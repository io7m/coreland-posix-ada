with C_String;
with Interfaces.C;

package body POSIX.File is

  --
  -- Functions to map between flag sets and discrete types.
  --

  function Open_Access_Mode_To_Integer (Open_Access_Mode : in Open_Access_Mode_t)
    return Open_Flag_Integer_t is
  begin
    return Open_Access_Mode_Map (Open_Access_Mode);
  end Open_Access_Mode_To_Integer;

  function Open_Options_To_Integer (Open_Options : in Open_Options_t) return Open_Flag_Integer_t is
    Return_Options : Open_Flag_Integer_t := 0;
  begin
    for Open_Option in Open_Option_t range Open_Option_t'First .. Open_Option_t'Last loop
      if Open_Options (Open_Option) then
        Return_Options := Return_Options or Open_Option_Map (Open_Option);
      end if;
      --# assert (Open_Option <= Open_Option_t'Last) and
      --#        (Open_Option >= Open_Option_t'First);
    end loop;
    return Return_Options;
  end Open_Options_To_Integer;

  --
  -- File opening/creation.
  --

  function C_Open_Boundary
    (File_Name : in String;
     Flags     : in Open_Flag_Integer_t;
     Mode      : in Permissions.Mode_t) return Descriptor_t is
    --# hide C_Open_Boundary
    function C_Open
      (File_Name : in C_String.String_Not_Null_Ptr_t;
       Flags     : in Open_Flag_Integer_t;
       Mode      : in Permissions.Mode_t) return Descriptor_t;
    pragma Import (C, C_Open, "open");
  begin
    declare
      C_File_Name_Buffer : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (File_Name, Append_Nul => True);
    begin
      return C_Open
        (File_Name => C_String.To_C_String (C_File_Name_Buffer'Unchecked_Access),
         Flags     => Flags,
         Mode      => Mode);
    end;
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      return -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      return -1;
  end C_Open_Boundary;

  procedure Open
    (File_Name    : in String;
     Access_Mode  : in Open_Access_Mode_t;
     Options      : in Open_Options_t;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    C_Flags : Open_Flag_Integer_t;
  begin
    C_Flags := Open_Access_Mode_To_Integer (Access_Mode) or
               Open_Options_To_Integer (Options);

    -- Reject long filename.
    if File_Name'Last > File_Name_t'Last then
      Descriptor  := -1;
      Error_Value := Error.Error_Name_Too_Long;
    else
      -- Set flags for non-blocking.
      if Non_Blocking then
        C_Flags := C_Flags or O_NONBLOCK;
      end if;

      -- Call system open() procedure.
      Descriptor := C_Open_Boundary
        (File_Name => File_Name,
         Flags     => C_Flags,
         Mode      => Mode);
      if Descriptor = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
      end if;
    end if;
  end Open;

  procedure Open_Read_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t := Open_Options_t'(others => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Read_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Read_Only;

  procedure Open_Write_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t := Open_Options_t'(others => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Write_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Write_Only;

  procedure Open_Exclusive
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t :=
      Open_Options_t'(Create     => True,
                      Exclusive  => True,
                      others     => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Write_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Exclusive;

  procedure Open_Append
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t :=
      Open_Options_t'(Append => True,
                      Create => True,
                      others => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Write_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Append;

  procedure Open_Truncate
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t :=
      Open_Options_t'(Create     => True,
                      Truncate   => True,
                      others     => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Write_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Truncate;

  procedure Open_Read_Write
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t := Open_Options_t'(others => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Read_Write,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Read_Write;

  procedure Open_Create
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    Open_Options : constant Open_Options_t :=
      Open_Options_t'(Create => True,
                      others => False);
  begin
    Open
      (File_Name    => File_Name,
       Access_Mode  => Write_Only,
       Non_Blocking => Non_Blocking,
       Options      => Open_Options,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Create;

  --
  -- File permissions.
  --

  procedure Change_Descriptor_Mode
    (Descriptor  : in Valid_Descriptor_t;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t)
  is
    Return_Value : Error.Return_Value_t;

    function C_fchmod
      (Descriptor : in Valid_Descriptor_t;
       Mode       : in Permissions.Mode_t) return Error.Return_Value_t;
    pragma Import (C, C_fchmod, "fchmod");
  begin
    Return_Value := C_fchmod
      (Descriptor => Descriptor,
       Mode       => Mode);
    case Return_Value is
      when -1 => Error_Value := Error.Get_Error;
      when 0  => Error_Value := Error.Error_None;
    end case;
  end Change_Descriptor_Mode;

  procedure Change_Mode
    (File_Name   : in String;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t)
  is
    Descriptor : Descriptor_t;
  begin
    Open_Read_Only
      (File_Name    => File_Name,
       Non_Blocking => False,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
    if Error_Value = Error.Error_None then
      Change_Descriptor_Mode
        (Descriptor  => Descriptor,
         Mode        => Mode,
         Error_Value => Error_Value);
    end if;
  end Change_Mode;

  --
  -- File ownership.
  --

  procedure Change_Descriptor_Ownership
    (Descriptor  : in Valid_Descriptor_t;
     Owner       : in User_DB.User_ID_t;
     Group       : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t)
  is
    Return_Value : Error.Return_Value_t;

    function C_fchown
      (Descriptor : in Valid_Descriptor_t;
       Owner      : in User_DB.User_ID_t;
       Group      : in User_DB.Group_ID_t) return Error.Return_Value_t;
    pragma Import (C, C_fchown, "fchown");
  begin
    Return_Value := C_fchown
      (Descriptor => Descriptor,
       Owner      => Owner,
       Group      => Group);
    case Return_Value is
      when -1 => Error_Value := Error.Get_Error;
      when 0  => Error_Value := Error.Error_None;
    end case;
  end Change_Descriptor_Ownership;

  procedure Change_Ownership
    (File_Name   : in String;
     Owner       : in User_DB.User_ID_t;
     Group       : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t)
  is
    Descriptor : Descriptor_t;
  begin
    Open_Read_Only
      (File_Name    => File_Name,
       Non_Blocking => False,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
    if Error_Value = Error.Error_None then
      Change_Descriptor_Ownership
        (Descriptor  => Descriptor,
         Owner       => Owner,
         Group       => Group,
         Error_Value => Error_Value);
    end if;
  end Change_Ownership;

  --
  -- File removal.
  --

  function Unlink_Boundary (File_Name : in String)
    return Error.Return_Value_t is
    --# hide Unlink_Boundary
    function C_Unlink (File_Name : in C_String.String_Not_Null_Ptr_t)
      return Error.Return_Value_t;
    pragma Import (C, C_Unlink, "unlink");
  begin
    declare
      C_File_Name_Buffer : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (File_Name, Append_Nul => True);
    begin
      return C_Unlink (C_String.To_C_String (C_File_Name_Buffer'Unchecked_Access));
    end;
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      return -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      return -1;
  end Unlink_Boundary;

  procedure Unlink
    (File_Name   : in String;
     Error_Value : out Error.Error_t) is
  begin
    case Unlink_Boundary (File_Name) is
      when  0 => Error_Value := Error.Error_None;
      when -1 => Error_Value := Error.Get_Error;
    end case;
  end Unlink;

  --
  -- File closing.
  --

  procedure Close
    (Descriptor  : in Valid_Descriptor_t;
     Error_Value : out Error.Error_t)
  is
    function C_Close (Descriptor : in Valid_Descriptor_t) return Error.Return_Value_t;
    pragma Import (C, C_Close, "close");
  begin
    case C_Close (Descriptor) is
      when  0 => Error_Value := Error.Error_None;
      when -1 => Error_Value := Error.Get_Error;
    end case;
  end Close;

end POSIX.File;
