with C_String;
with Interfaces.C;
with POSIX.Path;

package body POSIX.Symlink is

  procedure C_Readlink_Boundary
    (File_Name       : in String;
     Modified_Buffer : out File.File_Name_t;
     Modified_Size   : out C_Types.Signed_Size_t)
    --# derives Modified_Buffer, Modified_Size from File_Name;
  is
    --# hide C_Readlink_Boundary
    function C_Readlink
      (Path        : in C_String.String_Not_Null_Ptr_t;
       Buffer      : in C_String.Char_Array_Not_Null_Ptr_t;
       Buffer_Size : in C_Types.Size_t) return C_Types.Signed_Size_t;
    pragma Import (C, C_Readlink, "readlink");
  begin
    declare
      C_Buffer           : aliased Interfaces.C.char_array :=
        (Interfaces.C.size_t (File.File_Name_Index_t'First) ..
         Interfaces.C.size_t (File.File_Name_Index_t'Last) => Interfaces.C.nul);
      C_File_Name_Buffer : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (File_Name, Append_Nul => True);
      C_Size             : C_Types.Signed_Size_t;
    begin
      C_Size := C_Readlink
        (Path        => C_String.To_C_String (C_File_Name_Buffer'Unchecked_Access),
         Buffer      => C_String.To_C_Char_Array (C_Buffer'Unchecked_Access),
         Buffer_Size => C_Buffer'Length);
      if C_Size > 0 then
        Modified_Buffer (File.File_Name_Index_t'First .. Positive (C_Size)) := C_String.To_String
          (Item => C_String.To_C_Char_Array (C_Buffer'Unchecked_Access),
           Size => Interfaces.C.size_t (C_Size));
        Modified_Size := C_Size;
      else
        Modified_Size := -1;
      end if;
    end;
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      Modified_Size := -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      Modified_Size := -1;
  end C_Readlink_Boundary;

  procedure Read_Link
    (File_Name   : in String;
     Buffer      : out File.File_Name_t;
     Buffer_Size : out File.File_Name_Size_t;
     Error_Value : out Error.Error_t)
  is
    Returned_Buffer : File.File_Name_t;
    Returned_Size   : C_Types.Signed_Size_t;
  begin
    if File_Name'Last > Path.Max_Length then
      Error_Value := Error.Error_Name_Too_Long;
      Buffer      := File.File_Name_t'(File.File_Name_Index_t => Character'Val (0));
      Buffer_Size := 0;
    else
      -- Call system readlink().
      C_Readlink_Boundary
        (File_Name       => File_Name,
         Modified_Buffer => Returned_Buffer,
         Modified_Size   => Returned_Size);
      if Returned_Size = -1 then
        Error_Value := Error.Get_Error;
        Buffer      := File.File_Name_t'(File.File_Name_Index_t => Character'Val (0));
        Buffer_Size := 0;
      else
        Error_Value := Error.Error_None;
        Buffer      := Returned_Buffer;
        Buffer_Size := File.File_Name_Size_t (Returned_Size);
      end if;
    end if;
  end Read_Link;

  function C_Create_Boundary
    (File_Name : in String;
     Target    : in String) return Error.Return_Value_t is
    --# hide C_Create_Boundary
    function C_Symlink
      (File_Name : in C_String.String_Not_Null_Ptr_t;
       Target    : in C_String.String_Not_Null_Ptr_t) return Error.Return_Value_t;
    pragma Import (C, C_Symlink, "symlink");
  begin
    declare
      C_File_Name_Buffer : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (File_Name, Append_Nul => True);
      C_Target_Buffer    : aliased Interfaces.C.char_array :=
        Interfaces.C.To_C (Target, Append_Nul => True);
    begin
      return C_Symlink
        (Target    => C_String.To_C_String (C_File_Name_Buffer'Unchecked_Access),
         File_Name => C_String.To_C_String (C_Target_Buffer'Unchecked_Access));
    end;
  exception
    -- Do not propagate exceptions.
    when Storage_Error =>
      Error.Set_Error (Error.Error_Out_Of_Memory);
      return -1;
    when others =>
      Error.Set_Error (Error.Error_Unknown);
      return -1;
  end C_Create_Boundary;

  procedure Create
    (File_Name   : in String;
     Target      : in String;
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

    if Target'Last > Path.Max_Length then
      Error_Value := Error.Error_Name_Too_Long;
      Names_OK    := False;
    end if;

    if Names_OK then
      Return_Value := C_Create_Boundary
        (File_Name => File_Name,
         Target    => Target);
      case Return_Value is
        when  0 => Error_Value := Error.Error_None;
        when -1 => Error_Value := Error.Get_Error;
      end case;
    end if;
  end Create;

end POSIX.Symlink;
