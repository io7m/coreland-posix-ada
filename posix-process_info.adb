package body POSIX.Process_Info is

  procedure Set_User_ID
    (User_ID     : in     User_DB.Valid_User_ID_t;
     Error_Value :    out Error.Error_t)
  is
    function C_Set_User_ID (User_ID : User_DB.Valid_User_ID_t)
      return Error.Return_Value_t;
    pragma Import (C, C_Set_User_ID, "setuid");
  begin
    if C_Set_User_ID (User_ID) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Set_User_ID;

  procedure Set_Effective_User_ID
    (User_ID     : in     User_DB.Valid_User_ID_t;
     Error_Value :    out Error.Error_t)
  is
    function C_Set_Effective_User_ID (User_ID : User_DB.Valid_User_ID_t)
      return Error.Return_Value_t;
    pragma Import (C, C_Set_Effective_User_ID, "seteuid");
  begin
    if C_Set_Effective_User_ID (User_ID) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Set_Effective_User_ID;

  procedure Set_Group_ID
    (Group_ID    : in     User_DB.Valid_Group_ID_t;
     Error_Value :    out Error.Error_t)
  is
    function C_Set_Group_ID (Group_ID : User_DB.Valid_Group_ID_t)
      return Error.Return_Value_t;
    pragma Import (C, C_Set_Group_ID, "setgid");
  begin
    if C_Set_Group_ID (Group_ID) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Set_Group_ID;

  procedure Set_Effective_Group_ID
    (Group_ID    : in     User_DB.Valid_Group_ID_t;
     Error_Value :    out Error.Error_t)
  is
    function C_Set_Effective_Group_ID (Group_ID : User_DB.Valid_Group_ID_t)
      return Error.Return_Value_t;
    pragma Import (C, C_Set_Effective_Group_ID, "setegid");
  begin
    if C_Set_Effective_Group_ID (Group_ID) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Set_Effective_Group_ID;

end POSIX.Process_Info;
