module RegA_TB;
reg clk;
reg init_a;
reg shift_l;
reg [7:0] A;
wire [15:0] RegA_out;

RegA #(.N(8)) uut (.clk(clk), .init_a(init_a), .shift_l(shift_l), .A(A), .RegA_out(RegA_out));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegA_TB.vcd");
    $dumpvars(0, RegA_TB);

    init_a = 0;
    shift_l = 0;
    A = 8'd5;
    @(posedge clk);
    init_a = 1;
    @(posedge clk);
    init_a = 0;
    shift_l = 1;
    repeat(3) @(posedge clk);
    shift_l = 0;
    #40;

    A = 8'd200;
    @(posedge clk);
    init_a = 1;
    @(posedge clk);
    init_a = 0;
    shift_l = 1;
    repeat(4) @(posedge clk);
    shift_l = 0;
    #40;

    $finish;
end

endmodule