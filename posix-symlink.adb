with System;

package body POSIX.Symlink is

  procedure C_Readlink_Boundary
    (Path        : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out C_Types.Signed_Size_t) is
    --# hide C_Readlink_Boundary
--    function C_readlink
--      (Path        : in System.Address;
--       Buffer      : in System.Address;
--       Buffer_Size : in C_Types.Size_t) return C_Types.Signed_Size_t;
--    pragma Import (C, C_readlink, "readlink");
--  begin
--    Buffer_Size := C_readlink
--      (Path        => Path (Path'First)'Address,
--       Buffer      => Buffer (Buffer'First)'Address,
--       Buffer_Size => Buffer'Length);
  begin
    Buffer (1)  := 'A';
    Buffer_Size := 10;
  end C_Readlink_Boundary;

  procedure Read_Link
    (Path        : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out File.File_Name_Index_t;
     Error_Value : out Error.Error_t)
  is
    C_Path : File.File_Name_t;
    C_Size : C_Types.Signed_Size_t;
  begin
    if Path'Last > File.File_Name_t'Last then
      Error_Value := Error.Error_Name_Too_Long;
    else
      -- Copy and null-terminate filename.
      for Index in Positive range Path'First .. Path'Last loop
        C_Path (Index) := Path (Index);
      end loop;
      C_Path (Path'Last + 1) := Character'Val (0);

      -- Call system readlink().
      C_Readlink_Boundary
        (Path        => C_Path,
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

end POSIX.Symlink;
