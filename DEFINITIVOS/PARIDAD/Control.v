module Control (
    clk,
    rst,
    INIT,
    Cero,
    LBS,
    Cargar,
    Corrimiento,
    Decremento,
    Incremento,
    DONE
);

input clk;
input rst;
input INIT;
input Cero;
input LBS;
output reg Cargar;
output reg Corrimiento;
output reg Decremento;
output reg Incremento;
output reg DONE;

parameter Inicio    = 3'b000; // Cargar=1
parameter Chequeo1  = 3'b001; // pregunta Cero
parameter Chequeo2  = 3'b010; // pregunta LBS(RegistroA)
parameter IncCarga  = 3'b011; // LBS=1 -> Incremento=1, Cargar=1
parameter ShiftDec  = 3'b100; // LBS=0 -> Decremento=1, Corrimiento=1
parameter Final     = 3'b101; // Cero=1 -> Done=1

reg [2:0] STATE;

always @(posedge clk or posedge rst) begin
    if (rst)
        STATE <= Inicio;
    else begin
        case (STATE)
            Inicio: begin
                if (INIT)
                    STATE <= Chequeo1;
                else
                    STATE <= Inicio;
            end
            Chequeo1: begin
                if (Cero)
                    STATE <= Final;
                else
                    STATE <= Chequeo2;
            end
            Chequeo2: begin
                if (LBS)
                    STATE <= IncCarga;
                else
                    STATE <= ShiftDec;
            end
            IncCarga: begin
                STATE <= ShiftDec;
            end
            ShiftDec: begin
                STATE <= Chequeo1;
            end
            Final: begin
                STATE <= Inicio;
            end
            default: STATE <= Inicio;
        endcase
    end
end

always @(*) begin
    case (STATE)
        Inicio: begin
            Cargar      = 1;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 0;
            DONE        = 0;
        end
        Chequeo1: begin
            Cargar      = 0;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 0;
            DONE        = 0;
        end
        Chequeo2: begin
            Cargar      = 0;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 0;
            DONE        = 0;
        end
        IncCarga: begin
            Cargar      = 0;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 1;
            DONE        = 0;
        end
        ShiftDec: begin
            Cargar      = 0;
            Corrimiento = 1;
            Decremento  = 1;
            Incremento  = 0;
            DONE        = 0;
        end
        Final: begin
            Cargar      = 0;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 0;
            DONE        = 1;
        end
        default: begin
            Cargar      = 0;
            Corrimiento = 0;
            Decremento  = 0;
            Incremento  = 0;
            DONE        = 0;
        end
    endcase
end

`ifdef BENCH
reg [8*20:1] estado_nombre;
always @(*) begin
    case (STATE)
        Inicio:   estado_nombre = "INICIO";
        Chequeo1: estado_nombre = "CHEQUEO1";
        Chequeo2: estado_nombre = "CHEQUEO2";
        IncCarga: estado_nombre = "INC_CARGA";
        ShiftDec: estado_nombre = "SHIFT_DEC";
        Final:    estado_nombre = "FINAL";
        default:  estado_nombre = "unknown";
    endcase
end
`endif

endmodule