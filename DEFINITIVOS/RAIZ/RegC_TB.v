module RegC_TB;
reg clk;
reg ld;
reg dec;
wire [3:0] count;

RegC uut (.clk(clk), .ld(ld), .dec(dec), .count(count));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegC_TB.vcd");
    $dumpvars(0, RegC_TB);

    ld = 0; dec = 0;
    @(posedge clk);
    ld = 1;
    @(posedge clk);
    ld = 0;
    dec = 1;
    repeat(8) @(posedge clk);
    dec = 0;
    #40;

    $finish;
end

endmodule