module Complement #(parameter N = 8) (
    Divisor,
    DivisorComp
);
input  [N-1:0] Divisor;
output [N:0]   DivisorComp;

assign DivisorComp = (~{1'b0, Divisor}) + 1'b1;

endmodule