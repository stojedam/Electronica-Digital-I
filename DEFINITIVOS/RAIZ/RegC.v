module RegC (
    clk,
    ld,
    dec,
    count
);
input clk;
input ld;
input dec;
output [3:0] count;

reg [3:0] cnt;
assign count = cnt;

always @(posedge clk) begin
    if (ld)
        cnt <= 4'd8;
    else if (dec)
        cnt <= cnt - 1'b1;
end

endmodule