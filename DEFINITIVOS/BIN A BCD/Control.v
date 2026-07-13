module Control(
    input clk,
    input rst,
    input INIT,
    input ZERO,

    output reg ADD,
    output reg LD,
    output reg SHIFT,
    output reg DEC,
    output reg DONE
);

reg [2:0] Estado;

parameter START    = 3'd0;
parameter CHECK1   = 3'd1;
parameter CHECK2   = 3'd2;
parameter ADDSTATE = 3'd3;
parameter SHIFTDEC = 3'd4;
parameter FINAL    = 3'd5;

always @(posedge clk) begin
    if (rst)
        Estado <= START;
    else begin
        case (Estado)

            START:
                if (INIT)
                    Estado <= CHECK1;
                else
                    Estado <= START;

            CHECK1:
                if (ZERO)
                    Estado <= FINAL;
                else
                    Estado <= CHECK2;

            CHECK2:
                Estado <= ADDSTATE;

            ADDSTATE:
                Estado <= SHIFTDEC;

            SHIFTDEC:
                Estado <= CHECK1;

            FINAL:
                Estado <= START;

            default:
                Estado <= START;

        endcase
    end
end

always @(*) begin
    case (Estado)

        START: begin
            ADD   = 0;
            LD    = 1;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 0;
        end

        CHECK1: begin
            ADD   = 0;
            LD    = 0;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 0;
        end

        CHECK2: begin
            ADD   = 0;
            LD    = 0;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 0;
        end

        ADDSTATE: begin
            ADD   = 1;
            LD    = 0;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 0;
        end

        SHIFTDEC: begin
            ADD   = 0;
            LD    = 0;
            SHIFT = 1;
            DEC   = 1;
            DONE  = 0;
        end

        FINAL: begin
            ADD   = 0;
            LD    = 0;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 1;
        end

        default: begin
            ADD   = 0;
            LD    = 0;
            SHIFT = 0;
            DEC   = 0;
            DONE  = 0;
        end

    endcase
end

endmodule