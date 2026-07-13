module ConversorBin_TB;

    reg         clk, rst_n, init;
    reg  [19:0] bcd;
    wire [15:0] binario;
    wire        done;

    ConversorBin dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .init    (init),
        .bcd     (bcd),
        .binario (binario),
        .done    (done)
    );

    always #5 clk = ~clk;

    task step;
        begin
            @(posedge clk);
            #1;
        end
    endtask

    task run_test(input [19:0] value);
        begin
            bcd = value;
            init = 1; step; init = 0;
            wait (done);
            step;
        end
    endtask

    initial begin
        clk = 0; rst_n = 0; init = 0; bcd = 20'h0;

        `ifdef BENCH
            $dumpfile("ConversorBin_TB.vcd");
            $dumpvars(0, ConversorBin_TB);
        `endif

        step; rst_n = 1;
        step;

        run_test(20'h00000); // 0
        run_test(20'h00001); // 1
        run_test(20'h00010); // 10 (BCD)
        run_test(20'h01234); // 1234 (BCD)

        $finish;
    end

endmodule