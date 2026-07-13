module RegBin(
    input clk,
    input rst,
    input ADD,
    input SHIFT,
    input LD,
    input [15:0] Binario,
    input [19:0] BCDCorregido,

    output reg [35:0] Bin
);

always @(posedge clk) begin
    if (rst)
        Bin <= 36'b0;

    else if (LD)
        Bin <= {20'b0, Binario};

    else if (ADD)
        Bin[35:16] <= BCDCorregido;

    else if (SHIFT)
        Bin <= Bin << 1;
end

endmodule