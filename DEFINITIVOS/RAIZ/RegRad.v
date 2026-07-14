module RegRad (
    clk,
    ld,
    shift,
    Radicando,
    Rad
);
input clk;
input ld;
input shift;
input  [15:0] Radicando;
output [15:0] Rad;

reg [15:0] reg_rad;
assign Rad = reg_rad;

always @(posedge clk) begin
    if (ld)
        reg_rad <= Radicando;
    else if (shift)
        reg_rad <= {reg_rad[13:0], 2'b00};
end

endmodule