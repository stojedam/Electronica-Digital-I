module RaizCuadrada (
    clk,
    rst,
    INIT,
    Radicando,
    Raiz,
    DONE
);
input clk;
input rst;
input INIT;
input  [15:0] Radicando;
output [7:0]  Raiz;
output DONE;

wire LD, SHIFT, SUBTRACT, SETRAIZ, DEC, ZERO, MAYORIGUAL;

CaminoDeDatos caminoDeDatos0 (
    .clk(clk),
    .Radicando(Radicando),
    .LD(LD),
    .SHIFT(SHIFT),
    .SUBTRACT(SUBTRACT),
    .SETRAIZ(SETRAIZ),
    .DEC(DEC),
    .ZERO(ZERO),
    .MAYORIGUAL(MAYORIGUAL),
    .Raiz(Raiz)
);

Control control0 (
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .ZERO(ZERO),
    .MAYORIGUAL(MAYORIGUAL),
    .LD(LD),
    .SHIFT(SHIFT),
    .SUBTRACT(SUBTRACT),
    .SETRAIZ(SETRAIZ),
    .DEC(DEC),
    .DONE(DONE)
);

endmodule