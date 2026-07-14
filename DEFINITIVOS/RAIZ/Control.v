module Control (
    clk,
    rst,
    INIT,
    ZERO,
    MAYORIGUAL,
    LD,
    SHIFT,
    SUBTRACT,
    SETRAIZ,
    DEC,
    DONE
);

input clk;
input rst;
input INIT;
input ZERO;
input MAYORIGUAL;
output reg LD;
output reg SHIFT;
output reg SUBTRACT;
output reg SETRAIZ;
output reg DEC;
output reg DONE;

parameter Start  = 3'b000;
parameter Check1 = 3'b001;
parameter Shift1 = 3'b010;
parameter Check2 = 3'b011;
parameter Update = 3'b100; // MAYORIGUAL=1: resta y fija el bit de raiz en 1
parameter Shift2 = 3'b101; // MAYORIGUAL=0: solo corre el bit de raiz (bit 0)
parameter Dec    = 3'b110;
parameter Final  = 3'b111;

reg [2:0] STATE;

always @(posedge clk or posedge rst) begin
    if (rst)
        STATE <= Start;
    else begin
        case (STATE)
            Start:  STATE <= INIT ? Check1 : Start;
            Check1: STATE <= ZERO ? Final  : Shift1;
            Shift1: STATE <= Check2;
            Check2: STATE <= MAYORIGUAL ? Update : Shift2;
            Update: STATE <= Dec;
            Shift2: STATE <= Dec;
            Dec:    STATE <= Check1;
            Final:  STATE <= Start;
            default: STATE <= Start;
        endcase
    end
end

always @(*) begin
    LD = 0; SHIFT = 0; SUBTRACT = 0; SETRAIZ = 0; DEC = 0; DONE = 0;
    case (STATE)
        Start:  begin LD = 1; end         
        Shift1: begin SHIFT = 1; end
        Check2: begin end
        Update: begin SUBTRACT = 1; SETRAIZ = 1; end
        Shift2: begin SETRAIZ = 1; end
        Dec:    begin DEC = 1; end
        Final:  begin DONE = 1; end
        default: begin end
    endcase
end

`ifdef BENCH
reg [8*20:1] estado_nombre;
always @(*) begin
    case (STATE)
        Start:  estado_nombre = "START";
        Check1: estado_nombre = "CHECK1";
        Shift1: estado_nombre = "SHIFT1";
        Check2: estado_nombre = "CHECK2";
        Update: estado_nombre = "UPDATE";
        Shift2: estado_nombre = "SHIFT2";
        Dec:    estado_nombre = "DEC";
        Final:  estado_nombre = "FINAL";
        default: estado_nombre = "unknown";
    endcase
end
`endif

endmodule