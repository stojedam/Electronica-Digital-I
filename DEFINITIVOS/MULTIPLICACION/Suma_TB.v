module Suma_TB;
reg clk;
reg add;
reg rst;
reg [15:0] RegA_in;
wire [15:0] P;

Suma #(.N(8)) uut (.clk(clk), .add(add), .rst(rst), .RegA_in(RegA_in), .P(P));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Suma_TB.vcd");
    $dumpvars(0, Suma_TB);

    add = 0;
    rst = 0;
    RegA_in = 16'd10;
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;
    add = 1;
    @(posedge clk); // P = 0+10 = 10
    RegA_in = 16'd20;
    @(posedge clk); // P = 10+20 = 30
    RegA_in = 16'd5;
    @(posedge clk); // P = 30+5 = 35
    add = 0;
    #40;

    $finish;
end

endmodule