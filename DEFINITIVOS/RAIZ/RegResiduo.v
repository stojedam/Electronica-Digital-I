module RegResiduo (
    clk,
    ld,
    subtract,
    shift,
    ShiftIn,
    T,
    Residuo
);
input clk;
input ld;
input subtract;
input shift;
input  [1:0]  ShiftIn; // 2 bits mas significativos de RegRad, antes de su corrimiento
input  [15:0] T;
output [15:0] Residuo;

reg [15:0] reg_residuo;
assign Residuo = reg_residuo;

always @(posedge clk) begin
    if (ld)
        reg_residuo <= 16'b0;
    else if (subtract)
        reg_residuo <= reg_residuo - T;
    else if (shift)
        reg_residuo <= {reg_residuo[13:0], ShiftIn};
end

endmodule