#!/bin/sh

cat LICENSE || exit 1
cat <<EOF

--
-- Auto generated, do not edit.
--

package POSIX.C_Types is

EOF

./type-discrete Char  || exit 1
echo                  || exit 1
./type-discrete Short || exit 1
echo                  || exit 1
./type-discrete Int   || exit 1
echo                  || exit 1
./type-discrete Long  || exit 1
echo                  || exit 1

./type-discrete Unsigned_Char  || exit 1
echo                           || exit 1
./type-discrete Unsigned_Short || exit 1
echo                           || exit 1
./type-discrete Unsigned_Int   || exit 1
echo                           || exit 1
./type-discrete Unsigned_Long  || exit 1

echo                  || exit 1
./type-discrete Size  || exit 1

cat <<EOF

end POSIX.C_Types;
EOF
