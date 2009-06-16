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
  subtype File_Name_Index_t is File_Name_Size_t range File_Name_Size_t'First + 1 .. Path.Max_Length - 1;
  subtype File_Name_t       is String (File_Name_Index_t);

  --
  -- File opening/creation.
  --

  procedure Open_Read_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Write_Only
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Exclusive
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Append
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Truncate
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Read_Write
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking &
  --#         Error_Value from File_Name, Non_Blocking, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  procedure Open_Create
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  type Open_Flag_t is
    (Append,
     Create,
     Exclusive,
     Read_Only,
     Read_Write,
     Truncate,
     Write_Only);

  type Open_Flags_t is array (Open_Flag_t) of Boolean;

  -- proc_map : open
  procedure Open
    (File_Name    : in String;
     Non_Blocking : in Boolean;
     Mode         : in Permissions.Mode_t;
     Flags        : in Open_Flags_t;
     Descriptor   : out Descriptor_t;
     Error_Value  : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Descriptor from File_Name, Non_Blocking, Mode, Flags &
  --#         Error_Value from File_Name, Non_Blocking, Mode, Flags, Errno.Errno_Value;
  --# post ((Descriptor >= 0) and (Error_Value = Error.Error_None)) or
  --#      ((Descriptor = -1) and (Error_Value /= Error.Error_None));

  --
  -- File permissions.
  --

  -- proc_map : chmod
  procedure Change_Mode
    (File_Name   : in String;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Mode, Errno.Errno_Value;

  -- proc_map : fchmod
  procedure Change_Descriptor_Mode
    (Descriptor  : in Valid_Descriptor_t;
     Mode        : in Permissions.Mode_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Mode, Errno.Errno_Value;

  --
  -- File ownership.
  --

  -- proc_map : chown
  procedure Change_Ownership
    (File_Name   : in String;
     Owner       : in User_DB.User_ID_t;
     Group       : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Owner, Group, Errno.Errno_Value;

  -- proc_map : fchown
  procedure Change_Descriptor_Ownership
    (Descriptor  : in Valid_Descriptor_t;
     Owner       : in User_DB.User_ID_t;
     Group       : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Owner, Group, Errno.Errno_Value;

  --
  -- File removal.
  --

  -- proc_map : unlink
  procedure Unlink
    (File_Name   : in String;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Errno.Errno_Value;

  --
  -- File closing.
  --

  -- proc_map : close
  procedure Close
    (Descriptor  : in Valid_Descriptor_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Errno.Errno_Value;

private

EOF

./type-discrete Open_Flag_Integer || exit 1
echo
./posix_file                      || exit 1

cat <<EOF

  Internal_None       : constant Open_Flag_Integer_t := 0;
  Internal_Append     : constant Open_Flag_Integer_t := O_APPEND;
  Internal_Create     : constant Open_Flag_Integer_t := O_CREAT;
  Internal_Exclusive  : constant Open_Flag_Integer_t := O_EXCL;
  Internal_Read_Only  : constant Open_Flag_Integer_t := O_RDONLY;
  Internal_Read_Write : constant Open_Flag_Integer_t := O_RDONLY or O_WRONLY;
  Internal_Truncate   : constant Open_Flag_Integer_t := O_TRUNC;
  Internal_Write_Only : constant Open_Flag_Integer_t := O_WRONLY;

  type Open_Flag_Map_t is array (Open_Flag_t) of Open_Flag_Integer_t;

  Open_Flag_Map : constant Open_Flag_Map_t := Open_Flag_Map_t'
    (Append     => Internal_Append,
     Create     => Internal_Create,
     Exclusive  => Internal_Exclusive,
     Read_Only  => Internal_Read_Only,
     Read_Write => Internal_Read_Write,
     Truncate   => Internal_Truncate,
     Write_Only => Internal_Write_Only);

  -- Map Open_Flag_t to discrete type.
  function Open_Flags_To_Integer (Open_Flags : in Open_Flags_t) return Open_Flag_Integer_t;

  -- Map Open_Flag_Integer_t to Open_Flag_t.
  function Integer_To_Open_Flags (Open_Flags : in Open_Flag_Integer_t) return Open_Flags_t;

end POSIX.File;
