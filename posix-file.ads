with Interfaces.C;
with POSIX.Error;
with POSIX.File_Thin;
with POSIX.Permissions;

package POSIX.File is

  type Descriptor_t is private;
  type Flags_t is new Interfaces.C.unsigned;

  procedure Open_Read_Only
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Write_Only
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Exclusive
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Append
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Truncate
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Read_Write
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  procedure Open_Create
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

  Read_Only  : constant Flags_t := File_Thin.O_RDONLY;
  Write_Only : constant Flags_t := File_Thin.O_WRONLY;
  Read_Write : constant Flags_t := Read_Only or Write_Only;
  Append     : constant Flags_t := File_Thin.O_APPEND;
  Create     : constant Flags_t := File_Thin.O_CREAT;
  Exclusive  : constant Flags_t := File_Thin.O_EXCL;
  Truncate   : constant Flags_t := File_Thin.O_TRUNC;

  procedure Open
    (File         : in String;
     Non_Blocking : in Boolean := False;
     Mode         : in Permissions.Mode_t;
     Flags        : in Flags_t;
     Descriptor   : out Descriptor_t;
     Error        : out POSIX.Error.Error_t);

private

  type Descriptor_t is new Interfaces.C.int;

end POSIX.File;
