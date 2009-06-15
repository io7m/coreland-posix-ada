with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.User_DB;
with Test;
with Test_Config;

procedure T_UDB_GE5 is
  Error_Value    : POSIX.Error.Error_t;
  Database_Entry : POSIX.User_DB.Database_Entry_t;
  Found_Entry    : Boolean;
  Home_Directory : POSIX.User_DB.Home_Directory_t;
  Last_Index     : POSIX.User_DB.Home_Directory_Index_t;
begin

  POSIX.User_DB.Get_Entry_By_Name
    (User_Name      => Test_Config.User_Name,
     Database_Entry => Database_Entry,
     Found_Entry    => Found_Entry,
     Error_Value    => Error_Value);
  Test.Assert (Found_Entry);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.User_DB.Is_Valid (Database_Entry));

  POSIX.User_DB.Get_Home_Directory
    (Database_Entry => Database_Entry,
     Home_Directory => Home_Directory,
     Last_Index     => Last_Index);
  Test.Assert (Home_Directory (Home_Directory'First .. Last_Index) = Test_Config.User_Directory);

end T_UDB_GE5;
