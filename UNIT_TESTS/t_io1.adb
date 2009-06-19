with Ada.Unchecked_Conversion;

with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
with POSIX.IO;
with POSIX.Permissions;
with Test;

procedure T_IO1 is
  Error_Value : POSIX.Error.Error_t;
  Descriptor  : POSIX.File.Descriptor_t;

  procedure Test_Write
    (Descriptor : in POSIX.File.Valid_Descriptor_t;
     Input      : in String)
  is
    subtype Source_t is String (Input'Range);
    subtype Target_t is POSIX.IO.Storage_Element_Array_t (Input'Range);

    function To_Element_Array is new Ada.Unchecked_Conversion
      (Source => Source_t,
       Target => Target_t);

    Written : POSIX.IO.Storage_Element_Array_Size_t;
  begin
    POSIX.IO.Write
      (Descriptor       => Descriptor,
       Buffer           => To_Element_Array (Input),
       Element_Limit    => Target_t'Length,
       Elements_Written => Written,
       Error_Value      => Error_Value);
    Test.Assert (Written = Input'Length);
  end Test_Write;

begin
  POSIX.File.Unlink ("tmp/io1", Error_Value);
  Test.Assert (Error_Value'Valid);

  POSIX.File.Open_Create
    (File_Name    => "tmp/io1",
     Non_Blocking => False,
     Mode         => POSIX.Permissions.Default_File_Mode,
     Descriptor   => Descriptor,
     Error_Value  => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  Test_Write (Descriptor, "TESTDATA");
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test_Write (Descriptor, "TESTDATA");
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test_Write (Descriptor, "TESTDATA");
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test_Write (Descriptor, "TESTDATA");
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File.Close (Descriptor, Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
end T_IO1;
