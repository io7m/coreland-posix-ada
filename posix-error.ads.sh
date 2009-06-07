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

private

  function Ada_To_Errno (Value : in Error_t) return Interfaces.C.int;
  function Errno_To_Ada (Value : in Interfaces.C.int) return Error_t;

end POSIX.Error;
EOF
