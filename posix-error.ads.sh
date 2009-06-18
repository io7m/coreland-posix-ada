#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.Errno;
use type POSIX.Errno.Errno_Integer_t;

--# inherit POSIX.Errno;

package POSIX.Error is

  --
  -- Error message type.
  --

  subtype Message_Index_t is Positive range 1 .. 256;
  subtype Message_t is String (Message_Index_t);

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

  function Ada_To_Errno (Value : in Error_t) return Errno.Errno_Integer_t;

  function Errno_To_Ada (Value : in Errno.Errno_Integer_t) return Error_t;

  --
  -- Retrieve locale-dependent message based on error value.
  --

  procedure Message
    (Error_Value    : in     Error_t;
     Message_Buffer :    out Message_t;
     Last_Index     :    out Message_Index_t);
  --# derives Message_Buffer, Last_Index from Error_Value;

end POSIX.Error;
EOF
