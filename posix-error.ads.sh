#!/bin/sh

cat LICENSE || exit 1
cat <<EOF

--
-- Auto generated, do not edit.
--

package POSIX.Error
  --# own POSIX_errno;
is

EOF

./enum_type.lua < errno_to_ada.map || exit 1

cat <<EOF

  --
  -- Map error value to locale-specific error message.
  --

  procedure Message
    (Value  : in Error_t;
     Buffer : out String);
  --# derives Buffer from Value;

  --
  -- Get current error code.
  --

  function Get_Error return Error_t;
  --# global in POSIX_errno;

private

EOF

./type-discrete Errno_Int || exit 1

cat <<EOF

  --
  -- Mapping between errno and Ada error codes.
  --

  function Ada_To_Errno (Value : in Error_t) return Errno_Int_t;
  function Errno_To_Ada (Value : in Errno_Int_t) return Error_t;

  --
  -- Return POSIX errno integer.
  --

  function Errno_Get return Errno_Int_t;
  --# global in POSIX_errno;
  pragma Import (C, Errno_Get, "posix_errno_get");

  --
  -- Set POSIX errno integer.
  --

  procedure Errno_Set (Code : in Errno_Int_t);
  --# global out POSIX_Errno;
  --# derives POSIX_Errno from Code;
  pragma Import (C, Errno_Set, "posix_errno_set");

end POSIX.Error;
EOF
