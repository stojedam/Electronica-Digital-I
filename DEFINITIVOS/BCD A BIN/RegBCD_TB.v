module RegBCD_TB;

    reg         clk, rst_n, ld, shift, subtract;
    reg  [19:0] bcd_in;
    reg  [35:0] corrected_in;
    wire [35:0] reg_out;

    RegBCD dut (
        .clk          (clk),
        .rst_n        (rst_n),
        .ld           (ld),
        .shift        (shift),
        .subtract     (subtract),
        .bcd_in       (bcd_in),
        .corrected_in (corrected_in),
        .reg_out      (reg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst_n = 0; ld = 0; shift = 0; subtract = 0;
        bcd_in = 20'h0; corrected_in = 36'h0;

        `ifdef BENCH
            $dumpfile("RegBCD_TB.vcd");
            $dumpvars(0, RegBCD_TB);
        `endif

        @(negedge clk); rst_n = 1;

        bcd_in = 20'h12345;
        @(negedge clk); ld = 1;
        @(negedge clk); ld = 0;

        corrected_in = 36'hABCDE1234;
        @(negedge clk); subtract = 1;
        @(negedge clk); subtract = 0;

        @(negedge clk); shift = 1;
        @(negedge clk);
        @(negedge clk); shift = 0;

        @(negedge clk);
        $finish;
    end

endmodule