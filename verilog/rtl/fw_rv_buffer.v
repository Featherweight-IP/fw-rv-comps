/****************************************************************************
 * fw_rv_buffer.v
 ****************************************************************************/

`include "rv_macros.svh"
  
/**
 * Module: fw_rv_buffer
 * 
 * TODO: Add module documentation
 */
module fw_rv_buffer #(
		parameter WIDTH=8
		) (
		input			clock,
		input			reset,
		`RV_TARGET_PORT(i_, WIDTH),
		`RV_INITIATOR_PORT(o_, WIDTH)
		);
	reg[WIDTH-1:0]			dat;
	reg						dat_v;

	// Accept new data if we're not currently holding any
	// or if the output is accepting data in this cycle
	assign i_ready = (dat_v == 1'b0 || (o_valid & o_ready));
	assign o_valid = dat_v;
	assign o_dat = dat;
	
	always @(posedge clock) begin
		if (reset) begin
			dat <= {WIDTH{1'b0}};
			dat_v <= 1'b0;
		end else begin
			if (i_valid && i_ready) begin
				dat <= i_dat;
			end
		
			if (i_valid && i_ready) begin
				dat_v <= 1'b1;
			end else if (o_valid && o_ready) begin
				dat_v <= 1'b0;
			end
		end
	end
endmodule


