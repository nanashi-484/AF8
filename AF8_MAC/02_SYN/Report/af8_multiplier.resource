 
****************************************
Report : resources
Design : af8_multiplier
Version: R-2020.09
Date   : Sat May 23 16:18:13 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/AF8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_1       | DW_mult_uns    | a_width=3  | mult_35 (AF8_MAC.sv:35)    |
|                |                | b_width=3  |                            |
| add_x_2        | DW01_add       | width=6    | add_36 (AF8_MAC.sv:36)     |
| sub_x_3        | DW01_sub       | width=6    | sub_36 (AF8_MAC.sv:36)     |
=============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'sub_36 (AF8_MAC.sv:36)' in design 'af8_multiplier' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'add_36 (AF8_MAC.sv:36)'.  (HDL-120)


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
