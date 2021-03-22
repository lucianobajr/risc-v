all:
	iverilog datapath_tb.v -o datapath
main2:
	iverilog datapath_tb2.v -o datapath
run: datapath
	./datapath

gtk: datapath.vcd
	gtkwave datapath.vcd