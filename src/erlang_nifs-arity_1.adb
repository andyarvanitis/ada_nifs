
package body erlang_nifs.arity_1 is

   package args is new get_values(arg_type); use args;
   package rets is new make_values(ret_type); use rets;

   function nif_wrapper(env: access erl_nif_env_t;
                        argc: C.int with unreferenced;
                        argv: erl_nif_terms_t) return erl_nif_term_t is
      arg: arg_type.t;
      result: ret_type.t;
   begin
      -- TODO: Standardize on some exception handling here (raise erlang exceptions)
      arg := get_value(env, argv(0));
      result := ada_function(arg);
      return make_value(env, result);
   end nif_wrapper;

begin
   nif_functions.append(nif_info);

end erlang_nifs.arity_1;
