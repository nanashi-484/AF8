/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09
// Date      : Sat May 23 16:19:17 2026
/////////////////////////////////////////////////////////////


module fp8_multiplier ( sign_a, exp_a, man_a, sign_w, exp_w, man_w, sign_prod, 
        exp_prod, man_prod );
  input [3:0] exp_a;
  input [3:0] man_a;
  input [3:0] exp_w;
  input [3:0] man_w;
  output [5:0] exp_prod;
  output [7:0] man_prod;
  input sign_a, sign_w;
  output sign_prod;
  wire   n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74;

  XOR2_X3M_A9TR U17 ( .A(sign_w), .B(sign_a), .Y(sign_prod) );
  INV_X0P5B_A9TR U18 ( .A(exp_w[0]), .Y(n11) );
  INV_X0P5B_A9TR U19 ( .A(n11), .Y(n12) );
  INV_X0P5B_A9TR U20 ( .A(exp_a[0]), .Y(n13) );
  INV_X0P5B_A9TR U21 ( .A(n13), .Y(n14) );
  INV_X0P5B_A9TR U22 ( .A(man_a[2]), .Y(n15) );
  INV_X0P5B_A9TR U23 ( .A(n15), .Y(n16) );
  INV_X0P5B_A9TR U24 ( .A(man_w[0]), .Y(n17) );
  INV_X0P5B_A9TR U25 ( .A(n17), .Y(n18) );
  INV_X0P5B_A9TR U26 ( .A(man_w[2]), .Y(n19) );
  INV_X0P5B_A9TR U27 ( .A(n19), .Y(n20) );
  INV_X0P5B_A9TR U28 ( .A(man_w[3]), .Y(n21) );
  INV_X0P5B_A9TR U29 ( .A(n21), .Y(n22) );
  INV_X0P5B_A9TR U30 ( .A(man_a[3]), .Y(n23) );
  INV_X0P5B_A9TR U31 ( .A(n23), .Y(n24) );
  INV_X0P5B_A9TR U32 ( .A(man_a[0]), .Y(n25) );
  INV_X0P5B_A9TR U33 ( .A(n25), .Y(n26) );
  INV_X0P5B_A9TR U34 ( .A(man_w[1]), .Y(n27) );
  INV_X0P5B_A9TR U35 ( .A(n27), .Y(n28) );
  INV_X0P5B_A9TR U36 ( .A(man_a[1]), .Y(n29) );
  INV_X0P5B_A9TR U37 ( .A(n29), .Y(n30) );
  NAND2_X0P5A_A9TR U38 ( .A(n34), .B(n60), .Y(n58) );
  NAND2_X0P5A_A9TR U39 ( .A(n62), .B(n61), .Y(n60) );
  NAND2_X0P5A_A9TR U40 ( .A(n46), .B(n43), .Y(n67) );
  AOI21B_X0P5M_A9TR U41 ( .A0(n48), .A1(n47), .B0N(n46), .Y(n74) );
  AOI21_X0P5M_A9TR U42 ( .A0(n51), .A1(n50), .B0(n49), .Y(n69) );
  AOI21_X0P5M_A9TR U43 ( .A0(n40), .A1(n39), .B0(n38), .Y(n42) );
  AND4_X0P5M_A9TR U44 ( .A(n28), .B(n30), .C(n26), .D(n18), .Y(n72) );
  AND4_X0P5M_A9TR U45 ( .A(n28), .B(n30), .C(n22), .D(n24), .Y(n38) );
  AND2_X0P5B_A9TR U46 ( .A(n20), .B(n24), .Y(n36) );
  AND2_X0P5B_A9TR U47 ( .A(n22), .B(n16), .Y(n37) );
  AND2_X0P5B_A9TR U48 ( .A(n14), .B(n12), .Y(n35) );
  AND2_X0P5B_A9TR U49 ( .A(n20), .B(n16), .Y(n41) );
  AND2_X0P5B_A9TR U50 ( .A(n18), .B(n16), .Y(n73) );
  NAND2_X0P7A_A9TR U51 ( .A(n28), .B(n16), .Y(n50) );
  NAND2_X0P7A_A9TR U52 ( .A(n28), .B(n30), .Y(n48) );
  AND4_X0P5M_A9TR U53 ( .A(n28), .B(n24), .C(n18), .D(n16), .Y(n49) );
  NAND2_X0P7A_A9TR U54 ( .A(n28), .B(n24), .Y(n40) );
  AO21A1AI2_X0P5M_A9TR U55 ( .A0(n20), .A1(n30), .B0(n44), .C0(n43), .Y(n45)
         );
  AND2_X0P5B_A9TR U56 ( .A(n26), .B(n22), .Y(n44) );
  NAND2_X0P7A_A9TR U57 ( .A(n30), .B(n22), .Y(n39) );
  XOR2_X0P5M_A9TR U58 ( .A(n46), .B(n45), .Y(n71) );
  OA1B2_X1P4M_A9TR U59 ( .B0(n55), .B1(n54), .A0N(n53), .Y(man_prod[7]) );
  OAI21_X2M_A9TR U60 ( .A0(n34), .A1(n60), .B0(n58), .Y(exp_prod[3]) );
  OA1B2_X1P4M_A9TR U61 ( .B0(n14), .B1(n12), .A0N(n35), .Y(exp_prod[0]) );
  AOI21_X2M_A9TR U62 ( .A0(n57), .A1(n56), .B0(n72), .Y(man_prod[1]) );
  INV_X1B_A9TR U63 ( .A(n62), .Y(exp_prod[1]) );
  OAI31_X3M_A9TR U64 ( .A0(n55), .A1(n54), .A2(n53), .B0(n52), .Y(man_prod[6])
         );
  NOR2_X2A_A9TR U65 ( .A(n59), .B(n58), .Y(exp_prod[5]) );
  AND2_X1M_A9TR U66 ( .A(n26), .B(n18), .Y(man_prod[0]) );
  ADDF_X1M_A9TR U67 ( .A(exp_w[3]), .B(exp_a[3]), .CI(n31), .CO(n59), .S(n32)
         );
  INV_X0P5B_A9TR U68 ( .A(n32), .Y(n34) );
  ADDF_X1M_A9TR U69 ( .A(exp_w[1]), .B(exp_a[1]), .CI(n35), .CO(n33), .S(n62)
         );
  ADDF_X1M_A9TR U70 ( .A(exp_w[2]), .B(exp_a[2]), .CI(n33), .CO(n31), .S(n61)
         );
  ADDF_X1M_A9TR U71 ( .A(n38), .B(n37), .CI(n36), .CO(n55), .S(n65) );
  ADDF_X1M_A9TR U72 ( .A(n42), .B(n41), .CI(n49), .CO(n64), .S(n68) );
  NAND4_X0P5M_A9TR U73 ( .A(n28), .B(n30), .C(n26), .D(n20), .Y(n46) );
  NAND4_X0P5M_A9TR U74 ( .A(n30), .B(n26), .C(n20), .D(n22), .Y(n43) );
  NAND2_X1A_A9TR U75 ( .A(n26), .B(n20), .Y(n47) );
  NAND2_X1A_A9TR U76 ( .A(n24), .B(n18), .Y(n51) );
  NAND2_X0P5A_A9TR U77 ( .A(n22), .B(n24), .Y(n53) );
  OAI21_X0P5M_A9TR U78 ( .A0(n55), .A1(n53), .B0(n54), .Y(n52) );
  NAND2_X0P5A_A9TR U79 ( .A(n28), .B(n26), .Y(n57) );
  NAND2_X0P5A_A9TR U80 ( .A(n30), .B(n18), .Y(n56) );
  AO21_X1M_A9TR U81 ( .A0(n59), .A1(n58), .B0(exp_prod[5]), .Y(exp_prod[4]) );
  OA21_X1M_A9TR U82 ( .A0(n62), .A1(n61), .B0(n60), .Y(exp_prod[2]) );
  ADDF_X1M_A9TR U83 ( .A(n65), .B(n64), .CI(n63), .CO(n54), .S(man_prod[5]) );
  ADDF_X1M_A9TR U84 ( .A(n68), .B(n67), .CI(n66), .CO(n63), .S(man_prod[4]) );
  ADDF_X1M_A9TR U85 ( .A(n71), .B(n70), .CI(n69), .CO(n66), .S(man_prod[3]) );
  ADDF_X1M_A9TR U86 ( .A(n74), .B(n73), .CI(n72), .CO(n70), .S(man_prod[2]) );
endmodule

