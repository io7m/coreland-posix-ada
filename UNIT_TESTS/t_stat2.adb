with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
use type POSIX.File.Offset_t;

with POSIX.File_Status;
use type POSIX.File_Status.Link_Count_t;

with Test;

procedure T_Stat2 is
  Error_Value : POSIX.Error.Error_t;
  Status      : POSIX.File_Status.Status_t;
  Descriptor  : POSIX.File.Descriptor_t;
begin
  POSIX.File.Open_Read_Only
    (File_Name    => "tmp/stat1",
     Non_Blocking => False,
     Descriptor   => Descriptor,
     Error_Value  => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);

  POSIX.File_Status.Get_Descriptor_Status
    (Descriptor  => Descriptor,
     Status      => Status,
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.File_Status.Is_Valid (Status));

  Test.Assert (POSIX.File_Status.Get_Size (Status) = 5);
  Test.Assert (POSIX.File_Status.Get_Number_Of_Links (Status) = 1);
end T_Stat2;
