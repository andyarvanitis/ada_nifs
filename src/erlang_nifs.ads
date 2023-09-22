with interfaces.C; use interfaces;
with interfaces.C.strings;
use type interfaces.C.int;
with ada.containers; use ada.containers;
with ada.containers.vectors;

package erlang_nifs is
   --  pragma SPARK_mode;
   pragma Assertion_Policy(Check);

   type enif_environment_t is null record;
   subtype erl_nif_env_t is enif_environment_t;
   type erl_nif_term_t is new interfaces.unsigned_64;

   type nif_supported_type_id is (e_integer, e_float, e_string);

   generic
      type t is private;
      type_id: nif_supported_type_id;
   package nif_supported_types is
      --
   end nif_supported_types;

   package integer_type is new nif_supported_types(integer, e_integer);
   package float_type is new nif_supported_types(float, e_float);
   --  package string_type is new nif_supported_types(string, e_string);

private

   generic
      with package value_type is new nif_supported_types (<>);
   package get_values is
      function get_value(env: access erl_nif_env_t; term: erl_nif_term_t) return value_type.t;
   end get_values;

   generic
      with package value_type is new nif_supported_types (<>);
   package make_values is
      function make_value(env: access erl_nif_env_t; value: in value_type.t) return erl_nif_term_t;
   end make_values;

   type erl_nif_terms_t is array (0 .. C.int'last) of aliased erl_nif_term_t;

   type nif_fn_t is access function(env : access erl_nif_env_t;
                                    argc : C.int;
                                    argv : erl_nif_terms_t) return erl_nif_term_t
      with convention => C;

   type enif_func_t is record
      name : interfaces.C.strings.chars_ptr;
      arity : aliased C.unsigned;
      fptr : nif_fn_t;
      flags : aliased C.unsigned;
   end record
      with Convention => C_pass_by_copy;

   package funcs_vectors is new Vectors(Index_Type   => Natural,
                                        Element_Type => enif_func_t);
   use funcs_vectors;
   nif_functions: funcs_vectors.vector;

end erlang_nifs;
