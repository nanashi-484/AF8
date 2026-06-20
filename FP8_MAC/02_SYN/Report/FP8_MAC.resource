 
****************************************
Report : resources
Design : FP8_MAC
Version: R-2020.09
Date   : Sat May 23 16:12:20 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/FP8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_9        | DW01_add       | width=6    | u_multiplier/add_52 (FP8_MAC.sv:52) |
| gt_x_10        | DW_cmp         | width=8    | u_aligner/gt_89 (FP8_MAC.sv:89) |
| ashr_11        | DW_rightsh     | A_width=28 | u_aligner/srl_100 (FP8_MAC.sv:100) |
         |                | SH_width=5 |                            |
| DP_OP_51J1_126_1993             |            |                            |
|                | DP_OP_51J1_126_1993 |       |                            |
| DP_OP_25J1_124_2126             |            |                            |
|                | DP_OP_25J1_124_2126 |       |                            |
=============================================================================

Datapath Report for DP_OP_51J1_126_1993
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_51J1_126_1993  | u_multiplier/mult_47 (FP8_MAC.sv:47)                |
|                      | u_aligner/srl_96 (FP8_MAC.sv:96)                    |
|                      | u_aligner/C105 (FP8_MAC.sv:95)                      |
|                      | u_adder/gte_128 (FP8_MAC.sv:128)                    |
|                      | u_adder/C113 (FP8_MAC.sv:131)                       |
|                      | u_adder/C116 (FP8_MAC.sv:135)                       |
|                      | u_adder/sub_137 (FP8_MAC.sv:137)                    |
|                      | u_adder/add_141 (FP8_MAC.sv:141)                    |
|                      | u_adder/C114 (FP8_MAC.sv:132)                       |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 4     |                                          |
| I2    | PI   | Unsigned | 4     |                                          |
| I3    | PI   | Unsigned | 5     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 28    |                                          |
| I7    | PI   | Unsigned | 1     |                                          |
| I8    | PI   | Unsigned | 1     |                                          |
| I9    | PI   | Unsigned | 1     |                                          |
| I10   | PI   | Unsigned | 1     |                                          |
| I11   | PI   | Unsigned | 1     |                                          |
| T8    | IFO  | Unsigned | 8     | I1 * I2 (FP8_MAC.sv:47)                  |
| T34   | IFO  | Unsigned | 28    | T8 << 20                                 |
| T15   | IFO  | Unsigned | 28    | shift(T34,I3,0,0,0,0,28,0) (FP8_MAC.sv:96) |
| T20   | IFO  | Unsigned | 28    | { I4, I5 } ? T15 : T34 (FP8_MAC.sv:95)   |
| T44   | IFO  | Unsigned | 28    | { I7, I8 } ? T20 : I6 ( FP8_MAC.sv:131 FP8_MAC.sv:135 ) |
| T49   | IFO  | Unsigned | 28    | { I10, I11 } ? I6 : T20 ( FP8_MAC.sv:132 FP8_MAC.sv:135 ) |
| O1    | PO   | Unsigned | 1     | T20 >= I6 (FP8_MAC.sv:128)               |
| O2    | PO   | Signed   | 29    | addsub(T44,T49,I9) ( FP8_MAC.sv:137 FP8_MAC.sv:141 ) |
==============================================================================

Datapath Report for DP_OP_25J1_124_2126
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_25J1_124_2126  | u_multiplier/sub_52 (FP8_MAC.sv:52)                 |
|                      | u_aligner/gt_85 (FP8_MAC.sv:85)                     |
|                      | u_aligner/C103 (FP8_MAC.sv:87)                      |
|                      | u_aligner/sub_87 (FP8_MAC.sv:87)                    |
|                      | u_aligner/sub_87_2 (FP8_MAC.sv:87)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Signed   | 8     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| T21   | IFO  | Signed   | 8     | { I3, I4 } ? I2 : O1 (FP8_MAC.sv:87)     |
| T22   | IFO  | Signed   | 8     | { I3, I4 } ? O1 : I2 (FP8_MAC.sv:87)     |
| O1    | PO   | Signed   | 6     | I1 - $unsigned(3'b110) (FP8_MAC.sv:52)   |
| O2    | PO   | Signed   | 1     | I2 > O1 (FP8_MAC.sv:85)                  |
| O3    | PO   | Signed   | 8     | T21 - T22 (FP8_MAC.sv:87)                |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'u_multiplier/sub_52 (FP8_MAC.sv:52)' in design 'FP8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_multiplier/add_52 (FP8_MAC.sv:52)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_9            | DW01_add         | apparch (area)     |                |
| gt_x_10            | DW_cmp           | apparch (area)     |                |
| ashr_11            | DW_rightsh       | astr (area)        |                |
| DP_OP_51J1_126_1993                   |                    |                |
|                    | DP_OP_51J1_126_1993 | str (area)      |                |
|                    |                  | mult_arch: and     |                |
| DP_OP_25J1_124_2126                   |                    |                |
|                    | DP_OP_25J1_124_2126 | str (area,speed)                 |
===============================================================================

1
