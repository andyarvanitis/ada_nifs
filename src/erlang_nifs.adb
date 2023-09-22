with interfaces;
with erlang_nifs.c_apis; use erlang_nifs.c_apis;

package body erlang_nifs is

   package body get_values is
      --  pragma SPARK_Mode;

      function get_int(env: access erl_nif_env_t; term: erl_nif_term_t) return integer is
         i: C.int := 0;
      begin
         if enif_get_int(env, term, i) = 1 then
            return integer(i);
         else
            raise constraint_error;
         end if;
      end get_int;


      function get_double(env: access erl_nif_env_t; term: erl_nif_term_t) return long_float is
         d: C.double := 0.0;
      begin
         if enif_get_double(env, term, d) = 1 then
            return long_float(d);
         else
            raise constraint_error;
         end if;
      end get_double;


      function get_string(env: access erl_nif_env_t; term: erl_nif_term_t) return string is
         len: C.unsigned := 0;
         ERL_NIF_UTF8: constant C.unsigned := 1; -- TODO: enum ERL_NIF_UTF8
      begin
         if enif_get_string_length(env, term, len, ERL_NIF_UTF8) = 0 then
            raise constraint_error;
         end if;

         declare
            buf: C.char_array(1 .. C.size_t(len));
         begin
            if enif_get_string(env, term, buf, len, ERL_NIF_UTF8) > 0 then
               return C.to_ada(buf);
            else
               raise constraint_error;
            end if;
         end;
      end get_string;


      function get_value(env: access erl_nif_env_t; term: erl_nif_term_t) return value_type.t is
      begin
         case value_type.type_id is
            when e_integer =>
               return value_type.to_t(get_int(env, term));
            when e_long_float =>
               return value_type.to_t(get_double(env, term));
            when e_string =>
               return value_type.to_t(get_string(env, term));
         end case;
      end get_value;
   end get_values;


   package body make_values is

      function make_value(env: access erl_nif_env_t; value: in value_type.t) return erl_nif_term_t is
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
                  ERL_NIF_UTF8: constant C.unsigned := 1; -- TODO: enum ERL_NIF_UTF8
               begin
                  return enif_make_string(env, C.to_C(s), ERL_NIF_UTF8);
               end;
            --  when others =>
            --     raise constraint_error;
            end case;
      end make_value;

   end make_values;

end erlang_nifs;
