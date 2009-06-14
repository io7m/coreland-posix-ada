#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.File;
with POSIX.Error;

--# inherit POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.File;

package POSIX.IO is

  -- One single element of storage - usually one octet/byte.
EOF

./type-discrete Storage_Element

cat <<EOF

  subtype Storage_Element_Array_Index_t is Positive range Positive'First .. Positive'Last;
  type Storage_Element_Array_t is array (Storage_Element_Array_Index_t range <>) of Storage_Element_t;

  procedure Read
    (Descriptor    : in File.Valid_Descriptor_t;
     Buffer        : out Storage_Element_Array_t;
     Elements_Read : out Storage_Element_Array_Index_t;
     Error_Value   : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Buffer, Elements_Read, Error_Value from Descriptor, Errno.Errno_Value;

end POSIX.IO;
EOF
