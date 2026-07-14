module Comp1 (
    Residuo,
    T,
    MAYORIGUAL
);
input  [15:0] Residuo;
input  [15:0] T;
output MAYORIGUAL;

assign MAYORIGUAL = (Residuo >= T);

endmodule