 
****************************************
Report : resources
Design : fp8_multiplier
Version: R-2020.09
Date   : Sat May 23 16:19:17 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/FP8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_1       | DW_mult_uns    | a_width=4  | mult_47 (FP8_MAC.sv:47)    |
|                |                | b_width=4  |                            |
| add_x_2        | DW01_add       | width=6    | add_52 (FP8_MAC.sv:52)     |
| sub_x_3        | DW01_sub       | width=6    | sub_52 (FP8_MAC.sv:52)     |
=============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'sub_52 (FP8_MAC.sv:52)' in design 'fp8_multiplier' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'add_52 (FP8_MAC.sv:52)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| mult_x_1           | DW_mult_uns      | apparch (area)     |                |
|                    |                  | mult_arch: and     |                |
| add_x_2            | DW01_add         | apparch (area)     |                |
| sub_x_3            | DW01_sub         | apparch (area)     |                |
===============================================================================

1
