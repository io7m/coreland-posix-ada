with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
with POSIX.Symlink;
with Test;

procedure T_Symlink1 is
  Error_Value : POSIX.Error.Error_t;
begin
  POSIX.File.Unlink ("tmp/symlink", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_No_Such_File_Or_Directory);

  POSIX.Symlink.Create
    (File_Name   => "tmp/symlink",
     Target      => "symlink_target",
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.Symlink.Create
    (File_Name   => "tmp/symlink",
     Target      => "symlink_target",
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_File_Exists);

  POSIX.File.Unlink ("tmp/symlink", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Unlink ("tmp/symlink", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_No_Such_File_Or_Directory);
end T_Symlink1;
