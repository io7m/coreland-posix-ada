#!/usr/bin/env lua

local string_ex         = require ("string_ex")
local io                = require ("io")
local codes             = {}
local errno_values      = {}
local errno_values_used = {}

local argv = arg
local argc = table.maxn (argv)

if argc < 2 then
  error ("usage: errno_to_int.map errno_to_ada.map")
end

--
-- Read map of errno constants to integer values.
--

local errno_to_int_fh = io.open (argv [1])
assert (errno_to_int_fh)

for line in errno_to_int_fh:lines() do
  local parts        = string_ex.split (line, ":")
  local errno        = parts [1]:gsub (" ", "")
  local value        = parts [2]:gsub (" ", "")
  local value_number = tonumber (value)

  assert (value_number);

  errno_values [errno]             = value_number
  errno_values_used [value_number] = false
end

--
-- Read map of errno constants to Ada codes.
--

local errno_to_ada_fh = io.open (argv [2])
assert (errno_to_ada_fh)

local longest_errno_name = 0
local longest_ada_name   = 0

for line in errno_to_ada_fh:lines() do
  local parts = string_ex.split (line, ":")
  local code  = {}

  code.errno = parts [1]:gsub (" ", "")
  code.ada   = parts [2]:gsub (" ", "")

  if #code.ada   > longest_ada_name then longest_ada_name = #code.ada end
  if #code.errno > longest_errno_name then longest_errno_name = #code.errno end

  table.insert (codes, code)
end

assert (longest_errno_name > 0)
assert (longest_ada_name > 0)

--
-- Write Ada spec.
--

io.write ([[

  --
  -- Map POSIX errno to Ada POSIX error code value.
  --

  function Errno_To_Ada (Value : in Errno.Errno_Int_t) return Error_t is
    Return_Value : Error_t := Error_Unknown;
  begin
    case Value is
]])

for index, code in pairs (codes) do
  assert (type (code) == "table")
  local ok        = true
  local error_int = errno_values [code.errno]

  if not error_int then
    io.stderr:write ("errno_map: no value for "..code.errno.."\n")
    ok = false
  end

  local name_length = #code.errno

  if ok then
    if errno_values_used [error_int] == false then
      io.write ("      when "..code.errno)
      for index = name_length, longest_errno_name do io.write (" ") end
      io.write ("=> Return_Value := Error_"..code.ada..";\n")
      errno_values_used [error_int] = true
    end
  end
end

io.write ([[
      when others => null;
    end case;
    return Return_Value;
  end Errno_To_Ada;

  --
  -- Map Ada error code value to POSIX errno.
  --

  function Ada_To_Errno (Value : in Error_t) return Errno.Errno_Int_t is
    Return_Value : Errno.Errno_Int_t := -1;
  begin
    case Value is
]])

for index, code in pairs (codes) do
  assert (type (code) == "table")

  local name_length = #code.ada

  io.write ("      when Error_"..code.ada)
  for index = name_length, longest_ada_name do io.write (" ") end
  io.write ("=> Return_Value := "..code.errno..";\n")
end

io.write ([[
      when others => null;
    end case;
    return Return_Value;
  end Ada_To_Errno;
]])
