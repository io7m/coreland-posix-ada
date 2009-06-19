with POSIX.C_Types;
use type POSIX.C_Types.Signed_Size_t;

with System;

package body POSIX.IO is

  -- IO function return value.
  subtype IO_Return_Value_t is
    C_Types.Signed_Size_t range -1 .. C_Types.Signed_Size_t'Last;

  procedure C_Read_Boundary
    (Descriptor    : in     File.Valid_Descriptor_t;
     Buffer        :    out Storage_Element_Array_t;
     Element_Limit : in     Storage_Element_Array_Size_t;
     Elements_Read :    out Storage_Element_Array_Size_t;
     Read_Error    :    out Boolean)
    --# derives Buffer, Elements_Read, Read_Error from Descriptor, Element_Limit;
    --# post Elements_Read <= Element_Limit;
  is
    --# hide C_Read_Boundary
    function C_Read
      (Descriptor  : in File.Valid_Descriptor_t;
       Buffer      : in System.Address;
       Buffer_Size : in C_Types.Size_t) return IO_Return_Value_t;
    pragma Import (C, C_Read, "read");

    Return_Value : IO_Return_Value_t;
  begin
    Return_Value := C_Read
      (Descriptor  => Descriptor,
       Buffer      => Buffer (Buffer'First)'Address,
       Buffer_Size => C_Types.Size_t (Element_Limit));
    if Return_Value = -1 then
      Read_Error    := True;
      Elements_Read := 0;
    else
      Read_Error    := False;
      Elements_Read := Storage_Element_Array_Size_t (Return_Value);
    end if;
  end C_Read_Boundary;

  procedure Read
    (Descriptor    : in     File.Valid_Descriptor_t;
     Buffer        :    out Storage_Element_Array_t;
     Element_Limit : in     Storage_Element_Array_Size_t;
     Elements_Read :    out Storage_Element_Array_Size_t;
     Error_Value   :    out Error.Error_t)
  is
    Elements_Read_Returned : Storage_Element_Array_Size_t;
    Read_Error             : Boolean;
  begin
    C_Read_Boundary
      (Descriptor    => Descriptor,
       Buffer        => Buffer,
       Element_Limit => Element_Limit,
       Elements_Read => Elements_Read_Returned,
       Read_Error    => Read_Error);
    if Read_Error then
      Error_Value   := Error.Get_Error;
      Elements_Read := 0;
    else
      Error_Value   := Error.Error_None;
      Elements_Read := Elements_Read_Returned;
    end if;
  end Read;

  procedure C_Write_Boundary
    (Descriptor       : in     File.Valid_Descriptor_t;
     Buffer           : in     Storage_Element_Array_t;
     Element_Limit    : in     Storage_Element_Array_Size_t;
     Elements_Written :    out Storage_Element_Array_Size_t;
     Write_Error      :    out Boolean)
    --# derives Elements_Written, Write_Error from Buffer, Element_Limit, Descriptor;
    --# post Elements_Written <= Element_Limit;
  is
    --# hide C_Write_Boundary
    function C_Write
      (Descriptor  : in File.Valid_Descriptor_t;
       Buffer      : in System.Address;
       Buffer_Size : in C_Types.Size_t) return IO_Return_Value_t;
    pragma Import (C, C_Write, "write");

    Return_Value : IO_Return_Value_t;
  begin
    Return_Value := C_Write
      (Descriptor  => Descriptor,
       Buffer      => Buffer (Buffer'First)'Address,
       Buffer_Size => C_Types.Size_t (Element_Limit));
    if Return_Value = -1 then
      Write_Error      := True;
      Elements_Written := 0;
    else
      Write_Error      := False;
      Elements_Written := Storage_Element_Array_Size_t (Return_Value);
    end if;
  end C_Write_Boundary;

  procedure Write
    (Descriptor       : in     File.Valid_Descriptor_t;
     Buffer           : in     Storage_Element_Array_t;
     Element_Limit    : in     Storage_Element_Array_Size_t;
     Elements_Written :    out Storage_Element_Array_Size_t;
     Error_Value      :    out Error.Error_t)
  is
    Elements_Written_Returned : Storage_Element_Array_Size_t;
    Write_Error               : Boolean;
  begin
    C_Write_Boundary
      (Descriptor       => Descriptor,
       Buffer           => Buffer,
       Element_Limit    => Element_Limit,
       Elements_Written => Elements_Written_Returned,
       Write_Error      => Write_Error);
    if Write_Error then
      Error_Value      := Error.Get_Error;
      Elements_Written := 0;
    else
      Error_Value      := Error.Error_None;
      Elements_Written := Elements_Written_Returned;
    end if;
  end Write;

end POSIX.IO;
