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

  -- proc_map : getegid
  function Get_Effective_Group_ID return User_DB.Valid_Group_ID_t;
  pragma Import (C, Get_Effective_Group_ID, "getegid");

  -- proc_map : geteuid
  function Get_Effective_User_ID return User_DB.Valid_User_ID_t;
  pragma Import (C, Get_Effective_User_ID, "geteuid");

  -- proc_map : getgid
  function Get_Group_ID return User_DB.Valid_Group_ID_t;
  pragma Import (C, Get_Group_ID, "getgid");

  -- proc_map : getuid
  function Get_User_ID return User_DB.Valid_User_ID_t;
  pragma Import (C, Get_User_ID, "getuid");

  -- proc_map : setuid
  procedure Set_User_ID
    (User_ID     : in User_DB.Valid_User_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from User_ID, Errno.Errno_Value;

  -- proc_map : seteuid
  procedure Set_Effective_User_ID
    (User_ID     : in User_DB.Valid_User_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from User_ID, Errno.Errno_Value;

  -- proc_map : setgid
  procedure Set_Group_ID
    (Group_ID    : in User_DB.Valid_Group_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Group_ID, Errno.Errno_Value;

  -- proc_map : setegid
  procedure Set_Effective_Group_ID
    (Group_ID    : in User_DB.Valid_Group_ID_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from Group_ID, Errno.Errno_Value;

end POSIX.Process_Info;
EOF
