/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09
// Date      : Sat May 23 16:12:20 2026
/////////////////////////////////////////////////////////////


module FP8_MAC ( clk, rst_n, in_a, in_b, acc_clear, out_result );
  input [7:0] in_a;
  input [7:0] in_b;
  output [7:0] out_result;
  input clk, rst_n, acc_clear;
  wire   acc_sign, n_1_net__7_, n_1_net__6_, n_1_net__5_, n_1_net__4_,
         n_1_net__3_, n_1_net__2_, n_1_net__1_, n_1_net__0_, n_2_net__27_,
         n_2_net__26_, n_2_net__25_, n_2_net__24_, n_2_net__23_, n_2_net__22_,
         n_2_net__21_, n_2_net__20_, n_2_net__19_, n_2_net__18_, n_2_net__17_,
         n_2_net__16_, n_2_net__15_, n_2_net__14_, n_2_net__13_, n_2_net__12_,
         n_2_net__11_, n_2_net__10_, n_2_net__9_, n_2_net__8_, n_2_net__7_,
         n_2_net__6_, n_2_net__5_, n_2_net__4_, n_2_net__3_, n_2_net__2_,
         n_2_net__1_, n_2_net__0_, u_multiplier_N3, u_multiplier_N2,
         u_multiplier_N1, intadd_0_CI, intadd_0_n3, intadd_0_n2, intadd_0_n1,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219,
         n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n255, n256, n257, n258, n259, n260, n261, n262, n263,
         n264, n265, n266, n267, n268, n269, n270, n271, n272, n273, n274,
         n275, n276, n277, n278, n279, n280, n281, n282, n283, n284, n285,
         n286, n287, n288, n289, n290, n291, n292, n293, n294, n295, n296,
         n297, n298, n299, n300, n301, n302, n303, n304, n305, n306, n307,
         n308, n309, n310, n311, n312, n313, n314, n315, n316, n317, n318,
         n319, n320, n321, n322, n323, n324, n325, n326, n327, n328, n329,
         n330, n331, n332, n333, n334, n335, n336, n337, n338, n339, n340,
         n341, n342, n343, n344, n345, n346, n347, n348, n349, n350, n351,
         n352, n353, n354, n355, n356, n357, n358, n359, n360, n361, n362,
         n363, n364, n365, n366, n367, n368, n369, n370, n371, n372, n373,
         n374, n375, n376, n377, n378, n379, n380, n381, n382, n383, n384,
         n385, n386, n387, n388, n389, n390, n391, n392, n393, n394, n395,
         n396, n397, n398, n399, n400, n401, n402, n403, n404, n405, n406,
         n407, n408, n409, n410, n411, n412, n413, n414, n415, n416, n417,
         n418, n419, n420, n421, n422, n423, n424, n425, n426, n427, n428,
         n429, n430, n431, n432, n433, n434, n435, n436, n437, n438, n439,
         n440, n441, n442, n443, n444, n445, n446, n447, n448, n449, n450,
         n451, n452, n453, n454, n455, n456, n457, n458, n459, n460, n461,
         n462, n463, n464, n465, n466, n467, n468, n469, n470, n471, n472,
         n473, n474, n475, n476, n477, n478, n479, n480, n481, n482, n483,
         n484, n485, n486, n487, n488, n489, n490, n491, n492, n493, n494,
         n495, n496, n497, n498, n499, n500, n501, n502, n503, n504, n505,
         n506, n507, n508, n509, n510, n511, n512, n513, n514, n515, n516,
         n517, n518, n519, n520, n521, n522, n523, n524, n525, n526, n527,
         n528, n529, n530, n531, n532, n533, n534, n535, n536, n537, n538,
         n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549,
         n550, n551, n552, n553, n554, n555, n556, n557, n558, n559, n560,
         n561, n562, n563, n564, n565, n566, n567, n568, n569, n570, n571,
         n572, n573, n574, n575, n576, n577, n578, n579, n580, n581, n582,
         n583, n584, n585, n586, n587, n588, n589, n590, n591, n592, n593,
         n594, n595, n596, n597, n598, n599, n600, n601, n602, n603, n604,
         n605, n606, n607, n608, n609, n610, n611, n612, n613, n614, n615,
         n616, n617, n618, n619, n620, n621, n622, n623, n624, n625, n626,
         n627, n628, n629, n630, n631, n632, n633, n634, n635, n636, n637,
         n638, n639, n640, n641, n642, n643, n644, n645, n646, n647, n648,
         n649, n650, n651, n652, n653, n654, n655, n656, n657, n658, n659,
         n660, n661, n662, n663, n664, n665, n666, n667, n668, n669, n670,
         n671, n672, n673, n674, n675, n676, n677, n678, n679, n680, n681,
         n682, n683, n684, n685, n686, n687, n688, n689, n690, n691, n692,
         n693, n694, n695, n696, n697, n698, n699, n700, n701, n702, n703,
         n704, n705, n706, n707, n708, n709, n710, n711, n712, n713, n714,
         n715, n716, n717, n718, n719, n720, n721, n722, n723, n724, n725,
         n726, n727, n728, n729, n730, n731, n732, n733, n734, n735, n736,
         n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747,
         n748, n749, n750, n751, n752, n753, n754, n755, n756, n757, n758,
         n759, n760, n761, n762, n763, n764, n765, n766, n767, n768, n769,
         n770, n771, n772, n773, n774, n775, n776, n777, n778, n779, n780,
         n781, n782, n783, n784, n785, n786, n787, n788, n789, n790, n791,
         n792, n793, n794, n795, n796, n797, n798, n799, n800, n801, n802,
         n803, n804, n805, n806, n807, n808, n809, n810, n811, n812, n813,
         n814, n815, n816, n817, n818, n819, n820, n821, n822, n823, n824,
         n825, n826, n827, n828, n829, n830, n831, n832, n833, n834, n835,
         n836, n837, n838, n839, n840, n841, n842, n843, n844, n845, n846,
         n847, n848, n849, n850, n851, n852, n853, n854, n855, n856, n857,
         n858, n859, n860, n861, n862, n863, n864, n865, n866, n867, n868,
         n869, n870, n871, n872, n873, n874, n875, n876, n877, n878, n879,
         n880, n881, n882, n883, n884, n885, n886, n887, n888, n889, n890,
         n891, n892, n893, n894, n895, n896, n897, n898, n899, n900, n901,
         n902, n903, n904, n905, n906, n907, n908, n909, n910, n911, n912,
         n913, n914, n915, n916, n917, n918, n919, n920, n921, n922, n923,
         n924, n925, n926, n927, n928, n929, n930, n931, n932, n933, n934,
         n935, n936, n937, n938, n939, n940, n941, n942, n943, n944, n945,
         n946, n947, n948, n949, n950, n951, n952, n953, n954, n955, n956,
         n957, n958, n959, n960, n961, n962, n963, n964, n965, n966, n967,
         n968, n969, n970, n971, n972, n973, n974, n975, n976, n977, n978,
         n979, n980, n981, n982, n983, n984, n985, n986, n987, n988, n989,
         n990, n991, n992, n993, n994, n995, n996, n997, n998, n999, n1000,
         n1001, n1002, n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010,
         n1011, n1012, n1013, n1014, SYNOPSYS_UNCONNECTED_1;
  wire   [7:0] acc_exp;
  wire   [27:0] acc_mant;
  wire   [28:0] adder_mant;
  wire   [7:1] adder_exp;
  wire   [6:0] fp8_result;
  wire   [7:0] norm_exp;
  wire   [27:0] norm_mant;

  fp8_normalizer_MANT_WIDTH28 u_normalizer ( .sign_in(n1013), .mant_in(
        adder_mant), .exp_in({adder_exp, n1012}), .fp8_out({
        SYNOPSYS_UNCONNECTED_1, fp8_result}), .acc_exp(norm_exp), 
        .acc_mant_27_(norm_mant[27]), .acc_mant_26__BAR(norm_mant[26]), 
        .acc_mant_24_(norm_mant[24]), .acc_mant_22_(norm_mant[22]), 
        .acc_mant_21_(norm_mant[21]), .acc_mant_20_(norm_mant[20]), 
        .acc_mant_19_(norm_mant[19]), .acc_mant_18_(norm_mant[18]), 
        .acc_mant_17_(norm_mant[17]), .acc_mant_16_(norm_mant[16]), 
        .acc_mant_15_(norm_mant[15]), .acc_mant_14_(norm_mant[14]), 
        .acc_mant_13_(norm_mant[13]), .acc_mant_12_(norm_mant[12]), 
        .acc_mant_11_(norm_mant[11]), .acc_mant_10_(norm_mant[10]), 
        .acc_mant_9_(norm_mant[9]), .acc_mant_8_(norm_mant[8]), .acc_mant_7_(
        norm_mant[7]), .acc_mant_6_(norm_mant[6]), .acc_mant_5_(norm_mant[5]), 
        .acc_mant_4_(norm_mant[4]), .acc_mant_3_(norm_mant[3]), .acc_mant_2_(
        norm_mant[2]), .acc_mant_1_(norm_mant[1]), .acc_mant_0_(norm_mant[0]), 
        .acc_mant_25__BAR(norm_mant[25]), .acc_mant_23_(norm_mant[23]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_sign_out_reg ( .D(out_result[7]), .CK(
        clk), .R(n1014), .Q(acc_sign) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_5_ ( .D(n_2_net__5_), .CK(
        clk), .R(n1014), .Q(acc_mant[5]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_20_ ( .D(n_2_net__20_), 
        .CK(clk), .R(n1014), .Q(acc_mant[20]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_0_ ( .D(n_1_net__0_), .CK(
        clk), .R(n1014), .Q(acc_exp[0]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_1_ ( .D(n_1_net__1_), .CK(
        clk), .R(n1014), .Q(acc_exp[1]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_2_ ( .D(n_1_net__2_), .CK(
        clk), .R(n1014), .Q(acc_exp[2]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_3_ ( .D(n_1_net__3_), .CK(
        clk), .R(n1014), .Q(acc_exp[3]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_4_ ( .D(n_1_net__4_), .CK(
        clk), .R(n1014), .Q(acc_exp[4]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_5_ ( .D(n_1_net__5_), .CK(
        clk), .R(n1014), .Q(acc_exp[5]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_6_ ( .D(n_1_net__6_), .CK(
        clk), .R(n1014), .Q(acc_exp[6]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_7_ ( .D(n_1_net__7_), .CK(
        clk), .R(n1014), .Q(acc_exp[7]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_0_ ( .D(n_2_net__0_), .CK(
        clk), .R(n1014), .Q(acc_mant[0]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_1_ ( .D(n_2_net__1_), .CK(
        clk), .R(n1014), .Q(acc_mant[1]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_2_ ( .D(n_2_net__2_), .CK(
        clk), .R(n1014), .Q(acc_mant[2]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_3_ ( .D(n_2_net__3_), .CK(
        clk), .R(n1014), .Q(acc_mant[3]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_4_ ( .D(n_2_net__4_), .CK(
        clk), .R(n1014), .Q(acc_mant[4]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_6_ ( .D(n_2_net__6_), .CK(
        clk), .R(n1014), .Q(acc_mant[6]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_7_ ( .D(n_2_net__7_), .CK(
        clk), .R(n1014), .Q(acc_mant[7]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_8_ ( .D(n_2_net__8_), .CK(
        clk), .R(n1014), .Q(acc_mant[8]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_9_ ( .D(n_2_net__9_), .CK(
        clk), .R(n1014), .Q(acc_mant[9]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_10_ ( .D(n_2_net__10_), 
        .CK(clk), .R(n1014), .Q(acc_mant[10]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_11_ ( .D(n_2_net__11_), 
        .CK(clk), .R(n1014), .Q(acc_mant[11]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_12_ ( .D(n_2_net__12_), 
        .CK(clk), .R(n1014), .Q(acc_mant[12]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_13_ ( .D(n_2_net__13_), 
        .CK(clk), .R(n1014), .Q(acc_mant[13]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_14_ ( .D(n_2_net__14_), 
        .CK(clk), .R(n1014), .Q(acc_mant[14]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_15_ ( .D(n_2_net__15_), 
        .CK(clk), .R(n1014), .Q(acc_mant[15]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_16_ ( .D(n_2_net__16_), 
        .CK(clk), .R(n1014), .Q(acc_mant[16]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_17_ ( .D(n_2_net__17_), 
        .CK(clk), .R(n1014), .Q(acc_mant[17]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_18_ ( .D(n_2_net__18_), 
        .CK(clk), .R(n1014), .Q(acc_mant[18]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_19_ ( .D(n_2_net__19_), 
        .CK(clk), .R(n1014), .Q(acc_mant[19]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_21_ ( .D(n_2_net__21_), 
        .CK(clk), .R(n1014), .Q(acc_mant[21]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_22_ ( .D(n_2_net__22_), 
        .CK(clk), .R(n1014), .Q(acc_mant[22]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_23_ ( .D(n_2_net__23_), 
        .CK(clk), .R(n1014), .Q(acc_mant[23]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_24_ ( .D(n_2_net__24_), 
        .CK(clk), .R(n1014), .Q(acc_mant[24]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_25_ ( .D(n_2_net__25_), 
        .CK(clk), .R(n1014), .Q(acc_mant[25]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_26_ ( .D(n_2_net__26_), 
        .CK(clk), .R(n1014), .Q(acc_mant[26]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_27_ ( .D(n_2_net__27_), 
        .CK(clk), .R(n1014), .Q(acc_mant[27]) );
  ADDF_X1M_A9TR intadd_0_U4 ( .A(n206), .B(n200), .CI(intadd_0_CI), .CO(
        intadd_0_n3), .S(u_multiplier_N1) );
  ADDF_X1M_A9TR intadd_0_U3 ( .A(n214), .B(n211), .CI(intadd_0_n3), .CO(
        intadd_0_n2), .S(u_multiplier_N2) );
  ADDF_X1M_A9TR intadd_0_U2 ( .A(n209), .B(n203), .CI(intadd_0_n2), .CO(
        intadd_0_n1), .S(u_multiplier_N3) );
  NOR2_X1B_A9TR U300 ( .A(n426), .B(n719), .Y(n575) );
  INV_X1B_A9TR U301 ( .A(n638), .Y(n570) );
  INV_X2M_A9TR U302 ( .A(n215), .Y(n380) );
  BUF_X2M_A9TR U303 ( .A(acc_clear), .Y(n223) );
  INV_X2M_A9TR U304 ( .A(n199), .Y(n220) );
  INV_X2M_A9TR U305 ( .A(n202), .Y(n820) );
  INV_X2M_A9TR U306 ( .A(n205), .Y(n221) );
  INV_X2M_A9TR U307 ( .A(n208), .Y(n222) );
  INV_X1B_A9TR U308 ( .A(n213), .Y(n240) );
  INV_X1B_A9TR U309 ( .A(n211), .Y(n241) );
  INV_X2M_A9TR U310 ( .A(n210), .Y(n211) );
  INV_X2M_A9TR U311 ( .A(in_b[5]), .Y(n210) );
  INV_X1P2M_A9TR U312 ( .A(in_b[4]), .Y(n198) );
  INV_X1M_A9TR U313 ( .A(n198), .Y(n199) );
  INV_X1P2M_A9TR U314 ( .A(in_b[6]), .Y(n201) );
  INV_X1M_A9TR U315 ( .A(n201), .Y(n202) );
  INV_X1P2M_A9TR U316 ( .A(in_a[4]), .Y(n204) );
  INV_X1P2M_A9TR U317 ( .A(in_a[5]), .Y(n212) );
  INV_X1P2M_A9TR U318 ( .A(in_a[6]), .Y(n207) );
  INV_X1M_A9TR U319 ( .A(n204), .Y(n205) );
  INV_X1M_A9TR U320 ( .A(n207), .Y(n208) );
  AND2_X2M_A9TR U321 ( .A(n328), .B(n821), .Y(n243) );
  NAND4_X1A_A9TR U322 ( .A(n241), .B(n220), .C(n820), .D(n821), .Y(n328) );
  INV_X2M_A9TR U323 ( .A(in_b[3]), .Y(n821) );
  NAND4_X1A_A9TR U324 ( .A(n240), .B(n221), .C(n222), .D(n819), .Y(n326) );
  AND2_X2M_A9TR U325 ( .A(n326), .B(n819), .Y(n242) );
  INV_X1P2M_A9TR U326 ( .A(in_a[3]), .Y(n819) );
  INV_X1M_A9TR U327 ( .A(n212), .Y(n213) );
  INV_X0P5B_A9TR U328 ( .A(n220), .Y(n200) );
  INV_X0P5B_A9TR U329 ( .A(n820), .Y(n203) );
  INV_X0P5B_A9TR U330 ( .A(n221), .Y(n206) );
  INV_X0P5B_A9TR U331 ( .A(n222), .Y(n209) );
  INV_X0P5B_A9TR U332 ( .A(n240), .Y(n214) );
  INV_X0P5B_A9TR U333 ( .A(n367), .Y(n371) );
  INV_X0P5B_A9TR U334 ( .A(n382), .Y(n525) );
  INV_X0P5B_A9TR U335 ( .A(u_multiplier_N3), .Y(n251) );
  INV_X0P5B_A9TR U336 ( .A(n840), .Y(n789) );
  INV_X0P5B_A9TR U337 ( .A(n834), .Y(n794) );
  INV_X0P5B_A9TR U338 ( .A(n754), .Y(n720) );
  OAI21_X1M_A9TR U339 ( .A0(n818), .A1(n817), .B0(n816), .Y(n828) );
  NOR2_X4A_A9TR U340 ( .A(n828), .B(n827), .Y(n832) );
  OR2_X1M_A9TR U341 ( .A(fp8_result[2]), .B(n1002), .Y(out_result[2]) );
  XOR2_X0P7M_A9TR U342 ( .A(n1000), .B(n999), .Y(n1001) );
  AO22_X0P5M_A9TR U343 ( .A0(n832), .A1(n865), .B0(n864), .B1(n991), .Y(n973)
         );
  AO22_X0P5M_A9TR U344 ( .A0(n991), .A1(n874), .B0(n873), .B1(n832), .Y(n875)
         );
  AO22_X0P5M_A9TR U345 ( .A0(n991), .A1(n871), .B0(n870), .B1(n832), .Y(n872)
         );
  AO22_X0P5M_A9TR U346 ( .A0(n832), .A1(n874), .B0(n873), .B1(n991), .Y(n938)
         );
  AO22_X0P5M_A9TR U347 ( .A0(n991), .A1(n865), .B0(n864), .B1(n832), .Y(n866)
         );
  AO22_X0P5M_A9TR U348 ( .A0(n991), .A1(n877), .B0(n876), .B1(n832), .Y(n878)
         );
  AO22_X0P5M_A9TR U349 ( .A0(n991), .A1(n861), .B0(n860), .B1(n832), .Y(n863)
         );
  AO22_X0P5M_A9TR U350 ( .A0(n991), .A1(n868), .B0(n867), .B1(n832), .Y(n869)
         );
  INV_X5M_A9TR U351 ( .A(n832), .Y(n991) );
  NOR2_X1A_A9TR U352 ( .A(n700), .B(n521), .Y(n703) );
  NOR2_X0P5A_A9TR U353 ( .A(n661), .B(n625), .Y(n664) );
  NOR2_X0P5A_A9TR U354 ( .A(n435), .B(n689), .Y(n436) );
  NOR2_X0P7M_A9TR U355 ( .A(n867), .B(n685), .Y(n435) );
  NOR2_X1A_A9TR U356 ( .A(n743), .B(n784), .Y(n787) );
  NOR2_X0P7M_A9TR U357 ( .A(n848), .B(n780), .Y(n743) );
  INV_X0P6M_A9TR U358 ( .A(n877), .Y(n673) );
  NOR2_X1M_A9TR U359 ( .A(n833), .B(n794), .Y(n796) );
  NOR2_X1B_A9TR U360 ( .A(n839), .B(n789), .Y(n792) );
  NOR2_X1B_A9TR U361 ( .A(n870), .B(n678), .Y(n681) );
  INV_X0P7M_A9TR U362 ( .A(n861), .Y(n690) );
  INV_X0P7M_A9TR U363 ( .A(n846), .Y(n781) );
  OAI211_X0P7M_A9TR U364 ( .A0(n478), .A1(n767), .B0(n477), .C0(n476), .Y(n877) );
  INV_X1M_A9TR U365 ( .A(n865), .Y(n686) );
  INV_X0P6M_A9TR U366 ( .A(n874), .Y(n677) );
  INV_X0P7M_A9TR U367 ( .A(n871), .Y(n678) );
  OAI211_X0P7M_A9TR U368 ( .A0(n748), .A1(n644), .B0(n613), .C0(n612), .Y(n886) );
  INV_X0P6M_A9TR U369 ( .A(n830), .Y(n804) );
  AND2_X0P5B_A9TR U370 ( .A(n604), .B(n380), .Y(n885) );
  OAI222_X0P5M_A9TR U371 ( .A0(n445), .A1(n532), .B0(n496), .B1(n444), .C0(
        n446), .C1(n443), .Y(n582) );
  AO22_X0P5M_A9TR U372 ( .A0(n706), .A1(n215), .B0(n705), .B1(n380), .Y(n956)
         );
  INV_X0P6M_A9TR U373 ( .A(n753), .Y(n755) );
  AOI22_X0P5M_A9TR U374 ( .A0(n753), .A1(n571), .B0(n570), .B1(n461), .Y(n561)
         );
  NOR2XB_X0P5M_A9TR U375 ( .BN(n704), .A(n763), .Y(n705) );
  INV_X0P7M_A9TR U376 ( .A(n707), .Y(n708) );
  NAND2_X0P5A_A9TR U377 ( .A(n460), .B(n459), .Y(n649) );
  INV_X0P5B_A9TR U378 ( .A(n428), .Y(n473) );
  OR2_X1M_A9TR U379 ( .A(n767), .B(n532), .Y(n754) );
  NAND2B_X0P5M_A9TR U380 ( .AN(n532), .B(n502), .Y(n452) );
  NAND2_X2B_A9TR U381 ( .A(n570), .B(n385), .Y(n767) );
  OAI21_X0P5M_A9TR U382 ( .A0(acc_mant[16]), .A1(n457), .B0(n397), .Y(n515) );
  NOR2_X1B_A9TR U383 ( .A(n719), .B(n458), .Y(n577) );
  AOI21_X0P7M_A9TR U384 ( .A0(n415), .A1(n737), .B0(n387), .Y(n495) );
  OAI211_X0P7M_A9TR U385 ( .A0(n415), .A1(acc_mant[14]), .B0(n414), .C0(n413), 
        .Y(n608) );
  OAI21_X0P5M_A9TR U386 ( .A0(acc_mant[24]), .A1(n457), .B0(n394), .Y(n428) );
  OAI22_X1M_A9TR U387 ( .A0(n709), .A1(n458), .B0(n426), .B1(n715), .Y(n493)
         );
  AOI21_X0P7M_A9TR U388 ( .A0(n415), .A1(n762), .B0(n388), .Y(n494) );
  AOI21_X0P7M_A9TR U389 ( .A0(n415), .A1(n749), .B0(n383), .Y(n497) );
  OAI21_X0P5M_A9TR U390 ( .A0(n415), .A1(acc_mant[22]), .B0(n414), .Y(n388) );
  OAI21_X0P7M_A9TR U391 ( .A0(n415), .A1(acc_mant[24]), .B0(n414), .Y(n383) );
  OAI21_X0P5M_A9TR U392 ( .A0(n415), .A1(acc_mant[20]), .B0(n414), .Y(n387) );
  NOR2_X0P5A_A9TR U393 ( .A(n457), .B(acc_mant[18]), .Y(n400) );
  NOR2_X1M_A9TR U394 ( .A(n415), .B(n722), .Y(n425) );
  NOR2_X0P5A_A9TR U395 ( .A(n457), .B(acc_mant[20]), .Y(n398) );
  NAND2_X0P7A_A9TR U396 ( .A(n457), .B(n414), .Y(n458) );
  OAI21_X0P5M_A9TR U397 ( .A0(n415), .A1(acc_mant[18]), .B0(n414), .Y(n389) );
  INV_X2M_A9TR U398 ( .A(n381), .Y(n415) );
  INV_X1M_A9TR U399 ( .A(n395), .Y(n719) );
  NAND2_X0P5A_A9TR U400 ( .A(n324), .B(n323), .Y(n325) );
  INV_X0P6M_A9TR U401 ( .A(n372), .Y(n374) );
  INV_X0P7M_A9TR U402 ( .A(n322), .Y(n324) );
  MXT2_X0P7M_A9TR U403 ( .A(n278), .B(intadd_0_n1), .S0(n215), .Y(n293) );
  NAND2B_X1M_A9TR U404 ( .AN(n294), .B(n215), .Y(n302) );
  INV_X6M_A9TR U405 ( .A(n275), .Y(n215) );
  NOR2_X0P5A_A9TR U406 ( .A(n247), .B(n246), .Y(n249) );
  INV_X0P6M_A9TR U407 ( .A(u_multiplier_N2), .Y(n246) );
  NAND2_X0P5A_A9TR U408 ( .A(u_multiplier_N1), .B(n283), .Y(n318) );
  INV_X1M_A9TR U409 ( .A(n862), .Y(n827) );
  OR2_X1M_A9TR U410 ( .A(fp8_result[3]), .B(n1002), .Y(out_result[3]) );
  OR2_X1M_A9TR U411 ( .A(fp8_result[5]), .B(n1002), .Y(out_result[5]) );
  BUF_X7P5M_A9TR U412 ( .A(n1001), .Y(adder_mant[28]) );
  ADDF_X1M_A9TR U413 ( .A(n976), .B(n975), .CI(n974), .CO(n977), .S(
        adder_mant[12]) );
  AO22_X0P5M_A9TR U414 ( .A0(n832), .A1(n868), .B0(n867), .B1(n991), .Y(n979)
         );
  AO22_X0P5M_A9TR U415 ( .A0(n991), .A1(n904), .B0(n903), .B1(n832), .Y(n905)
         );
  AO22_X0P5M_A9TR U416 ( .A0(n832), .A1(n871), .B0(n870), .B1(n991), .Y(n976)
         );
  AO22_X0P5M_A9TR U417 ( .A0(n832), .A1(n904), .B0(n903), .B1(n991), .Y(n953)
         );
  AO22_X0P5M_A9TR U418 ( .A0(n991), .A1(n858), .B0(n857), .B1(n832), .Y(n859)
         );
  AO22_X0P5M_A9TR U419 ( .A0(n832), .A1(n907), .B0(n906), .B1(n991), .Y(n955)
         );
  AO22_X0P5M_A9TR U420 ( .A0(n832), .A1(n880), .B0(n879), .B1(n991), .Y(n944)
         );
  AO22_X0P5M_A9TR U421 ( .A0(n832), .A1(n877), .B0(n876), .B1(n991), .Y(n941)
         );
  AO22_X0P5M_A9TR U422 ( .A0(n832), .A1(n895), .B0(n894), .B1(n991), .Y(n964)
         );
  AO22_X0P5M_A9TR U423 ( .A0(n991), .A1(n901), .B0(n900), .B1(n832), .Y(n902)
         );
  AO22_X0P5M_A9TR U424 ( .A0(n991), .A1(n880), .B0(n879), .B1(n832), .Y(n881)
         );
  AO22_X0P5M_A9TR U425 ( .A0(n832), .A1(n892), .B0(n891), .B1(n991), .Y(n950)
         );
  AO22_X0P5M_A9TR U426 ( .A0(n832), .A1(n898), .B0(n897), .B1(n991), .Y(n970)
         );
  AO22_X0P5M_A9TR U427 ( .A0(n991), .A1(n883), .B0(n882), .B1(n832), .Y(n884)
         );
  AO22_X0P5M_A9TR U428 ( .A0(n832), .A1(n889), .B0(n888), .B1(n991), .Y(n947)
         );
  AO22_X0P5M_A9TR U429 ( .A0(n832), .A1(n886), .B0(n885), .B1(n991), .Y(n985)
         );
  AO22_X0P5M_A9TR U430 ( .A0(n832), .A1(n883), .B0(n882), .B1(n991), .Y(n982)
         );
  AO22_X0P5M_A9TR U431 ( .A0(n991), .A1(n892), .B0(n891), .B1(n832), .Y(n893)
         );
  AO22_X0P5M_A9TR U432 ( .A0(n991), .A1(n886), .B0(n885), .B1(n832), .Y(n887)
         );
  AO22_X0P5M_A9TR U433 ( .A0(n991), .A1(n895), .B0(n894), .B1(n832), .Y(n896)
         );
  AO22_X0P5M_A9TR U434 ( .A0(n991), .A1(n889), .B0(n888), .B1(n832), .Y(n890)
         );
  AO22_X0P5M_A9TR U435 ( .A0(n832), .A1(n901), .B0(n900), .B1(n991), .Y(n967)
         );
  AO22_X0P5M_A9TR U436 ( .A0(n991), .A1(n898), .B0(n897), .B1(n832), .Y(n899)
         );
  OAI21_X1M_A9TR U437 ( .A0(n667), .A1(n666), .B0(n665), .Y(n702) );
  AOI21_X0P7M_A9TR U438 ( .A0(n684), .A1(n683), .B0(n682), .Y(n699) );
  AOI21_X0P7M_A9TR U439 ( .A0(n664), .A1(n663), .B0(n662), .Y(n665) );
  AOI21_X1M_A9TR U440 ( .A0(n697), .A1(n696), .B0(n695), .Y(n698) );
  NAND2_X1A_A9TR U441 ( .A(n697), .B(n436), .Y(n700) );
  NOR2_X1A_A9TR U442 ( .A(n771), .B(n792), .Y(n772) );
  OAI21_X0P7M_A9TR U443 ( .A0(n784), .A1(n783), .B0(n782), .Y(n785) );
  NOR2_X1A_A9TR U444 ( .A(n404), .B(n693), .Y(n697) );
  OAI21_X1M_A9TR U445 ( .A0(n694), .A1(n693), .B0(n692), .Y(n695) );
  NOR2_X0P5A_A9TR U446 ( .A(n891), .B(n653), .Y(n656) );
  OAI21_X0P7M_A9TR U447 ( .A0(n792), .A1(n791), .B0(n790), .Y(n799) );
  NOR2_X0P5A_A9TR U448 ( .A(n888), .B(n657), .Y(n625) );
  OAI211_X0P5M_A9TR U449 ( .A0(n726), .A1(n588), .B0(n587), .C0(n586), .Y(n904) );
  NOR2_X0P7M_A9TR U450 ( .A(n885), .B(n658), .Y(n661) );
  NAND2_X0P7A_A9TR U451 ( .A(n808), .B(n716), .Y(n723) );
  NOR2_X0P5A_A9TR U452 ( .A(n897), .B(n594), .Y(n597) );
  NOR2_X1B_A9TR U453 ( .A(n857), .B(n691), .Y(n693) );
  OAI21_X0P5M_A9TR U454 ( .A0(n564), .A1(n581), .B0(n563), .Y(n907) );
  INV_X0P6M_A9TR U455 ( .A(n889), .Y(n657) );
  INV_X0P6M_A9TR U456 ( .A(n868), .Y(n685) );
  AO21B_X0P5M_A9TR U457 ( .A0(n649), .A1(n648), .B0N(n647), .Y(n895) );
  OAI211_X0P5M_A9TR U458 ( .A0(n730), .A1(n588), .B0(n551), .C0(n550), .Y(n901) );
  AND2_X0P5B_A9TR U459 ( .A(n956), .B(n805), .Y(n806) );
  INV_X0P6M_A9TR U460 ( .A(n886), .Y(n658) );
  NOR2_X0P7M_A9TR U461 ( .A(n860), .B(n690), .Y(n404) );
  NOR2_X1B_A9TR U462 ( .A(n864), .B(n686), .Y(n689) );
  AND2_X0P5B_A9TR U463 ( .A(n882), .B(n668), .Y(n671) );
  OAI211_X0P5M_A9TR U464 ( .A0(n761), .A1(n644), .B0(n637), .C0(n636), .Y(n892) );
  INV_X1M_A9TR U465 ( .A(n858), .Y(n691) );
  INV_X1M_A9TR U466 ( .A(n990), .Y(n809) );
  OAI211_X0P5M_A9TR U467 ( .A0(n582), .A1(n767), .B0(n450), .C0(n449), .Y(n880) );
  OAI211_X0P5M_A9TR U468 ( .A0(n736), .A1(n588), .B0(n538), .C0(n537), .Y(n898) );
  OAI22_X0P5M_A9TR U469 ( .A0(n731), .A1(n769), .B0(n730), .B1(n735), .Y(n852)
         );
  INV_X1M_A9TR U470 ( .A(n957), .Y(n805) );
  OAI211_X0P5M_A9TR U471 ( .A0(n768), .A1(n644), .B0(n624), .C0(n623), .Y(n889) );
  OAI22_X1M_A9TR U472 ( .A0(n403), .A1(n769), .B0(n561), .B1(n735), .Y(n858)
         );
  AO22_X0P5M_A9TR U473 ( .A0(n766), .A1(n215), .B0(n765), .B1(n380), .Y(n839)
         );
  AO22_X0P5M_A9TR U474 ( .A0(n760), .A1(n215), .B0(n759), .B1(n380), .Y(n842)
         );
  AO22_X0P5M_A9TR U475 ( .A0(n747), .A1(n215), .B0(n746), .B1(n380), .Y(n836)
         );
  OAI211_X0P5M_A9TR U476 ( .A0(n564), .A1(n767), .B0(n463), .C0(n462), .Y(n883) );
  OAI211_X0P5M_A9TR U477 ( .A0(n534), .A1(n767), .B0(n501), .C0(n500), .Y(n874) );
  AOI22_X0P5M_A9TR U478 ( .A0(n542), .A1(n570), .B0(n707), .B1(n571), .Y(n730)
         );
  AND2_X0P7M_A9TR U479 ( .A(n505), .B(n380), .Y(n870) );
  OAI22_X0P5M_A9TR U480 ( .A0(n737), .A1(n769), .B0(n736), .B1(n735), .Y(n849)
         );
  AO22_X0P5M_A9TR U481 ( .A0(n712), .A1(n215), .B0(n711), .B1(n380), .Y(n829)
         );
  AO22_X0P5M_A9TR U482 ( .A0(n740), .A1(n215), .B0(n739), .B1(n380), .Y(n845)
         );
  OAI22_X1M_A9TR U483 ( .A0(n769), .A1(n756), .B0(n755), .B1(n754), .Y(n834)
         );
  INV_X0P5B_A9TR U484 ( .A(n631), .Y(n445) );
  NAND3_X1A_A9TR U485 ( .A(n720), .B(n719), .C(n718), .Y(n721) );
  AOI222_X1M_A9TR U486 ( .A0(n753), .A1(n532), .B0(n508), .B1(n382), .C0(n507), 
        .C1(n506), .Y(n741) );
  AOI22_X0P5M_A9TR U487 ( .A0(n718), .A1(n527), .B0(n526), .B1(n570), .Y(n736)
         );
  AOI222_X0P7M_A9TR U488 ( .A0(n515), .A1(n471), .B0(n531), .B1(n618), .C0(
        n470), .C1(n516), .Y(n549) );
  NOR2_X0P7M_A9TR U489 ( .A(n639), .B(n638), .Y(n738) );
  OAI21_X0P5M_A9TR U490 ( .A0(n533), .A1(n754), .B0(n769), .Y(n585) );
  INV_X0P5B_A9TR U491 ( .A(n648), .Y(n630) );
  NOR2_X0P7M_A9TR U492 ( .A(n602), .B(n638), .Y(n745) );
  OAI21_X0P5M_A9TR U493 ( .A0(n558), .A1(n579), .B0(n557), .Y(n559) );
  NOR2_X0P5A_A9TR U494 ( .A(n509), .B(n525), .Y(n514) );
  INV_X1M_A9TR U495 ( .A(n572), .Y(n533) );
  NOR2_X1B_A9TR U496 ( .A(n767), .B(n531), .Y(n648) );
  OAI22_X0P5M_A9TR U497 ( .A0(n508), .A1(n511), .B0(n510), .B1(n525), .Y(n474)
         );
  NOR3_X0P5A_A9TR U498 ( .A(n644), .B(n525), .C(n491), .Y(n492) );
  INV_X0P5B_A9TR U499 ( .A(n487), .Y(n605) );
  INV_X0P5B_A9TR U500 ( .A(n608), .Y(n444) );
  OAI22_X0P5M_A9TR U501 ( .A0(n497), .A1(n496), .B0(n495), .B1(n525), .Y(n498)
         );
  INV_X0P5B_A9TR U502 ( .A(n512), .Y(n470) );
  AOI211_X0P7M_A9TR U503 ( .A0(n457), .A1(n456), .B0(n223), .C0(n455), .Y(n509) );
  OAI211_X0P5M_A9TR U504 ( .A0(n415), .A1(acc_mant[16]), .B0(n414), .C0(n386), 
        .Y(n486) );
  AOI21_X0P7M_A9TR U505 ( .A0(n415), .A1(n727), .B0(n389), .Y(n490) );
  INV_X0P5B_A9TR U506 ( .A(n425), .Y(n427) );
  NOR2_X0P5A_A9TR U507 ( .A(n525), .B(n570), .Y(n527) );
  NOR2_X0P7M_A9TR U508 ( .A(n644), .B(n532), .Y(n472) );
  AOI21_X0P5M_A9TR U509 ( .A0(n457), .A1(n715), .B0(n223), .Y(n394) );
  INV_X0P6M_A9TR U510 ( .A(n496), .Y(n516) );
  NAND2_X1A_A9TR U511 ( .A(n415), .B(n414), .Y(n426) );
  NOR2_X0P5A_A9TR U512 ( .A(n457), .B(acc_mant[22]), .Y(n399) );
  INV_X0P5B_A9TR U513 ( .A(n532), .Y(n531) );
  OR2_X1M_A9TR U514 ( .A(n763), .B(n380), .Y(n735) );
  AND2_X0P5B_A9TR U515 ( .A(n763), .B(n215), .Y(n528) );
  NOR3BB_X3M_A9TR U516 ( .AN(n231), .BN(n314), .C(n228), .Y(n377) );
  XNOR2_X0P7M_A9TR U517 ( .A(n368), .B(n371), .Y(n224) );
  INV_X1M_A9TR U518 ( .A(n281), .Y(n279) );
  MXIT2_X0P7M_A9TR U519 ( .A(intadd_0_n1), .B(n278), .S0(n215), .Y(n232) );
  MXT2_X0P5M_A9TR U520 ( .A(n276), .B(u_multiplier_N3), .S0(n215), .Y(n280) );
  MXT2_X0P5M_A9TR U521 ( .A(n277), .B(u_multiplier_N2), .S0(n215), .Y(n282) );
  AND2_X0P5B_A9TR U522 ( .A(n215), .B(n305), .Y(n306) );
  MXIT2_X0P7M_A9TR U523 ( .A(n285), .B(n284), .S0(n215), .Y(n236) );
  AO21_X2M_A9TR U524 ( .A0(n274), .A1(n273), .B0(n272), .Y(n275) );
  NOR2_X1A_A9TR U525 ( .A(n260), .B(n1008), .Y(n259) );
  INV_X1M_A9TR U526 ( .A(intadd_0_n1), .Y(n1008) );
  NAND2_X0P5A_A9TR U527 ( .A(n319), .B(n318), .Y(n321) );
  NOR2_X0P7M_A9TR U528 ( .A(u_multiplier_N1), .B(n283), .Y(n317) );
  INV_X1M_A9TR U529 ( .A(u_multiplier_N1), .Y(n1003) );
  NOR2_X1A_A9TR U530 ( .A(n263), .B(n294), .Y(n257) );
  NOR2_X0P5A_A9TR U531 ( .A(n356), .B(n341), .Y(n347) );
  NOR2_X0P5A_A9TR U532 ( .A(n356), .B(n355), .Y(n365) );
  INV_X1M_A9TR U533 ( .A(n300), .Y(n263) );
  INV_X1M_A9TR U534 ( .A(n294), .Y(n261) );
  NOR2B_X0P7M_A9TR U535 ( .AN(acc_exp[1]), .B(n223), .Y(n283) );
  NOR2B_X0P7M_A9TR U536 ( .AN(acc_exp[0]), .B(n223), .Y(n284) );
  INV_X0P6M_A9TR U537 ( .A(n223), .Y(n414) );
  NOR2_X0P5A_A9TR U538 ( .A(n340), .B(n345), .Y(n338) );
  NOR2_X0P5A_A9TR U539 ( .A(n340), .B(n329), .Y(n316) );
  NOR2_X0P5A_A9TR U540 ( .A(n327), .B(n341), .Y(n315) );
  NOR2_X0P5A_A9TR U541 ( .A(n340), .B(n341), .Y(n331) );
  NOR2_X0P5A_A9TR U542 ( .A(n346), .B(n329), .Y(n330) );
  NOR2B_X2M_A9TR U543 ( .AN(fp8_result[0]), .B(n1002), .Y(out_result[0]) );
  NOR2XB_X0P5M_A9TR U544 ( .BN(norm_mant[27]), .A(n1002), .Y(n_2_net__27_) );
  NOR2XB_X0P5M_A9TR U545 ( .BN(norm_mant[24]), .A(n1002), .Y(n_2_net__24_) );
  ADDF_X1M_A9TR U546 ( .A(n973), .B(n972), .CI(n971), .CO(n933), .S(
        adder_mant[14]) );
  ADDF_X1M_A9TR U547 ( .A(n979), .B(n978), .CI(n977), .CO(n971), .S(
        adder_mant[13]) );
  ADDF_X1M_A9TR U548 ( .A(n982), .B(n981), .CI(n980), .CO(n942), .S(
        adder_mant[8]) );
  XOR2_X0P5M_A9TR U549 ( .A(n908), .B(n999), .Y(n954) );
  AO22_X0P5M_A9TR U550 ( .A0(n991), .A1(n907), .B0(n906), .B1(n832), .Y(n908)
         );
  AO22_X0P5M_A9TR U551 ( .A0(n991), .A1(n852), .B0(n851), .B1(n832), .Y(n853)
         );
  AO22_X0P5M_A9TR U552 ( .A0(n991), .A1(n855), .B0(n854), .B1(n832), .Y(n856)
         );
  AO22_X0P5M_A9TR U553 ( .A0(n832), .A1(n852), .B0(n851), .B1(n991), .Y(n926)
         );
  AO22_X0P5M_A9TR U554 ( .A0(n991), .A1(n849), .B0(n848), .B1(n832), .Y(n850)
         );
  AO22_X0P5M_A9TR U555 ( .A0(n832), .A1(n858), .B0(n857), .B1(n991), .Y(n932)
         );
  AO22_X0P5M_A9TR U556 ( .A0(n832), .A1(n861), .B0(n860), .B1(n991), .Y(n935)
         );
  AO22_X0P5M_A9TR U557 ( .A0(n832), .A1(n855), .B0(n854), .B1(n991), .Y(n929)
         );
  AO22_X0P5M_A9TR U558 ( .A0(n991), .A1(n846), .B0(n845), .B1(n832), .Y(n847)
         );
  AO22_X0P5M_A9TR U559 ( .A0(n832), .A1(n846), .B0(n845), .B1(n991), .Y(n923)
         );
  AO22_X0P5M_A9TR U560 ( .A0(n832), .A1(n830), .B0(n829), .B1(n991), .Y(n961)
         );
  AO22_X0P5M_A9TR U561 ( .A0(n832), .A1(n843), .B0(n842), .B1(n991), .Y(n920)
         );
  AO22_X0P5M_A9TR U562 ( .A0(n832), .A1(n849), .B0(n848), .B1(n991), .Y(n988)
         );
  AO22_X0P5M_A9TR U563 ( .A0(n832), .A1(n834), .B0(n833), .B1(n991), .Y(n911)
         );
  AO22_X0P5M_A9TR U564 ( .A0(n832), .A1(n837), .B0(n836), .B1(n991), .Y(n914)
         );
  AO22_X0P5M_A9TR U565 ( .A0(n832), .A1(n840), .B0(n839), .B1(n991), .Y(n917)
         );
  AOI21_X0P5M_A9TR U566 ( .A0(n600), .A1(n599), .B0(n598), .Y(n667) );
  NAND2_X0P5A_A9TR U567 ( .A(n664), .B(n651), .Y(n666) );
  NAND2_X0P5A_A9TR U568 ( .A(n520), .B(n683), .Y(n521) );
  NOR2_X1A_A9TR U569 ( .A(n773), .B(n802), .Y(n774) );
  OAI21_X0P5M_A9TR U570 ( .A0(n592), .A1(n591), .B0(n590), .Y(n599) );
  NOR2_X0P5A_A9TR U571 ( .A(n903), .B(n589), .Y(n591) );
  NOR2_X0P5A_A9TR U572 ( .A(n656), .B(n650), .Y(n651) );
  NOR2_X0P5A_A9TR U573 ( .A(n597), .B(n552), .Y(n600) );
  OAI21_X0P5M_A9TR U574 ( .A0(n676), .A1(n675), .B0(n674), .Y(n684) );
  OAI21_X0P5M_A9TR U575 ( .A0(n597), .A1(n596), .B0(n595), .Y(n598) );
  NOR2_X0P5A_A9TR U576 ( .A(n479), .B(n675), .Y(n520) );
  NAND2_X0P5A_A9TR U577 ( .A(n903), .B(n589), .Y(n590) );
  OAI21_X0P5M_A9TR U578 ( .A0(n656), .A1(n655), .B0(n654), .Y(n663) );
  NOR2_X0P5A_A9TR U579 ( .A(n894), .B(n652), .Y(n650) );
  NAND2_X0P5A_A9TR U580 ( .A(n900), .B(n593), .Y(n596) );
  NOR2_X1A_A9TR U581 ( .A(n723), .B(n811), .Y(n814) );
  OAI21_X0P5M_A9TR U582 ( .A0(n661), .A1(n660), .B0(n659), .Y(n662) );
  OAI21_X0P5M_A9TR U583 ( .A0(n689), .A1(n688), .B0(n687), .Y(n696) );
  NOR2_X0P5A_A9TR U584 ( .A(n906), .B(n565), .Y(n592) );
  NOR2_X0P5A_A9TR U585 ( .A(n900), .B(n593), .Y(n552) );
  AOI21_X0P5M_A9TR U586 ( .A0(n672), .A1(n671), .B0(n670), .Y(n676) );
  NAND2_X0P5A_A9TR U587 ( .A(n894), .B(n652), .Y(n655) );
  NAND2_X0P5A_A9TR U588 ( .A(n672), .B(n464), .Y(n479) );
  OAI21_X0P5M_A9TR U589 ( .A0(n779), .A1(n778), .B0(n777), .Y(n786) );
  NOR2_X1A_A9TR U590 ( .A(n757), .B(n796), .Y(n800) );
  NOR2_X0P7M_A9TR U591 ( .A(n519), .B(n681), .Y(n683) );
  NAND2_X0P5A_A9TR U592 ( .A(n867), .B(n685), .Y(n688) );
  NAND2_X0P5A_A9TR U593 ( .A(n885), .B(n658), .Y(n659) );
  NAND2_X0P5A_A9TR U594 ( .A(n897), .B(n594), .Y(n595) );
  NAND2_X0P5A_A9TR U595 ( .A(n851), .B(n776), .Y(n777) );
  NOR2_X0P7M_A9TR U596 ( .A(n876), .B(n673), .Y(n675) );
  OAI21_X0P5M_A9TR U597 ( .A0(n681), .A1(n680), .B0(n679), .Y(n682) );
  NAND2_X0P5A_A9TR U598 ( .A(n888), .B(n657), .Y(n660) );
  NAND2_X0P5A_A9TR U599 ( .A(n876), .B(n673), .Y(n674) );
  AND2_X0P5B_A9TR U600 ( .A(n879), .B(n669), .Y(n670) );
  NAND2_X0P5A_A9TR U601 ( .A(n891), .B(n653), .Y(n654) );
  NOR2_X0P7M_A9TR U602 ( .A(n851), .B(n776), .Y(n779) );
  OR2_X0P7M_A9TR U603 ( .A(n879), .B(n669), .Y(n672) );
  NAND2_X0P5A_A9TR U604 ( .A(n842), .B(n788), .Y(n791) );
  AOI211_X0P5M_A9TR U605 ( .A0(acc_mant[1]), .A1(n585), .B0(n584), .C0(n583), 
        .Y(n586) );
  NAND2_X0P5A_A9TR U606 ( .A(n860), .B(n690), .Y(n694) );
  NOR2_X0P5A_A9TR U607 ( .A(n873), .B(n677), .Y(n519) );
  NAND2_X0P5A_A9TR U608 ( .A(n870), .B(n678), .Y(n679) );
  NAND2_X0P5A_A9TR U609 ( .A(n839), .B(n789), .Y(n790) );
  NAND2_X0P5A_A9TR U610 ( .A(n833), .B(n794), .Y(n795) );
  NAND2_X0P5A_A9TR U611 ( .A(n845), .B(n781), .Y(n782) );
  NAND2_X0P5A_A9TR U612 ( .A(n854), .B(n775), .Y(n778) );
  OR2_X0P7M_A9TR U613 ( .A(n882), .B(n668), .Y(n464) );
  NOR2_X1M_A9TR U614 ( .A(n845), .B(n781), .Y(n784) );
  NAND2_X0P5A_A9TR U615 ( .A(n857), .B(n691), .Y(n692) );
  NAND2_X0P5A_A9TR U616 ( .A(n873), .B(n677), .Y(n680) );
  OR2_X0P7M_A9TR U617 ( .A(n829), .B(n804), .Y(n716) );
  NOR2_X0P5A_A9TR U618 ( .A(n854), .B(n775), .Y(n732) );
  INV_X0P6M_A9TR U619 ( .A(n852), .Y(n776) );
  NAND2_X0P5A_A9TR U620 ( .A(n864), .B(n686), .Y(n687) );
  AND2_X0P5B_A9TR U621 ( .A(n829), .B(n804), .Y(n807) );
  NAND2_X0P5A_A9TR U622 ( .A(n848), .B(n780), .Y(n783) );
  NOR2_X0P5A_A9TR U623 ( .A(n582), .B(n581), .Y(n583) );
  AOI21_X0P5M_A9TR U624 ( .A0(n648), .A1(n646), .B0(n562), .Y(n563) );
  AOI21_X0P5M_A9TR U625 ( .A0(n549), .A1(n641), .B0(n548), .Y(n550) );
  NAND2_X0P5A_A9TR U626 ( .A(n836), .B(n793), .Y(n797) );
  INV_X0P6M_A9TR U627 ( .A(n843), .Y(n788) );
  INV_X0P6M_A9TR U628 ( .A(n849), .Y(n780) );
  OAI222_X0P5M_A9TR U629 ( .A0(n769), .A1(n456), .B0(n581), .B1(n761), .C0(
        n767), .C1(n418), .Y(n868) );
  AOI21_X0P5M_A9TR U630 ( .A0(n646), .A1(n720), .B0(n645), .Y(n647) );
  AND2_X0P5B_A9TR U631 ( .A(n640), .B(n380), .Y(n894) );
  AOI21_X0P5M_A9TR U632 ( .A0(n634), .A1(n641), .B0(n633), .Y(n637) );
  AND2_X0P5B_A9TR U633 ( .A(n629), .B(n380), .Y(n891) );
  NAND2_X0P5A_A9TR U634 ( .A(n542), .B(n641), .Y(n476) );
  AND2_X0P5B_A9TR U635 ( .A(n617), .B(n380), .Y(n888) );
  OAI222_X0P7M_A9TR U636 ( .A0(n769), .A1(n518), .B0(n581), .B1(n741), .C0(
        n767), .C1(n517), .Y(n871) );
  AND2_X0P5B_A9TR U637 ( .A(n734), .B(n380), .Y(n848) );
  AND2_X0P5B_A9TR U638 ( .A(n725), .B(n380), .Y(n854) );
  OAI21_X0P5M_A9TR U639 ( .A0(n741), .A1(n644), .B0(n643), .Y(n645) );
  AND2_X0P5B_A9TR U640 ( .A(n485), .B(n380), .Y(n873) );
  AOI21_X0P5M_A9TR U641 ( .A0(n641), .A1(n621), .B0(n620), .Y(n624) );
  AOI21_X0P5M_A9TR U642 ( .A0(n610), .A1(n641), .B0(n609), .Y(n613) );
  AOI21_X0P5M_A9TR U643 ( .A0(acc_mant[3]), .A1(n585), .B0(n536), .Y(n537) );
  OAI22_X0P5M_A9TR U644 ( .A0(n547), .A1(n754), .B0(n546), .B1(n545), .Y(n548)
         );
  AND2_X0P5B_A9TR U645 ( .A(n411), .B(n380), .Y(n867) );
  AND2_X0P5B_A9TR U646 ( .A(n441), .B(n380), .Y(n879) );
  AND2_X0P5B_A9TR U647 ( .A(n554), .B(n380), .Y(n906) );
  AND2_X0P5B_A9TR U648 ( .A(n469), .B(n380), .Y(n876) );
  AND2_X0P5B_A9TR U649 ( .A(n524), .B(n380), .Y(n897) );
  AND2_X0P5B_A9TR U650 ( .A(n729), .B(n380), .Y(n851) );
  AND2_X0P5B_A9TR U651 ( .A(n568), .B(n380), .Y(n903) );
  OAI22_X0P7M_A9TR U652 ( .A0(n742), .A1(n769), .B0(n741), .B1(n767), .Y(n846)
         );
  OAI22_X0P5M_A9TR U653 ( .A0(n727), .A1(n769), .B0(n726), .B1(n735), .Y(n855)
         );
  AND2_X0P5B_A9TR U654 ( .A(n454), .B(n380), .Y(n882) );
  AND2_X0P5B_A9TR U655 ( .A(n541), .B(n380), .Y(n900) );
  OAI222_X0P5M_A9TR U656 ( .A0(n769), .A1(n430), .B0(n581), .B1(n748), .C0(
        n767), .C1(n392), .Y(n861) );
  OAI21_X0P5M_A9TR U657 ( .A0(n561), .A1(n588), .B0(n560), .Y(n562) );
  OAI222_X0P5M_A9TR U658 ( .A0(n446), .A1(n512), .B0(n496), .B1(n509), .C0(
        n532), .C1(n649), .Y(n564) );
  NOR2XB_X0P5M_A9TR U659 ( .BN(n728), .A(n763), .Y(n729) );
  AOI22_X0P5M_A9TR U660 ( .A0(n720), .A1(n559), .B0(n585), .B1(acc_mant[0]), 
        .Y(n560) );
  AOI22_X0P5M_A9TR U661 ( .A0(n1011), .A1(acc_mant[8]), .B0(n753), .B1(n472), 
        .Y(n463) );
  AND2_X0P5B_A9TR U662 ( .A(n724), .B(n763), .Y(n568) );
  AOI22_X0P5M_A9TR U663 ( .A0(acc_mant[14]), .A1(n1011), .B0(n621), .B1(n433), 
        .Y(n434) );
  AOI211_X0P7M_A9TR U664 ( .A0(n382), .A1(n608), .B0(n417), .C0(n416), .Y(n634) );
  NOR2XB_X0P5M_A9TR U665 ( .BN(n710), .A(n763), .Y(n711) );
  NAND2_X0P5A_A9TR U666 ( .A(n635), .B(n648), .Y(n587) );
  NOR2XB_X0P5M_A9TR U667 ( .BN(n758), .A(n763), .Y(n759) );
  NAND2_X0P5A_A9TR U668 ( .A(n611), .B(n720), .Y(n612) );
  NAND2_X0P5A_A9TR U669 ( .A(n622), .B(n648), .Y(n551) );
  AOI22_X0P5M_A9TR U670 ( .A0(n713), .A1(n571), .B0(n570), .B1(n569), .Y(n726)
         );
  NOR2XB_X0P5M_A9TR U671 ( .BN(n410), .A(n763), .Y(n411) );
  NOR2XB_X0P5M_A9TR U672 ( .BN(n423), .A(n763), .Y(n424) );
  NOR2XB_X0P5M_A9TR U673 ( .BN(n738), .A(n763), .Y(n739) );
  NAND2_X0P5A_A9TR U674 ( .A(n569), .B(n641), .Y(n449) );
  AND2_X0P5B_A9TR U675 ( .A(n733), .B(n763), .Y(n524) );
  AND2_X0P5B_A9TR U676 ( .A(n553), .B(n763), .Y(n554) );
  NOR2XB_X0P5M_A9TR U677 ( .BN(n378), .A(n763), .Y(n379) );
  NAND2_X0P5A_A9TR U678 ( .A(n622), .B(n720), .Y(n623) );
  AND2_X0P5B_A9TR U679 ( .A(n728), .B(n763), .Y(n541) );
  NAND2_X0P5A_A9TR U680 ( .A(n611), .B(n648), .Y(n538) );
  NOR2XB_X0P5M_A9TR U681 ( .BN(n553), .A(n763), .Y(n393) );
  OAI22_X0P5M_A9TR U682 ( .A0(n769), .A1(n619), .B0(n618), .B1(n630), .Y(n620)
         );
  NOR2_X0P5A_A9TR U683 ( .A(n475), .B(n474), .Y(n542) );
  AND2_X0P5B_A9TR U684 ( .A(n738), .B(n763), .Y(n640) );
  OAI22_X0P5M_A9TR U685 ( .A0(n769), .A1(n632), .B0(n631), .B1(n630), .Y(n633)
         );
  OAI22_X0P5M_A9TR U686 ( .A0(n535), .A1(n754), .B0(n534), .B1(n581), .Y(n536)
         );
  INV_X0P7M_A9TR U687 ( .A(n837), .Y(n793) );
  NOR2XB_X0P5M_A9TR U688 ( .BN(n733), .A(n763), .Y(n734) );
  NAND2_X0P5A_A9TR U689 ( .A(n635), .B(n720), .Y(n636) );
  NOR2XB_X0P5M_A9TR U690 ( .BN(n724), .A(n763), .Y(n725) );
  AOI22_X0P5M_A9TR U691 ( .A0(n1011), .A1(acc_mant[4]), .B0(n642), .B1(n641), 
        .Y(n643) );
  NAND2_X0P5A_A9TR U692 ( .A(n526), .B(n641), .Y(n500) );
  NOR2XB_X0P5M_A9TR U693 ( .BN(n504), .A(n763), .Y(n505) );
  NOR2XB_X0P5M_A9TR U694 ( .BN(n764), .A(n763), .Y(n765) );
  NOR2XB_X0P5M_A9TR U695 ( .BN(n745), .A(n763), .Y(n746) );
  AOI22_X0P5M_A9TR U696 ( .A0(n1011), .A1(acc_mant[10]), .B0(n707), .B1(n472), 
        .Y(n477) );
  OAI22_X0P5M_A9TR U697 ( .A0(n495), .A1(n446), .B0(n443), .B1(n511), .Y(n416)
         );
  NOR2XB_X0P5M_A9TR U698 ( .BN(n638), .A(n639), .Y(n504) );
  AOI222_X0P7M_A9TR U699 ( .A0(n395), .A1(n605), .B0(n572), .B1(acc_mant[9]), 
        .C0(acc_mant[10]), .C1(n576), .Y(n631) );
  OAI211_X0P5M_A9TR U700 ( .A0(n490), .A1(n446), .B0(n489), .C0(n488), .Y(n534) );
  AOI21_X0P5M_A9TR U701 ( .A0(acc_mant[11]), .A1(n1011), .B0(n492), .Y(n501)
         );
  AOI211_X0P7M_A9TR U702 ( .A0(n506), .A1(n515), .B0(n432), .C0(n431), .Y(n621) );
  NOR2_X0P5A_A9TR U703 ( .A(n448), .B(n447), .Y(n569) );
  NOR2_X0P7M_A9TR U704 ( .A(n452), .B(n638), .Y(n750) );
  NOR2_X0P7M_A9TR U705 ( .A(n566), .B(n638), .Y(n710) );
  NOR2XB_X0P5M_A9TR U706 ( .BN(n638), .A(n523), .Y(n484) );
  AOI211_X0P7M_A9TR U707 ( .A0(n382), .A1(n515), .B0(n402), .C0(n401), .Y(n461) );
  NOR2XB_X0P5M_A9TR U708 ( .BN(n638), .A(n567), .Y(n440) );
  NOR2XB_X0P5M_A9TR U709 ( .BN(n638), .A(n540), .Y(n468) );
  NOR2_X0P5A_A9TR U710 ( .A(n615), .B(n638), .Y(n764) );
  NOR2XB_X0P5M_A9TR U711 ( .BN(n638), .A(n626), .Y(n628) );
  NOR2_X0P7M_A9TR U712 ( .A(n627), .B(n638), .Y(n758) );
  NOR2_X0P5A_A9TR U713 ( .A(n499), .B(n498), .Y(n526) );
  NOR2XB_X0P5M_A9TR U714 ( .BN(n638), .A(n614), .Y(n616) );
  NOR2XB_X0P5M_A9TR U715 ( .BN(n638), .A(n451), .Y(n453) );
  OAI22_X0P5M_A9TR U716 ( .A0(n507), .A1(n496), .B0(n473), .B1(n446), .Y(n475)
         );
  NOR2XB_X0P5M_A9TR U717 ( .BN(n638), .A(n601), .Y(n603) );
  NAND2_X0P5A_A9TR U718 ( .A(n493), .B(n719), .Y(n412) );
  OAI22_X0P5M_A9TR U719 ( .A0(n512), .A1(n511), .B0(n510), .B1(n446), .Y(n513)
         );
  NOR2_X0P5A_A9TR U720 ( .A(n508), .B(n496), .Y(n402) );
  NOR2_X0P5A_A9TR U721 ( .A(n490), .B(n496), .Y(n417) );
  AOI222_X0P5M_A9TR U722 ( .A0(n576), .A1(acc_mant[3]), .B0(n577), .B1(
        acc_mant[5]), .C0(n575), .C1(acc_mant[4]), .Y(n547) );
  NAND2_X0P5A_A9TR U723 ( .A(n503), .B(n532), .Y(n451) );
  OAI22_X0P5M_A9TR U724 ( .A0(n507), .A1(n446), .B0(n510), .B1(n511), .Y(n401)
         );
  NAND2_X0P5A_A9TR U725 ( .A(n466), .B(n532), .Y(n614) );
  NOR2_X0P5A_A9TR U726 ( .A(n495), .B(n496), .Y(n391) );
  NAND2_X0P5A_A9TR U727 ( .A(n608), .B(n506), .Y(n489) );
  NOR2_X0P5A_A9TR U728 ( .A(n508), .B(n446), .Y(n432) );
  NAND2B_X0P5M_A9TR U729 ( .AN(n532), .B(n439), .Y(n566) );
  AOI22_X0P5M_A9TR U730 ( .A0(n382), .A1(n487), .B0(n486), .B1(n516), .Y(n488)
         );
  OAI22_X0P5M_A9TR U731 ( .A0(n494), .A1(n511), .B0(n493), .B1(n446), .Y(n499)
         );
  NAND2_X0P5A_A9TR U732 ( .A(n481), .B(n532), .Y(n601) );
  OAI22_X0P5M_A9TR U733 ( .A0(n494), .A1(n446), .B0(n490), .B1(n511), .Y(n390)
         );
  AOI22_X0P5M_A9TR U734 ( .A0(n425), .A1(n395), .B0(n575), .B1(acc_mant[26]), 
        .Y(n396) );
  INV_X0P5B_A9TR U735 ( .A(n577), .Y(n558) );
  NAND2B_X0P5M_A9TR U736 ( .AN(n532), .B(n467), .Y(n539) );
  AOI22_X0P5M_A9TR U737 ( .A0(n575), .A1(acc_mant[6]), .B0(n577), .B1(
        acc_mant[7]), .Y(n555) );
  OAI22_X0P5M_A9TR U738 ( .A0(n512), .A1(n525), .B0(n510), .B1(n496), .Y(n431)
         );
  OAI22_X0P5M_A9TR U739 ( .A0(n497), .A1(n446), .B0(n495), .B1(n511), .Y(n447)
         );
  AOI222_X0P7M_A9TR U740 ( .A0(n493), .A1(n506), .B0(n382), .B1(n497), .C0(
        n516), .C1(n718), .Y(n748) );
  OAI22_X0P5M_A9TR U741 ( .A0(n494), .A1(n496), .B0(n490), .B1(n525), .Y(n448)
         );
  NAND2B_X0P5M_A9TR U742 ( .AN(n532), .B(n482), .Y(n522) );
  AOI211_X1M_A9TR U743 ( .A0(n457), .A1(n430), .B0(n223), .C0(n429), .Y(n512)
         );
  NOR2XB_X0P5M_A9TR U744 ( .BN(n395), .A(n419), .Y(n466) );
  AOI211_X1M_A9TR U745 ( .A0(n457), .A1(n762), .B0(n223), .C0(n398), .Y(n508)
         );
  OAI21_X0P5M_A9TR U746 ( .A0(acc_mant[11]), .A1(n457), .B0(n442), .Y(n487) );
  AOI211_X1M_A9TR U747 ( .A0(n457), .A1(n749), .B0(n223), .C0(n399), .Y(n507)
         );
  NOR2XB_X0P5M_A9TR U748 ( .BN(n395), .A(n405), .Y(n438) );
  NOR2_X0P5A_A9TR U749 ( .A(n408), .B(n395), .Y(n482) );
  INV_X0P5B_A9TR U750 ( .A(n718), .Y(n491) );
  AOI21_X0P5M_A9TR U751 ( .A0(n457), .A1(n518), .B0(n223), .Y(n442) );
  NOR2_X0P5A_A9TR U752 ( .A(n457), .B(acc_mant[12]), .Y(n455) );
  NAND2_X0P5A_A9TR U753 ( .A(n740), .B(n457), .Y(n405) );
  NAND2B_X0P5M_A9TR U754 ( .AN(n457), .B(n717), .Y(n408) );
  NAND2_X0P5A_A9TR U755 ( .A(n415), .B(n456), .Y(n413) );
  AOI21_X0P5M_A9TR U756 ( .A0(n457), .A1(n727), .B0(n223), .Y(n397) );
  NAND2_X0P5A_A9TR U757 ( .A(n415), .B(n430), .Y(n386) );
  NOR2_X0P5A_A9TR U758 ( .A(n457), .B(acc_mant[14]), .Y(n429) );
  XOR2_X0P7M_A9TR U759 ( .A(n376), .B(n375), .Y(n230) );
  NAND2_X0P5A_A9TR U760 ( .A(n366), .B(n369), .Y(n368) );
  NAND2_X0P5A_A9TR U761 ( .A(n374), .B(n373), .Y(n375) );
  NOR2_X0P7M_A9TR U762 ( .A(n370), .B(n372), .Y(n292) );
  OAI21_X1M_A9TR U763 ( .A0(n322), .A1(n238), .B0(n323), .Y(n367) );
  NOR2_X1A_A9TR U764 ( .A(n290), .B(n289), .Y(n372) );
  NAND2_X1A_A9TR U765 ( .A(n288), .B(n287), .Y(n369) );
  NOR2_X1A_A9TR U766 ( .A(n288), .B(n287), .Y(n370) );
  NOR2_X1M_A9TR U767 ( .A(n286), .B(n235), .Y(n322) );
  OA21_X0P7M_A9TR U768 ( .A0(n317), .A1(n320), .B0(n318), .Y(n238) );
  NAND2_X0P5A_A9TR U769 ( .A(n1011), .B(acc_mant[7]), .Y(n606) );
  INV_X0P7M_A9TR U770 ( .A(n302), .Y(n309) );
  INV_X0P7M_A9TR U771 ( .A(n311), .Y(n307) );
  AND2_X0P5B_A9TR U772 ( .A(n275), .B(n305), .Y(n308) );
  NAND2_X1A_A9TR U773 ( .A(n260), .B(n1008), .Y(n270) );
  OA21_X0P5M_A9TR U774 ( .A0(n249), .A1(n239), .B0(n248), .Y(n234) );
  NAND2_X1A_A9TR U775 ( .A(n251), .B(n250), .Y(n252) );
  NOR2_X0P7M_A9TR U776 ( .A(n251), .B(n250), .Y(n253) );
  NAND2_X0P5A_A9TR U777 ( .A(n247), .B(n246), .Y(n248) );
  OA21_X0P5M_A9TR U778 ( .A0(n317), .A1(n245), .B0(n318), .Y(n239) );
  XNOR2_X0P5M_A9TR U779 ( .A(n277), .B(n1003), .Y(n247) );
  NAND2_X0P5A_A9TR U780 ( .A(n244), .B(n284), .Y(n245) );
  INV_X0P5B_A9TR U781 ( .A(n285), .Y(n244) );
  NAND2_X0P5A_A9TR U782 ( .A(n263), .B(n294), .Y(n266) );
  NOR2_X0P7M_A9TR U783 ( .A(n356), .B(n345), .Y(n359) );
  NOR2_X0P7M_A9TR U784 ( .A(n346), .B(n355), .Y(n358) );
  NOR2_X0P7M_A9TR U785 ( .A(n356), .B(n329), .Y(n337) );
  NOR2_X0P7M_A9TR U786 ( .A(n327), .B(n355), .Y(n339) );
  NOR2_X0P7M_A9TR U787 ( .A(n340), .B(n355), .Y(n348) );
  OR2_X0P7M_A9TR U788 ( .A(n223), .B(n384), .Y(n722) );
  NOR2XB_X1M_A9TR U789 ( .BN(acc_exp[4]), .A(n223), .Y(n278) );
  NAND2B_X0P5M_A9TR U790 ( .AN(n223), .B(acc_sign), .Y(n825) );
  NOR2_X0P7M_A9TR U791 ( .A(n327), .B(n329), .Y(n740) );
  NOR3_X0P5A_A9TR U792 ( .A(n819), .B(n221), .C(n222), .Y(n823) );
  NOR3_X0P5A_A9TR U793 ( .A(n821), .B(n220), .C(n820), .Y(n822) );
  NOR2_X0P7M_A9TR U794 ( .A(n346), .B(n341), .Y(n336) );
  NOR2_X0P7M_A9TR U795 ( .A(n327), .B(n345), .Y(n334) );
  NOR2_X0P7M_A9TR U796 ( .A(n346), .B(n345), .Y(n351) );
  OR2_X1M_A9TR U797 ( .A(fp8_result[4]), .B(n1002), .Y(out_result[4]) );
  OR2_X1M_A9TR U798 ( .A(fp8_result[6]), .B(n1002), .Y(out_result[6]) );
  ADDF_X1M_A9TR U799 ( .A(n970), .B(n969), .CI(n968), .CO(n962), .S(
        adder_mant[3]) );
  XOR2_X0P5M_A9TR U800 ( .A(n905), .B(n999), .Y(n952) );
  XOR2_X0P5M_A9TR U801 ( .A(n890), .B(n999), .Y(n946) );
  XOR2_X0P5M_A9TR U802 ( .A(n872), .B(n999), .Y(n975) );
  XOR2_X0P5M_A9TR U803 ( .A(n878), .B(n999), .Y(n940) );
  XOR2_X0P5M_A9TR U804 ( .A(n884), .B(n999), .Y(n981) );
  XOR2_X0P5M_A9TR U805 ( .A(n869), .B(n999), .Y(n978) );
  XOR2_X0P5M_A9TR U806 ( .A(n866), .B(n999), .Y(n972) );
  XOR2_X0P5M_A9TR U807 ( .A(n893), .B(n999), .Y(n949) );
  XOR2_X0P5M_A9TR U808 ( .A(n863), .B(n862), .Y(n934) );
  XOR2_X0P5M_A9TR U809 ( .A(n859), .B(n862), .Y(n931) );
  XOR2_X0P5M_A9TR U810 ( .A(n899), .B(n999), .Y(n969) );
  AO22_X0P5M_A9TR U811 ( .A0(n832), .A1(n957), .B0(n956), .B1(n991), .Y(n995)
         );
  AOI21_X1M_A9TR U812 ( .A0(n703), .A1(n702), .B0(n701), .Y(n818) );
  AOI21_X0P7M_A9TR U813 ( .A0(n787), .A1(n786), .B0(n785), .Y(n803) );
  NAND2_X0P7A_A9TR U814 ( .A(n744), .B(n787), .Y(n773) );
  NOR2_X0P7M_A9TR U815 ( .A(n732), .B(n779), .Y(n744) );
  OR2_X1M_A9TR U816 ( .A(n956), .B(n805), .Y(n808) );
  NOR2_X0P7M_A9TR U817 ( .A(n842), .B(n788), .Y(n771) );
  NOR2_X0P7M_A9TR U818 ( .A(n836), .B(n793), .Y(n757) );
  AND2_X0P7M_A9TR U819 ( .A(n393), .B(n380), .Y(n857) );
  AND2_X0P7M_A9TR U820 ( .A(n379), .B(n380), .Y(n860) );
  AND2_X0P7M_A9TR U821 ( .A(n424), .B(n380), .Y(n864) );
  OAI22_X0P7M_A9TR U822 ( .A0(n769), .A1(n715), .B0(n714), .B1(n754), .Y(n830)
         );
  OAI22_X0P7M_A9TR U823 ( .A0(n762), .A1(n769), .B0(n761), .B1(n767), .Y(n843)
         );
  AO22_X0P7M_A9TR U824 ( .A0(n752), .A1(n215), .B0(n751), .B1(n380), .Y(n833)
         );
  MXT2_X0P5M_A9TR U825 ( .A(n603), .B(n745), .S0(n763), .Y(n604) );
  NAND2_X0P5A_A9TR U826 ( .A(n461), .B(n641), .Y(n462) );
  AOI22_X0P5M_A9TR U827 ( .A0(n1011), .A1(acc_mant[9]), .B0(n713), .B1(n472), 
        .Y(n450) );
  AOI222_X1M_A9TR U828 ( .A0(n707), .A1(n532), .B0(n382), .B1(n507), .C0(n506), 
        .C1(n473), .Y(n768) );
  AO21A1AI2_X0P5M_A9TR U829 ( .A0(n395), .A1(n608), .B0(n607), .C0(n606), .Y(
        n609) );
  MXT2_X0P5M_A9TR U830 ( .A(n484), .B(n483), .S0(n763), .Y(n485) );
  MXT2_X0P5M_A9TR U831 ( .A(n468), .B(n704), .S0(n763), .Y(n469) );
  MXT2_X0P5M_A9TR U832 ( .A(n616), .B(n764), .S0(n763), .Y(n617) );
  MXT2_X0P5M_A9TR U833 ( .A(n453), .B(n750), .S0(n763), .Y(n454) );
  NOR2B_X0P7M_A9TR U834 ( .AN(n750), .B(n763), .Y(n751) );
  MXT2_X0P5M_A9TR U835 ( .A(n440), .B(n710), .S0(n763), .Y(n441) );
  MXT2_X0P5M_A9TR U836 ( .A(n628), .B(n758), .S0(n763), .Y(n629) );
  AOI222_X0P7M_A9TR U837 ( .A0(n713), .A1(n532), .B0(n382), .B1(n494), .C0(
        n497), .C1(n506), .Y(n761) );
  OAI22_X0P7M_A9TR U838 ( .A0(n749), .A1(n769), .B0(n748), .B1(n767), .Y(n837)
         );
  NOR2_X0P5A_A9TR U839 ( .A(n522), .B(n638), .Y(n483) );
  AOI211_X0P7M_A9TR U840 ( .A0(n516), .A1(n515), .B0(n514), .C0(n513), .Y(n642) );
  OAI21_X0P5M_A9TR U841 ( .A0(n605), .A1(n395), .B0(n648), .Y(n607) );
  AOI211_X0P7M_A9TR U842 ( .A0(n382), .A1(n486), .B0(n391), .C0(n390), .Y(n610) );
  NOR2_X0P7M_A9TR U843 ( .A(n539), .B(n638), .Y(n704) );
  MXIT2_X0P5M_A9TR U844 ( .A(n466), .B(n465), .S0(n532), .Y(n540) );
  MXIT2_X0P5M_A9TR U845 ( .A(n437), .B(n439), .S0(n532), .Y(n627) );
  MXIT2_X0P5M_A9TR U846 ( .A(n480), .B(n482), .S0(n532), .Y(n602) );
  MXIT2_X0P5M_A9TR U847 ( .A(n438), .B(n437), .S0(n532), .Y(n567) );
  MXIT2_X0P5M_A9TR U848 ( .A(n465), .B(n467), .S0(n532), .Y(n615) );
  NAND2_X0P5A_A9TR U849 ( .A(n438), .B(n532), .Y(n626) );
  AOI222_X0P7M_A9TR U850 ( .A0(n395), .A1(n509), .B0(n572), .B1(acc_mant[10]), 
        .C0(n576), .C1(acc_mant[11]), .Y(n618) );
  MXIT2_X0P5M_A9TR U851 ( .A(n409), .B(n408), .S0(n395), .Y(n439) );
  INV_X1M_A9TR U852 ( .A(n641), .Y(n581) );
  MXIT2_X0P5M_A9TR U853 ( .A(n406), .B(n409), .S0(n395), .Y(n480) );
  NOR2_X0P7M_A9TR U854 ( .A(n422), .B(n395), .Y(n467) );
  MXIT2_X0P5M_A9TR U855 ( .A(n407), .B(n406), .S0(n395), .Y(n437) );
  MXIT2_X0P5M_A9TR U856 ( .A(n421), .B(n420), .S0(n395), .Y(n465) );
  MXIT2_X0P5M_A9TR U857 ( .A(n405), .B(n407), .S0(n395), .Y(n481) );
  MXIT2_X0P5M_A9TR U858 ( .A(n419), .B(n421), .S0(n395), .Y(n503) );
  INV_X1M_A9TR U859 ( .A(n511), .Y(n506) );
  MXIT2_X0P5M_A9TR U860 ( .A(n747), .B(n752), .S0(n457), .Y(n406) );
  INV_X1M_A9TR U861 ( .A(n735), .Y(n385) );
  NOR2_X1A_A9TR U862 ( .A(n735), .B(n570), .Y(n641) );
  NAND2_X0P7A_A9TR U863 ( .A(n570), .B(n528), .Y(n644) );
  NOR2_X1A_A9TR U864 ( .A(n457), .B(n722), .Y(n718) );
  NOR2B_X0P7M_A9TR U865 ( .AN(n638), .B(n532), .Y(n571) );
  BUF_X3M_A9TR U866 ( .A(n381), .Y(n457) );
  NAND2_X2B_A9TR U867 ( .A(n377), .B(n224), .Y(n638) );
  OAI21_X0P7M_A9TR U868 ( .A0(n371), .A1(n370), .B0(n369), .Y(n376) );
  XNOR2_X0P5M_A9TR U869 ( .A(n325), .B(n238), .Y(n233) );
  XOR2_X0P7M_A9TR U870 ( .A(n229), .B(n237), .Y(n314) );
  AO22_X0P5M_A9TR U871 ( .A0(n1004), .A1(n215), .B0(n1011), .B1(acc_exp[2]), 
        .Y(adder_exp[2]) );
  XNOR2_X0P5M_A9TR U872 ( .A(n321), .B(n320), .Y(n218) );
  OR2_X1M_A9TR U873 ( .A(n296), .B(n295), .Y(n229) );
  NAND2_X0P7A_A9TR U874 ( .A(n296), .B(n295), .Y(n297) );
  XOR2_X0P5M_A9TR U875 ( .A(n236), .B(n1012), .Y(n219) );
  AND2_X0P7M_A9TR U876 ( .A(n215), .B(n717), .Y(n989) );
  OR2_X1M_A9TR U877 ( .A(n215), .B(n294), .Y(n301) );
  OR2_X1M_A9TR U878 ( .A(n215), .B(n300), .Y(n310) );
  OR2_X1M_A9TR U879 ( .A(n262), .B(n261), .Y(n258) );
  OR2_X1M_A9TR U880 ( .A(n1003), .B(n277), .Y(n254) );
  AOI21_X0P7M_A9TR U881 ( .A0(n243), .A1(n242), .B0(intadd_0_CI), .Y(n285) );
  INV_X1M_A9TR U882 ( .A(n256), .Y(n305) );
  NOR2XB_X1M_A9TR U883 ( .BN(acc_exp[5]), .A(n223), .Y(n294) );
  NOR2XB_X1M_A9TR U884 ( .BN(acc_exp[3]), .A(n223), .Y(n276) );
  NOR2XB_X1M_A9TR U885 ( .BN(acc_exp[7]), .A(n223), .Y(n256) );
  NOR2XB_X1M_A9TR U886 ( .BN(acc_exp[6]), .A(n223), .Y(n300) );
  NOR2XB_X1M_A9TR U887 ( .BN(acc_exp[2]), .A(n223), .Y(n277) );
  INV_X0P5B_A9TR U888 ( .A(norm_mant[23]), .Y(n216) );
  INV_X0P5B_A9TR U889 ( .A(norm_mant[25]), .Y(n217) );
  XOR2_X0P5M_A9TR U890 ( .A(n838), .B(n862), .Y(n913) );
  AO22_X0P5M_A9TR U891 ( .A0(n991), .A1(n837), .B0(n836), .B1(n832), .Y(n838)
         );
  XOR2_X0P5M_A9TR U892 ( .A(n853), .B(n862), .Y(n925) );
  INV_X0P5B_A9TR U893 ( .A(n317), .Y(n319) );
  XOR2_X0P5M_A9TR U894 ( .A(n847), .B(n862), .Y(n922) );
  INV_X0P5B_A9TR U895 ( .A(n370), .Y(n366) );
  XOR2_X0P5M_A9TR U896 ( .A(n831), .B(n999), .Y(n960) );
  NAND2B_X1M_A9TR U897 ( .AN(n300), .B(n215), .Y(n311) );
  AOI222_X0P5M_A9TR U898 ( .A0(n576), .A1(acc_mant[4]), .B0(n577), .B1(
        acc_mant[6]), .C0(n575), .C1(acc_mant[5]), .Y(n535) );
  NAND2_X1A_A9TR U899 ( .A(n229), .B(n297), .Y(n298) );
  MXIT2_X0P5M_A9TR U900 ( .A(u_multiplier_N3), .B(n276), .S0(n215), .Y(n227)
         );
  NAND2_X1A_A9TR U901 ( .A(n290), .B(n289), .Y(n373) );
  XOR2_X0P5M_A9TR U902 ( .A(n958), .B(n999), .Y(n994) );
  AO22_X0P5M_A9TR U903 ( .A0(n991), .A1(n957), .B0(n956), .B1(n832), .Y(n958)
         );
  XOR2_X0P5M_A9TR U904 ( .A(n844), .B(n862), .Y(n919) );
  MXIT2_X0P5M_A9TR U905 ( .A(u_multiplier_N1), .B(n283), .S0(n215), .Y(n235)
         );
  MXIT2_X0P5M_A9TR U906 ( .A(n706), .B(n717), .S0(n457), .Y(n422) );
  MXIT2_X0P5M_A9TR U907 ( .A(n752), .B(n712), .S0(n457), .Y(n420) );
  MXIT2_X0P5M_A9TR U908 ( .A(n766), .B(n747), .S0(n457), .Y(n421) );
  MXIT2_X0P5M_A9TR U909 ( .A(n740), .B(n760), .S0(n457), .Y(n419) );
  MXIT2_X0P5M_A9TR U910 ( .A(n760), .B(n766), .S0(n457), .Y(n407) );
  MXIT2_X0P5M_A9TR U911 ( .A(n712), .B(n706), .S0(n457), .Y(n409) );
  MXT2_X0P7M_A9TR U912 ( .A(u_multiplier_N2), .B(n277), .S0(n215), .Y(n281) );
  NAND2_X1A_A9TR U913 ( .A(n286), .B(n235), .Y(n323) );
  INV_X0P5B_A9TR U914 ( .A(n486), .Y(n443) );
  AOI211_X1M_A9TR U915 ( .A0(n457), .A1(n737), .B0(n223), .C0(n400), .Y(n510)
         );
  NOR2_X1A_A9TR U916 ( .A(n236), .B(n1012), .Y(n320) );
  ADDF_X1M_A9TR U917 ( .A(n988), .B(n987), .CI(n986), .CO(n921), .S(
        adder_mant[19]) );
  XOR2_X0P5M_A9TR U918 ( .A(n850), .B(n862), .Y(n987) );
  INV_X0P5B_A9TR U919 ( .A(n585), .Y(n546) );
  MXIT2_X0P5M_A9TR U920 ( .A(n420), .B(n422), .S0(n395), .Y(n502) );
  AOI21_X1M_A9TR U921 ( .A0(n292), .A1(n367), .B0(n291), .Y(n299) );
  OAI21_X1M_A9TR U922 ( .A0(n372), .A1(n369), .B0(n373), .Y(n291) );
  XOR3_X0P5M_A9TR U923 ( .A(n308), .B(n307), .C(n306), .Y(n313) );
  ADDH_X1M_A9TR U924 ( .A(n254), .B(n276), .CO(n255), .S(n250) );
  NAND2_X1A_A9TR U925 ( .A(n300), .B(n305), .Y(n264) );
  NOR2_X1A_A9TR U926 ( .A(n300), .B(n305), .Y(n265) );
  ADDH_X1M_A9TR U927 ( .A(n255), .B(n278), .CO(n262), .S(n260) );
  NOR2_X1A_A9TR U928 ( .A(n257), .B(n265), .Y(n268) );
  XOR2_X0P5M_A9TR U929 ( .A(n835), .B(n862), .Y(n910) );
  AO22_X0P5M_A9TR U930 ( .A0(n991), .A1(n834), .B0(n833), .B1(n832), .Y(n835)
         );
  XOR2_X0P5M_A9TR U931 ( .A(n856), .B(n862), .Y(n928) );
  NOR2_X1A_A9TR U932 ( .A(n242), .B(n243), .Y(intadd_0_CI) );
  INV_X0P5B_A9TR U933 ( .A(n328), .Y(n356) );
  INV_X0P5B_A9TR U934 ( .A(n326), .Y(n355) );
  OA21A1OI2_X0P5M_A9TR U935 ( .A0(n580), .A1(n579), .B0(n578), .C0(n754), .Y(
        n584) );
  INV_X0P5B_A9TR U936 ( .A(n642), .Y(n517) );
  MXIT2_X0P5M_A9TR U937 ( .A(n503), .B(n502), .S0(n532), .Y(n639) );
  INV_X0P5B_A9TR U938 ( .A(n610), .Y(n392) );
  MXIT2_X0P5M_A9TR U939 ( .A(n451), .B(n452), .S0(n638), .Y(n553) );
  MXIT2_X0P5M_A9TR U940 ( .A(n481), .B(n480), .S0(n532), .Y(n523) );
  INV_X0P5B_A9TR U941 ( .A(n634), .Y(n418) );
  MXIT2_X0P5M_A9TR U942 ( .A(n540), .B(n539), .S0(n638), .Y(n728) );
  MXIT2_X0P5M_A9TR U943 ( .A(n523), .B(n522), .S0(n638), .Y(n733) );
  OAI21_X1M_A9TR U944 ( .A0(n719), .A1(n491), .B0(n412), .Y(n713) );
  NAND2_X1A_A9TR U945 ( .A(n258), .B(n268), .Y(n271) );
  OAI21_X1M_A9TR U946 ( .A0(n271), .A1(n270), .B0(n269), .Y(n272) );
  AOI21_X1M_A9TR U947 ( .A0(n225), .A1(n268), .B0(n267), .Y(n269) );
  OAI21_X1M_A9TR U948 ( .A0(n266), .A1(n265), .B0(n264), .Y(n267) );
  XOR2_X0P5M_A9TR U949 ( .A(n841), .B(n862), .Y(n916) );
  AO22_X0P5M_A9TR U950 ( .A0(n991), .A1(n840), .B0(n839), .B1(n832), .Y(n841)
         );
  INV_X0P5B_A9TR U951 ( .A(n549), .Y(n478) );
  ADDH_X1M_A9TR U952 ( .A(u_multiplier_N2), .B(u_multiplier_N1), .CO(n1006), 
        .S(n1004) );
  AND2_X1M_A9TR U953 ( .A(n380), .B(n414), .Y(n1011) );
  ADDF_X1M_A9TR U954 ( .A(n964), .B(n963), .CI(n962), .CO(n948), .S(
        adder_mant[4]) );
  XOR2_X0P5M_A9TR U955 ( .A(n896), .B(n999), .Y(n963) );
  ADDF_X1M_A9TR U956 ( .A(n967), .B(n966), .CI(n965), .CO(n968), .S(
        adder_mant[2]) );
  XOR2_X0P5M_A9TR U957 ( .A(n902), .B(n999), .Y(n966) );
  ADDF_X1M_A9TR U958 ( .A(n998), .B(n997), .CI(n996), .CO(n1000), .S(
        adder_mant[27]) );
  XOR2_X0P5M_A9TR U959 ( .A(n992), .B(n999), .Y(n997) );
  INV_X0P5B_A9TR U960 ( .A(n904), .Y(n589) );
  INV_X0P5B_A9TR U961 ( .A(n907), .Y(n565) );
  INV_X0P5B_A9TR U962 ( .A(n901), .Y(n593) );
  INV_X0P5B_A9TR U963 ( .A(n898), .Y(n594) );
  INV_X0P5B_A9TR U964 ( .A(n892), .Y(n653) );
  INV_X0P5B_A9TR U965 ( .A(n895), .Y(n652) );
  INV_X0P5B_A9TR U966 ( .A(n880), .Y(n669) );
  MXIT2_X0P5M_A9TR U967 ( .A(n614), .B(n615), .S0(n638), .Y(n423) );
  MXIT2_X0P5M_A9TR U968 ( .A(n601), .B(n602), .S0(n638), .Y(n378) );
  INV_X0P5B_A9TR U969 ( .A(n883), .Y(n668) );
  MXIT2_X0P5M_A9TR U970 ( .A(n626), .B(n627), .S0(n638), .Y(n410) );
  MXIT2_X0P5M_A9TR U971 ( .A(n567), .B(n566), .S0(n638), .Y(n724) );
  NOR2_X1A_A9TR U972 ( .A(n259), .B(n271), .Y(n273) );
  OAI21_X1M_A9TR U973 ( .A0(n253), .A1(n234), .B0(n252), .Y(n274) );
  XOR2_X0P5M_A9TR U974 ( .A(n875), .B(n999), .Y(n937) );
  XOR2_X0P5M_A9TR U975 ( .A(n881), .B(n999), .Y(n943) );
  ADDF_X1M_A9TR U976 ( .A(n985), .B(n984), .CI(n983), .CO(n980), .S(
        adder_mant[7]) );
  XOR2_X0P5M_A9TR U977 ( .A(n887), .B(n999), .Y(n984) );
  AO21B_X0P5M_A9TR U978 ( .A0(n1011), .A1(acc_exp[7]), .B0N(n1010), .Y(
        adder_exp[7]) );
  MXT2_X0P7M_A9TR U979 ( .A(n284), .B(n285), .S0(n215), .Y(n1012) );
  INV_X0P5B_A9TR U980 ( .A(n855), .Y(n775) );
  OAI21_X1M_A9TR U981 ( .A0(n700), .A1(n699), .B0(n698), .Y(n701) );
  XNOR2_X0P5M_A9TR U982 ( .A(in_b[7]), .B(in_a[7]), .Y(n826) );
  NOR2B_X1P4M_A9TR U983 ( .AN(fp8_result[1]), .B(n1002), .Y(out_result[1]) );
  NOR2XB_X0P5M_A9TR U984 ( .BN(norm_mant[19]), .A(n1002), .Y(n_2_net__19_) );
  NOR2XB_X0P5M_A9TR U985 ( .BN(norm_exp[4]), .A(n1002), .Y(n_1_net__4_) );
  NOR2XB_X0P5M_A9TR U986 ( .BN(norm_exp[3]), .A(n1002), .Y(n_1_net__3_) );
  NOR2XB_X0P5M_A9TR U987 ( .BN(norm_exp[1]), .A(n1002), .Y(n_1_net__1_) );
  NOR2XB_X0P5M_A9TR U988 ( .BN(norm_exp[0]), .A(n1002), .Y(n_1_net__0_) );
  MXIT2_X0P5M_A9TR U989 ( .A(n825), .B(n826), .S0(n828), .Y(n824) );
  NAND2_X2B_A9TR U990 ( .A(n377), .B(n218), .Y(n395) );
  INV_X0P5B_A9TR U991 ( .A(in_b[0]), .Y(n327) );
  INV_X0P5B_A9TR U992 ( .A(in_b[1]), .Y(n340) );
  INV_X0P5B_A9TR U993 ( .A(in_b[2]), .Y(n346) );
  INV_X0P5B_A9TR U994 ( .A(in_a[1]), .Y(n341) );
  INV_X0P5B_A9TR U995 ( .A(in_a[2]), .Y(n345) );
  XOR2_X1M_A9TR U996 ( .A(n826), .B(n825), .Y(n862) );
  NOR2B_X2M_A9TR U997 ( .AN(n824), .B(n1002), .Y(out_result[7]) );
  OAI21_X1M_A9TR U998 ( .A0(n395), .A1(n428), .B0(n396), .Y(n753) );
  OAI22_X1M_A9TR U999 ( .A0(n395), .A1(n427), .B0(n533), .B1(n709), .Y(n707)
         );
  NAND2B_X1M_A9TR U1000 ( .AN(n395), .B(n532), .Y(n496) );
  NOR2_X1A_A9TR U1001 ( .A(n426), .B(n395), .Y(n572) );
  NAND2B_X1M_A9TR U1002 ( .AN(n532), .B(n395), .Y(n511) );
  NOR2_X1A_A9TR U1003 ( .A(n458), .B(n395), .Y(n576) );
  NOR2_X1A_A9TR U1004 ( .A(n532), .B(n395), .Y(n382) );
  INV_X1M_A9TR U1005 ( .A(n1011), .Y(n769) );
  AND2_X1M_A9TR U1006 ( .A(n262), .B(n261), .Y(n225) );
  AND2_X0P5B_A9TR U1007 ( .A(n1009), .B(n1008), .Y(n226) );
  AND2_X1M_A9TR U1008 ( .A(n313), .B(n312), .Y(n228) );
  INV_X1P7B_A9TR U1009 ( .A(rst_n), .Y(n1014) );
  AO22_X2M_A9TR U1010 ( .A0(n214), .A1(n823), .B0(n211), .B1(n822), .Y(n1002)
         );
  NAND2_X1A_A9TR U1011 ( .A(n532), .B(n395), .Y(n446) );
  XNOR2_X0P7M_A9TR U1012 ( .A(n299), .B(n298), .Y(n231) );
  AND2_X1M_A9TR U1013 ( .A(n304), .B(n303), .Y(n237) );
  INV_X0P5B_A9TR U1014 ( .A(in_a[0]), .Y(n329) );
  TIELO_X1M_A9TR U1015 ( .Y(n1013) );
  ADDF_X1M_A9TR U1016 ( .A(n280), .B(n227), .CI(n279), .CO(n289), .S(n288) );
  ADDF_X1M_A9TR U1017 ( .A(n215), .B(n282), .CI(n281), .CO(n287), .S(n286) );
  ADDF_X1M_A9TR U1018 ( .A(n215), .B(n293), .CI(n232), .CO(n296), .S(n290) );
  ADDF_X1M_A9TR U1019 ( .A(n215), .B(n302), .CI(n301), .CO(n303), .S(n295) );
  ADDF_X1M_A9TR U1020 ( .A(n311), .B(n310), .CI(n309), .CO(n312), .S(n304) );
  NAND2_X1A_A9TR U1021 ( .A(n377), .B(n219), .Y(n381) );
  ADDH_X1M_A9TR U1022 ( .A(n316), .B(n315), .CO(n333), .S(n760) );
  NAND2_X2B_A9TR U1023 ( .A(n377), .B(n233), .Y(n532) );
  ADDH_X1M_A9TR U1024 ( .A(n331), .B(n330), .CO(n335), .S(n332) );
  ADDF_X1M_A9TR U1025 ( .A(n334), .B(n333), .CI(n332), .CO(n342), .S(n766) );
  ADDF_X1M_A9TR U1026 ( .A(n337), .B(n336), .CI(n335), .CO(n354), .S(n343) );
  ADDH_X1M_A9TR U1027 ( .A(n339), .B(n338), .CO(n350), .S(n344) );
  ADDF_X1M_A9TR U1028 ( .A(n344), .B(n343), .CI(n342), .CO(n352), .S(n747) );
  ADDH_X1M_A9TR U1029 ( .A(n348), .B(n347), .CO(n357), .S(n349) );
  ADDF_X1M_A9TR U1030 ( .A(n351), .B(n350), .CI(n349), .CO(n361), .S(n353) );
  ADDF_X1M_A9TR U1031 ( .A(n354), .B(n353), .CI(n352), .CO(n360), .S(n752) );
  ADDF_X1M_A9TR U1032 ( .A(n359), .B(n358), .CI(n357), .CO(n364), .S(n362) );
  ADDF_X1M_A9TR U1033 ( .A(n362), .B(n361), .CI(n360), .CO(n363), .S(n712) );
  ADDF_X1M_A9TR U1034 ( .A(n365), .B(n364), .CI(n363), .CO(n717), .S(n706) );
  NAND2_X2B_A9TR U1035 ( .A(n377), .B(n230), .Y(n763) );
  INV_X0P5B_A9TR U1036 ( .A(acc_mant[15]), .Y(n430) );
  INV_X0P5B_A9TR U1037 ( .A(acc_mant[26]), .Y(n709) );
  INV_X0P5B_A9TR U1038 ( .A(acc_mant[25]), .Y(n715) );
  INV_X0P5B_A9TR U1039 ( .A(acc_mant[23]), .Y(n749) );
  INV_X0P5B_A9TR U1040 ( .A(acc_mant[27]), .Y(n384) );
  INV_X0P5B_A9TR U1041 ( .A(acc_mant[19]), .Y(n737) );
  INV_X0P5B_A9TR U1042 ( .A(acc_mant[21]), .Y(n762) );
  INV_X0P5B_A9TR U1043 ( .A(acc_mant[17]), .Y(n727) );
  INV_X0P5B_A9TR U1044 ( .A(acc_mant[16]), .Y(n403) );
  INV_X0P5B_A9TR U1045 ( .A(acc_mant[13]), .Y(n456) );
  INV_X0P5B_A9TR U1046 ( .A(n767), .Y(n433) );
  OAI21_X1M_A9TR U1047 ( .A0(n768), .A1(n581), .B0(n434), .Y(n865) );
  INV_X0P5B_A9TR U1048 ( .A(acc_mant[12]), .Y(n518) );
  AOI22_X0P5M_A9TR U1049 ( .A0(n572), .A1(acc_mant[8]), .B0(n576), .B1(
        acc_mant[9]), .Y(n460) );
  AOI22_X0P5M_A9TR U1050 ( .A0(n575), .A1(acc_mant[10]), .B0(acc_mant[11]), 
        .B1(n577), .Y(n459) );
  INV_X0P5B_A9TR U1051 ( .A(n446), .Y(n471) );
  INV_X0P5B_A9TR U1052 ( .A(n528), .Y(n588) );
  AOI22_X0P5M_A9TR U1053 ( .A0(n572), .A1(acc_mant[7]), .B0(acc_mant[8]), .B1(
        n576), .Y(n530) );
  AOI22_X0P5M_A9TR U1054 ( .A0(n575), .A1(acc_mant[9]), .B0(n577), .B1(
        acc_mant[10]), .Y(n529) );
  NAND2_X0P5A_A9TR U1055 ( .A(n530), .B(n529), .Y(n611) );
  AOI22_X0P5M_A9TR U1056 ( .A0(n572), .A1(acc_mant[6]), .B0(n576), .B1(
        acc_mant[7]), .Y(n544) );
  AOI22_X0P5M_A9TR U1057 ( .A0(n575), .A1(acc_mant[8]), .B0(n577), .B1(
        acc_mant[9]), .Y(n543) );
  NAND2_X0P5A_A9TR U1058 ( .A(n544), .B(n543), .Y(n622) );
  INV_X0P5B_A9TR U1059 ( .A(acc_mant[2]), .Y(n545) );
  AOI22_X0P5M_A9TR U1060 ( .A0(n572), .A1(acc_mant[4]), .B0(n576), .B1(
        acc_mant[5]), .Y(n556) );
  NAND2_X0P5A_A9TR U1061 ( .A(n556), .B(n555), .Y(n646) );
  INV_X0P5B_A9TR U1062 ( .A(acc_mant[3]), .Y(n579) );
  AOI22_X0P5M_A9TR U1063 ( .A0(n575), .A1(acc_mant[2]), .B0(n576), .B1(
        acc_mant[1]), .Y(n557) );
  AOI22_X0P5M_A9TR U1064 ( .A0(n572), .A1(acc_mant[5]), .B0(n576), .B1(
        acc_mant[6]), .Y(n574) );
  AOI22_X0P5M_A9TR U1065 ( .A0(n575), .A1(acc_mant[7]), .B0(n577), .B1(
        acc_mant[8]), .Y(n573) );
  NAND2_X0P5A_A9TR U1066 ( .A(n574), .B(n573), .Y(n635) );
  INV_X0P5B_A9TR U1067 ( .A(n575), .Y(n580) );
  AOI22_X0P5M_A9TR U1068 ( .A0(n577), .A1(acc_mant[4]), .B0(n576), .B1(
        acc_mant[2]), .Y(n578) );
  INV_X0P5B_A9TR U1069 ( .A(acc_mant[6]), .Y(n619) );
  INV_X0P5B_A9TR U1070 ( .A(acc_mant[5]), .Y(n632) );
  OAI22_X1M_A9TR U1071 ( .A0(n769), .A1(n709), .B0(n708), .B1(n754), .Y(n957)
         );
  INV_X0P5B_A9TR U1072 ( .A(n713), .Y(n714) );
  OAI21_X1M_A9TR U1073 ( .A0(n722), .A1(n215), .B0(n721), .Y(n990) );
  NOR2_X1A_A9TR U1074 ( .A(n989), .B(n809), .Y(n811) );
  INV_X0P5B_A9TR U1075 ( .A(acc_mant[18]), .Y(n731) );
  INV_X0P5B_A9TR U1076 ( .A(acc_mant[20]), .Y(n742) );
  INV_X0P5B_A9TR U1077 ( .A(acc_mant[24]), .Y(n756) );
  INV_X0P5B_A9TR U1078 ( .A(acc_mant[22]), .Y(n770) );
  OAI22_X1M_A9TR U1079 ( .A0(n770), .A1(n769), .B0(n768), .B1(n767), .Y(n840)
         );
  NAND2_X1A_A9TR U1080 ( .A(n800), .B(n772), .Y(n802) );
  NAND2_X1A_A9TR U1081 ( .A(n814), .B(n774), .Y(n817) );
  OAI21_X1M_A9TR U1082 ( .A0(n797), .A1(n796), .B0(n795), .Y(n798) );
  AOI21_X1M_A9TR U1083 ( .A0(n800), .A1(n799), .B0(n798), .Y(n801) );
  OAI21_X1M_A9TR U1084 ( .A0(n803), .A1(n802), .B0(n801), .Y(n815) );
  AOI21_X1M_A9TR U1085 ( .A0(n808), .A1(n807), .B0(n806), .Y(n812) );
  NAND2_X1A_A9TR U1086 ( .A(n989), .B(n809), .Y(n810) );
  OAI21_X1M_A9TR U1087 ( .A0(n812), .A1(n811), .B0(n810), .Y(n813) );
  AOI21_X1M_A9TR U1088 ( .A0(n815), .A1(n814), .B0(n813), .Y(n816) );
  AO22_X0P5M_A9TR U1089 ( .A0(n991), .A1(n830), .B0(n829), .B1(n832), .Y(n831)
         );
  INV_X1M_A9TR U1090 ( .A(n827), .Y(n999) );
  AO22_X0P5M_A9TR U1091 ( .A0(n991), .A1(n843), .B0(n842), .B1(n832), .Y(n844)
         );
  ADDF_X1M_A9TR U1092 ( .A(n911), .B(n910), .CI(n909), .CO(n959), .S(
        adder_mant[24]) );
  ADDF_X1M_A9TR U1093 ( .A(n914), .B(n913), .CI(n912), .CO(n909), .S(
        adder_mant[23]) );
  ADDF_X1M_A9TR U1094 ( .A(n917), .B(n916), .CI(n915), .CO(n912), .S(
        adder_mant[22]) );
  ADDF_X1M_A9TR U1095 ( .A(n920), .B(n919), .CI(n918), .CO(n915), .S(
        adder_mant[21]) );
  ADDF_X1M_A9TR U1096 ( .A(n923), .B(n922), .CI(n921), .CO(n918), .S(
        adder_mant[20]) );
  ADDF_X1M_A9TR U1097 ( .A(n926), .B(n925), .CI(n924), .CO(n986), .S(
        adder_mant[18]) );
  ADDF_X1M_A9TR U1098 ( .A(n929), .B(n928), .CI(n927), .CO(n924), .S(
        adder_mant[17]) );
  ADDF_X1M_A9TR U1099 ( .A(n932), .B(n931), .CI(n930), .CO(n927), .S(
        adder_mant[16]) );
  ADDF_X1M_A9TR U1100 ( .A(n935), .B(n934), .CI(n933), .CO(n930), .S(
        adder_mant[15]) );
  ADDF_X1M_A9TR U1101 ( .A(n938), .B(n937), .CI(n936), .CO(n974), .S(
        adder_mant[11]) );
  ADDF_X1M_A9TR U1102 ( .A(n941), .B(n940), .CI(n939), .CO(n936), .S(
        adder_mant[10]) );
  ADDF_X1M_A9TR U1103 ( .A(n944), .B(n943), .CI(n942), .CO(n939), .S(
        adder_mant[9]) );
  ADDF_X1M_A9TR U1104 ( .A(n947), .B(n946), .CI(n945), .CO(n983), .S(
        adder_mant[6]) );
  ADDF_X1M_A9TR U1105 ( .A(n950), .B(n949), .CI(n948), .CO(n945), .S(
        adder_mant[5]) );
  ADDF_X1M_A9TR U1106 ( .A(n953), .B(n952), .CI(n951), .CO(n965), .S(
        adder_mant[1]) );
  ADDF_X1M_A9TR U1107 ( .A(n999), .B(n955), .CI(n954), .CO(n951), .S(
        adder_mant[0]) );
  ADDF_X1M_A9TR U1108 ( .A(n961), .B(n960), .CI(n959), .CO(n993), .S(
        adder_mant[25]) );
  AO21_X0P7M_A9TR U1109 ( .A0(n832), .A1(n990), .B0(n989), .Y(n998) );
  AO22_X0P5M_A9TR U1110 ( .A0(n991), .A1(n990), .B0(n989), .B1(n832), .Y(n992)
         );
  ADDF_X1M_A9TR U1111 ( .A(n995), .B(n994), .CI(n993), .CO(n996), .S(
        adder_mant[26]) );
  NOR2XB_X0P5M_A9TR U1112 ( .BN(norm_exp[5]), .A(n1002), .Y(n_1_net__5_) );
  NOR2XB_X0P5M_A9TR U1113 ( .BN(norm_exp[2]), .A(n1002), .Y(n_1_net__2_) );
  NOR2XB_X0P5M_A9TR U1114 ( .BN(norm_exp[7]), .A(n1002), .Y(n_1_net__7_) );
  NOR2XB_X0P5M_A9TR U1115 ( .BN(norm_mant[6]), .A(n1002), .Y(n_2_net__6_) );
  NOR2XB_X0P5M_A9TR U1116 ( .BN(norm_mant[3]), .A(n1002), .Y(n_2_net__3_) );
  NOR2XB_X0P5M_A9TR U1117 ( .BN(norm_mant[1]), .A(n1002), .Y(n_2_net__1_) );
  NOR2XB_X0P5M_A9TR U1118 ( .BN(norm_mant[2]), .A(n1002), .Y(n_2_net__2_) );
  NOR2XB_X0P5M_A9TR U1119 ( .BN(norm_mant[9]), .A(n1002), .Y(n_2_net__9_) );
  NOR2XB_X0P5M_A9TR U1120 ( .BN(norm_mant[8]), .A(n1002), .Y(n_2_net__8_) );
  NOR2XB_X0P5M_A9TR U1121 ( .BN(norm_mant[7]), .A(n1002), .Y(n_2_net__7_) );
  NOR2XB_X0P5M_A9TR U1122 ( .BN(norm_mant[10]), .A(n1002), .Y(n_2_net__10_) );
  NOR2XB_X0P5M_A9TR U1123 ( .BN(norm_mant[15]), .A(n1002), .Y(n_2_net__15_) );
  NOR2XB_X0P5M_A9TR U1124 ( .BN(norm_mant[12]), .A(n1002), .Y(n_2_net__12_) );
  NOR2XB_X0P5M_A9TR U1125 ( .BN(norm_mant[5]), .A(n1002), .Y(n_2_net__5_) );
  NOR2XB_X0P5M_A9TR U1126 ( .BN(norm_mant[17]), .A(n1002), .Y(n_2_net__17_) );
  NOR2XB_X0P5M_A9TR U1127 ( .BN(norm_mant[4]), .A(n1002), .Y(n_2_net__4_) );
  NOR2XB_X0P5M_A9TR U1128 ( .BN(norm_mant[14]), .A(n1002), .Y(n_2_net__14_) );
  NOR2XB_X0P5M_A9TR U1129 ( .BN(norm_mant[13]), .A(n1002), .Y(n_2_net__13_) );
  NOR2XB_X0P5M_A9TR U1130 ( .BN(norm_mant[16]), .A(n1002), .Y(n_2_net__16_) );
  NOR2XB_X0P5M_A9TR U1131 ( .BN(n217), .A(n1002), .Y(n_2_net__25_) );
  NOR2XB_X0P5M_A9TR U1132 ( .BN(norm_mant[22]), .A(n1002), .Y(n_2_net__22_) );
  NOR2XB_X0P5M_A9TR U1133 ( .BN(norm_mant[11]), .A(n1002), .Y(n_2_net__11_) );
  NOR2XB_X0P5M_A9TR U1134 ( .BN(norm_mant[21]), .A(n1002), .Y(n_2_net__21_) );
  NOR2XB_X0P5M_A9TR U1135 ( .BN(norm_exp[6]), .A(n1002), .Y(n_1_net__6_) );
  NOR2XB_X0P5M_A9TR U1136 ( .BN(norm_mant[0]), .A(n1002), .Y(n_2_net__0_) );
  NOR2_X0P5A_A9TR U1137 ( .A(n216), .B(n1002), .Y(n_2_net__23_) );
  NOR2_X0P5A_A9TR U1138 ( .A(norm_mant[26]), .B(n1002), .Y(n_2_net__26_) );
  NOR2XB_X0P5M_A9TR U1139 ( .BN(norm_mant[18]), .A(n1002), .Y(n_2_net__18_) );
  NOR2XB_X0P5M_A9TR U1140 ( .BN(norm_mant[20]), .A(n1002), .Y(n_2_net__20_) );
  AO22_X0P5M_A9TR U1141 ( .A0(n1003), .A1(n215), .B0(n1011), .B1(acc_exp[1]), 
        .Y(adder_exp[1]) );
  XNOR2_X0P5M_A9TR U1142 ( .A(u_multiplier_N3), .B(n1006), .Y(n1005) );
  AO22_X0P5M_A9TR U1143 ( .A0(n1005), .A1(n215), .B0(n1011), .B1(acc_exp[3]), 
        .Y(adder_exp[3]) );
  NOR2_X0P5A_A9TR U1144 ( .A(u_multiplier_N3), .B(n1006), .Y(n1009) );
  XOR2_X0P5M_A9TR U1145 ( .A(n1009), .B(intadd_0_n1), .Y(n1007) );
  AO22_X0P5M_A9TR U1146 ( .A0(n1007), .A1(n215), .B0(n1011), .B1(acc_exp[4]), 
        .Y(adder_exp[4]) );
  NAND2_X0P5A_A9TR U1147 ( .A(n215), .B(n226), .Y(n1010) );
  AO21B_X0P5M_A9TR U1148 ( .A0(n1011), .A1(acc_exp[5]), .B0N(n1010), .Y(
        adder_exp[5]) );
  AO21B_X0P5M_A9TR U1149 ( .A0(n1011), .A1(acc_exp[6]), .B0N(n1010), .Y(
        adder_exp[6]) );
endmodule


module fp8_normalizer_MANT_WIDTH28 ( sign_in, mant_in, exp_in, fp8_out, 
        acc_sign, acc_exp, acc_mant_27_, acc_mant_26__BAR, acc_mant_24_, 
        acc_mant_22_, acc_mant_21_, acc_mant_20_, acc_mant_19_, acc_mant_18_, 
        acc_mant_17_, acc_mant_16_, acc_mant_15_, acc_mant_14_, acc_mant_13_, 
        acc_mant_12_, acc_mant_11_, acc_mant_10_, acc_mant_9_, acc_mant_8_, 
        acc_mant_7_, acc_mant_6_, acc_mant_5_, acc_mant_4_, acc_mant_3_, 
        acc_mant_2_, acc_mant_1_, acc_mant_0_, acc_mant_25__BAR, acc_mant_23_
 );
  input [28:0] mant_in;
  input [7:0] exp_in;
  output [7:0] fp8_out;
  output [7:0] acc_exp;
  input sign_in;
  output acc_sign, acc_mant_27_, acc_mant_26__BAR, acc_mant_24_, acc_mant_22_,
         acc_mant_21_, acc_mant_20_, acc_mant_19_, acc_mant_18_, acc_mant_17_,
         acc_mant_16_, acc_mant_15_, acc_mant_14_, acc_mant_13_, acc_mant_12_,
         acc_mant_11_, acc_mant_10_, acc_mant_9_, acc_mant_8_, acc_mant_7_,
         acc_mant_6_, acc_mant_5_, acc_mant_4_, acc_mant_3_, acc_mant_2_,
         acc_mant_1_, acc_mant_0_, acc_mant_25__BAR, acc_mant_23_;
  wire   acc_mant_25_, n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461, n462, n463, n464,
         n465, n466, n467, n468, n469, n471, n472, n473, n474, n475, n476,
         n477, n478, n479, n480, n481;

  NOR2_X1B_A9TR U3 ( .A(n166), .B(n142), .Y(n361) );
  BUF_X2M_A9TR U4 ( .A(n172), .Y(n304) );
  INV_X0P5B_A9TR U5 ( .A(acc_exp[1]), .Y(n411) );
  NAND2_X1A_A9TR U6 ( .A(n169), .B(n168), .Y(n393) );
  INV_X0P5B_A9TR U7 ( .A(n177), .Y(n152) );
  AOI22_X2M_A9TR U8 ( .A0(n207), .A1(n178), .B0(n208), .B1(n177), .Y(n338) );
  INV_X0P5B_A9TR U9 ( .A(acc_mant_24_), .Y(n469) );
  OAI22_X0P7M_A9TR U10 ( .A0(n481), .A1(n480), .B0(n479), .B1(n478), .Y(
        fp8_out[0]) );
  OAI211_X0P7M_A9TR U11 ( .A0(n481), .A1(acc_mant_25_), .B0(n433), .C0(n467), 
        .Y(n434) );
  AOI21_X0P7M_A9TR U12 ( .A0(n389), .A1(n436), .B0(n451), .Y(fp8_out[4]) );
  NAND3_X0P5A_A9TR U13 ( .A(n446), .B(n373), .C(n390), .Y(n382) );
  NAND3_X1A_A9TR U14 ( .A(n415), .B(acc_exp[3]), .C(n390), .Y(n383) );
  AOI211_X0P7M_A9TR U15 ( .A0(acc_mant_24_), .A1(acc_exp[3]), .B0(n471), .C0(
        acc_mant_23_), .Y(n472) );
  INV_X1M_A9TR U16 ( .A(n445), .Y(n447) );
  NOR2_X0P5A_A9TR U17 ( .A(n460), .B(n459), .Y(n462) );
  INV_X1B_A9TR U18 ( .A(n416), .Y(n417) );
  OAI21_X1P4M_A9TR U19 ( .A0(n311), .A1(n359), .B0(n310), .Y(n312) );
  NOR3_X0P7M_A9TR U20 ( .A(n380), .B(n379), .C(n378), .Y(n381) );
  NOR2_X1B_A9TR U21 ( .A(n425), .B(n424), .Y(n448) );
  NAND2_X0P7A_A9TR U22 ( .A(n205), .B(n346), .Y(n336) );
  NAND2_X0P7A_A9TR U23 ( .A(n274), .B(n346), .Y(n364) );
  NAND2_X0P5A_A9TR U24 ( .A(n411), .B(n385), .Y(n421) );
  INV_X0P7M_A9TR U25 ( .A(n468), .Y(n427) );
  NOR2_X0P7M_A9TR U26 ( .A(n411), .B(n446), .Y(n415) );
  NOR3_X1M_A9TR U27 ( .A(acc_exp[4]), .B(acc_exp[6]), .C(acc_exp[5]), .Y(n386)
         );
  INV_X0P7M_A9TR U28 ( .A(n418), .Y(acc_exp[4]) );
  INV_X1M_A9TR U29 ( .A(n338), .Y(n356) );
  INV_X0P6M_A9TR U30 ( .A(n385), .Y(acc_exp[2]) );
  AOI22_X0P7M_A9TR U31 ( .A0(n139), .A1(n361), .B0(n156), .B1(n208), .Y(n385)
         );
  NAND2_X1A_A9TR U32 ( .A(n208), .B(n162), .Y(n169) );
  AO22_X0P5M_A9TR U33 ( .A0(n144), .A1(n208), .B0(n361), .B1(n143), .Y(
        acc_exp[6]) );
  OR2_X1M_A9TR U34 ( .A(n112), .B(n92), .Y(n177) );
  INV_X3M_A9TR U35 ( .A(n175), .Y(n149) );
  NOR2_X4A_A9TR U36 ( .A(n69), .B(n58), .Y(n175) );
  AOI22BB_X1M_A9TR U37 ( .A0(n54), .A1(n53), .B0N(n57), .B1N(n52), .Y(n69) );
  NAND2_X1A_A9TR U38 ( .A(n48), .B(n38), .Y(n39) );
  NAND4_X2A_A9TR U39 ( .A(n25), .B(n225), .C(n222), .D(n56), .Y(n48) );
  INV_X1M_A9TR U40 ( .A(n91), .Y(n56) );
  NOR3_X0P7M_A9TR U41 ( .A(n45), .B(n44), .C(n91), .Y(n46) );
  NAND3_X2A_A9TR U42 ( .A(n34), .B(n264), .C(n288), .Y(n91) );
  INV_X1M_A9TR U43 ( .A(n300), .Y(n391) );
  INV_X1M_A9TR U44 ( .A(n42), .Y(n403) );
  AND2_X0P5B_A9TR U45 ( .A(mant_in[28]), .B(mant_in[17]), .Y(n17) );
  AND2_X0P5B_A9TR U46 ( .A(mant_in[28]), .B(mant_in[18]), .Y(n16) );
  NAND2B_X1M_A9TR U47 ( .AN(n435), .B(n434), .Y(fp8_out[1]) );
  AO21A1AI2_X0P7M_A9TR U48 ( .A0(n413), .A1(n427), .B0(n409), .C0(n477), .Y(
        n478) );
  INV_X1M_A9TR U49 ( .A(n436), .Y(n444) );
  OAI21_X0P7M_A9TR U50 ( .A0(n476), .A1(n409), .B0(n413), .Y(n477) );
  NAND3_X1A_A9TR U51 ( .A(n386), .B(n445), .C(n383), .Y(n432) );
  NOR2_X0P7M_A9TR U52 ( .A(n473), .B(n475), .Y(n476) );
  NOR2_X1A_A9TR U53 ( .A(n431), .B(n430), .Y(n439) );
  INV_X0P6M_A9TR U54 ( .A(n472), .Y(n473) );
  NAND4_X0P7M_A9TR U55 ( .A(n466), .B(n465), .C(n464), .D(n463), .Y(n471) );
  AOI22BB_X0P7M_A9TR U56 ( .A0(n411), .A1(n474), .B0N(n426), .B1N(n411), .Y(
        n412) );
  NOR2_X1A_A9TR U57 ( .A(acc_mant_27_), .B(acc_exp[0]), .Y(n410) );
  AO21A1AI2_X0P7M_A9TR U58 ( .A0(n415), .A1(acc_mant_27_), .B0(n411), .C0(n414), .Y(n416) );
  NOR3_X0P5A_A9TR U59 ( .A(acc_mant_21_), .B(acc_mant_18_), .C(acc_mant_20_), 
        .Y(n463) );
  INV_X1M_A9TR U60 ( .A(acc_mant_25__BAR), .Y(acc_mant_25_) );
  OA1B2_X1M_A9TR U61 ( .B0(n401), .B1(n359), .A0N(n400), .Y(n405) );
  INV_X1M_A9TR U62 ( .A(n312), .Y(acc_mant_26__BAR) );
  NAND2_X0P7A_A9TR U63 ( .A(n218), .B(n338), .Y(n335) );
  OAI21_X0P7M_A9TR U64 ( .A0(n321), .A1(n397), .B0(n184), .Y(n218) );
  NAND2_X0P5A_A9TR U65 ( .A(n284), .B(n356), .Y(n285) );
  NAND2_X0P7A_A9TR U66 ( .A(n336), .B(n356), .Y(n206) );
  NOR2_X0P5A_A9TR U67 ( .A(n211), .B(n338), .Y(n220) );
  INV_X1M_A9TR U68 ( .A(n440), .Y(n451) );
  AOI21_X1M_A9TR U69 ( .A0(n397), .A1(n281), .B0(n257), .Y(n258) );
  NAND2_X0P7A_A9TR U70 ( .A(n364), .B(n356), .Y(n246) );
  AO21A1AI2_X0P7M_A9TR U71 ( .A0(n301), .A1(n394), .B0(n256), .C0(n338), .Y(
        n257) );
  NOR2_X0P5A_A9TR U72 ( .A(n242), .B(n393), .Y(n183) );
  NOR2_X0P5A_A9TR U73 ( .A(n421), .B(acc_exp[3]), .Y(n387) );
  NOR2_X0P5A_A9TR U74 ( .A(n251), .B(n301), .Y(n252) );
  INV_X1M_A9TR U75 ( .A(acc_exp[0]), .Y(n446) );
  INV_X1M_A9TR U76 ( .A(n162), .Y(n114) );
  INV_X1M_A9TR U77 ( .A(n112), .Y(n96) );
  INV_X1M_A9TR U78 ( .A(n101), .Y(n105) );
  NAND2_X1A_A9TR U79 ( .A(n84), .B(n83), .Y(n85) );
  NAND3_X1A_A9TR U80 ( .A(n188), .B(n82), .C(n314), .Y(n81) );
  NAND2_X0P7A_A9TR U81 ( .A(n82), .B(n334), .Y(n84) );
  NAND3_X1A_A9TR U82 ( .A(n73), .B(n209), .C(n325), .Y(n71) );
  NAND3B_X1M_A9TR U83 ( .AN(n57), .B(n56), .C(n190), .Y(n58) );
  OAI21_X1M_A9TR U84 ( .A0(n50), .A1(n49), .B0(n54), .Y(n67) );
  NOR2_X0P7M_A9TR U85 ( .A(n164), .B(n161), .Y(acc_exp[7]) );
  NAND2B_X0P7M_A9TR U86 ( .AN(n56), .B(n43), .Y(n40) );
  INV_X1M_A9TR U87 ( .A(n43), .Y(n32) );
  NOR2_X0P5A_A9TR U88 ( .A(n143), .B(n146), .Y(n124) );
  INV_X0P7M_A9TR U89 ( .A(n334), .Y(n188) );
  AO21B_X0P7M_A9TR U90 ( .A0(mant_in[28]), .A1(mant_in[16]), .B0N(n26), .Y(
        n186) );
  INV_X0P7M_A9TR U91 ( .A(mant_in[27]), .Y(n21) );
  OAI22_X1M_A9TR U92 ( .A0(n452), .A1(n451), .B0(n450), .B1(n449), .Y(
        fp8_out[3]) );
  AOI211_X1M_A9TR U93 ( .A0(n431), .A1(n430), .B0(n439), .C0(n479), .Y(n435)
         );
  NOR2_X1A_A9TR U94 ( .A(n451), .B(n432), .Y(n467) );
  NAND2_X1A_A9TR U95 ( .A(n448), .B(n450), .Y(n479) );
  OAI21_X1M_A9TR U96 ( .A0(n389), .A1(n382), .B0(n381), .Y(n384) );
  NAND2_X1A_A9TR U97 ( .A(n439), .B(n429), .Y(n450) );
  OR2_X1M_A9TR U98 ( .A(n409), .B(n413), .Y(n431) );
  NAND2_X1A_A9TR U99 ( .A(n427), .B(n412), .Y(n413) );
  AOI22_X0P5M_A9TR U100 ( .A0(n447), .A1(n373), .B0(acc_exp[3]), .B1(n445), 
        .Y(n388) );
  NAND2_X1A_A9TR U101 ( .A(n417), .B(n427), .Y(n430) );
  NOR4BB_X0P5M_A9TR U102 ( .AN(n462), .BN(n461), .C(acc_mant_15_), .D(
        acc_mant_16_), .Y(n466) );
  AND2_X2M_A9TR U103 ( .A(n481), .B(acc_mant_25_), .Y(n441) );
  OAI21_X1M_A9TR U104 ( .A0(n405), .A1(n404), .B0(n403), .Y(acc_mant_27_) );
  NAND3BB_X0P5M_A9TR U105 ( .AN(acc_mant_11_), .BN(acc_mant_10_), .C(n458), 
        .Y(n459) );
  OAI22_X0P5M_A9TR U106 ( .A0(n324), .A1(n367), .B0(n401), .B1(n365), .Y(
        acc_mant_11_) );
  OA22_X1M_A9TR U107 ( .A0(n220), .A1(n219), .B0(n335), .B1(n359), .Y(n221) );
  NOR3_X0P5A_A9TR U108 ( .A(acc_mant_13_), .B(acc_mant_14_), .C(acc_mant_12_), 
        .Y(n458) );
  OAI22_X0P5M_A9TR U109 ( .A0(n273), .A1(n272), .B0(n362), .B1(n359), .Y(
        acc_mant_20_) );
  OAI22_X0P5M_A9TR U110 ( .A0(n315), .A1(n359), .B0(n283), .B1(n282), .Y(
        acc_mant_21_) );
  OAI22_X0P5M_A9TR U111 ( .A0(n345), .A1(n344), .B0(n343), .B1(n359), .Y(
        acc_mant_22_) );
  OAI21_X0P5M_A9TR U112 ( .A0(n349), .A1(n356), .B0(n323), .Y(n401) );
  OAI22_X0P5M_A9TR U113 ( .A0(n368), .A1(n367), .B0(n366), .B1(n365), .Y(
        acc_mant_8_) );
  AOI21_X0P5M_A9TR U114 ( .A0(n240), .A1(n359), .B0(n239), .Y(acc_mant_16_) );
  NAND2_X0P5A_A9TR U115 ( .A(n356), .B(n350), .Y(n323) );
  OAI21_X1M_A9TR U116 ( .A0(n295), .A1(n338), .B0(n294), .Y(n296) );
  OAI21_X1M_A9TR U117 ( .A0(n309), .A1(n338), .B0(n308), .Y(n310) );
  OAI2XB1_X1M_A9TR U118 ( .A1N(n338), .A0(n286), .B0(n285), .Y(n366) );
  NAND2_X0P5A_A9TR U119 ( .A(n322), .B(n397), .Y(n184) );
  NAND2_X0P5A_A9TR U120 ( .A(n322), .B(n346), .Y(n350) );
  OAI211_X1M_A9TR U121 ( .A0(n346), .A1(n293), .B0(n338), .C0(n292), .Y(n294)
         );
  AOI21_X0P5M_A9TR U122 ( .A0(n253), .A1(n301), .B0(n252), .Y(n281) );
  AOI21_X0P5M_A9TR U123 ( .A0(n245), .A1(n393), .B0(n183), .Y(n322) );
  NAND2_X0P5A_A9TR U124 ( .A(n269), .B(n346), .Y(n284) );
  OAI21_X0P5M_A9TR U125 ( .A0(n234), .A1(n393), .B0(n196), .Y(n204) );
  AOI21_X0P5M_A9TR U126 ( .A0(n253), .A1(n393), .B0(n216), .Y(n396) );
  AO21A1AI2_X0P5M_A9TR U127 ( .A0(n394), .A1(n393), .B0(n392), .C0(n338), .Y(
        n395) );
  AO21B_X0P5M_A9TR U128 ( .A0(n238), .A1(n393), .B0N(n237), .Y(n271) );
  OAI21_X0P5M_A9TR U129 ( .A0(n347), .A1(n346), .B0(n338), .Y(n217) );
  NAND2_X0P5A_A9TR U130 ( .A(n299), .B(n393), .Y(n306) );
  OAI211_X0P5M_A9TR U131 ( .A0(n304), .A1(n303), .B0(n302), .C0(n301), .Y(n305) );
  NOR2_X0P7M_A9TR U132 ( .A(n245), .B(n393), .Y(n274) );
  NAND2_X0P5A_A9TR U133 ( .A(n299), .B(n301), .Y(n291) );
  NAND2_X0P5A_A9TR U134 ( .A(n236), .B(n301), .Y(n237) );
  NOR2_X0P5A_A9TR U135 ( .A(n255), .B(n393), .Y(n216) );
  NOR2_X0P5A_A9TR U136 ( .A(n393), .B(n199), .Y(n269) );
  NAND2_X0P5A_A9TR U137 ( .A(n304), .B(n300), .Y(n302) );
  NAND2_X0P5A_A9TR U138 ( .A(n304), .B(n180), .Y(n199) );
  INV_X2M_A9TR U139 ( .A(n397), .Y(n346) );
  AOI22_X0P5M_A9TR U140 ( .A0(n176), .A1(n361), .B0(n150), .B1(n208), .Y(n418)
         );
  AO22_X0P5M_A9TR U141 ( .A0(n147), .A1(n208), .B0(n361), .B1(n146), .Y(
        acc_exp[5]) );
  NOR2_X2A_A9TR U142 ( .A(n166), .B(n165), .Y(n207) );
  AOI31_X2M_A9TR U143 ( .A0(n125), .A1(n124), .A2(n123), .B0(n160), .Y(n166)
         );
  AO21B_X1M_A9TR U144 ( .A0(n117), .A1(n175), .B0N(n176), .Y(n125) );
  NAND2B_X1M_A9TR U145 ( .AN(n117), .B(n149), .Y(n123) );
  AND2_X1M_A9TR U146 ( .A(n97), .B(n96), .Y(n174) );
  NOR2_X2A_A9TR U147 ( .A(n110), .B(n90), .Y(n112) );
  AOI22BB_X1M_A9TR U148 ( .A0(n175), .A1(n87), .B0N(n86), .B1N(n85), .Y(n110)
         );
  NAND2_X1A_A9TR U149 ( .A(n77), .B(n76), .Y(n80) );
  NOR2XB_X2M_A9TR U150 ( .BN(n77), .A(n76), .Y(n82) );
  AO21B_X1M_A9TR U151 ( .A0(n67), .A1(n149), .B0N(n66), .Y(n77) );
  NAND3_X1A_A9TR U152 ( .A(n209), .B(n324), .C(n175), .Y(n66) );
  NOR2_X0P5A_A9TR U153 ( .A(n175), .B(n91), .Y(n92) );
  NAND2B_X0P5M_A9TR U154 ( .AN(n164), .B(n163), .Y(n165) );
  NAND2B_X1M_A9TR U155 ( .AN(n48), .B(n132), .Y(n54) );
  INV_X1B_A9TR U156 ( .A(n48), .Y(n49) );
  AOI21_X0P5M_A9TR U157 ( .A0(n47), .A1(n91), .B0(n46), .Y(n50) );
  NOR3_X2A_A9TR U158 ( .A(n290), .B(n214), .C(n32), .Y(n34) );
  AOI21_X0P5M_A9TR U159 ( .A0(n141), .A1(n140), .B0(n160), .Y(n163) );
  NAND2_X1A_A9TR U160 ( .A(n391), .B(n403), .Y(n22) );
  NOR2_X1A_A9TR U161 ( .A(n186), .B(n185), .Y(n132) );
  INV_X0P7M_A9TR U162 ( .A(n68), .Y(n324) );
  NAND2B_X0P5M_A9TR U163 ( .AN(n195), .B(n197), .Y(n111) );
  AO21B_X0P5M_A9TR U164 ( .A0(mant_in[28]), .A1(mant_in[6]), .B0N(n63), .Y(
        n179) );
  AO21B_X0P5M_A9TR U165 ( .A0(mant_in[28]), .A1(mant_in[4]), .B0N(n103), .Y(
        n195) );
  AOI2XB1_X0P5M_A9TR U166 ( .A1N(mant_in[28]), .A0(mant_in[0]), .B0(n126), .Y(
        n173) );
  OAI21_X0P5M_A9TR U167 ( .A0(mant_in[28]), .A1(n9), .B0(n8), .Y(n146) );
  AO21B_X0P5M_A9TR U168 ( .A0(mant_in[28]), .A1(mant_in[10]), .B0N(n70), .Y(
        n325) );
  OAI21_X0P5M_A9TR U169 ( .A0(mant_in[28]), .A1(n28), .B0(n27), .Y(n185) );
  AO21B_X0P5M_A9TR U170 ( .A0(mant_in[12]), .A1(mant_in[28]), .B0N(n65), .Y(
        n68) );
  OAI21_X0P5M_A9TR U171 ( .A0(mant_in[28]), .A1(n5), .B0(n4), .Y(n143) );
  AO21B_X0P5M_A9TR U172 ( .A0(mant_in[28]), .A1(mant_in[25]), .B0N(n31), .Y(
        n289) );
  AO21B_X0P5M_A9TR U173 ( .A0(mant_in[28]), .A1(mant_in[2]), .B0N(n106), .Y(
        n198) );
  AO21B_X0P5M_A9TR U174 ( .A0(mant_in[28]), .A1(mant_in[3]), .B0N(n102), .Y(
        n197) );
  AO21B_X0P5M_A9TR U175 ( .A0(mant_in[8]), .A1(mant_in[28]), .B0N(n78), .Y(
        n334) );
  NAND2_X0P5A_A9TR U176 ( .A(mant_in[28]), .B(n120), .Y(n121) );
  NAND2B_X0P7M_A9TR U177 ( .AN(mant_in[28]), .B(mant_in[26]), .Y(n20) );
  NAND2_X0P5A_A9TR U178 ( .A(mant_in[28]), .B(mant_in[15]), .Y(n27) );
  NAND2B_X0P5M_A9TR U179 ( .AN(mant_in[28]), .B(mant_in[15]), .Y(n26) );
  NAND2B_X0P5M_A9TR U180 ( .AN(mant_in[28]), .B(mant_in[18]), .Y(n15) );
  NAND2B_X0P5M_A9TR U181 ( .AN(mant_in[28]), .B(mant_in[11]), .Y(n65) );
  NAND2B_X0P5M_A9TR U182 ( .AN(mant_in[28]), .B(mant_in[19]), .Y(n14) );
  AOI221_X0P7M_A9TR U183 ( .A0(n447), .A1(n446), .B0(n445), .B1(acc_exp[0]), 
        .C0(n444), .Y(n452) );
  OA21A1OI2_X0P7M_A9TR U184 ( .A0(n429), .A1(n439), .B0(n438), .C0(n437), .Y(
        n443) );
  INV_X0P6M_A9TR U185 ( .A(n479), .Y(n438) );
  AO21A1AI2_X0P7M_A9TR U186 ( .A0(n471), .A1(acc_mant_23_), .B0(acc_mant_24_), 
        .C0(n467), .Y(n480) );
  NOR2_X1M_A9TR U187 ( .A(n451), .B(n436), .Y(n437) );
  OAI21_X1P4M_A9TR U188 ( .A0(n384), .A1(n445), .B0(n432), .Y(n436) );
  AOI22_X0P7M_A9TR U189 ( .A0(n447), .A1(n369), .B0(acc_exp[1]), .B1(n445), 
        .Y(n389) );
  OAI211_X0P5M_A9TR U190 ( .A0(n441), .A1(n312), .B0(n445), .C0(n440), .Y(n442) );
  AND3_X0P7M_A9TR U191 ( .A(n428), .B(n427), .C(n426), .Y(n429) );
  NAND2_X2B_A9TR U192 ( .A(n441), .B(n312), .Y(n445) );
  OR2_X1M_A9TR U193 ( .A(n407), .B(n408), .Y(n409) );
  OA21_X0P5M_A9TR U194 ( .A0(n469), .A1(acc_exp[1]), .B0(n406), .Y(n407) );
  AND2_X0P5B_A9TR U195 ( .A(acc_exp[0]), .B(acc_mant_25__BAR), .Y(n408) );
  OAI22BB_X0P5M_A9TR U196 ( .A0(n335), .A1(n365), .B0N(n361), .B1N(n334), .Y(
        acc_mant_7_) );
  OA1B2_X0P5M_A9TR U197 ( .B0(n338), .B1(n399), .A0N(n398), .Y(n400) );
  AOI21_X0P5M_A9TR U198 ( .A0(n312), .A1(acc_exp[1]), .B0(acc_exp[0]), .Y(n406) );
  OA1B2_X0P5M_A9TR U199 ( .B0(n218), .B1(n338), .A0N(n187), .Y(acc_mant_15_)
         );
  OAI22BB_X0P5M_A9TR U200 ( .A0(n311), .A1(n365), .B0N(n361), .B1N(n210), .Y(
        acc_mant_10_) );
  OAI2XB1_X0P5M_A9TR U201 ( .A1N(n328), .A0(n327), .B0(n326), .Y(acc_mant_9_)
         );
  NOR2_X0P5A_A9TR U202 ( .A(n337), .B(n338), .Y(n345) );
  OAI21_X0P5M_A9TR U203 ( .A0(n271), .A1(n397), .B0(n270), .Y(n317) );
  OA21_X0P5M_A9TR U204 ( .A0(n350), .A1(n356), .B0(n355), .Y(n351) );
  OA21_X0P5M_A9TR U205 ( .A0(n336), .A1(n356), .B0(n355), .Y(n228) );
  MXIT2_X0P5M_A9TR U206 ( .A(n276), .B(n278), .S0(n346), .Y(n354) );
  MXIT2_X0P5M_A9TR U207 ( .A(n348), .B(n347), .S0(n346), .Y(n399) );
  OAI21_X0P5M_A9TR U208 ( .A0(n204), .A1(n397), .B0(n200), .Y(n313) );
  OA1B2_X0P5M_A9TR U209 ( .B0(n284), .B1(n356), .A0N(n359), .Y(n239) );
  MXIT2_X0P5M_A9TR U210 ( .A(n277), .B(n279), .S0(n346), .Y(n353) );
  OA21_X0P5M_A9TR U211 ( .A0(n364), .A1(n356), .B0(n355), .Y(n357) );
  OAI21_X0P5M_A9TR U212 ( .A0(n276), .A1(n397), .B0(n275), .Y(n331) );
  MXIT2_X0P5M_A9TR U213 ( .A(n203), .B(n226), .S0(n346), .Y(n337) );
  MXIT2_X0P5M_A9TR U214 ( .A(n321), .B(n320), .S0(n346), .Y(n349) );
  MXIT2_X0P5M_A9TR U215 ( .A(n247), .B(n250), .S0(n301), .Y(n348) );
  MXIT2_X0P5M_A9TR U216 ( .A(n249), .B(n251), .S0(n301), .Y(n347) );
  MXIT2_X0P5M_A9TR U217 ( .A(n248), .B(n247), .S0(n301), .Y(n277) );
  MXIT2_X0P5M_A9TR U218 ( .A(n243), .B(n248), .S0(n301), .Y(n320) );
  MXIT2_X0P5M_A9TR U219 ( .A(n230), .B(n233), .S0(n301), .Y(n226) );
  MXIT2_X0P5M_A9TR U220 ( .A(n298), .B(n297), .S0(n301), .Y(n340) );
  MXIT2_X0P5M_A9TR U221 ( .A(n241), .B(n244), .S0(n301), .Y(n321) );
  MXIT2_X0P5M_A9TR U222 ( .A(n235), .B(n231), .S0(n301), .Y(n203) );
  MXIT2_X0P5M_A9TR U223 ( .A(n242), .B(n241), .S0(n301), .Y(n276) );
  NAND2_X0P7A_A9TR U224 ( .A(n306), .B(n305), .Y(n307) );
  AND2_X0P5B_A9TR U225 ( .A(n301), .B(n391), .Y(n392) );
  MXIT2_X0P5M_A9TR U226 ( .A(n244), .B(n243), .S0(n301), .Y(n278) );
  NAND2_X0P5A_A9TR U227 ( .A(n236), .B(n393), .Y(n196) );
  MXIT2_X0P5M_A9TR U228 ( .A(n250), .B(n249), .S0(n301), .Y(n279) );
  MXIT2_X0P5M_A9TR U229 ( .A(n232), .B(n266), .S0(n301), .Y(n339) );
  MXIT2_X0P5M_A9TR U230 ( .A(n235), .B(n234), .S0(n393), .Y(n262) );
  MXIT2_X0P5M_A9TR U231 ( .A(n233), .B(n232), .S0(n301), .Y(n263) );
  MXIT2_X0P5M_A9TR U232 ( .A(n231), .B(n230), .S0(n301), .Y(n261) );
  MXIT2_X0P5M_A9TR U233 ( .A(n266), .B(n298), .S0(n301), .Y(n293) );
  MXIT2_X0P5M_A9TR U234 ( .A(n191), .B(n223), .S0(n304), .Y(n250) );
  MXIT2_X0P5M_A9TR U235 ( .A(n223), .B(n222), .S0(n304), .Y(n232) );
  MXIT2_X0P5M_A9TR U236 ( .A(n225), .B(n224), .S0(n304), .Y(n266) );
  MXIT2_X0P5M_A9TR U237 ( .A(n222), .B(n225), .S0(n304), .Y(n249) );
  MXIT2_X0P5M_A9TR U238 ( .A(n265), .B(n264), .S0(n304), .Y(n298) );
  INV_X2M_A9TR U239 ( .A(n393), .Y(n301) );
  NAND2_X0P7A_A9TR U240 ( .A(n402), .B(n359), .Y(n365) );
  MXIT2_X0P5M_A9TR U241 ( .A(n213), .B(n212), .S0(n304), .Y(n253) );
  AOI22_X2M_A9TR U242 ( .A0(n207), .A1(n176), .B0(n208), .B1(n175), .Y(n359)
         );
  AND2_X2M_A9TR U243 ( .A(n166), .B(n137), .Y(n208) );
  NAND2XB_X1M_A9TR U244 ( .BN(n171), .A(n170), .Y(n158) );
  MXIT2_X1M_A9TR U245 ( .A(n105), .B(n104), .S0(n112), .Y(n162) );
  NOR2_X1A_A9TR U246 ( .A(n179), .B(n89), .Y(n87) );
  NAND3B_X1M_A9TR U247 ( .AN(n89), .B(n175), .C(n194), .Y(n90) );
  OAI21B_X1M_A9TR U248 ( .A0(n175), .A1(n75), .B0N(n82), .Y(n97) );
  NAND3_X1A_A9TR U249 ( .A(n83), .B(n175), .C(n368), .Y(n76) );
  NAND2XB_X1M_A9TR U250 ( .BN(n75), .A(n67), .Y(n57) );
  NAND2_X0P5A_A9TR U251 ( .A(n56), .B(n192), .Y(n52) );
  NOR2B_X0P7M_A9TR U252 ( .AN(n136), .B(n135), .Y(n164) );
  OAI22_X0P5M_A9TR U253 ( .A0(n37), .A1(n36), .B0(n130), .B1(n91), .Y(n38) );
  AOI21_X0P5M_A9TR U254 ( .A0(n265), .A1(n44), .B0(n91), .Y(n36) );
  OAI31_X0P5M_A9TR U255 ( .A0(n43), .A1(n42), .A2(n300), .B0(n41), .Y(n47) );
  NAND2_X0P5A_A9TR U256 ( .A(n288), .B(n34), .Y(n129) );
  OAI22_X0P5M_A9TR U257 ( .A0(n33), .A1(n42), .B0(n32), .B1(n290), .Y(n35) );
  AOI21_X0P5M_A9TR U258 ( .A0(n303), .A1(n289), .B0(n300), .Y(n33) );
  NOR2_X1M_A9TR U259 ( .A(n45), .B(n44), .Y(n25) );
  AOI2XB1_X0P7M_A9TR U260 ( .A1N(mant_in[28]), .A0(mant_in[6]), .B0(n79), .Y(
        n314) );
  AOI2XB1_X0P7M_A9TR U261 ( .A1N(mant_in[28]), .A0(exp_in[2]), .B0(n95), .Y(
        n138) );
  AOI2XB1_X0P7M_A9TR U262 ( .A1N(mant_in[28]), .A0(mant_in[13]), .B0(n51), .Y(
        n192) );
  AOI2XB1_X0P7M_A9TR U263 ( .A1N(mant_in[28]), .A0(mant_in[4]), .B0(n88), .Y(
        n194) );
  AO21B_X0P7M_A9TR U264 ( .A0(mant_in[20]), .A1(mant_in[28]), .B0N(n14), .Y(
        n45) );
  NAND2B_X0P5M_A9TR U265 ( .AN(mant_in[28]), .B(mant_in[7]), .Y(n78) );
  XOR2_X0P5M_A9TR U266 ( .A(exp_in[0]), .B(mant_in[28]), .Y(n171) );
  NAND2B_X0P7M_A9TR U267 ( .AN(mant_in[28]), .B(mant_in[22]), .Y(n19) );
  NAND2B_X0P5M_A9TR U268 ( .AN(mant_in[28]), .B(mant_in[5]), .Y(n63) );
  AND2_X0P5B_A9TR U269 ( .A(mant_in[28]), .B(mant_in[14]), .Y(n51) );
  NAND2B_X0P5M_A9TR U270 ( .AN(mant_in[28]), .B(mant_in[9]), .Y(n70) );
  NAND2B_X0P7M_A9TR U271 ( .AN(mant_in[28]), .B(mant_in[23]), .Y(n18) );
  AND2_X0P5B_A9TR U272 ( .A(mant_in[28]), .B(mant_in[26]), .Y(n29) );
  NOR2_X0P5A_A9TR U273 ( .A(n340), .B(n397), .Y(n341) );
  NOR2_X0P5A_A9TR U274 ( .A(acc_mant_6_), .B(acc_mant_5_), .Y(n454) );
  NAND2_X1A_A9TR U275 ( .A(n177), .B(n162), .Y(n107) );
  INV_X0P5B_A9TR U276 ( .A(n164), .Y(n137) );
  MXIT2_X0P5M_A9TR U277 ( .A(n192), .B(n191), .S0(n304), .Y(n233) );
  MXIT2_X0P5M_A9TR U278 ( .A(n194), .B(n193), .S0(n304), .Y(n241) );
  MXIT2_X0P5M_A9TR U279 ( .A(n314), .B(n188), .S0(n304), .Y(n244) );
  MXIT2_X0P5M_A9TR U280 ( .A(n368), .B(n189), .S0(n304), .Y(n243) );
  MXIT2_X0P5M_A9TR U281 ( .A(n190), .B(n192), .S0(n304), .Y(n247) );
  MXIT2_X0P5M_A9TR U282 ( .A(n209), .B(n324), .S0(n304), .Y(n248) );
  MXIT2_X0P5M_A9TR U283 ( .A(n195), .B(n360), .S0(n304), .Y(n236) );
  MXIT2_X0P5M_A9TR U284 ( .A(n188), .B(n368), .S0(n304), .Y(n235) );
  MXIT2_X0P5M_A9TR U285 ( .A(n193), .B(n314), .S0(n304), .Y(n234) );
  MXIT2_X0P5M_A9TR U286 ( .A(n189), .B(n209), .S0(n304), .Y(n231) );
  MXIT2_X0P5M_A9TR U287 ( .A(n324), .B(n190), .S0(n304), .Y(n230) );
  MXIT2_X0P5M_A9TR U288 ( .A(n182), .B(n181), .S0(n304), .Y(n242) );
  MXIT2_X0P5M_A9TR U289 ( .A(n198), .B(n197), .S0(n304), .Y(n238) );
  MXIT2_X0P5M_A9TR U290 ( .A(n180), .B(n198), .S0(n304), .Y(n245) );
  AND2_X0P5B_A9TR U291 ( .A(mant_in[28]), .B(n94), .Y(n95) );
  OA21_X1M_A9TR U292 ( .A0(n73), .A1(n72), .B0(n71), .Y(n83) );
  NOR2_X1A_A9TR U293 ( .A(n68), .B(n149), .Y(n73) );
  NAND2_X1A_A9TR U294 ( .A(n97), .B(n101), .Y(n89) );
  CGENI_X1M_A9TR U295 ( .A(n152), .B(n178), .CI(n116), .CON(n117) );
  CGENI_X1M_A9TR U296 ( .A(n138), .B(n115), .CI(n174), .CON(n116) );
  NOR2_X0P5A_A9TR U297 ( .A(n453), .B(acc_mant_4_), .Y(n456) );
  NOR2_X0P5A_A9TR U298 ( .A(acc_mant_7_), .B(acc_mant_9_), .Y(n455) );
  AO21B_X1M_A9TR U299 ( .A0(mant_in[28]), .A1(mant_in[27]), .B0N(n20), .Y(n300) );
  NAND2B_X1M_A9TR U300 ( .AN(mant_in[28]), .B(n21), .Y(n42) );
  MXIT2_X0P5M_A9TR U301 ( .A(n289), .B(n254), .S0(n304), .Y(n394) );
  MXIT2_X0P5M_A9TR U302 ( .A(n290), .B(n289), .S0(n304), .Y(n299) );
  MXIT2_X0P5M_A9TR U303 ( .A(n287), .B(n215), .S0(n304), .Y(n255) );
  MXIT2_X0P5M_A9TR U304 ( .A(n224), .B(n265), .S0(n304), .Y(n251) );
  MXIT2_X0P5M_A9TR U305 ( .A(n238), .B(n199), .S0(n393), .Y(n205) );
  OR2_X0P7M_A9TR U306 ( .A(n208), .B(n207), .Y(n402) );
  MXIT2_X0P5M_A9TR U307 ( .A(n288), .B(n287), .S0(n304), .Y(n297) );
  MXIT2_X0P5M_A9TR U308 ( .A(n204), .B(n203), .S0(n346), .Y(n227) );
  MXIT2_X0P5M_A9TR U309 ( .A(n226), .B(n339), .S0(n346), .Y(n309) );
  MXIT2_X0P5M_A9TR U310 ( .A(n262), .B(n271), .S0(n397), .Y(n286) );
  MXIT2_X0P5M_A9TR U311 ( .A(n261), .B(n263), .S0(n346), .Y(n295) );
  MXIT2_X0P5M_A9TR U312 ( .A(n320), .B(n348), .S0(n346), .Y(n211) );
  XOR2_X0P5M_A9TR U313 ( .A(n119), .B(exp_in[7]), .Y(n120) );
  AO21A1AI2_X1M_A9TR U314 ( .A0(n112), .A1(n111), .B0(n110), .C0(n109), .Y(
        n170) );
  NAND2_X1A_A9TR U315 ( .A(n175), .B(n108), .Y(n109) );
  OR2_X0P7M_A9TR U316 ( .A(n164), .B(n163), .Y(n142) );
  NOR2XB_X0P5M_A9TR U317 ( .BN(acc_exp[7]), .A(acc_exp[6]), .Y(n468) );
  NAND3_X0P5M_A9TR U318 ( .A(n1), .B(n451), .C(n423), .Y(n424) );
  NOR2_X0P5A_A9TR U319 ( .A(n316), .B(n338), .Y(n273) );
  NOR2_X0P5A_A9TR U320 ( .A(n315), .B(n355), .Y(acc_mant_5_) );
  OAI21_X0P5M_A9TR U321 ( .A0(n339), .A1(n346), .B0(n338), .Y(n342) );
  NOR2_X0P5A_A9TR U322 ( .A(n329), .B(n338), .Y(n283) );
  MXIT2_X0P5M_A9TR U323 ( .A(n349), .B(n399), .S0(n338), .Y(n352) );
  MXIT2_X0P5M_A9TR U324 ( .A(n354), .B(n353), .S0(n338), .Y(n358) );
  NOR2_X0P5A_A9TR U325 ( .A(n202), .B(n201), .Y(acc_mant_14_) );
  NOR2_X0P5A_A9TR U326 ( .A(n333), .B(n332), .Y(acc_mant_13_) );
  NOR2_X0P5A_A9TR U327 ( .A(n319), .B(n318), .Y(acc_mant_12_) );
  OAI22_X0P5M_A9TR U328 ( .A0(n314), .A1(n367), .B0(n343), .B1(n365), .Y(
        acc_mant_6_) );
  OAI22BB_X0P5M_A9TR U329 ( .A0(n362), .A1(n365), .B0N(n361), .B1N(n360), .Y(
        acc_mant_4_) );
  INV_X0P5B_A9TR U330 ( .A(n361), .Y(n367) );
  NAND2_X1A_A9TR U331 ( .A(n443), .B(n442), .Y(fp8_out[2]) );
  AO21_X0P7M_A9TR U332 ( .A0(acc_exp[1]), .A1(acc_exp[2]), .B0(n428), .Y(n1)
         );
  NOR3_X1A_A9TR U333 ( .A(mant_in[24]), .B(mant_in[25]), .C(n22), .Y(n43) );
  CGENI_X1M_A9TR U334 ( .A(n167), .B(n114), .CI(n158), .CON(n115) );
  NOR2_X1A_A9TR U335 ( .A(n198), .B(n107), .Y(n108) );
  INV_X0P5B_A9TR U336 ( .A(exp_in[6]), .Y(n5) );
  NAND2_X0P5A_A9TR U337 ( .A(mant_in[28]), .B(n3), .Y(n4) );
  INV_X0P5B_A9TR U338 ( .A(exp_in[5]), .Y(n9) );
  ADDH_X1M_A9TR U339 ( .A(n6), .B(exp_in[5]), .CO(n118), .S(n7) );
  NAND2_X0P5A_A9TR U340 ( .A(mant_in[28]), .B(n7), .Y(n8) );
  INV_X0P5B_A9TR U341 ( .A(exp_in[4]), .Y(n13) );
  ADDH_X1M_A9TR U342 ( .A(n10), .B(exp_in[4]), .CO(n6), .S(n11) );
  NAND2_X0P5A_A9TR U343 ( .A(mant_in[28]), .B(n11), .Y(n12) );
  OAI21_X1M_A9TR U344 ( .A0(mant_in[28]), .A1(n13), .B0(n12), .Y(n176) );
  AO21B_X1M_A9TR U345 ( .A0(mant_in[19]), .A1(mant_in[28]), .B0N(n15), .Y(n44)
         );
  AOI2XB1_X1M_A9TR U346 ( .A1N(mant_in[28]), .A0(mant_in[17]), .B0(n16), .Y(
        n225) );
  AOI2XB1_X1M_A9TR U347 ( .A1N(mant_in[28]), .A0(mant_in[16]), .B0(n17), .Y(
        n222) );
  AO21B_X1M_A9TR U348 ( .A0(mant_in[28]), .A1(mant_in[24]), .B0N(n18), .Y(n290) );
  AO21B_X1M_A9TR U349 ( .A0(mant_in[23]), .A1(mant_in[28]), .B0N(n19), .Y(n214) );
  AND2_X1M_A9TR U350 ( .A(mant_in[28]), .B(mant_in[21]), .Y(n23) );
  AOI2XB1_X1M_A9TR U351 ( .A1N(mant_in[28]), .A0(mant_in[20]), .B0(n23), .Y(
        n264) );
  AND2_X1M_A9TR U352 ( .A(mant_in[28]), .B(mant_in[22]), .Y(n24) );
  AOI2XB1_X1M_A9TR U353 ( .A1N(mant_in[28]), .A0(mant_in[21]), .B0(n24), .Y(
        n288) );
  INV_X0P5B_A9TR U354 ( .A(mant_in[14]), .Y(n28) );
  INV_X0P5B_A9TR U355 ( .A(mant_in[25]), .Y(n30) );
  OA1B2_X1M_A9TR U356 ( .B0(mant_in[28]), .B1(n30), .A0N(n29), .Y(n303) );
  NAND2B_X0P5M_A9TR U357 ( .AN(mant_in[28]), .B(mant_in[24]), .Y(n31) );
  INV_X0P5B_A9TR U358 ( .A(n34), .Y(n41) );
  AOI21B_X0P5M_A9TR U359 ( .A0(n35), .A1(n41), .B0N(n129), .Y(n37) );
  INV_X0P5B_A9TR U360 ( .A(n45), .Y(n265) );
  INV_X0P5B_A9TR U361 ( .A(n44), .Y(n224) );
  NAND3_X0P5M_A9TR U362 ( .A(n265), .B(n224), .C(n225), .Y(n130) );
  OAI21_X1M_A9TR U363 ( .A0(n48), .A1(n186), .B0(n39), .Y(n53) );
  AND2_X1M_A9TR U364 ( .A(n48), .B(n40), .Y(n75) );
  AND2_X0P5B_A9TR U365 ( .A(mant_in[28]), .B(mant_in[13]), .Y(n55) );
  AOI2XB1_X1M_A9TR U366 ( .A1N(mant_in[28]), .A0(mant_in[12]), .B0(n55), .Y(
        n190) );
  INV_X0P5B_A9TR U367 ( .A(exp_in[3]), .Y(n62) );
  ADDH_X1M_A9TR U368 ( .A(n59), .B(exp_in[3]), .CO(n10), .S(n60) );
  NAND2_X0P5A_A9TR U369 ( .A(mant_in[28]), .B(n60), .Y(n61) );
  OAI21_X1M_A9TR U370 ( .A0(mant_in[28]), .A1(n62), .B0(n61), .Y(n178) );
  AND2_X0P5B_A9TR U371 ( .A(mant_in[28]), .B(mant_in[11]), .Y(n64) );
  AOI2XB1_X1M_A9TR U372 ( .A1N(mant_in[28]), .A0(mant_in[10]), .B0(n64), .Y(
        n209) );
  NOR2_X0P5A_A9TR U373 ( .A(n69), .B(n175), .Y(n72) );
  AND2_X0P5B_A9TR U374 ( .A(mant_in[28]), .B(mant_in[9]), .Y(n74) );
  AOI2XB1_X1M_A9TR U375 ( .A1N(mant_in[28]), .A0(mant_in[8]), .B0(n74), .Y(
        n368) );
  AND2_X0P5B_A9TR U376 ( .A(mant_in[28]), .B(mant_in[7]), .Y(n79) );
  NAND2_X1A_A9TR U377 ( .A(n80), .B(n81), .Y(n101) );
  INV_X1M_A9TR U378 ( .A(n81), .Y(n86) );
  AND2_X0P5B_A9TR U379 ( .A(mant_in[28]), .B(mant_in[5]), .Y(n88) );
  ADDH_X1M_A9TR U380 ( .A(n93), .B(exp_in[2]), .CO(n59), .S(n94) );
  INV_X0P5B_A9TR U381 ( .A(n174), .Y(n155) );
  INV_X0P5B_A9TR U382 ( .A(exp_in[1]), .Y(n100) );
  ADDH_X1M_A9TR U383 ( .A(exp_in[0]), .B(exp_in[1]), .CO(n93), .S(n98) );
  NAND2_X0P5A_A9TR U384 ( .A(mant_in[28]), .B(n98), .Y(n99) );
  OAI21_X1M_A9TR U385 ( .A0(mant_in[28]), .A1(n100), .B0(n99), .Y(n167) );
  NAND2B_X0P5M_A9TR U386 ( .AN(mant_in[28]), .B(mant_in[2]), .Y(n102) );
  NAND2B_X0P5M_A9TR U387 ( .AN(mant_in[28]), .B(mant_in[3]), .Y(n103) );
  OR2_X0P7M_A9TR U388 ( .A(n197), .B(n195), .Y(n104) );
  NAND2B_X0P5M_A9TR U389 ( .AN(mant_in[28]), .B(mant_in[1]), .Y(n106) );
  OR2_X0P7M_A9TR U390 ( .A(n146), .B(n145), .Y(n113) );
  XNOR2_X0P5M_A9TR U391 ( .A(n143), .B(n113), .Y(n144) );
  INV_X0P5B_A9TR U392 ( .A(exp_in[7]), .Y(n122) );
  ADDH_X1M_A9TR U393 ( .A(n118), .B(exp_in[6]), .CO(n119), .S(n3) );
  OAI21_X1M_A9TR U394 ( .A0(mant_in[28]), .A1(n122), .B0(n121), .Y(n160) );
  INV_X0P5B_A9TR U395 ( .A(n325), .Y(n189) );
  NAND4_X0P5M_A9TR U396 ( .A(n189), .B(n368), .C(n188), .D(n314), .Y(n128) );
  AND2_X0P5B_A9TR U397 ( .A(mant_in[28]), .B(mant_in[1]), .Y(n126) );
  NAND4_X0P5M_A9TR U398 ( .A(n173), .B(n194), .C(n209), .D(n324), .Y(n127) );
  NOR3_X0P5A_A9TR U399 ( .A(n129), .B(n128), .C(n127), .Y(n136) );
  NOR4BB_X0P5M_A9TR U400 ( .AN(n192), .BN(n190), .C(n179), .D(n195), .Y(n134)
         );
  NOR3BB_X0P5M_A9TR U401 ( .AN(n222), .BN(n264), .C(n130), .Y(n133) );
  NOR2_X0P5A_A9TR U402 ( .A(n198), .B(n197), .Y(n131) );
  NAND4_X0P5M_A9TR U403 ( .A(n134), .B(n133), .C(n132), .D(n131), .Y(n135) );
  NOR2_X0P5A_A9TR U404 ( .A(n171), .B(n167), .Y(n141) );
  INV_X0P5B_A9TR U405 ( .A(n138), .Y(n139) );
  NOR3_X0P5A_A9TR U406 ( .A(n176), .B(n178), .C(n139), .Y(n140) );
  XNOR2_X0P5M_A9TR U407 ( .A(n146), .B(n145), .Y(n147) );
  ADDF_X1M_A9TR U408 ( .A(n176), .B(n149), .CI(n148), .CO(n145), .S(n150) );
  ADDF_X1M_A9TR U409 ( .A(n178), .B(n152), .CI(n151), .CO(n148), .S(n153) );
  AO22_X1M_A9TR U410 ( .A0(n178), .A1(n361), .B0(n153), .B1(n208), .Y(
        acc_exp[3]) );
  ADDF_X1M_A9TR U411 ( .A(n139), .B(n155), .CI(n154), .CO(n151), .S(n156) );
  XOR2_X0P5M_A9TR U412 ( .A(n171), .B(n170), .Y(n157) );
  AO22_X1M_A9TR U413 ( .A0(n171), .A1(n361), .B0(n208), .B1(n157), .Y(
        acc_exp[0]) );
  ADDF_X1M_A9TR U414 ( .A(n167), .B(n114), .CI(n158), .CO(n154), .S(n159) );
  AO22_X1M_A9TR U415 ( .A0(n361), .A1(n167), .B0(n208), .B1(n159), .Y(
        acc_exp[1]) );
  INV_X0P5B_A9TR U416 ( .A(n160), .Y(n161) );
  NAND2_X1A_A9TR U417 ( .A(n207), .B(n167), .Y(n168) );
  AOI22_X1M_A9TR U418 ( .A0(n171), .A1(n207), .B0(n208), .B1(n170), .Y(n172)
         );
  INV_X0P5B_A9TR U419 ( .A(n173), .Y(n180) );
  AO22_X1M_A9TR U420 ( .A0(n207), .A1(n139), .B0(n208), .B1(n174), .Y(n397) );
  NAND2_X0P5A_A9TR U421 ( .A(n359), .B(n338), .Y(n363) );
  NOR2_X0P5A_A9TR U422 ( .A(n284), .B(n363), .Y(acc_mant_0_) );
  INV_X0P5B_A9TR U423 ( .A(n179), .Y(n193) );
  INV_X0P5B_A9TR U424 ( .A(n197), .Y(n182) );
  INV_X0P5B_A9TR U425 ( .A(n195), .Y(n181) );
  INV_X0P5B_A9TR U426 ( .A(n185), .Y(n191) );
  INV_X0P5B_A9TR U427 ( .A(n186), .Y(n223) );
  NOR2_X0P5A_A9TR U428 ( .A(n211), .B(n356), .Y(n187) );
  NOR2_X0P5A_A9TR U429 ( .A(n337), .B(n356), .Y(n202) );
  INV_X0P5B_A9TR U430 ( .A(n194), .Y(n360) );
  NAND2_X0P5A_A9TR U431 ( .A(n205), .B(n397), .Y(n200) );
  NOR2_X0P5A_A9TR U432 ( .A(n313), .B(n338), .Y(n201) );
  OAI21_X1M_A9TR U433 ( .A0(n227), .A1(n356), .B0(n206), .Y(n311) );
  INV_X0P5B_A9TR U434 ( .A(n209), .Y(n210) );
  INV_X0P5B_A9TR U435 ( .A(n264), .Y(n213) );
  INV_X0P5B_A9TR U436 ( .A(n288), .Y(n212) );
  INV_X0P5B_A9TR U437 ( .A(n214), .Y(n287) );
  INV_X0P5B_A9TR U438 ( .A(n290), .Y(n215) );
  AOI21_X0P5M_A9TR U439 ( .A0(n396), .A1(n346), .B0(n217), .Y(n219) );
  MXIT2_X0P5M_A9TR U440 ( .A(n227), .B(n309), .S0(n338), .Y(n229) );
  INV_X0P5B_A9TR U441 ( .A(n359), .Y(n355) );
  AOI21_X0P5M_A9TR U442 ( .A0(n229), .A1(n359), .B0(n228), .Y(acc_mant_18_) );
  MXIT2_X0P5M_A9TR U443 ( .A(n295), .B(n286), .S0(n356), .Y(n240) );
  OAI2XB1_X1M_A9TR U444 ( .A1N(n338), .A0(n354), .B0(n246), .Y(n327) );
  INV_X0P5B_A9TR U445 ( .A(n303), .Y(n254) );
  NOR2_X0P5A_A9TR U446 ( .A(n255), .B(n301), .Y(n256) );
  OA1B2_X1M_A9TR U447 ( .B0(n338), .B1(n353), .A0N(n258), .Y(n259) );
  OA1B2_X1M_A9TR U448 ( .B0(n327), .B1(n359), .A0N(n259), .Y(acc_mant_25__BAR)
         );
  MXIT2_X0P5M_A9TR U449 ( .A(n262), .B(n261), .S0(n346), .Y(n316) );
  OAI21_X0P5M_A9TR U450 ( .A0(n263), .A1(n346), .B0(n338), .Y(n268) );
  NOR2_X0P5A_A9TR U451 ( .A(n293), .B(n397), .Y(n267) );
  NOR2_X0P5A_A9TR U452 ( .A(n268), .B(n267), .Y(n272) );
  NAND2_X0P5A_A9TR U453 ( .A(n269), .B(n397), .Y(n270) );
  NAND2_X0P5A_A9TR U454 ( .A(n317), .B(n338), .Y(n362) );
  NAND2_X0P5A_A9TR U455 ( .A(n274), .B(n397), .Y(n275) );
  NAND2_X0P5A_A9TR U456 ( .A(n331), .B(n338), .Y(n315) );
  MXIT2_X0P5M_A9TR U457 ( .A(n278), .B(n277), .S0(n346), .Y(n329) );
  OAI21_X0P5M_A9TR U458 ( .A0(n279), .A1(n346), .B0(n338), .Y(n280) );
  AOI21_X0P5M_A9TR U459 ( .A0(n281), .A1(n346), .B0(n280), .Y(n282) );
  OAI21_X0P5M_A9TR U460 ( .A0(n301), .A1(n297), .B0(n291), .Y(n292) );
  OAI21_X1M_A9TR U461 ( .A0(n366), .A1(n359), .B0(n296), .Y(acc_mant_24_) );
  OAI211_X1M_A9TR U462 ( .A0(n346), .A1(n340), .B0(n338), .C0(n307), .Y(n308)
         );
  NAND2_X0P5A_A9TR U463 ( .A(n313), .B(n338), .Y(n343) );
  NOR2_X0P5A_A9TR U464 ( .A(n316), .B(n356), .Y(n319) );
  NOR2_X0P5A_A9TR U465 ( .A(n317), .B(n338), .Y(n318) );
  INV_X0P5B_A9TR U466 ( .A(n365), .Y(n328) );
  NAND2_X0P5A_A9TR U467 ( .A(n361), .B(n325), .Y(n326) );
  NOR2_X0P5A_A9TR U468 ( .A(n329), .B(n356), .Y(n333) );
  NOR2_X0P5A_A9TR U469 ( .A(n331), .B(n338), .Y(n332) );
  NOR2_X0P5A_A9TR U470 ( .A(n350), .B(n363), .Y(acc_mant_3_) );
  NOR2_X0P5A_A9TR U471 ( .A(n336), .B(n363), .Y(acc_mant_2_) );
  NOR2_X0P5A_A9TR U472 ( .A(n342), .B(n341), .Y(n344) );
  AOI21_X0P5M_A9TR U473 ( .A0(n359), .A1(n352), .B0(n351), .Y(acc_mant_19_) );
  AOI21_X0P5M_A9TR U474 ( .A0(n359), .A1(n358), .B0(n357), .Y(acc_mant_17_) );
  NOR2_X0P5A_A9TR U475 ( .A(n364), .B(n363), .Y(acc_mant_1_) );
  NOR2_X1A_A9TR U476 ( .A(n469), .B(n221), .Y(n481) );
  ADDH_X1M_A9TR U477 ( .A(acc_exp[0]), .B(acc_exp[1]), .CO(n370), .S(n369) );
  ADDH_X1M_A9TR U478 ( .A(n370), .B(acc_exp[2]), .CO(n374), .S(n371) );
  NAND2_X1A_A9TR U479 ( .A(n447), .B(n371), .Y(n372) );
  OAI21_X1M_A9TR U480 ( .A0(n447), .A1(n385), .B0(n372), .Y(n390) );
  ADDH_X1M_A9TR U481 ( .A(n374), .B(acc_exp[3]), .CO(n375), .S(n373) );
  ADDH_X1M_A9TR U482 ( .A(n375), .B(acc_exp[4]), .CO(n377), .S(n380) );
  ADDH_X1M_A9TR U483 ( .A(n376), .B(acc_exp[6]), .S(n379) );
  ADDH_X1M_A9TR U484 ( .A(n377), .B(acc_exp[5]), .CO(n376), .S(n378) );
  AOI31_X1M_A9TR U485 ( .A0(n387), .A1(n446), .A2(n386), .B0(acc_exp[7]), .Y(
        n440) );
  AOI21_X1M_A9TR U486 ( .A0(n388), .A1(n436), .B0(n451), .Y(fp8_out[6]) );
  OA1B2_X1M_A9TR U487 ( .B0(n390), .B1(n444), .A0N(n451), .Y(fp8_out[5]) );
  AOI21_X0P5M_A9TR U488 ( .A0(n397), .A1(n396), .B0(n395), .Y(n398) );
  INV_X0P5B_A9TR U489 ( .A(n402), .Y(n404) );
  NAND2B_X0P5M_A9TR U490 ( .AN(acc_exp[0]), .B(acc_mant_25_), .Y(n474) );
  AOI21_X1M_A9TR U491 ( .A0(acc_mant_26__BAR), .A1(acc_exp[0]), .B0(n410), .Y(
        n426) );
  NAND2_X0P5A_A9TR U492 ( .A(n446), .B(acc_mant_26__BAR), .Y(n414) );
  NAND2_X0P5A_A9TR U493 ( .A(n421), .B(acc_exp[3]), .Y(n419) );
  NOR2_X0P5A_A9TR U494 ( .A(n419), .B(n418), .Y(n420) );
  INV_X0P5B_A9TR U495 ( .A(acc_exp[5]), .Y(n422) );
  NOR2_X0P5A_A9TR U496 ( .A(n420), .B(n422), .Y(n425) );
  INV_X0P5B_A9TR U497 ( .A(n421), .Y(n428) );
  NAND2_X0P5A_A9TR U498 ( .A(acc_exp[6]), .B(n422), .Y(n423) );
  INV_X0P5B_A9TR U499 ( .A(n441), .Y(n433) );
  INV_X0P5B_A9TR U500 ( .A(n448), .Y(n449) );
  INV_X0P5B_A9TR U501 ( .A(acc_mant_8_), .Y(n457) );
  OR4_X0P5M_A9TR U502 ( .A(acc_mant_3_), .B(acc_mant_0_), .C(acc_mant_1_), .D(
        acc_mant_2_), .Y(n453) );
  NAND4_X0P5M_A9TR U503 ( .A(n457), .B(n456), .C(n455), .D(n454), .Y(n460) );
  INV_X0P5B_A9TR U504 ( .A(acc_mant_17_), .Y(n461) );
  INV_X0P5B_A9TR U505 ( .A(acc_mant_19_), .Y(n465) );
  INV_X0P5B_A9TR U506 ( .A(acc_mant_22_), .Y(n464) );
  INV_X0P5B_A9TR U507 ( .A(n221), .Y(acc_mant_23_) );
  INV_X0P5B_A9TR U508 ( .A(n474), .Y(n475) );
endmodule

