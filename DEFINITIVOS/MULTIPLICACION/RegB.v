module RegB #(parameter N = 8) (
    clk,
    init_b,
    shift_r,
    B,
    LSB
);
input clk;
input init_b;
input shift_r;
input [N-1:0] B;
output LSB;

reg [N-1:0] regB;
assign LSB = regB[0];

always @(posedge clk) begin
    if (init_b)
        regB <= B;
    else if (shift_r)
        regB <= regB >> 1;
end

endmodule