#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Configuration is
  pragma Pure (POSIX.Configuration);

  type Value_t is range -1 .. 2 ** 31;

  Unsupported : constant Value_t := -1;

EOF

./posix-config || exit 1

cat <<EOF

end POSIX.Configuration;
EOF
