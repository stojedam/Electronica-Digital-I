module RegBCD (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        ld,
    input  wire        shift,
    input  wire        subtract,
    input  wire [19:0] bcd_in,
    input  wire [35:0] corrected_in,
    output reg  [35:0] reg_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            reg_out <= 36'b0;
        else if (ld)
            reg_out <= {bcd_in, 16'b0};
        else if (subtract)
            reg_out <= corrected_in;
        else if (shift)
            reg_out <= reg_out >> 1;
    end

endmodule