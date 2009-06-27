#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.File;
with POSIX.Error;
with POSIX.Permissions;

use type POSIX.Error.Error_t;
use type POSIX.Error.Return_Value_t;

--# inherit POSIX.C_Types,
--#         POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.File,
--#         POSIX.Permissions;

package POSIX.Directory is

  -- subprogram_map : chdir
  procedure Change_By_Name
    (Path        : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Path, Errno.Errno_Value;

  -- subprogram_map : fchdir
  procedure Change_By_Descriptor
    (Descriptor  : in     File.Valid_Descriptor_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Descriptor, Errno.Errno_Value;

  -- subprogram_map : mkdir
  procedure Create
    (Name        : in     String;
     Mode        : in     Permissions.Mode_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Name, Mode, Errno.Errno_Value;

  -- subprogram_map : rmdir
  procedure Remove
    (Name        : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Name, Errno.Errno_Value;

end POSIX.Directory;
EOF
