all:
	iverilog datapath_tb.v -o datapath
run: datapath
	./datapath
gtk: datapath.vcd
	gtkwave datapath.vcd