module Complement_TB;
reg [7:0] Divisor;
wire [8:0] DivisorComp;

Complement #(.N(8)) uut (.Divisor(Divisor), .DivisorComp(DivisorComp));

initial begin
    $dumpfile("Complement_TB.vcd");
    $dumpvars(0, Complement_TB);

    Divisor = 8'd5;
    #20;
    Divisor = 8'd200;
    #20;
    Divisor = 8'd0;
    #20;
    Divisor = 8'd255;
    #20;

    $finish;
end

endmodule