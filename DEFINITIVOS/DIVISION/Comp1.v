module Comp1 #(parameter N = 8) (
    Residuo,
    Divisor,
    RESIDUOCOMP
);
input [N:0]   Residuo;
input [N-1:0] Divisor;
output        RESIDUOCOMP;

assign RESIDUOCOMP = (Residuo >= {1'b0, Divisor}) ? 1'b1 : 1'b0;

endmodule