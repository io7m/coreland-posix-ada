with System;
with POSIX.Path;

package body POSIX.Symlink is

  procedure C_Readlink_Boundary
    (File_Name   : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out C_Types.Signed_Size_t) is
    --# hide C_Readlink_Boundary
    function C_readlink
      (File_Name   : in System.Address;
       Buffer      : in System.Address;
       Buffer_Size : in C_Types.Size_t) return C_Types.Signed_Size_t;
    pragma Import (C, C_readlink, "readlink");
  begin
    Buffer_Size := C_readlink
      (File_Name   => File_Name (File_Name'First)'Address,
       Buffer      => Buffer (Buffer'First)'Address,
       Buffer_Size => Buffer'Length);
  end C_Readlink_Boundary;

  procedure Read_Link
    (File_Name   : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out File.File_Name_Index_t;
     Error_Value : out Error.Error_t)
  is
    C_File_Name : File.File_Name_t;
    C_Size      : C_Types.Signed_Size_t;
  begin
    if File_Name'Last > Path.Max_Length then
      Error_Value := Error.Error_Name_Too_Long;
    else
      -- Copy and null-terminate filename.
      for Index in Positive range File_Name'First .. File_Name'Last loop
        C_File_Name (Index) := File_Name (Index);
      end loop;
      C_File_Name (File_Name'Last + 1) := Character'Val (0);

      -- Call system readlink().
      C_Readlink_Boundary
        (File_Name   => C_File_Name,
         Buffer      => Buffer,
         Buffer_Size => C_Size);
      if C_Size = -1 then
        Error_Value := Error.Get_Error;
      else
        Error_Value := Error.Error_None;
        Buffer_Size := File.File_Name_Index_t (C_Size);
      end if;
    end if;
  end Read_Link;

  function C_Create_Boundary
    (File_Name   : in String;
     Destination : in String) return Error.Return_Value_t is
    --# hide C_Create_Boundary
    function C_Symlink
      (Old_Path : in System.Address;
       New_Path : in System.Address) return Error.Return_Value_t;
    pragma Import (C, C_Symlink, "symlink");
  begin
    return C_Symlink
      (Old_Path => File_Name (File_Name'First)'Address,
       New_Path => Destination (Destination'First)'Address);
  end C_Create_Boundary;

  procedure Create
    (File_Name   : in String;
     Destination : in String;
     Error_Value : out Error.Error_t)
  is
    Names_OK     : Boolean;
    Return_Value : Error.Return_Value_t;
  begin
    Error_Value := Error.Error_None;
    Names_OK    := True;

    if File_Name'Last > Path.Max_Length then
      Error_Value := Error.Error_Name_Too_Long;
      Names_OK    := False;
    end if;

    if Destination'Last > Path.Max_Length then
      Error_Value := Error.Error_Name_Too_Long;
      Names_OK    := False;
    end if;

    if Names_OK then
      Return_Value := C_Create_Boundary
        (File_Name   => File_Name,
         Destination => Destination);
      case Return_Value is
        when  0 => Error_Value := Error.Error_None;
        when -1 => Error_Value := Error.Get_Error;
      end case;
    end if;
  end Create;

end POSIX.Symlink;
