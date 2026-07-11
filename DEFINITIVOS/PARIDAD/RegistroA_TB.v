module RegistroA_TB;
reg clk;
reg Cargar;
reg Corrimiento;
reg [8:0] EntradaBits;
wire LBS;

RegistroA uut (.clk(clk), .Cargar(Cargar), .Corrimiento(Corrimiento), .EntradaBits(EntradaBits), .LBS(LBS));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("RegistroA_TB.vcd");
    $dumpvars(0, RegistroA_TB);

    Cargar = 0;
    Corrimiento = 0;
    EntradaBits = 9'b000011111;
    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    Corrimiento = 1;
    repeat(9) @(posedge clk);
    Corrimiento = 0;
    #40;

    EntradaBits = 9'b111111111;
    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    Corrimiento = 1;
    repeat(9) @(posedge clk);
    Corrimiento = 0;
    #40;

    EntradaBits = 9'b010101010;
    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    Corrimiento = 1;
    repeat(9) @(posedge clk);
    Corrimiento = 0;
    #40;

    $finish;
end

endmodule