module GeneradorT_TB;
reg [7:0] Raiz;
wire [15:0] T;

GeneradorT uut (.Raiz(Raiz), .T(T));

initial begin
    $dumpfile("GeneradorT_TB.vcd");
    $dumpvars(0, GeneradorT_TB);

    Raiz = 8'd0;
    #20;
    Raiz = 8'd1;
    #20;
    Raiz = 8'd15;
    #20;
    Raiz = 8'd255;
    #20;

    $finish;
end

endmodule