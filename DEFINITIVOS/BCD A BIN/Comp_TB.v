module Comp_TB;

    reg  [4:0] c_in;
    wire       zero;
    integer    i;

    Comp dut (
        .c_in (c_in),
        .zero (zero)
    );

    initial begin
        `ifdef BENCH
            $dumpfile("Comp_TB.vcd");
            $dumpvars(0, Comp_TB);
        `endif

        for (i = 0; i < 32; i = i + 1) begin
            c_in = i[4:0];
            #10;
        end

        $finish;
    end

endmodule