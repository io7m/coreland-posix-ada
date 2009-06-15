with C_String;
with Interfaces.C;
with POSIX.C_Types;
with System;

package body POSIX.User_DB is

  subtype C_Passwd_Return_Type_t is C_Types.Int_t range 0 .. 2;

  Passwd_Result_OK      : constant C_Passwd_Return_Type_t := 0;
  Passwd_Result_No_User : constant C_Passwd_Return_Type_t := 1;
  Passwd_Result_Error   : constant C_Passwd_Return_Type_t := 2;

  procedure C_Get_Entry_By_Name_Boundary
    (User_Name      : in String;
     Database_Entry : out Database_Entry_t;
     Return_Value   : out C_Passwd_Return_Type_t)
    --# derives Database_Entry, Return_Value from User_Name;
  is
    --# hide C_Get_Entry_By_Name_Boundary
    function C_posix_getpwnam
      (User_Name      : in C_String.String_Not_Null_Ptr_t;
       Database_Entry : in System.Address) return C_Passwd_Return_Type_t;
    pragma Import (C, C_posix_getpwnam, "posix_getpwnam");
  begin
    declare
      C_User_Name_Buffer : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (User_Name, Append_Nul => True);
    begin
      Return_Value := C_posix_getpwnam
        (User_Name      => C_String.To_C_String (C_User_Name_Buffer'Unchecked_Access),
         Database_Entry => Database_Entry.C_Core (Database_Entry.C_Core'First)'Address);
    end;
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      Return_Value := Passwd_Result_Error;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      Return_Value := Passwd_Result_Error;
  end C_Get_Entry_By_Name_Boundary;

  procedure Get_Entry_By_Name
    (User_Name      : in String;
     Database_Entry : out Database_Entry_t;
     Found_Entry    : out Boolean;
     Error_Value    : out Error.Error_t)
  is
    Returned_Value : C_Passwd_Return_Type_t;
  begin
    C_Get_Entry_By_Name_Boundary
      (User_Name      => User_Name,
       Database_Entry => Database_Entry,
       Return_Value   => Returned_Value);
    case Returned_Value is
      when Passwd_Result_OK =>
        Found_Entry          := True;
        Database_Entry.Valid := True;
        Error_Value          := Error.Error_None;
      when Passwd_Result_Error =>
        Found_Entry          := False;
        Database_Entry.Valid := False;
        Error_Value          := Error.Get_Error;
      when Passwd_Result_No_User =>
        Found_Entry          := False;
        Database_Entry.Valid := False;
        Error_Value          := Error.Error_None;
    end case;
  end Get_Entry_By_Name;

  --
  -- Accessor functions.
  --

  function Is_Valid (Database_Entry : in Database_Entry_t) return Boolean is
  begin
    return Database_Entry.Valid;
  end Is_Valid;

  function C_Get_User_ID (Database_Entry : in Database_Entry_t) return User_ID_t is
    --# hide C_Get_User_ID
    function C_posix_passwd_get_uid (Database_Entry : System.Address) return User_ID_t;
    pragma Import (C, C_posix_passwd_get_uid, "posix_passwd_get_uid");
  begin
    return C_posix_passwd_get_uid
      (Database_Entry.C_Core (Database_Entry.C_Core'First)'Address);
  end C_Get_User_ID;

  function Get_User_ID (Database_Entry : in Database_Entry_t) return User_ID_t is
  begin
    return C_Get_User_ID (Database_Entry);
  end Get_User_ID;

end POSIX.User_DB;
