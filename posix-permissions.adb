package body POSIX.Permissions is

  function Mode_To_Integer (Mode : in Mode_t) return Mode_Integer_t is
    Return_Mode : Mode_Integer_t := 8#0000#;
  begin
    for Mode_Element in Mode_Element_t range Mode_t'First .. Mode_t'Last loop
      --# assert Mode_Element <= Mode_t'Last
      --#    and Mode_Element >= Mode_t'First
      --#    and Mode_Map (Mode_Element) >= Mode_Integer_t'First
      --#    and Mode_Map (Mode_Element) <= Mode_Integer_t'Last;
      if Mode (Mode_Element) then
        Return_Mode := Return_Mode or Mode_Map (Mode_Element);
      end if;
    end loop;
    return Return_Mode;
  end Mode_To_Integer;

  function Mode_Integer_To_Mode (Mode : in Mode_Integer_t) return Mode_t is
    Return_Mode : Mode_t := None;
  begin
    for Mode_Element in Mode_Element_t range Mode_t'First .. Mode_t'Last loop
      if (Mode and Mode_Map (Mode_Element)) = Mode_Map (Mode_Element) then
        Return_Mode (Mode_Element) := True;
      end if;
      --# assert (Mode_Element <= Mode_t'Last) and
      --#        (Mode_Element >= Mode_t'First);
    end loop;
    return Return_Mode;
  end Mode_Integer_To_Mode;

end POSIX.Permissions;
