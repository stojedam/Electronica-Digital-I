module RegC(
    input clk,
    input rst,
    input LD,
    input DEC,

    output reg [4:0] C
);

always @(posedge clk) begin
    if (rst)
        C <= 5'd16;

    else if (LD)
        C <= 5'd16;

    else if (DEC)
        C <= C - 1'b1;
end

endmodule