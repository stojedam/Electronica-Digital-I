module ConversorBin (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,
    input  wire [19:0] bcd,
    output wire [15:0] binario,
    output wire        done
);

    wire ld, shift, dec, subtract, zero;

    Control u_control (
        .clk      (clk),
        .rst_n    (rst_n),
        .init     (init),
        .zero     (zero),
        .ld       (ld),
        .shift    (shift),
        .dec      (dec),
        .subtract (subtract),
        .done     (done)
    );

    CaminoDeDatos u_datapath (
        .clk      (clk),
        .rst_n    (rst_n),
        .ld       (ld),
        .shift    (shift),
        .dec      (dec),
        .subtract (subtract),
        .bcd      (bcd),
        .binario  (binario),
        .zero     (zero)
    );

endmodule