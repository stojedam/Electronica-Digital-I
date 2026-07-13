module RegC_TB;

reg clk;
reg rst;
reg LD;
reg DEC;

wire [4:0] C;

RegC uut(
    .clk(clk),
    .rst(rst),
    .LD(LD),
    .DEC(DEC),
    .C(C)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegC_TB.vcd");
    $dumpvars(0, RegC_TB);

    rst = 1;
    LD = 0;
    DEC = 0;

    @(posedge clk);
    rst = 0;
    LD = 1;

    @(posedge clk);
    LD = 0;

    repeat(16) begin
        DEC = 1;
        @(posedge clk);
    end

    DEC = 0;

    #100;
    $finish;
end

endmodule