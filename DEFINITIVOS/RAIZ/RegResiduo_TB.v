module RegResiduo_TB;
reg clk;
reg ld;
reg subtract;
reg shift;
reg [1:0] ShiftIn;
reg [15:0] T;
wire [15:0] Residuo;

RegResiduo uut (.clk(clk), .ld(ld), .subtract(subtract), .shift(shift), .ShiftIn(ShiftIn), .T(T), .Residuo(Residuo));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegResiduo_TB.vcd");
    $dumpvars(0, RegResiduo_TB);

    ld = 0; subtract = 0; shift = 0; ShiftIn = 2'b00; T = 16'd0;
    @(posedge clk);
    ld = 1;
    @(posedge clk);
    ld = 0;
    ShiftIn = 2'b11;
    shift = 1;
    @(posedge clk);
    shift = 0;
    T = 16'd5;
    subtract = 1;
    @(posedge clk);
    subtract = 0;
    ShiftIn = 2'b01;
    shift = 1;
    repeat(3) @(posedge clk);
    shift = 0;
    #40;

    $finish;
end

endmodule