# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  #Adding Page
  set Description [ipgui::add_page $IPINST -name "Description"]
  ipgui::add_static_text $IPINST -name "text" -parent ${Description} -text {PARAMETERS:
* p_UART_BITS           - incoming data size and output data vector size.
* p_START_BITS         - How many Start bits.
* p_STOP_BITS           - How many Stop bits.
* p_CHECK_PARITY   - Incoming data includes Parity?.
* p_PARITY                    - Incoming data has Parity ODD or EVEN.
 
INPUTS:
* iUART_Clock - RX in coming data speed
* iReset             - Reset input, active high.
* iData               - incoming data

OUTPUTS:
* oData                       - Data output,size determinded by parameter name 'p_UART_BITS'
* oNew_Data_Valid  -  One pulse bit for data valid at the oData.
* oParity_Error           - When 'p_CHECK_PARITY' is 'YES' then when Parity is Error 2 clocks pulse.}

  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Configure Parameters}]
  ipgui::add_param $IPINST -name "p_UART_BITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "p_CHECK_PARITY" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "p_START_BITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "p_STOP_BITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "p_PARITY" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.p_CHECK_PARITY { PARAM_VALUE.p_CHECK_PARITY } {
	# Procedure called to update p_CHECK_PARITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.p_CHECK_PARITY { PARAM_VALUE.p_CHECK_PARITY } {
	# Procedure called to validate p_CHECK_PARITY
	return true
}

proc update_PARAM_VALUE.p_PARITY { PARAM_VALUE.p_PARITY } {
	# Procedure called to update p_PARITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.p_PARITY { PARAM_VALUE.p_PARITY } {
	# Procedure called to validate p_PARITY
	return true
}

proc update_PARAM_VALUE.p_START_BITS { PARAM_VALUE.p_START_BITS } {
	# Procedure called to update p_START_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.p_START_BITS { PARAM_VALUE.p_START_BITS } {
	# Procedure called to validate p_START_BITS
	return true
}

proc update_PARAM_VALUE.p_STOP_BITS { PARAM_VALUE.p_STOP_BITS } {
	# Procedure called to update p_STOP_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.p_STOP_BITS { PARAM_VALUE.p_STOP_BITS } {
	# Procedure called to validate p_STOP_BITS
	return true
}

proc update_PARAM_VALUE.p_UART_BITS { PARAM_VALUE.p_UART_BITS } {
	# Procedure called to update p_UART_BITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.p_UART_BITS { PARAM_VALUE.p_UART_BITS } {
	# Procedure called to validate p_UART_BITS
	return true
}


proc update_MODELPARAM_VALUE.p_UART_BITS { MODELPARAM_VALUE.p_UART_BITS PARAM_VALUE.p_UART_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.p_UART_BITS}] ${MODELPARAM_VALUE.p_UART_BITS}
}

proc update_MODELPARAM_VALUE.p_CHECK_PARITY { MODELPARAM_VALUE.p_CHECK_PARITY PARAM_VALUE.p_CHECK_PARITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.p_CHECK_PARITY}] ${MODELPARAM_VALUE.p_CHECK_PARITY}
}

proc update_MODELPARAM_VALUE.p_START_BITS { MODELPARAM_VALUE.p_START_BITS PARAM_VALUE.p_START_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.p_START_BITS}] ${MODELPARAM_VALUE.p_START_BITS}
}

proc update_MODELPARAM_VALUE.p_STOP_BITS { MODELPARAM_VALUE.p_STOP_BITS PARAM_VALUE.p_STOP_BITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.p_STOP_BITS}] ${MODELPARAM_VALUE.p_STOP_BITS}
}

proc update_MODELPARAM_VALUE.p_PARITY { MODELPARAM_VALUE.p_PARITY PARAM_VALUE.p_PARITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.p_PARITY}] ${MODELPARAM_VALUE.p_PARITY}
}

