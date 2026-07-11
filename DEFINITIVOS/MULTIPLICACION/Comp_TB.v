module Comp_TB;
reg [3:0] count;
wire ZERO;

Comp #(.CW(4)) uut (.count(count), .ZERO(ZERO));

initial begin
    $dumpfile("Comp_TB.vcd");
    $dumpvars(0, Comp_TB);

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