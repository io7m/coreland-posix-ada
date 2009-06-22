#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.Error;
with POSIX.Path;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.Path;

package POSIX.User_DB is

EOF

./type-discrete User_ID || exit 1
echo
./type-discrete Group_ID || exit 1

LOGIN_NAME_MAX=`./constants LOGIN_NAME_MAX` || exit 1

cat <<EOF

  Unspecified_User  : constant User_ID_t;
  Unspecified_Group : constant Group_ID_t;

  subtype Valid_User_ID_t is User_ID_t range 0 .. User_ID_t'Last;
  subtype Valid_Group_ID_t is Group_ID_t range 0 .. Group_ID_t'Last;

  type Database_Entry_t is limited private;

  --
  -- Entry refers to valid user entry?
  --

  function Is_Valid (Database_Entry : in Database_Entry_t) return Boolean;

  -- proc_map : getpwnam_r
  procedure Get_Entry_By_Name
    (User_Name      : in     String;
     Database_Entry :    out Database_Entry_t;
     Found_Entry    :    out Boolean;
     Error_Value    :    out Error.Error_t);
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

  subtype Home_Directory_Index_t is Positive range 1 .. Path.Max_Length;
  subtype Home_Directory_t is String (Home_Directory_Index_t);

  subtype Shell_Path_Index_t is Positive range 1 .. Path.Max_Length;
  subtype Shell_Path_t is String (Shell_Path_Index_t);

  --
  -- Accessor functions.
  --

  function Get_User_ID (Database_Entry : in Database_Entry_t) return User_ID_t;
  --# pre Is_Valid (Database_Entry);

  function Get_Group_ID (Database_Entry : in Database_Entry_t) return Group_ID_t;
  --# pre Is_Valid (Database_Entry);

  procedure Get_User_Name
    (Database_Entry : in     Database_Entry_t;
     User_Name      :    out User_Name_t;
     Last_Index     :    out User_Name_Index_t);
  --# derives User_Name, Last_Index from Database_Entry;
  --# pre Is_Valid (Database_Entry);

  procedure Get_Home_Directory
    (Database_Entry : in     Database_Entry_t;
     Home_Directory :    out Home_Directory_t;
     Last_Index     :    out Home_Directory_Index_t);
  --# derives Home_Directory, Last_Index from Database_Entry;
  --# pre Is_Valid (Database_Entry);

  procedure Get_Shell
    (Database_Entry : in     Database_Entry_t;
     Shell_Path     :    out Shell_Path_t;
     Last_Index     :    out Shell_Path_Index_t);
  --# derives Shell_Path, Last_Index from Database_Entry;
  --# pre Is_Valid (Database_Entry);

private

  Unspecified_User  : constant User_ID_t  := -1;
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
