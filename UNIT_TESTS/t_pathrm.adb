with Ada.Command_Line;
with Ada.Text_IO;
with POSIX.Path;

procedure T_Pathrm is
  Last_Index : Positive;
  Path       : constant String := Ada.Command_Line.Argument (1);
begin
  Last_Index := POSIX.Path.Remove_Component (Path);

  Ada.Text_IO.Put_Line (Path (Path'First .. Last_Index));
end T_Pathrm;
