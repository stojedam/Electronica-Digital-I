
module CaminoDeDatos #(parameter N = 8, parameter CW = 4) (
    clk,
    A,
    B,
    LD,
    ADD,
    SHIFT,
    LSB,
    ZERO,
    P
);

input clk;
input [N-1:0] A;
input [N-1:0] B;
input LD;
input ADD;
input SHIFT;
output LSB;
output ZERO;
output [2*N-1:0] P;
 
wire [2*N-1:0] RegA_out;
wire [CW-1:0]  count;

RegA #(.N(N)) regA0 (
    .clk(clk),
    .init_a(LD),
    .shift_l(SHIFT),
    .A(A),
    .RegA_out(RegA_out)
);
 
RegB #(.N(N)) regB0 (
    .clk(clk),
    .init_b(LD),
    .shift_r(SHIFT),
    .B(B),
    .LSB(LSB)
);
 
Suma #(.N(N)) suma0 (
    .clk(clk),
    .add(ADD),
    .rst(LD),
    .RegA_in(RegA_out),
    .P(P)
);
 
Counter #(.N(N), .CW(CW)) counter0 (
    .clk(clk),
    .Id(LD),
    .Dec(SHIFT),
    .count(count)
);
 
Comp #(.CW(CW)) comp0 (
    .count(count),
    .ZERO(ZERO)
);
 
endmodule
