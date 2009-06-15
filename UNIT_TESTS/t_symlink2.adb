with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
with POSIX.Symlink;
with Test;

procedure T_Symlink2 is
  Error_Value : POSIX.Error.Error_t;
  Name_Buffer : POSIX.File.File_Name_t;
  Name_Size   : POSIX.File.File_Name_Size_t;
begin
  POSIX.File.Unlink ("tmp/symlink2", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_No_Such_File_Or_Directory);

  POSIX.Symlink.Create
    (File_Name   => "tmp/symlink2",
     Target      => "",
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.Symlink.Read_Link
    (File_Name   => "tmp/symlink2",
     Buffer      => Name_Buffer,
     Buffer_Size => Name_Size,
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (Name_Size = 0);

  POSIX.File.Unlink ("tmp/symlink2", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
end T_Symlink2;
