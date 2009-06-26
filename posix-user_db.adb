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
    --# global in Errno.Errno_Value;
    --# derives Database_Entry, Return_Value from User_Name, Errno.Errno_Value;
    --# post
    --#   ((Return_Value = Passwd_Result_Error) and
    --#     (Error.Get_Error (Errno.Errno_Value) = Error.Error_None))
    --#   or
    --#   ((Return_Value /= Passwd_Result_Error) and
    --#     (Error.Get_Error (Errno.Errno_Value) /= Error.Error_None));
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
         Database_Entry => Database_Entry.C_Data (Database_Entry.C_Data'First)'Address);
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
  -- Accessor subprograms.
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
      (Database_Entry.C_Data (Database_Entry.C_Data'First)'Address);
  end C_Get_User_ID;

  function Get_User_ID (Database_Entry : in Database_Entry_t) return User_ID_t is
  begin
    return C_Get_User_ID (Database_Entry);
  end Get_User_ID;

  function C_Get_Group_ID (Database_Entry : in Database_Entry_t) return Group_ID_t is
    --# hide C_Get_Group_ID
    function C_posix_passwd_get_gid (Database_Entry : System.Address) return Group_ID_t;
    pragma Import (C, C_posix_passwd_get_gid, "posix_passwd_get_gid");
  begin
    return C_posix_passwd_get_gid
      (Database_Entry.C_Data (Database_Entry.C_Data'First)'Address);
  end C_Get_Group_ID;

  function Get_Group_ID (Database_Entry : in Database_Entry_t) return Group_ID_t is
  begin
    return C_Get_Group_ID (Database_Entry);
  end Get_Group_ID;

  procedure C_Get_User_Name
    (Database_Entry : in Database_Entry_t;
     User_Name      : out User_Name_t;
     Last_Index     : out User_Name_Index_t)
    --# derives User_Name, Last_Index from Database_Entry;
  is
    --# hide C_Get_User_Name
    procedure C_posix_passwd_get_pw_name
      (Database_Entry : in System.Address;
       User_Name      : in System.Address;
       Last_Index     : out User_Name_Index_t);
    pragma Import (C, C_posix_passwd_get_pw_name, "posix_passwd_get_pw_name");
  begin
    C_posix_passwd_get_pw_name
      (Database_Entry => Database_Entry.C_Data (Database_Entry.C_Data'First)'Address,
       User_Name      => User_Name (User_Name'First)'Address,
       Last_Index     => Last_Index);
  end C_Get_User_Name;

  procedure Get_User_Name
    (Database_Entry : in Database_Entry_t;
     User_Name      : out User_Name_t;
     Last_Index     : out User_Name_Index_t) is
  begin
    C_Get_User_Name
      (Database_Entry => Database_Entry,
       User_Name      => User_Name,
       Last_Index     => Last_Index);
  end Get_User_Name;

  procedure C_Get_Home_Directory
    (Database_Entry : in Database_Entry_t;
     Home_Directory : out Home_Directory_t;
     Last_Index     : out Home_Directory_Index_t)
    --# derives Home_Directory, Last_Index from Database_Entry;
  is
    --# hide C_Get_Home_Directory
    procedure C_posix_passwd_get_pw_dir
      (Database_Entry : in System.Address;
       Home_Directory : in System.Address;
       Last_Index     : out Home_Directory_Index_t);
    pragma Import (C, C_posix_passwd_get_pw_dir, "posix_passwd_get_pw_dir");
  begin
    C_posix_passwd_get_pw_dir
      (Database_Entry => Database_Entry.C_Data (Database_Entry.C_Data'First)'Address,
       Home_Directory => Home_Directory (Home_Directory'First)'Address,
       Last_Index     => Last_Index);
  end C_Get_Home_Directory;

  procedure Get_Home_Directory
    (Database_Entry : in Database_Entry_t;
     Home_Directory : out Home_Directory_t;
     Last_Index     : out Home_Directory_Index_t) is
  begin
    C_Get_Home_Directory
      (Database_Entry => Database_Entry,
       Home_Directory => Home_Directory,
       Last_Index     => Last_Index);
  end Get_Home_Directory;

  procedure C_Get_Shell
    (Database_Entry : in Database_Entry_t;
     Shell_Path     : out Shell_Path_t;
     Last_Index     : out Shell_Path_Index_t)
    --# derives Shell_Path, Last_Index from Database_Entry;
  is
    --# hide C_Get_Shell
    procedure C_posix_passwd_get_pw_shell
      (Database_Entry : in System.Address;
       Shell_Path     : in System.Address;
       Last_Index     : out Shell_Path_Index_t);
    pragma Import (C, C_posix_passwd_get_pw_shell, "posix_passwd_get_pw_shell");
  begin
    C_posix_passwd_get_pw_shell
      (Database_Entry => Database_Entry.C_Data (Database_Entry.C_Data'First)'Address,
       Shell_Path     => Shell_Path (Shell_Path'First)'Address,
       Last_Index     => Last_Index);
  end C_Get_Shell;

  procedure Get_Shell
    (Database_Entry : in Database_Entry_t;
     Shell_Path     : out Shell_Path_t;
     Last_Index     : out Shell_Path_Index_t) is
  begin
    C_Get_Shell
      (Database_Entry => Database_Entry,
       Shell_Path     => Shell_Path,
       Last_Index     => Last_Index);
  end Get_Shell;

end POSIX.User_DB;
