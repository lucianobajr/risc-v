module if_id (clock, reset,instrout,npcout,instr,npc);
    input wire clock,reset;
    output reg [31:0] instrout,npcout;     
    input wire [31:0] instr,npc;

    initial @(posedge reset)  begin
        instrout <= 0;
        npcout   <= 0;
    end

    always  @(posedge clock)  begin
        if (!reset) begin
            instrout <= instr;
            npcout <= npc;
        end
    end
endmodule