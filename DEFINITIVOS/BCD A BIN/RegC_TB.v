module RegC_TB;

    reg        clk, rst_n, ld, dec;
    wire [4:0] c_out;
    integer    i;

    RegC dut (
        .clk   (clk),
        .rst_n (rst_n),
        .ld    (ld),
        .dec   (dec),
        .c_out (c_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst_n = 0; ld = 0; dec = 0;

        `ifdef BENCH
            $dumpfile("RegC_TB.vcd");
            $dumpvars(0, RegC_TB);
        `endif

        @(negedge clk); rst_n = 1;

        @(negedge clk); ld = 1;
        @(negedge clk); ld = 0;

        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk); dec = 1;
            @(negedge clk); dec = 0;
        end

        @(negedge clk);
        $finish;
    end

endmodule