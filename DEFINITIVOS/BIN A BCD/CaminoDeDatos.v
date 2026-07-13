module CaminoDeDatos(
    input clk,
    input rst,
    input ADD,
    input LD,
    input SHIFT,
    input DEC,
    input [15:0] Binario,

    output [19:0] BCD,
    output ZERO
);

wire [35:0] Bin;
wire [19:0] BCDCorregido;
wire [4:0] C;

RegBin REGBIN(
    .clk(clk),
    .rst(rst),
    .ADD(ADD),
    .SHIFT(SHIFT),
    .LD(LD),
    .Binario(Binario),
    .BCDCorregido(BCDCorregido),
    .Bin(Bin)
);

CorreccionBCD CORRECCION(
    .Bin(Bin),
    .BCDCorregido(BCDCorregido)
);

RegC REGC(
    .clk(clk),
    .rst(rst),
    .LD(LD),
    .DEC(DEC),
    .C(C)
);

Comp COMPARADOR(
    .C(C),
    .ZERO(ZERO)
);

assign BCD = Bin[35:16];

endmodule