module CaminoDeDatos (
    clk,
    Radicando,
    LD,
    SHIFT,
    SUBTRACT,
    SETRAIZ,
    DEC,
    ZERO,
    MAYORIGUAL,
    Raiz
);
input clk;
input  [15:0] Radicando;
input LD;
input SHIFT;
input SUBTRACT;
input SETRAIZ;
input DEC;
output ZERO;
output MAYORIGUAL;
output [7:0] Raiz;

wire [15:0] Rad;
wire [1:0]  RadTop;   // Rad[15:14] antes del corrimiento, entra a Residuo
wire [15:0] Residuo;
wire [15:0] T;
wire [3:0] count;

assign RadTop = Rad[15:14];

RegRad regRad0 (
    .clk(clk),
    .ld(LD),
    .shift(SHIFT),
    .Radicando(Radicando),
    .Rad(Rad)
);

RegResiduo regResiduo0 (
    .clk(clk),
    .ld(LD),
    .subtract(SUBTRACT),
    .shift(SHIFT),
    .ShiftIn(RadTop),
    .T(T),
    .Residuo(Residuo)
);

GeneradorT generadorT0 (
    .Raiz(Raiz),
    .T(T)
);

Comp1 comp1_0 (
    .Residuo(Residuo),
    .T(T),
    .MAYORIGUAL(MAYORIGUAL)
);

RegRaiz regRaiz0 (
    .clk(clk),
    .ld(LD),
    .setraiz(SETRAIZ),
    .MAYORIGUAL(MAYORIGUAL),
    .Raiz(Raiz)
);

RegC regC0 (
    .clk(clk),
    .ld(LD),
    .dec(DEC),
    .count(count)
);

Comp2 comp2_0 (
    .count(count),
    .ZERO(ZERO)
);

endmodule