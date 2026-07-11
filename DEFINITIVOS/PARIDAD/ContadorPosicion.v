module ContadorPosicion (clk, Cargar, Decremento, Cero);
input clk;
input Cargar;
input Decremento;
output Cero;

reg [3:0] ContadorPosicion;
assign Cero = (ContadorPosicion == 4'b0000);

always @(posedge clk) begin
    if (Cargar)
        ContadorPosicion <= 4'b1001; // 4'b9
    else if (Decremento)
        ContadorPosicion <= ContadorPosicion - 1;
end

endmodule