
package sample_functions is
   pragma SPARK_mode;

   function plus_one(x: integer) return integer is (x + 1)
      with pre => x < integer'last;

   function uppercase(s: string) return string is (raise Constraint_Error with "'" & s & "' is too big");

end sample_functions;