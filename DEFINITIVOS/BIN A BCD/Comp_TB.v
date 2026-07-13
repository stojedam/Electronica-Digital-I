module Comp_TB;

reg [4:0] C;
wire ZERO;

Comp uut(
    .C(C),
    .ZERO(ZERO)
);

initial begin
    $dumpfile("Comp_TB.vcd");
    $dumpvars(0, Comp_TB);

    C = 5'd16;
    #100;

    C = 5'd8;
    #100;

    C = 5'd1;
    #100;

    C = 5'd0;
    #100;

    $finish;
end

endmodule