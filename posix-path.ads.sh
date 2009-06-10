#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Path is
  pragma Pure (POSIX.Path);

  -- PATH_MAX
  Max_Length : constant Positive := 4096;

end POSIX.Path;
EOF
