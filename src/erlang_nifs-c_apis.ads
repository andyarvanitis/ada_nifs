
private package erlang_nifs.c_apis is

   --------------------------------------------------------------------------------------
   -- Erlang NIF C APIs
   --------------------------------------------------------------------------------------

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

   function enif_make_double(env: access erl_nif_env_t; d: C.double) return erl_nif_term_t
      with convention => C,
            import => true,
            external_name => "enif_make_double";

   function enif_make_string(env: access erl_nif_env_t;
                             str: C.char_array;
                             encoding: C.unsigned) return erl_nif_term_t
      with convention => C,
            import => true,
            external_name => "enif_make_string";



   -- ERL_NIF_TERM enif_raise_exception(ErlNifEnv* env, ERL_NIF_TERM reason)
   function enif_raise_exception(env: access erl_nif_env_t;
                                 reason: erl_nif_term_t) return erl_nif_term_t
      with convention => C,
            import => true,
            external_name => "enif_raise_exception";


   --------------------------------------------------------------------------------------
   -- Function exposed to C side to fill NIF list during initialization
   --------------------------------------------------------------------------------------

   type nif_funcs_array_t is array (0 .. integer'last) of aliased enif_func_t
      with convention => C;

   procedure populate_nif_array(arr: in out nif_funcs_array_t; count: C.int)
      with export => true,
           convention => C,
           external_name => "populate_nif_array",
           pre => C.int(nif_functions.length) = count;

end erlang_nifs.c_apis;
