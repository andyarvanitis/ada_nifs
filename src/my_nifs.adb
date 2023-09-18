with erlang_nifs; use erlang_nifs;
with erlang_nifs.arity_1;

package body my_NIFs is

   function plus_one(x: integer) return integer is
   begin
      return x + 1;
   end plus_one;

   package incrementer is new erlang_nifs.arity_1
     (erlang_name  => "increment",
      arg_type     => integer_type,
      ret_type     => integer_type,
      ada_function => plus_one);

begin
   incrementer.do_nothing;

end my_NIFs;

