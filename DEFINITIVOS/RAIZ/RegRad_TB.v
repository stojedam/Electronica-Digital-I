module RegRad_TB;
reg clk;
reg ld;
reg shift;
reg [15:0] Radicando;
wire [15:0] Rad;

RegRad uut (.clk(clk), .ld(ld), .shift(shift), .Radicando(Radicando), .Rad(Rad));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegRad_TB.vcd");
    $dumpvars(0, RegRad_TB);

    ld = 0; shift = 0;
    Radicando = 16'd1000;
    @(posedge clk);
    ld = 1;
    @(posedge clk);
    ld = 0;
    shift = 1;
    repeat(8) @(posedge clk);
    shift = 0;
    #40;

    $finish;
end

endmodule