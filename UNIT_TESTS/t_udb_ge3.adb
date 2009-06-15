with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.User_DB;
use type POSIX.User_DB.User_ID_t;

with Test;
with Test_Config;

procedure T_UDB_GE3 is
  Error_Value    : POSIX.Error.Error_t;
  Database_Entry : POSIX.User_DB.Database_Entry_t;
  Found_Entry    : Boolean;
  User_Name      : POSIX.User_DB.User_Name_t;
  Last_Index     : POSIX.User_DB.User_Name_Index_t;
begin

  POSIX.User_DB.Get_Entry_By_Name
    (User_Name      => Test_Config.User_Name,
     Database_Entry => Database_Entry,
     Found_Entry    => Found_Entry,
     Error_Value    => Error_Value);
  Test.Assert (Found_Entry);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.User_DB.Is_Valid (Database_Entry));

  POSIX.User_DB.Get_User_Name
    (Database_Entry => Database_Entry,
     User_Name      => User_Name,
     Last_Index     => Last_Index);
  Test.Assert (User_Name (User_Name'First .. Last_Index) = Test_Config.User_Name);

end T_UDB_GE3;
