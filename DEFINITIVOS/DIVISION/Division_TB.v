module Division_TB;
reg clk;
reg rst;
reg INIT;
reg [7:0] Divisor;
reg [7:0] Dividendo;
wire [8:0] Residuo;
wire [7:0] Cociente;
wire DONE;

Division #(.N(8), .CW(4)) uut (
    .clk(clk), .rst(rst), .INIT(INIT), .Divisor(Divisor), .Dividendo(Dividendo),
    .Residuo(Residuo), .Cociente(Cociente), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

task correr(input [7:0] dividendo_val, input [7:0] divisor_val);
    begin
        Dividendo = dividendo_val;
        Divisor = divisor_val;
        @(posedge clk); rst = 1;
        @(posedge clk); rst = 0; INIT = 1;
        @(posedge clk); INIT = 0;
        wait(DONE);
        #40;
    end
endtask

initial begin
    $dumpfile("Division_TB.vcd");
    $dumpvars(0, Division_TB);

    rst = 1; INIT = 0; Divisor = 0; Dividendo = 0;
    @(posedge clk); rst = 0; #40;

    correr(8'd20, 8'd5);
    correr(8'd7, 8'd2);
    correr(8'd255, 8'd3);
    correr(8'd100, 8'd7);
    correr(8'd0, 8'd9);
    correr(8'd9, 8'd200);

    $finish;
end

endmodule