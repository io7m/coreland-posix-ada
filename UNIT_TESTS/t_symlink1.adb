with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.Symlink;
with Test;

procedure T_Symlink1 is
  Error_Value : POSIX.Error.Error_t;
begin
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

end T_Symlink1;
