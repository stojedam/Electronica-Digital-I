module RegBin_TB;

reg clk;
reg rst;
reg ADD;
reg SHIFT;
reg LD;

reg [15:0] Binario;
reg [19:0] BCDCorregido;

wire [35:0] Bin;

RegBin uut(
    .clk(clk),
    .rst(rst),
    .ADD(ADD),
    .SHIFT(SHIFT),
    .LD(LD),
    .Binario(Binario),
    .BCDCorregido(BCDCorregido),
    .Bin(Bin)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegBin_TB.vcd");
    $dumpvars(0, RegBin_TB);

    rst = 1;
    ADD = 0;
    SHIFT = 0;
    LD = 0;
    Binario = 16'd12345;
    BCDCorregido = 20'h12345;

    @(posedge clk);
    rst = 0;

    LD = 1;
    @(posedge clk);
    LD = 0;

    SHIFT = 1;
    repeat(5)
        @(posedge clk);
    SHIFT = 0;

    ADD = 1;
    @(posedge clk);
    ADD = 0;

    #100;
    $finish;
end

endmodule