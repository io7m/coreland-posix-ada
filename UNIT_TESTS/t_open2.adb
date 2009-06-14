with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
use type POSIX.File.Descriptor_t;

with Test;

procedure T_Open2 is
  Error_Value : POSIX.Error.Error_t;
  Descriptor  : POSIX.File.Descriptor_t;
begin
  POSIX.File.Open_Read_Only
    (File_Name    => "tmp/open2",
     Non_Blocking => False,
     Descriptor   => Descriptor,
     Error_Value  => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (Descriptor /= -1);

  POSIX.File.Close (Descriptor, Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
end T_Open2;
