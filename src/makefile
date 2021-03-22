all:
	iverilog datapath_tb.v -o datapath
main2:
	iverilog main2.v -o main
run: datapath
	./datapath

gtk: datapath.vcd
	gtkwave datapath.vcd