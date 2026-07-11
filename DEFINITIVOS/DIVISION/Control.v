module Control (
    clk,
    rst,
    INIT,
    ZERO,
    RESIDUOCOMP,
    SETCOCIENTE,
    SETRESIDUO,
    LD,
    SHIFT,
    DEC,
    DONE
);
input clk;
input rst;
input INIT;
input ZERO;
input RESIDUOCOMP;
output reg SETCOCIENTE;
output reg SETRESIDUO;
output reg LD;
output reg SHIFT;
output reg DEC;
output reg DONE;

parameter Start      = 3'b000; // LD=1
parameter Check1     = 3'b001; // pregunta ZERO (C==0)
parameter Shift      = 3'b010; // (Residuo,Dividendo)<<1
parameter Check2     = 3'b011; // pregunta RESIDUOCOMP
parameter Setco      = 3'b100; // RESIDUOCOMP=0
parameter Setcodi    = 3'b101; // RESIDUOCOMP=1 -> SETCOCIENTE=1, SETRESIDUO=1
parameter Counterdec = 3'b110; // DEC=1
parameter End        = 3'b111; // DONE=1

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
                    STATE <= End;
                else
                    STATE <= Shift;
            end
            Shift: begin
                STATE <= Check2;
            end
            Check2: begin
                if (RESIDUOCOMP)
                    STATE <= Setcodi;
                else
                    STATE <= Setco;
            end
            Setco: begin
                STATE <= Counterdec;
            end
            Setcodi: begin
                STATE <= Counterdec;
            end
            Counterdec: begin
                STATE <= Check1;
            end
            End: begin
                STATE <= Start;
            end
            default: STATE <= Start;
        endcase
    end
end

always @(*) begin
    case (STATE)
        Start: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 1; SHIFT = 0; DEC = 0; DONE = 0;
        end
        Check1: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 0; DONE = 0;
        end
        Shift: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 1; DEC = 0; DONE = 0;
        end
        Check2: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 0; DONE = 0;
        end
        Setco: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 0; DONE = 0;
        end
        Setcodi: begin
            SETCOCIENTE = 1; SETRESIDUO = 1; LD = 0; SHIFT = 0; DEC = 0; DONE = 0;
        end
        Counterdec: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 1; DONE = 0;
        end
        End: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 0; DONE = 1;
        end
        default: begin
            SETCOCIENTE = 0; SETRESIDUO = 0; LD = 0; SHIFT = 0; DEC = 0; DONE = 0;
        end
    endcase
end

`ifdef BENCH
reg [8*20:1] estado_nombre;
always @(*) begin
    case (STATE)
        Start:      estado_nombre = "START";
        Check1:     estado_nombre = "CHECK1";
        Shift:      estado_nombre = "SHIFT";
        Check2:     estado_nombre = "CHECK2";
        Setco:      estado_nombre = "SETCO";
        Setcodi:    estado_nombre = "SETCODI";
        Counterdec: estado_nombre = "COUNTERDEC";
        End:        estado_nombre = "END";
        default:    estado_nombre = "unknown";
    endcase
end
`endif

endmodule