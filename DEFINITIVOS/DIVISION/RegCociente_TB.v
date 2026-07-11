module RegCociente_TB;
reg clk;
reg LD;
reg SETCOCIENTE;
reg SHIFT;
reg [7:0] Dividendo;
wire [7:0] Cociente;
wire MSB;

RegCociente #(.N(8)) uut (.clk(clk), .LD(LD), .SETCOCIENTE(SETCOCIENTE), .SHIFT(SHIFT), .Dividendo(Dividendo), .Cociente(Cociente), .MSB(MSB));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegCociente_TB.vcd");
    $dumpvars(0, RegCociente_TB);

    LD = 0; SETCOCIENTE = 0; SHIFT = 0;
    Dividendo = 8'b10110011;
    @(posedge clk);
    LD = 1;
    @(posedge clk);
    LD = 0;
    SHIFT = 1;
    @(posedge clk); // corre, LSB entra en 0
    SHIFT = 0;
    SETCOCIENTE = 1;
    @(posedge clk); // fija el LSB en 1
    SETCOCIENTE = 0;
    SHIFT = 1;
    repeat(3) @(posedge clk);
    SHIFT = 0;
    #40;

    $finish;
end

endmodule