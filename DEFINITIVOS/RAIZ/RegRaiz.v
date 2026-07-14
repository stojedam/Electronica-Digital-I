module RegRaiz (
    clk,
    ld,
    setraiz,
    MAYORIGUAL,
    Raiz
);
input clk;
input ld;
input setraiz;
input MAYORIGUAL;
output [7:0] Raiz;

reg [7:0] reg_raiz;
assign Raiz = reg_raiz;

always @(posedge clk) begin
    if (ld)
        reg_raiz <= 8'b0;
    else if (setraiz)
        reg_raiz <= {reg_raiz[6:0], MAYORIGUAL};
end

endmodule