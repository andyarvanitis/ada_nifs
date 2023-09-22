
generic
   erlang_name: string;
   with package argument_type is new nif_supported_types (<>);
   with package return_type is new nif_supported_types (<>);
   with function ada_function(x: in argument_type.t) return return_type.t;
package erlang_nifs.arity_1 is
   pragma SPARK_mode;
   pragma elaborate_body;
   pragma Assertion_Policy(Check);

private
   function nif_wrapper(env: access erl_nif_env_t;
                        argc: C.int;
                        argv: erl_nif_terms_t) return erl_nif_term_t
      with
         convention => C,
         pre => argc = 1;

   nif_info : enif_func_t := (name => C.strings.new_string(erlang_name),
                              arity => 1,
                              fptr => nif_wrapper'access,
                              flags => 0);

end erlang_nifs.arity_1;
