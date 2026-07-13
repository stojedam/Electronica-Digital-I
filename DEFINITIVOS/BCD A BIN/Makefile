TARGET = ConversorBin

ICE40_SIM_CELLS=./lattice_sim/cells_sim_ecp5.v

ifeq ($(TARGET), ConversorBin)
    OBJS = ConversorBin.v \
        	CaminoDeDatos.v \
           	RegBCD.v \
           	CorrectionBin.v \
           	RegC.v \
           	Comp.v \
           	Control.v
else ifeq ($(TARGET), RegBCD)
OBJS = RegBCD.v
else ifeq ($(TARGET), CorrectionBin)
OBJS = CorrectionBin.v
else ifeq ($(TARGET), RegC)
OBJS = RegC.v
else ifeq ($(TARGET), Comp)
OBJS = Comp.v
else ifeq ($(TARGET), Control)
OBJS = Control.v
else
    OBJS = ${TARGET}.v
endif


sim:
	rm -f a.out *.vcd
	iverilog  -DBENCH $(TARGET)_TB.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB.vcd
sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment $(TARGET)_synth.v' $(OBJS)
	iverilog  -I ./lattice_sim  $(TARGET)_TB.v $(TARGET)_synth.v $(ICE40_SIM_CELLS) 
	vvp a.out
	gtkwave $(TARGET)_TB.vcd
svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}; memory -nomap; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}.v; proc; memory -nomap; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_out"
	netlistsvg ${TARGET}.json -o ${TARGET}.svg
	google-chrome ${TARGET}.svg

#LATTICE COLORLIGHT 5A
$(TARGET).json : $(BUILD_DIR)
	yosys -v3 -q -l synth.log -p 'attrmap -tocase keep -imap keep="true" keep=1; synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment  $(TARGET)_synth.v ' $(OBJS) -l  $(TARGET).rpt
$(TARGET)_out.config : $(TARGET).json
	nextpnr-ecp5 --json $(TARGET).json --lpf $(TARGET).lpf --textcfg $(TARGET)_out.config --25k --package CABGA256 --speed 6 --timing-allow-fail --seed 1 --lpf-allow-unconstrained --log  $(TARGET)_pnr.log
$(TARGET).bit :  $(TARGET)_out.config
	ecppack --bootaddr 0 --compress $(TARGET)_out.config --svf $(TARGET).svf --bit $@

configure_lattice: $(TARGET).bit   # TDI:TDO:TCK:TMS TXD:CTS:DTR:RXD
#	sudo openFPGALoader -c ft232RL --pins=0:3:4:1 -m  ${TARGET}.bit 	
#	sudo openFPGALoader -c ft232RL --pins=RXD:RTS:TXD:CTS -m  ${TARGET}.bit 	
	sudo openFPGALoader -c ft232RL --pins=TXD:CTS:DTR:RXD -m  ${TARGET}.bit	

clean:
	rm -rf *svg *out *dot a.out *.vcd *json *_synth.v *log *bit *rpt *svf *out.config
