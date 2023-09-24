`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Genadi 109
// 
// Create Date: 04/23/2022 11:18:22 PM
// Design Name: 
// Module Name: UART_RX
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


module UART_RX
#( //like generic in vhdl
    parameter p_UART_BITS           = 8,
    parameter [2:0] p_START_BITS    = 1,
    parameter [2:0] p_STOP_BITS     = 1,
    parameter [0:0] p_CHECK_PARITY  = 1'b0,// 0 - no use of parity  ,   1 - check for parity
    parameter [0:0] p_PARITY        = 1'b0 // 0 - parity even = 0   ,   1 - pariy odd = 1
    )
( //i/o list
    input iUART_Clock,
    input iReset,
    input iData,
    output [p_UART_BITS-1:0] oData,
    output oNew_Data_Valid,
    output oParity_Error  // 0 - no error, 1- error
    );
    
    localparam reg [2:0] IDLE   = 3'd0;
    localparam reg [2:0] START  = 3'd1;
    localparam reg [2:0] DATA   = 3'd2;
    localparam reg [2:0] PARITY = 3'd3;
    localparam reg [2:0] STOP   = 3'd4;
    
        //Second always - controlling the UIART 
    reg [2:0] rUART_State                   = IDLE;
    reg [2:0] rStart_bits                   = p_START_BITS-1;
    reg [2:0] rStop_bits                    = p_STOP_BITS-1;
    reg [3:0] rUART_Bits_Counter            = p_UART_BITS-1;
    reg [0:p_UART_BITS-1] rData             = 0; //bits order inverted,LSB at index p_UART_BITS-1, MSB at index 0
    reg                   rData_Parity      = 1'b0;
    reg rNew_Data_Valid                     = 1'b0;
    reg r_Data_stable                       = 1'b0;
    reg rParity_Error                       = 1'b0;
    /*initial begin
      rClock <= 1'b0;
    end*/
    
    assign oData            = rNew_Data_Valid? rData: 0;
    assign oNew_Data_Valid  = rNew_Data_Valid; 
    assign oParity_Error    = rParity_Error;
    
    always @(posedge iUART_Clock, posedge iReset) begin
        if(iReset) begin
            rNew_Data_Valid     <=  1'b0;
            rUART_State         <=  IDLE;
            rStart_bits         <=  p_START_BITS-1;
            rStop_bits          <=  p_STOP_BITS -1;
            rUART_Bits_Counter  <=  p_UART_BITS -1;
        end else begin
            r_Data_stable <= iData;
            case (rUART_State)
                IDLE: begin
                    if(r_Data_stable) 
                        rUART_State <= START;
                end
                
                START: begin
                    rNew_Data_Valid <= 1'b0;
                    rParity_Error   <= 1'b0;
                    if(!r_Data_stable)
                        if(rStart_bits == 0) begin
                            rUART_State <=  DATA;
                            rStart_bits <=  p_START_BITS-1;
                        end else
                            rStart_bits <=  rStart_bits - 1;
                end
                
                DATA: begin
                    rData[rUART_Bits_Counter]   <= r_Data_stable;
                    
                    if(rUART_Bits_Counter==0) begin
                        if(p_CHECK_PARITY) //check parity
                            rUART_State         <=  PARITY;
                        else    
                            rUART_State         <=  STOP;
                            
                        rUART_Bits_Counter  <=  p_UART_BITS - 1; 
                        rData_Parity        <=  ^{r_Data_stable, rData[1:p_UART_BITS - 1]}; //calculate Parity bit without missing the last bit
                    end else 
                        rUART_Bits_Counter  <= rUART_Bits_Counter- 1;
                end
                
                PARITY: begin
                    if(p_PARITY) begin // odd
                        if((rData_Parity && !r_Data_stable) || (!rData_Parity && r_Data_stable))
                            rParity_Error <= 1'b0;
                        else
                            rParity_Error <= 1'b1;
                    end else begin // even
                        if((!rData_Parity && !r_Data_stable) || (rData_Parity && r_Data_stable))
                            rParity_Error <= 1'b0;
                        else
                            rParity_Error <= 1'b1;
                    end
                    rUART_State   <=  STOP;
                end
                
                STOP: begin
                     if(r_Data_stable)
                        if(rStop_bits == 0) begin
                            rUART_State     <=  START;
                            rStop_bits      <=  p_STOP_BITS-1;
                            rNew_Data_Valid <=  1'b1;
                        end else
                            rStop_bits  <= rStop_bits - 1;
                     else // if the stop bit is 0 then something is off
                            rUART_State     <=  START;
                            rStop_bits      <=  p_STOP_BITS-1;
                end
                
                default: begin
                    rUART_State <= IDLE;
                end
            endcase
        
        end
    end
    
endmodule
