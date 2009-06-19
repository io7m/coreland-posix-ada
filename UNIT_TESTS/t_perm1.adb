with Ada.Text_IO;
with POSIX.Permissions;

procedure T_Perm1 is
  package Text_IO renames Ada.Text_IO;
  package Mode_IO is new Ada.Text_IO.Modular_IO (POSIX.Permissions.Mode_Integer_t);

  User_Read     : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.User_Read => True, others => False);
  User_Write    : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.User_Write => True, others => False);
  User_Execute  : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.User_Execute => True, others => False);

  Group_Read    : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.Group_Read => True, others => False);
  Group_Write   : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.Group_Write => True, others => False);
  Group_Execute : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.Group_Execute => True, others => False);

  World_Read    : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.World_Read => True, others => False);
  World_Write   : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.World_Write => True, others => False);
  World_Execute : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.World_Execute => True, others => False);

  Set_User_ID   : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.Set_User_ID => True, others => False);
  Set_Group_ID  : constant POSIX.Permissions.Mode_t :=
    (POSIX.Permissions.Set_Group_ID => True, others => False);

  procedure Dump
    (Name : in String;
     Mode : in POSIX.Permissions.Mode_t) is
  begin
    Text_IO.Put (Name & " : ");
    Mode_IO.Put
      (Item  => POSIX.Permissions.Mode_To_Integer (Mode),
       Width => 8,
       Base  => 8);
    Text_IO.New_Line;
  end Dump;

begin
  Dump ("Set_User_ID  ", Set_User_ID);
  Dump ("Set_Group_ID ", Set_Group_ID);

  Dump ("User_Read    ", User_Read);
  Dump ("User_Write   ", User_Write);
  Dump ("User_Execute ", User_Execute);

  Dump ("Group_Read   ", Group_Read);
  Dump ("Group_Write  ", Group_Write);
  Dump ("Group_Execute", Group_Execute);

  Dump ("World_Read   ", World_Read);
  Dump ("World_Write  ", World_Write);
  Dump ("World_Execute", World_Execute);
end T_Perm1;
