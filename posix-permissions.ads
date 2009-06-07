with Interfaces.C;

package POSIX.Permissions is

  type Mode_t is new Interfaces.C.unsigned;

  None        : constant Mode_t := 8#0000#;

  User_Read   : constant Mode_t := 8#0400#;
  User_Write  : constant Mode_t := 8#0200#;
  User_Exec   : constant Mode_t := 8#0100#;

  Group_Read  : constant Mode_t := 8#0040#;
  Group_Write : constant Mode_t := 8#0020#;
  Group_Exec  : constant Mode_t := 8#0010#;

  World_Read  : constant Mode_t := 8#0004#;
  World_Write : constant Mode_t := 8#0002#;
  World_Exec  : constant Mode_t := 8#0001#;

end POSIX.Permissions;
