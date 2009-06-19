with POSIX.Error;
use type POSIX.Error.Error_t;

with POSIX.File;
use type POSIX.File.Offset_t;

with POSIX.File_Status;
with Test;

procedure T_Stat1 is
  Error_Value : POSIX.Error.Error_t;
  Status      : POSIX.File_Status.Status_t;
begin
  POSIX.File_Status.Get_Status
    (File_Name   => "tmp/stat1",
     Status      => Status,
     Error_Value => Error_Value);
  Test.Assert (Error_Value = POSIX.Error.Error_None);
  Test.Assert (POSIX.File_Status.Is_Valid (Status));

  Test.Assert (POSIX.File_Status.Get_Size (Status) = 5);
  Test.Assert (POSIX.File_Status.Get_Number_Of_Links (Status) = 1);
end T_Stat1;
