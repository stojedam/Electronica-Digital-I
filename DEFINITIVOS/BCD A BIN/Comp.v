module Comp (
    input  wire [4:0] c_in,
    output wire       zero
);

    assign zero = (c_in == 5'd0);

endmodule