module CaminoDeDatos_TB;

reg clk;
reg rst;
reg ADD;
reg LD;
reg SHIFT;
reg DEC;
reg [15:0] Binario;

wire [19:0] BCD;
wire ZERO;

CaminoDeDatos uut(
    .clk(clk),
    .rst(rst),
    .ADD(ADD),
    .LD(LD),
    .SHIFT(SHIFT),
    .DEC(DEC),
    .Binario(Binario),
    .BCD(BCD),
    .ZERO(ZERO)
);

initial begin
    clk = 0;
    forever #20 clk = ~clk;
end

initial begin
    $dumpfile("CaminoDeDatos_TB.vcd");
    $dumpvars(0, CaminoDeDatos_TB);

    rst = 1;
    ADD = 0;
    LD = 0;
    SHIFT = 0;
    DEC = 0;
    Binario = 16'd12345;

    @(posedge clk);
    rst = 0;

    LD = 1;
    @(posedge clk);
    LD = 0;

    repeat(16) begin
        ADD = 1;
        @(posedge clk);
        ADD = 0;

        SHIFT = 1;
        DEC = 1;
        @(posedge clk);
        SHIFT = 0;
        DEC = 0;
    end

    #100;
    $finish;
end

endmodule