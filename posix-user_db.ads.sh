#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.Error;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error;

package POSIX.User_DB is

EOF

./type-discrete User_ID || exit 1
echo
./type-discrete Group_ID || exit 1

LOGIN_NAME_MAX=`./constants LOGIN_NAME_MAX` || exit 1

cat <<EOF

  Unspecified_User  : constant User_ID_t;
  Unspecified_Group : constant Group_ID_t;

  type Database_Entry_t is limited private;

  --
  -- Entry refers to valid user entry?
  --

  function Is_Valid (Database_Entry : in Database_Entry_t) return Boolean;

  -- proc_map : getpwnam_r
  procedure Get_Entry_By_Name
    (User_Name      : in String;
     Database_Entry : out Database_Entry_t;
     Found_Entry    : out Boolean;
     Error_Value    : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Database_Entry, Found_Entry from User_Name &
  --#         Error_Value                 from User_Name, Errno.Errno_Value;
  --# post ((Error_Value = Error.Error_None)  and (Is_Valid (Database_Entry))) or
  --#      ((Error_Value /= Error.Error_None) and (not Is_Valid (Database_Entry)));

  --
  -- Database entry types.
  --

  subtype User_Name_Index_t is Positive range 1 .. $LOGIN_NAME_MAX;
  subtype User_Name_t is String (User_Name_Index_t);

  --
  -- Accessor functions.
  --

  function Get_User_ID (Database_Entry : in Database_Entry_t) return User_ID_t;
  --# pre Is_Valid (Database_Entry);

  procedure Get_User_Name
    (Database_Entry : in Database_Entry_t;
     User_Name      : out User_Name_t;
     Last_Index     : out User_Name_Index_t);
  --# derives User_Name, Last_Index from Database_Entry;
  --# pre Is_Valid (Database_Entry);

private

  Unspecified_User  : constant User_ID_t := -1;
  Unspecified_Group : constant Group_ID_t := -1;

  -- Pseudo type matching size of the system passwd structure to allow
  -- stack allocation.
EOF

./type-passwd C_Database_Entry || exit 1

cat <<EOF

  type Database_Entry_t is record
    Valid  : Boolean;
    C_Data : C_Database_Entry_t;
  end record;

end POSIX.User_DB;
EOF
