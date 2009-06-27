#!/bin/sh

if [ $# -ne 1 ]
then
  echo "usage: map" 1>&2
  exit 1
fi

file=$1
shift

echo '/*'
echo
cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
*/

#include "posix_config.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int
main (int argc, char *argv[])
{
EOF

IFS="
"
for line in `cat $file`
do
  constant=`echo ${line} | awk -F: '{print $1}' | tr -d '[:space:]'`
  ada_name=`echo ${line} | awk -F: '{print $2}'`

  cat <<EOF
  (void) printf (" ${ada_name} : constant Value_t := %ld;\n",
#ifdef ${constant}
    (long) ${constant});
#else
    (long) -1);
#endif

EOF
done

cat <<EOF
  return EXIT_SUCCESS;
}
EOF
