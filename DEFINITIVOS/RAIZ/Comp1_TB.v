module Comp1_TB;
reg [15:0] Residuo;
reg [15:0] T;
wire MAYORIGUAL;

Comp1 uut (.Residuo(Residuo), .T(T), .MAYORIGUAL(MAYORIGUAL));

initial begin
    $dumpfile("Comp1_TB.vcd");
    $dumpvars(0, Comp1_TB);

    Residuo = 16'd10; T = 16'd5;
    #20;
    Residuo = 16'd5; T = 16'd10;
    #20;
    Residuo = 16'd5; T = 16'd5;
    #20;

    $finish;
end

endmodule