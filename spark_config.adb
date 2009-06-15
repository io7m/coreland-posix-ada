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

with Ada.Text_IO;
with System;

procedure spark_config is
  package IO renames Ada.Text_IO;

  type Discrete_Type is range System.Min_Int .. System.Max_Int;
  type Modulo_Type   is mod System.Max_Binary_Modulus;
  type Float_Type    is digits System.Max_Base_Digits range -1.0 .. 1.0;

begin

  IO.Put_Line ("-- Auto generated, do not edit.");
  IO.Put_Line ("-- " & System.Name'Image (System.System_Name));
  IO.New_Line;

  IO.Put_Line ("package System is");
  IO.Put_Line ("  type Address is private;");
  IO.New_Line;
  IO.Put_Line ("  Min_Int            : constant := " & Discrete_Type'Image (System.Min_Int) & ";");
  IO.Put_Line ("  Max_Int            : constant := " & Discrete_Type'Image (System.Max_Int) & ";");
  IO.Put_Line ("  Max_Binary_Modulus : constant := " & Modulo_Type'Image (Modulo_Type'Last) & " + 1;");
  IO.Put_Line ("  Max_Digits         : constant := " & Discrete_Type'Image (System.Max_Digits) & ";");
  IO.Put_Line ("  Max_Base_Digits    : constant := " & Discrete_Type'Image (System.Max_Base_Digits) & ";");
  IO.Put_Line ("  Max_Mantissa       : constant := " & Discrete_Type'Image (System.Max_Mantissa) & ";");
  IO.Put_Line ("  Storage_Unit       : constant := " & Discrete_Type'Image (System.Storage_Unit) & ";");
  IO.Put_Line ("  Word_Size          : constant := " & Discrete_Type'Image (System.Word_Size) & ";");
  IO.Put_Line ("  Fine_Delta         : constant := " & Float_Type'Image (System.Fine_Delta) & ";");
  IO.New_Line;
  IO.Put_Line ("  subtype Any_Priority is Integer range " &
    Integer'Image (System.Any_Priority'First) & " .. " &
    Integer'Image (System.Any_Priority'Last) & ";");
  IO.Put_Line ("  subtype Priority is Any_Priority range " &
    Integer'Image (System.Priority'First) & " .. " &
    Integer'Image (System.Priority'Last) & ";");
  IO.Put_Line ("  subtype Interrupt_Priority is Any_Priority range " &
    Integer'Image (System.Interrupt_Priority'First) & " .. " &
    Integer'Image (System.Interrupt_Priority'Last) & ";");
  IO.Put_Line ("  Default_Bit_Order : constant Bit_Order := " &
    System.Bit_Order'Image (System.Default_Bit_Order) & ";");
  IO.New_Line;
  IO.Put_Line ("end System;");

end spark_config;
