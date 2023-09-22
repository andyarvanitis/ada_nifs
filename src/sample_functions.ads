
package sample_functions is
   pragma SPARK_mode;

   function plus_one(x: integer) return integer is (x + 1)
      with pre => x < integer'last;

end sample_functions;