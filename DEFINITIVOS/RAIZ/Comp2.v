module Comp2 (
    count,
    ZERO
);
input  [3:0] count;
output ZERO;

assign ZERO = (count == 4'b0);

endmodule