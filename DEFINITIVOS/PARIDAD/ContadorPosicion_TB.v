module ContadorPosicion_TB;
reg clk;
reg Cargar;
reg Decremento;
wire Cero;

ContadorPosicion uut (.clk(clk), .Cargar(Cargar), .Decremento(Decremento), .Cero(Cero));

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("ContadorPosicion_TB.vcd");
    $dumpvars(0, ContadorPosicion_TB);

    Cargar = 0;
    Decremento = 0;
    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    @(posedge clk);
    Decremento = 1;
    wait(Cero);
    Decremento = 0;
    #40;

    @(posedge clk);
    Cargar = 1;
    @(posedge clk);
    Cargar = 0;
    Decremento = 1;
    repeat(5) @(posedge clk);
    Decremento = 0;
    #40;

    $finish;
end

endmodule