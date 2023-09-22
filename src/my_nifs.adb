with erlang_nifs; use erlang_nifs;
with erlang_nifs.arity_1;
with sample_functions; use sample_functions;

package body my_nifs is

   package incrementer is new erlang_nifs.arity_1
     (erlang_name => "increment",
      arg_type => integer_type,
      ret_type => integer_type,
      ada_function => plus_one);

   package negater is new erlang_nifs.arity_1
     (erlang_name => "negate",
      arg_type => long_float_type,
      ret_type => long_float_type,
      ada_function => "-");

   --  package uppercaser is new erlang_nifs.arity_1
   --    (erlang_name => "uppercase",
   --     arg_type => string_type,
   --     ret_type => string_type,
   --     ada_function => uppercase);

begin
   incrementer.do_nothing;
   negater.do_nothing;
   --  uppercaser.do_nothing;

end my_nifs;
