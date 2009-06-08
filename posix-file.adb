with System;

package body POSIX.File is

  function C_Open_Boundary
    (File_Name : in String;
     Flags     : in Flags_t;
     Mode      : in Permissions.Mode_t) return Descriptor_t is
    --# hide C_Open_Boundary

    function C_Open
      (File_Name : in System.Address;
       Flags     : in Flags_t;
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
     Flags        : in Flags_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t)
  is
    C_Flags     : Flags_t;
    C_File_Name : File_Name_t := File_Name_t'(File_Name_Index_t => Character'Val (0));
  begin
    -- Reject long filename.
    if File_Name'Last >= File_Name_t'Last then
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

end POSIX.File;
