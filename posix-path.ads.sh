#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Path is

  -- PATH_MAX
  Max_Length : constant Positive := `./constants PATH_MAX`;

  -- Remove component of Path.
  procedure Remove_Component
    (Path       : in     String;
     Last_Index :    out Positive);

end POSIX.Path;
EOF
