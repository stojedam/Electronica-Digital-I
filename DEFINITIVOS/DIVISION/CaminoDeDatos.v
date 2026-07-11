module CaminoDeDatos #(parameter N = 8, parameter CW = 4) (
    clk,
    Divisor,
    Dividendo,
    LD,
    SETCOCIENTE,
    SETRESIDUO,
    SHIFT,
    DEC,
    RESIDUOCOMP,
    ZERO,
    Residuo,
    Cociente
);

input clk;
input [N-1:0] Divisor;
input [N-1:0] Dividendo;
input LD;
input SETCOCIENTE;
input SETRESIDUO;
input SHIFT;
input DEC;
output RESIDUOCOMP;
output ZERO;
output [N:0]   Residuo;
output [N-1:0] Cociente;

wire         cociente_msb;
wire [N:0]   divisorComp;
wire [CW-1:0] count;

RegCociente #(.N(N)) regCociente0 (
    .clk(clk),
    .LD(LD),
    .SETCOCIENTE(SETCOCIENTE),
    .SHIFT(SHIFT),
    .Dividendo(Dividendo),
    .Cociente(Cociente),
    .MSB(cociente_msb)
);

Complement #(.N(N)) complement0 (
    .Divisor(Divisor),
    .DivisorComp(divisorComp)
);

RegResiduo #(.N(N)) regResiduo0 (
    .clk(clk),
    .LD(LD),
    .SETRESIDUO(SETRESIDUO),
    .SHIFT(SHIFT),
    .ShiftIn(cociente_msb), // corrimiento combinado (Residuo,Dividendo)<<1
    .DivisorComp(divisorComp),
    .Residuo(Residuo)
);

Comp1 #(.N(N)) comp1_0 (
    .Residuo(Residuo),
    .Divisor(Divisor),
    .RESIDUOCOMP(RESIDUOCOMP)
);

Counter #(.N(N), .CW(CW)) counter0 (
    .clk(clk),
    .ld(LD),
    .Dec(DEC),
    .count(count)
);

Comp2 #(.CW(CW)) comp2_0 (
    .count(count),
    .ZERO(ZERO)
);

endmodule