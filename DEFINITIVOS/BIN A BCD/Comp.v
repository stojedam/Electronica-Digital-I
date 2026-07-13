module Comp(
    input [4:0] C,
    output ZERO
);

assign ZERO = (C == 5'd0);

endmodule