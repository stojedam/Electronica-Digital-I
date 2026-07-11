module Control_TB;
reg clk;
reg rst;
reg INIT;
reg ZERO;
reg LSB;
wire LD;
wire ADD;
wire SHIFT;
wire DONE;

Control uut (
    .clk(clk), .rst(rst), .INIT(INIT), .ZERO(ZERO), .LSB(LSB),
    .LD(LD), .ADD(ADD), .SHIFT(SHIFT), .DONE(DONE)
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
    LSB = 0;
    @(posedge clk);
    rst = 0;

    // Caso: LSB=1 (pasa por ADD y SHIFT), luego LSB=0 (solo SHIFT), luego ZERO=1 (Final)
    @(posedge clk);
    INIT = 1;
    @(posedge clk);
    INIT = 0;
    @(posedge clk); // Check1 -> Check2 (ZERO=0)
    LSB = 1;
    @(posedge clk); // Check2 -> AddSt
    @(posedge clk); // AddSt -> ShiftSt
    @(posedge clk); // ShiftSt -> Check1
    LSB = 0;
    @(posedge clk); // Check1 -> Check2 (ZERO=0)
    @(posedge clk); // Check2 -> ShiftSt
    @(posedge clk); // ShiftSt -> Check1
    ZERO = 1;
    @(posedge clk); // Check1 -> Final
    @(posedge clk);
    ZERO = 0;
    #40;

    $finish;
end

endmodule