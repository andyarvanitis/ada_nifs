
package supported_erlang_types is
   pragma assertion_policy(check);

   type nif_supported_type_id is (e_integer, e_long_float, e_string);

   type_definition_error: exception;

   generic
      type t (<>) is private;
      type_id: nif_supported_type_id;
      with function to_t(x: in integer) return t is <>;
      with function to_t(x: in long_float) return t is <>;
      with function to_t(x: in string) return t is <>;
      with function from_t(x: in t) return integer is <>;
      with function from_t(x: in t) return long_float is <>;
      with function from_t(x: in t) return string is <>;
   package nif_supported_types is
      --
   end nif_supported_types;

   generic
      type t (<>) is private;
      type t1 (<>) is private;
      type t2 (<>) is private;
   package conversions is
      function to_t(x: in t) return t is (x);
      function to_t(unused: in t)
         return t1 is (raise type_definition_error);
      function to_t(unused: in t)
         return t2 is (raise type_definition_error);
      function from_t(x: in t) return t is (x);
      function from_t(unused: in t)
         return t1 is (raise type_definition_error);
      function from_t(unused: in t)
         return t2 is (raise type_definition_error);
   end conversions;

   package integer_conversions is new conversions(integer, long_float, string);
   use integer_conversions;

   package float_conversions is new conversions(long_float, integer, string);
   use float_conversions;

   package string_conversions is new conversions(string, integer, long_float);
   use string_conversions;

   --------------------------------------------------------------------------------------
   -- Package instances used directly by users creating NIF bindings
   --------------------------------------------------------------------------------------

   package integer_type is new nif_supported_types(integer, e_integer);
   package long_float_type is new nif_supported_types(long_float, e_long_float);
   package string_type is new nif_supported_types(string, e_string);

end supported_erlang_types;

