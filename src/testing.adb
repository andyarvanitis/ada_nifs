--  with erlang_nifs; use erlang_nifs;
--  with erlang_nifs.arity_1;

package body testing is

   function just_foo(x: integer) return integer is (x + 100);

   --  package nif1 is new erlang_nifs.arity_1( erlang_name => "not_impl",
   --                                           arg_type => integer_type,
   --                                           ret_type => integer_type,
   --                                           ada_function => just_foo );

   --  package nif2 is new erlang_nifs.arity_1( erlang_name => "dofoo2",
   --                                           arg_type => integer_type,
   --                                           ret_type => integer_type,
   --                                           ada_function => just_foo );

   --  package nif3 is new erlang_nifs.arity_1( erlang_name => "dofoo3",
   --                                           arg_type => integer_type,
   --                                           ret_type => integer_type,
   --                                           ada_function => just_foo );

--  begin
--     nif_funcs(nif_funcs'first) := (C.strings.new_string("dofoo"), 1, nif1.nif_wrapper'access);

end testing;
