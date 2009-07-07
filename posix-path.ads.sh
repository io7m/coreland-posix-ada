#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Path is

  -- PATH_MAX
  Max_Length : constant Positive := `./constants PATH_MAX`;

  -- Remove component of Path.
  function Remove_Component (Path_Name  : in String) return Positive;
  --# pre Path_Name'First >= 1
  --# and Path_Name'Last  >= Path_Name'First;

end POSIX.Path;
EOF
