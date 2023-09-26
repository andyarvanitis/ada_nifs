package body erlang_nifs.c_apis is

   procedure populate_nif_array(arr: in out nif_funcs_array_t;
                              count: C.int with unreferenced) is
      i : integer := 0;
   begin
      for nif of nif_functions loop
         arr(i):= nif;
         i := i + 1;
      end loop;
   end populate_nif_array;

end erlang_nifs.c_apis;
