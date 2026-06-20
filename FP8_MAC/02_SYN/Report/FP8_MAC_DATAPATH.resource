 
****************************************
Report : resources
Design : FP8_MAC_DATAPATH
Version: R-2020.09
Date   : Sat May 23 16:13:27 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/FP8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_7        | DW01_add       | width=6    | u_multiplier/add_52 (FP8_MAC.sv:52) |
| gt_x_8         | DW_cmp         | width=8    | u_aligner/gt_89 (FP8_MAC.sv:89) |
| ashr_9         | DW_rightsh     | A_width=28 | u_aligner/srl_100 (FP8_MAC.sv:100) |
         |                | SH_width=5 |                            |
| DP_OP_48J1_124_3764             |            |                            |
|                | DP_OP_48J1_124_3764 |       |                            |
| DP_OP_18_127_6948               |            |                            |
|                | DP_OP_18_127_6948 |         |                            |
=============================================================================

Datapath Report for DP_OP_48J1_124_3764
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_48J1_124_3764  | u_multiplier/mult_47 (FP8_MAC.sv:47)                |
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
| T6    | IFO  | Unsigned | 8     | I1 * I2 (FP8_MAC.sv:47)                  |
| T31   | IFO  | Unsigned | 28    | T6 << 20                                 |
| T13   | IFO  | Unsigned | 28    | shift(T31,I3,0,0,0,0,28,0) (FP8_MAC.sv:96) |
| T18   | IFO  | Unsigned | 28    | { I4, I5 } ? T13 : T31 (FP8_MAC.sv:95)   |
| T41   | IFO  | Unsigned | 28    | { I7, I8 } ? T18 : I6 ( FP8_MAC.sv:131 FP8_MAC.sv:135 ) |
| T46   | IFO  | Unsigned | 28    | { I10, I11 } ? I6 : T18 ( FP8_MAC.sv:132 FP8_MAC.sv:135 ) |
| O1    | PO   | Unsigned | 1     | T18 >= I6 (FP8_MAC.sv:128)               |
| O2    | PO   | Signed   | 29    | addsub(T41,T46,I9) ( FP8_MAC.sv:137 FP8_MAC.sv:141 ) |
==============================================================================

Datapath Report for DP_OP_18_127_6948
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_18_127_6948    | u_multiplier/sub_52 (FP8_MAC.sv:52)                 |
|                      | u_aligner/sub_87 (FP8_MAC.sv:87)                    |
|                      | u_aligner/sub_87_2 (FP8_MAC.sv:87)                  |
|                      | u_aligner/gt_85 (FP8_MAC.sv:85)                     |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Signed   | 8     |                                          |
| O1    | PO   | Signed   | 6     | I1 - $unsigned(3'b110) (FP8_MAC.sv:52)   |
| O2    | PO   | Signed   | 8     | I2 - O1 (FP8_MAC.sv:87)                  |
| O3    | PO   | Signed   | 8     | O1 - I2 (FP8_MAC.sv:87)                  |
| O4    | PO   | Signed   | 1     | I2 > O1 (FP8_MAC.sv:85)                  |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'u_multiplier/sub_52 (FP8_MAC.sv:52)' in design 'FP8_MAC_DATAPATH' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_multiplier/add_52 (FP8_MAC.sv:52)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_7            | DW01_add         | apparch (area)     |                |
| gt_x_8             | DW_cmp           | apparch (area)     |                |
| ashr_9             | DW_rightsh       | astr (area)        |                |
| DP_OP_48J1_124_3764                   |                    |                |
|                    | DP_OP_48J1_124_3764 | str (area,speed)                 |
|                    |                  | mult_arch: and     |                |
| DP_OP_18_127_6948  | DP_OP_18_127_6948 | str (area)        |                |
===============================================================================

1
