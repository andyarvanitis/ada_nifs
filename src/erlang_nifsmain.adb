pragma Warnings (Off);
pragma Ada_95;
--  pragma Source_File_Name (Erlang_Nifsmain, Spec_File_Name => "b~erlang_nifs.ads");
--  pragma Source_File_Name (Erlang_Nifsmain, Body_File_Name => "b~erlang_nifs.adb");
pragma Suppress (Overflow_Check);

package body Erlang_Nifsmain is

   E10 : Short_Integer; pragma Import (Ada, E10, "ada__exceptions_E");
   E15 : Short_Integer; pragma Import (Ada, E15, "system__soft_links_E");
   E27 : Short_Integer; pragma Import (Ada, E27, "system__exception_table_E");
   E28 : Short_Integer; pragma Import (Ada, E28, "system__exceptions_E");
   E23 : Short_Integer; pragma Import (Ada, E23, "system__soft_links__initialize_E");
   E53 : Short_Integer; pragma Import (Ada, E53, "ada__assertions_E");
   E55 : Short_Integer; pragma Import (Ada, E55, "interfaces__c_E");
   E57 : Short_Integer; pragma Import (Ada, E57, "interfaces__c__strings_E");
   E02 : Short_Integer; pragma Import (Ada, E02, "erlang_nifs_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure Erlang_Nifsfinal is

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      null;
   end Erlang_Nifsfinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure Erlang_Nifsinit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      Erlang_Nifsmain'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      if E10 = 0 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if E15 = 0 then
         System.Soft_Links'Elab_Spec;
      end if;
      if E27 = 0 then
         System.Exception_Table'Elab_Body;
      end if;
      E27 := E27 + 1;
      if E28 = 0 then
         System.Exceptions'Elab_Spec;
      end if;
      E28 := E28 + 1;
      if E23 = 0 then
         System.Soft_Links.Initialize'Elab_Body;
      end if;
      E23 := E23 + 1;
      E15 := E15 + 1;
      E10 := E10 + 1;
      if E53 = 0 then
         Ada.Assertions'Elab_Spec;
      end if;
      E53 := E53 + 1;
      if E55 = 0 then
         Interfaces.C'Elab_Spec;
      end if;
      E55 := E55 + 1;
      if E57 = 0 then
         Interfaces.C.Strings'Elab_Spec;
      end if;
      E57 := E57 + 1;
      if E02 = 0 then
         erlang_nifs'elab_body;
      end if;
      E02 := E02 + 1;
   end Erlang_Nifsinit;

--  BEGIN Object file/option list
   --   -Llib/
   --   -L/Users/andy/.config/alire/cache/dependencies/gnat_native_12.2.1_77267eb1/lib/gcc/x86_64-apple-darwin19.6.0/12.2.0/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end Erlang_Nifsmain;
