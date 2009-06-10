#!/bin/sh

cat LICENSE || exit 1
cat <<EOF

--
-- Auto generated, do not edit.
--

package POSIX.Errno
  --# own Errno_Value;
is

EOF

./type-discrete Errno_Int || exit 1

cat <<EOF

  --
  -- Return POSIX errno integer.
  --

  function Errno_Get return Errno_Int_t;
  --# global in Errno_Value;
  pragma Import (C, Errno_Get, "posix_errno_get");

  --
  -- Set POSIX errno integer.
  --

  procedure Errno_Set (Code : in Errno_Int_t);
  --# global out Errno_Value;
  --# derives Errno_Value from Code;
  pragma Import (C, Errno_Set, "posix_errno_set");

end POSIX.Errno;
EOF
