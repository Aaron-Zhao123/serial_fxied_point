`timescale 1ns/1ps  
module testbench();

parameter width = 8;
reg[width -1 :0] x,y;
reg clk;
reg asyn_reset;
reg data_x_vld,data_y_vld,d_out_rdy;
wire data_x_rdy,data_y_rdy,d_out_vld;
wire [width - 1: 0] sum;
integer cnt = 0;
integer data_in_file_x,data_in_file_y;
integer scan_file_x,scan_file_y;

initial begin
	clk=1;
	asyn_reset <= 1;
	data_x_vld <= 1;
	data_y_vld <= 1;
	d_out_rdy <= 1;
	while(1) begin
		#10 clk=~clk;
		cnt = cnt + 1;
	end

end

always@(negedge clk) begin
	asyn_reset <= 0;
	if(data_x_rdy && data_x_vld) begin
		scan_file_x=$fscanf(data_in_file_x,"%b",x);
	end
	if (data_y_rdy && data_y_vld) begin
		scan_file_y=$fscanf(data_in_file_y,"%b",y);
	end
end


initial begin
  data_in_file_x=$fopen("/home/aaron/verilog/Serial_fixed_point/x_value.txt","r");
  
  data_in_file_y=$fopen("/home/aaron/verilog/Serial_fixed_point/y_value.txt","r");
  asyn_reset <= 1;
end
Serial_add add(
x,
y,
sum,
cout,
clk,
asyn_reset,
data_x_vld,
data_x_rdy,
data_y_vld,
data_y_rdy,
d_out_vld,
d_out_rdy
);
endmodule 
