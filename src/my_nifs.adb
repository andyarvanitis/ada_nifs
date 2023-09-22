with erlang_nifs; use erlang_nifs;
with erlang_nifs.arity_1;
with sample_functions; use sample_functions;

package body my_nifs is

   package incrementer is new erlang_nifs.arity_1
     (erlang_name => "increment",
      arg_type => integer_type,
      ret_type => integer_type,
      ada_function => plus_one);

begin
   incrementer.do_nothing;

end my_nifs;
