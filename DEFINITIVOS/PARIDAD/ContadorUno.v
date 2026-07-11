module ContadorUno (clk, Cargar, Incremento, Cantidad, Paridad);
input clk;
input Cargar;
input Incremento;
output [3:0] Cantidad;
output Paridad;
 
reg [3:0] ContadorUno;
assign Cantidad = ContadorUno;
assign Paridad  = ContadorUno[0];
 
always @(posedge clk) begin
    if (Cargar)
        ContadorUno <= 4'b0000;
    else if (Incremento)
        ContadorUno <= ContadorUno + 1;
end
 
endmodule
