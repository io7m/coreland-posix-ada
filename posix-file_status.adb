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
       Status     => Status'Address);
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
    end if;
  end Get_Status;

end POSIX.File_Status;
