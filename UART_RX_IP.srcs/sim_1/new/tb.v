`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 01:06:21 AM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();

reg         rUART_Clock     = 0;
reg         rReset          = 0;
wire [7:0]   rData_o        ;
reg         rData_i         = 0;
wire         rNew_Data_Valid ;
wire         rParity_Error   ;

integer r_counter = 0;

`define BITS 13
reg [`BITS-1:0]   rsend  = `BITS'b11_0011_0001_011        ;
UART_RX 
#(
    .p_CHECK_PARITY(1),
    .p_PARITY(0)
 )
rx_ip 
(
.iUART_Clock        (rUART_Clock),
.iReset             (rReset),
.iData              (rData_i),
.oData              (rData_o),
.oNew_Data_Valid    (rNew_Data_Valid),
.oParity_Error      (rParity_Error)
);

always begin 
    rUART_Clock <= ~rUART_Clock;
    #104166.6; // 9600hz
end

initial begin
    rReset <= 1;
    #100;
    rReset <= 0;
end 

always @(posedge rUART_Clock) begin
    if (rReset) begin
        r_counter <= 0;
    end else begin
        if(r_counter <`BITS) begin
            rData_i <= rsend[r_counter];
            r_counter <= r_counter + 1;
        end
    end
end
endmodule
