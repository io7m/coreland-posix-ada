#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.C_Types;
use type POSIX.C_Types.Int_t;

with POSIX.Error;
use type POSIX.Error.Error_t;
use type POSIX.Error.Return_Value_t;

with POSIX.Errno;
use type POSIX.Errno.Errno_Integer_t;

with POSIX.Path;
with POSIX.Permissions;
with POSIX.User_DB;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.Path,
--#         POSIX.Permissions,
--#         POSIX.User_DB;

package POSIX.File is

  -- File descriptor type.
EOF

./type-discrete Descriptor || exit 1

cat << EOF
  subtype Valid_Descriptor_t is Descriptor_t range 0 .. Descriptor_t'Last;

  -- File offset/size.
EOF

./type-discrete Offset || exit 1

cat <<EOF

  -- Filename subtype based on POSIX PATH_MAX
  subtype File_Name_Size_t  is Natural range Natural'First .. Path.Max_Length;
  subtype File_Name_Index_t is File_Name_Size_t range File_Name_Size_t'First + 1 .. Path.Max_Length;
  subtype File_Name_t       is String (File_Name_Index_t);

  --
  -- File opening/creation.
  --

  procedure Open_Read_Only
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Write_Only
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Exclusive
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Mode         : in     Permissions.Mode_t;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Append
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Truncate
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Mode         : in     Permissions.Mode_t;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Read_Write
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Create
    (File_Name    : in     String;
     Non_Blocking : in     Boolean;
     Mode         : in     Permissions.Mode_t;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  type Open_Access_Mode_t is
    (Execute_Only,
     Read_Only,
     Read_Write,
     Search_Only,
     Write_Only);

  type Open_Option_t is
    (Append,
     Close_On_Execute,
     Create,
     Is_Directory,
     Exclusive,
     No_Controlling_TTY,
     No_Follow_Symlinks,
     Truncate,
     TTY_Initialize);

  type Open_Options_t is array (Open_Option_t) of Boolean;

  -- proc_map : open
  procedure Open
    (File_Name    : in     String;
     Access_Mode  : in     Open_Access_Mode_t;
     Options      : in     Open_Options_t;
     Non_Blocking : in     Boolean;
     Mode         : in     Permissions.Mode_t;
     Descriptor   :    out Descriptor_t;
     Error_Value  :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor  from File_Name, Non_Blocking, Mode, Access_Mode, Options &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Access_Mode, Options, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  --
  -- File permissions.
  --

  -- proc_map : chmod
  procedure Change_Mode
    (File_Name   : in     String;
     Mode        : in     Permissions.Mode_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Mode, Errno.Errno_Value;

  -- proc_map : fchmod
  procedure Change_Descriptor_Mode
    (Descriptor  : in     Valid_Descriptor_t;
     Mode        : in     Permissions.Mode_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Mode, Errno.Errno_Value;

  --
  -- File ownership.
  --

  -- proc_map : chown
  procedure Change_Ownership
    (File_Name   : in     String;
     Owner       : in     User_DB.User_ID_t;
     Group       : in     User_DB.Group_ID_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Owner, Group, Errno.Errno_Value;

  -- proc_map : fchown
  procedure Change_Descriptor_Ownership
    (Descriptor  : in     Valid_Descriptor_t;
     Owner       : in     User_DB.User_ID_t;
     Group       : in     User_DB.Group_ID_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Owner, Group, Errno.Errno_Value;

  --
  -- File removal.
  --

  -- proc_map : unlink
  procedure Unlink
    (File_Name   : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Errno.Errno_Value;

  --
  -- File closing.
  --

  -- proc_map : close
  procedure Close
    (Descriptor  : in     Valid_Descriptor_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Errno.Errno_Value;

private

EOF

./type-discrete Open_Flag_Integer || exit 1

cat <<EOF

  -- Integer value for unsupported flag values on the current platform.
  Unsupported : constant Open_Flag_Integer_t := 16#ffff_ffff#;

EOF

./posix_file                      || exit 1

cat <<EOF

  type Open_Access_Mode_Map_t is array (Open_Access_Mode_t) of Open_Flag_Integer_t;

  Open_Access_Mode_Map : constant Open_Access_Mode_Map_t := Open_Access_Mode_Map_t'
    (Execute_Only => O_EXEC,
     Read_Only    => O_RDONLY,
     Read_Write   => O_RDWR,
     Search_Only  => O_SEARCH,
     Write_Only   => O_WRONLY);

  type Open_Option_Map_t is array (Open_Option_t) of Open_Flag_Integer_t;

  Open_Option_Map : constant Open_Option_Map_t := Open_Option_Map_t'
    (Append             => O_APPEND,
     Close_On_Execute   => O_CLOEXEC,
     Create             => O_CREAT,
     Is_Directory       => O_DIRECTORY,
     Exclusive          => O_EXCL,
     No_Controlling_TTY => O_NOCTTY,
     No_Follow_Symlinks => O_NOFOLLOW,
     Truncate           => O_TRUNC,
     TTY_Initialize     => O_TTY_INIT);

  -- Map Open_Access_Mode_t to discrete type.
  function Open_Access_Mode_To_Integer (Access_Mode : in Open_Access_Mode_t) return Open_Flag_Integer_t;
  --# return Open_Access_Mode_Map (Access_Mode);

  -- Map Open_Options_t to discrete type.
  function Open_Options_To_Integer (Open_Options : in Open_Options_t) return Open_Flag_Integer_t;

  -- Check access mode is valid.
  function Check_Access_Mode (Access_Mode : in Open_Access_Mode_t) return Boolean;
  --# return Open_Access_Mode_Map (Access_Mode) /= Unsupported;

  -- Check no options have invalid values.
  function Check_Options (Options : in Open_Options_t) return Boolean;
  --# return for some Option in Open_Option_t =>
  --#   ((Open_Option_Map (Option) /= Unsupported) and (Options (Option)));

  -- Check invalid flags.
  function Check_Support
    (Access_Mode : in Open_Access_Mode_t;
     Options     : in Open_Options_t) return Boolean;
  --# return Check_Access_Mode (Access_Mode) and
  --#        Check_Options (Options);

end POSIX.File;
