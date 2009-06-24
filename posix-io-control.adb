with C_String;
with Interfaces.C;

package body POSIX.IO.Control is

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
    if Check_Request_Support (I_PUSH) then
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

end POSIX.IO.Control;
