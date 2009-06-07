with System;
with Interfaces.C;

package POSIX.File_Thin is

  O_RDONLY   : constant := 0000;
  O_WRONLY   : constant := 0000;
  O_NONBLOCK : constant := 0000;
  O_APPEND   : constant := 0000;
  O_CREAT    : constant := 0000;
  O_EXCL     : constant := 0000;
  O_TRUNC    : constant := 0000;

  function Open
    (File  : in System.Address;
     Flags : in Interfaces.C.unsigned;
     Mode  : in Interfaces.C.unsigned) return Interfaces.C.int;
  pragma Import (C, Open, "open");

end POSIX.File_Thin;
