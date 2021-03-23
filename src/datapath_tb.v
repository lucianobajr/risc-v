`include "main.v"

module datapath_tb ();
    reg clock, reset;
	reg [31:0] mem_alu_result,read_data,WB_mux5_writedata;
    
	main Datapath(
		.clock(clock),
		.reset(reset),
		.mem_alu_result(mem_alu_result),
		.read_data(read_data),
		.WB_mux5_writedata(WB_mux5_writedata)
	);

	initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, datapath_tb);
        
        $display("Exibindo os resultados:");
        $monitor("READ DATA: %b\nExit ALU: %b\nExit WRITE DATA: %b\n",read_data,mem_alu_result, WB_mux5_writedata);

	end

	initial begin
		#1; clock = 0;
		#1; clock = 1; reset = 1;
		#1; clock = 0;
		#1; clock = 1; reset = 0;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0;
		#1; clock = 1;
		#1; clock = 0; reset = 0;
		$finish;
	end
endmodule