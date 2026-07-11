module RegistroA (clk, Cargar, Corrimiento, EntradaBits, LBS);
input clk;
input Cargar;
input Corrimiento;
input [8:0] EntradaBits;
output LBS;

reg [8:0] RegistroA;
assign LBS = RegistroA[0];

always @(posedge clk) begin
    if (Cargar)
        RegistroA <= EntradaBits;
    else if (Corrimiento)
        RegistroA <= RegistroA >> 1;
end

endmodule