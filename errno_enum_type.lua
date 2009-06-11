#!/usr/bin/env lua

local string_ex = require ("string_ex")
local io        = require ("io")
local codes     = {}

io.write ([[
  type Error_t is
    (Error_None,
]])

for line in io.stdin:lines() do
  local parts = string_ex.split (line, ":")
  local name  = parts[2]:gsub (" ", "")
  table.insert (codes, name)
end

for index, code in pairs (codes) do
  io.write ("     Error_"..code..",\n")
end

io.write ([[
     Error_Unknown);
]])
