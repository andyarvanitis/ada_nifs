package testing is
   pragma elaborate_body;
   --  pragma SPARK_mode;

   --  function just_foo(x: integer) return integer is (x + 100);

   --  package nif1 is new erlang_nifs.arity_1( erlang_name => "dofoo",
   --                                           arg_type => integer_type,
   --                                           ret_type => integer_type,
   --                                           ada_function => just_foo );

end testing;
