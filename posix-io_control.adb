with C_String;
with Interfaces.C;
with System;

package body POSIX.IO_Control is

  --
  -- Return value type.
  --

  subtype Ioctl_Return_Value_t is C_Types.Int_t range -1 .. C_Types.Int_t'Last;

  --
  -- Return true if request type is supported.
  --

  function Check_Request_Support (Request : in Request_t) return Boolean is
  begin
    return Request /= Unsupported;
  end Check_Request_Support;

  --
  -- Push module.
  --

  function Push_Module_Boundary
    (Descriptor : in File.Valid_Descriptor_t;
     Name       : in String) return Ioctl_Return_Value_t
  is
    --# hide Push_Module_Boundary
    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Name       : in C_String.String_Not_Null_Ptr_t)
      return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");

    Name_Buffer : aliased Interfaces.C.char_array := Interfaces.C.To_C (Name);
  begin
    return Ioctl
      (Descriptor => Descriptor,
       Request    => I_PUSH,
       Name       => C_String.To_C_String (Name_Buffer'Unchecked_Access));
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      return -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      return -1;
  end Push_Module_Boundary;

  procedure Push_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name        : in     String;
     Error_Value :    out Error.Error_t)
  is
    Return_Value : Request_t;
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_PUSH) then
    --# end accept;
      Return_Value := Push_Module_Boundary
        (Descriptor => Descriptor,
         Name       => Name);
      if Return_Value = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    else
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Push_Module;

  --
  -- Pop module.
  --

  procedure Pop_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Error_Value :    out Error.Error_t)
  is
    Return_Value : Ioctl_Return_Value_t;

    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in C_Types.Int_t) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_POP) then
    --# end accept;
      Return_Value := Ioctl
        (Descriptor => Descriptor,
         Request    => I_POP,
         Arg        => 0);
      if Return_Value = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    else
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Pop_Module;

  --
  -- Look module.
  --

  procedure Look_Module_Boundary
    (Descriptor   : in     File.Valid_Descriptor_t;
     Name_Buffer  :    out Name_Buffer_t;
     Return_Value :    out Ioctl_Return_Value_t)
    --# derives Name_Buffer, Return_Value from Descriptor;
  is
    --# hide Look_Module_Boundary

    C_Buffer : aliased Interfaces.C.char_array :=
      (Interfaces.C.size_t (Name_Buffer'First) ..
       Interfaces.C.size_t (Name_Buffer'Last) => Interfaces.C.nul);

    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in System.Address) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    if Ioctl
      (Descriptor => Descriptor,
       Request    => I_LOOK,
       Arg        => C_Buffer (C_Buffer'First)'Address) /= -1 then
      for Index in C_Buffer'Range loop
        Name_Buffer (Positive (Index)) := Interfaces.C.To_Ada (C_Buffer (Index));
      end loop;
      Return_Value := 0;
    else
      Return_Value := -1;
    end if;
  end Look_Module_Boundary;

  procedure Look_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name_Buffer :    out Name_Buffer_t;
     Name_Last   :    out Name_Buffer_Index_t;
     Error_Value :    out Error.Error_t)
  is
    Return_Value : Ioctl_Return_Value_t;
    Done         : Boolean;
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_LOOK) then
    --# end accept;
      Look_Module_Boundary
        (Descriptor   => Descriptor,
         Name_Buffer  => Name_Buffer,
         Return_Value => Return_Value);
      if Return_Value = 0 then
        Error_Value := Error.Error_None;
        Name_Last   := Name_Buffer_Index_t'First;
        Done        := False;
        for Index in Name_Buffer_Index_t range Name_Buffer'First .. Name_Buffer'Last loop
          --# assert Index <= Name_Buffer'Last
          --#    and Index >= Name_Buffer'First;
          if Name_Buffer (Index) = Character'Val (0) then
            Name_Last := Index;
            Done      := True;
          end if;
          exit when Done;
        end loop;
      else
        Name_Last   := Name_Buffer_Index_t'First;
        Error_Value := Error.Get_Error;
      end if;
    else
      Name_Buffer := Name_Buffer_t'(others => Character'Val (0));
      Name_Last   := Name_Buffer_Index_t'First;
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Look_Module;

  --
  -- Flush.
  --

  procedure Flush
    (Descriptor  : in     File.Valid_Descriptor_t;
     Queues      : in     Queue_Type_t;
     Error_Value :    out Error.Error_t)
  is
    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in Queue_Value_t) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_FLUSH) then
    --# end accept;
      if Ioctl
        (Descriptor => Descriptor,
         Request    => I_FLUSH,
         Arg        => Queue_Map (Queues)) = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    else
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Flush;

  --
  -- Flush_Band.
  --

  function Flush_Band_Boundary
    (Descriptor  : in File.Valid_Descriptor_t;
     Priority    : in Priority_Band_t;
     Queues      : in Queue_Type_t) return Ioctl_Return_Value_t
  is
    --# hide Flush_Band_Boundary
    Band_Info : aliased Band_Info_t :=
      (Priority => Priority,
       Queue    => Queue_Map (Queues));

    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in System.Address) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    return Ioctl
      (Descriptor => Descriptor,
       Request    => I_FLUSHBAND,
       Arg        => Band_Info'Address);
  end Flush_Band_Boundary;

  procedure Flush_Band
    (Descriptor  : in     File.Valid_Descriptor_t;
     Priority    : in     Priority_Band_t;
     Queues      : in     Queue_Type_t;
     Error_Value :    out Error.Error_t) is
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_FLUSHBAND) then
    --# end accept;
      if Flush_Band_Boundary
        (Descriptor => Descriptor,
         Priority   => Priority,
         Queues     => Queues) = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    else
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Flush_Band;

  --
  -- Set_Signal_Events.
  --

  --
  -- Return True if all of the selected options are valid on the current platform.
  --

  function Check_Signal_Events (Events : in Events_t) return Boolean is
    Supported : Boolean := True;
  begin
    for Event in Event_Selector_t range Event_Selector_t'First .. Event_Selector_t'Last loop
      if Events (Event) then
        if Event_Map (Event) = Unsupported_Event then
          Supported := False;
        end if;
      end if;
      --# assert Event <= Event_Selector_t'Last
      --#    and Event >= Event_Selector_t'First;
    end loop;
    return Supported;
  end Check_Signal_Events;

  --
  -- Convert Events array to event mask.
  --

  function Signal_Event_Mask (Events : in Events_t) return Event_Value_t is
    Mask       : Event_Value_t := 0;
    Event_Mask : Event_Value_t;
  begin
    --# assert (Mask or Event_Value_t'Last) = Event_Value_t'Last;
    for Event in Event_Selector_t range Event_Selector_t'First .. Event_Selector_t'Last loop
      if Events (Event) then
        Event_Mask := Event_Map (Event);
        Mask       := Mask or Event_Mask;
      end if;
      --# assert Event <= Event_Selector_t'Last
      --#    and Event >= Event_Selector_t'First;
    end loop;
    return Mask;
  end Signal_Event_Mask;

  procedure Set_Signal_Events
    (Descriptor  : in     File.Valid_Descriptor_t;
     Events      : in     Events_t;
     Error_Value :    out Error.Error_t)
  is
    Supported : Boolean;

    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in Event_Value_t) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    Supported := Check_Request_Support (I_SETSIG) and
                 Check_Signal_Events (Events);
    if Supported then
      if Ioctl
        (Descriptor => Descriptor,
         Request    => I_SETSIG,
         Arg        => Signal_Event_Mask (Events)) = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    else
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Set_Signal_Events;

  --
  -- Get_Signal_Events
  --

  --
  -- Convert Events array to event mask.
  --

  function Signal_Mask_To_Events (Mask : in Event_Value_t) return Events_t is
    Return_Events : Events_t := Events_t'(others => False);
  begin
    for Event in Event_Selector_t range Event_Selector_t'First .. Event_Selector_t'Last loop
      if (Mask and Event_Map (Event)) = Event_Map (Event) then
        Return_Events (Event) := True;
      end if;
      --# assert Event <= Event_Selector_t'Last
      --#    and Event >= Event_Selector_t'First;
    end loop;
    return Return_Events;
  end Signal_Mask_To_Events;

  procedure Get_Signal_Events_Boundary
    (Descriptor  : in     File.Valid_Descriptor_t;
     Events      :    out Events_t;
     Failed      :    out Boolean)
    --# derives Events, Failed from Descriptor;
  is
    --# hide Get_Signal_Events_Boundary
    Event_Value : aliased Event_Value_t;

    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Arg        : in System.Address) return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");
  begin
    if Ioctl
      (Descriptor => Descriptor,
       Request    => I_GETSIG,
       Arg        => Event_Value'Address) = -1 then
      Failed := True;
    else
      Failed := False;
      Events := Signal_Mask_To_Events (Event_Value);
    end if;
  end Get_Signal_Events_Boundary;

  procedure Get_Signal_Events
    (Descriptor  : in     File.Valid_Descriptor_t;
     Events      :    out Events_t;
     Error_Value :    out Error.Error_t)
  is
    Failed : Boolean;
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_GETSIG) then
    --# end accept;
      Get_Signal_Events_Boundary
        (Descriptor => Descriptor,
         Events     => Events,
         Failed     => Failed);
      if Failed then
        Error_Value := Error.Error_None;
      else
        Error_Value := Error.Get_Error;
      end if;
    else
      Events      := Events_t'(others => False);
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Get_Signal_Events;

  --
  -- Find_Module.
  --

  function Find_Module_Boundary
    (Descriptor : in File.Valid_Descriptor_t;
     Name       : in String) return Ioctl_Return_Value_t
  is
    --# hide Find_Module_Boundary
    function Ioctl
      (Descriptor : in File.Valid_Descriptor_t;
       Request    : in Request_t;
       Name       : in C_String.String_Not_Null_Ptr_t)
      return Ioctl_Return_Value_t;
    pragma Import (C, Ioctl, "ioctl");

    Name_Buffer : aliased Interfaces.C.char_array := Interfaces.C.To_C (Name);
  begin
    return Ioctl
      (Descriptor => Descriptor,
       Request    => I_FIND,
       Name       => C_String.To_C_String (Name_Buffer'Unchecked_Access));
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      return -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      return -1;
  end Find_Module_Boundary;

  procedure Find_Module
    (Descriptor  : in     File.Valid_Descriptor_t;
     Name        : in     String;
     Found       :    out Boolean;
     Error_Value :    out Error.Error_t) is
  begin
    --# accept Flow, 22, "Value is implementation-defined.";
    if Check_Request_Support (I_FIND) then
    --# end accept;
      case Find_Module_Boundary
        (Descriptor => Descriptor,
         Name       => Name) is
        when  0 =>
          Error_Value := Error.Error_None;
          Found := False;
        when  1 =>
          Error_Value := Error.Error_None;
          Found := True;
        when others =>
          Error_Value := Error.Get_Error;
          Found       := False;
      end case;
    else
      Found       := False;
      Error_Value := Error.Error_Not_Supported;
    end if;
  end Find_Module;

end POSIX.IO_Control;
