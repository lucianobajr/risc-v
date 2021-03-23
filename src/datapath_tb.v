`include "main.v"

module datapath_tb ();
    reg clock, reset;

    main Datapath(
		.clock(clock),
		.reset(reset)
		.);

	initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, main);
        
        $display("Exibindo os resultados:");
        $monitor("Instruction: %b\nExit PC: %b\nExit ALU: %b\n", );

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