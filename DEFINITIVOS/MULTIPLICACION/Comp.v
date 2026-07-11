module Comp #(parameter CW = 4) (
    count,
    ZERO
);
input  [CW-1:0] count;
output ZERO;

assign ZERO = (count == {CW{1'b0}});

endmodule