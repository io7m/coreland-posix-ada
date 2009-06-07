#!/bin/sh

cat LICENSE
cat <<EOF

--
-- Auto generated, do not edit.
--

with Interfaces.C;

package POSIX.Error is

EOF

./enum_type.lua < errno_to_ada.map || exit 1

cat <<EOF

  --
  -- Map error value to locale-specific error message.
  --

  function Wide_Message (Value : in Error_t) return Wide_String;
  function Message (Value : in Error_t) return String;

  --
  -- Get current error code.
  --

  function Get_Error return Error_t;

private

  --
  -- Mapping between errno and Ada error codes.
  --

  function Ada_To_Errno (Value : in Error_t) return Interfaces.C.int;
  function Errno_To_Ada (Value : in Interfaces.C.int) return Error_t;

  --
  -- Return POSIX errno integer.
  --

  function Errno_Get return Interfaces.C.int;
  pragma Import (C, Errno_Get, "posix_errno_get");

  --
  -- Set POSIX errno integer.
  --

  procedure Errno_Set (Code : Interfaces.C.int);
  pragma Import (C, Errno_Set, "posix_errno_set");

end POSIX.Error;
EOF
