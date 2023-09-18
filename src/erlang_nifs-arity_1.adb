
--  with text_io;

package body erlang_nifs.arity_1 is

   function nif_wrapper(env: access erl_nif_env_t;
                        argc: C.int with unreferenced;
                        argv: erl_nif_terms_t) return erl_nif_term_t is
      package gets is new get_values(arg_type); use gets;
      package makes is new make_values(ret_type); use makes;
      input: arg_type.t;
      output: ret_type.t;
   begin
      input := enif_get_value(env, argv(0)); -- ada version (which this is) can throw exceptions
      output := ada_function(input);
      -- Standardize on some exception handling here (assume provided nif can throw)
      return enif_make_value(env, output);
   end nif_wrapper;

begin
   nif_functions.append(nif_info);

end erlang_nifs.arity_1;
