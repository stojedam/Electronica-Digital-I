module CorreccionBCD_TB;

reg [35:0] Bin;
wire [19:0] BCDCorregido;

CorreccionBCD uut(
    .Bin(Bin),
    .BCDCorregido(BCDCorregido)
);

initial begin
    $dumpfile("CorreccionBCD_TB.vcd");
    $dumpvars(0, CorreccionBCD_TB);

    Bin = 36'b0;
    Bin[35:16] = 20'h12345;
    #100;

    Bin[35:16] = 20'h56789;
    #100;

    Bin[35:16] = 20'h99999;
    #100;

    $finish;
end

endmodule