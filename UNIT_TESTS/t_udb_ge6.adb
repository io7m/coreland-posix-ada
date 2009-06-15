with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.User_DB;
with Test;

procedure T_UDB_GE6 is
  Error_Value    : POSIX.Error.Error_t;
  Database_Entry : POSIX.User_DB.Database_Entry_t;
  Found_Entry    : Boolean;
  Shell_Path     : POSIX.User_DB.Shell_Path_t;
  Last_Index     : POSIX.User_DB.Shell_Path_Index_t;
begin

  POSIX.User_DB.Get_Entry_By_Name
    (User_Name      => "root",
     Database_Entry => Database_Entry,
     Found_Entry    => Found_Entry,
     Error_Value    => Error_Value);
  Test.Assert (Found_Entry);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.User_DB.Is_Valid (Database_Entry));

  POSIX.User_DB.Get_Shell
    (Database_Entry => Database_Entry,
     Shell_Path     => Shell_Path,
     Last_Index     => Last_Index);
  Test.Assert (Shell_Path (Shell_Path'First .. Last_Index) = "/bin/bash");

end T_UDB_GE6;
