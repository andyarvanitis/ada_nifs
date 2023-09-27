
private package erlang_nifs.c_apis is

   --------------------------------------------------------------------------------------
   -- Erlang NIF C APIs
   --------------------------------------------------------------------------------------

   type erl_nif_binary_t is record
      size: aliased C.size_t;
      data: C.strings.chars_ptr;
   end record
      with convention => C;


   function enif_get_int(env: access erl_nif_env_t;
                        term: erl_nif_term_t;
                       value: in out C.int)
            return integer
      with convention => C,
               import => true,
        external_name => "enif_get_int";

   function enif_get_double(env: access erl_nif_env_t;
                            term: erl_nif_term_t;
                            value: in out C.double)
            return integer
      with convention => C,
               import => true,
        external_name => "enif_get_double";

   function enif_get_string_length(env: access erl_nif_env_t;
                                  term: erl_nif_term_t;
                                   len: in out C.unsigned;
                              encoding: C.unsigned)
            return integer
      with convention => C,
               import => true,
        external_name => "enif_get_string_length";

   function enif_get_string(env: access erl_nif_env_t;
                           term: erl_nif_term_t;
                            buf: in out C.char_array;
                           size: C.unsigned;
                       encoding: C.unsigned)
            return integer
      with convention => C,
               import => true,
        external_name => "enif_get_string";

   function enif_make_int(env: access erl_nif_env_t;
                            i: C.int)
            return erl_nif_term_t
      with convention => C,
               import => true,
        external_name => "enif_make_int";

   function enif_make_double(env: access erl_nif_env_t;
                               d: C.double)
            return erl_nif_term_t
      with convention => C,
               import => true,
        external_name => "enif_make_double";

   function enif_make_string(env: access erl_nif_env_t;
                             str: C.char_array;
                        encoding: C.unsigned)
            return erl_nif_term_t
      with convention => C,
               import => true,
        external_name => "enif_make_string";

   function enif_inspect_binary(env: access erl_nif_env_t;
                               term: erl_nif_term_t;
                              value: in out erl_nif_binary_t)
            return integer
      with convention => C,
               import => true,
        external_name => "enif_inspect_binary";

   function enif_make_new_binary(env: access erl_nif_env_t;
                                 size: C.size_t;
                                 term: out erl_nif_term_t)
            return C.strings.chars_ptr
      with convention => C,
               import => true,
        external_name => "enif_make_new_binary";

   function enif_raise_exception(env: access erl_nif_env_t;
                              reason: erl_nif_term_t)
            return erl_nif_term_t
      with convention => C,
               import => true,
        external_name => "enif_raise_exception";


   --------------------------------------------------------------------------------------
   -- Function exposed to C side to fill NIF list during initialization
   --------------------------------------------------------------------------------------

   type nif_funcs_array_t is array (0 .. integer'last) of aliased enif_func_t
      with convention => C;

   procedure populate_nif_array(arr: in out nif_funcs_array_t;
                              count: C.int)
      with convention => C,
               export => true,
        external_name => "populate_nif_array",
                  pre => C.int(nif_functions.length) = count;

end erlang_nifs.c_apis;
