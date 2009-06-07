#!/usr/bin/env lua

local string_ex = require ("string_ex")
local io        = require ("io")
local codes     = {}

for line in io.stdin:lines() do
  local parts = string_ex.split (line, ":")
  local code  = {}
  
  code.errno = parts[1]:gsub (" ", "")
  code.ada   = parts[2]:gsub (" ", "")

  table.insert (codes, code)
end

--
-- Map POSIX errno to Ada POSIX error code value.
--

io.write ([[
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
main (int argc, char *argv[])
{
  if (argc < 2) exit (1);

]])

for index, code in pairs (codes) do
  assert (type (code) == "table")

  io.write ([[
#ifdef ]]..code.errno..[[

  if (strcmp (argv[1], "]]..code.errno..[[") == 0) {
    printf ("%d\n", ]]..code.errno..[[);
    return 0;
  }
#endif

]])
end

io.write ([[
  return 0;
}
]])
