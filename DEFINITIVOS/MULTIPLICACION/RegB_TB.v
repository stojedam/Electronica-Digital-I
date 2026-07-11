module RegB_TB;
reg clk;
reg init_b;
reg shift_r;
reg [7:0] B;
wire LSB;

RegB #(.N(8)) uut (.clk(clk), .init_b(init_b), .shift_r(shift_r), .B(B), .LSB(LSB));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegB_TB.vcd");
    $dumpvars(0, RegB_TB);

    init_b = 0;
    shift_r = 0;
    B = 8'b00010110; // 22, para ver LSB alternando: 0,1,1,0,1...
    @(posedge clk);
    init_b = 1;
    @(posedge clk);
    init_b = 0;
    shift_r = 1;
    repeat(8) @(posedge clk);
    shift_r = 0;
    #40;

    $finish;
end

endmodule