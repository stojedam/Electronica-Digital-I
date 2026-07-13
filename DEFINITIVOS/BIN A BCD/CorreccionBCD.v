module CorreccionBCD(
    input [35:0] Bin,
    output reg [19:0] BCDCorregido
);

always @(*) begin

    BCDCorregido = Bin[35:16];

    if (BCDCorregido[3:0] >= 5)
        BCDCorregido[3:0] =
            BCDCorregido[3:0] + 3;

    if (BCDCorregido[7:4] >= 5)
        BCDCorregido[7:4] =
            BCDCorregido[7:4] + 3;

    if (BCDCorregido[11:8] >= 5)
        BCDCorregido[11:8] =
            BCDCorregido[11:8] + 3;

    if (BCDCorregido[15:12] >= 5)
        BCDCorregido[15:12] =
            BCDCorregido[15:12] + 3;

    if (BCDCorregido[19:16] >= 5)
        BCDCorregido[19:16] =
            BCDCorregido[19:16] + 3;

end

endmodule