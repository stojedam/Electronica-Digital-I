module CorrectionBin_TB;

    reg  [35:0] reg_in;
    wire [35:0] reg_corrected;

    CorrectionBin dut (
        .reg_in        (reg_in),
        .reg_corrected (reg_corrected)
    );

    initial begin
        `ifdef BENCH
            $dumpfile("CorrectionBin_TB.vcd");
            $dumpvars(0, CorrectionBin_TB);
        `endif

        reg_in = {4'd0,4'd1,4'd2,4'd3,4'd4, 16'hABCD}; #10;
        reg_in = {4'd0,4'd0,4'd0,4'd0,4'd9, 16'h0000}; #10;
        reg_in = {4'd8,4'd8,4'd8,4'd8,4'd8, 16'h1234}; #10;
        reg_in = {4'd9,4'd9,4'd9,4'd9,4'd9, 16'hFFFF}; #10;

        $finish;
    end

endmodule