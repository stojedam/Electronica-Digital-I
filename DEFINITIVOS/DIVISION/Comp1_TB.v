module Comp1_TB;
reg [8:0] Residuo;
reg [7:0] Divisor;
wire RESIDUOCOMP;

Comp1 #(.N(8)) uut (.Residuo(Residuo), .Divisor(Divisor), .RESIDUOCOMP(RESIDUOCOMP));

initial begin
    $dumpfile("Comp1_TB.vcd");
    $dumpvars(0, Comp1_TB);

    Divisor = 8'd10;
    Residuo = 9'd5;  // 5 < 10 -> RESIDUOCOMP=0
    #20;
    Residuo = 9'd10; // 10 >= 10 -> RESIDUOCOMP=1
    #20;
    Residuo = 9'd20; // 20 >= 10 -> RESIDUOCOMP=1
    #20;
    Residuo = 9'd0;  // 0 < 10 -> RESIDUOCOMP=0
    #20;

    $finish;
end

endmodule