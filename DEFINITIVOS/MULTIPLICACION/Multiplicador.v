module Multiplicador #(parameter N = 8, parameter CW = 4) (
    clk,
    rst,
    INIT,
    A,
    B,
    P,
    DONE
);

input clk;
input rst;
input INIT;
input [N-1:0] A;
input [N-1:0] B;
output [2*N-1:0] P;
output DONE;

wire LD;
wire ADD;
wire SHIFT;
wire LSB;
wire ZERO;

CaminoDeDatos #(.N(N), .CW(CW)) caminoDeDatos0 (
    .clk(clk),
    .A(A),
    .B(B),
    .LD(LD),
    .ADD(ADD),
    .SHIFT(SHIFT),
    .LSB(LSB),
    .ZERO(ZERO),
    .P(P)
);

Control control0 (
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .ZERO(ZERO),
    .LSB(LSB),
    .LD(LD),
    .ADD(ADD),
    .SHIFT(SHIFT),
    .DONE(DONE)
);

endmodule