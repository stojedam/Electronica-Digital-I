module CorrectionBin (
    input  wire [35:0] reg_in,
    output wire [35:0] reg_corrected
);

    wire [3:0] d0 = reg_in[19:16];
    wire [3:0] d1 = reg_in[23:20];
    wire [3:0] d2 = reg_in[27:24];
    wire [3:0] d3 = reg_in[31:28];
    wire [3:0] d4 = reg_in[35:32];

    wire [3:0] d0_c = (d0 >= 4'd8) ? (d0 - 4'd3) : d0;
    wire [3:0] d1_c = (d1 >= 4'd8) ? (d1 - 4'd3) : d1;
    wire [3:0] d2_c = (d2 >= 4'd8) ? (d2 - 4'd3) : d2;
    wire [3:0] d3_c = (d3 >= 4'd8) ? (d3 - 4'd3) : d3;
    wire [3:0] d4_c = (d4 >= 4'd8) ? (d4 - 4'd3) : d4;

    assign reg_corrected = {d4_c, d3_c, d2_c, d1_c, d0_c, reg_in[15:0]};

endmodule