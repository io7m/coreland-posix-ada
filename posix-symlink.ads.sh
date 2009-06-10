#!/bin/sh

cat LICENSE || exit 1
cat <<EOF
with POSIX.C_Types;
use type POSIX.C_Types.Signed_Size_t;

with POSIX.Errno;
use type POSIX.Errno.Errno_Int_t;

with POSIX.Error;
with POSIX.File;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.File;

package POSIX.Symlink is

  -- proc_map : readlink
  procedure Read_Link
    (Path        : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out File.File_Name_Index_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Buffer, Buffer_Size from Path &
  --#         Error_Value         from Errno.Errno_Value;

end POSIX.Symlink;
EOF
