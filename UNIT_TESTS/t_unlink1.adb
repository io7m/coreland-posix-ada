with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
with POSIX.Permissions;
with Test;

procedure T_Unlink1 is
  Error_Value : POSIX.Error.Error_t;
  Descriptor  : POSIX.File.Descriptor_t;
begin
  POSIX.File.Unlink ("tmp/unlink1", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_No_Such_File_Or_Directory);

  POSIX.File.Open_Create
    (File_Name    => "tmp/unlink1",
     Non_Blocking => False,
     Mode         => POSIX.Permissions.Default_File_Mode,
     Descriptor   => Descriptor,
     Error_Value  => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Close (Descriptor, Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Unlink ("tmp/unlink1", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Unlink ("tmp/unlink1", Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_No_Such_File_Or_Directory);
end T_Unlink1;
