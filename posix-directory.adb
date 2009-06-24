package body POSIX.Directory is

  procedure Change_By_Descriptor
    (Descriptor  : in     File.Valid_Descriptor_t;
     Error_Value :    out Error.Error_t)
  is
    function Fchdir (Descriptor : in File.Valid_Descriptor_t)
      return Error.Return_Value_t;
    pragma Import (C, Fchdir, "fchdir");
  begin
    if Fchdir (Descriptor) = -1 then
      Error_Value := Error.Get_Error;
    else
      Error_Value := Error.Error_None;
    end if;
  end Change_By_Descriptor;

  procedure Change_By_Name
    (Path        : in     String;
     Error_Value :    out Error.Error_t)
  is
    Descriptor   : File.Descriptor_t;
    Error_Local  : Error.Error_t;
  begin
    File.Open_Read_Only
      (File_Name    => Path,
       Non_Blocking => False,
       Descriptor   => Descriptor,
       Error_Value  => Error_Local);
    if Error_Local = Error.Error_None then
      Change_By_Descriptor
        (Descriptor  => Descriptor,
         Error_Value => Error_Value);
      File.Close
        (Descriptor  => Descriptor,
         Error_Value => Error_Local);
      if Error_Local /= Error.Error_None then
        Error_Value := Error_Local;
      end if;
    else
      Error_Value := Error_Local;
    end if;
  end Change_By_Name;

end POSIX.Directory;
