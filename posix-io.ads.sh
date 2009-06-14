#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.File;
with POSIX.Error;

--# inherit POSIX.C_Types,
--#         POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.File;

package POSIX.IO is

  -- One single element of storage - usually one octet/byte.
EOF

./type-discrete Storage_Element

cat <<EOF

  subtype Storage_Element_Array_Index_t is Natural range Natural'First .. Natural'Last;
  type Storage_Element_Array_t is array (Storage_Element_Array_Index_t range <>) of Storage_Element_t;

  -- proc_map : read
  procedure Read
    (Descriptor    : in File.Valid_Descriptor_t;
     Buffer        : out Storage_Element_Array_t;
     Elements_Read : out Storage_Element_Array_Index_t;
     Error_Value   : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Buffer, Elements_Read, Error_Value from Descriptor, Errno.Errno_Value;

  -- proc_map : write
  procedure Write
    (Descriptor       : in File.Valid_Descriptor_t;
     Buffer           : in Storage_Element_Array_t;
     Elements_Written : out Storage_Element_Array_Index_t;
     Error_Value      : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Elements_Written, Error_Value from Descriptor, Buffer, Errno.Errno_Value;

end POSIX.IO;
EOF
