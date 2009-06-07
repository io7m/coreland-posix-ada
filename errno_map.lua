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
  local ok           = true
  local errno        = parts [1]:gsub (" ", "")
  local value        = parts [2]:gsub (" ", "")
  local value_number = tonumber (value)

  io.stderr:write ("errno_map: errno '"..errno.."' value '"..value.."'\n")

  if not value_number then
    io.stderr:write ("errno_map: no value for "..errno.."\n")
    ok = false
  end

  if ok then
    errno_values [errno]             = value_number
    errno_values_used [value_number] = false
  end
end

--
-- Read map of errno constants to Ada codes.
--

local errno_to_ada_fh = io.open (argv [2])
assert (errno_to_ada_fh)

for line in errno_to_ada_fh:lines() do
  local parts = string_ex.split (line, ":")
  local code  = {}

  code.errno = parts [1]:gsub (" ", "")
  code.ada   = parts [2]:gsub (" ", "")

  table.insert (codes, code)
end

--
-- Write Ada spec.
--

io.write ([[

  --
  -- Map POSIX errno to Ada POSIX error code value.
  --

  function Errno_To_Ada (Value : in Interfaces.C.int) return Error_t is
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

  if ok then
    if errno_values_used [error_int] == false then
      io.write ("      when C_Constants."..code.errno.." => return Error_"..code.ada..";\n")
      errno_values_used [error_int] = true
    end
  end
end

io.write ([[
      when others => null;
    end case;
    return Error_Unknown;
  end Errno_To_Ada;

  --
  -- Map Ada error code value to POSIX errno.
  --

  function Ada_To_Errno (Value : in Error_t) return Interfaces.C.int is
  begin
    case Value is
]])

for index, code in pairs (codes) do
  assert (type (code) == "table")
  io.write ("      when Error_"..code.ada.." => return C_Constants."..code.errno..";\n")
end

io.write ([[
      when others => null;
    end case;
    return -1;
  end Ada_To_Errno;
]])
