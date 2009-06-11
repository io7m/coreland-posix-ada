with POSIX.Error;
use type POSIX.Error.Error_t;

with Test;

procedure T_Error1 is
  package Error renames POSIX.Error;

  Fetched : Error.Error_t;
  Value   : constant Error.Error_t := Error.Error_Access;
begin
  Error.Set_Error (Value);
  Fetched := Error.Get_Error;
  Test.Assert
    (Check        => Fetched = Value,
     Pass_Message => Error.Error_t'Image (Fetched) & " = "  & Error.Error_t'Image (Value),
     Fail_Message => Error.Error_t'Image (Fetched) & " /= " & Error.Error_t'Image (Value));
end T_Error1;
