with POSIX.C_Types;
use type POSIX.C_Types.Signed_Size_t;

with System;

package body POSIX.IO is

  procedure C_Read_Boundary
    (Descriptor    : in     File.Valid_Descriptor_t;
     Buffer        :    out Storage_Element_Array_t;
     Element_Limit : in     Storage_Element_Array_Size_t;
     Elements_Read :    out Storage_Element_Array_Size_t;
     Error_Value   :    out Error.Error_t)
    --# global in Errno.Errno_Value;
    --# derives Buffer, Elements_Read, Error_Value from Descriptor, Element_Limit, Errno.Errno_Value;
  is
    --# hide C_Read_Boundary
    function C_Read
      (Descriptor  : in File.Valid_Descriptor_t;
       Buffer      : in System.Address;
       Buffer_Size : in C_Types.Size_t) return C_Types.Signed_Size_t;
    pragma Import (C, C_Read, "read");

    Size_Returned : C_Types.Signed_Size_t;
  begin
    Size_Returned := C_Read
      (Descriptor  => Descriptor,
       Buffer      => Buffer (Buffer'First)'Address,
       Buffer_Size => C_Types.Size_t (Element_Limit));
    case Size_Returned is
      when -1 =>
        Error_Value   := Error.Get_Error;
        Elements_Read := 0;
      when  0 =>
        Error_Value   := Error.Error_None;
        Elements_Read := 0;
      when others =>
        Error_Value   := Error.Error_None;
        Elements_Read := Storage_Element_Array_Size_t (Size_Returned);
    end case;
  end C_Read_Boundary;

  procedure Read
    (Descriptor    : in     File.Valid_Descriptor_t;
     Buffer        :    out Storage_Element_Array_t;
     Element_Limit : in     Storage_Element_Array_Size_t;
     Elements_Read :    out Storage_Element_Array_Size_t;
     Error_Value   :    out Error.Error_t) is
  begin
    Error.Set_Error (Error.Error_None);

    C_Read_Boundary
      (Descriptor    => Descriptor,
       Buffer        => Buffer,
       Element_Limit => Element_Limit,
       Elements_Read => Elements_Read,
       Error_Value   => Error_Value);
  end Read;

  procedure C_Write_Boundary
    (Descriptor       : in     File.Valid_Descriptor_t;
     Buffer           : in     Storage_Element_Array_t;
     Element_Limit    : in     Storage_Element_Array_Size_t;
     Elements_Written :    out Storage_Element_Array_Size_t;
     Error_Value      :    out Error.Error_t)
    --# global in Errno.Errno_Value;
    --# derives Elements_Written, Error_Value from Buffer, Element_Limit, Descriptor, Errno.Errno_Value;
  is
    --# hide C_Write_Boundary
    function C_Write
      (Descriptor  : in File.Valid_Descriptor_t;
       Buffer      : in System.Address;
       Buffer_Size : in C_Types.Size_t) return C_Types.Signed_Size_t;
    pragma Import (C, C_Write, "write");

    Size_Returned : C_Types.Signed_Size_t;
  begin
    Size_Returned := C_Write
      (Descriptor  => Descriptor,
       Buffer      => Buffer (Buffer'First)'Address,
       Buffer_Size => C_Types.Size_t (Element_Limit));
    case Size_Returned is
      when -1 =>
        Error_Value      := Error.Get_Error;
        Elements_Written := 0;
      when  0 =>
        Error_Value      := Error.Error_None;
        Elements_Written := 0;
      when others =>
        Error_Value      := Error.Error_None;
        Elements_Written := Storage_Element_Array_Size_t (Size_Returned);
    end case;
  end C_Write_Boundary;

  procedure Write
    (Descriptor       : in     File.Valid_Descriptor_t;
     Buffer           : in     Storage_Element_Array_t;
     Element_Limit    : in     Storage_Element_Array_Size_t;
     Elements_Written :    out Storage_Element_Array_Size_t;
     Error_Value      :    out Error.Error_t) is
  begin
    Error.Set_Error (Error.Error_None);

    C_Write_Boundary
      (Descriptor       => Descriptor,
       Buffer           => Buffer,
       Element_Limit    => Element_Limit,
       Elements_Written => Elements_Written,
       Error_Value      => Error_Value);
  end Write;

end POSIX.IO;
