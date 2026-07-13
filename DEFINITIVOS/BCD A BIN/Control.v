module Control (
    input  wire clk,
    input  wire rst_n,
    input  wire init,
    input  wire zero,
    output reg  ld,
    output reg  shift,
    output reg  dec,
    output reg  subtract,
    output reg  done
);

    localparam S_START    = 3'd0;
    localparam S_CHECK1   = 3'd1;
    localparam S_FINAL    = 3'd2;
    localparam S_CHECK2   = 3'd3;
    localparam S_SUBTRACT = 3'd4;
    localparam S_SHIFTDEC = 3'd5;

    reg [2:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= S_START;
        else        state <= next_state;
    end

    always @(*) begin
        case (state)
            S_START:    next_state = init ? S_CHECK1 : S_START;
            S_CHECK1:   next_state = zero ? S_FINAL   : S_CHECK2;
            S_FINAL:    next_state = S_START;
            S_CHECK2:   next_state = S_SUBTRACT;
            S_SUBTRACT: next_state = S_SHIFTDEC;
            S_SHIFTDEC: next_state = S_CHECK1;
            default:    next_state = S_START;
        endcase
    end

    always @(*) begin
        ld = 1'b0; shift = 1'b0; dec = 1'b0; subtract = 1'b0; done = 1'b0;
        case (state)
            S_START:    ld       = 1'b1;
            S_SUBTRACT: subtract = 1'b1;
            S_SHIFTDEC: begin shift = 1'b1; dec = 1'b1; end
            S_FINAL:    done     = 1'b1;
            default:    ;
        endcase
    end

endmodule