module RegA #(parameter N = 8) (
    clk,
    init_a,
    shift_l,
    A,
    RegA_out
);
input clk;
input init_a;
input shift_l;
input  [N-1:0]   A;
output [2*N-1:0] RegA_out;

reg [2*N-1:0] regA;
assign RegA_out = regA;

always @(posedge clk) begin
    if (init_a)
        regA <= {{N{1'b0}}, A};
    else if (shift_l)
        regA <= regA << 1;
end

endmodule
