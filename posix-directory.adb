with C_String;
with Interfaces.C;

package body POSIX.Directory is

  --
  -- Change_By_Descriptor.
  --

  procedure Change_By_Descriptor
    (Descriptor  : in     File.Valid_Descriptor_t;
     Error_Value :    out Error.Error_t)
  is
    function Fchdir (Descriptor : in File.Valid_Descriptor_t)
      return Error.Return_Value_t;
    pragma Import (C, Fchdir, "fchdir");
  begin
    if Fchdir (Descriptor) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Change_By_Descriptor;

  --
  -- Change_By_Name.
  --

  procedure Change_By_Name
    (Path        : in     String;
     Error_Value :    out Error.Error_t)
  is
    Descriptor   : File.Descriptor_t;
    Error_Local  : Error.Error_t;
  begin
    File.Open_Read_Only
      (File_Name    => Path,
       Non_Blocking => False,
       Descriptor   => Descriptor,
       Error_Value  => Error_Local);
    if Error_Local = Error.Error_None then
      Change_By_Descriptor
        (Descriptor  => Descriptor,
         Error_Value => Error_Value);
      File.Close
        (Descriptor  => Descriptor,
         Error_Value => Error_Local);
      if Error_Local /= Error.Error_None then
        Error_Value := Error_Local;
      end if;
    else
      Error_Value := Error_Local;
    end if;
  end Change_By_Name;

  --
  -- Create directory.
  --

  function Create_Boundary
    (Name : in String;
     Mode : in Permissions.Mode_t) return Error.Return_Value_t
    --# global in Errno.Errno_Value;
    --# return R =>
    --#  ((R = 0)  -> (Error.Get_Error (Errno.Errno_Value)  = Error.Error_None)) or
    --#  ((R = -1) -> (Error.Get_Error (Errno.Errno_Value) /= Error.Error_None));
  is
    C_Name : aliased Interfaces.C.char_array := Interfaces.C.To_C (Name);

    function Mkdir
      (Name : in C_String.String_Not_Null_Ptr_t;
       Mode : in Permissions.Mode_t) return Error.Return_Value_t;
    pragma Import (C, Mkdir, "mkdir");
  begin
    return Mkdir
      (Name => C_String.To_C_String (C_Name'Unchecked_Access),
       Mode => Mode);
  end Create_Boundary;

  procedure Create
    (Name        : in     String;
     Mode        : in     Permissions.Mode_t;
     Error_Value :    out Error.Error_t) is
  begin
    case Create_Boundary (Name, Mode) is
      when  0 => Error_Value := Error.Error_None;
      when -1 => Error_Value := Error.Get_Error;
    end case;
  end Create;

  --
  -- Remove empty directory.
  --

  function Remove_Boundary (Name : in String) return Error.Return_Value_t
    --# global in Errno.Errno_Value;
    --# return R =>
    --#  ((R = 0)  -> (Error.Get_Error (Errno.Errno_Value)  = Error.Error_None)) or
    --#  ((R = -1) -> (Error.Get_Error (Errno.Errno_Value) /= Error.Error_None));
  is
    C_Name : aliased Interfaces.C.char_array := Interfaces.C.To_C (Name);

    function Rmdir (Name : in C_String.String_Not_Null_Ptr_t)
      return Error.Return_Value_t;
    pragma Import (C, Rmdir, "rmdir");
  begin
    return Rmdir (C_String.To_C_String (C_Name'Unchecked_Access));
  end Remove_Boundary;

  procedure Remove
    (Name        : in     String;
     Error_Value :    out Error.Error_t) is
  begin
    case Remove_Boundary (Name) is
      when  0 => Error_Value := Error.Error_None;
      when -1 => Error_Value := Error.Get_Error;
    end case;
  end Remove;

end POSIX.Directory;
