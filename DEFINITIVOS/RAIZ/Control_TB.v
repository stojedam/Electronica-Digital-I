module Control_TB;
reg clk;
reg rst;
reg INIT;
reg ZERO;
reg MAYORIGUAL;
wire LD, SHIFT, SUBTRACT, SETRAIZ, DEC, DONE;

Control uut (
    .clk(clk), .rst(rst), .INIT(INIT), .ZERO(ZERO), .MAYORIGUAL(MAYORIGUAL),
    .LD(LD), .SHIFT(SHIFT), .SUBTRACT(SUBTRACT), .SETRAIZ(SETRAIZ), .DEC(DEC), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Control_TB.vcd");
    $dumpvars(0, Control_TB);

    rst = 1; INIT = 0; ZERO = 0; MAYORIGUAL = 0;
    @(posedge clk);
    rst = 0;

    @(posedge clk);
    INIT = 1;
    @(posedge clk);
    INIT = 0;
    repeat(2) begin
        @(posedge clk); // Check1 -> Shift1
        MAYORIGUAL = 1;
        @(posedge clk); // Shift1 -> Check2
        @(posedge clk); // Check2 -> Update
        @(posedge clk); // Update -> Dec
        @(posedge clk); // Dec -> Check1
    end
    MAYORIGUAL = 0;
    @(posedge clk); // Check1 -> Shift1
    @(posedge clk); // Shift1 -> Check2
    @(posedge clk); // Check2 -> Shift2
    @(posedge clk); // Shift2 -> Dec
    @(posedge clk); // Dec -> Check1
    ZERO = 1;
    @(posedge clk); // Check1 -> Final
    @(posedge clk); // Final -> Start
    ZERO = 0;
    #40;

    $finish;
end

endmodule