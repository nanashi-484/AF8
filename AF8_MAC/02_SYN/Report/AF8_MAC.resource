 
****************************************
Report : resources
Design : AF8_MAC
Version: R-2020.09
Date   : Sat May 23 16:01:50 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/AF8_MAC.sv
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_9        | DW01_add       | width=6    | u_multiplier/add_36 (AF8_MAC.sv:36) |
| gt_x_10        | DW_cmp         | width=10   | u_aligner/gt_67 (AF8_MAC.sv:67) |
| ashr_11        | DW_rightsh     | A_width=24 | u_aligner/srl_82 (AF8_MAC.sv:82) |
           |                | SH_width=5 |                            |
| ashr_58        | DW_rightsh     | A_width=27 | u_normalizer/srl_179 (AF8_MAC.sv:179) |
      |                | SH_width=10 |                           |
| sub_x_59       | DW01_sub       | width=5    | u_normalizer/sub_184 (AF8_MAC.sv:184) |
| ash_60         | DW_leftsh      | A_width=50 | u_normalizer/sll_184 (AF8_MAC.sv:184) |
      |                | SH_width=5 |                            |
| add_x_63       | DW01_add       | width=10   | u_normalizer/add_215 (AF8_MAC.sv:215) |
| lte_x_64       | DW_cmp         | width=9    | u_normalizer/lte_217 (AF8_MAC.sv:217) |
| gte_x_65       | DW_cmp         | width=10   | u_normalizer/gte_223 (AF8_MAC.sv:223) |
| sub_x_66       | DW01_sub       | width=10   | u_normalizer/sub_225 (AF8_MAC.sv:225) |
| gte_x_67       | DW_cmp         | width=10   | u_normalizer/gte_225 (AF8_MAC.sv:225) |
| sub_x_68       | DW01_sub       | width=11   | u_normalizer/sub_228 (AF8_MAC.sv:228) |
| ash_69         | DW_leftsh      | A_width=24 | u_normalizer/sll_228 (AF8_MAC.sv:228) |
      |                | SH_width=32 |                           |
| gte_x_70       | DW_cmp         | width=24   | u_normalizer/gte_229 (AF8_MAC.sv:229) |
| gte_x_71       | DW_cmp         | width=10   | u_normalizer/gte_238 (AF8_MAC.sv:238) |
| ashr_72        | DW_rightsh     | A_width=24 | u_normalizer/srl_244 (AF8_MAC.sv:244) |
      |                | SH_width=6 |                            |
| gte_x_73       | DW_cmp         | width=6    | u_normalizer/gte_247 (AF8_MAC.sv:247) |
| sub_x_74       | DW01_sub       | width=7    | u_normalizer/sub_247 (AF8_MAC.sv:247) |
| ash_75         | DW_leftsh      | A_width=24 | u_normalizer/sll_247 (AF8_MAC.sv:247) |
      |                | SH_width=32 |                           |
| sub_x_76       | DW01_dec       | width=24   | u_normalizer/sub_247_2 (AF8_MAC.sv:247) |
| ashr_78        | DW_rightsh     | A_width=24 | u_normalizer/srl_253 (AF8_MAC.sv:253) |
      |                | SH_width=6 |                            |
| gte_x_79       | DW_cmp         | width=6    | u_normalizer/gte_256 (AF8_MAC.sv:256) |
| sub_x_80       | DW01_sub       | width=7    | u_normalizer/sub_256 (AF8_MAC.sv:256) |
| ash_81         | DW_leftsh      | A_width=24 | u_normalizer/sll_256 (AF8_MAC.sv:256) |
      |                | SH_width=32 |                           |
| sub_x_82       | DW01_dec       | width=24   | u_normalizer/sub_256_2 (AF8_MAC.sv:256) |
| add_x_83       | DW01_inc       | width=3    | u_normalizer/add_268 (AF8_MAC.sv:268) |
| gte_x_84       | DW_cmp         | width=10   | u_normalizer/gte_275 (AF8_MAC.sv:275) |
| lte_x_85       | DW_cmp         | width=10   | u_normalizer/lte_278 (AF8_MAC.sv:278) |
| DP_OP_218J1_122_9594            |            |                            |
|                | DP_OP_218J1_122_9594 |      |                            |
| DP_OP_219J1_123_5246            |            |                            |
|                | DP_OP_219J1_123_5246 |      |                            |
| DP_OP_220J1_124_413             |            |                            |
|                | DP_OP_220J1_124_413 |       |                            |
| DP_OP_166J1_125_6636            |            |                            |
|                | DP_OP_166J1_125_6636 |      |                            |
=============================================================================

