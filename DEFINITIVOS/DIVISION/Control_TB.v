module Control_TB;
reg clk;
reg rst;
reg INIT;
reg ZERO;
reg RESIDUOCOMP;
wire SETCOCIENTE;
wire SETRESIDUO;
wire LD;
wire SHIFT;
wire DEC;
wire DONE;

Control uut (
    .clk(clk), .rst(rst), .INIT(INIT), .ZERO(ZERO), .RESIDUOCOMP(RESIDUOCOMP),
    .SETCOCIENTE(SETCOCIENTE), .SETRESIDUO(SETRESIDUO), .LD(LD),
    .SHIFT(SHIFT), .DEC(DEC), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Control_TB.vcd");
    $dumpvars(0, Control_TB);

    rst = 1; INIT = 0; ZERO = 0; RESIDUOCOMP = 0;
    @(posedge clk);
    rst = 0;

    @(posedge clk);
    INIT = 1;
    @(posedge clk);
    INIT = 0;
    @(posedge clk); // Check1 -> Shift (ZERO=0)
    @(posedge clk); // Shift -> Check2
    RESIDUOCOMP = 1;
    @(posedge clk); // Check2 -> Setcodi
    @(posedge clk); // Setcodi -> Counterdec
    @(posedge clk); // Counterdec -> Check1
    RESIDUOCOMP = 0;
    @(posedge clk); // Check1 -> Shift
    @(posedge clk); // Shift -> Check2
    @(posedge clk); // Check2 -> Setco
    @(posedge clk); // Setco -> Counterdec
    @(posedge clk); // Counterdec -> Check1
    ZERO = 1;
    @(posedge clk); // Check1 -> End
    @(posedge clk);
    #40;

    $finish;
end

endmodule