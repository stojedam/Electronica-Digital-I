module ConversorBCD_TB;

reg clk;
reg rst;
reg INIT;
reg [15:0] Binario;

wire [19:0] BCD;
wire DONE;

ConversorBCD uut(
    .clk(clk),
    .rst(rst),
    .INIT(INIT),
    .Binario(Binario),
    .BCD(BCD),
    .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

task prueba;
input [15:0] numero;
begin
    rst = 1;
    INIT = 0;
    Binario = numero;

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
    $dumpfile("ConversorBCD_TB.vcd");
    $dumpvars(0, ConversorBCD_TB);

    prueba(0);
    prueba(9);
    prueba(25);
    prueba(1234);
    prueba(12345);
    prueba(65535);

    $finish;
end

endmodule