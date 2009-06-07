#!/bin/sh

IFS="
"

for line in `cat errno.map`
do
  errno=`echo $line | awk -F: '{print $1}' | tr -d ' '`
  value=`./errno_int $errno` || exit 1

  echo "$errno : $value"
done
