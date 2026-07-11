module Paridad (
    clk,
    rst,
    INIT,
    EntradaBits,
    Cantidad,
    Paridad,
    DONE
);

input clk;
input rst;
input INIT;
input [8:0] EntradaBits;
output [3:0] Cantidad;
output Paridad;
output DONE;

wire Cargar;
wire Corrimiento;
wire Decremento;
wire Incremento;
wire Cero;
wire LBS;

CaminoDeDatos caminoDeDatos0 (
    .clk(clk),
    .EntradaBits(EntradaBits),
    .Cargar(Cargar),
    .Corrimiento(Corrimiento),
    .Incremento(Incremento),
    .Decremento(Decremento),
    .LBS(LBS),
    .Cero(Cero),
    .Cantidad(Cantidad),
    .Paridad(Paridad)
);

Control control0 (
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .Cero(Cero),
    .LBS(LBS),
    .Cargar(Cargar),
    .Corrimiento(Corrimiento),
    .Decremento(Decremento),
    .Incremento(Incremento),
    .DONE(DONE)
);

endmodule