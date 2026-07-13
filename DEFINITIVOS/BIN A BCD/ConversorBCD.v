module ConversorBCD(
    input clk,
    input rst,
    input INIT,
    input [15:0] Binario,

    output [19:0] BCD,
    output DONE
);

wire ADD;
wire LD;
wire SHIFT;
wire DEC;
wire ZERO;

Control CONTROL(
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .ZERO(ZERO),
    .ADD(ADD),
    .LD(LD),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .DONE(DONE)
);

CaminoDeDatos DATOS(
    .clk(clk),
    .rst(rst),
    .ADD(ADD),
    .LD(LD),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .Binario(Binario),
    .BCD(BCD),
    .ZERO(ZERO)
);

endmodule