module Paridad_TB;
reg clk;
reg rst;
reg INIT;
reg [8:0] EntradaBits;
wire [3:0] Cantidad;
wire Paridad;
wire DONE;

Paridad uut (
    .clk(clk), .rst(rst), .INIT(INIT), .EntradaBits(EntradaBits),
    .Cantidad(Cantidad), .Paridad(Paridad), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

task correr_caso(input [8:0] valor);
    begin
        EntradaBits = valor;
        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;
        INIT = 1;
        @(posedge clk);
        INIT = 0;
        wait(DONE);
        #40;
    end
endtask

initial begin
    $dumpfile("Paridad_TB.vcd");
    $dumpvars(0, Paridad_TB);

    rst = 1;
    INIT = 0;
    EntradaBits = 9'b0;
    @(posedge clk);
    rst = 0;
    #40;

    correr_caso(9'b000000000); // 0 unos  -> Cantidad=0, Paridad=0
    correr_caso(9'b000001111); // 4 unos  -> Cantidad=4, Paridad=0
    correr_caso(9'b111111111); // 9 unos  -> Cantidad=9, Paridad=1
    correr_caso(9'b101010101); // 5 unos  -> Cantidad=5, Paridad=1

    $finish;
end

endmodule