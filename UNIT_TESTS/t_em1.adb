with Ada.Text_IO;

with POSIX.Error;
use type POSIX.Error.Error_t;

procedure T_Em1 is
  package Text_IO renames Ada.Text_IO;

  Message    : POSIX.Error.Message_t;
  Last_Index : POSIX.Error.Message_Index_t;
begin
  for Error_Value in POSIX.Error.Error_t range
    POSIX.Error.Error_t'First .. POSIX.Error.Error_t'Last loop
    POSIX.Error.Message
      (Error_Value    => Error_Value,
       Message_Buffer => Message,
       Last_Index     => Last_Index);
    if POSIX.Error.Message_Index_t'First /= Last_Index then
      Text_IO.Put_Line (Message (Message'First .. Last_Index));
    end if;
  end loop;
end T_Em1;
