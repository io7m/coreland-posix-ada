with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.User_DB;
use type POSIX.User_DB.Group_ID_t;

with Test;

procedure T_UDB_GE4 is
  Error_Value    : POSIX.Error.Error_t;
  Database_Entry : POSIX.User_DB.Database_Entry_t;
  Found_Entry    : Boolean;
begin

  POSIX.User_DB.Get_Entry_By_Name
    (User_Name      => "root",
     Database_Entry => Database_Entry,
     Found_Entry    => Found_Entry,
     Error_Value    => Error_Value);
  Test.Assert (Found_Entry);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.User_DB.Is_Valid (Database_Entry));
  Test.Assert (POSIX.User_DB.Get_Group_ID (Database_Entry) = 0);

end T_UDB_GE4;
