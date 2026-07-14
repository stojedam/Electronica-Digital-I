module GeneradorT (
    Raiz,
    T
);
input  [7:0]  Raiz;
output [15:0] T;

assign T = ({8'b0, Raiz} << 2) + 16'b1;

endmodule