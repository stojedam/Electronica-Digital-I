module Comp2_TB;
reg [3:0] count;
wire ZERO;

Comp2 #(.CW(4)) uut (.count(count), .ZERO(ZERO));

initial begin
    $dumpfile("Comp2_TB.vcd");
    $dumpvars(0, Comp2_TB);

    count = 4'd8;
    #20;
    count = 4'd3;
    #20;
    count = 4'd0;
    #20;
    count = 4'd1;
    #20;

    $finish;
end

endmodule