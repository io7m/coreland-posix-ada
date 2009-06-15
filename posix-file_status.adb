with System;

package body POSIX.File_Status is

  procedure C_FStat_Boundary
    (Descriptor   : in File.Valid_Descriptor_t;
     Status       : out Status_t;
     Return_Value : out Error.Return_Value_t)
    --# derives Status, Return_Value from Descriptor;
  is
    --# hide C_FStat_Boundary
    function C_fstat
      (Descriptor : in File.Valid_Descriptor_t;
       Status     : in System.Address) return Error.Return_Value_t;
    pragma Import (C, C_fstat, "fstat");
  begin
    Return_Value := C_fstat
      (Descriptor => Descriptor,
       Status     => Status (Status'First)'Address);
  end C_FStat_Boundary;

  procedure Get_Descriptor_Status
    (Descriptor  : in File.Valid_Descriptor_t;
     Status      : out Status_t;
     Error_Value : out Error.Error_t)
  is
    Return_Value : Error.Return_Value_t;
  begin
    C_FStat_Boundary
      (Descriptor   => Descriptor,
       Status       => Status,
       Return_Value => Return_Value);
    case Return_Value is
      when -1 => Error_Value := Error.Get_Error;
      when  0 => Error_Value := Error.Error_None;
    end case;
  end Get_Descriptor_Status;

  procedure Get_Status
    (File_Name   : in String;
     Status      : out Status_t;
     Error_Value : out Error.Error_t)
  is
    Descriptor : File.Descriptor_t;
  begin
    File.Open_Read_Only
      (File_Name    => File_Name,
       Non_Blocking => False,
       Descriptor   => Descriptor,
       Error_Value  => Error_Value);
    if Error_Value = Error.Error_None then
      Get_Descriptor_Status
        (Descriptor  => Descriptor,
         Status      => Status,
         Error_Value => Error_Value);
    else
      Status := Status_t'(Status_Element_Index_t => 0);
    end if;
  end Get_Status;

  --
  -- Status accessor functions.
  --

  function C_Get_Device_ID (Status : in Status_t) return Device_ID_t is
    --# hide C_Get_Device_ID
    function C_posix_stat_st_dev (Status : in System.Address) return Device_ID_t;
    pragma Import (C, C_posix_stat_st_dev, "posix_stat_st_dev");
  begin
    return C_posix_stat_st_dev (Status (Status'First)'Address);
  end C_Get_Device_ID;

  function Get_Device_ID (Status : in Status_t) return Device_ID_t is
  begin
    return C_Get_Device_ID (Status);
  end Get_Device_ID;

  function C_Get_INode (Status : in Status_t) return INode_t is
    --# hide C_Get_INode
    function C_posix_stat_st_ino (Status : in System.Address) return INode_t;
    pragma Import (C, C_posix_stat_st_ino, "posix_stat_st_ino");
  begin
    return C_posix_stat_st_ino (Status (Status'First)'Address);
  end C_Get_INode;

  function Get_INode (Status : in Status_t) return INode_t is
  begin
    return C_Get_INode (Status);
  end Get_INode;

  function C_Get_Mode (Status : in Status_t) return Permissions.Mode_Integer_t is
    --# hide C_Get_Mode
    function C_posix_stat_st_mode (Status : in System.Address)
      return Permissions.Mode_Integer_t;
    pragma Import (C, C_posix_stat_st_mode, "posix_stat_st_mode");
  begin
    return C_posix_stat_st_mode (Status (Status'First)'Address);
  end C_Get_Mode;

  function Get_Mode (Status : in Status_t) return Permissions.Mode_t is
  begin
    return Permissions.Mode_Integer_To_Mode (C_Get_Mode (Status));
  end Get_Mode;

  function C_Get_Number_Of_Links (Status : in Status_t) return Positive is
    --# hide C_Get_Number_Of_Links
    function C_posix_stat_st_nlink (Status : in System.Address) return Positive;
    pragma Import (C, C_posix_stat_st_nlink, "posix_stat_st_nlink");
  begin
    return C_posix_stat_st_nlink (Status (Status'First)'Address);
  end C_Get_Number_Of_Links;

  function Get_Number_Of_Links (Status : in Status_t) return Positive is
  begin
    return C_Get_Number_Of_Links (Status);
  end Get_Number_Of_Links;

  function C_Get_User_ID (Status : in Status_t) return User_DB.User_ID_t is
    --# hide C_Get_User_ID
    function C_posix_stat_st_uid (Status : in System.Address) return User_DB.User_ID_t;
    pragma Import (C, C_posix_stat_st_uid, "posix_stat_st_uid");
  begin
    return C_posix_stat_st_uid (Status (Status'First)'Address);
  end C_Get_User_ID;

  function Get_User_ID (Status : in Status_t) return User_DB.User_ID_t is
  begin
    return C_Get_User_ID (Status);
  end Get_User_ID;

  function C_Get_Group_ID (Status : in Status_t) return User_DB.Group_ID_t is
    --# hide C_Get_Group_ID
    function C_posix_stat_st_gid (Status : in System.Address) return User_DB.Group_ID_t;
    pragma Import (C, C_posix_stat_st_gid, "posix_stat_st_gid");
  begin
    return C_posix_stat_st_gid (Status (Status'First)'Address);
  end C_Get_Group_ID;

  function Get_Group_ID (Status : in Status_t) return User_DB.Group_ID_t is
  begin
    return C_Get_Group_ID (Status);
  end Get_Group_ID;

  function C_Get_Size (Status : in Status_t) return File.Offset_t is
    --# hide C_Get_Size
    function C_posix_stat_st_size (Status : in System.Address) return File.Offset_t;
    pragma Import (C, C_posix_stat_st_size, "posix_stat_st_size");
  begin
    return C_posix_stat_st_size (Status (Status'First)'Address);
  end C_Get_Size;

  function Get_Size (Status : in Status_t) return File.Offset_t is
  begin
    return C_Get_Size (Status);
  end Get_Size;

end POSIX.File_Status;
