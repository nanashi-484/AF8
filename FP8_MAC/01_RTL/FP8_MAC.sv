
module fp8_decoder(
    input logic [7:0] in_data,

    output logic       sign,
    output logic [3:0] exp,
    output logic [3:0] man_with_hidden, 
    
    output logic       is_zero,
    output logic       is_nan_inf
);

    logic [2:0] man_without_hidden;

    always_comb begin
        sign = in_data[7];
        exp = in_data[6:3];
        man_without_hidden = in_data[2:0];

        is_zero = (exp == 4'b0000) && (man_without_hidden == 3'b000);
        is_nan_inf = (exp == 4'b1111);

        man_with_hidden = (exp == 4'b0000)? {1'b0 , man_without_hidden} : {1'b1 , man_without_hidden};

    end

endmodule

module fp8_multiplier(
    input  logic       sign_a,
    input  logic [3:0] exp_a,
    input  logic [3:0] man_a, 
    
    input  logic       sign_w,
    input  logic [3:0] exp_w,
    input  logic [3:0] man_w,
    
    output logic               sign_prod,
    output logic signed  [5:0] exp_prod, 
    output logic         [7:0] man_prod
);
    
    always_comb begin
        sign_prod = sign_a ^ sign_w;
        man_prod = man_a * man_w;
        exp_prod = signed'({2'b00, exp_a}) + signed'({2'b00, exp_w}) - 6'sd7;
    end

endmodule

module fp8_to_fp32_aligner (
    //FP8 prod
    input  logic signed [5:0]  exp_prod,
    input  logic        [7:0]  man_prod,

    //acc prod
    input  logic signed [9:0]  exp_acc,
    input  logic        [23:0] man_acc,


    output logic signed [9:0]  exp_common,
    output logic        [24:0] aligned_man_prod,
    output logic        [24:0] aligned_man_acc
);
    logic signed [9:0] exp_prod_ext;
    logic signed [9:0] exp_diff;
    logic        [4:0] shift_amount;
    logic              prod_is_smaller;

    logic        [24:0] padded_man_prod;
    logic        [24:0] padded_man_acc;

    always_comb begin
        exp_prod_ext = 10'(exp_prod);
        exp_diff = exp_acc - exp_prod_ext;
        prod_is_smaller = (exp_diff > 0);

        exp_common = prod_is_smaller ? exp_acc : exp_prod_ext;

        shift_amount = prod_is_smaller ? exp_diff[4:0] : (-exp_diff)[4:0];

        //aligner
        padded_man_prod = {man_prod, 17'b0};
        padded_man_acc  = {1'b0, man_acc};

        //Shifter
        if (prod_is_smaller) begin
            aligned_man_prod = padded_man_prod >> shift_amount;
            aligned_man_acc  = padded_man_acc;
        end else begin
            aligned_man_prod = padded_man_prod;
            aligned_man_acc  = padded_man_acc >> shift_amount;
        end
    end

endmodule