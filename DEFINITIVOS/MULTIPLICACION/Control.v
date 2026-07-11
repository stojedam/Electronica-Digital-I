module Control (
    clk,
    rst,
    INIT,
    ZERO,
    LSB,
    LD,
    ADD,
    SHIFT,
    DONE
);
input clk;
input rst;
input INIT;
input ZERO;
input LSB;
output reg LD;
output reg ADD;
output reg SHIFT;
output reg DONE;

parameter Start  = 3'b000; // LD=1
parameter Check1 = 3'b001; // pregunta ZERO (C==0)
parameter Check2 = 3'b010; // pregunta LSB(B)
parameter AddSt  = 3'b011; // LBS(B)=1 -> ADD=1, luego pasa por Shift
parameter ShiftSt= 3'b100; // A<<1, B>>1, C=C-1
parameter Final  = 3'b101; // ZERO=1 -> DONE=1

reg [2:0] STATE;

always @(posedge clk or posedge rst) begin
    if (rst)
        STATE <= Start;
    else begin
        case (STATE)
            Start: begin
                if (INIT)
                    STATE <= Check1;
                else
                    STATE <= Start;
            end
            Check1: begin
                if (ZERO)
                    STATE <= Final;
                else
                    STATE <= Check2;
            end
            Check2: begin
                if (LSB)
                    STATE <= AddSt;
                else
                    STATE <= ShiftSt;
            end
            AddSt: begin
                STATE <= ShiftSt; 
            end
            ShiftSt: begin
                STATE <= Check1;
            end
            Final: begin
                STATE <= Start;
            end
            default: STATE <= Start;
        endcase
    end
end

always @(*) begin
    case (STATE)
        Start: begin
            LD    = 1;
            ADD   = 0;
            SHIFT = 0;
            DONE  = 0;
        end
        Check1: begin
            LD    = 0;
            ADD   = 0;
            SHIFT = 0;
            DONE  = 0;
        end
        Check2: begin
            LD    = 0;
            ADD   = 0;
            SHIFT = 0;
            DONE  = 0;
        end
        AddSt: begin
            LD    = 0;
            ADD   = 1;
            SHIFT = 0;
            DONE  = 0;
        end
        ShiftSt: begin
            LD    = 0;
            ADD   = 0;
            SHIFT = 1;
            DONE  = 0;
        end
        Final: begin
            LD    = 0;
            ADD   = 0;
            SHIFT = 0;
            DONE  = 1;
        end
        default: begin
            LD    = 0;
            ADD   = 0;
            SHIFT = 0;
            DONE  = 0;
        end
    endcase
end

`ifdef BENCH
reg [8*20:1] estado_nombre;
always @(*) begin
    case (STATE)
        Start:   estado_nombre = "START";
        Check1:  estado_nombre = "CHECK1";
        Check2:  estado_nombre = "CHECK2";
        AddSt:   estado_nombre = "ADD";
        ShiftSt: estado_nombre = "SHIFT";
        Final:   estado_nombre = "FINAL";
        default: estado_nombre = "unknown";
    endcase
end
`endif

endmodule