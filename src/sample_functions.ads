with ada.characters.handling;

package sample_functions is
   pragma SPARK_mode;
   pragma pure;
   pragma assertion_policy( ignore );

   function plus_one(x: integer) return integer is (x + 1)
      with pre => x < integer'last;

   function uppercase(s: string) return string is (ada.characters.handling.to_upper(s));

end sample_functions;