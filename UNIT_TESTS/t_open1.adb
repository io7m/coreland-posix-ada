with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
with POSIX.Permissions;
with Test;

procedure T_Open1 is
  Error_Value : POSIX.Error.Error_t;
  Descriptor  : POSIX.File.Descriptor_t;
begin
  POSIX.File.Unlink ("tmp/open1", Error_Value);
  Test.Assert (Error_Value'Valid);

  POSIX.File.Open_Create
    (File_Name    => "tmp/open1",
     Non_Blocking => False,
     Mode         => POSIX.Permissions.Default_File_Mode,
     Descriptor   => Descriptor,
     Error_Value  => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Close (Descriptor, Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Unlink ("tmp/open1", Error_Value);
  Test.Assert (Error_Value'Valid);
end T_Open1;
