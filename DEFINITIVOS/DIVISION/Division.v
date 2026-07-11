module Division #(parameter N = 8, parameter CW = 4) (
    clk,
    rst,
    INIT,
    Divisor,
    Dividendo,
    Residuo,
    Cociente,
    DONE
);
input clk;
input rst;
input INIT;
input  [N-1:0] Divisor;
input  [N-1:0] Dividendo;
output [N:0]   Residuo;
output [N-1:0] Cociente;
output DONE;

wire SETCOCIENTE;
wire SETRESIDUO;
wire LD;
wire SHIFT;
wire DEC;
wire RESIDUOCOMP;
wire ZERO;

CaminoDeDatos #(.N(N), .CW(CW)) caminoDeDatos0 (
    .clk(clk),
    .Divisor(Divisor),
    .Dividendo(Dividendo),
    .LD(LD),
    .SETCOCIENTE(SETCOCIENTE),
    .SETRESIDUO(SETRESIDUO),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .RESIDUOCOMP(RESIDUOCOMP),
    .ZERO(ZERO),
    .Residuo(Residuo),
    .Cociente(Cociente)
);

Control control0 (
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .ZERO(ZERO),
    .RESIDUOCOMP(RESIDUOCOMP),
    .SETCOCIENTE(SETCOCIENTE),
    .SETRESIDUO(SETRESIDUO),
    .LD(LD),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .DONE(DONE)
);

endmodule