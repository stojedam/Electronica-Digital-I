module Multiplicador_TB;
reg clk;
reg rst;
reg INIT;
reg [7:0] A;
reg [7:0] B;
wire [15:0] P;
wire DONE;

Multiplicador #(.N(8), .CW(4)) uut (
    .clk(clk), .rst(rst), .INIT(INIT), .A(A), .B(B), .P(P), .DONE(DONE)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

task correr(input [7:0] a_val, input [7:0] b_val);
    begin
        A = a_val;
        B = b_val;
        @(posedge clk); rst = 1;
        @(posedge clk); rst = 0; INIT = 1;
        @(posedge clk); INIT = 0;
        wait(DONE);
        #40;
    end
endtask

initial begin
    $dumpfile("Multiplicador_TB.vcd");
    $dumpvars(0, Multiplicador_TB);

    rst = 1; INIT = 0; A = 0; B = 0;
    @(posedge clk); rst = 0; #40;

    correr(8'd0, 8'd25);
    correr(8'd5, 8'd6);
    correr(8'd255, 8'd255);
    correr(8'd100, 8'd3);
    correr(8'd1, 8'd1);

    $finish;
end

endmodule