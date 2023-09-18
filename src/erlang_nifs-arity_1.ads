
generic
   erlang_name: string;
   with package arg_type is new nif_supported_types (<>);
   with package ret_type is new nif_supported_types (<>);
   with function ada_function(x: in arg_type.t) return ret_type.t;
package erlang_nifs.arity_1 is
   pragma elaborate_body;
   pragma Assertion_Policy(Check);

procedure do_nothing is null;

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
