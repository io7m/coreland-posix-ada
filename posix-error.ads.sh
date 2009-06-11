#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.Errno;
use type POSIX.Errno.Errno_Int_t;

--# inherit POSIX.Errno;

package POSIX.Error is

EOF

./errno_enum_type.lua < errno_to_ada.map || exit 1

cat <<EOF

  --
  -- Get current error code.
  --

  function Get_Error return Error_t;
  --# global in Errno.Errno_Value;

  --
  -- Set current error code.
  --

  procedure Set_Error (Error_Value : in Error_t);
  --# global out Errno.Errno_Value;
  --# derives Errno.Errno_Value from Error_Value;

  --
  -- Range of return values returned by many POSIX procedures.
  -- Compatible with C int.
  --

EOF

./type-discrete Return_Value || exit 1

cat <<EOF

  --
  -- Mapping between errno and Ada error codes.
  --

  function Ada_To_Errno (Value : in Error_t) return Errno.Errno_Int_t;

  function Errno_To_Ada (Value : in Errno.Errno_Int_t) return Error_t;

end POSIX.Error;
EOF
