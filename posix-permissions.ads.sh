#!/bin/sh

cat LICENSE       || exit 1
cat auto-warn.txt || exit 1
cat <<EOF
package POSIX.Permissions is

  -- Elements
  type Mode_Element_t is
    (User_Read,
     User_Write,
     User_Execute,
     Group_Read,
     Group_Write,
     Group_Execute,
     World_Read,
     World_Write,
     World_Execute,
     Set_User_ID,
     Set_Group_ID);

  type Mode_t is array (Mode_Element_t) of Boolean;

  -- Default (conventional) mode for newly created files.
  Default_File_Mode : constant Mode_t := Mode_t'
    (User_Read  => True,
     User_Write => True,
     Group_Read => True,
     World_Read => True,
     others     => False);

  -- Null mode set.
  None : constant Mode_t := Mode_t'(others => False);

EOF

./type-discrete Mode_Integer || exit 1

cat <<EOF

  type Mode_Map_t is array (Mode_Element_t) of Mode_Integer_t;

  Mode_Map : constant Mode_Map_t;

  -- Map Mode_t to discrete type.
  function Mode_To_Integer (Mode : in Mode_t) return Mode_Integer_t;

  -- Map Mode_Integer_t to Mode_t.
  function Mode_Integer_To_Mode (Mode : in Mode_Integer_t) return Mode_t;

private

EOF

S_IRUSR=`./constants S_IRUSR` || exit 1
S_IWUSR=`./constants S_IWUSR` || exit 1
S_IXUSR=`./constants S_IXUSR` || exit 1

S_IRGRP=`./constants S_IRGRP` || exit 1
S_IWGRP=`./constants S_IWGRP` || exit 1
S_IXGRP=`./constants S_IXGRP` || exit 1

S_IROTH=`./constants S_IROTH` || exit 1
S_IWOTH=`./constants S_IWOTH` || exit 1
S_IXOTH=`./constants S_IXOTH` || exit 1

S_ISUID=`./constants S_ISUID` || exit 1
S_ISGID=`./constants S_ISGID` || exit 1

cat <<EOF
  Internal_User_Read    : constant Mode_Integer_t := ${S_IRUSR};
  Internal_User_Write   : constant Mode_Integer_t := ${S_IWUSR};
  Internal_User_Exec    : constant Mode_Integer_t := ${S_IXUSR};

  Internal_Group_Read   : constant Mode_Integer_t := ${S_IRGRP};
  Internal_Group_Write  : constant Mode_Integer_t := ${S_IWGRP};
  Internal_Group_Exec   : constant Mode_Integer_t := ${S_IXGRP};

  Internal_World_Read   : constant Mode_Integer_t := ${S_IROTH};
  Internal_World_Write  : constant Mode_Integer_t := ${S_IWOTH};
  Internal_World_Exec   : constant Mode_Integer_t := ${S_IXOTH};

  Internal_Set_User_ID  : constant Mode_Integer_t := ${S_ISUID};
  Internal_Set_Group_ID : constant Mode_Integer_t := ${S_ISGID};

  Mode_Map : constant Mode_Map_t := Mode_Map_t'
    (User_Read     => Internal_User_Read,
     User_Write    => Internal_User_Write,
     User_Execute  => Internal_User_Exec,
     Group_Read    => Internal_Group_Read,
     Group_Write   => Internal_Group_Write,
     Group_Execute => Internal_Group_Exec,
     World_Read    => Internal_World_Read,
     World_Write   => Internal_World_Write,
     World_Execute => Internal_World_Exec,
     Set_User_ID   => Internal_Set_User_ID,
     Set_Group_ID  => Internal_Set_Group_ID);

end POSIX.Permissions;
EOF
