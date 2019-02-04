# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "PWM_RES" -parent ${Page_0}


}

proc update_PARAM_VALUE.PWM_RES { PARAM_VALUE.PWM_RES } {
	# Procedure called to update PWM_RES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PWM_RES { PARAM_VALUE.PWM_RES } {
	# Procedure called to validate PWM_RES
	return true
}


proc update_MODELPARAM_VALUE.PWM_RES { MODELPARAM_VALUE.PWM_RES PARAM_VALUE.PWM_RES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PWM_RES}] ${MODELPARAM_VALUE.PWM_RES}
}

