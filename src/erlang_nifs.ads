with interfaces.C; use interfaces;
with interfaces.C.strings;
use type interfaces.C.int;
with ada.containers; use ada.containers;
with ada.containers.vectors;
with ada.exceptions; use ada.exceptions;
with supported_erlang_types; use supported_erlang_types;

package erlang_nifs is
   --  pragma SPARK_mode;
   pragma assertion_policy( check );

   type enif_environment_t is null record;
   subtype erl_nif_env_t is enif_environment_t;
   type erl_nif_term_t is new interfaces.unsigned_64;

   package types renames supported_erlang_types;

   -- Package instances used directly by users creating NIF bindings
   --
   package integer_type renames types.integer_type;
   package long_float_type renames types.long_float_type;
   package string_type renames types.string_type;

private

   generic
      with package value_type is new nif_supported_types (<>);
   package get_values is
      function get_value(env: not null access erl_nif_env_t;
                         term: erl_nif_term_t) return value_type.t;
   end get_values;

   generic
      with package value_type is new nif_supported_types (<>);
   package make_values is
      function make_value(env: not null access erl_nif_env_t;
                          value: in value_type.t) return erl_nif_term_t;
   end make_values;

   type erl_nif_terms_t is array (0 .. C.int'last) of aliased erl_nif_term_t;

   type nif_fn_t is access function(env : not null access erl_nif_env_t;
                                    argc : C.int;
                                    argv : erl_nif_terms_t) return erl_nif_term_t
      with convention => C;

   type enif_func_t is record
      name : C.strings.chars_ptr;
      arity : aliased C.unsigned;
      fptr : nif_fn_t;
      flags : aliased C.unsigned;
   end record
      with Convention => C_pass_by_copy;

   package funcs_vectors is new vectors(index_type => positive, element_type => enif_func_t);
   nif_functions: funcs_vectors.vector;

   function raise_erlang_exception(env: not null access erl_nif_env_t;
                                   message: in string) return erl_nif_term_t;

   function raise_erlang_exception(env: not null access erl_nif_env_t;
                                   error: in exception_occurrence) return erl_nif_term_t;

end erlang_nifs;
