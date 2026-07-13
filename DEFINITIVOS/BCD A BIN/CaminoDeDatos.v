module CaminoDeDatos (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        ld,
    input  wire        shift,
    input  wire        dec,
    input  wire        subtract,
    input  wire [19:0] bcd,
    output wire [15:0] binario,
    output wire        zero
);

    wire [35:0] reg_out, reg_corrected;
    wire [4:0]  c_out;

    RegBCD u_reg_bcd (
        .clk          (clk),
        .rst_n        (rst_n),
        .ld           (ld),
        .shift        (shift),
        .subtract     (subtract),
        .bcd_in       (bcd),
        .corrected_in (reg_corrected),
        .reg_out      (reg_out)
    );

    CorrectionBin u_correction (
        .reg_in       (reg_out),
        .reg_corrected(reg_corrected)
    );

    RegC u_reg_c (
        .clk   (clk),
        .rst_n (rst_n),
        .ld    (ld),
        .dec   (dec),
        .c_out (c_out)
    );

    Comp u_comp (
        .c_in (c_out),
        .zero (zero)
    );

    assign binario = reg_out[15:0];

endmodule