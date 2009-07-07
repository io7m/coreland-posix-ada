#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Path is

  -- PATH_MAX
  Max_Length : constant Positive := `./constants PATH_MAX`;

  -- Path name subtype based on POSIX PATH_MAX
  subtype Path_Name_Size_t  is Natural range Natural'First .. Max_Length;
  subtype Path_Name_Index_t is Path_Name_Size_t range Path_Name_Size_t'First + 1 .. Max_Length;
  subtype Path_Name_t       is String (Path_Name_Index_t);

  -- Remove component of Path.
  function Remove_Component (Path_Name : in String) return Positive;
  --# pre Path_Name'First >= 1
  --# and Path_Name'Last  >= Path_Name'First;

end POSIX.Path;
EOF
