with interfaces;
with erlang_nifs.c_apis; use erlang_nifs.c_apis;

package body erlang_nifs is

   use type C.unsigned;
   use type C.size_t;

   ERL_NIF_LATIN1 : constant := 1;
-- ERL_NIF_UTF8   : constant := 2;

   nif_api_call_failure: exception;

   package body get_values is

      function get_int(env: not null access erl_nif_env_t;
                      term: erl_nif_term_t)
               return integer is
         i: C.int := 0;
      begin
         if enif_get_int(env, term, i) = 1 then
            return integer(i);
         else
            raise nif_api_call_failure with "enif_get_int";
         end if;
      end get_int;


      function get_double(env: not null access erl_nif_env_t;
                         term: erl_nif_term_t)
               return long_float is
         d: C.double := 0.0;
      begin
         if enif_get_double(env, term, d) = 1 then
            return long_float(d);
         else
            raise nif_api_call_failure with "enif_get_double";
         end if;
      end get_double;


      function get_string_length(env: not null access erl_nif_env_t;
                                term: erl_nif_term_t)
               return C.unsigned
         with post => get_string_length'result < C.unsigned'last and
                         C.size_t(get_string_length'result) < C.size_t'last is
         len: C.unsigned := 0;
      begin
         if enif_get_string_length(env, term, len, ERL_NIF_LATIN1) = 0 then
            raise nif_api_call_failure with "enif_get_string_length";
         end if;
         return len;
      end get_string_length;


      function get_string(env: not null access erl_nif_env_t;
                         term: erl_nif_term_t)
               return string is
         -- Increment length to account for terminating null
         len : constant C.unsigned := get_string_length(env, term) + 1;
         buf: C.char_array(1 .. C.size_t(len));
         ret_code: integer;
      begin
         ret_code := enif_get_string(env, term, buf, len, ERL_NIF_LATIN1);
         if ret_code > 0 then
            return C.to_ada(buf);
         elsif ret_code = 0 then
            raise nif_api_call_failure with "enif_get_string (cannot be encoded)";
         else
            raise nif_api_call_failure with "enif_get_string (buffer too small)";
         end if;
      end get_string;

      function get_utf_8_string(env: not null access erl_nif_env_t;
                               term: erl_nif_term_t)
               return string is
         bin: erl_nif_binary_t;
      begin
         if enif_inspect_binary(env, term, bin) = 1 then
            return C.strings.value(bin.data, bin.size);
         else
            raise nif_api_call_failure with "enif_inspect_binary returned 'false'";
         end if;
      end get_utf_8_string;

      function get_value(env: not null access erl_nif_env_t;
                        term: erl_nif_term_t)
               return value_type.t is
      begin
         case value_type.type_id is
            when e_integer =>
               return value_type.to_t(get_int(env, term));
            when e_long_float =>
               return value_type.to_t(get_double(env, term));
            when e_string =>
               return value_type.to_t(get_string(env, term));
            when e_utf_8_string =>
               return value_type.to_t(get_utf_8_string(env, term));
         end case;
      end get_value;
   end get_values;


   package body make_values is

      function make_value(env: not null access erl_nif_env_t;
                        value: in value_type.t)
               return erl_nif_term_t is
      begin
         case value_type.type_id is
            when e_integer =>
               declare
                  i: constant integer := value_type.from_t(value);
               begin
                  return enif_make_int(env, C.int(i));
               end;
            when e_long_float =>
               declare
                  lf: constant long_float := value_type.from_t(value);
               begin
                  return enif_make_double(env, C.double(lf));
               end;
            when e_string =>
               declare
                  s: constant string := value_type.from_t(value);
               begin
                  return enif_make_string(env, C.to_C(s), ERL_NIF_LATIN1);
               end;
            when e_utf_8_string =>
               declare
                  s: constant string := value_type.from_t(value);
                  term: erl_nif_term_t;
                  data: C.strings.chars_ptr;
               begin
                  data := enif_make_new_binary(env, s'length, term);
                  C.strings.update(item => data,
                                 offset => 0,
                                    str => s,
                                  check => false);
                  return term;
               end;
            end case;
      end make_value;

   end make_values;

   function raise_erlang_exception(env: not null access erl_nif_env_t;
                               message: in string)
            return erl_nif_term_t is
      reason: constant erl_nif_term_t :=
                  enif_make_string(env, C.to_C(message), ERL_NIF_LATIN1);
   begin
      return enif_raise_exception(env, reason);
   end raise_erlang_exception;

   function raise_erlang_exception(env: not null access erl_nif_env_t;
                                 error: in exception_occurrence)
            return erl_nif_term_t is
      message: constant string := "Ada exception: " &
                                   exception_name(error) &
                                  " - " &
                                   exception_message(error);
   begin
      return raise_erlang_exception(env, message);
   end raise_erlang_exception;

end erlang_nifs;
