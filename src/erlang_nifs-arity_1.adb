
package body erlang_nifs.arity_1 is

   package args is new get_values(argument_type); use args;
   package rets is new make_values(return_type); use rets;

   function nif_wrapper(env: not null access erl_nif_env_t;
                       argc: C.int with unreferenced;
                       argv: erl_nif_terms_t)
            return erl_nif_term_t is
   begin
      return make_value(env, ada_function(get_value(env, argv(0))));

   exception
      when error: others =>
         return raise_erlang_exception(env, error);

   end nif_wrapper;

begin
   nif_functions.append(nif_info);

end erlang_nifs.arity_1;
