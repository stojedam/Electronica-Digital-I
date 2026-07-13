module Control_TB;

    reg  clk, rst_n, init, zero;
    wire ld, shift, dec, subtract, done;

    Control dut (
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

    always #5 clk = ~clk;

    task step;
        begin
            @(posedge clk);
            #1;
        end
    endtask

    initial begin
        clk = 0; rst_n = 0; init = 0; zero = 0;

        `ifdef BENCH
            $dumpfile("Control_TB.vcd");
            $dumpvars(0, Control_TB);
        `endif

        step; rst_n = 1;

        init = 1; step;   // START -> CHECK1
        init = 0;

        zero = 0; step;   // CHECK1 -> CHECK2
        step;              // CHECK2 -> SUBTRACT
        step;              // SUBTRACT -> SHIFTDEC
        step;              // SHIFTDEC -> CHECK1

        zero = 1; step;   // CHECK1 -> FINAL
        step;              // FINAL -> START

        $finish;
    end

endmodule