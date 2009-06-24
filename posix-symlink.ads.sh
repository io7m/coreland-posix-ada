#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.C_Types;
use type POSIX.C_Types.Signed_Size_t;

with POSIX.Error;
use type POSIX.Error.Return_Value_t;

with POSIX.File;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.File,
--#         POSIX.Path;

package POSIX.Symlink is

  -- subprogram_map : readlink
  procedure Read_Link
    (File_Name   : in     String;
     Buffer      :    out File.File_Name_t;
     Buffer_Size :    out File.File_Name_Size_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Buffer, Buffer_Size from File_Name &
  --#         Error_Value         from File_Name, Errno.Errno_Value;

  -- subprogram_map : symlink
  procedure Create
    (File_Name   : in     String;
     Target      : in     String;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Target, Errno.Errno_Value;

end POSIX.Symlink;
EOF
