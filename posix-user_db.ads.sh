#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.User_DB is

EOF

./type-discrete User_ID || exit 1
echo
./type-discrete Group_ID || exit 1

cat <<EOF

  Unspecified_User  : constant User_ID_t;
  Unspecified_Group : constant Group_ID_t;

private

  Unspecified_User  : constant User_ID_t := -1;
  Unspecified_Group : constant Group_ID_t := -1;

end POSIX.User_DB;
EOF
