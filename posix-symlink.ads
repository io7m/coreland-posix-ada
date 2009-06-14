--
-- Copyright (c) 2009, <mark@coreland.ath.cx>
--
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--

--
-- Auto generated, do not edit.
--

with POSIX.C_Types;
use type POSIX.C_Types.Signed_Size_t;

with POSIX.Error;
use type POSIX.Error.Return_Value_t;

with POSIX.File;

--# inherit POSIX.C_Types,
--#         POSIX.Errno,
--#         POSIX.Error,
--#         POSIX.File,
--#         POSIX.Path;

package POSIX.Symlink is

  -- proc_map : readlink
  procedure Read_Link
    (File_Name   : in String;
     Buffer      : in out File.File_Name_t;
     Buffer_Size : out File.File_Name_Size_t;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Buffer      from File_Name, Buffer &
  --#         Buffer_Size from File_Name &
  --#         Error_Value from File_Name, Errno.Errno_Value;

  -- proc_map : symlink
  procedure Create
    (File_Name   : in String;
     Target      : in String;
     Error_Value : out Error.Error_t);
  --# global in Errno.Errno_Value;
  --# derives Error_Value from File_Name, Target, Errno.Errno_Value;

end POSIX.Symlink;
