 
****************************************
Report : resources
Design : AF8_MAC_DATAPATH
Version: R-2020.09
Date   : Sat May 23 16:14:51 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/AF8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_7        | DW01_add       | width=6    | u_multiplier/add_36 (AF8_MAC.sv:36) |
| gt_x_8         | DW_cmp         | width=10   | u_aligner/gt_67 (AF8_MAC.sv:67) |
| ashr_9         | DW_rightsh     | A_width=24 | u_aligner/srl_82 (AF8_MAC.sv:82) |
           |                | SH_width=5 |                            |
| DP_OP_37J1_122_4684             |            |                            |
|                | DP_OP_37J1_122_4684 |       |                            |
| DP_OP_48_125_6379               |            |                            |
|                | DP_OP_48_125_6379 |         |                            |
=============================================================================

Datapath Report for DP_OP_37J1_122_4684
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_37J1_122_4684  | u_multiplier/sub_36 (AF8_MAC.sv:36)                 |
|                      | u_aligner/sub_66 (AF8_MAC.sv:66)                    |
|                      | u_aligner/sub_70 (AF8_MAC.sv:70)                    |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Signed   | 10    |                                          |
| T29   | IFO  | Signed   | 7     | O1 << 1                                  |
| T30   | IFO  | Signed   | 5     | O2[4:0]                                  |
| O1    | PO   | Signed   | 6     | I1 - $unsigned(4'b1110) (AF8_MAC.sv:36)  |
| O2    | PO   | Signed   | 10    | I2 - T29 (AF8_MAC.sv:66)                 |
| O3    | PO   | Signed   | 5     | $signed(1'b0) - T30 (AF8_MAC.sv:70)      |
==============================================================================

Datapath Report for DP_OP_48_125_6379
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_48_125_6379    | u_multiplier/mult_35 (AF8_MAC.sv:35)                |
|                      | u_aligner/srl_78 (AF8_MAC.sv:78)                    |
|                      | u_aligner/C91 (AF8_MAC.sv:77)                       |
|                      | u_adder/gte_104 (AF8_MAC.sv:104)                    |
|                      | u_adder/C110 (AF8_MAC.sv:105)                       |
|                      | u_adder/C113 (AF8_MAC.sv:109)                       |
|                      | u_adder/sub_110 (AF8_MAC.sv:110)                    |
|                      | u_adder/add_113 (AF8_MAC.sv:113)                    |
|                      | u_adder/C111 (AF8_MAC.sv:106)                       |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 3     |                                          |
| I2    | PI   | Unsigned | 3     |                                          |
| I3    | PI   | Unsigned | 5     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 24    |                                          |
| I7    | PI   | Unsigned | 1     |                                          |
| I8    | PI   | Unsigned | 1     |                                          |
| I9    | PI   | Unsigned | 1     |                                          |
| I10   | PI   | Unsigned | 1     |                                          |
| I11   | PI   | Unsigned | 1     |                                          |
| T6    | IFO  | Unsigned | 6     | I1 * I2 (AF8_MAC.sv:35)                  |
| T31   | IFO  | Unsigned | 27    | T6 << 21                                 |
| T12   | IFO  | Unsigned | 27    | shift(T31,I3,0,0,0,0,27,0) (AF8_MAC.sv:78) |
| T16   | IFO  | Unsigned | 27    | { I4, I5 } ? T12 : T31 (AF8_MAC.sv:77)   |
| T41   | IFO  | Unsigned | 27    | { I7, I8 } ? T16 : I6 ( AF8_MAC.sv:105 AF8_MAC.sv:109 ) |
| T46   | IFO  | Unsigned | 27    | { I10, I11 } ? I6 : T16 ( AF8_MAC.sv:106 AF8_MAC.sv:109 ) |
| O1    | PO   | Unsigned | 1     | T16 >= I6 (AF8_MAC.sv:104)               |
| O2    | PO   | Signed   | 28    | addsub(T41,T46,I9) ( AF8_MAC.sv:110 AF8_MAC.sv:113 ) |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'u_multiplier/sub_36 (AF8_MAC.sv:36)' in design 'AF8_MAC_DATAPATH' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_multiplier/add_36 (AF8_MAC.sv:36)'.  (HDL-120)

Information: Operator associated with resources 'u_aligner/gt_67 (AF8_MAC.sv:67)' in design 'AF8_MAC_DATAPATH' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_aligner/sub_66 (AF8_MAC.sv:66)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_7            | DW01_add         | apparch (area)     |                |
| gt_x_8             | DW_cmp           | apparch (area)     |                |
| ashr_9             | DW_rightsh       | astr (area)        |                |
| DP_OP_37J1_122_4684                   |                    |                |
|                    | DP_OP_37J1_122_4684 | str (area,speed)                 |
| DP_OP_48_125_6379  | DP_OP_48_125_6379 | str (area,speed)  |                |
|                    |                  | mult_arch: and     |                |
===============================================================================

1
