module Counter #(parameter N = 8, parameter CW = 4) (
    clk,
    Id,
    Dec,
    count
);

input clk;
input Id;
input Dec;
output [CW-1:0] count;

reg [CW-1:0] cnt;
assign count = cnt;

always @(posedge clk) begin
    if (Id)
        cnt <= N[CW-1:0];
    else if (Dec)
        cnt <= cnt - 1'b1;
end

endmodule