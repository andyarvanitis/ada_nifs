with unchecked_conversion;
with interfaces;

--  with text_io; use text_io;

package body erlang_nifs is

   -----------------  C functions to access Erlang runtime  ------------------------

   function enif_get_int(env: access erl_nif_env_t;
                         term: erl_nif_term_t;
                         value: in out C.int) return integer
      with convention => C,
            import => true,
                  external_name => "enif_get_int";


   function enif_get_double(env: access erl_nif_env_t;
                            term: erl_nif_term_t;
                            value: in out C.double) return integer
   with convention => C,
            import => true,
                  external_name => "enif_get_double";


   function enif_get_string_length(env: access erl_nif_env_t;
                                   term: erl_nif_term_t;
                                   len: in out C.unsigned;
                                   encoding: C.unsigned) return integer
   with convention => C,
            import => true,
                  external_name => "enif_get_string_length";


   function enif_get_string(env: access erl_nif_env_t;
                            term: erl_nif_term_t;
                            buf: in out C.char_array;
                            size: C.unsigned;
                            encoding: C.unsigned) return integer
   with convention => C,
            import => true,
                  external_name => "enif_get_string";


   function enif_make_int(env: access erl_nif_env_t; i: C.int) return erl_nif_term_t
      with convention => C,
            import => true,
            external_name => "enif_make_int";


   --------------------------------------------------------------------------------- 

   package body get_values is
      --  pragma SPARK_Mode;

      function convert is new unchecked_conversion(source => integer, target => value_type.t);
      function convert is new unchecked_conversion(source => float, target => value_type.t);
      function convert is new unchecked_conversion(source => string, target => value_type.t);


      function get_int(env: access erl_nif_env_t; term: erl_nif_term_t) return integer is
         c_int_val: C.int := 0;
      begin
         if enif_get_int(env, term, c_int_val) = 1 then
            return integer(c_int_val);
         else
            raise constraint_error;
         end if;
      end get_int;


      function get_float(env: access erl_nif_env_t; term: erl_nif_term_t) return float is
         c_double_val: C.double := 0.0;
      begin
         if enif_get_double(env, term, c_double_val) = 1 then
            return float(c_double_val);
         else
            raise constraint_error;
         end if;
      end get_float;


      function get_string(env: access erl_nif_env_t; term: erl_nif_term_t) return string is
         c_len: C.unsigned := 0;
         ERL_NIF_UTF8: constant C.unsigned := 1; -- TODO: enum ERL_NIF_UTF8
      begin
         if enif_get_string_length(env, term, c_len, ERL_NIF_UTF8) = 0 then
            raise constraint_error;
         end if;

         declare
            buf: C.char_array(1 .. C.size_t(c_len));
         begin
            if enif_get_string(env, term, buf, c_len, ERL_NIF_UTF8) > 0 then
               return C.to_ada(buf);
            else
               raise constraint_error;
            end if;
         end;
      end get_string;


      function enif_get_value(env: access erl_nif_env_t; term: erl_nif_term_t) return value_type.t is
      begin
         case value_type.type_id is
            when e_integer =>
               return convert(get_int(env, term));
            when e_float =>
               return convert(get_float(env, term));
            when e_string =>
               return convert(get_string(env, term));
         end case;
      end enif_get_value;
   end get_values;


   package body make_values is

      function convert is new unchecked_conversion(source =>  value_type.t, target => integer);

      function enif_make_value(env: access erl_nif_env_t; value: in value_type.t) return erl_nif_term_t is
      begin
         case value_type.type_id is
            when e_integer =>
               return enif_make_int(env, C.int(convert(value)));
            --  when e_float =>
            --  when e_string =>
            when others => 
               return erl_nif_term_t'(0);
         end case;         
         return erl_nif_term_t'(0);
      end enif_make_value;

   end make_values;


   --  function nif_stub(env: access erl_nif_env_t;
   --                    argc: C.int;
   --                    argv: access erl_nif_term_t) return erl_nif_term_t is (erl_nif_term_t'first)
   --     with convention => C;


   type nif_funcs_array_t is array (0 .. integer'last) of aliased enif_func_t
      with convention => C;

   procedure populate_functions(arr: in out nif_funcs_array_t; count: C.int)
      with export => true,
           convention => C,
           external_name => "populate_functions",
           pre => C.int(nif_functions.length) = count;

   procedure populate_functions(arr: in out nif_funcs_array_t; count: C.int with unreferenced) is
      i : integer := 0;
   begin
      for nif of nif_functions loop
         arr(i):= nif;
         i := i + 1;
      end loop;
   end populate_functions;

end erlang_nifs;
