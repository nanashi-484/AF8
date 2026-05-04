module af8_decoder (
    input  logic [7:0] in_data,
    
    output logic       sign,
    output logic [3:0] exp,
    output logic [2:0] man 
);

    logic [6:0] magnitude;

    always_comb begin
        sign = in_data[7];
        magnitude = sign ? ~in_data[6:0] : in_data[6:0];
        exp = magnitude[6:3];
        man = magnitude[2:0];
    end
endmodule

module af8_multiplier (
    input  logic       sign_a,
    input  logic [3:0] exp_a,
    input  logic [2:0] man_a,
    
    input  logic       sign_w,
    input  logic [3:0] exp_w,
    input  logic [2:0] man_w,
    
    output logic               sign_prod,
    output logic signed  [5:0] exp_prod_base4,
    output logic         [5:0] man_prod 
);
    
    always_comb begin
        sign_prod = sign_a ^ sign_w;
        man_prod = man_a * man_w;
        exp_prod_base4 = signed'({2'b00, exp_a}) + signed'({2'b00, exp_w}) - 6'sd14;
    end

endmodule

module af8_to_fp32_aligner (
    input  logic signed [5:0]  exp_prod_base4,
    input  logic        [5:0]  man_prod,
    
    input  logic signed [9:0]  exp_acc,
    input  logic        [23:0] man_acc,
    
    output logic signed [9:0]  exp_common,
    output logic        [26:0] aligned_man_prod,
    output logic        [26:0] aligned_man_acc
);

    logic signed [9:0] exp_prod_base2;
    logic signed [9:0] exp_diff;
    logic        [4:0] shift_amount; 
    logic              prod_is_smaller;
    
    logic        [26:0] padded_man_prod;
    logic        [26:0] padded_man_acc;

    always_comb begin
        //(Base-4 to Base-2)
        exp_prod_base2 = 10'(exp_prod_base4) <<< 1;

        exp_diff = exp_acc - exp_prod_base2;
        prod_is_smaller = (exp_diff > 0);
        exp_common = prod_is_smaller ? exp_acc : exp_prod_base2;
        shift_amount = prod_is_smaller ? exp_diff[4:0] : (-exp_diff)[4:0];

        padded_man_prod = {man_prod, 21'b0};
        padded_man_acc  = {3'b0, man_acc};

        //Barrel Shifter
        if (prod_is_smaller) begin
            aligned_man_prod = padded_man_prod >> shift_amount;
            aligned_man_acc  = padded_man_acc;
        end else begin
            aligned_man_prod = padded_man_prod;
            aligned_man_acc  = padded_man_acc >> shift_amount;
        end
    end
endmodule