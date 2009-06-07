package body POSIX.File is
  package C renames Interfaces.C;

  use type C.unsigned;
  use type C.int;

  procedure Open
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Flags        : in Flags_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t)
  is
    C_FD      : C.int;
    C_Flags   : C.unsigned := C.unsigned (Flags);
    C_Mode    : constant C.unsigned := C.unsigned (Mode);
    File_Name : constant String := File & Character'Val (0);
  begin
    if Non_Blocking then
      C_Flags := C_Flags or File_Thin.O_NONBLOCK;
    end if;

    C_FD := File_Thin.Open
      (File  => File_Name (1)'Address,
       Flags => C_Flags,
       Mode  => C_Mode);

    if C_FD = -1 then
      Descriptor := -1;
      Error      := POSIX.Error.Get_Error;
    end if;

    Descriptor := Descriptor_t (C_FD);
    Error      := POSIX.Error.Error_None;
  end Open;

  procedure Open_Read_Only
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Read_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Read_Only;

  procedure Open_Write_Only
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Write_Only;

  procedure Open_Exclusive
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Create or Exclusive or Write_Only,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Exclusive;

  procedure Open_Append
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Append or Create or Write_Only,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Append;

  procedure Open_Truncate
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only or Truncate or Create,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Truncate;

  procedure Open_Read_Write
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Read_Write,
       Mode         => Permissions.None,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Read_Write;

  procedure Open_Create
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t) is
  begin
    Open
      (File         => File,
       Non_Blocking => Non_Blocking,
       Flags        => Write_Only or Create,
       Mode         => Mode,
       Descriptor   => Descriptor,
       Error        => Error);
  end Open_Create;

end POSIX.File;
