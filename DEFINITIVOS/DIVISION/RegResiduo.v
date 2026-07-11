module RegResiduo #(parameter N = 8) (
    clk,
    LD,
    SETRESIDUO,
    SHIFT,
    ShiftIn,
    DivisorComp,
    Residuo
);
input clk;
input LD;           
input SETRESIDUO;   
input SHIFT;        
input ShiftIn;       
input  [N:0] DivisorComp; 
output [N:0] Residuo;

reg [N:0] reg_residuo;
assign Residuo = reg_residuo;

always @(posedge clk) begin
    if (LD)
        reg_residuo <= {(N+1){1'b0}};
    else if (SETRESIDUO)
        reg_residuo <= reg_residuo + DivisorComp;
    else if (SHIFT)
        reg_residuo <= {reg_residuo[N-1:0], ShiftIn};
end

endmodule