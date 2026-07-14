module RaizCuadrada_TB;
reg clk;
reg rst;
reg INIT;
reg [15:0] Radicando;
wire [7:0] Raiz;
wire DONE;

RaizCuadrada uut (
    .clk(clk), .rst(rst), .INIT(INIT), .Radicando(Radicando), .Raiz(Raiz), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

task correr(input [15:0] valor);
    begin
        Radicando = valor;
        @(posedge clk); rst = 1;
        @(posedge clk); rst = 0; INIT = 1;
        @(posedge clk); INIT = 0;
        wait(DONE);
        #40;
    end
endtask

initial begin
    $dumpfile("RaizCuadrada_TB.vcd");
    $dumpvars(0, RaizCuadrada_TB);

    rst = 1; INIT = 0; Radicando = 0;
    @(posedge clk); rst = 0; #40;

    correr(16'd0);
    correr(16'd1);
    correr(16'd9);
    correr(16'd225);
    correr(16'd255);
    correr(16'd1000);
    correr(16'd65535);

    $finish;
end

endmodule