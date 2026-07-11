module CaminoDeDatos (
    clk,
    EntradaBits,
    Cargar,
    Corrimiento,
    Incremento,
    Decremento,
    LBS,
    Cero,
    Cantidad,
    Paridad
);
input clk;
input [8:0] EntradaBits;
input Cargar;
input Corrimiento;
input Incremento;
input Decremento;
output LBS;
output Cero;
output [3:0] Cantidad;
output Paridad;
 
RegistroA regA0 (
    .clk(clk),
    .Cargar(Cargar),
    .Corrimiento(Corrimiento),
    .EntradaBits(EntradaBits),
    .LBS(LBS)
);
 
ContadorUno contadorUno0 (
    .clk(clk),
    .Cargar(Cargar),
    .Incremento(Incremento),
    .Cantidad(Cantidad),
    .Paridad(Paridad)
);
 
ContadorPosicion contadorPosicion0 (
    .clk(clk),
    .Cargar(Cargar),
    .Decremento(Decremento),
    .Cero(Cero)
);
 
endmodule
