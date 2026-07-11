module ContadorUno_TB;
reg clk;
reg Cargar;
reg Incremento;
wire [3:0] Cantidad;
wire Paridad;

ContadorUno uut (.clk(clk), .Cargar(Cargar), .Incremento(Incremento), .Cantidad(Cantidad), .Paridad(Paridad));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("ContadorUno_TB.vcd");
    $dumpvars(0, ContadorUno_TB);

    Cargar = 0;
    Incremento = 0;
    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    @(posedge clk);
    Incremento = 1;
    repeat(5) @(posedge clk);
    Incremento = 0;
    #40;

    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    Incremento = 1;
    repeat(10) @(posedge clk);
    Incremento = 0;
    #40;

    $finish;
end

endmodule