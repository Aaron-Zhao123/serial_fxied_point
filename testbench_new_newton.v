`timescale 1ns/1ps
module testbench_new_newton();

parameter width = 128;

reg clk;
reg asyn_reset;

integer data_in_file_x_one,data_in_file_x_two, data_in_file_x_three, data_in_file_x_four, data_in_file_x_five;
integer data_in_file_x_six;
integer scan_file_x_one,scan_file_x_two,scan_file_x_three, scan_file_x_four,scan_file_x_five;
integer scan_file_x_six;

integer data_in_file_b_one, scan_file_b_one, scan_file_b_three, data_in_file_b_three;
integer data_in_file_b_two, scan_file_b_two;
integer data_in_file_b_four, scan_file_b_four;
integer data_in_file_b_five, scan_file_b_five;

integer cnt = 0;
initial begin
        clk=1;
        while(1) begin
                #10 clk=~clk;
        end
	asyn_reset <= 1;
end

reg [1:0] x_value_one, x_value_two, x_value_three, x_value_four, x_value_five;
reg [1:0] 
b_value_one, b_value_two, b_value_three, b_value_four, b_value_five;
always @ (posedge clk) begin
	cnt = cnt + 1;
end

initial begin
	data_in_file_x_one =$fopen ("x_value.txt","r");
	data_in_file_x_two = $fopen ("x_value.txt","r");
	data_in_file_b_one = $fopen ("y_value.txt","r");
	data_in_file_x_three = $fopen("x_value.txt", "r");
	data_in_file_x_four = $fopen ("x_value.txt", "r");
	data_in_file_b_two = $fopen ("y_value.txt","r");
	data_in_file_x_five = $fopen ("x_value.txt", "r");
	data_in_file_x_six = $fopen ("x_value.txt", "r");
	data_in_file_b_three = $fopen ("y_value.txt","r");
	data_in_file_b_four = $fopen ("y_value.txt","r");
	data_in_file_b_five = $fopen ("y_value.txt","r");
end

initial begin
	
scan_file_x_one = $fscanf(data_in_file_x_one,"%b",x_value_one);
scan_file_x_two = $fscanf(data_in_file_x_two,"%b",x_value_two);
scan_file_x_three = $fscanf (data_in_file_x_three,"%b",x_value_three);
scan_file_b_one = $fscanf(data_in_file_b_one,"%b",b_value_one);
scan_file_x_four = $fscanf (data_in_file_x_four, "%b", x_value_four);
scan_file_b_two = $fscanf(data_in_file_b_two,"%b",b_value_two);
scan_file_x_five = $fscanf (data_in_file_x_five, "%b", x_value_five);
scan_file_b_three = $fscanf(data_in_file_b_three,"%b",b_value_three);
scan_file_b_four = $fscanf(data_in_file_b_four,"%b",b_value_four);
scan_file_b_five = $fscanf(data_in_file_b_five,"%b",b_value_five);
end
wire [1:0] res;
newton integrated_newton(
clk,
asyn_reset,
x_value_one, x_value_two, x_value_three, x_value_four, x_value_five,
b_value_one, b_value_two, b_value_three, b_value_four, b_value_five,
res
);


endmodule
