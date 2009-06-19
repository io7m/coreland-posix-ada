#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
with POSIX.File;
use type POSIX.File.Descriptor_t;

with POSIX.Error;
use type POSIX.Error.Error_t;
use type POSIX.Error.Return_Value_t;

with POSIX.Permissions;
with POSIX.User_DB;

--# inherit POSIX.C_Types,
--#         POSIX.Error,
--#         POSIX.Errno,
--#         POSIX.File,
--#         POSIX.Permissions,
--#         POSIX.User_DB;

package POSIX.File_Status is

  -- Abstract file status type.
  type Status_t is private;

  -- Status is valid?
  function Is_Valid (Status : in Status_t) return Boolean;

  -- proc_map : stat
  procedure Get_Status
    (File_Name   : in     String;
     Status      :    out Status_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Status, Error_Value from File_Name, Errno.Errno_Value;
  --# post ((Is_Valid (Status))     and (Error_Value = Error.Error_None)) or
  --#      ((not Is_Valid (Status)) and (Error_Value /= Error.Error_None));

  -- proc_map : fstat
  procedure Get_Descriptor_Status
    (Descriptor  : in     File.Valid_Descriptor_t;
     Status      :    out Status_t;
     Error_Value :    out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Status      from Descriptor &
  --#         Error_Value from Descriptor, Errno.Errno_Value;
  --# post ((Is_Valid (Status))     and (Error_Value = Error.Error_None)) or
  --#      ((not Is_Valid (Status)) and (Error_Value /= Error.Error_None));

EOF

./type-discrete Device_ID  || exit 1
echo
./type-discrete INode      || exit 1
echo
./type-discrete Link_Count || exit 1

cat <<EOF

  --
  -- File status accessor functions.
  --

  function Get_Device_ID (Status : in Status_t) return Device_ID_t;
  --# pre Is_Valid (Status);

  function Get_INode (Status : in Status_t) return INode_t;
  --# pre Is_Valid (Status);

  function Get_Mode (Status : in Status_t) return Permissions.Mode_t;
  --# pre Is_Valid (Status);

  function Get_Number_Of_Links (Status : in Status_t) return Link_Count_t;
  --# pre Is_Valid (Status);

  function Get_User_ID (Status : in Status_t) return User_DB.User_ID_t;
  --# pre Is_Valid (Status);

  function Get_Group_ID (Status : in Status_t) return User_DB.Group_ID_t;
  --# pre Is_Valid (Status);

  function Get_Size (Status : in Status_t) return File.Offset_t;
  --# pre Is_Valid (Status);

private

  -- Pseudo type matching size of the system stat structure to allow
  -- stack allocation.
EOF

./type-status C_Status || exit 1

cat <<EOF

  type Status_t is record
    Valid  : Boolean;
    C_Data : aliased C_Status_t;
  end record;

end POSIX.File_Status;
EOF
