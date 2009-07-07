package body POSIX.Path is

  function Remove_Component
    (Path_Name  : in String) return Positive
  is
    Current_Index : Positive;
    Continue      : Boolean := True;
  begin
    Current_Index := Path_Name'Last;

    -- Remove trailing slashes.
    while Path_Name (Current_Index) = '/' loop
      --# assert Current_Index <= Path_Name'Last
      --#    and Current_Index >= Path_Name'First;
      if Current_Index = Path_Name'First then
        Continue := False;
        exit;
      end if;
      Current_Index := Current_Index - 1;
    end loop;

    -- Remove non-slash path component.
    if Continue then
      while Path_Name (Current_Index) /= '/' loop
        --# assert Current_Index <= Path_Name'Last
        --#    and Current_Index >= Path_Name'First;
        if Current_Index = Path_Name'First then
          Continue := False;
          exit;
        end if;
        Current_Index := Current_Index - 1;
      end loop;
    end if;

    -- Remove preceding "trailing" slashes.
    if Continue then
      while Path_Name (Current_Index) = '/' loop
        --# assert Current_Index <= Path_Name'Last
        --#    and Current_Index >= Path_Name'First;
        if Current_Index = Path_Name'First then
          exit;
        end if;
        Current_Index := Current_Index - 1;
      end loop;
    end if;

    return Current_Index;
  end Remove_Component;

end POSIX.Path;
