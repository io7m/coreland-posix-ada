#!/bin/sh

cat LICENSE || exit 1
cat <<EOF

--
-- Auto generated, do not edit.
--

with POSIX.Error_Internal;
use type POSIX.Error_Internal.Errno_Int_t;

--# inherit POSIX.Error_Internal;

package POSIX.Error is

EOF

./enum_type.lua < errno_to_ada.map || exit 1

cat <<EOF

  --
  -- Get current error code.
  --

  function Get_Error return Error_t;
  --# global in Error_Internal.Errno;

  --
  -- Range of return values returned by many POSIX procedures.
  -- Compatible with C int.
  --

EOF

./type-discrete Return_Value || exit 1

cat <<EOF

private

  --
  -- Mapping between errno and Ada error codes.
  --

  function Ada_To_Errno (Value : in Error_t) return Error_Internal.Errno_Int_t;
  function Errno_To_Ada (Value : in Error_Internal.Errno_Int_t) return Error_t;

end POSIX.Error;
EOF
