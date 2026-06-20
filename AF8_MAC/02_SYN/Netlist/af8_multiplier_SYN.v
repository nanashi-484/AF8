/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09
// Date      : Sat May 23 16:18:13 2026
/////////////////////////////////////////////////////////////


module af8_multiplier ( sign_a, exp_a, man_a, sign_w, exp_w, man_w, sign_prod, 
        exp_prod_base4, man_prod );
  input [3:0] exp_a;
  input [2:0] man_a;
  input [3:0] exp_w;
  input [2:0] man_w;
  output [5:0] exp_prod_base4;
  output [5:0] man_prod;
  input sign_a, sign_w;
  output sign_prod;
  wire   n54, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53;

  XOR2_X3M_A9TR U17 ( .A(sign_w), .B(sign_a), .Y(sign_prod) );
  INV_X0P5B_A9TR U18 ( .A(exp_w[0]), .Y(n11) );
  INV_X0P5B_A9TR U19 ( .A(n11), .Y(n12) );
  INV_X0P5B_A9TR U20 ( .A(exp_a[0]), .Y(n13) );
  INV_X0P5B_A9TR U21 ( .A(n13), .Y(n14) );
  INV_X0P5B_A9TR U22 ( .A(man_w[0]), .Y(n15) );
  INV_X0P5B_A9TR U23 ( .A(n15), .Y(n16) );
  INV_X0P5B_A9TR U24 ( .A(man_w[2]), .Y(n17) );
  INV_X0P5B_A9TR U25 ( .A(n17), .Y(n18) );
  INV_X0P5B_A9TR U26 ( .A(man_a[2]), .Y(n19) );
  INV_X0P5B_A9TR U27 ( .A(n19), .Y(n20) );
  INV_X0P5B_A9TR U28 ( .A(man_a[0]), .Y(n21) );
  INV_X0P5B_A9TR U29 ( .A(n21), .Y(n22) );
  INV_X0P5B_A9TR U30 ( .A(man_a[1]), .Y(n23) );
  INV_X0P5B_A9TR U31 ( .A(n23), .Y(n24) );
  INV_X0P5B_A9TR U32 ( .A(man_w[1]), .Y(n25) );
  INV_X0P5B_A9TR U33 ( .A(n25), .Y(n26) );
  NOR2_X0P7M_A9TR U34 ( .A(n31), .B(n45), .Y(n43) );
  NAND2_X0P5A_A9TR U35 ( .A(n47), .B(n46), .Y(n45) );
  AO21A1AI2_X0P5M_A9TR U36 ( .A0(n26), .A1(n20), .B0(n34), .C0(n33), .Y(n50)
         );
  AND2_X0P5B_A9TR U37 ( .A(n14), .B(n12), .Y(n32) );
  AND4_X0P5M_A9TR U38 ( .A(n26), .B(n24), .C(n18), .D(n22), .Y(n49) );
  AND2_X0P5B_A9TR U39 ( .A(n20), .B(n16), .Y(n52) );
  AND4_X0P5M_A9TR U40 ( .A(n26), .B(n24), .C(n22), .D(n16), .Y(n51) );
  BUF_X1M_A9TR U41 ( .A(n54), .Y(exp_prod_base4[3]) );
  AOI21_X0P7M_A9TR U42 ( .A0(n36), .A1(n35), .B0(n49), .Y(n53) );
  NAND2_X0P7A_A9TR U43 ( .A(n18), .B(n22), .Y(n35) );
  OA1B2_X1P4M_A9TR U44 ( .B0(n40), .B1(n39), .A0N(n38), .Y(man_prod[5]) );
  OA1B2_X1P4M_A9TR U45 ( .B0(n14), .B1(n12), .A0N(n32), .Y(exp_prod_base4[0])
         );
  AOI21_X2M_A9TR U46 ( .A0(n42), .A1(n41), .B0(n51), .Y(man_prod[1]) );
  INV_X1B_A9TR U47 ( .A(n47), .Y(exp_prod_base4[1]) );
  OAI31_X3M_A9TR U48 ( .A0(n40), .A1(n39), .A2(n38), .B0(n37), .Y(man_prod[4])
         );
  NOR2_X2A_A9TR U49 ( .A(n43), .B(n44), .Y(exp_prod_base4[5]) );
  AND2_X1M_A9TR U50 ( .A(n22), .B(n16), .Y(man_prod[0]) );
  INV_X0P5B_A9TR U51 ( .A(n28), .Y(n31) );
  ADDF_X1M_A9TR U52 ( .A(exp_w[1]), .B(exp_a[1]), .CI(n32), .CO(n29), .S(n47)
         );
  ADDF_X1M_A9TR U53 ( .A(exp_w[2]), .B(exp_a[2]), .CI(n29), .CO(n30), .S(n46)
         );
  ADDF_X1M_A9TR U54 ( .A(exp_w[3]), .B(exp_a[3]), .CI(n30), .CO(n44), .S(n28)
         );
  AOI21_X0P5M_A9TR U55 ( .A0(n31), .A1(n45), .B0(n43), .Y(n54) );
  AND2_X0P5B_A9TR U56 ( .A(n24), .B(n26), .Y(n40) );
  NAND2_X1A_A9TR U57 ( .A(n24), .B(n18), .Y(n34) );
  NAND3_X0P5M_A9TR U58 ( .A(n26), .B(n34), .C(n20), .Y(n33) );
  NAND2_X1A_A9TR U59 ( .A(n26), .B(n24), .Y(n36) );
  NAND2_X0P5A_A9TR U60 ( .A(n18), .B(n20), .Y(n38) );
  NAND2_X0P5A_A9TR U61 ( .A(n39), .B(n40), .Y(n37) );
  NAND2_X0P5A_A9TR U62 ( .A(n26), .B(n22), .Y(n42) );
  NAND2_X0P5A_A9TR U63 ( .A(n24), .B(n16), .Y(n41) );
  AO21_X1M_A9TR U64 ( .A0(n44), .A1(n43), .B0(exp_prod_base4[5]), .Y(
        exp_prod_base4[4]) );
  OA21_X1M_A9TR U65 ( .A0(n47), .A1(n46), .B0(n45), .Y(exp_prod_base4[2]) );
  ADDF_X1M_A9TR U66 ( .A(n50), .B(n49), .CI(n48), .CO(n39), .S(man_prod[3]) );
  ADDF_X1M_A9TR U67 ( .A(n53), .B(n52), .CI(n51), .CO(n48), .S(man_prod[2]) );
endmodule

