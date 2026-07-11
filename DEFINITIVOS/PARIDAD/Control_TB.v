module Control_TB;
reg clk;
reg rst;
reg INIT;
reg Cero;
reg LBS;
wire Cargar;
wire Corrimiento;
wire Decremento;
wire Incremento;
wire DONE;

Control uut (
    .clk(clk), .rst(rst), .INIT(INIT), .Cero(Cero), .LBS(LBS),
    .Cargar(Cargar), .Corrimiento(Corrimiento), .Decremento(Decremento),
    .Incremento(Incremento), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("Control_TB.vcd");
    $dumpvars(0, Control_TB);

    rst = 1;
    INIT = 0;
    Cero = 0;
    LBS = 0;
    @(posedge clk);
    rst = 0;

    // Caso 1: el número llega directo a cero (EntradaBits = 0)
    @(posedge clk);
    INIT = 1;
    @(posedge clk);
    INIT = 0;
    @(posedge clk);
    Cero = 1;
    @(posedge clk);
    Cero = 0;
    #40;

    // Caso 2: recorre un bit en 1 y luego uno en 0 antes de terminar
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;
    INIT = 1;
    @(posedge clk);
    INIT = 0;
    @(posedge clk);
    LBS = 1;
    @(posedge clk);
    LBS = 0;
    @(posedge clk);
    @(posedge clk);
    LBS = 0;
    @(posedge clk);
    Cero = 1;
    @(posedge clk);
    Cero = 0;
    #40;

    $finish;
end

endmodule