module Counter_TB;
reg clk;
reg Id;
reg Dec;
wire [3:0] count;

Counter #(.N(8), .CW(4)) uut (.clk(clk), .Id(Id), .Dec(Dec), .count(count));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Counter_TB.vcd");
    $dumpvars(0, Counter_TB);

    Id = 0;
    Dec = 0;
    @(posedge clk);
    Id = 1;
    @(posedge clk);
    Id = 0;
    @(posedge clk);
    Dec = 1;
    repeat(8) @(posedge clk); // de 8 a 0
    Dec = 0;
    #40;

    $finish;
end

endmodule