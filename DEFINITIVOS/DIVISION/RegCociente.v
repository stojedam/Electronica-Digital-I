module RegCociente #(parameter N = 8) (
    clk,
    LD,
    SETCOCIENTE,
    SHIFT,
    Dividendo,
    Cociente,
    MSB
);

input clk;
input LD;            
input SETCOCIENTE;   
input SHIFT;         
input  [N-1:0] Dividendo;
output [N-1:0] Cociente;
output MSB;

reg [N-1:0] reg_cociente;
assign Cociente = reg_cociente;
assign MSB = reg_cociente[N-1];

always @(posedge clk) begin
    if (LD)
        reg_cociente <= Dividendo;
    else if (SETCOCIENTE)
        reg_cociente <= {reg_cociente[N-1:1], 1'b1};
    else if (SHIFT)
        reg_cociente <= {reg_cociente[N-2:0], 1'b0};
end

endmodule