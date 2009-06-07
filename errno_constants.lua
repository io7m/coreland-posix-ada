#!/usr/bin/env lua

local string_ex         = require ("string_ex")
local io                = require ("io")
local errno_values      = {}

local argv = arg
local argc = table.maxn (argv)

if argc < 1 then
  error ("usage: errno_to_int.map")
end

--
-- Read map of errno constants to integer values.
--

local errno_to_int_fh = io.open (argv [1])
assert (errno_to_int_fh)

for line in errno_to_int_fh:lines() do
  local parts = string_ex.split (line, ":")

  local errno = parts [1]:gsub (" ", "")
  local value = parts [2]:gsub (" ", "")

  errno_values [errno] = tonumber (value)
end

io.write ([[
  package C_Constants is
]])

for name, value in pairs (errno_values) do
  io.write ("    "..name.." : constant := "..value..";\n")
end

io.write ([[
  end C_Constants;
]])
