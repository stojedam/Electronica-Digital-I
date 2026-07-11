module RegResiduo_TB;
reg clk;
reg LD;
reg SETRESIDUO;
reg SHIFT;
reg ShiftIn;
reg [8:0] DivisorComp;
wire [8:0] Residuo;

RegResiduo #(.N(8)) uut (.clk(clk), .LD(LD), .SETRESIDUO(SETRESIDUO), .SHIFT(SHIFT), .ShiftIn(ShiftIn), .DivisorComp(DivisorComp), .Residuo(Residuo));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegResiduo_TB.vcd");
    $dumpvars(0, RegResiduo_TB);

    LD = 0; SETRESIDUO = 0; SHIFT = 0; ShiftIn = 0;
    DivisorComp = -9'd5; // complemento de 5, para restar 5
    @(posedge clk);
    LD = 1;
    @(posedge clk);
    LD = 0;
    ShiftIn = 1;
    SHIFT = 1;
    @(posedge clk); // Residuo = 0b0...01
    SHIFT = 0;
    SETRESIDUO = 1;
    @(posedge clk); // Residuo = Residuo - 5 (deberia dar negativo -> MSB en 1)
    SETRESIDUO = 0;
    ShiftIn = 0;
    SHIFT = 1;
    repeat(2) @(posedge clk);
    SHIFT = 0;
    #40;

    $finish;
end

endmodule