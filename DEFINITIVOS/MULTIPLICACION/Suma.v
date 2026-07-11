module Suma #(parameter N = 8) (
    clk,
    add,
    rst,
    RegA_in,
    P
);

input clk;
input add;
input rst;
input  [2*N-1:0] RegA_in;
output [2*N-1:0] P;

reg [2*N-1:0] P_reg;
assign P = P_reg;

always @(posedge clk) begin
    if (rst)
        P_reg <= {2*N{1'b0}};
    else if (add)
        P_reg <= P_reg + RegA_in;
end

endmodule