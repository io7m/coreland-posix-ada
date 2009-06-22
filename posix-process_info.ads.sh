#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.Error;
with POSIX.User_DB;

use type POSIX.User_DB.User_ID_t;
use type POSIX.User_DB.Group_ID_t;

--# inherit POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.User_DB;

package POSIX.Process_Info is

  function Get_Effective_Group_ID return User_DB.Group_ID_t;
  pragma Import (C, Get_Effective_Group_ID, "getegid");

  function Get_Effective_User_ID return User_DB.User_ID_t;
  pragma Import (C, Get_Effective_User_ID, "geteuid");

  function Get_Group_ID return User_DB.Group_ID_t;
  pragma Import (C, Get_Group_ID, "getgid");

  function Get_User_ID return User_DB.User_ID_t;
  pragma Import (C, Get_User_ID, "getuid");

  procedure Set_User_ID
    (User_ID     : in User_DB.User_ID_t;
     Error_Value : out Error.Error_t);
  --# derives Error_Value from User_ID;

  procedure Set_Effective_User_ID
    (User_ID     : in User_DB.User_ID_t;
     Error_Value : out Error.Error_t);
  --# derives Error_Value from User_ID;

  procedure Set_Group_ID
    (Group_ID    : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t);
  --# derives Error_Value from Group_ID;

  procedure Set_Effective_Group_ID
    (Group_ID    : in User_DB.Group_ID_t;
     Error_Value : out Error.Error_t);
  --# derives Error_Value from Group_ID;

end POSIX.Process_Info;
EOF