Datapath Report for DP_OP_218J1_122_9594
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_218J1_122_9594 | u_multiplier/sub_36 (AF8_MAC.sv:36)                 |
|                      | u_aligner/sub_66 (AF8_MAC.sv:66)                    |
|                      | u_aligner/sub_70 (AF8_MAC.sv:70)                    |
|                      | u_aligner/C89 (AF8_MAC.sv:68)                       |
|                      | u_normalizer/add_141_aco (AF8_MAC.sv:141)           |
|                      | u_normalizer/add_180 (AF8_MAC.sv:180)               |
|                      | u_normalizer/add_186 (AF8_MAC.sv:186)               |
|                      | u_normalizer/sub_171 (AF8_MAC.sv:171)               |
|                      | u_normalizer/gte_177 (AF8_MAC.sv:177)               |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Signed   | 10    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 5     |                                          |
| T10   | IFO  | Signed   | 6     | I1 - $unsigned(4'b1110) (AF8_MAC.sv:36)  |
| T147  | IFO  | Signed   | 7     | T10 << 1                                 |
| T148  | IFO  | Signed   | 5     | O1[4:0]                                  |
| T16   | IFO  | Signed   | 10    | { I3, I4 } ? I2 : T147 (AF8_MAC.sv:68)   |
| O1    | PO   | Signed   | 10    | I2 - T147 (AF8_MAC.sv:66)                |
| O2    | PO   | Signed   | 5     | $signed(1'b0) - T148 (AF8_MAC.sv:70)     |
| O3    | PO   | Signed   | 10    | T16 + I5 + O4 ( AF8_MAC.sv:141 AF8_MAC.sv:180 AF8_MAC.sv:186 ) |
| O4    | PO   | Signed   | 7     | I6 - $unsigned(5'b10111) (AF8_MAC.sv:171) |
| O5    | PO   | Signed   | 1     | O4 >= $signed(1'b0) (AF8_MAC.sv:177)     |
==============================================================================

Datapath Report for DP_OP_219J1_123_5246
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_219J1_123_5246 | u_normalizer/add_251 (AF8_MAC.sv:251)               |
|                      | u_normalizer/C1435 (AF8_MAC.sv:250)                 |
|                      | u_normalizer/add_266_aco (AF8_MAC.sv:266)           |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 9     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| T99   | IFO  | Signed   | 10    | I1 + $unsigned(1'b1) (AF8_MAC.sv:251)    |
| T119  | IFO  | Unsigned | 10    | { I2, I3 } ? T99 : I1 (AF8_MAC.sv:250)   |
| O1    | PO   | Unsigned | 10    | T119 + I4 (AF8_MAC.sv:266)               |
==============================================================================

Datapath Report for DP_OP_220J1_124_413
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_220J1_124_413  | u_normalizer/add_236 (AF8_MAC.sv:236)               |
|                      | u_normalizer/sub_236 (AF8_MAC.sv:236)               |
|                      | u_normalizer/sub_245 (AF8_MAC.sv:245)               |
|                      | u_normalizer/sub_246 (AF8_MAC.sv:246)               |
|                      | u_normalizer/add_252 (AF8_MAC.sv:252)               |
|                      | u_normalizer/sub_254 (AF8_MAC.sv:254)               |
|                      | u_normalizer/sub_255 (AF8_MAC.sv:255)               |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 10    |                                          |
| I2    | PI   | Signed   | 10    |                                          |
| T166  | IFO  | Signed   | 5     | O1[4:0]                                  |
| T214  | IFO  | Signed   | 6     | O1[5:0]                                  |
| T169  | IFO  | Signed   | 5     | O4[4:0]                                  |
| O1    | PO   | Signed   | 10    | I1 + $unsigned(3'b111) - I2 (AF8_MAC.sv:236) |
| O2    | PO   | Signed   | 5     | T166 - $unsigned(1'b1) (AF8_MAC.sv:245)  |
| O3    | PO   | Signed   | 5     | T166 - $unsigned(2'b10) (AF8_MAC.sv:246) |
| O4    | PO   | Unsigned | 6     | T214 + $unsigned(2'b10) (AF8_MAC.sv:252) |
| O5    | PO   | Signed   | 5     | T169 - $unsigned(1'b1) (AF8_MAC.sv:254)  |
| O6    | PO   | Signed   | 5     | T169 - $unsigned(2'b10) (AF8_MAC.sv:255) |
==============================================================================

Datapath Report for DP_OP_166J1_125_6636
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_166J1_125_6636 | u_multiplier/mult_35 (AF8_MAC.sv:35)                |
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
| T8    | IFO  | Unsigned | 6     | I1 * I2 (AF8_MAC.sv:35)                  |
| T149  | IFO  | Unsigned | 27    | T8 << 21                                 |
| T14   | IFO  | Unsigned | 27    | shift(T149,I3,0,0,0,0,27,0) (AF8_MAC.sv:78) |
| T18   | IFO  | Unsigned | 27    | { I4, I5 } ? T14 : T149 (AF8_MAC.sv:77)  |
| T159  | IFO  | Unsigned | 27    | { I7, I8 } ? T18 : I6 ( AF8_MAC.sv:105 AF8_MAC.sv:109 ) |
| T164  | IFO  | Unsigned | 27    | { I10, I11 } ? I6 : T18 ( AF8_MAC.sv:106 AF8_MAC.sv:109 ) |
| O1    | PO   | Unsigned | 1     | T18 >= I6 (AF8_MAC.sv:104)               |
| O2    | PO   | Signed   | 28    | addsub(T159,T164,I9) ( AF8_MAC.sv:110 AF8_MAC.sv:113 ) |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'u_multiplier/sub_36 (AF8_MAC.sv:36)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_multiplier/add_36 (AF8_MAC.sv:36)'.  (HDL-120)

Information: Operator associated with resources 'u_normalizer/add_251 (AF8_MAC.sv:251)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_normalizer/add_215 (AF8_MAC.sv:215)'.  (HDL-120)

Information: Operator associated with resources 'u_aligner/gt_67 (AF8_MAC.sv:67)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_aligner/sub_66 (AF8_MAC.sv:66)'.  (HDL-120)

Information: Operator associated with resources 'u_normalizer/sub_225 (AF8_MAC.sv:225)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'u_normalizer/gte_225 (AF8_MAC.sv:225)'.  (HDL-120)

Information: Operator associated with resources 'u_normalizer/gte_238 (AF8_MAC.sv:238)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_normalizer/add_236 (AF8_MAC.sv:236) u_normalizer/sub_236 (AF8_MAC.sv:236)'.  (HDL-120)

Information: Operator associated with resources 'u_normalizer/gt_250 (AF8_MAC.sv:250)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_normalizer/srl_244 (AF8_MAC.sv:244)'.  (HDL-120)

Information: Operator associated with resources 'u_normalizer/gte_256 (AF8_MAC.sv:256)' in design 'AF8_MAC' breaks the datapath extraction because there is leakage due to truncation on the fanout of its driver 'u_normalizer/add_252 (AF8_MAC.sv:252)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_9            | DW01_add         | apparch (area)     |                |
| gt_x_10            | DW_cmp           | apparch (area)     |                |
| ashr_11            | DW_rightsh       | astr (area)        |                |
| ashr_58            | DW_rightsh       | astr (area)        |                |
| sub_x_59           | DW01_sub         | apparch (area)     |                |
| ash_60             | DW_leftsh        | astr (area)        |                |
| add_x_63           | DW01_add         | apparch (area)     |                |
| lte_x_64           | DW_cmp           | apparch (area)     |                |
| gte_x_65           | DW_cmp           | apparch (area)     |                |
| sub_x_66           | DW01_sub         | apparch (area)     |                |
| gte_x_67           | DW_cmp           | apparch (area)     |                |
| sub_x_68           | DW01_sub         | apparch (area)     |                |
| ash_69             | DW_leftsh        | astr (area)        |                |
| gte_x_70           | DW_cmp           | apparch (area)     |                |
| gte_x_71           | DW_cmp           | apparch (area)     |                |
| ashr_72            | DW_rightsh       | astr (area)        |                |
| gte_x_73           | DW_cmp           | apparch (area)     |                |
| sub_x_74           | DW01_sub         | apparch (area)     |                |
| ash_75             | DW_leftsh        | astr (area)        |                |
| sub_x_76           | DW01_dec         | apparch (area)     |                |
| ashr_78            | DW_rightsh       | astr (area)        |                |
| gte_x_79           | DW_cmp           | apparch (area)     |                |
| sub_x_80           | DW01_sub         | apparch (area)     |                |
| ash_81             | DW_leftsh        | astr (area)        |                |
| sub_x_82           | DW01_dec         | apparch (area)     |                |
| add_x_83           | DW01_inc         | apparch (area)     |                |
| gte_x_84           | DW_cmp           | apparch (area)     |                |
| lte_x_85           | DW_cmp           | apparch (area)     |                |
| DP_OP_218J1_122_9594                  |                    |                |
|                    | DP_OP_218J1_122_9594 | str (area,speed)                |
| DP_OP_219J1_123_5246                  |                    |                |
|                    | DP_OP_219J1_123_5246 | str (area)     |                |
| DP_OP_220J1_124_413                   |                    |                |
|                    | DP_OP_220J1_124_413 | str (area)      |                |
| DP_OP_166J1_125_6636                  |                    |                |
|                    | DP_OP_166J1_125_6636 | str (area)     |                |
|                    |                  | mult_arch: and     |                |
===============================================================================

1
