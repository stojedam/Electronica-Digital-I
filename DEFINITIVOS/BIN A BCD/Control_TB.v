module Control_TB;

reg clk;
reg rst;
reg INIT;
reg ZERO;

wire ADD;
wire LD;
wire SHIFT;
wire DEC;
wire DONE;

Control uut(
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .ZERO(ZERO),
    .ADD(ADD),
    .LD(LD),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Control_TB.vcd");
    $dumpvars(0, Control_TB);

    rst = 1;
    INIT = 0;
    ZERO = 0;

    @(posedge clk);
    rst = 0;

    @(posedge clk);
    INIT = 1;

    @(posedge clk);
    INIT = 0;

    repeat(16)
        @(posedge clk);

    ZERO = 1;

    repeat(5)
        @(posedge clk);

    $finish;
end

endmodule