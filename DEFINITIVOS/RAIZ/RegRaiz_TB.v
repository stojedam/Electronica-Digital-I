module RegRaiz_TB;
reg clk;
reg ld;
reg setraiz;
reg MAYORIGUAL;
wire [7:0] Raiz;

RegRaiz uut (.clk(clk), .ld(ld), .setraiz(setraiz), .MAYORIGUAL(MAYORIGUAL), .Raiz(Raiz));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegRaiz_TB.vcd");
    $dumpvars(0, RegRaiz_TB);

    ld = 0; setraiz = 0; MAYORIGUAL = 0;
    @(posedge clk);
    ld = 1;
    @(posedge clk);
    ld = 0;
    MAYORIGUAL = 1;
    setraiz = 1;
    @(posedge clk);
    MAYORIGUAL = 0;
    @(posedge clk);
    MAYORIGUAL = 1;
    @(posedge clk);
    setraiz = 0;
    #40;

    $finish;
end

endmodule