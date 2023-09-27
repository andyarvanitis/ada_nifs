with erlang_nifs; use erlang_nifs;
with erlang_nifs.arity_1;
with examples_functions; use examples_functions;

package body examples is

   package incrementer is new erlang_nifs.arity_1
      (erlang_name => "increment",
     argument_type => integer_type,
       return_type => integer_type,
      ada_function => plus_one);

   package negater is new erlang_nifs.arity_1
      (erlang_name => "negate",
     argument_type => long_float_type,
       return_type => long_float_type,
      ada_function => "-");

   package uppercaser is new erlang_nifs.arity_1
      (erlang_name => "uppercase",
     argument_type => string_type,
       return_type => string_type,
      ada_function => uppercase);

   package uppercaser_u8 is new erlang_nifs.arity_1
      (erlang_name => "uppercase_binary",
     argument_type => utf_8_string_type,
       return_type => utf_8_string_type,
      ada_function => uppercase);

 pragma unreferenced (incrementer, negater, uppercaser, uppercaser_u8);

end examples;
