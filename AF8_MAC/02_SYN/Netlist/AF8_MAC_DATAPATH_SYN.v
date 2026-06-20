/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09
// Date      : Sat May 23 16:14:51 2026
/////////////////////////////////////////////////////////////


module AF8_MAC_DATAPATH ( clk, rst_n, acc_clear, sign_a, exp_a, man_a, sign_b, 
        exp_b, man_b, norm_sign, norm_exp, norm_mant, is_nan_input, adder_sign, 
        adder_mant, adder_exp );
  input [3:0] exp_a;
  input [2:0] man_a;
  input [3:0] exp_b;
  input [2:0] man_b;
  input [9:0] norm_exp;
  input [23:0] norm_mant;
  output [27:0] adder_mant;
  output [9:0] adder_exp;
  input clk, rst_n, acc_clear, sign_a, sign_b, norm_sign, is_nan_input;
  output adder_sign;
  wire   n1412, n_0_net__0_, n_1_net__9_, n_1_net__7_, n_1_net__6_,
         n_1_net__5_, n_1_net__4_, n_1_net__2_, n_1_net__1_, n_1_net__0_,
         n_2_net__23_, n_2_net__22_, n_2_net__21_, n_2_net__20_, n_2_net__19_,
         n_2_net__18_, n_2_net__17_, n_2_net__16_, n_2_net__15_, n_2_net__14_,
         n_2_net__13_, n_2_net__12_, n_2_net__11_, n_2_net__10_, n_2_net__9_,
         n_2_net__8_, n_2_net__7_, n_2_net__6_, n_2_net__5_, n_2_net__4_,
         n_2_net__3_, n_2_net__2_, n_2_net__1_, n_2_net__0_, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268,
         n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290,
         n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301,
         n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334,
         n335, n336, n337, n338, n339, n340, n341, n342, n343, n344, n345,
         n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356,
         n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378,
         n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411,
         n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n422,
         n423, n424, n425, n426, n427, n428, n429, n430, n431, n432, n433,
         n434, n435, n436, n437, n438, n439, n440, n441, n442, n443, n444,
         n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, n455,
         n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466,
         n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477,
         n478, n479, n480, n481, n482, n483, n484, n485, n486, n487, n488,
         n489, n490, n491, n492, n493, n494, n495, n496, n497, n498, n499,
         n500, n501, n502, n503, n504, n505, n506, n507, n508, n509, n510,
         n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521,
         n522, n523, n524, n525, n526, n527, n528, n529, n530, n531, n532,
         n533, n534, n535, n536, n537, n538, n539, n540, n541, n542, n543,
         n544, n545, n546, n547, n548, n549, n550, n551, n552, n553, n554,
         n555, n556, n557, n558, n559, n560, n561, n562, n563, n564, n565,
         n566, n567, n568, n569, n570, n571, n572, n573, n574, n575, n576,
         n577, n578, n579, n580, n581, n582, n583, n584, n585, n586, n587,
         n588, n589, n590, n591, n592, n593, n594, n595, n596, n597, n598,
         n599, n600, n601, n602, n603, n604, n605, n606, n607, n608, n609,
         n610, n611, n612, n613, n614, n615, n616, n617, n618, n619, n620,
         n621, n622, n623, n624, n625, n626, n627, n628, n629, n630, n631,
         n632, n633, n634, n635, n636, n637, n638, n639, n640, n641, n642,
         n643, n644, n645, n646, n647, n648, n649, n650, n651, n652, n653,
         n654, n655, n656, n657, n658, n659, n660, n661, n662, n663, n664,
         n665, n666, n667, n668, n669, n670, n671, n672, n673, n674, n675,
         n676, n677, n678, n679, n680, n681, n682, n683, n684, n685, n686,
         n687, n688, n689, n690, n691, n692, n693, n694, n695, n696, n697,
         n698, n699, n700, n701, n702, n703, n704, n705, n706, n707, n708,
         n709, n710, n711, n712, n713, n714, n715, n716, n717, n718, n719,
         n720, n721, n722, n723, n724, n725, n726, n727, n728, n729, n730,
         n731, n732, n733, n734, n735, n736, n737, n738, n739, n740, n741,
         n742, n743, n744, n745, n746, n747, n748, n749, n750, n751, n752,
         n753, n754, n755, n756, n757, n758, n759, n760, n761, n762, n763,
         n764, n765, n766, n767, n768, n769, n770, n771, n772, n773, n774,
         n775, n776, n777, n778, n779, n780, n781, n782, n783, n784, n785,
         n786, n787, n788, n789, n790, n791, n792, n793, n794, n795, n796,
         n797, n798, n799, n800, n801, n802, n803, n804, n805, n806, n807,
         n808, n809, n810, n811, n812, n813, n814, n815, n816, n817, n818,
         n819, n820, n821, n822, n823, n824, n825, n826, n827, n828, n829,
         n830, n831, n832, n833, n834, n835, n836, n837, n838, n839, n840,
         n841, n842, n843, n844, n845, n846, n847, n848, n849, n850, n851,
         n852, n853, n854, n855, n856, n857, n858, n859, n860, n861, n862,
         n863, n864, n865, n866, n867, n868, n869, n870, n871, n872, n873,
         n874, n875, n876, n877, n878, n879, n880, n881, n882, n883, n884,
         n885, n886, n887, n888, n889, n890, n891, n892, n893, n894, n895,
         n896, n897, n898, n899, n900, n901, n902, n903, n904, n905, n906,
         n907, n908, n909, n910, n911, n912, n913, n914, n915, n916, n917,
         n918, n919, n920, n921, n922, n923, n924, n925, n926, n927, n928,
         n929, n930, n931, n932, n933, n934, n935, n936, n937, n938, n939,
         n940, n941, n942, n943, n944, n945, n946, n947, n948, n949, n950,
         n951, n952, n953, n954, n955, n956, n957, n958, n959, n960, n961,
         n962, n963, n964, n965, n966, n967, n968, n969, n970, n971, n972,
         n973, n974, n975, n976, n977, n978, n979, n980, n981, n982, n983,
         n984, n985, n986, n987, n988, n989, n990, n991, n992, n993, n994,
         n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234,
         n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244,
         n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254,
         n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264,
         n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274,
         n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284,
         n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294,
         n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304,
         n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314,
         n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324,
         n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334,
         n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342, n1343, n1344,
         n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352, n1353, n1354,
         n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362, n1363, n1364,
         n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1372, n1373, n1374,
         n1375, n1376, n1377, n1378, n1379, n1380, n1381, n1382, n1383, n1384,
         n1385, n1386, n1387, n1388, n1389, n1390, n1391, n1392, n1393, n1394,
         n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402, n1403, n1404,
         n1405, n1406, n1407, n1408, n1409, n1410, n1411;
  wire   [9:0] acc_exp;
  wire   [23:0] acc_mant;

  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_6_ ( .D(n_2_net__6_), .CK(
        clk), .R(n1411), .Q(acc_mant[6]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_21_ ( .D(n_2_net__21_), 
        .CK(clk), .R(n1411), .Q(acc_mant[21]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_0_ ( .D(n_1_net__0_), .CK(
        clk), .R(n1411), .Q(acc_exp[0]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_1_ ( .D(n_1_net__1_), .CK(
        clk), .R(n1411), .Q(acc_exp[1]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_2_ ( .D(n_1_net__2_), .CK(
        clk), .R(n1411), .Q(acc_exp[2]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_4_ ( .D(n_1_net__4_), .CK(
        clk), .R(n1411), .Q(acc_exp[4]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_5_ ( .D(n_1_net__5_), .CK(
        clk), .R(n1411), .Q(acc_exp[5]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_6_ ( .D(n_1_net__6_), .CK(
        clk), .R(n1411), .Q(acc_exp[6]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_7_ ( .D(n_1_net__7_), .CK(
        clk), .R(n1411), .Q(acc_exp[7]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_exp_out_reg_9_ ( .D(n_1_net__9_), .CK(
        clk), .R(n1411), .Q(acc_exp[9]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_0_ ( .D(n_2_net__0_), .CK(
        clk), .R(n1411), .Q(acc_mant[0]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_1_ ( .D(n_2_net__1_), .CK(
        clk), .R(n1411), .Q(acc_mant[1]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_2_ ( .D(n_2_net__2_), .CK(
        clk), .R(n1411), .Q(acc_mant[2]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_3_ ( .D(n_2_net__3_), .CK(
        clk), .R(n1411), .Q(acc_mant[3]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_4_ ( .D(n_2_net__4_), .CK(
        clk), .R(n1411), .Q(acc_mant[4]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_5_ ( .D(n_2_net__5_), .CK(
        clk), .R(n1411), .Q(acc_mant[5]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_7_ ( .D(n_2_net__7_), .CK(
        clk), .R(n1411), .Q(acc_mant[7]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_8_ ( .D(n_2_net__8_), .CK(
        clk), .R(n1411), .Q(acc_mant[8]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_9_ ( .D(n_2_net__9_), .CK(
        clk), .R(n1411), .Q(acc_mant[9]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_10_ ( .D(n_2_net__10_), 
        .CK(clk), .R(n1411), .Q(acc_mant[10]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_11_ ( .D(n_2_net__11_), 
        .CK(clk), .R(n1411), .Q(acc_mant[11]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_12_ ( .D(n_2_net__12_), 
        .CK(clk), .R(n1411), .Q(acc_mant[12]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_13_ ( .D(n_2_net__13_), 
        .CK(clk), .R(n1411), .Q(acc_mant[13]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_14_ ( .D(n_2_net__14_), 
        .CK(clk), .R(n1411), .Q(acc_mant[14]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_15_ ( .D(n_2_net__15_), 
        .CK(clk), .R(n1411), .Q(acc_mant[15]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_16_ ( .D(n_2_net__16_), 
        .CK(clk), .R(n1411), .Q(acc_mant[16]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_17_ ( .D(n_2_net__17_), 
        .CK(clk), .R(n1411), .Q(acc_mant[17]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_18_ ( .D(n_2_net__18_), 
        .CK(clk), .R(n1411), .Q(acc_mant[18]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_19_ ( .D(n_2_net__19_), 
        .CK(clk), .R(n1411), .Q(acc_mant[19]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_20_ ( .D(n_2_net__20_), 
        .CK(clk), .R(n1411), .Q(acc_mant[20]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_22_ ( .D(n_2_net__22_), 
        .CK(clk), .R(n1411), .Q(acc_mant[22]) );
  DFFRPQ_X0P5M_A9TR u_acc_register_acc_mant_out_reg_23_ ( .D(n_2_net__23_), 
        .CK(clk), .R(n1411), .Q(acc_mant[23]) );
  DFFRPQN_X0P5M_A9TR u_acc_register_acc_sign_out_reg ( .D(n_0_net__0_), .CK(
        clk), .R(n1411), .QN(n1410) );
  DFFSQN_X0P5M_A9TR u_acc_register_acc_exp_out_reg_8_ ( .D(n1408), .CK(clk), 
        .SN(n172), .QN(acc_exp[8]) );
  DFFSQN_X0P5M_A9TR u_acc_register_acc_exp_out_reg_3_ ( .D(n1407), .CK(clk), 
        .SN(n172), .QN(acc_exp[3]) );
  XOR2_X3M_A9TR U255 ( .A(n1260), .B(n1259), .Y(adder_mant[25]) );
  XOR2_X2M_A9TR U256 ( .A(n1251), .B(n1250), .Y(adder_mant[23]) );
  INV_X0P6M_A9TR U257 ( .A(n1294), .Y(n1373) );
  AOI21_X1M_A9TR U258 ( .A0(n1348), .A1(n1322), .B0(n1321), .Y(n1337) );
  OAI21_X1M_A9TR U259 ( .A0(n1332), .A1(n1303), .B0(n1302), .Y(n1314) );
  INV_X1B_A9TR U260 ( .A(n1320), .Y(n1348) );
  INV_X1M_A9TR U261 ( .A(n1286), .Y(n1332) );
  INV_X0P6M_A9TR U262 ( .A(n1271), .Y(n217) );
  MXT2_X0P5M_A9TR U263 ( .A(n1136), .B(n1137), .S0(n1214), .Y(n1147) );
  OAI21_X6M_A9TR U264 ( .A0(n1320), .A1(n222), .B0(n221), .Y(n1286) );
  OAI21_X1P4M_A9TR U265 ( .A0(n1306), .A1(n1311), .B0(n1307), .Y(n1082) );
  NAND2_X1A_A9TR U266 ( .A(n987), .B(n986), .Y(n1345) );
  NOR2_X2M_A9TR U267 ( .A(n991), .B(n990), .Y(n1333) );
  NOR2_X2M_A9TR U268 ( .A(n1079), .B(n1078), .Y(n1304) );
  NOR2_X2M_A9TR U269 ( .A(n1075), .B(n1074), .Y(n1328) );
  NAND2_X1A_A9TR U270 ( .A(n993), .B(n992), .Y(n1324) );
  ADDF_X1M_A9TR U271 ( .A(n1016), .B(n1015), .CI(n1014), .CO(n1076), .S(n1075)
         );
  ADDF_X1M_A9TR U272 ( .A(n974), .B(n973), .CI(n972), .CO(n990), .S(n989) );
  ADDF_X1M_A9TR U273 ( .A(n1039), .B(n1038), .CI(n1037), .CO(n1080), .S(n1079)
         );
  XOR2_X0P7M_A9TR U274 ( .A(n1013), .B(n178), .Y(n1017) );
  XOR2_X0P7M_A9TR U275 ( .A(n982), .B(n178), .Y(n995) );
  XOR2_X0P7M_A9TR U276 ( .A(n971), .B(n178), .Y(n975) );
  MXT2_X0P7M_A9TR U277 ( .A(n895), .B(n894), .S0(n892), .Y(n896) );
  AND2_X0P5B_A9TR U278 ( .A(n1067), .B(n897), .Y(n898) );
  AND2_X0P5B_A9TR U279 ( .A(n1067), .B(n913), .Y(n914) );
  AND2_X0P7M_A9TR U280 ( .A(n1195), .B(n1065), .Y(n1066) );
  AND2_X0P5B_A9TR U281 ( .A(n1067), .B(n902), .Y(n893) );
  MXT2_X0P7M_A9TR U282 ( .A(n948), .B(n947), .S0(n1067), .Y(n949) );
  MXT2_X1P4B_A9TR U283 ( .A(n905), .B(n906), .S0(n1195), .Y(n928) );
  AND2_X2B_A9TR U284 ( .A(n1195), .B(n978), .Y(n979) );
  XOR2_X1M_A9TR U285 ( .A(n1047), .B(n178), .Y(n1051) );
  XOR2_X0P7M_A9TR U286 ( .A(n1044), .B(n178), .Y(n1052) );
  MXT2_X0P7M_A9TR U287 ( .A(n1035), .B(n1034), .S0(n1067), .Y(n1036) );
  MXT2_X0P7M_A9TR U288 ( .A(n1024), .B(n1023), .S0(n1067), .Y(n1025) );
  MXT2_X0P5M_A9TR U289 ( .A(n1057), .B(n1056), .S0(n1067), .Y(n1058) );
  AND2_X0P7M_A9TR U290 ( .A(n892), .B(n1032), .Y(n1033) );
  BUF_X9M_A9TR U291 ( .A(n1020), .Y(n1214) );
  INV_X5M_A9TR U292 ( .A(n892), .Y(n1172) );
  AND2_X1P4M_A9TR U293 ( .A(n1067), .B(n929), .Y(n903) );
  INV_X6M_A9TR U294 ( .A(n1020), .Y(n1210) );
  NOR2XB_X3M_A9TR U295 ( .BN(n887), .A(n267), .Y(n266) );
  NAND2_X0P5A_A9TR U296 ( .A(n886), .B(n885), .Y(n887) );
  NOR2_X1B_A9TR U297 ( .A(n198), .B(n1410), .Y(n1386) );
  NAND2_X1A_A9TR U298 ( .A(n891), .B(n268), .Y(n267) );
  INV_X1M_A9TR U299 ( .A(n890), .Y(n268) );
  ADDF_X1M_A9TR U300 ( .A(n884), .B(n1197), .CI(n1194), .CO(n885), .S(n871) );
  AND2_X1M_A9TR U301 ( .A(n192), .B(n374), .Y(n891) );
  INV_X0P5B_A9TR U302 ( .A(n1198), .Y(n884) );
  ADDF_X1M_A9TR U303 ( .A(n869), .B(n1176), .CI(n1178), .CO(n870), .S(n857) );
  MXT2_X0P7M_A9TR U304 ( .A(n865), .B(n864), .S0(n1236), .Y(n1197) );
  MXT2_X0P7M_A9TR U305 ( .A(n868), .B(n867), .S0(n1236), .Y(n1194) );
  MXT2_X0P7M_A9TR U306 ( .A(n368), .B(n469), .S0(n1236), .Y(n1240) );
  AND2_X1M_A9TR U307 ( .A(n851), .B(n176), .Y(n1176) );
  MXT2_X0P7M_A9TR U308 ( .A(n373), .B(n383), .S0(n1236), .Y(n1243) );
  INV_X0P5B_A9TR U309 ( .A(n1179), .Y(n869) );
  INV_X0P5B_A9TR U310 ( .A(n1218), .Y(n889) );
  MXT2_X0P7M_A9TR U311 ( .A(n854), .B(n853), .S0(n1236), .Y(n1178) );
  MXT2_X0P7M_A9TR U312 ( .A(n883), .B(n882), .S0(n1236), .Y(n1215) );
  MXT2_X0P7M_A9TR U313 ( .A(n880), .B(n879), .S0(n1236), .Y(n1217) );
  OAI22_X1M_A9TR U314 ( .A0(n1381), .A1(n862), .B0(n876), .B1(n861), .Y(n1198)
         );
  AND2_X1M_A9TR U315 ( .A(n841), .B(n176), .Y(n1161) );
  INV_X0P5B_A9TR U316 ( .A(n1164), .Y(n855) );
  NOR2XB_X1M_A9TR U317 ( .BN(n843), .A(n1236), .Y(n1163) );
  OAI22_X1M_A9TR U318 ( .A0(n1381), .A1(n849), .B0(n848), .B1(n876), .Y(n1179)
         );
  OAI22_X1M_A9TR U319 ( .A0(n1381), .A1(n877), .B0(n876), .B1(n875), .Y(n1218)
         );
  NAND2_X1A_A9TR U320 ( .A(n837), .B(n418), .Y(n876) );
  NOR2XB_X1M_A9TR U321 ( .BN(n810), .A(n1236), .Y(n1123) );
  NOR2_X1M_A9TR U322 ( .A(n772), .B(n771), .Y(n775) );
  OR2_X2M_A9TR U323 ( .A(n549), .B(n548), .Y(n552) );
  AND2_X1M_A9TR U324 ( .A(n549), .B(n548), .Y(n550) );
  OAI31_X2M_A9TR U325 ( .A0(n751), .A1(n750), .A2(n825), .B0(n749), .Y(n1057)
         );
  NOR2_X3B_A9TR U326 ( .A(n718), .B(n717), .Y(n624) );
  INV_X0P7M_A9TR U327 ( .A(n1009), .Y(n678) );
  ADDF_X1M_A9TR U328 ( .A(n967), .B(n969), .CI(n611), .CO(n712), .S(n711) );
  NOR2B_X1M_A9TR U329 ( .AN(n662), .B(n177), .Y(n663) );
  MXT2_X0P7M_A9TR U330 ( .A(n615), .B(n614), .S0(n177), .Y(n616) );
  OR2_X1M_A9TR U331 ( .A(n377), .B(n376), .Y(n380) );
  NOR2B_X0P7M_A9TR U332 ( .AN(n753), .B(n683), .Y(n684) );
  NOR2B_X0P7M_A9TR U333 ( .AN(n753), .B(n680), .Y(n681) );
  NOR2_X1B_A9TR U334 ( .A(n658), .B(n753), .Y(n816) );
  NOR2_X1B_A9TR U335 ( .A(n381), .B(n382), .Y(n385) );
  NAND2_X1A_A9TR U336 ( .A(n576), .B(n630), .Y(n667) );
  NOR2_X1B_A9TR U337 ( .A(n641), .B(n638), .Y(n762) );
  NAND2B_X1M_A9TR U338 ( .AN(n630), .B(n575), .Y(n467) );
  NAND2B_X1M_A9TR U339 ( .AN(n630), .B(n578), .Y(n672) );
  NOR2B_X0P7M_A9TR U340 ( .AN(n753), .B(n617), .Y(n619) );
  NOR2_X0P7M_A9TR U341 ( .A(n641), .B(n593), .Y(n780) );
  INV_X1M_A9TR U342 ( .A(n1383), .Y(n1389) );
  OAI22_X0P7M_A9TR U343 ( .A0(n639), .A1(n642), .B0(n641), .B1(n640), .Y(n651)
         );
  MXIT2_X0P7M_A9TR U344 ( .A(n628), .B(n627), .S0(n626), .Y(n690) );
  INV_X2M_A9TR U345 ( .A(n1381), .Y(n1399) );
  INV_X1M_A9TR U346 ( .A(n630), .Y(n229) );
  NAND2B_X1M_A9TR U347 ( .AN(n626), .B(n561), .Y(n764) );
  NOR2_X1B_A9TR U348 ( .A(n600), .B(n453), .Y(n459) );
  INV_X5M_A9TR U349 ( .A(n372), .Y(n630) );
  BUF_X4M_A9TR U350 ( .A(n600), .Y(n644) );
  MXT2_X1M_A9TR U351 ( .A(n499), .B(n498), .S0(n518), .Y(n608) );
  AND2_X1M_A9TR U352 ( .A(n175), .B(n173), .Y(n419) );
  NOR2B_X2M_A9TR U353 ( .AN(n518), .B(n517), .Y(n628) );
  AOI22BB_X2M_A9TR U354 ( .A0(n525), .A1(n484), .B0N(n639), .B1N(n595), .Y(
        n485) );
  OR2_X3M_A9TR U355 ( .A(n1400), .B(n198), .Y(n1381) );
  INV_X3M_A9TR U356 ( .A(n461), .Y(n175) );
  INV_X1M_A9TR U357 ( .A(n460), .Y(n443) );
  INV_X1M_A9TR U358 ( .A(n197), .Y(n198) );
  NOR2_X1M_A9TR U359 ( .A(n173), .B(n174), .Y(n522) );
  BUFH_X6M_A9TR U360 ( .A(n433), .Y(n528) );
  NAND2_X1A_A9TR U361 ( .A(n1400), .B(n363), .Y(n366) );
  INV_X1M_A9TR U362 ( .A(n174), .Y(n197) );
  NAND2XB_X1M_A9TR U363 ( .BN(n1379), .A(n357), .Y(n358) );
  XOR2_X1P4M_A9TR U364 ( .A(n441), .B(n344), .Y(n387) );
  XNOR2_X0P7M_A9TR U365 ( .A(n338), .B(n351), .Y(n360) );
  OR2_X1M_A9TR U366 ( .A(n325), .B(n282), .Y(n249) );
  NAND2_X1A_A9TR U367 ( .A(n336), .B(n361), .Y(n355) );
  AND2_X1M_A9TR U368 ( .A(n185), .B(n324), .Y(n325) );
  INV_X2P5M_A9TR U369 ( .A(n342), .Y(n312) );
  NOR2B_X1M_A9TR U370 ( .AN(acc_exp[5]), .B(n174), .Y(n293) );
  INV_X1M_A9TR U371 ( .A(n321), .Y(n322) );
  NAND2_X1A_A9TR U372 ( .A(n319), .B(n318), .Y(n330) );
  NOR2XB_X1M_A9TR U373 ( .BN(acc_exp[6]), .A(n174), .Y(n316) );
  NOR2B_X2M_A9TR U374 ( .AN(acc_exp[7]), .B(n174), .Y(n319) );
  NOR2B_X2M_A9TR U375 ( .AN(acc_exp[3]), .B(n174), .Y(n301) );
  INV_X1P7M_A9TR U376 ( .A(n290), .Y(n287) );
  NAND2_X2B_A9TR U377 ( .A(n166), .B(n170), .Y(n302) );
  INV_X1P7M_A9TR U378 ( .A(n291), .Y(n286) );
  INV_X2M_A9TR U379 ( .A(n167), .Y(n168) );
  INV_X7P5B_A9TR U380 ( .A(acc_clear), .Y(n196) );
  INV_X2M_A9TR U381 ( .A(exp_b[3]), .Y(n167) );
  INV_X4B_A9TR U382 ( .A(exp_b[1]), .Y(n265) );
  INV_X4M_A9TR U383 ( .A(exp_a[2]), .Y(n169) );
  INV_X4M_A9TR U384 ( .A(n169), .Y(n170) );
  INV_X1M_A9TR U385 ( .A(n193), .Y(n194) );
  INV_X3M_A9TR U386 ( .A(exp_a[3]), .Y(n193) );
  INV_X0P5B_A9TR U387 ( .A(man_b[1]), .Y(n394) );
  INV_X0P5B_A9TR U388 ( .A(man_b[2]), .Y(n367) );
  INV_X4M_A9TR U389 ( .A(exp_b[2]), .Y(n165) );
  INV_X0P5B_A9TR U390 ( .A(man_a[0]), .Y(n427) );
  INV_X0P5B_A9TR U391 ( .A(man_a[1]), .Y(n391) );
  INV_X0P5B_A9TR U392 ( .A(man_a[2]), .Y(n399) );
  INV_X0P5B_A9TR U393 ( .A(n193), .Y(n195) );
  INV_X3M_A9TR U394 ( .A(n165), .Y(n166) );
  NAND2_X4B_A9TR U395 ( .A(exp_b[0]), .B(exp_a[0]), .Y(n290) );
  NAND2_X4B_A9TR U396 ( .A(exp_b[1]), .B(exp_a[1]), .Y(n289) );
  INV_X0P5B_A9TR U397 ( .A(rst_n), .Y(n171) );
  INV_X0P5B_A9TR U398 ( .A(n171), .Y(n172) );
  INV_X0P5B_A9TR U399 ( .A(n351), .Y(n352) );
  NAND2_X1A_A9TR U400 ( .A(n607), .B(n630), .Y(n787) );
  INV_X0P5B_A9TR U401 ( .A(n301), .Y(n235) );
  NOR2B_X1M_A9TR U402 ( .AN(acc_exp[9]), .B(n174), .Y(n321) );
  NOR2B_X1M_A9TR U403 ( .AN(acc_exp[4]), .B(n174), .Y(n295) );
  MXT2_X0P7M_A9TR U404 ( .A(n673), .B(n1235), .S0(n177), .Y(n674) );
  INV_X1M_A9TR U405 ( .A(n323), .Y(n318) );
  MXIT2_X0P7M_A9TR U406 ( .A(n617), .B(n515), .S0(n753), .Y(n798) );
  NOR2B_X2M_A9TR U407 ( .AN(n633), .B(n1236), .Y(n947) );
  NOR2B_X2M_A9TR U408 ( .AN(n663), .B(n1236), .Y(n1023) );
  NOR2B_X1M_A9TR U409 ( .AN(n755), .B(n1236), .Y(n1056) );
  INV_X0P5B_A9TR U410 ( .A(man_b[0]), .Y(n428) );
  INV_X0P5B_A9TR U411 ( .A(n187), .Y(n247) );
  NOR2_X1A_A9TR U412 ( .A(n325), .B(n247), .Y(n246) );
  INV_X0P5B_A9TR U413 ( .A(n302), .Y(n292) );
  ADDF_X1M_A9TR U414 ( .A(n1050), .B(n1049), .CI(n1048), .CO(n1084), .S(n1081)
         );
  INV_X0P5B_A9TR U415 ( .A(n1266), .Y(n214) );
  NAND2_X1A_A9TR U416 ( .A(n941), .B(n940), .Y(n1351) );
  INV_X0P5B_A9TR U417 ( .A(n1270), .Y(n1117) );
  NOR2_X3B_A9TR U418 ( .A(n1090), .B(n220), .Y(n219) );
  INV_X1M_A9TR U419 ( .A(n1369), .Y(n1372) );
  INV_X1M_A9TR U420 ( .A(n1370), .Y(n1371) );
  NOR2_X2M_A9TR U421 ( .A(n1265), .B(n217), .Y(n216) );
  AOI21_X3M_A9TR U422 ( .A0(n1301), .A1(n1083), .B0(n1082), .Y(n1287) );
  NOR2_X3A_A9TR U423 ( .A(n1304), .B(n1306), .Y(n1083) );
  INV_X1M_A9TR U424 ( .A(n1289), .Y(n1293) );
  INV_X1M_A9TR U425 ( .A(n1291), .Y(n1292) );
  INV_X1M_A9TR U426 ( .A(n1311), .Y(n1305) );
  INV_X1M_A9TR U427 ( .A(n1279), .Y(n1144) );
  OAI2XB1_X1M_A9TR U428 ( .A1N(n1404), .A0(n1257), .B0(n1403), .Y(n230) );
  INV_X1M_A9TR U429 ( .A(n1261), .Y(n1171) );
  INV_X1M_A9TR U430 ( .A(n1304), .Y(n1312) );
  INV_X1M_A9TR U431 ( .A(n1252), .Y(n1233) );
  INV_X1M_A9TR U432 ( .A(n1206), .Y(n1207) );
  INV_X1M_A9TR U433 ( .A(n1355), .Y(n1357) );
  NAND2_X1A_A9TR U434 ( .A(n1103), .B(n1102), .Y(n1284) );
  OA21_X1P4M_A9TR U435 ( .A0(n1364), .A1(n935), .B0(n1365), .Y(n1362) );
  NAND2_X2B_A9TR U436 ( .A(n1224), .B(n1223), .Y(n1248) );
  INV_X1M_A9TR U437 ( .A(n1338), .Y(n1346) );
  INV_X1M_A9TR U438 ( .A(n1345), .Y(n1339) );
  INV_X1B_A9TR U439 ( .A(n1367), .Y(n935) );
  INV_X0P7M_A9TR U440 ( .A(n1364), .Y(n1366) );
  XOR2_X1P4M_A9TR U441 ( .A(n979), .B(n178), .Y(n996) );
  XOR2_X1P4M_A9TR U442 ( .A(n1011), .B(n178), .Y(n1018) );
  XOR2_X0P7M_A9TR U443 ( .A(n1070), .B(n178), .Y(n1091) );
  AND2_X2B_A9TR U444 ( .A(n1214), .B(n945), .Y(n946) );
  OAI21_X8M_A9TR U445 ( .A0(n269), .A1(n888), .B0(n266), .Y(n1384) );
  NAND2_X2B_A9TR U446 ( .A(n857), .B(n856), .Y(n858) );
  AND2_X2M_A9TR U447 ( .A(n846), .B(n845), .Y(n847) );
  NAND2_X0P5A_A9TR U448 ( .A(n1245), .B(n178), .Y(n1403) );
  NAND2_X0P7A_A9TR U449 ( .A(n824), .B(n823), .Y(n189) );
  OR2_X1M_A9TR U450 ( .A(n824), .B(n823), .Y(n281) );
  INV_X1P7M_A9TR U451 ( .A(n1035), .Y(n700) );
  ADDF_X1M_A9TR U452 ( .A(n956), .B(n958), .CI(n654), .CO(n710), .S(n707) );
  INV_X2M_A9TR U453 ( .A(n948), .Y(n655) );
  AND2_X2B_A9TR U454 ( .A(n592), .B(n176), .Y(n978) );
  OA21A1OI2_X3M_A9TR U455 ( .A0(n573), .A1(n572), .B0(n837), .C0(n571), .Y(
        n574) );
  INV_X0P6M_A9TR U456 ( .A(n1097), .Y(n800) );
  AND2_X1M_A9TR U457 ( .A(n785), .B(n176), .Y(n1094) );
  INV_X0P6M_A9TR U458 ( .A(n1110), .Y(n811) );
  INV_X0P6M_A9TR U459 ( .A(n1124), .Y(n822) );
  INV_X1M_A9TR U460 ( .A(n1137), .Y(n832) );
  NOR2_X0P5A_A9TR U461 ( .A(n431), .B(n421), .Y(n422) );
  NOR2B_X1P4M_A9TR U462 ( .AN(n684), .B(n177), .Y(n685) );
  NAND2_X0P5A_A9TR U463 ( .A(n753), .B(n228), .Y(n227) );
  INV_X6M_A9TR U464 ( .A(n449), .Y(n646) );
  NAND2XB_X1M_A9TR U465 ( .BN(n630), .A(n590), .Y(n782) );
  NAND2B_X2M_A9TR U466 ( .AN(n626), .B(n631), .Y(n515) );
  INV_X5M_A9TR U467 ( .A(n525), .Y(n641) );
  INV_X4M_A9TR U468 ( .A(n837), .Y(n825) );
  INV_X5M_A9TR U469 ( .A(n372), .Y(n626) );
  INV_X2M_A9TR U470 ( .A(n748), .Y(n848) );
  MXIT2_X1P4M_A9TR U471 ( .A(n493), .B(n492), .S0(n518), .Y(n590) );
  MXIT2_X1P4M_A9TR U472 ( .A(n495), .B(n496), .S0(n518), .Y(n579) );
  NAND2_X0P5A_A9TR U473 ( .A(n1389), .B(n274), .Y(n1390) );
  NOR2_X1B_A9TR U474 ( .A(n1236), .B(n177), .Y(n228) );
  INV_X1M_A9TR U475 ( .A(n1400), .Y(n1383) );
  BUF_X6M_A9TR U476 ( .A(n1400), .Y(n1236) );
  INV_X1B_A9TR U477 ( .A(n387), .Y(n562) );
  INV_X1M_A9TR U478 ( .A(n332), .Y(n334) );
  NOR2_X3A_A9TR U479 ( .A(n311), .B(n1392), .Y(n341) );
  OR2_X1M_A9TR U480 ( .A(n349), .B(n350), .Y(n253) );
  INV_X1B_A9TR U481 ( .A(n907), .Y(n1406) );
  NAND2_X0P7A_A9TR U482 ( .A(n328), .B(n327), .Y(n350) );
  INV_X1M_A9TR U483 ( .A(n496), .Y(n499) );
  INV_X5M_A9TR U484 ( .A(n234), .Y(n1382) );
  OA21_X1P4M_A9TR U485 ( .A0(n327), .A1(n329), .B0(n330), .Y(n187) );
  NAND2B_X1M_A9TR U486 ( .AN(n173), .B(n1237), .Y(n497) );
  INV_X1P7M_A9TR U487 ( .A(n1378), .Y(n482) );
  MXIT2_X0P7M_A9TR U488 ( .A(n867), .B(n882), .S0(n173), .Y(n512) );
  NAND2_X0P5A_A9TR U489 ( .A(n173), .B(n864), .Y(n491) );
  NAND2_X0P5A_A9TR U490 ( .A(n173), .B(n853), .Y(n511) );
  NOR2_X2M_A9TR U491 ( .A(n319), .B(n318), .Y(n329) );
  INV_X3M_A9TR U492 ( .A(n306), .Y(n272) );
  INV_X1M_A9TR U493 ( .A(n316), .Y(n314) );
  NOR2_X2A_A9TR U494 ( .A(n174), .B(n444), .Y(n432) );
  NOR2_X2A_A9TR U495 ( .A(n174), .B(n1380), .Y(n307) );
  NAND2_X2B_A9TR U496 ( .A(n168), .B(n195), .Y(n297) );
  INV_X1M_A9TR U497 ( .A(acc_exp[0]), .Y(n444) );
  INV_X1M_A9TR U498 ( .A(acc_exp[2]), .Y(n1380) );
  INV_X7P5M_A9TR U499 ( .A(exp_a[1]), .Y(n264) );
  OAI21_X3M_A9TR U500 ( .A0(n1260), .A1(n1256), .B0(n1257), .Y(n1405) );
  XNOR2_X3M_A9TR U501 ( .A(n1377), .B(n1376), .Y(adder_mant[14]) );
  NOR2_X3M_A9TR U502 ( .A(n225), .B(n224), .Y(n1320) );
  INV_X0P7M_A9TR U503 ( .A(n1301), .Y(n1302) );
  INV_X1M_A9TR U504 ( .A(n1306), .Y(n1308) );
  INV_X1M_A9TR U505 ( .A(n1295), .Y(n1297) );
  INV_X1M_A9TR U506 ( .A(n1189), .Y(n1186) );
  INV_X1M_A9TR U507 ( .A(n1265), .Y(n1267) );
  INV_X1M_A9TR U508 ( .A(n1247), .Y(n1249) );
  INV_X1M_A9TR U509 ( .A(n1323), .Y(n1325) );
  INV_X1M_A9TR U510 ( .A(n1274), .Y(n1276) );
  INV_X1M_A9TR U511 ( .A(n1256), .Y(n1258) );
  INV_X1M_A9TR U512 ( .A(n1350), .Y(n1352) );
  INV_X1M_A9TR U513 ( .A(n1359), .Y(n1361) );
  INV_X1M_A9TR U514 ( .A(n1340), .Y(n1342) );
  INV_X1M_A9TR U515 ( .A(n1333), .Y(n1335) );
  NOR2_X3B_A9TR U516 ( .A(n937), .B(n936), .Y(n1359) );
  NOR2_X2M_A9TR U517 ( .A(n1103), .B(n1102), .Y(n1283) );
  OR2_X2M_A9TR U518 ( .A(n1089), .B(n1088), .Y(n1375) );
  ADDF_X1M_A9TR U519 ( .A(n923), .B(n922), .CI(n921), .CO(n938), .S(n937) );
  XOR2_X1P4M_A9TR U520 ( .A(n1055), .B(n178), .Y(n1063) );
  ADDF_X1M_A9TR U521 ( .A(n178), .B(n928), .CI(n927), .CO(n922), .S(n934) );
  XOR2_X1P4M_A9TR U522 ( .A(n968), .B(n178), .Y(n976) );
  XOR2_X1P4M_A9TR U523 ( .A(n898), .B(n178), .Y(n911) );
  MXT2_X0P7M_A9TR U524 ( .A(n1068), .B(n1069), .S0(n1214), .Y(n1093) );
  MXT2_X1P4B_A9TR U525 ( .A(n900), .B(n899), .S0(n1214), .Y(n901) );
  OAI21_X3M_A9TR U526 ( .A0(n724), .A1(n723), .B0(n722), .Y(n744) );
  AOI21_X2M_A9TR U527 ( .A0(n552), .A1(n551), .B0(n550), .Y(n553) );
  INV_X2M_A9TR U528 ( .A(n624), .Y(n720) );
  NAND2_X0P5A_A9TR U529 ( .A(n1404), .B(n1403), .Y(n1246) );
  OR2_X1P4M_A9TR U530 ( .A(n707), .B(n706), .Y(n709) );
  NOR2_X1A_A9TR U531 ( .A(n834), .B(n833), .Y(n836) );
  AND2_X1M_A9TR U532 ( .A(n802), .B(n801), .Y(n803) );
  OR2_X1P4M_A9TR U533 ( .A(n871), .B(n870), .Y(n873) );
  NOR2_X0P7M_A9TR U534 ( .A(n813), .B(n812), .Y(n814) );
  INV_X1M_A9TR U535 ( .A(n1243), .Y(n374) );
  INV_X1M_A9TR U536 ( .A(n1151), .Y(n844) );
  NOR2XB_X0P5M_A9TR U537 ( .BN(n1235), .A(n177), .Y(n1238) );
  AOI211_X3M_A9TR U538 ( .A0(n568), .A1(n634), .B0(n459), .C0(n458), .Y(n664)
         );
  MX2_X1B_A9TR U539 ( .A(n563), .B(n863), .S0(n177), .Y(n564) );
  AND2_X1M_A9TR U540 ( .A(n866), .B(n177), .Y(n559) );
  AND2_X1M_A9TR U541 ( .A(n840), .B(n177), .Y(n629) );
  AND2_X1M_A9TR U542 ( .A(n830), .B(n177), .Y(n500) );
  MXIT2_X1P4M_A9TR U543 ( .A(n631), .B(n632), .S0(n229), .Y(n699) );
  MXIT2_X0P5M_A9TR U544 ( .A(n765), .B(n764), .S0(n753), .Y(n766) );
  NOR2_X2M_A9TR U545 ( .A(n690), .B(n753), .Y(n840) );
  OAI22_X0P7M_A9TR U546 ( .A0(n645), .A1(n639), .B0(n641), .B1(n643), .Y(n521)
         );
  NAND2XB_X2M_A9TR U547 ( .BN(n626), .A(n558), .Y(n757) );
  AOI22_X0P7M_A9TR U548 ( .A0(n1399), .A1(acc_mant[14]), .B0(n760), .B1(n778), 
        .Y(n761) );
  MXIT2_X1P4M_A9TR U549 ( .A(n576), .B(n575), .S0(n630), .Y(n745) );
  AOI22_X0P7M_A9TR U550 ( .A0(n1399), .A1(acc_mant[13]), .B0(n778), .B1(n748), 
        .Y(n749) );
  NOR2_X2A_A9TR U551 ( .A(n694), .B(n693), .Y(n778) );
  INV_X2M_A9TR U552 ( .A(n695), .Y(n838) );
  INV_X4M_A9TR U553 ( .A(n434), .Y(n449) );
  OR2_X3B_A9TR U554 ( .A(n461), .B(n447), .Y(n532) );
  MXIT2_X1P4M_A9TR U555 ( .A(n475), .B(n501), .S0(n528), .Y(n748) );
  OR2_X2M_A9TR U556 ( .A(n528), .B(n529), .Y(n861) );
  NOR2_X4A_A9TR U557 ( .A(n461), .B(n443), .Y(n837) );
  NAND2_X4B_A9TR U558 ( .A(n366), .B(n365), .Y(n461) );
  INV_X9M_A9TR U559 ( .A(n562), .Y(n177) );
  NOR2_X3A_A9TR U560 ( .A(n348), .B(n252), .Y(n251) );
  XNOR2_X0P7M_A9TR U561 ( .A(n441), .B(n440), .Y(n446) );
  OR2_X2M_A9TR U562 ( .A(n364), .B(n253), .Y(n252) );
  INV_X2M_A9TR U563 ( .A(n312), .Y(n242) );
  XOR2_X0P7M_A9TR U564 ( .A(n362), .B(n277), .Y(n363) );
  INV_X2M_A9TR U565 ( .A(n341), .Y(n343) );
  XOR2_X1P4M_A9TR U566 ( .A(n355), .B(n337), .Y(n357) );
  XOR2_X0P7M_A9TR U567 ( .A(n355), .B(n190), .Y(n356) );
  NAND2_X2B_A9TR U568 ( .A(n271), .B(n270), .Y(n294) );
  AO1B2_X3M_A9TR U569 ( .B0(n309), .B1(n336), .A0N(n361), .Y(n276) );
  INV_X1M_A9TR U570 ( .A(n596), .Y(n475) );
  AOI21_X0P7M_A9TR U571 ( .A0(n173), .A1(n478), .B0(n477), .Y(n582) );
  INV_X4M_A9TR U572 ( .A(n1387), .Y(n1392) );
  AOI22_X0P7M_A9TR U573 ( .A0(n173), .A1(acc_mant[21]), .B0(n522), .B1(
        acc_mant[20]), .Y(n530) );
  OAI21_X0P5M_A9TR U574 ( .A0(n173), .A1(acc_mant[19]), .B0(n197), .Y(n473) );
  MXIT2_X0P7M_A9TR U575 ( .A(n469), .B(n1237), .S0(n173), .Y(n429) );
  MXIT2_X0P7M_A9TR U576 ( .A(n882), .B(n469), .S0(n173), .Y(n496) );
  MXIT2_X0P7M_A9TR U577 ( .A(n864), .B(n879), .S0(n173), .Y(n517) );
  OAI21_X0P5M_A9TR U578 ( .A0(n173), .A1(acc_mant[18]), .B0(n197), .Y(n448) );
  MXIT2_X0P7M_A9TR U579 ( .A(n466), .B(n383), .S0(n173), .Y(n425) );
  XOR2_X1P4M_A9TR U580 ( .A(n1385), .B(n1386), .Y(n907) );
  MXIT2_X0P7M_A9TR U581 ( .A(n879), .B(n466), .S0(n173), .Y(n493) );
  OAI21_X1M_A9TR U582 ( .A0(n173), .A1(acc_mant[21]), .B0(n197), .Y(n474) );
  INV_X1M_A9TR U583 ( .A(n360), .Y(n239) );
  NAND2_X1A_A9TR U584 ( .A(n317), .B(n316), .Y(n327) );
  NOR2_X1M_A9TR U585 ( .A(n1401), .B(n352), .Y(n354) );
  INV_X1B_A9TR U586 ( .A(n432), .Y(n1378) );
  INV_X1P7M_A9TR U587 ( .A(n337), .Y(n309) );
  BUF_X6M_A9TR U588 ( .A(n432), .Y(n173) );
  INV_X1M_A9TR U589 ( .A(n295), .Y(n270) );
  INV_X2M_A9TR U590 ( .A(n319), .Y(n317) );
  NOR2XB_X3M_A9TR U591 ( .BN(acc_exp[8]), .A(n174), .Y(n323) );
  NOR2XB_X2M_A9TR U592 ( .BN(acc_exp[1]), .A(n174), .Y(n351) );
  INV_X1M_A9TR U593 ( .A(acc_mant[22]), .Y(n862) );
  BUF_X7P5M_A9TR U594 ( .A(n1412), .Y(adder_mant[26]) );
  OAI21_X1M_A9TR U595 ( .A0(n1337), .A1(n1333), .B0(n1334), .Y(n1327) );
  NOR2_X3B_A9TR U596 ( .A(n1288), .B(n263), .Y(n226) );
  AND2_X3B_A9TR U597 ( .A(n1370), .B(n1375), .Y(n220) );
  NAND2_X2B_A9TR U598 ( .A(n1369), .B(n1375), .Y(n263) );
  AOI21_X3M_A9TR U599 ( .A0(n223), .A1(n1321), .B0(n994), .Y(n221) );
  INV_X0P7M_A9TR U600 ( .A(n1300), .Y(n1303) );
  INV_X0P7M_A9TR U601 ( .A(n1315), .Y(n1317) );
  INV_X0P7M_A9TR U602 ( .A(n1328), .Y(n1330) );
  OAI21_X3M_A9TR U603 ( .A0(n1315), .A1(n1329), .B0(n1316), .Y(n1301) );
  OAI21_X2M_A9TR U604 ( .A0(n1350), .A1(n1356), .B0(n1351), .Y(n225) );
  OAI21_X1P4M_A9TR U605 ( .A0(n1334), .A1(n1323), .B0(n1324), .Y(n994) );
  NOR2_X3A_A9TR U606 ( .A(n941), .B(n940), .Y(n1350) );
  NOR2_X3M_A9TR U607 ( .A(n939), .B(n938), .Y(n1355) );
  NOR2_X2A_A9TR U608 ( .A(n1130), .B(n1129), .Y(n1265) );
  OAI21_X3M_A9TR U609 ( .A0(n1340), .A1(n1345), .B0(n1341), .Y(n1321) );
  ADDF_X1M_A9TR U610 ( .A(n1005), .B(n1004), .CI(n1003), .CO(n1074), .S(n993)
         );
  ADDF_X1M_A9TR U611 ( .A(n1028), .B(n1027), .CI(n1026), .CO(n1078), .S(n1077)
         );
  ADDF_X1M_A9TR U612 ( .A(n1128), .B(n1127), .CI(n1126), .CO(n1129), .S(n1116)
         );
  ADDF_X1M_A9TR U613 ( .A(n1114), .B(n1113), .CI(n1112), .CO(n1115), .S(n1103)
         );
  XOR2_X1P4M_A9TR U614 ( .A(n1066), .B(n178), .Y(n1092) );
  AND2_X1M_A9TR U615 ( .A(n1172), .B(n1032), .Y(n1050) );
  XOR2_X0P7M_A9TR U616 ( .A(n1125), .B(n178), .Y(n1131) );
  XOR2_X0P7M_A9TR U617 ( .A(n1095), .B(n178), .Y(n1105) );
  XOR2_X0P7M_A9TR U618 ( .A(n1180), .B(n178), .Y(n1191) );
  XOR2_X0P7M_A9TR U619 ( .A(n1149), .B(n178), .Y(n1159) );
  XOR2_X0P7M_A9TR U620 ( .A(n1196), .B(n178), .Y(n1212) );
  XOR2_X0P7M_A9TR U621 ( .A(n1122), .B(n178), .Y(n1132) );
  XOR2_X0P7M_A9TR U622 ( .A(n1135), .B(n178), .Y(n1146) );
  XOR2_X0P7M_A9TR U623 ( .A(n1177), .B(n178), .Y(n1192) );
  XOR2_X0P7M_A9TR U624 ( .A(n1219), .B(n178), .Y(n1225) );
  XOR2_X0P7M_A9TR U625 ( .A(n1216), .B(n178), .Y(n1226) );
  XOR2_X0P7M_A9TR U626 ( .A(n1162), .B(n178), .Y(n1174) );
  AND2_X1M_A9TR U627 ( .A(n1172), .B(n956), .Y(n974) );
  XOR2_X0P7M_A9TR U628 ( .A(n1111), .B(n178), .Y(n1118) );
  XOR2_X1P4M_A9TR U629 ( .A(n1033), .B(n178), .Y(n1041) );
  XOR2_X0P7M_A9TR U630 ( .A(n1098), .B(n178), .Y(n1104) );
  XOR2_X1P4M_A9TR U631 ( .A(n904), .B(n907), .Y(n932) );
  AND2_X1P4M_A9TR U632 ( .A(n1172), .B(n909), .Y(n930) );
  XOR2_X1P4M_A9TR U633 ( .A(n949), .B(n178), .Y(n953) );
  XOR2_X0P7M_A9TR U634 ( .A(n1199), .B(n178), .Y(n1211) );
  XOR2_X1P4M_A9TR U635 ( .A(n946), .B(n178), .Y(n954) );
  XOR2_X0P7M_A9TR U636 ( .A(n1138), .B(n178), .Y(n1145) );
  XOR2_X0P7M_A9TR U637 ( .A(n1152), .B(n178), .Y(n1158) );
  XOR2_X1P4M_A9TR U638 ( .A(n901), .B(n178), .Y(n910) );
  XOR2_X0P7M_A9TR U639 ( .A(n1165), .B(n178), .Y(n1173) );
  MXT2_X0P7M_A9TR U640 ( .A(n1179), .B(n1178), .S0(n892), .Y(n1180) );
  MXT2_X0P7M_A9TR U641 ( .A(n1198), .B(n1197), .S0(n1214), .Y(n1199) );
  INV_X9M_A9TR U642 ( .A(n1210), .Y(n892) );
  MXT2_X0P7M_A9TR U643 ( .A(n1151), .B(n1150), .S0(n1214), .Y(n1152) );
  AND2_X2B_A9TR U644 ( .A(n1214), .B(n956), .Y(n957) );
  MXT2_X0P7M_A9TR U645 ( .A(n1164), .B(n1163), .S0(n1214), .Y(n1165) );
  AND2_X3B_A9TR U646 ( .A(n424), .B(n176), .Y(n929) );
  ADDF_X1M_A9TR U647 ( .A(n902), .B(n894), .CI(n510), .CO(n546), .S(n542) );
  OR2_X2M_A9TR U648 ( .A(n733), .B(n689), .Y(n701) );
  OAI21_X1M_A9TR U649 ( .A0(n413), .A1(n412), .B0(n411), .Y(n414) );
  ADDF_X1M_A9TR U650 ( .A(n1032), .B(n1034), .CI(n700), .CO(n734), .S(n733) );
  ADDF_X1M_A9TR U651 ( .A(n897), .B(n899), .CI(n509), .CO(n548), .S(n547) );
  NAND2_X2B_A9TR U652 ( .A(n259), .B(n254), .Y(n916) );
  AND2_X0P5B_A9TR U653 ( .A(n813), .B(n812), .Y(n188) );
  AO21A1AI2_X3M_A9TR U654 ( .A0(n490), .A1(n489), .B0(n825), .C0(n488), .Y(
        n895) );
  OR2_X0P7M_A9TR U655 ( .A(n802), .B(n801), .Y(n275) );
  ADDF_X1M_A9TR U656 ( .A(n945), .B(n947), .CI(n655), .CO(n706), .S(n705) );
  OR2_X1M_A9TR U657 ( .A(n1245), .B(n178), .Y(n1404) );
  ADDF_X1M_A9TR U658 ( .A(n1010), .B(n1012), .CI(n678), .CO(n727), .S(n726) );
  NAND2_X1A_A9TR U659 ( .A(n834), .B(n833), .Y(n835) );
  NOR2_X1B_A9TR U660 ( .A(n393), .B(n392), .Y(n395) );
  ADDF_X1M_A9TR U661 ( .A(n1043), .B(n756), .CI(n1045), .CO(n769), .S(n735) );
  AND2_X2B_A9TR U662 ( .A(n629), .B(n176), .Y(n945) );
  OR2_X0P7M_A9TR U663 ( .A(n562), .B(n390), .Y(n393) );
  NOR2_X2M_A9TR U664 ( .A(n699), .B(n753), .Y(n842) );
  MX2_X1B_A9TR U665 ( .A(n591), .B(n881), .S0(n177), .Y(n592) );
  NOR2B_X0P7M_A9TR U666 ( .AN(n784), .B(n177), .Y(n785) );
  NOR2B_X0P7M_A9TR U667 ( .AN(n798), .B(n177), .Y(n799) );
  NOR2B_X0P7M_A9TR U668 ( .AN(n796), .B(n177), .Y(n797) );
  NOR2B_X0P7M_A9TR U669 ( .AN(n788), .B(n177), .Y(n789) );
  MX2_X1B_A9TR U670 ( .A(n609), .B(n878), .S0(n177), .Y(n610) );
  NOR2B_X1M_A9TR U671 ( .AN(n681), .B(n177), .Y(n682) );
  NOR2B_X0P7M_A9TR U672 ( .AN(n809), .B(n177), .Y(n810) );
  NOR2B_X0P7M_A9TR U673 ( .AN(n816), .B(n177), .Y(n817) );
  NOR2B_X1M_A9TR U674 ( .AN(n691), .B(n177), .Y(n692) );
  NOR2B_X0P7M_A9TR U675 ( .AN(n807), .B(n177), .Y(n808) );
  NOR2_X2M_A9TR U676 ( .A(n515), .B(n753), .Y(n618) );
  NOR2B_X0P7M_A9TR U677 ( .AN(n753), .B(n752), .Y(n754) );
  NOR2_X2A_A9TR U678 ( .A(n680), .B(n753), .Y(n828) );
  NOR2_X2M_A9TR U679 ( .A(n467), .B(n753), .Y(n668) );
  OAI222_X2M_A9TR U680 ( .A0(n760), .A1(n418), .B0(n646), .B1(n565), .C0(n638), 
        .C1(n600), .Y(n818) );
  NOR2_X2M_A9TR U681 ( .A(n786), .B(n753), .Y(n878) );
  INV_X6M_A9TR U682 ( .A(n531), .Y(n568) );
  MXIT2_X1P4M_A9TR U683 ( .A(n671), .B(n672), .S0(n753), .Y(n809) );
  INV_X5M_A9TR U684 ( .A(n600), .Y(n581) );
  INV_X4M_A9TR U685 ( .A(n449), .Y(n531) );
  MXIT2_X1P4M_A9TR U686 ( .A(n560), .B(n561), .S0(n630), .Y(n661) );
  NAND2_X1A_A9TR U687 ( .A(n560), .B(n626), .Y(n765) );
  OAI22BB_X2M_A9TR U688 ( .A0(n637), .A1(n639), .B0N(n525), .B1N(n457), .Y(
        n458) );
  MXIT2_X1P4M_A9TR U689 ( .A(n589), .B(n590), .S0(n630), .Y(n680) );
  OR2_X0P7M_A9TR U690 ( .A(n562), .B(n375), .Y(n377) );
  INV_X7P5M_A9TR U691 ( .A(n431), .Y(n600) );
  AND2_X1M_A9TR U692 ( .A(n837), .B(n197), .Y(n257) );
  AND2_X0P5B_A9TR U693 ( .A(n431), .B(n417), .Y(n375) );
  NOR2_X2M_A9TR U694 ( .A(n518), .B(n492), .Y(n575) );
  NAND2_X4B_A9TR U695 ( .A(n461), .B(n460), .Y(n694) );
  MXIT2_X1P4M_A9TR U696 ( .A(n517), .B(n425), .S0(n518), .Y(n558) );
  MXIT2_X1P4M_A9TR U697 ( .A(n530), .B(n529), .S0(n528), .Y(n695) );
  MXIT2_X1P4M_A9TR U698 ( .A(n512), .B(n429), .S0(n518), .Y(n561) );
  NAND2_X4B_A9TR U699 ( .A(n244), .B(n245), .Y(n1379) );
  OAI21_X3M_A9TR U700 ( .A0(n341), .A1(n344), .B0(n242), .Y(n241) );
  OAI21_X3M_A9TR U701 ( .A0(n333), .A1(n345), .B0(n346), .Y(n240) );
  AOI21_X3M_A9TR U702 ( .A0(n335), .A1(n276), .B0(n310), .Y(n344) );
  NAND2_X2B_A9TR U703 ( .A(n343), .B(n342), .Y(n441) );
  NOR2_X3M_A9TR U704 ( .A(n332), .B(n345), .Y(n243) );
  NOR2_X3M_A9TR U705 ( .A(n313), .B(n1388), .Y(n332) );
  INV_X2M_A9TR U706 ( .A(n439), .Y(n310) );
  NAND2_X2B_A9TR U707 ( .A(n313), .B(n1388), .Y(n333) );
  OR2_X3B_A9TR U708 ( .A(n273), .B(n272), .Y(n439) );
  NAND2_X3B_A9TR U709 ( .A(n311), .B(n1392), .Y(n342) );
  INV_X0P6M_A9TR U710 ( .A(n361), .Y(n308) );
  INV_X5M_A9TR U711 ( .A(n1406), .Y(n178) );
  INV_X6M_A9TR U712 ( .A(n1382), .Y(n1397) );
  NAND2_X2B_A9TR U713 ( .A(n1382), .B(n307), .Y(n361) );
  INV_X0P6M_A9TR U714 ( .A(n497), .Y(n498) );
  OR2_X1M_A9TR U715 ( .A(n326), .B(n329), .Y(n282) );
  INV_X0P6M_A9TR U716 ( .A(n329), .Y(n331) );
  INV_X0P6M_A9TR U717 ( .A(n326), .Y(n328) );
  XNOR2_X0P7M_A9TR U718 ( .A(n360), .B(n432), .Y(n191) );
  XOR2_X2M_A9TR U719 ( .A(n305), .B(n304), .Y(n306) );
  INV_X11M_A9TR U720 ( .A(n196), .Y(n174) );
  XOR2_X1P4M_A9TR U721 ( .A(sign_b), .B(sign_a), .Y(n1385) );
  BUFH_X9M_A9TR U722 ( .A(n1409), .Y(adder_mant[27]) );
  XOR2_X3M_A9TR U723 ( .A(n233), .B(n1406), .Y(n1409) );
  XNOR2_X3M_A9TR U724 ( .A(n1405), .B(n1246), .Y(n1412) );
  NOR2_X6A_A9TR U725 ( .A(n231), .B(n230), .Y(n233) );
  OAI21_X6M_A9TR U726 ( .A0(n263), .A1(n1287), .B0(n219), .Y(n218) );
  NOR3_X3M_A9TR U727 ( .A(n1350), .B(n1355), .C(n1349), .Y(n224) );
  NAND2_X3B_A9TR U728 ( .A(n1322), .B(n223), .Y(n222) );
  NAND2_X2B_A9TR U729 ( .A(n1300), .B(n1083), .Y(n1288) );
  NOR2_X2A_A9TR U730 ( .A(n1328), .B(n1315), .Y(n1300) );
  NOR2_X2M_A9TR U731 ( .A(n1289), .B(n1295), .Y(n1369) );
  OA21_X4M_A9TR U732 ( .A0(n1359), .A1(n1362), .B0(n1360), .Y(n1349) );
  NOR2_X4M_A9TR U733 ( .A(n1077), .B(n1076), .Y(n1315) );
  NOR2_X3A_A9TR U734 ( .A(n993), .B(n992), .Y(n1323) );
  NOR2_X2M_A9TR U735 ( .A(n1085), .B(n1084), .Y(n1289) );
  OR2_X1M_A9TR U736 ( .A(n1170), .B(n1169), .Y(n1262) );
  NAND2_X2B_A9TR U737 ( .A(n1081), .B(n1080), .Y(n1307) );
  NAND2_X2B_A9TR U738 ( .A(n1087), .B(n1086), .Y(n1296) );
  OR2_X1M_A9TR U739 ( .A(n1143), .B(n1142), .Y(n1280) );
  OR2_X1M_A9TR U740 ( .A(n1232), .B(n1231), .Y(n1253) );
  NAND2_X2B_A9TR U741 ( .A(n1077), .B(n1076), .Y(n1316) );
  NAND2_X3B_A9TR U742 ( .A(n1075), .B(n1074), .Y(n1329) );
  NAND2_X2B_A9TR U743 ( .A(n939), .B(n938), .Y(n1356) );
  OR2_X1M_A9TR U744 ( .A(n1204), .B(n1203), .Y(n1208) );
  NOR2_X4A_A9TR U745 ( .A(n1087), .B(n1086), .Y(n1295) );
  NAND2_X2B_A9TR U746 ( .A(n937), .B(n936), .Y(n1360) );
  NAND2_X2B_A9TR U747 ( .A(n1085), .B(n1084), .Y(n1291) );
  OR2_X1M_A9TR U748 ( .A(n1116), .B(n1115), .Y(n1271) );
  NOR2_X4A_A9TR U749 ( .A(n989), .B(n988), .Y(n1340) );
  NAND2_X2B_A9TR U750 ( .A(n989), .B(n988), .Y(n1341) );
  ADDF_X1M_A9TR U751 ( .A(n1073), .B(n1072), .CI(n1071), .CO(n1088), .S(n1087)
         );
  ADDF_X1M_A9TR U752 ( .A(n1101), .B(n1100), .CI(n1099), .CO(n1102), .S(n1089)
         );
  ADDF_X1M_A9TR U753 ( .A(n985), .B(n984), .CI(n983), .CO(n992), .S(n991) );
  ADDF_X1M_A9TR U754 ( .A(n926), .B(n925), .CI(n924), .CO(n919), .S(n936) );
  ADDF_X1M_A9TR U755 ( .A(n932), .B(n931), .CI(n930), .CO(n921), .S(n1367) );
  NOR2_X2M_A9TR U756 ( .A(n934), .B(n933), .Y(n1364) );
  ADDF_X1P4M_A9TR U757 ( .A(n952), .B(n951), .CI(n950), .CO(n986), .S(n941) );
  ADDF_X1M_A9TR U758 ( .A(n912), .B(n911), .CI(n910), .CO(n951), .S(n918) );
  AND2_X2M_A9TR U759 ( .A(n1195), .B(n998), .Y(n999) );
  MXT2_X0P7M_A9TR U760 ( .A(n894), .B(n895), .S0(n1195), .Y(n926) );
  AND2_X2M_A9TR U761 ( .A(n1195), .B(n1010), .Y(n1011) );
  XOR2_X1P4M_A9TR U762 ( .A(n908), .B(n907), .Y(n931) );
  AND2_X2B_A9TR U763 ( .A(n1195), .B(n1021), .Y(n1022) );
  XOR2_X1P4M_A9TR U764 ( .A(n903), .B(n907), .Y(n927) );
  MXT2_X0P7M_A9TR U765 ( .A(n1109), .B(n1110), .S0(n1214), .Y(n1120) );
  MXT2_X2M_A9TR U766 ( .A(n906), .B(n905), .S0(n1067), .Y(n908) );
  BUFH_X9M_A9TR U767 ( .A(n1067), .Y(n1195) );
  MXT2_X1P4B_A9TR U768 ( .A(n916), .B(n915), .S0(n1214), .Y(n917) );
  NOR2_X2A_A9TR U769 ( .A(n554), .B(n538), .Y(n557) );
  NOR2_X3A_A9TR U770 ( .A(n702), .B(n740), .Y(n743) );
  AOI21_X3M_A9TR U771 ( .A0(n545), .A1(n544), .B0(n543), .Y(n555) );
  NAND2_X2B_A9TR U772 ( .A(n278), .B(n552), .Y(n554) );
  AND2_X2B_A9TR U773 ( .A(n542), .B(n541), .Y(n543) );
  OAI21_X2M_A9TR U774 ( .A0(n716), .A1(n715), .B0(n714), .Y(n721) );
  AND2_X1M_A9TR U775 ( .A(n540), .B(n539), .Y(n544) );
  AND2_X2B_A9TR U776 ( .A(n547), .B(n546), .Y(n551) );
  NAND2_X1A_A9TR U777 ( .A(n181), .B(n183), .Y(n702) );
  NAND2_X2B_A9TR U778 ( .A(n738), .B(n701), .Y(n740) );
  AOI21_X1P4M_A9TR U779 ( .A0(n416), .A1(n415), .B0(n414), .Y(n423) );
  AND2_X1P4M_A9TR U780 ( .A(n726), .B(n725), .Y(n730) );
  OR2_X2M_A9TR U781 ( .A(n677), .B(n727), .Y(n181) );
  OAI21_X1P4M_A9TR U782 ( .A0(n407), .A1(n406), .B0(n405), .Y(n415) );
  NOR2_X3A_A9TR U783 ( .A(n713), .B(n712), .Y(n716) );
  AND2_X2B_A9TR U784 ( .A(n733), .B(n732), .Y(n737) );
  OR2_X1M_A9TR U785 ( .A(n846), .B(n845), .Y(n279) );
  INV_X1P7M_A9TR U786 ( .A(n916), .Y(n653) );
  NAND2XB_X1M_A9TR U787 ( .BN(n814), .A(n281), .Y(n210) );
  NAND2_X0P7A_A9TR U788 ( .A(n188), .B(n281), .Y(n208) );
  NOR2_X2A_A9TR U789 ( .A(n886), .B(n885), .Y(n888) );
  INV_X1P7M_A9TR U790 ( .A(n900), .Y(n509) );
  AND2_X2M_A9TR U791 ( .A(n871), .B(n870), .Y(n872) );
  NAND2XB_X1M_A9TR U792 ( .BN(n380), .A(n379), .Y(n408) );
  OAI211_X3M_A9TR U793 ( .A0(n465), .A1(n825), .B0(n464), .C0(n463), .Y(n900)
         );
  NOR2B_X1P4M_A9TR U794 ( .AN(n610), .B(n1236), .Y(n980) );
  OAI31_X3M_A9TR U795 ( .A0(n750), .A1(n751), .A2(n694), .B0(n588), .Y(n959)
         );
  MXT2_X0P5M_A9TR U796 ( .A(n1238), .B(n1237), .S0(n1236), .Y(n1244) );
  AOI21_X2M_A9TR U797 ( .A0(n503), .A1(n686), .B0(n260), .Y(n259) );
  OAI31_X3M_A9TR U798 ( .A0(n698), .A1(n697), .A2(n694), .B0(n652), .Y(n948)
         );
  OAI31_X3M_A9TR U799 ( .A0(n780), .A1(n694), .A2(n781), .B0(n606), .Y(n981)
         );
  OR2_X0P7M_A9TR U800 ( .A(n419), .B(n396), .Y(n376) );
  OR2_X0P7M_A9TR U801 ( .A(n419), .B(n396), .Y(n382) );
  OR2_X0P7M_A9TR U802 ( .A(n396), .B(n389), .Y(n390) );
  NOR2_X2A_A9TR U803 ( .A(n502), .B(n261), .Y(n686) );
  INV_X1P7M_A9TR U804 ( .A(n818), .Y(n462) );
  MXIT2_X1P4M_A9TR U805 ( .A(n667), .B(n467), .S0(n753), .Y(n807) );
  NOR2_X2M_A9TR U806 ( .A(n757), .B(n753), .Y(n866) );
  NOR2_X2M_A9TR U807 ( .A(n764), .B(n753), .Y(n863) );
  MXIT2_X0P5M_A9TR U808 ( .A(n787), .B(n786), .S0(n753), .Y(n788) );
  NOR2XB_X1M_A9TR U809 ( .BN(n753), .A(n783), .Y(n591) );
  MXIT2_X0P5M_A9TR U810 ( .A(n783), .B(n782), .S0(n753), .Y(n784) );
  NOR2XB_X1M_A9TR U811 ( .BN(n753), .A(n658), .Y(n659) );
  NOR2_X2M_A9TR U812 ( .A(n782), .B(n753), .Y(n881) );
  OAI222_X2M_A9TR U813 ( .A0(n641), .A1(n594), .B0(n644), .B1(n597), .C0(n646), 
        .C1(n595), .Y(n751) );
  NOR2XB_X1P4M_A9TR U814 ( .BN(n753), .A(n661), .Y(n662) );
  NOR2XB_X1M_A9TR U815 ( .BN(n753), .A(n671), .Y(n673) );
  NOR2XB_X1M_A9TR U816 ( .BN(n753), .A(n667), .Y(n669) );
  NOR2XB_X0P7M_A9TR U817 ( .BN(n753), .A(n613), .Y(n615) );
  OAI222_X2M_A9TR U818 ( .A0(n600), .A1(n593), .B0(n646), .B1(n596), .C0(n777), 
        .C1(n418), .Y(n826) );
  NOR2_X2A_A9TR U819 ( .A(n683), .B(n753), .Y(n830) );
  NOR2_X2M_A9TR U820 ( .A(n661), .B(n753), .Y(n820) );
  MXIT2_X1P4M_A9TR U821 ( .A(n579), .B(n578), .S0(n626), .Y(n752) );
  AOI22_X1M_A9TR U822 ( .A0(n525), .A1(n599), .B0(n504), .B1(n601), .Y(n505)
         );
  INV_X4M_A9TR U823 ( .A(n626), .Y(n418) );
  NAND2XB_X2M_A9TR U824 ( .BN(n630), .A(n608), .Y(n786) );
  AOI22_X0P7M_A9TR U825 ( .A0(n1399), .A1(acc_mant[15]), .B0(n778), .B1(n777), 
        .Y(n779) );
  NOR2_X6A_A9TR U826 ( .A(n436), .B(n528), .Y(n525) );
  NAND2B_X2M_A9TR U827 ( .AN(n693), .B(n528), .Y(n434) );
  NOR2B_X3M_A9TR U828 ( .AN(n518), .B(n495), .Y(n607) );
  MXIT2_X2M_A9TR U829 ( .A(n491), .B(n493), .S0(n518), .Y(n576) );
  NOR2_X2M_A9TR U830 ( .A(n518), .B(n497), .Y(n578) );
  NOR2B_X2M_A9TR U831 ( .AN(n518), .B(n511), .Y(n560) );
  NOR2_X6A_A9TR U832 ( .A(n518), .B(n693), .Y(n431) );
  NOR2B_X2M_A9TR U833 ( .AN(n518), .B(n491), .Y(n589) );
  INV_X4M_A9TR U834 ( .A(n1389), .Y(n176) );
  NAND2_X6B_A9TR U835 ( .A(n359), .B(n358), .Y(n693) );
  AND2_X2M_A9TR U836 ( .A(n1400), .B(n442), .Y(n460) );
  NOR2_X2A_A9TR U837 ( .A(n237), .B(n191), .Y(n236) );
  INV_X7P5M_A9TR U838 ( .A(n237), .Y(n1400) );
  NAND2B_X1M_A9TR U839 ( .AN(n1379), .B(n364), .Y(n365) );
  NOR4BB_X3M_A9TR U840 ( .AN(n251), .BN(n339), .C(n340), .D(n387), .Y(n250) );
  OR2_X3M_A9TR U841 ( .A(n320), .B(n249), .Y(n244) );
  AOI21_X4M_A9TR U842 ( .A0(n243), .A1(n241), .B0(n240), .Y(n320) );
  XNOR2_X3M_A9TR U843 ( .A(n362), .B(n276), .Y(n364) );
  NAND2_X2B_A9TR U844 ( .A(n335), .B(n439), .Y(n362) );
  NOR2_X4M_A9TR U845 ( .A(n315), .B(n314), .Y(n345) );
  XOR2_X3M_A9TR U846 ( .A(n1397), .B(n301), .Y(n273) );
  NAND2_X0P7A_A9TR U847 ( .A(n331), .B(n330), .Y(n349) );
  OR2_X1M_A9TR U848 ( .A(n323), .B(n322), .Y(n185) );
  NOR2_X2M_A9TR U849 ( .A(n168), .B(n194), .Y(n296) );
  NAND2_X2B_A9TR U850 ( .A(n303), .B(n302), .Y(n304) );
  INV_X0P6M_A9TR U851 ( .A(acc_mant[23]), .Y(n877) );
  INV_X3M_A9TR U852 ( .A(n1401), .Y(n338) );
  OR2_X2B_A9TR U853 ( .A(n166), .B(n170), .Y(n303) );
  BUF_X1P4B_A9TR U854 ( .A(is_nan_input), .Y(n1402) );
  MXIT2_X1M_A9TR U855 ( .A(n613), .B(n519), .S0(n753), .Y(n796) );
  INV_X1M_A9TR U856 ( .A(n446), .Y(n442) );
  NOR2B_X3M_A9TR U857 ( .AN(n685), .B(n1236), .Y(n1034) );
  XOR2_X1P4M_A9TR U858 ( .A(n960), .B(n1406), .Y(n964) );
  XOR2_X1P4M_A9TR U859 ( .A(n914), .B(n178), .Y(n943) );
  XOR2_X1P4M_A9TR U860 ( .A(n917), .B(n178), .Y(n942) );
  XOR2_X4M_A9TR U861 ( .A(exp_a[0]), .B(exp_b[0]), .Y(n1401) );
  NAND2_X2B_A9TR U862 ( .A(n625), .B(n720), .Y(n723) );
  AND2_X3B_A9TR U863 ( .A(n175), .B(n418), .Y(n396) );
  MXT2_X1P4M_A9TR U864 ( .A(n514), .B(n513), .S0(n518), .Y(n632) );
  NAND2_X1A_A9TR U865 ( .A(n1400), .B(n446), .Y(n447) );
  OR2_X2M_A9TR U866 ( .A(n735), .B(n734), .Y(n738) );
  OAI21_X0P5M_A9TR U867 ( .A0(n173), .A1(acc_mant[17]), .B0(n197), .Y(n476) );
  NAND2_X2B_A9TR U868 ( .A(n743), .B(n703), .Y(n205) );
  AOI21_X4M_A9TR U869 ( .A0(n744), .A1(n743), .B0(n742), .Y(n204) );
  AOI22_X0P5M_A9TR U870 ( .A0(n173), .A1(acc_mant[6]), .B0(n522), .B1(
        acc_mant[5]), .Y(n583) );
  OAI211_X0P5M_A9TR U871 ( .A0(n173), .A1(acc_mant[7]), .B0(n197), .C0(n471), 
        .Y(n599) );
  MXT2_X0P7M_A9TR U872 ( .A(n1001), .B(n1000), .S0(n1067), .Y(n1002) );
  NAND2_X1A_A9TR U873 ( .A(n323), .B(n322), .Y(n324) );
  NOR2_X1A_A9TR U874 ( .A(n987), .B(n986), .Y(n1338) );
  NOR2_X2A_A9TR U875 ( .A(n1338), .B(n1340), .Y(n1322) );
  OR2_X1P4M_A9TR U876 ( .A(n547), .B(n546), .Y(n278) );
  NAND2_X0P5A_A9TR U877 ( .A(n173), .B(n675), .Y(n435) );
  AOI22_X0P5M_A9TR U878 ( .A0(n482), .A1(acc_mant[7]), .B0(n522), .B1(
        acc_mant[6]), .Y(n645) );
  OAI211_X0P5M_A9TR U879 ( .A0(n173), .A1(acc_mant[12]), .B0(n197), .C0(n451), 
        .Y(n634) );
  NOR2_X1P4M_A9TR U880 ( .A(n792), .B(n791), .Y(n199) );
  OAI22_X2M_A9TR U881 ( .A0(n532), .A1(n805), .B0(n676), .B1(n694), .Y(n487)
         );
  AND2_X1M_A9TR U882 ( .A(n852), .B(n177), .Y(n580) );
  OAI22_X1M_A9TR U883 ( .A0(n646), .A1(n599), .B0(n641), .B1(n601), .Y(n587)
         );
  MXT2_X0P7M_A9TR U884 ( .A(n970), .B(n969), .S0(n1067), .Y(n971) );
  NOR2B_X2M_A9TR U885 ( .AN(n620), .B(n1236), .Y(n1000) );
  MXT2_X0P7M_A9TR U886 ( .A(n619), .B(n618), .S0(n177), .Y(n620) );
  NOR2B_X1M_A9TR U887 ( .AN(n754), .B(n177), .Y(n755) );
  MXT2_X0P7M_A9TR U888 ( .A(n1069), .B(n1068), .S0(n1067), .Y(n1070) );
  NAND2_X2B_A9TR U889 ( .A(n315), .B(n314), .Y(n346) );
  AND2_X1M_A9TR U890 ( .A(n828), .B(n177), .Y(n494) );
  AND2_X1M_A9TR U891 ( .A(n850), .B(n177), .Y(n577) );
  NAND2_X1A_A9TR U892 ( .A(n282), .B(n187), .Y(n248) );
  NAND2_X1A_A9TR U893 ( .A(n334), .B(n333), .Y(n340) );
  NOR2_X3A_A9TR U894 ( .A(n1333), .B(n1323), .Y(n223) );
  NAND2_X3B_A9TR U895 ( .A(n286), .B(n289), .Y(n288) );
  ADDF_X1M_A9TR U896 ( .A(n1021), .B(n1023), .CI(n731), .CO(n689), .S(n677) );
  MXIT2_X0P5M_A9TR U897 ( .A(n853), .B(n867), .S0(n173), .Y(n495) );
  AND2_X1M_A9TR U898 ( .A(n735), .B(n734), .Y(n736) );
  OR2_X1M_A9TR U899 ( .A(n705), .B(n704), .Y(n656) );
  ADDF_X1M_A9TR U900 ( .A(n1054), .B(n768), .CI(n1056), .CO(n771), .S(n770) );
  INV_X0P5B_A9TR U901 ( .A(n1057), .Y(n768) );
  NAND2_X1A_A9TR U902 ( .A(n1401), .B(n352), .Y(n353) );
  OAI21_X1M_A9TR U903 ( .A0(n310), .A1(n277), .B0(n335), .Y(n440) );
  OA21_X1M_A9TR U904 ( .A0(n308), .A1(n190), .B0(n336), .Y(n277) );
  NOR2_X1A_A9TR U905 ( .A(n775), .B(n202), .Y(n201) );
  NOR2_X1A_A9TR U906 ( .A(n770), .B(n769), .Y(n202) );
  OR2_X1P4M_A9TR U907 ( .A(n1382), .B(n307), .Y(n336) );
  AND2_X1M_A9TR U908 ( .A(n398), .B(n879), .Y(n404) );
  AND2_X1M_A9TR U909 ( .A(n385), .B(n383), .Y(n410) );
  NAND2_X1A_A9TR U910 ( .A(n385), .B(n384), .Y(n409) );
  NOR2_X1A_A9TR U911 ( .A(n380), .B(n378), .Y(n283) );
  OAI22BB_X1M_A9TR U912 ( .A0(n826), .A1(n532), .B0N(n1399), .B1N(acc_mant[3]), 
        .Y(n260) );
  INV_X0P5B_A9TR U913 ( .A(n694), .Y(n503) );
  AOI22_X0P5M_A9TR U914 ( .A0(n173), .A1(acc_mant[5]), .B0(n522), .B1(
        acc_mant[4]), .Y(n643) );
  NAND2_X0P5A_A9TR U915 ( .A(n173), .B(n665), .Y(n479) );
  INV_X1M_A9TR U916 ( .A(n639), .Y(n504) );
  OAI22_X1M_A9TR U917 ( .A0(n594), .A1(n639), .B0(n641), .B1(n595), .Y(n502)
         );
  OAI22_X1P4M_A9TR U918 ( .A0(n646), .A1(n597), .B0(n644), .B1(n582), .Y(n261)
         );
  MXIT2_X1P4M_A9TR U919 ( .A(n607), .B(n608), .S0(n626), .Y(n683) );
  OAI222_X1P4M_A9TR U920 ( .A0(n641), .A1(n637), .B0(n644), .B1(n636), .C0(
        n646), .C1(n635), .Y(n698) );
  NOR2_X1A_A9TR U921 ( .A(n639), .B(n638), .Y(n697) );
  NOR2_X2A_A9TR U922 ( .A(n528), .B(n501), .Y(n777) );
  XOR2_X2M_A9TR U923 ( .A(n271), .B(n295), .Y(n311) );
  NOR2_X1A_A9TR U924 ( .A(n317), .B(n316), .Y(n326) );
  NOR2_X1A_A9TR U925 ( .A(n338), .B(n351), .Y(n337) );
  NAND2B_X1M_A9TR U926 ( .AN(n626), .B(n627), .Y(n519) );
  AO22_X1M_A9TR U927 ( .A0(n568), .A1(n567), .B0(n581), .B1(n566), .Y(n572) );
  AND2_X1M_A9TR U928 ( .A(n1214), .B(n967), .Y(n968) );
  NAND2_X1A_A9TR U929 ( .A(n628), .B(n630), .Y(n613) );
  MXT2_X0P7M_A9TR U930 ( .A(n981), .B(n980), .S0(n1067), .Y(n982) );
  MXT2_X0P7M_A9TR U931 ( .A(n1009), .B(n1012), .S0(n1067), .Y(n1013) );
  MXT2_X0P7M_A9TR U932 ( .A(n1046), .B(n1045), .S0(n1067), .Y(n1047) );
  AND2_X1M_A9TR U933 ( .A(n1067), .B(n1043), .Y(n1044) );
  NOR2_X1A_A9TR U934 ( .A(n699), .B(n227), .Y(n1045) );
  NAND2_X1A_A9TR U935 ( .A(n589), .B(n630), .Y(n783) );
  OAI31_X2M_A9TR U936 ( .A0(n763), .A1(n762), .A2(n825), .B0(n761), .Y(n1069)
         );
  AND2_X1M_A9TR U937 ( .A(n1195), .B(n1107), .Y(n1108) );
  NOR2_X1A_A9TR U938 ( .A(n519), .B(n753), .Y(n614) );
  NAND2_X1A_A9TR U939 ( .A(n208), .B(n189), .Y(n207) );
  NAND2_X1A_A9TR U940 ( .A(n347), .B(n346), .Y(n348) );
  INV_X1P2M_A9TR U941 ( .A(n345), .Y(n347) );
  NOR2_X1A_A9TR U942 ( .A(n423), .B(n422), .Y(n424) );
  AOI22_X1M_A9TR U943 ( .A0(n524), .A1(acc_mant[4]), .B0(n523), .B1(
        acc_mant[2]), .Y(n489) );
  AOI31_X1M_A9TR U944 ( .A0(n568), .A1(n522), .A2(acc_mant[3]), .B0(n472), .Y(
        n490) );
  AND2_X1M_A9TR U945 ( .A(n816), .B(n177), .Y(n426) );
  ADDF_X1M_A9TR U946 ( .A(n966), .B(n965), .CI(n964), .CO(n984), .S(n972) );
  XOR2_X1M_A9TR U947 ( .A(n957), .B(n178), .Y(n965) );
  XOR2_X1P4M_A9TR U948 ( .A(n999), .B(n178), .Y(n1007) );
  MXT2_X0P7M_A9TR U949 ( .A(n1023), .B(n1024), .S0(n1214), .Y(n1031) );
  XOR2_X0P7M_A9TR U950 ( .A(n1025), .B(n178), .Y(n1029) );
  XOR2_X1P4M_A9TR U951 ( .A(n1022), .B(n178), .Y(n1030) );
  ADDF_X1M_A9TR U952 ( .A(n1042), .B(n1041), .CI(n1040), .CO(n1060), .S(n1048)
         );
  MXT2_X0P7M_A9TR U953 ( .A(n1034), .B(n1035), .S0(n1214), .Y(n1042) );
  ADDF_X1M_A9TR U954 ( .A(n1053), .B(n1052), .CI(n1051), .CO(n1072), .S(n1059)
         );
  MXT2_X0P7M_A9TR U955 ( .A(n1045), .B(n1046), .S0(n1214), .Y(n1053) );
  MXT2_X0P7M_A9TR U956 ( .A(n1056), .B(n1057), .S0(n1214), .Y(n1064) );
  XOR2_X1P4M_A9TR U957 ( .A(n1058), .B(n178), .Y(n1062) );
  ADDF_X1M_A9TR U958 ( .A(n1106), .B(n1105), .CI(n1104), .CO(n1127), .S(n1112)
         );
  ADDF_X1M_A9TR U959 ( .A(n1120), .B(n1119), .CI(n1118), .CO(n1140), .S(n1126)
         );
  XOR2_X0P7M_A9TR U960 ( .A(n1108), .B(n178), .Y(n1119) );
  OAI21_X1P4M_A9TR U961 ( .A0(n291), .A1(n290), .B0(n289), .Y(n305) );
  AND2_X1M_A9TR U962 ( .A(n520), .B(n176), .Y(n909) );
  AND2_X1M_A9TR U963 ( .A(n796), .B(n177), .Y(n520) );
  AOI21B_X3M_A9TR U964 ( .A0(n182), .A1(n320), .B0N(n186), .Y(n245) );
  NAND2_X1A_A9TR U965 ( .A(n934), .B(n933), .Y(n1365) );
  AOI2XB1_X1M_A9TR U966 ( .A1N(n1265), .A0(n1117), .B0(n214), .Y(n213) );
  NAND2B_X1M_A9TR U967 ( .AN(n1256), .B(n1404), .Y(n232) );
  XOR2_X0P5M_A9TR U968 ( .A(n306), .B(n1397), .Y(n1398) );
  XOR2_X2M_A9TR U969 ( .A(n1358), .B(n1349), .Y(adder_mant[2]) );
  XNOR2_X2M_A9TR U970 ( .A(n1348), .B(n1347), .Y(adder_mant[4]) );
  XOR2_X2M_A9TR U971 ( .A(n1344), .B(n1343), .Y(adder_mant[5]) );
  AOI21_X1M_A9TR U972 ( .A0(n1348), .A1(n1346), .B0(n1339), .Y(n1344) );
  XOR2_X2M_A9TR U973 ( .A(n1337), .B(n1336), .Y(adder_mant[6]) );
  XNOR2_X2M_A9TR U974 ( .A(n1327), .B(n1326), .Y(adder_mant[7]) );
  XNOR2_X2M_A9TR U975 ( .A(n1319), .B(n1318), .Y(adder_mant[9]) );
  OAI21_X1M_A9TR U976 ( .A0(n1332), .A1(n1328), .B0(n1329), .Y(n1319) );
  XNOR2_X2M_A9TR U977 ( .A(n1314), .B(n1313), .Y(adder_mant[10]) );
  XOR2_X2M_A9TR U978 ( .A(n1310), .B(n1309), .Y(adder_mant[11]) );
  AOI21_X1M_A9TR U979 ( .A0(n1314), .A1(n1312), .B0(n1305), .Y(n1310) );
  XOR2_X2M_A9TR U980 ( .A(n1373), .B(n1290), .Y(adder_mant[12]) );
  XOR2_X2M_A9TR U981 ( .A(n1299), .B(n1298), .Y(adder_mant[13]) );
  AOI21_X1M_A9TR U982 ( .A0(n1294), .A1(n1293), .B0(n1292), .Y(n1299) );
  XOR2_X2M_A9TR U983 ( .A(n1285), .B(n262), .Y(adder_mant[15]) );
  NAND2B_X1M_A9TR U984 ( .AN(n1283), .B(n1284), .Y(n262) );
  AOI21_X1M_A9TR U985 ( .A0(n1273), .A1(n1271), .B0(n1117), .Y(n1268) );
  XNOR2_X2M_A9TR U986 ( .A(n1209), .B(n1205), .Y(adder_mant[22]) );
  XNOR2_X3M_A9TR U987 ( .A(n1255), .B(n1254), .Y(adder_mant[24]) );
  AND2_X1M_A9TR U988 ( .A(n325), .B(n187), .Y(n182) );
  OR2_X1M_A9TR U989 ( .A(n726), .B(n725), .Y(n183) );
  AND2_X1M_A9TR U990 ( .A(n705), .B(n704), .Y(n184) );
  AO21_X1M_A9TR U991 ( .A0(n325), .A1(n248), .B0(n246), .Y(n186) );
  INV_X0P5B_A9TR U992 ( .A(n173), .Y(n417) );
  OA21_X1M_A9TR U993 ( .A0(n354), .A1(n432), .B0(n353), .Y(n190) );
  NAND2_X2B_A9TR U994 ( .A(n273), .B(n272), .Y(n335) );
  NOR2_X1A_A9TR U995 ( .A(n1240), .B(n1234), .Y(n192) );
  AND2_X3B_A9TR U996 ( .A(n265), .B(n264), .Y(n291) );
  NAND2_X2B_A9TR U997 ( .A(n445), .B(n1381), .Y(n534) );
  OAI21_X6M_A9TR U998 ( .A0(n206), .A1(n205), .B0(n204), .Y(n203) );
  NAND2_X4B_A9TR U999 ( .A(n215), .B(n213), .Y(n1282) );
  NAND2_X6B_A9TR U1000 ( .A(n1273), .B(n216), .Y(n215) );
  OAI21_X8M_A9TR U1001 ( .A0(n1278), .A1(n1274), .B0(n1275), .Y(n1264) );
  OAI21_X8M_A9TR U1002 ( .A0(n1285), .A1(n1283), .B0(n1284), .Y(n1273) );
  AOI21_X6M_A9TR U1003 ( .A0(n226), .A1(n1286), .B0(n218), .Y(n1285) );
  OAI31_X3M_A9TR U1004 ( .A0(n698), .A1(n697), .A2(n825), .B0(n696), .Y(n1046)
         );
  XNOR2_X2M_A9TR U1005 ( .A(n1264), .B(n1263), .Y(adder_mant[20]) );
  XNOR2_X2M_A9TR U1006 ( .A(n1282), .B(n1281), .Y(adder_mant[18]) );
  MXT2_X1M_A9TR U1007 ( .A(n1386), .B(n1385), .S0(n1384), .Y(adder_sign) );
  OAI22_X2M_A9TR U1008 ( .A0(n1383), .A1(n1382), .B0(n1381), .B1(n1380), .Y(
        adder_exp[2]) );
  NOR2_X2M_A9TR U1009 ( .A(n1379), .B(n1378), .Y(adder_exp[0]) );
  XNOR2_X2M_A9TR U1010 ( .A(n1273), .B(n1272), .Y(adder_mant[16]) );
  XOR2_X2M_A9TR U1011 ( .A(n1363), .B(n1362), .Y(adder_mant[1]) );
  XNOR2_X2M_A9TR U1012 ( .A(n1368), .B(n1367), .Y(adder_mant[0]) );
  XOR2_X0P7M_A9TR U1013 ( .A(n893), .B(n178), .Y(n925) );
  XOR2_X0P7M_A9TR U1014 ( .A(n1036), .B(n178), .Y(n1040) );
  XOR2_X0P7M_A9TR U1015 ( .A(n1002), .B(n178), .Y(n1006) );
  OAI21_X6M_A9TR U1016 ( .A0(n200), .A1(n199), .B0(n793), .Y(n804) );
  AOI21_X6M_A9TR U1017 ( .A0(n203), .A1(n201), .B0(n776), .Y(n200) );
  AOI21_X3M_A9TR U1018 ( .A0(n557), .A1(n929), .B0(n556), .Y(n206) );
  NOR2_X6M_A9TR U1019 ( .A(n209), .B(n207), .Y(n212) );
  NOR2_X6M_A9TR U1020 ( .A(n815), .B(n210), .Y(n209) );
  AOI21_X6M_A9TR U1021 ( .A0(n279), .A1(n211), .B0(n847), .Y(n860) );
  OAI21_X6M_A9TR U1022 ( .A0(n212), .A1(n836), .B0(n835), .Y(n211) );
  AOI21_X8M_A9TR U1023 ( .A0(n1282), .A1(n1280), .B0(n1144), .Y(n1278) );
  NOR2_X6M_A9TR U1024 ( .A(n1260), .B(n232), .Y(n231) );
  AND2_X3B_A9TR U1025 ( .A(n1382), .B(n235), .Y(n271) );
  XOR2_X4M_A9TR U1026 ( .A(n287), .B(n288), .Y(n234) );
  NAND2B_X6M_A9TR U1027 ( .AN(n236), .B(n238), .Y(n433) );
  OR2_X1P4M_A9TR U1028 ( .A(n1379), .B(n239), .Y(n238) );
  NOR2_X6M_A9TR U1029 ( .A(n1379), .B(n250), .Y(n237) );
  OAI211_X2M_A9TR U1030 ( .A0(n507), .A1(acc_mant[6]), .B0(n258), .C0(n255), 
        .Y(n254) );
  NOR3BB_X2M_A9TR U1031 ( .AN(n505), .BN(n257), .C(n256), .Y(n255) );
  NOR2_X1B_A9TR U1032 ( .A(n506), .B(acc_mant[4]), .Y(n256) );
  NAND2_X1A_A9TR U1033 ( .A(n508), .B(n1378), .Y(n258) );
  AOI21_X6M_A9TR U1034 ( .A0(n874), .A1(n873), .B0(n872), .Y(n269) );
  XNOR2_X2M_A9TR U1035 ( .A(n1354), .B(n1353), .Y(adder_mant[3]) );
  XOR2_X2M_A9TR U1036 ( .A(n1332), .B(n1331), .Y(adder_mant[8]) );
  XOR2_X2M_A9TR U1037 ( .A(n1190), .B(n1187), .Y(adder_mant[21]) );
  XOR2_X2M_A9TR U1038 ( .A(n1278), .B(n1277), .Y(adder_mant[19]) );
  NOR2_X4A_A9TR U1039 ( .A(n1081), .B(n1080), .Y(n1306) );
  OAI222_X2M_A9TR U1040 ( .A0(n694), .A1(n805), .B0(n676), .B1(n825), .C0(n675), .C1(n1381), .Y(n1009) );
  MXT2_X0P7M_A9TR U1041 ( .A(n669), .B(n668), .S0(n177), .Y(n670) );
  OAI222_X2M_A9TR U1042 ( .A0(n826), .A1(n694), .B0(n688), .B1(n825), .C0(
        n1381), .C1(n687), .Y(n1035) );
  INV_X2M_A9TR U1043 ( .A(n1024), .Y(n731) );
  AO21A1AI2_X3M_A9TR U1044 ( .A0(n537), .A1(n536), .B0(n825), .C0(n535), .Y(
        n906) );
  AOI21_X1P4M_A9TR U1045 ( .A0(acc_mant[0]), .A1(n534), .B0(n533), .Y(n535) );
  NOR2_X2A_A9TR U1046 ( .A(n612), .B(n716), .Y(n625) );
  OAI21_X3M_A9TR U1047 ( .A0(n555), .A1(n554), .B0(n553), .Y(n556) );
  OR2_X1M_A9TR U1048 ( .A(n431), .B(n562), .Y(n381) );
  OAI222_X2M_A9TR U1049 ( .A0(n818), .A1(n694), .B0(n666), .B1(n825), .C0(n665), .C1(n1381), .Y(n1024) );
  ADDF_X1M_A9TR U1050 ( .A(n1065), .B(n790), .CI(n1068), .CO(n791), .S(n772)
         );
  INV_X2M_A9TR U1051 ( .A(n895), .Y(n510) );
  AOI21_X3M_A9TR U1052 ( .A0(n721), .A1(n720), .B0(n719), .Y(n722) );
  NAND2_X2B_A9TR U1053 ( .A(n711), .B(n710), .Y(n715) );
  AOI21_X6M_A9TR U1054 ( .A0(n804), .A1(n275), .B0(n803), .Y(n815) );
  OAI21_X6M_A9TR U1055 ( .A0(n860), .A1(n859), .B0(n858), .Y(n874) );
  XOR2_X2M_A9TR U1056 ( .A(n300), .B(n299), .Y(n1387) );
  NOR2_X0P5A_A9TR U1057 ( .A(n306), .B(n1397), .Y(n1391) );
  NOR2_X1P4M_A9TR U1058 ( .A(n711), .B(n710), .Y(n612) );
  NAND2_X1A_A9TR U1059 ( .A(n545), .B(n280), .Y(n538) );
  OR2_X2M_A9TR U1060 ( .A(n542), .B(n541), .Y(n545) );
  OAI222_X3M_A9TR U1061 ( .A0(n646), .A1(n593), .B0(n748), .B1(n436), .C0(n600), .C1(n594), .Y(n805) );
  ADDF_X1M_A9TR U1062 ( .A(n944), .B(n943), .CI(n942), .CO(n962), .S(n950) );
  ADDF_X1M_A9TR U1063 ( .A(n955), .B(n954), .CI(n953), .CO(n973), .S(n961) );
  ADDF_X1M_A9TR U1064 ( .A(n1093), .B(n1092), .CI(n1091), .CO(n1113), .S(n1099) );
  ADDF_X1M_A9TR U1065 ( .A(n913), .B(n915), .CI(n653), .CO(n704), .S(n549) );
  AOI21_X3M_A9TR U1066 ( .A0(n709), .A1(n184), .B0(n708), .Y(n724) );
  INV_X2M_A9TR U1067 ( .A(n1001), .Y(n679) );
  OA21A1OI2_X3M_A9TR U1068 ( .A0(n651), .A1(n650), .B0(n837), .C0(n649), .Y(
        n652) );
  OAI21_X2M_A9TR U1069 ( .A0(n741), .A1(n740), .B0(n739), .Y(n742) );
  AOI21B_X2M_A9TR U1070 ( .A0(n181), .A1(n730), .B0N(n729), .Y(n741) );
  AOI21_X2M_A9TR U1071 ( .A0(n738), .A1(n737), .B0(n736), .Y(n739) );
  BUFH_X11M_A9TR U1072 ( .A(n1020), .Y(n1067) );
  NOR2_X2A_A9TR U1073 ( .A(n723), .B(n657), .Y(n703) );
  OA21A1OI2_X3M_A9TR U1074 ( .A0(n587), .A1(n586), .B0(n837), .C0(n585), .Y(
        n588) );
  ADDF_X1M_A9TR U1075 ( .A(n998), .B(n1000), .CI(n679), .CO(n725), .S(n718) );
  NOR2_X8A_A9TR U1076 ( .A(n1384), .B(n1406), .Y(n1020) );
  ADDF_X1M_A9TR U1077 ( .A(n1008), .B(n1007), .CI(n1006), .CO(n1027), .S(n1014) );
  ADDF_X1M_A9TR U1078 ( .A(n1064), .B(n1063), .CI(n1062), .CO(n1100), .S(n1071) );
  XOR2_X2M_A9TR U1079 ( .A(n1269), .B(n1268), .Y(adder_mant[17]) );
  AND2_X0P5B_A9TR U1080 ( .A(n1395), .B(n1388), .Y(n274) );
  OR2_X1M_A9TR U1081 ( .A(n540), .B(n539), .Y(n280) );
  INV_X1P7B_A9TR U1082 ( .A(n172), .Y(n1411) );
  ADDF_X1M_A9TR U1083 ( .A(n1021), .B(n1023), .CI(n731), .CO(n732), .S(n728)
         );
  NOR2_X1A_A9TR U1084 ( .A(n283), .B(n408), .Y(n386) );
  OAI22_X1M_A9TR U1085 ( .A0(n639), .A1(n598), .B0(n644), .B1(n583), .Y(n586)
         );
  ADDF_X1M_A9TR U1086 ( .A(n1019), .B(n1018), .CI(n1017), .CO(n1038), .S(n1026) );
  NOR2XB_X0P5M_A9TR U1087 ( .BN(norm_exp[3]), .A(n1402), .Y(n284) );
  INV_X0P5B_A9TR U1088 ( .A(n284), .Y(n1407) );
  NOR2XB_X0P5M_A9TR U1089 ( .BN(norm_exp[8]), .A(n1402), .Y(n285) );
  INV_X0P5B_A9TR U1090 ( .A(n285), .Y(n1408) );
  AOI21_X2M_A9TR U1091 ( .A0(n305), .A1(n303), .B0(n292), .Y(n300) );
  OAI21_X1M_A9TR U1092 ( .A0(n300), .A1(n296), .B0(n297), .Y(n1394) );
  INV_X4B_A9TR U1093 ( .A(n1394), .Y(n1388) );
  ADDH_X2M_A9TR U1094 ( .A(n294), .B(n293), .CO(n315), .S(n313) );
  INV_X1M_A9TR U1095 ( .A(n296), .Y(n298) );
  NAND2_X1A_A9TR U1096 ( .A(n298), .B(n297), .Y(n299) );
  NOR3_X1A_A9TR U1097 ( .A(n357), .B(n360), .C(n173), .Y(n339) );
  NAND2_X3B_A9TR U1098 ( .A(n1400), .B(n356), .Y(n359) );
  INV_X5M_A9TR U1099 ( .A(n693), .Y(n372) );
  BUFH_X11M_A9TR U1100 ( .A(n433), .Y(n518) );
  NOR2_X1A_A9TR U1101 ( .A(n394), .B(n391), .Y(n401) );
  NOR2_X1A_A9TR U1102 ( .A(n367), .B(n427), .Y(n400) );
  NOR2_X1A_A9TR U1103 ( .A(n367), .B(n399), .Y(n383) );
  NOR2_X2A_A9TR U1104 ( .A(n518), .B(n425), .Y(n627) );
  NOR2B_X1M_A9TR U1105 ( .AN(n614), .B(n177), .Y(n368) );
  NOR2_X1A_A9TR U1106 ( .A(n394), .B(n399), .Y(n370) );
  NOR2_X1A_A9TR U1107 ( .A(n367), .B(n391), .Y(n369) );
  ADDH_X1M_A9TR U1108 ( .A(n370), .B(n369), .CO(n1237), .S(n469) );
  NOR2_X2M_A9TR U1109 ( .A(n518), .B(n429), .Y(n631) );
  NOR2B_X1M_A9TR U1110 ( .AN(n618), .B(n177), .Y(n371) );
  MXT2_X0P7M_A9TR U1111 ( .A(n371), .B(n466), .S0(n1236), .Y(n1234) );
  NAND2B_X1M_A9TR U1112 ( .AN(n173), .B(n383), .Y(n492) );
  NOR2B_X1M_A9TR U1113 ( .AN(n668), .B(n177), .Y(n373) );
  INV_X0P5B_A9TR U1114 ( .A(n466), .Y(n378) );
  INV_X0P5B_A9TR U1115 ( .A(n469), .Y(n379) );
  INV_X0P5B_A9TR U1116 ( .A(n1237), .Y(n384) );
  NOR2_X2M_A9TR U1117 ( .A(n410), .B(n409), .Y(n412) );
  NOR2_X1A_A9TR U1118 ( .A(n386), .B(n412), .Y(n416) );
  INV_X0P6M_A9TR U1119 ( .A(n518), .Y(n388) );
  AND2_X0P5B_A9TR U1120 ( .A(n175), .B(n388), .Y(n389) );
  NOR2_X1A_A9TR U1121 ( .A(n428), .B(n391), .Y(n864) );
  INV_X0P5B_A9TR U1122 ( .A(n864), .Y(n392) );
  NOR2_X1A_A9TR U1123 ( .A(n394), .B(n427), .Y(n867) );
  NAND2_X1A_A9TR U1124 ( .A(n395), .B(n867), .Y(n407) );
  OR2_X1P4M_A9TR U1125 ( .A(n419), .B(n396), .Y(n397) );
  NOR2_X1A_A9TR U1126 ( .A(n397), .B(n562), .Y(n398) );
  INV_X0P5B_A9TR U1127 ( .A(n398), .Y(n402) );
  NOR2_X1A_A9TR U1128 ( .A(n428), .B(n399), .Y(n879) );
  ADDH_X1M_A9TR U1129 ( .A(n401), .B(n400), .CO(n466), .S(n882) );
  OR2_X1P4M_A9TR U1130 ( .A(n402), .B(n882), .Y(n403) );
  NOR2_X1P4M_A9TR U1131 ( .A(n404), .B(n403), .Y(n406) );
  NAND2_X1A_A9TR U1132 ( .A(n404), .B(n403), .Y(n405) );
  NAND2_X1A_A9TR U1133 ( .A(n283), .B(n408), .Y(n413) );
  NAND2_X1A_A9TR U1134 ( .A(n410), .B(n409), .Y(n411) );
  AND2_X0P5B_A9TR U1135 ( .A(n418), .B(n417), .Y(n420) );
  OR2_X0P7M_A9TR U1136 ( .A(n420), .B(n419), .Y(n421) );
  NAND2_X2B_A9TR U1137 ( .A(n558), .B(n630), .Y(n658) );
  AND2_X1M_A9TR U1138 ( .A(n426), .B(n176), .Y(n897) );
  NOR2_X1A_A9TR U1139 ( .A(n428), .B(n427), .Y(n853) );
  AND2_X1M_A9TR U1140 ( .A(n820), .B(n177), .Y(n430) );
  NOR2B_X2M_A9TR U1141 ( .AN(n430), .B(n1236), .Y(n899) );
  NAND2_X1A_A9TR U1142 ( .A(n581), .B(n482), .Y(n506) );
  INV_X1P7M_A9TR U1143 ( .A(n506), .Y(n523) );
  NOR2_X1B_A9TR U1144 ( .A(n646), .B(n643), .Y(n438) );
  NAND2_X6B_A9TR U1145 ( .A(n528), .B(n693), .Y(n639) );
  INV_X0P5B_A9TR U1146 ( .A(acc_mant[9]), .Y(n675) );
  OAI211_X0P7M_A9TR U1147 ( .A0(n173), .A1(acc_mant[8]), .B0(n197), .C0(n435), 
        .Y(n640) );
  INV_X2P5M_A9TR U1148 ( .A(n693), .Y(n436) );
  OAI22_X1M_A9TR U1149 ( .A0(n639), .A1(n640), .B0(n641), .B1(n645), .Y(n437)
         );
  AOI211_X2M_A9TR U1150 ( .A0(n523), .A1(acc_mant[3]), .B0(n438), .C0(n437), 
        .Y(n465) );
  NAND4_X1A_A9TR U1151 ( .A(n581), .B(n837), .C(n197), .D(n444), .Y(n445) );
  NAND2_X1A_A9TR U1152 ( .A(n534), .B(acc_mant[2]), .Y(n464) );
  INV_X1P7B_A9TR U1153 ( .A(n532), .Y(n569) );
  AOI22_X1M_A9TR U1154 ( .A0(n173), .A1(acc_mant[23]), .B0(n522), .B1(
        acc_mant[22]), .Y(n529) );
  INV_X1P2M_A9TR U1155 ( .A(n861), .Y(n760) );
  INV_X0P5B_A9TR U1156 ( .A(n530), .Y(n565) );
  INV_X0P5B_A9TR U1157 ( .A(acc_mant[19]), .Y(n827) );
  AOI21_X1M_A9TR U1158 ( .A0(n482), .A1(n827), .B0(n448), .Y(n638) );
  INV_X0P5B_A9TR U1159 ( .A(acc_mant[13]), .Y(n450) );
  NAND2_X0P5A_A9TR U1160 ( .A(n173), .B(n450), .Y(n451) );
  INV_X0P5B_A9TR U1161 ( .A(acc_mant[11]), .Y(n687) );
  NAND2_X0P5A_A9TR U1162 ( .A(n482), .B(n687), .Y(n452) );
  OAI211_X0P7M_A9TR U1163 ( .A0(n482), .A1(acc_mant[10]), .B0(n197), .C0(n452), 
        .Y(n642) );
  INV_X0P5B_A9TR U1164 ( .A(n642), .Y(n453) );
  INV_X0P5B_A9TR U1165 ( .A(acc_mant[17]), .Y(n806) );
  OAI21_X0P5M_A9TR U1166 ( .A0(n482), .A1(acc_mant[16]), .B0(n197), .Y(n454)
         );
  AOI21_X1M_A9TR U1167 ( .A0(n173), .A1(n806), .B0(n454), .Y(n637) );
  INV_X0P5B_A9TR U1168 ( .A(acc_mant[15]), .Y(n456) );
  OAI21_X0P5M_A9TR U1169 ( .A0(n482), .A1(acc_mant[14]), .B0(n197), .Y(n455)
         );
  AOI21_X1M_A9TR U1170 ( .A0(n173), .A1(n456), .B0(n455), .Y(n635) );
  INV_X0P5B_A9TR U1171 ( .A(n635), .Y(n457) );
  AOI22_X2M_A9TR U1172 ( .A0(n569), .A1(n462), .B0(n664), .B1(n503), .Y(n463)
         );
  INV_X11M_A9TR U1173 ( .A(n175), .Y(n753) );
  AND2_X1M_A9TR U1174 ( .A(n807), .B(n177), .Y(n468) );
  AND2_X1M_A9TR U1175 ( .A(n468), .B(n176), .Y(n902) );
  NAND2_X1P4B_A9TR U1176 ( .A(n579), .B(n630), .Y(n671) );
  AND2_X1M_A9TR U1177 ( .A(n809), .B(n177), .Y(n470) );
  NOR2B_X2M_A9TR U1178 ( .AN(n470), .B(n1236), .Y(n894) );
  INV_X0P5B_A9TR U1179 ( .A(acc_mant[8]), .Y(n622) );
  NAND2_X0P5A_A9TR U1180 ( .A(n482), .B(n622), .Y(n471) );
  OAI22_X1M_A9TR U1181 ( .A0(n639), .A1(n599), .B0(n641), .B1(n583), .Y(n472)
         );
  NOR2_X2M_A9TR U1182 ( .A(n531), .B(n1378), .Y(n524) );
  INV_X0P5B_A9TR U1183 ( .A(acc_mant[20]), .Y(n839) );
  AOI21_X1M_A9TR U1184 ( .A0(n482), .A1(n839), .B0(n473), .Y(n593) );
  AOI21_X1M_A9TR U1185 ( .A0(n173), .A1(n862), .B0(n474), .Y(n596) );
  NAND2_X1A_A9TR U1186 ( .A(n522), .B(acc_mant[23]), .Y(n501) );
  INV_X0P5B_A9TR U1187 ( .A(acc_mant[18]), .Y(n819) );
  AOI21_X1M_A9TR U1188 ( .A0(n482), .A1(n819), .B0(n476), .Y(n594) );
  INV_X0P5B_A9TR U1189 ( .A(acc_mant[12]), .Y(n478) );
  OAI21_X0P5M_A9TR U1190 ( .A0(n173), .A1(acc_mant[11]), .B0(n197), .Y(n477)
         );
  INV_X0P5B_A9TR U1191 ( .A(acc_mant[10]), .Y(n665) );
  OAI211_X0P7M_A9TR U1192 ( .A0(n173), .A1(acc_mant[9]), .B0(n197), .C0(n479), 
        .Y(n601) );
  NAND2_X1A_A9TR U1193 ( .A(n581), .B(n601), .Y(n486) );
  INV_X0P5B_A9TR U1194 ( .A(acc_mant[14]), .Y(n481) );
  OAI21_X0P5M_A9TR U1195 ( .A0(n173), .A1(acc_mant[13]), .B0(n197), .Y(n480)
         );
  AOI21_X0P7M_A9TR U1196 ( .A0(n173), .A1(n481), .B0(n480), .Y(n597) );
  INV_X0P5B_A9TR U1197 ( .A(n597), .Y(n484) );
  INV_X0P5B_A9TR U1198 ( .A(acc_mant[16]), .Y(n795) );
  OAI21_X0P5M_A9TR U1199 ( .A0(n482), .A1(acc_mant[15]), .B0(n197), .Y(n483)
         );
  AOI21_X1M_A9TR U1200 ( .A0(n173), .A1(n795), .B0(n483), .Y(n595) );
  OAI211_X2M_A9TR U1201 ( .A0(n582), .A1(n646), .B0(n486), .C0(n485), .Y(n676)
         );
  AOI21_X2M_A9TR U1202 ( .A0(acc_mant[1]), .A1(n534), .B0(n487), .Y(n488) );
  AND2_X1M_A9TR U1203 ( .A(n494), .B(n176), .Y(n913) );
  NOR2B_X2M_A9TR U1204 ( .AN(n500), .B(n1236), .Y(n915) );
  INV_X0P5B_A9TR U1205 ( .A(acc_mant[5]), .Y(n584) );
  OAI22BB_X1M_A9TR U1206 ( .A0(n644), .A1(acc_mant[3]), .B0N(n568), .B1N(n584), 
        .Y(n508) );
  INV_X1B_A9TR U1207 ( .A(n524), .Y(n507) );
  INV_X0P5B_A9TR U1208 ( .A(n511), .Y(n514) );
  INV_X0P5B_A9TR U1209 ( .A(n512), .Y(n513) );
  NAND2_X2B_A9TR U1210 ( .A(n632), .B(n630), .Y(n617) );
  AND2_X1M_A9TR U1211 ( .A(n798), .B(n177), .Y(n516) );
  NOR2B_X2M_A9TR U1212 ( .AN(n516), .B(n1236), .Y(n905) );
  OR2_X1M_A9TR U1213 ( .A(n905), .B(n909), .Y(n541) );
  XNOR2_X1M_A9TR U1214 ( .A(n909), .B(n905), .Y(n540) );
  AOI31_X1M_A9TR U1215 ( .A0(n568), .A1(n522), .A2(acc_mant[2]), .B0(n521), 
        .Y(n537) );
  AOI22_X1M_A9TR U1216 ( .A0(n524), .A1(acc_mant[3]), .B0(n523), .B1(
        acc_mant[1]), .Y(n536) );
  NAND2_X1A_A9TR U1217 ( .A(n525), .B(n634), .Y(n527) );
  AOI22_X1P4M_A9TR U1218 ( .A0(n581), .A1(n640), .B0(n568), .B1(n642), .Y(n526) );
  OAI211_X2M_A9TR U1219 ( .A0(n635), .A1(n639), .B0(n527), .C0(n526), .Y(n621)
         );
  OAI222_X2M_A9TR U1220 ( .A0(n600), .A1(n637), .B0(n531), .B1(n638), .C0(n695), .C1(n436), .Y(n794) );
  OAI22_X1M_A9TR U1221 ( .A0(n621), .A1(n694), .B0(n794), .B1(n532), .Y(n533)
         );
  INV_X1M_A9TR U1222 ( .A(n906), .Y(n539) );
  AND2_X1M_A9TR U1223 ( .A(n559), .B(n176), .Y(n967) );
  NOR2XB_X2M_A9TR U1224 ( .BN(n753), .A(n765), .Y(n563) );
  NOR2XB_X2M_A9TR U1225 ( .BN(n564), .A(n1236), .Y(n969) );
  OAI222_X1M_A9TR U1226 ( .A0(n565), .A1(n639), .B0(n600), .B1(n635), .C0(n646), .C1(n637), .Y(n763) );
  OAI22_X1M_A9TR U1227 ( .A0(n639), .A1(n634), .B0(n641), .B1(n642), .Y(n573)
         );
  INV_X0P5B_A9TR U1228 ( .A(n640), .Y(n567) );
  INV_X0P5B_A9TR U1229 ( .A(n645), .Y(n566) );
  INV_X0P5B_A9TR U1230 ( .A(acc_mant[6]), .Y(n570) );
  NAND2_X2B_A9TR U1231 ( .A(n569), .B(n436), .Y(n647) );
  OAI22_X1M_A9TR U1232 ( .A0(n570), .A1(n1381), .B0(n647), .B1(n861), .Y(n571)
         );
  OAI31_X4M_A9TR U1233 ( .A0(n762), .A1(n694), .A2(n763), .B0(n574), .Y(n970)
         );
  INV_X1P7B_A9TR U1234 ( .A(n970), .Y(n611) );
  NOR2_X2A_A9TR U1235 ( .A(n745), .B(n753), .Y(n850) );
  AND2_X1M_A9TR U1236 ( .A(n577), .B(n176), .Y(n956) );
  NOR2_X2M_A9TR U1237 ( .A(n752), .B(n753), .Y(n852) );
  NOR2B_X2M_A9TR U1238 ( .AN(n580), .B(n1236), .Y(n958) );
  NOR2_X1B_A9TR U1239 ( .A(n639), .B(n593), .Y(n750) );
  INV_X0P5B_A9TR U1240 ( .A(n582), .Y(n598) );
  OAI22_X1M_A9TR U1241 ( .A0(n584), .A1(n1381), .B0(n647), .B1(n848), .Y(n585)
         );
  INV_X1P7M_A9TR U1242 ( .A(n959), .Y(n654) );
  OAI222_X1M_A9TR U1243 ( .A0(n639), .A1(n596), .B0(n600), .B1(n595), .C0(n646), .C1(n594), .Y(n781) );
  OAI22BB_X2M_A9TR U1244 ( .A0(n641), .A1(n598), .B0N(n504), .B1N(n597), .Y(
        n605) );
  OAI22_X1M_A9TR U1245 ( .A0(n646), .A1(n601), .B0(n600), .B1(n599), .Y(n604)
         );
  INV_X0P5B_A9TR U1246 ( .A(acc_mant[7]), .Y(n602) );
  INV_X1M_A9TR U1247 ( .A(n777), .Y(n875) );
  OAI22_X1M_A9TR U1248 ( .A0(n602), .A1(n1381), .B0(n647), .B1(n875), .Y(n603)
         );
  OA21A1OI2_X3M_A9TR U1249 ( .A0(n605), .A1(n604), .B0(n837), .C0(n603), .Y(
        n606) );
  INV_X1P7M_A9TR U1250 ( .A(n981), .Y(n623) );
  NOR2XB_X1M_A9TR U1251 ( .BN(n753), .A(n787), .Y(n609) );
  AND2_X2B_A9TR U1252 ( .A(n616), .B(n176), .Y(n998) );
  OAI222_X2M_A9TR U1253 ( .A0(n622), .A1(n1381), .B0(n621), .B1(n825), .C0(
        n794), .C1(n694), .Y(n1001) );
  ADDFH_X2M_A9TR U1254 ( .A(n978), .B(n623), .CI(n980), .CO(n717), .SUM(n713)
         );
  AND2_X1M_A9TR U1255 ( .A(n842), .B(n177), .Y(n633) );
  INV_X0P5B_A9TR U1256 ( .A(n634), .Y(n636) );
  OAI22_X1M_A9TR U1257 ( .A0(n646), .A1(n645), .B0(n644), .B1(n643), .Y(n650)
         );
  INV_X0P5B_A9TR U1258 ( .A(acc_mant[4]), .Y(n648) );
  OAI22_X1M_A9TR U1259 ( .A0(n648), .A1(n1381), .B0(n647), .B1(n838), .Y(n649)
         );
  NAND2_X1A_A9TR U1260 ( .A(n656), .B(n709), .Y(n657) );
  NOR2B_X0P7M_A9TR U1261 ( .AN(n659), .B(n177), .Y(n660) );
  AND2_X1P4M_A9TR U1262 ( .A(n660), .B(n176), .Y(n1021) );
  INV_X1P7B_A9TR U1263 ( .A(n664), .Y(n666) );
  AND2_X1P4M_A9TR U1264 ( .A(n670), .B(n176), .Y(n1010) );
  NOR2_X2M_A9TR U1265 ( .A(n672), .B(n753), .Y(n1235) );
  NOR2B_X2M_A9TR U1266 ( .AN(n674), .B(n1236), .Y(n1012) );
  AND2_X2B_A9TR U1267 ( .A(n682), .B(n176), .Y(n1032) );
  INV_X1P7B_A9TR U1268 ( .A(n686), .Y(n688) );
  NOR2XB_X1P4M_A9TR U1269 ( .BN(n753), .A(n690), .Y(n691) );
  AND2_X2B_A9TR U1270 ( .A(n692), .B(n176), .Y(n1043) );
  AOI22_X1M_A9TR U1271 ( .A0(n1399), .A1(acc_mant[12]), .B0(n778), .B1(n695), 
        .Y(n696) );
  INV_X1M_A9TR U1272 ( .A(n1046), .Y(n756) );
  AND2_X1M_A9TR U1273 ( .A(n707), .B(n706), .Y(n708) );
  NAND2_X1A_A9TR U1274 ( .A(n713), .B(n712), .Y(n714) );
  AND2_X1M_A9TR U1275 ( .A(n718), .B(n717), .Y(n719) );
  NAND2_X1A_A9TR U1276 ( .A(n728), .B(n727), .Y(n729) );
  NOR2XB_X1M_A9TR U1277 ( .BN(n753), .A(n745), .Y(n746) );
  NOR2B_X0P7M_A9TR U1278 ( .AN(n746), .B(n177), .Y(n747) );
  AND2_X1M_A9TR U1279 ( .A(n747), .B(n1383), .Y(n1054) );
  NOR2B_X0P7M_A9TR U1280 ( .AN(n753), .B(n757), .Y(n758) );
  NOR2B_X0P7M_A9TR U1281 ( .AN(n758), .B(n177), .Y(n759) );
  AND2_X1M_A9TR U1282 ( .A(n759), .B(n176), .Y(n1065) );
  INV_X1M_A9TR U1283 ( .A(n1069), .Y(n790) );
  NOR2B_X0P7M_A9TR U1284 ( .AN(n766), .B(n177), .Y(n767) );
  NOR2B_X2M_A9TR U1285 ( .AN(n767), .B(n1236), .Y(n1068) );
  NAND2_X1A_A9TR U1286 ( .A(n770), .B(n769), .Y(n774) );
  NAND2_X1A_A9TR U1287 ( .A(n772), .B(n771), .Y(n773) );
  OAI21_X1M_A9TR U1288 ( .A0(n775), .A1(n774), .B0(n773), .Y(n776) );
  OAI31_X1M_A9TR U1289 ( .A0(n781), .A1(n780), .A2(n825), .B0(n779), .Y(n1097)
         );
  NOR2B_X1M_A9TR U1290 ( .AN(n789), .B(n1236), .Y(n1096) );
  NAND2_X1A_A9TR U1291 ( .A(n792), .B(n791), .Y(n793) );
  OAI22_X1M_A9TR U1292 ( .A0(n1381), .A1(n795), .B0(n794), .B1(n825), .Y(n1110) );
  AND2_X1M_A9TR U1293 ( .A(n797), .B(n1383), .Y(n1107) );
  NOR2B_X1M_A9TR U1294 ( .AN(n799), .B(n1236), .Y(n1109) );
  ADDF_X1M_A9TR U1295 ( .A(n800), .B(n1094), .CI(n1096), .CO(n801), .S(n792)
         );
  OAI22_X1M_A9TR U1296 ( .A0(n1381), .A1(n806), .B0(n805), .B1(n825), .Y(n1124) );
  AND2_X1M_A9TR U1297 ( .A(n808), .B(n176), .Y(n1121) );
  ADDF_X1M_A9TR U1298 ( .A(n811), .B(n1107), .CI(n1109), .CO(n812), .S(n802)
         );
  AND2_X1M_A9TR U1299 ( .A(n817), .B(n176), .Y(n1134) );
  OAI22_X1M_A9TR U1300 ( .A0(n1381), .A1(n819), .B0(n818), .B1(n825), .Y(n1137) );
  NOR2B_X1M_A9TR U1301 ( .AN(n820), .B(n177), .Y(n821) );
  NOR2B_X1M_A9TR U1302 ( .AN(n821), .B(n1236), .Y(n1136) );
  ADDF_X1M_A9TR U1303 ( .A(n822), .B(n1121), .CI(n1123), .CO(n823), .S(n813)
         );
  OAI22_X1M_A9TR U1304 ( .A0(n1381), .A1(n827), .B0(n826), .B1(n825), .Y(n1151) );
  NOR2B_X1M_A9TR U1305 ( .AN(n828), .B(n177), .Y(n829) );
  AND2_X1M_A9TR U1306 ( .A(n829), .B(n1383), .Y(n1148) );
  NOR2B_X1M_A9TR U1307 ( .AN(n830), .B(n177), .Y(n831) );
  NOR2B_X1M_A9TR U1308 ( .AN(n831), .B(n1236), .Y(n1150) );
  ADDF_X1M_A9TR U1309 ( .A(n1134), .B(n832), .CI(n1136), .CO(n833), .S(n824)
         );
  OAI22_X1M_A9TR U1310 ( .A0(n1381), .A1(n839), .B0(n838), .B1(n876), .Y(n1164) );
  NOR2B_X1M_A9TR U1311 ( .AN(n840), .B(n177), .Y(n841) );
  NOR2B_X1M_A9TR U1312 ( .AN(n842), .B(n177), .Y(n843) );
  ADDF_X1M_A9TR U1313 ( .A(n844), .B(n1148), .CI(n1150), .CO(n845), .S(n834)
         );
  INV_X0P5B_A9TR U1314 ( .A(acc_mant[21]), .Y(n849) );
  NOR2B_X1M_A9TR U1315 ( .AN(n850), .B(n177), .Y(n851) );
  NOR2B_X1M_A9TR U1316 ( .AN(n852), .B(n177), .Y(n854) );
  ADDF_X1M_A9TR U1317 ( .A(n855), .B(n1161), .CI(n1163), .CO(n856), .S(n846)
         );
  NOR2_X1A_A9TR U1318 ( .A(n857), .B(n856), .Y(n859) );
  NOR2B_X1M_A9TR U1319 ( .AN(n863), .B(n177), .Y(n865) );
  NOR2B_X1M_A9TR U1320 ( .AN(n866), .B(n177), .Y(n868) );
  NOR2B_X1M_A9TR U1321 ( .AN(n878), .B(n177), .Y(n880) );
  NOR2B_X1M_A9TR U1322 ( .AN(n881), .B(n177), .Y(n883) );
  ADDF_X1M_A9TR U1323 ( .A(n889), .B(n1217), .CI(n1215), .CO(n890), .S(n886)
         );
  AND2_X1M_A9TR U1324 ( .A(n1172), .B(n897), .Y(n920) );
  XOR2_X0P7M_A9TR U1325 ( .A(n896), .B(n907), .Y(n924) );
  MXT2_X0P7M_A9TR U1326 ( .A(n899), .B(n900), .S0(n1195), .Y(n912) );
  AND2_X1M_A9TR U1327 ( .A(n1210), .B(n902), .Y(n923) );
  AND2_X3B_A9TR U1328 ( .A(n892), .B(n909), .Y(n904) );
  AND2_X1M_A9TR U1329 ( .A(n1172), .B(n913), .Y(n952) );
  MXT2_X0P7M_A9TR U1330 ( .A(n915), .B(n916), .S0(n1195), .Y(n944) );
  ADDFH_X2M_A9TR U1331 ( .A(n920), .B(n919), .CI(n918), .CO(n940), .SUM(n939)
         );
  AND2_X1M_A9TR U1332 ( .A(n1172), .B(n929), .Y(n933) );
  AND2_X1M_A9TR U1333 ( .A(n1210), .B(n945), .Y(n963) );
  MXT2_X0P7M_A9TR U1334 ( .A(n947), .B(n948), .S0(n1195), .Y(n955) );
  MXT2_X0P7M_A9TR U1335 ( .A(n958), .B(n959), .S0(n1195), .Y(n966) );
  MXIT2_X1M_A9TR U1336 ( .A(n959), .B(n958), .S0(n1214), .Y(n960) );
  ADDFH_X2M_A9TR U1337 ( .A(n963), .B(n962), .CI(n961), .CO(n988), .SUM(n987)
         );
  AND2_X1M_A9TR U1338 ( .A(n1172), .B(n967), .Y(n985) );
  MXT2_X0P7M_A9TR U1339 ( .A(n969), .B(n970), .S0(n1195), .Y(n977) );
  AND2_X1M_A9TR U1340 ( .A(n1172), .B(n978), .Y(n1005) );
  ADDF_X1M_A9TR U1341 ( .A(n977), .B(n976), .CI(n975), .CO(n1004), .S(n983) );
  MXT2_X0P7M_A9TR U1342 ( .A(n980), .B(n981), .S0(n1195), .Y(n997) );
  NAND2_X2B_A9TR U1343 ( .A(n991), .B(n990), .Y(n1334) );
  AND2_X1M_A9TR U1344 ( .A(n1172), .B(n998), .Y(n1016) );
  ADDF_X1M_A9TR U1345 ( .A(n997), .B(n996), .CI(n995), .CO(n1015), .S(n1003)
         );
  MXT2_X0P7M_A9TR U1346 ( .A(n1000), .B(n1001), .S0(n1195), .Y(n1008) );
  AND2_X1M_A9TR U1347 ( .A(n1172), .B(n1010), .Y(n1028) );
  MXT2_X0P7M_A9TR U1348 ( .A(n1012), .B(n1009), .S0(n1195), .Y(n1019) );
  AND2_X1M_A9TR U1349 ( .A(n1172), .B(n1021), .Y(n1039) );
  ADDF_X1M_A9TR U1350 ( .A(n1031), .B(n1030), .CI(n1029), .CO(n1049), .S(n1037) );
  AND2_X1M_A9TR U1351 ( .A(n1172), .B(n1043), .Y(n1061) );
  AND2_X1M_A9TR U1352 ( .A(n1172), .B(n1054), .Y(n1073) );
  AND2_X3B_A9TR U1353 ( .A(n1195), .B(n1054), .Y(n1055) );
  ADDFH_X2M_A9TR U1354 ( .A(n1061), .B(n1060), .CI(n1059), .CO(n1086), .SUM(
        n1085) );
  AND2_X1M_A9TR U1355 ( .A(n1172), .B(n1065), .Y(n1101) );
  NAND2_X2B_A9TR U1356 ( .A(n1079), .B(n1078), .Y(n1311) );
  OAI21_X3M_A9TR U1357 ( .A0(n1295), .A1(n1291), .B0(n1296), .Y(n1370) );
  NAND2_X1A_A9TR U1358 ( .A(n1089), .B(n1088), .Y(n1374) );
  INV_X1M_A9TR U1359 ( .A(n1374), .Y(n1090) );
  AND2_X1M_A9TR U1360 ( .A(n1172), .B(n1094), .Y(n1114) );
  MXT2_X0P7M_A9TR U1361 ( .A(n1096), .B(n1097), .S0(n1214), .Y(n1106) );
  AND2_X1M_A9TR U1362 ( .A(n892), .B(n1094), .Y(n1095) );
  MXT2_X0P7M_A9TR U1363 ( .A(n1097), .B(n1096), .S0(n892), .Y(n1098) );
  AND2_X1M_A9TR U1364 ( .A(n1210), .B(n1107), .Y(n1128) );
  MXT2_X0P7M_A9TR U1365 ( .A(n1110), .B(n1109), .S0(n892), .Y(n1111) );
  NAND2_X1A_A9TR U1366 ( .A(n1116), .B(n1115), .Y(n1270) );
  AND2_X1M_A9TR U1367 ( .A(n1172), .B(n1121), .Y(n1141) );
  MXT2_X0P7M_A9TR U1368 ( .A(n1123), .B(n1124), .S0(n1214), .Y(n1133) );
  AND2_X1M_A9TR U1369 ( .A(n892), .B(n1121), .Y(n1122) );
  MXT2_X0P7M_A9TR U1370 ( .A(n1124), .B(n1123), .S0(n892), .Y(n1125) );
  NAND2_X1A_A9TR U1371 ( .A(n1130), .B(n1129), .Y(n1266) );
  AND2_X1M_A9TR U1372 ( .A(n1172), .B(n1134), .Y(n1155) );
  ADDF_X1M_A9TR U1373 ( .A(n1133), .B(n1132), .CI(n1131), .CO(n1154), .S(n1139) );
  AND2_X1M_A9TR U1374 ( .A(n1195), .B(n1134), .Y(n1135) );
  MXT2_X0P7M_A9TR U1375 ( .A(n1137), .B(n1136), .S0(n1214), .Y(n1138) );
  ADDF_X1M_A9TR U1376 ( .A(n1141), .B(n1140), .CI(n1139), .CO(n1142), .S(n1130) );
  NAND2_X1A_A9TR U1377 ( .A(n1143), .B(n1142), .Y(n1279) );
  AND2_X1M_A9TR U1378 ( .A(n1210), .B(n1148), .Y(n1168) );
  ADDF_X1M_A9TR U1379 ( .A(n1147), .B(n1146), .CI(n1145), .CO(n1167), .S(n1153) );
  MXT2_X0P7M_A9TR U1380 ( .A(n1150), .B(n1151), .S0(n1214), .Y(n1160) );
  AND2_X1M_A9TR U1381 ( .A(n892), .B(n1148), .Y(n1149) );
  ADDF_X1M_A9TR U1382 ( .A(n1155), .B(n1154), .CI(n1153), .CO(n1156), .S(n1143) );
  NOR2_X1A_A9TR U1383 ( .A(n1157), .B(n1156), .Y(n1274) );
  NAND2_X1A_A9TR U1384 ( .A(n1157), .B(n1156), .Y(n1275) );
  AND2_X1M_A9TR U1385 ( .A(n1210), .B(n1161), .Y(n1183) );
  ADDF_X1M_A9TR U1386 ( .A(n1160), .B(n1159), .CI(n1158), .CO(n1182), .S(n1166) );
  MXT2_X0P7M_A9TR U1387 ( .A(n1163), .B(n1164), .S0(n1214), .Y(n1175) );
  AND2_X1M_A9TR U1388 ( .A(n1195), .B(n1161), .Y(n1162) );
  ADDF_X1M_A9TR U1389 ( .A(n1168), .B(n1167), .CI(n1166), .CO(n1169), .S(n1157) );
  NAND2_X1A_A9TR U1390 ( .A(n1170), .B(n1169), .Y(n1261) );
  AOI21_X8M_A9TR U1391 ( .A0(n1264), .A1(n1262), .B0(n1171), .Y(n1190) );
  AND2_X1M_A9TR U1392 ( .A(n1172), .B(n1176), .Y(n1202) );
  ADDF_X1M_A9TR U1393 ( .A(n1175), .B(n1174), .CI(n1173), .CO(n1201), .S(n1181) );
  MXT2_X0P7M_A9TR U1394 ( .A(n1178), .B(n1179), .S0(n1214), .Y(n1193) );
  AND2_X1M_A9TR U1395 ( .A(n892), .B(n1176), .Y(n1177) );
  ADDF_X1M_A9TR U1396 ( .A(n1183), .B(n1182), .CI(n1181), .CO(n1184), .S(n1170) );
  NOR2_X1A_A9TR U1397 ( .A(n1185), .B(n1184), .Y(n1189) );
  NAND2_X1A_A9TR U1398 ( .A(n1185), .B(n1184), .Y(n1188) );
  NAND2_X1A_A9TR U1399 ( .A(n1186), .B(n1188), .Y(n1187) );
  OAI21_X8M_A9TR U1400 ( .A0(n1190), .A1(n1189), .B0(n1188), .Y(n1209) );
  AND2_X1M_A9TR U1401 ( .A(n1210), .B(n1194), .Y(n1222) );
  ADDF_X1M_A9TR U1402 ( .A(n1193), .B(n1192), .CI(n1191), .CO(n1221), .S(n1200) );
  MXT2_X0P7M_A9TR U1403 ( .A(n1197), .B(n1198), .S0(n1214), .Y(n1213) );
  AND2_X1M_A9TR U1404 ( .A(n1195), .B(n1194), .Y(n1196) );
  ADDF_X1M_A9TR U1405 ( .A(n1202), .B(n1201), .CI(n1200), .CO(n1203), .S(n1185) );
  NAND2_X1A_A9TR U1406 ( .A(n1204), .B(n1203), .Y(n1206) );
  NAND2_X1A_A9TR U1407 ( .A(n1208), .B(n1206), .Y(n1205) );
  AOI21_X8M_A9TR U1408 ( .A0(n1209), .A1(n1208), .B0(n1207), .Y(n1251) );
  AND2_X1M_A9TR U1409 ( .A(n1210), .B(n1215), .Y(n1230) );
  ADDF_X1M_A9TR U1410 ( .A(n1213), .B(n1212), .CI(n1211), .CO(n1229), .S(n1220) );
  MXT2_X0P7M_A9TR U1411 ( .A(n1217), .B(n1218), .S0(n1214), .Y(n1227) );
  AND2_X1M_A9TR U1412 ( .A(n892), .B(n1215), .Y(n1216) );
  MXT2_X0P7M_A9TR U1413 ( .A(n1218), .B(n1217), .S0(n892), .Y(n1219) );
  ADDF_X1M_A9TR U1414 ( .A(n1222), .B(n1221), .CI(n1220), .CO(n1223), .S(n1204) );
  NOR2_X1A_A9TR U1415 ( .A(n1224), .B(n1223), .Y(n1247) );
  OAI21_X8M_A9TR U1416 ( .A0(n1251), .A1(n1247), .B0(n1248), .Y(n1255) );
  ADDF_X1M_A9TR U1417 ( .A(n1227), .B(n1226), .CI(n1225), .CO(n1239), .S(n1228) );
  ADDF_X1M_A9TR U1418 ( .A(n1230), .B(n1229), .CI(n1228), .CO(n1231), .S(n1224) );
  NAND2_X1A_A9TR U1419 ( .A(n1232), .B(n1231), .Y(n1252) );
  AOI21_X8M_A9TR U1420 ( .A0(n1255), .A1(n1253), .B0(n1233), .Y(n1260) );
  ADDF_X1M_A9TR U1421 ( .A(n1240), .B(n1239), .CI(n1234), .CO(n1241), .S(n1232) );
  NOR2_X1A_A9TR U1422 ( .A(n1242), .B(n1241), .Y(n1256) );
  NAND2_X1A_A9TR U1423 ( .A(n1242), .B(n1241), .Y(n1257) );
  ADDF_X1M_A9TR U1424 ( .A(n1243), .B(n178), .CI(n1244), .CO(n1245), .S(n1242)
         );
  NAND2_X1A_A9TR U1425 ( .A(n1249), .B(n1248), .Y(n1250) );
  NAND2_X1A_A9TR U1426 ( .A(n1253), .B(n1252), .Y(n1254) );
  NAND2_X1A_A9TR U1427 ( .A(n1258), .B(n1257), .Y(n1259) );
  NAND2_X1A_A9TR U1428 ( .A(n1262), .B(n1261), .Y(n1263) );
  NAND2_X1A_A9TR U1429 ( .A(n1267), .B(n1266), .Y(n1269) );
  NAND2_X1A_A9TR U1430 ( .A(n1271), .B(n1270), .Y(n1272) );
  NAND2_X1A_A9TR U1431 ( .A(n1276), .B(n1275), .Y(n1277) );
  NAND2_X1A_A9TR U1432 ( .A(n1280), .B(n1279), .Y(n1281) );
  OAI21_X1M_A9TR U1433 ( .A0(n1332), .A1(n1288), .B0(n1287), .Y(n1294) );
  NAND2_X1A_A9TR U1434 ( .A(n1293), .B(n1291), .Y(n1290) );
  NAND2_X1A_A9TR U1435 ( .A(n1297), .B(n1296), .Y(n1298) );
  NAND2_X1A_A9TR U1436 ( .A(n1308), .B(n1307), .Y(n1309) );
  NAND2_X1A_A9TR U1437 ( .A(n1312), .B(n1311), .Y(n1313) );
  NAND2_X1A_A9TR U1438 ( .A(n1317), .B(n1316), .Y(n1318) );
  NAND2_X1A_A9TR U1439 ( .A(n1325), .B(n1324), .Y(n1326) );
  NAND2_X1A_A9TR U1440 ( .A(n1330), .B(n1329), .Y(n1331) );
  NAND2_X1A_A9TR U1441 ( .A(n1335), .B(n1334), .Y(n1336) );
  NAND2_X1A_A9TR U1442 ( .A(n1342), .B(n1341), .Y(n1343) );
  NAND2_X1A_A9TR U1443 ( .A(n1346), .B(n1345), .Y(n1347) );
  OAI21_X1M_A9TR U1444 ( .A0(n1349), .A1(n1355), .B0(n1356), .Y(n1354) );
  NAND2_X1A_A9TR U1445 ( .A(n1352), .B(n1351), .Y(n1353) );
  NAND2_X1A_A9TR U1446 ( .A(n1357), .B(n1356), .Y(n1358) );
  NAND2_X1A_A9TR U1447 ( .A(n1361), .B(n1360), .Y(n1363) );
  NAND2_X1A_A9TR U1448 ( .A(n1366), .B(n1365), .Y(n1368) );
  OAI21_X1M_A9TR U1449 ( .A0(n1373), .A1(n1372), .B0(n1371), .Y(n1377) );
  NAND2_X1A_A9TR U1450 ( .A(n1375), .B(n1374), .Y(n1376) );
  NAND2_X0P5A_A9TR U1451 ( .A(n1387), .B(n1391), .Y(n1395) );
  AO21B_X1M_A9TR U1452 ( .A0(n1399), .A1(acc_exp[9]), .B0N(n1390), .Y(
        adder_exp[9]) );
  AO21B_X1M_A9TR U1453 ( .A0(n1399), .A1(acc_exp[8]), .B0N(n1390), .Y(
        adder_exp[8]) );
  AO21B_X1M_A9TR U1454 ( .A0(n1399), .A1(acc_exp[6]), .B0N(n1390), .Y(
        adder_exp[6]) );
  AO21B_X1M_A9TR U1455 ( .A0(n1399), .A1(acc_exp[7]), .B0N(n1390), .Y(
        adder_exp[7]) );
  XNOR2_X0P5M_A9TR U1456 ( .A(n1392), .B(n1391), .Y(n1393) );
  AO22_X1M_A9TR U1457 ( .A0(n1393), .A1(n1400), .B0(n1399), .B1(acc_exp[4]), 
        .Y(adder_exp[4]) );
  XOR2_X0P5M_A9TR U1458 ( .A(n1395), .B(n1394), .Y(n1396) );
  AO22_X1M_A9TR U1459 ( .A0(n1400), .A1(n1396), .B0(n1399), .B1(acc_exp[5]), 
        .Y(adder_exp[5]) );
  AO22_X1M_A9TR U1460 ( .A0(n1398), .A1(n1400), .B0(n1399), .B1(acc_exp[3]), 
        .Y(adder_exp[3]) );
  AO22_X1M_A9TR U1461 ( .A0(n1401), .A1(n1400), .B0(n1399), .B1(acc_exp[1]), 
        .Y(adder_exp[1]) );
  NOR2XB_X0P5M_A9TR U1462 ( .BN(norm_mant[3]), .A(n1402), .Y(n_2_net__3_) );
  NOR2XB_X0P5M_A9TR U1463 ( .BN(norm_exp[4]), .A(n1402), .Y(n_1_net__4_) );
  NOR2XB_X0P5M_A9TR U1464 ( .BN(norm_exp[5]), .A(n1402), .Y(n_1_net__5_) );
  NOR2XB_X0P5M_A9TR U1465 ( .BN(norm_exp[0]), .A(n1402), .Y(n_1_net__0_) );
  NOR2XB_X0P5M_A9TR U1466 ( .BN(norm_mant[22]), .A(n1402), .Y(n_2_net__22_) );
  NOR2XB_X0P5M_A9TR U1467 ( .BN(norm_exp[9]), .A(n1402), .Y(n_1_net__9_) );
  NOR2XB_X0P5M_A9TR U1468 ( .BN(norm_exp[6]), .A(n1402), .Y(n_1_net__6_) );
  NOR2XB_X0P5M_A9TR U1469 ( .BN(norm_mant[0]), .A(n1402), .Y(n_2_net__0_) );
  NOR2XB_X0P5M_A9TR U1470 ( .BN(norm_exp[2]), .A(n1402), .Y(n_1_net__2_) );
  NOR2XB_X0P5M_A9TR U1471 ( .BN(norm_mant[2]), .A(n1402), .Y(n_2_net__2_) );
  NOR2XB_X0P5M_A9TR U1472 ( .BN(norm_mant[4]), .A(n1402), .Y(n_2_net__4_) );
  NOR2XB_X0P5M_A9TR U1473 ( .BN(norm_mant[1]), .A(n1402), .Y(n_2_net__1_) );
  NOR2XB_X0P5M_A9TR U1474 ( .BN(norm_mant[5]), .A(n1402), .Y(n_2_net__5_) );
  NOR2XB_X0P5M_A9TR U1475 ( .BN(norm_exp[1]), .A(n1402), .Y(n_1_net__1_) );
  NOR2XB_X0P5M_A9TR U1476 ( .BN(norm_exp[7]), .A(n1402), .Y(n_1_net__7_) );
  NOR2XB_X0P5M_A9TR U1477 ( .BN(norm_mant[17]), .A(n1402), .Y(n_2_net__17_) );
  NOR2XB_X0P5M_A9TR U1478 ( .BN(norm_mant[19]), .A(n1402), .Y(n_2_net__19_) );
  NOR2XB_X0P5M_A9TR U1479 ( .BN(norm_mant[7]), .A(n1402), .Y(n_2_net__7_) );
  NOR2XB_X0P5M_A9TR U1480 ( .BN(norm_mant[12]), .A(n1402), .Y(n_2_net__12_) );
  NOR2XB_X0P5M_A9TR U1481 ( .BN(norm_mant[8]), .A(n1402), .Y(n_2_net__8_) );
  NOR2XB_X0P5M_A9TR U1482 ( .BN(norm_mant[20]), .A(n1402), .Y(n_2_net__20_) );
  NOR2XB_X0P5M_A9TR U1483 ( .BN(norm_mant[18]), .A(n1402), .Y(n_2_net__18_) );
  NOR2XB_X0P5M_A9TR U1484 ( .BN(norm_mant[13]), .A(n1402), .Y(n_2_net__13_) );
  NOR2XB_X0P5M_A9TR U1485 ( .BN(norm_mant[10]), .A(n1402), .Y(n_2_net__10_) );
  NOR2XB_X0P5M_A9TR U1486 ( .BN(norm_mant[15]), .A(n1402), .Y(n_2_net__15_) );
  NOR2XB_X0P5M_A9TR U1487 ( .BN(norm_mant[9]), .A(n1402), .Y(n_2_net__9_) );
  NOR2XB_X0P5M_A9TR U1488 ( .BN(norm_mant[11]), .A(n1402), .Y(n_2_net__11_) );
  NOR2XB_X0P5M_A9TR U1489 ( .BN(norm_mant[21]), .A(n1402), .Y(n_2_net__21_) );
  NOR2XB_X0P5M_A9TR U1490 ( .BN(norm_mant[16]), .A(n1402), .Y(n_2_net__16_) );
  NOR2XB_X0P5M_A9TR U1491 ( .BN(norm_mant[23]), .A(n1402), .Y(n_2_net__23_) );
  NOR2XB_X0P5M_A9TR U1492 ( .BN(norm_mant[14]), .A(n1402), .Y(n_2_net__14_) );
  NOR2XB_X0P5M_A9TR U1493 ( .BN(norm_mant[6]), .A(n1402), .Y(n_2_net__6_) );
  NOR2XB_X0P5M_A9TR U1494 ( .BN(norm_sign), .A(n1402), .Y(n_0_net__0_) );
endmodule

