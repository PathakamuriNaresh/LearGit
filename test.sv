
module fifo2(input [7:0] data_in, input clk,rst,rd,wr, 
	output empty,full, output reg [3:0] ifo_cnt,
	output reg [7:0] data_out);

reg [7:0] fifo_ram [0:7];
reg [2:0] rd_ptr,wr_ptr;

assign empty = (fifo_cnt==0);
assign full = (fifo_cnt==8);


always @(posedge clk) begin:write
	
	if((wr && !full) || (wr && rd))

		fifo_ram(wr_ptr) <= data_in;
end


always @(posedge clk) begin:read

	if((rd && !empty) || (rd && wr))

		data_out <= fifo_ram(rd_ptr);
end


always @(posedge clk) begin:pointer

	if(rst) begin

		wr_ptr <= 0;
		rd_ptr <= 0;

		else begin

			wr_ptr <= ((wr && !full) || (wr && rd)) ? wr_ptr+1 : wr_ptr;

			rd_ptr <= ((rd && !empty) || (rd && wr)) ? rd_ptr+1 : rd_ptr;

			end

		end

	end


always @(posedge clk) begin:counter

	if(rst) begin

		fifo_cnt <=0;

		else begin

			case ({wr,rd})

				2'b00: fifo_cnt <= fifo_cnt;
				2'b01: fifo_cnt <= (fifo_cnt==0) ? 0 : fifo_cnt-1;
			        2'b10: fifo_cnt <= (fifo_cnt==8) ? 8 : fifo_cnt+1;
				2'b11: fifo_cnt <= fifo_cnt <= fifo_cnt;
				default: fifo_cnt <= fifo_cnt;
			endcase
		end
	end
end

endmodule
