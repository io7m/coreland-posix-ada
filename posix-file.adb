with C_String;
with Interfaces.C;
with System;

package body POSIX.File is

  --
  -- File opening/creation.
  --

  function C_Open_Boundary
    (File_Name : in String;
     Flags     : in Open_Flags_t;
     Mode      : in Permissions.Mode_t) return Descriptor_t is
    --# hide C_Open_Boundary
    function C_Open
      (File_Name : in System.Address;
       Flags     : in Open_Flags_t;
       Mode      : in Permissions.Mode_t) return Descriptor_t;
    pragma Import (C, C_Open, "open");
  begin
    return C_Open
      (File_Name => File_Name (File_Name'First)'Address,
       Flags     => Flags,
       Mode      => Mode);
  end C_Open_Boundary;

  procedure Open
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Flags        : in Open_Flags_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    C_Flags     : Open_Flags_t;
    C_File_Name : File_Name_t := File_Name_t'(File_Name_Index_t => Character'Val (0));
  begin
    -- Reject long filename.
    if File_Name'Last > File_Name_t'Last then
      Descriptor  := -1;
      Error_Value := Error.Error_Name_Too_Long;
    else
      -- Set flags for non-blocking.
      if Non_Blocking then
        C_Flags := Flags or O_NONBLOCK;
      else
        C_Flags := Flags;
      end if;

      -- Copy and null-terminate filename.
      for Index in Positive range File_Name'First .. File_Name'Last loop
        C_File_Name (Index) := File_Name (Index);
      end loop;
      C_File_Name (File_Name'Last + 1) := Character'Val (0);

      -- Call system open() procedure.
      Descriptor := C_Open_Boundary
        (File_Name => C_File_Name,
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
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Read_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Read_Only;

  procedure Open_Write_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Write_Only;

  procedure Open_Exclusive
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Create or Exclusive or Write_Only,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Exclusive;

  procedure Open_Append
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Append or Create or Write_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Append;

  procedure Open_Truncate
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only or Truncate or Create,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Truncate;

  procedure Open_Read_Write
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Read_Write,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Read_Write;

  procedure Open_Create
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t) is
  begin
    Open
      (File_Name    => File_Name,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only or Create,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
  end Open_Create;

  --
  -- File permissions.
  --

  procedure Change_Descriptor_Mode
    (Descriptor  : in Descriptor_t;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t)
  is
    Return_Value : Error.Return_Value_t;

    function C_fchmod
      (Descriptor : in Descriptor_t;
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
    (Descriptor  : in Descriptor_t;
     Error_Value : out Error.Error_t)
  is
    function C_Close (Descriptor : in Descriptor_t) return Error.Return_Value_t;
    pragma Import (C, C_Close, "close");
  begin
    case C_Close (Descriptor) is
      when  0 => Error_Value := Error.Error_None;
      when -1 => Error_Value := Error.Get_Error;
    end case;
  end Close;

end POSIX.File;
