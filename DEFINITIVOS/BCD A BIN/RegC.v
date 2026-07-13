module RegC (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ld,
    input  wire       dec,
    output reg  [4:0] c_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            c_out <= 5'd0;
        else if (ld)
            c_out <= 5'd16;
        else if (dec)
            c_out <= c_out - 5'd1;
    end

endmodule