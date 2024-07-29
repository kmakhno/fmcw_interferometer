
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# blink_led

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART digilentinc.com:eclypse-z7:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir src/bd/

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:processing_system7:5.5\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:xlslice:1.0\
digilent.com:user:ZmodScopeController:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
blink_led\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: ADC_4x
proc create_hier_cell_ADC_4x { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_ADC_4x() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I ADC_InClk
  create_bd_pin -dir I ADC_SamplingClk
  create_bd_pin -dir I SysClk100
  create_bd_pin -dir O ZmodAdcClkIn_n_0
  create_bd_pin -dir O ZmodAdcClkIn_n_1
  create_bd_pin -dir O ZmodAdcClkIn_p_0
  create_bd_pin -dir O ZmodAdcClkIn_p_1
  create_bd_pin -dir I ZmodDcoClk_0
  create_bd_pin -dir I ZmodDcoClk_1
  create_bd_pin -dir I aRst_n
  create_bd_pin -dir O adc0_config_error
  create_bd_pin -dir O adc0_data_ovf
  create_bd_pin -dir O adc1_config_error
  create_bd_pin -dir O adc1_data_ovf
  create_bd_pin -dir O -from 63 -to 0 adc_data
  create_bd_pin -dir O -from 0 -to 0 adc_valid
  create_bd_pin -dir O -from 0 -to 0 adcs_init_done
  create_bd_pin -dir O -from 0 -to 0 adcs_relay_init_done
  create_bd_pin -dir O -from 0 -to 0 adcs_rst_done
  create_bd_pin -dir I -from 13 -to 0 dZmodADC_Data_0
  create_bd_pin -dir I -from 13 -to 0 dZmodADC_Data_1
  create_bd_pin -dir O iZmodSync_0
  create_bd_pin -dir O iZmodSync_1
  create_bd_pin -dir O sZmodADC_CS_0
  create_bd_pin -dir O sZmodADC_CS_1
  create_bd_pin -dir IO sZmodADC_SDIO_0
  create_bd_pin -dir IO sZmodADC_SDIO_1
  create_bd_pin -dir O sZmodADC_Sclk_0
  create_bd_pin -dir O sZmodADC_Sclk_1
  create_bd_pin -dir O sZmodCh1CouplingH_0
  create_bd_pin -dir O sZmodCh1CouplingH_1
  create_bd_pin -dir O sZmodCh1CouplingL_0
  create_bd_pin -dir O sZmodCh1CouplingL_1
  create_bd_pin -dir O sZmodCh1GainH_0
  create_bd_pin -dir O sZmodCh1GainH_1
  create_bd_pin -dir O sZmodCh1GainL_0
  create_bd_pin -dir O sZmodCh1GainL_1
  create_bd_pin -dir O sZmodCh2CouplingH_0
  create_bd_pin -dir O sZmodCh2CouplingH_1
  create_bd_pin -dir O sZmodCh2CouplingL_0
  create_bd_pin -dir O sZmodCh2CouplingL_1
  create_bd_pin -dir O sZmodCh2GainH_0
  create_bd_pin -dir O sZmodCh2GainH_1
  create_bd_pin -dir O sZmodCh2GainL_0
  create_bd_pin -dir O sZmodCh2GainL_1
  create_bd_pin -dir O sZmodRelayComH_0
  create_bd_pin -dir O sZmodRelayComH_1
  create_bd_pin -dir O sZmodRelayComL_0
  create_bd_pin -dir O sZmodRelayComL_1

  # Create instance: ADC0_1_DATA, and set properties
  set ADC0_1_DATA [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 ADC0_1_DATA ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $ADC0_1_DATA

  # Create instance: ADC0_CH1, and set properties
  set ADC0_CH1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ADC0_CH1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {16} \
 ] $ADC0_CH1

  # Create instance: ADC0_CH2, and set properties
  set ADC0_CH2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ADC0_CH2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DOUT_WIDTH {16} \
 ] $ADC0_CH2

  # Create instance: ADC1_CH1, and set properties
  set ADC1_CH1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ADC1_CH1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {16} \
 ] $ADC1_CH1

  # Create instance: ADC1_CH2, and set properties
  set ADC1_CH2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 ADC1_CH2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DOUT_WIDTH {16} \
 ] $ADC1_CH2

  # Create instance: ZmodScopeController_0, and set properties
  set ZmodScopeController_0 [ create_bd_cell -type ip -vlnv digilent.com:user:ZmodScopeController:1.0 ZmodScopeController_0 ]
  set_property -dict [ list \
   CONFIG.kADC_ClkDiv {1} \
   CONFIG.kCh1CouplingStatic {"1"} \
   CONFIG.kCh1GainStatic {"1"} \
   CONFIG.kCh2CouplingStatic {"1"} \
   CONFIG.kCh2GainStatic {"1"} \
   CONFIG.kExtCalibEn {false} \
   CONFIG.kExtRelayConfigEn {false} \
 ] $ZmodScopeController_0

  # Create instance: ZmodScopeController_1, and set properties
  set ZmodScopeController_1 [ create_bd_cell -type ip -vlnv digilent.com:user:ZmodScopeController:1.0 ZmodScopeController_1 ]
  set_property -dict [ list \
   CONFIG.kADC_ClkDiv {1} \
   CONFIG.kCh1CouplingStatic {"1"} \
   CONFIG.kCh1GainStatic {"1"} \
   CONFIG.kCh2CouplingStatic {"1"} \
   CONFIG.kCh2GainStatic {"1"} \
   CONFIG.kExtCalibEn {false} \
   CONFIG.kExtRelayConfigEn {false} \
   CONFIG.kExtSyncEn {false} \
 ] $ZmodScopeController_1

  # Create instance: adcs_initi_done, and set properties
  set adcs_initi_done [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 adcs_initi_done ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $adcs_initi_done

  # Create instance: adcs_relay_init_done, and set properties
  set adcs_relay_init_done [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 adcs_relay_init_done ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $adcs_relay_init_done

  # Create instance: adcs_rst_done, and set properties
  set adcs_rst_done [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 adcs_rst_done ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $adcs_rst_done

  # Create instance: one, and set properties
  set one [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 one ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_2

  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_3

  # Create port connections
  connect_bd_net -net ADC0_1_DATA_dout [get_bd_pins adc_data] [get_bd_pins ADC0_1_DATA/dout]
  connect_bd_net -net ADC0_CH1_Dout [get_bd_pins ADC0_1_DATA/In0] [get_bd_pins ADC0_CH1/Dout]
  connect_bd_net -net ADC0_CH2_Dout [get_bd_pins ADC0_1_DATA/In1] [get_bd_pins ADC0_CH2/Dout]
  connect_bd_net -net ADC1_CH1_Dout [get_bd_pins ADC0_1_DATA/In2] [get_bd_pins ADC1_CH1/Dout]
  connect_bd_net -net ADC1_CH2_Dout [get_bd_pins ADC0_1_DATA/In3] [get_bd_pins ADC1_CH2/Dout]
  connect_bd_net -net Net [get_bd_pins SysClk100] [get_bd_pins ZmodScopeController_0/SysClk100] [get_bd_pins ZmodScopeController_1/SysClk100]
  connect_bd_net -net Net1 [get_bd_pins ADC_SamplingClk] [get_bd_pins ZmodScopeController_0/ADC_SamplingClk] [get_bd_pins ZmodScopeController_1/ADC_SamplingClk]
  connect_bd_net -net Net2 [get_bd_pins ADC_InClk] [get_bd_pins ZmodScopeController_0/ADC_InClk] [get_bd_pins ZmodScopeController_1/ADC_InClk]
  connect_bd_net -net Net3 [get_bd_pins aRst_n] [get_bd_pins ZmodScopeController_0/aRst_n] [get_bd_pins ZmodScopeController_1/aRst_n]
  connect_bd_net -net Net4 [get_bd_pins ZmodScopeController_0/cDataAxisTready] [get_bd_pins ZmodScopeController_0/sTestMode] [get_bd_pins ZmodScopeController_1/cDataAxisTready] [get_bd_pins ZmodScopeController_1/sTestMode] [get_bd_pins one/dout]
  connect_bd_net -net Net5 [get_bd_pins sZmodADC_SDIO_0] [get_bd_pins ZmodScopeController_0/sZmodADC_SDIO]
  connect_bd_net -net Net6 [get_bd_pins sZmodADC_SDIO_1] [get_bd_pins ZmodScopeController_1/sZmodADC_SDIO]
  connect_bd_net -net ZmodDcoClk_0_1 [get_bd_pins ZmodDcoClk_0] [get_bd_pins ZmodScopeController_0/ZmodDcoClk]
  connect_bd_net -net ZmodDcoClk_1_1 [get_bd_pins ZmodDcoClk_1] [get_bd_pins ZmodScopeController_1/ZmodDcoClk]
  connect_bd_net -net ZmodScopeController_0_ZmodAdcClkIn_n [get_bd_pins ZmodAdcClkIn_n_0] [get_bd_pins ZmodScopeController_0/ZmodAdcClkIn_n]
  connect_bd_net -net ZmodScopeController_0_ZmodAdcClkIn_p [get_bd_pins ZmodAdcClkIn_p_0] [get_bd_pins ZmodScopeController_0/ZmodAdcClkIn_p]
  connect_bd_net -net ZmodScopeController_0_cDataAxisTdata [get_bd_pins ADC0_CH1/Din] [get_bd_pins ADC0_CH2/Din] [get_bd_pins ZmodScopeController_0/cDataAxisTdata]
  connect_bd_net -net ZmodScopeController_0_cDataAxisTvalid [get_bd_pins ZmodScopeController_0/cDataAxisTvalid] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net ZmodScopeController_0_iZmodSync [get_bd_pins iZmodSync_0] [get_bd_pins ZmodScopeController_0/iZmodSync]
  connect_bd_net -net ZmodScopeController_0_sConfigError [get_bd_pins adc0_config_error] [get_bd_pins ZmodScopeController_0/sConfigError]
  connect_bd_net -net ZmodScopeController_0_sDataOverflow [get_bd_pins adc1_data_ovf] [get_bd_pins ZmodScopeController_0/sDataOverflow]
  connect_bd_net -net ZmodScopeController_0_sInitDoneADC [get_bd_pins ZmodScopeController_0/sInitDoneADC] [get_bd_pins adcs_initi_done/Op2]
  connect_bd_net -net ZmodScopeController_0_sInitDoneRelay [get_bd_pins ZmodScopeController_0/sInitDoneRelay] [get_bd_pins adcs_relay_init_done/Op2]
  connect_bd_net -net ZmodScopeController_0_sRstBusy [get_bd_pins ZmodScopeController_0/sRstBusy] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net ZmodScopeController_0_sZmodADC_CS [get_bd_pins sZmodADC_CS_0] [get_bd_pins ZmodScopeController_0/sZmodADC_CS]
  connect_bd_net -net ZmodScopeController_0_sZmodADC_Sclk [get_bd_pins sZmodADC_Sclk_0] [get_bd_pins ZmodScopeController_0/sZmodADC_Sclk]
  connect_bd_net -net ZmodScopeController_0_sZmodCh1CouplingH [get_bd_pins sZmodCh1CouplingH_0] [get_bd_pins ZmodScopeController_0/sZmodCh1CouplingH]
  connect_bd_net -net ZmodScopeController_0_sZmodCh1CouplingL [get_bd_pins sZmodCh1CouplingL_0] [get_bd_pins ZmodScopeController_0/sZmodCh1CouplingL]
  connect_bd_net -net ZmodScopeController_0_sZmodCh1GainH [get_bd_pins sZmodCh1GainH_0] [get_bd_pins ZmodScopeController_0/sZmodCh1GainH]
  connect_bd_net -net ZmodScopeController_0_sZmodCh1GainL [get_bd_pins sZmodCh1GainL_0] [get_bd_pins ZmodScopeController_0/sZmodCh1GainL]
  connect_bd_net -net ZmodScopeController_0_sZmodCh2CouplingH [get_bd_pins sZmodCh2CouplingH_0] [get_bd_pins ZmodScopeController_0/sZmodCh2CouplingH]
  connect_bd_net -net ZmodScopeController_0_sZmodCh2CouplingL [get_bd_pins sZmodCh2CouplingL_0] [get_bd_pins ZmodScopeController_0/sZmodCh2CouplingL]
  connect_bd_net -net ZmodScopeController_0_sZmodCh2GainH [get_bd_pins sZmodCh2GainH_0] [get_bd_pins ZmodScopeController_0/sZmodCh2GainH]
  connect_bd_net -net ZmodScopeController_0_sZmodCh2GainL [get_bd_pins sZmodCh2GainL_0] [get_bd_pins ZmodScopeController_0/sZmodCh2GainL]
  connect_bd_net -net ZmodScopeController_0_sZmodRelayComH [get_bd_pins sZmodRelayComH_0] [get_bd_pins ZmodScopeController_0/sZmodRelayComH]
  connect_bd_net -net ZmodScopeController_0_sZmodRelayComL [get_bd_pins sZmodRelayComL_0] [get_bd_pins ZmodScopeController_0/sZmodRelayComL]
  connect_bd_net -net ZmodScopeController_1_ZmodAdcClkIn_n [get_bd_pins ZmodAdcClkIn_n_1] [get_bd_pins ZmodScopeController_1/ZmodAdcClkIn_n]
  connect_bd_net -net ZmodScopeController_1_ZmodAdcClkIn_p [get_bd_pins ZmodAdcClkIn_p_1] [get_bd_pins ZmodScopeController_1/ZmodAdcClkIn_p]
  connect_bd_net -net ZmodScopeController_1_cDataAxisTdata [get_bd_pins ADC1_CH1/Din] [get_bd_pins ADC1_CH2/Din] [get_bd_pins ZmodScopeController_1/cDataAxisTdata]
  connect_bd_net -net ZmodScopeController_1_cDataAxisTvalid [get_bd_pins ZmodScopeController_1/cDataAxisTvalid] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net ZmodScopeController_1_iZmodSync [get_bd_pins iZmodSync_1] [get_bd_pins ZmodScopeController_1/iZmodSync]
  connect_bd_net -net ZmodScopeController_1_sConfigError [get_bd_pins adc1_config_error] [get_bd_pins ZmodScopeController_1/sConfigError]
  connect_bd_net -net ZmodScopeController_1_sDataOverflow [get_bd_pins adc0_data_ovf] [get_bd_pins ZmodScopeController_1/sDataOverflow]
  connect_bd_net -net ZmodScopeController_1_sInitDoneADC [get_bd_pins ZmodScopeController_1/sInitDoneADC] [get_bd_pins adcs_initi_done/Op1]
  connect_bd_net -net ZmodScopeController_1_sInitDoneRelay [get_bd_pins ZmodScopeController_1/sInitDoneRelay] [get_bd_pins adcs_relay_init_done/Op1]
  connect_bd_net -net ZmodScopeController_1_sRstBusy [get_bd_pins ZmodScopeController_1/sRstBusy] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net ZmodScopeController_1_sZmodADC_CS [get_bd_pins sZmodADC_CS_1] [get_bd_pins ZmodScopeController_1/sZmodADC_CS]
  connect_bd_net -net ZmodScopeController_1_sZmodADC_Sclk [get_bd_pins sZmodADC_Sclk_1] [get_bd_pins ZmodScopeController_1/sZmodADC_Sclk]
  connect_bd_net -net ZmodScopeController_1_sZmodCh1CouplingH [get_bd_pins sZmodCh1CouplingH_1] [get_bd_pins ZmodScopeController_1/sZmodCh1CouplingH]
  connect_bd_net -net ZmodScopeController_1_sZmodCh1CouplingL [get_bd_pins sZmodCh1CouplingL_1] [get_bd_pins ZmodScopeController_1/sZmodCh1CouplingL]
  connect_bd_net -net ZmodScopeController_1_sZmodCh1GainH [get_bd_pins sZmodCh1GainH_1] [get_bd_pins ZmodScopeController_1/sZmodCh1GainH]
  connect_bd_net -net ZmodScopeController_1_sZmodCh1GainL [get_bd_pins sZmodCh1GainL_1] [get_bd_pins ZmodScopeController_1/sZmodCh1GainL]
  connect_bd_net -net ZmodScopeController_1_sZmodCh2CouplingH [get_bd_pins sZmodCh2CouplingH_1] [get_bd_pins ZmodScopeController_1/sZmodCh2CouplingH]
  connect_bd_net -net ZmodScopeController_1_sZmodCh2CouplingL [get_bd_pins sZmodCh2CouplingL_1] [get_bd_pins ZmodScopeController_1/sZmodCh2CouplingL]
  connect_bd_net -net ZmodScopeController_1_sZmodCh2GainH [get_bd_pins sZmodCh2GainH_1] [get_bd_pins ZmodScopeController_1/sZmodCh2GainH]
  connect_bd_net -net ZmodScopeController_1_sZmodCh2GainL [get_bd_pins sZmodCh2GainL_1] [get_bd_pins ZmodScopeController_1/sZmodCh2GainL]
  connect_bd_net -net ZmodScopeController_1_sZmodRelayComH [get_bd_pins sZmodRelayComH_1] [get_bd_pins ZmodScopeController_1/sZmodRelayComH]
  connect_bd_net -net ZmodScopeController_1_sZmodRelayComL [get_bd_pins sZmodRelayComL_1] [get_bd_pins ZmodScopeController_1/sZmodRelayComL]
  connect_bd_net -net adcs_initi_done_Res [get_bd_pins adcs_init_done] [get_bd_pins adcs_initi_done/Res]
  connect_bd_net -net adcs_rst_done_Res [get_bd_pins adcs_rst_done] [get_bd_pins adcs_rst_done/Res]
  connect_bd_net -net dZmodADC_Data_0_1 [get_bd_pins dZmodADC_Data_0] [get_bd_pins ZmodScopeController_0/dZmodADC_Data]
  connect_bd_net -net dZmodADC_Data_1_1 [get_bd_pins dZmodADC_Data_1] [get_bd_pins ZmodScopeController_1/dZmodADC_Data]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins adc_valid] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins adcs_relay_init_done] [get_bd_pins adcs_relay_init_done/Res]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins adcs_rst_done/Op2] [get_bd_pins util_vector_logic_2/Res]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins adcs_rst_done/Op1] [get_bd_pins util_vector_logic_3/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]

  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]


  # Create ports
  set ZmodAdcClkIn_n_0 [ create_bd_port -dir O ZmodAdcClkIn_n_0 ]
  set ZmodAdcClkIn_n_1 [ create_bd_port -dir O ZmodAdcClkIn_n_1 ]
  set ZmodAdcClkIn_p_0 [ create_bd_port -dir O ZmodAdcClkIn_p_0 ]
  set ZmodAdcClkIn_p_1 [ create_bd_port -dir O ZmodAdcClkIn_p_1 ]
  set ZmodDcoClk_0 [ create_bd_port -dir I ZmodDcoClk_0 ]
  set ZmodDcoClk_1 [ create_bd_port -dir I ZmodDcoClk_1 ]
  set dZmodADC_Data_0 [ create_bd_port -dir I -from 13 -to 0 dZmodADC_Data_0 ]
  set dZmodADC_Data_1 [ create_bd_port -dir I -from 13 -to 0 dZmodADC_Data_1 ]
  set iZmodSync_0 [ create_bd_port -dir O iZmodSync_0 ]
  set iZmodSync_1 [ create_bd_port -dir O iZmodSync_1 ]
  set sZmodADC_CS_0 [ create_bd_port -dir O sZmodADC_CS_0 ]
  set sZmodADC_CS_1 [ create_bd_port -dir O sZmodADC_CS_1 ]
  set sZmodADC_SDIO_0 [ create_bd_port -dir IO sZmodADC_SDIO_0 ]
  set sZmodADC_SDIO_1 [ create_bd_port -dir IO sZmodADC_SDIO_1 ]
  set sZmodADC_Sclk_0 [ create_bd_port -dir O sZmodADC_Sclk_0 ]
  set sZmodADC_Sclk_1 [ create_bd_port -dir O sZmodADC_Sclk_1 ]
  set sZmodCh1CouplingH_0 [ create_bd_port -dir O sZmodCh1CouplingH_0 ]
  set sZmodCh1CouplingH_1 [ create_bd_port -dir O sZmodCh1CouplingH_1 ]
  set sZmodCh1CouplingL_0 [ create_bd_port -dir O sZmodCh1CouplingL_0 ]
  set sZmodCh1CouplingL_1 [ create_bd_port -dir O sZmodCh1CouplingL_1 ]
  set sZmodCh1GainH_0 [ create_bd_port -dir O sZmodCh1GainH_0 ]
  set sZmodCh1GainH_1 [ create_bd_port -dir O sZmodCh1GainH_1 ]
  set sZmodCh1GainL_0 [ create_bd_port -dir O sZmodCh1GainL_0 ]
  set sZmodCh1GainL_1 [ create_bd_port -dir O sZmodCh1GainL_1 ]
  set sZmodCh2CouplingH_0 [ create_bd_port -dir O sZmodCh2CouplingH_0 ]
  set sZmodCh2CouplingH_1 [ create_bd_port -dir O sZmodCh2CouplingH_1 ]
  set sZmodCh2CouplingL_0 [ create_bd_port -dir O sZmodCh2CouplingL_0 ]
  set sZmodCh2CouplingL_1 [ create_bd_port -dir O sZmodCh2CouplingL_1 ]
  set sZmodCh2GainH_0 [ create_bd_port -dir O sZmodCh2GainH_0 ]
  set sZmodCh2GainH_1 [ create_bd_port -dir O sZmodCh2GainH_1 ]
  set sZmodCh2GainL_0 [ create_bd_port -dir O sZmodCh2GainL_0 ]
  set sZmodCh2GainL_1 [ create_bd_port -dir O sZmodCh2GainL_1 ]
  set sZmodRelayComH_0 [ create_bd_port -dir O sZmodRelayComH_0 ]
  set sZmodRelayComH_1 [ create_bd_port -dir O sZmodRelayComH_1 ]
  set sZmodRelayComL_0 [ create_bd_port -dir O sZmodRelayComL_0 ]
  set sZmodRelayComL_1 [ create_bd_port -dir O sZmodRelayComL_1 ]
  set sys_clk_led [ create_bd_port -dir O sys_clk_led ]

  # Create instance: ADC_4x
  create_hier_cell_ADC_4x [current_bd_instance .] ADC_4x

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_GPIO2_WIDTH {1} \
   CONFIG.C_GPIO_WIDTH {7} \
   CONFIG.C_IS_DUAL {1} \
   CONFIG.GPIO2_BOARD_INTERFACE {Custom} \
   CONFIG.GPIO_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_0

  # Create instance: blink_led, and set properties
  set block_name blink_led
  set block_cell_name blink_led
  if { [catch {set blink_led [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $blink_led eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
   CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {666.666687} \
   CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
   CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
   CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
   CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
   CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
   CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
   CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_CLK0_FREQ {100000000} \
   CONFIG.PCW_CLK1_FREQ {10000000} \
   CONFIG.PCW_CLK2_FREQ {10000000} \
   CONFIG.PCW_CLK3_FREQ {10000000} \
   CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
   CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
   CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
   CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
   CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
   CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
   CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
   CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
   CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
   CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
   CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
   CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
   CONFIG.PCW_ENET0_RESET_ENABLE {1} \
   CONFIG.PCW_ENET0_RESET_IO {MIO 9} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_ENET1_RESET_ENABLE {0} \
   CONFIG.PCW_ENET_RESET_ENABLE {1} \
   CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
   CONFIG.PCW_EN_EMIO_CD_SDIO0 {0} \
   CONFIG.PCW_EN_EMIO_ENET0 {0} \
   CONFIG.PCW_EN_EMIO_I2C1 {0} \
   CONFIG.PCW_EN_EMIO_UART0 {0} \
   CONFIG.PCW_EN_ENET0 {1} \
   CONFIG.PCW_EN_GPIO {1} \
   CONFIG.PCW_EN_I2C1 {0} \
   CONFIG.PCW_EN_QSPI {1} \
   CONFIG.PCW_EN_SDIO0 {1} \
   CONFIG.PCW_EN_UART0 {1} \
   CONFIG.PCW_EN_USB0 {0} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
   CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
   CONFIG.PCW_FPGA_FCLK1_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK2_ENABLE {0} \
   CONFIG.PCW_FPGA_FCLK3_ENABLE {0} \
   CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
   CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
   CONFIG.PCW_I2C0_RESET_ENABLE {0} \
   CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
   CONFIG.PCW_I2C1_I2C1_IO {<Select>} \
   CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_I2C1_RESET_ENABLE {0} \
   CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {111.111115} \
   CONFIG.PCW_I2C_RESET_ENABLE {1} \
   CONFIG.PCW_I2C_RESET_SELECT {<Select>} \
   CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
   CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
   CONFIG.PCW_MIO_0_DIRECTION {inout} \
   CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_0_PULLUP {enabled} \
   CONFIG.PCW_MIO_0_SLEW {slow} \
   CONFIG.PCW_MIO_10_DIRECTION {inout} \
   CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_10_PULLUP {disabled} \
   CONFIG.PCW_MIO_10_SLEW {slow} \
   CONFIG.PCW_MIO_11_DIRECTION {inout} \
   CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_11_PULLUP {disabled} \
   CONFIG.PCW_MIO_11_SLEW {slow} \
   CONFIG.PCW_MIO_12_DIRECTION {inout} \
   CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_12_PULLUP {enabled} \
   CONFIG.PCW_MIO_12_SLEW {slow} \
   CONFIG.PCW_MIO_13_DIRECTION {inout} \
   CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_13_PULLUP {enabled} \
   CONFIG.PCW_MIO_13_SLEW {slow} \
   CONFIG.PCW_MIO_14_DIRECTION {in} \
   CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_14_PULLUP {enabled} \
   CONFIG.PCW_MIO_14_SLEW {slow} \
   CONFIG.PCW_MIO_15_DIRECTION {out} \
   CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_15_PULLUP {enabled} \
   CONFIG.PCW_MIO_15_SLEW {slow} \
   CONFIG.PCW_MIO_16_DIRECTION {out} \
   CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_16_PULLUP {enabled} \
   CONFIG.PCW_MIO_16_SLEW {fast} \
   CONFIG.PCW_MIO_17_DIRECTION {out} \
   CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_17_PULLUP {enabled} \
   CONFIG.PCW_MIO_17_SLEW {fast} \
   CONFIG.PCW_MIO_18_DIRECTION {out} \
   CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_18_PULLUP {enabled} \
   CONFIG.PCW_MIO_18_SLEW {fast} \
   CONFIG.PCW_MIO_19_DIRECTION {out} \
   CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_19_PULLUP {enabled} \
   CONFIG.PCW_MIO_19_SLEW {fast} \
   CONFIG.PCW_MIO_1_DIRECTION {out} \
   CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_1_PULLUP {enabled} \
   CONFIG.PCW_MIO_1_SLEW {slow} \
   CONFIG.PCW_MIO_20_DIRECTION {out} \
   CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_20_PULLUP {enabled} \
   CONFIG.PCW_MIO_20_SLEW {fast} \
   CONFIG.PCW_MIO_21_DIRECTION {out} \
   CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_21_PULLUP {enabled} \
   CONFIG.PCW_MIO_21_SLEW {fast} \
   CONFIG.PCW_MIO_22_DIRECTION {in} \
   CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_22_PULLUP {enabled} \
   CONFIG.PCW_MIO_22_SLEW {fast} \
   CONFIG.PCW_MIO_23_DIRECTION {in} \
   CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_23_PULLUP {enabled} \
   CONFIG.PCW_MIO_23_SLEW {fast} \
   CONFIG.PCW_MIO_24_DIRECTION {in} \
   CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_24_PULLUP {enabled} \
   CONFIG.PCW_MIO_24_SLEW {fast} \
   CONFIG.PCW_MIO_25_DIRECTION {in} \
   CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_25_PULLUP {enabled} \
   CONFIG.PCW_MIO_25_SLEW {fast} \
   CONFIG.PCW_MIO_26_DIRECTION {in} \
   CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_26_PULLUP {enabled} \
   CONFIG.PCW_MIO_26_SLEW {fast} \
   CONFIG.PCW_MIO_27_DIRECTION {in} \
   CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_27_PULLUP {enabled} \
   CONFIG.PCW_MIO_27_SLEW {fast} \
   CONFIG.PCW_MIO_28_DIRECTION {inout} \
   CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_28_PULLUP {enabled} \
   CONFIG.PCW_MIO_28_SLEW {fast} \
   CONFIG.PCW_MIO_29_DIRECTION {inout} \
   CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_29_PULLUP {enabled} \
   CONFIG.PCW_MIO_29_SLEW {fast} \
   CONFIG.PCW_MIO_2_DIRECTION {inout} \
   CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_2_PULLUP {disabled} \
   CONFIG.PCW_MIO_2_SLEW {slow} \
   CONFIG.PCW_MIO_30_DIRECTION {inout} \
   CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_30_PULLUP {enabled} \
   CONFIG.PCW_MIO_30_SLEW {fast} \
   CONFIG.PCW_MIO_31_DIRECTION {inout} \
   CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_31_PULLUP {enabled} \
   CONFIG.PCW_MIO_31_SLEW {fast} \
   CONFIG.PCW_MIO_32_DIRECTION {inout} \
   CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_32_PULLUP {enabled} \
   CONFIG.PCW_MIO_32_SLEW {fast} \
   CONFIG.PCW_MIO_33_DIRECTION {inout} \
   CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_33_PULLUP {enabled} \
   CONFIG.PCW_MIO_33_SLEW {fast} \
   CONFIG.PCW_MIO_34_DIRECTION {inout} \
   CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_34_PULLUP {enabled} \
   CONFIG.PCW_MIO_34_SLEW {fast} \
   CONFIG.PCW_MIO_35_DIRECTION {inout} \
   CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_35_PULLUP {enabled} \
   CONFIG.PCW_MIO_35_SLEW {fast} \
   CONFIG.PCW_MIO_36_DIRECTION {inout} \
   CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_36_PULLUP {enabled} \
   CONFIG.PCW_MIO_36_SLEW {fast} \
   CONFIG.PCW_MIO_37_DIRECTION {inout} \
   CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_37_PULLUP {enabled} \
   CONFIG.PCW_MIO_37_SLEW {fast} \
   CONFIG.PCW_MIO_38_DIRECTION {inout} \
   CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_38_PULLUP {enabled} \
   CONFIG.PCW_MIO_38_SLEW {fast} \
   CONFIG.PCW_MIO_39_DIRECTION {inout} \
   CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_39_PULLUP {enabled} \
   CONFIG.PCW_MIO_39_SLEW {fast} \
   CONFIG.PCW_MIO_3_DIRECTION {inout} \
   CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_3_PULLUP {disabled} \
   CONFIG.PCW_MIO_3_SLEW {slow} \
   CONFIG.PCW_MIO_40_DIRECTION {inout} \
   CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_40_PULLUP {enabled} \
   CONFIG.PCW_MIO_40_SLEW {slow} \
   CONFIG.PCW_MIO_41_DIRECTION {inout} \
   CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_41_PULLUP {enabled} \
   CONFIG.PCW_MIO_41_SLEW {slow} \
   CONFIG.PCW_MIO_42_DIRECTION {inout} \
   CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_42_PULLUP {enabled} \
   CONFIG.PCW_MIO_42_SLEW {slow} \
   CONFIG.PCW_MIO_43_DIRECTION {inout} \
   CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_43_PULLUP {enabled} \
   CONFIG.PCW_MIO_43_SLEW {slow} \
   CONFIG.PCW_MIO_44_DIRECTION {inout} \
   CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_44_PULLUP {enabled} \
   CONFIG.PCW_MIO_44_SLEW {slow} \
   CONFIG.PCW_MIO_45_DIRECTION {inout} \
   CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_45_PULLUP {enabled} \
   CONFIG.PCW_MIO_45_SLEW {slow} \
   CONFIG.PCW_MIO_46_DIRECTION {out} \
   CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_46_PULLUP {enabled} \
   CONFIG.PCW_MIO_46_SLEW {slow} \
   CONFIG.PCW_MIO_47_DIRECTION {in} \
   CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_47_PULLUP {enabled} \
   CONFIG.PCW_MIO_47_SLEW {slow} \
   CONFIG.PCW_MIO_48_DIRECTION {inout} \
   CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_48_PULLUP {enabled} \
   CONFIG.PCW_MIO_48_SLEW {slow} \
   CONFIG.PCW_MIO_49_DIRECTION {inout} \
   CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_49_PULLUP {enabled} \
   CONFIG.PCW_MIO_49_SLEW {slow} \
   CONFIG.PCW_MIO_4_DIRECTION {inout} \
   CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_4_PULLUP {disabled} \
   CONFIG.PCW_MIO_4_SLEW {slow} \
   CONFIG.PCW_MIO_50_DIRECTION {inout} \
   CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_50_PULLUP {enabled} \
   CONFIG.PCW_MIO_50_SLEW {slow} \
   CONFIG.PCW_MIO_51_DIRECTION {inout} \
   CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_51_PULLUP {enabled} \
   CONFIG.PCW_MIO_51_SLEW {slow} \
   CONFIG.PCW_MIO_52_DIRECTION {out} \
   CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_52_PULLUP {enabled} \
   CONFIG.PCW_MIO_52_SLEW {slow} \
   CONFIG.PCW_MIO_53_DIRECTION {inout} \
   CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
   CONFIG.PCW_MIO_53_PULLUP {enabled} \
   CONFIG.PCW_MIO_53_SLEW {slow} \
   CONFIG.PCW_MIO_5_DIRECTION {inout} \
   CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_5_PULLUP {disabled} \
   CONFIG.PCW_MIO_5_SLEW {slow} \
   CONFIG.PCW_MIO_6_DIRECTION {out} \
   CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_6_PULLUP {disabled} \
   CONFIG.PCW_MIO_6_SLEW {slow} \
   CONFIG.PCW_MIO_7_DIRECTION {out} \
   CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_7_PULLUP {disabled} \
   CONFIG.PCW_MIO_7_SLEW {slow} \
   CONFIG.PCW_MIO_8_DIRECTION {out} \
   CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_8_PULLUP {disabled} \
   CONFIG.PCW_MIO_8_SLEW {slow} \
   CONFIG.PCW_MIO_9_DIRECTION {out} \
   CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
   CONFIG.PCW_MIO_9_PULLUP {enabled} \
   CONFIG.PCW_MIO_9_SLEW {slow} \
   CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#Quad SPI Flash#ENET Reset#GPIO#GPIO#GPIO#GPIO#UART 0#UART 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#SD 0#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0} \
   CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]/HOLD_B#qspi0_sclk#gpio[7]#qspi_fbclk#reset#gpio[10]#gpio[11]#gpio[12]#gpio[13]#rx#tx#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#gpio[28]#gpio[29]#gpio[30]#gpio[31]#gpio[32]#gpio[33]#gpio[34]#gpio[35]#gpio[36]#gpio[37]#gpio[38]#gpio[39]#clk#cmd#data[0]#data[1]#data[2]#data[3]#gpio[46]#cd#gpio[48]#gpio[49]#gpio[50]#gpio[51]#mdc#mdio} \
   CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
   CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
   CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
   CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.311} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.311} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.304} \
   CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.304} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {0.202} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {0.202} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {0.029} \
   CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {0.031} \
   CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
   CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
   CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
   CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
   CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
   CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
   CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
   CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
   CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
   CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
   CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
   CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
   CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
   CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
   CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
   CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
   CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
   CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
   CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
   CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
   CONFIG.PCW_UART0_UART0_IO {MIO 14 .. 15} \
   CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {10} \
   CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
   CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
   CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
   CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
   CONFIG.PCW_UIPARAM_DDR_BL {8} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.311} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.311} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.304} \
   CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.304} \
   CONFIG.PCW_UIPARAM_DDR_CL {7} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {63.2909} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {63.2909} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {49.1639} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {49.1639} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
   CONFIG.PCW_UIPARAM_DDR_CWL {6} \
   CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
   CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {32.2611} \
   CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {32.2666} \
   CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {44.6376} \
   CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {44.3743} \
   CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.202} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.202} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.029} \
   CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.031} \
   CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {32.5236} \
   CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {32.3526} \
   CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {44.4929} \
   CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {44.4683} \
   CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {0} \
   CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {165.1} \
   CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
   CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3 (Low Voltage)} \
   CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
   CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
   CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
   CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
   CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
   CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
   CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
   CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
   CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
   CONFIG.PCW_USB0_RESET_ENABLE {1} \
   CONFIG.PCW_USB0_RESET_IO {MIO 46} \
   CONFIG.PCW_USB0_USB0_IO {<Select>} \
   CONFIG.PCW_USB1_RESET_ENABLE {0} \
   CONFIG.PCW_USB_RESET_ENABLE {1} \
   CONFIG.PCW_USB_RESET_SELECT {<Select>} \
   CONFIG.PCW_USE_M_AXI_GP0 {1} \
 ] $processing_system7_0

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_MON_TYPE {NATIVE} \
   CONFIG.C_NUM_OF_PROBES {2} \
   CONFIG.C_PROBE0_TYPE {0} \
   CONFIG.C_PROBE1_TYPE {0} \
 ] $system_ila_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {7} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net ADC_4x_ZmodAdcClkIn_n_0 [get_bd_ports ZmodAdcClkIn_n_0] [get_bd_pins ADC_4x/ZmodAdcClkIn_n_0]
  connect_bd_net -net ADC_4x_ZmodAdcClkIn_n_1 [get_bd_ports ZmodAdcClkIn_n_1] [get_bd_pins ADC_4x/ZmodAdcClkIn_n_1]
  connect_bd_net -net ADC_4x_ZmodAdcClkIn_p_0 [get_bd_ports ZmodAdcClkIn_p_0] [get_bd_pins ADC_4x/ZmodAdcClkIn_p_0]
  connect_bd_net -net ADC_4x_ZmodAdcClkIn_p_1 [get_bd_ports ZmodAdcClkIn_p_1] [get_bd_pins ADC_4x/ZmodAdcClkIn_p_1]
  connect_bd_net -net ADC_4x_adc0_config_error [get_bd_pins ADC_4x/adc0_config_error] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net ADC_4x_adc0_data_ovf [get_bd_pins ADC_4x/adc0_data_ovf] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net ADC_4x_adc1_config_error [get_bd_pins ADC_4x/adc1_config_error] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net ADC_4x_adc1_data_ovf [get_bd_pins ADC_4x/adc1_data_ovf] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net ADC_4x_adcs_init_done [get_bd_pins ADC_4x/adcs_init_done] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net ADC_4x_adcs_relay_init_done [get_bd_pins ADC_4x/adcs_relay_init_done] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net ADC_4x_adcs_rst_done [get_bd_pins ADC_4x/adcs_rst_done] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net ADC_4x_iZmodSync_0 [get_bd_ports iZmodSync_0] [get_bd_pins ADC_4x/iZmodSync_0]
  connect_bd_net -net ADC_4x_iZmodSync_1 [get_bd_ports iZmodSync_1] [get_bd_pins ADC_4x/iZmodSync_1]
  connect_bd_net -net ADC_4x_sZmodADC_CS_0 [get_bd_ports sZmodADC_CS_0] [get_bd_pins ADC_4x/sZmodADC_CS_0]
  connect_bd_net -net ADC_4x_sZmodADC_CS_1 [get_bd_ports sZmodADC_CS_1] [get_bd_pins ADC_4x/sZmodADC_CS_1]
  connect_bd_net -net ADC_4x_sZmodADC_Sclk_0 [get_bd_ports sZmodADC_Sclk_0] [get_bd_pins ADC_4x/sZmodADC_Sclk_0]
  connect_bd_net -net ADC_4x_sZmodADC_Sclk_1 [get_bd_ports sZmodADC_Sclk_1] [get_bd_pins ADC_4x/sZmodADC_Sclk_1]
  connect_bd_net -net ADC_4x_sZmodCh1CouplingH_0 [get_bd_ports sZmodCh1CouplingH_0] [get_bd_pins ADC_4x/sZmodCh1CouplingH_0]
  connect_bd_net -net ADC_4x_sZmodCh1CouplingH_1 [get_bd_ports sZmodCh1CouplingH_1] [get_bd_pins ADC_4x/sZmodCh1CouplingH_1]
  connect_bd_net -net ADC_4x_sZmodCh1CouplingL_0 [get_bd_ports sZmodCh1CouplingL_0] [get_bd_pins ADC_4x/sZmodCh1CouplingL_0]
  connect_bd_net -net ADC_4x_sZmodCh1CouplingL_1 [get_bd_ports sZmodCh1CouplingL_1] [get_bd_pins ADC_4x/sZmodCh1CouplingL_1]
  connect_bd_net -net ADC_4x_sZmodCh1GainH_0 [get_bd_ports sZmodCh1GainH_0] [get_bd_pins ADC_4x/sZmodCh1GainH_0]
  connect_bd_net -net ADC_4x_sZmodCh1GainH_1 [get_bd_ports sZmodCh1GainH_1] [get_bd_pins ADC_4x/sZmodCh1GainH_1]
  connect_bd_net -net ADC_4x_sZmodCh1GainL_0 [get_bd_ports sZmodCh1GainL_0] [get_bd_pins ADC_4x/sZmodCh1GainL_0]
  connect_bd_net -net ADC_4x_sZmodCh1GainL_1 [get_bd_ports sZmodCh1GainL_1] [get_bd_pins ADC_4x/sZmodCh1GainL_1]
  connect_bd_net -net ADC_4x_sZmodCh2CouplingH_0 [get_bd_ports sZmodCh2CouplingH_0] [get_bd_pins ADC_4x/sZmodCh2CouplingH_0]
  connect_bd_net -net ADC_4x_sZmodCh2CouplingH_1 [get_bd_ports sZmodCh2CouplingH_1] [get_bd_pins ADC_4x/sZmodCh2CouplingH_1]
  connect_bd_net -net ADC_4x_sZmodCh2CouplingL_0 [get_bd_ports sZmodCh2CouplingL_0] [get_bd_pins ADC_4x/sZmodCh2CouplingL_0]
  connect_bd_net -net ADC_4x_sZmodCh2CouplingL_1 [get_bd_ports sZmodCh2CouplingL_1] [get_bd_pins ADC_4x/sZmodCh2CouplingL_1]
  connect_bd_net -net ADC_4x_sZmodCh2GainH_0 [get_bd_ports sZmodCh2GainH_0] [get_bd_pins ADC_4x/sZmodCh2GainH_0]
  connect_bd_net -net ADC_4x_sZmodCh2GainH_1 [get_bd_ports sZmodCh2GainH_1] [get_bd_pins ADC_4x/sZmodCh2GainH_1]
  connect_bd_net -net ADC_4x_sZmodCh2GainL_0 [get_bd_ports sZmodCh2GainL_0] [get_bd_pins ADC_4x/sZmodCh2GainL_0]
  connect_bd_net -net ADC_4x_sZmodCh2GainL_1 [get_bd_ports sZmodCh2GainL_1] [get_bd_pins ADC_4x/sZmodCh2GainL_1]
  connect_bd_net -net ADC_4x_sZmodRelayComH_0 [get_bd_ports sZmodRelayComH_0] [get_bd_pins ADC_4x/sZmodRelayComH_0]
  connect_bd_net -net ADC_4x_sZmodRelayComH_1 [get_bd_ports sZmodRelayComH_1] [get_bd_pins ADC_4x/sZmodRelayComH_1]
  connect_bd_net -net ADC_4x_sZmodRelayComL_0 [get_bd_ports sZmodRelayComL_0] [get_bd_pins ADC_4x/sZmodRelayComL_0]
  connect_bd_net -net ADC_4x_sZmodRelayComL_1 [get_bd_ports sZmodRelayComL_1] [get_bd_pins ADC_4x/sZmodRelayComL_1]
  connect_bd_net -net Net [get_bd_ports sZmodADC_SDIO_0] [get_bd_pins ADC_4x/sZmodADC_SDIO_0]
  connect_bd_net -net Net1 [get_bd_ports sZmodADC_SDIO_1] [get_bd_pins ADC_4x/sZmodADC_SDIO_1]
  connect_bd_net -net ZmodDcoClk_0_0_1 [get_bd_ports ZmodDcoClk_0] [get_bd_pins ADC_4x/ZmodDcoClk_0]
  connect_bd_net -net ZmodDcoClk_1_0_1 [get_bd_ports ZmodDcoClk_1] [get_bd_pins ADC_4x/ZmodDcoClk_1]
  connect_bd_net -net adc_data [get_bd_pins ADC_4x/adc_data] [get_bd_pins system_ila_0/probe0]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets adc_data]
  connect_bd_net -net adc_valid [get_bd_pins ADC_4x/adc_valid] [get_bd_pins system_ila_0/probe1]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets adc_valid]
  connect_bd_net -net axi_gpio_0_gpio2_io_o [get_bd_pins ADC_4x/aRst_n] [get_bd_pins axi_gpio_0/gpio2_io_o]
  connect_bd_net -net blink_led_blink_o [get_bd_ports sys_clk_led] [get_bd_pins blink_led/blink_o]
  connect_bd_net -net dZmodADC_Data_0_0_1 [get_bd_ports dZmodADC_Data_0] [get_bd_pins ADC_4x/dZmodADC_Data_0]
  connect_bd_net -net dZmodADC_Data_1_0_1 [get_bd_ports dZmodADC_Data_1] [get_bd_pins ADC_4x/dZmodADC_Data_1]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins ADC_4x/ADC_InClk] [get_bd_pins ADC_4x/ADC_SamplingClk] [get_bd_pins ADC_4x/SysClk100] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins blink_led/clk_i] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/aux_reset_in] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_gpio_0/gpio_io_i] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.0.19  2019-03-26 bk=1.5019 VDI=41 GEI=35 GUI=JA:9.0 non-TLS
#  -string -flagsOSRD
preplace port DDR -pg 1 -lvl 6 -x 1800 -y 60 -defaultsOSRD
preplace port FIXED_IO -pg 1 -lvl 6 -x 1800 -y 80 -defaultsOSRD
preplace port ZmodDcoClk_1 -pg 1 -lvl 0 -x 0 -y 630 -defaultsOSRD
preplace port ZmodDcoClk_0 -pg 1 -lvl 0 -x 0 -y 610 -defaultsOSRD
preplace port ZmodAdcClkIn_p_1 -pg 1 -lvl 6 -x 1800 -y 160 -defaultsOSRD
preplace port ZmodAdcClkIn_n_0 -pg 1 -lvl 6 -x 1800 -y 120 -defaultsOSRD
preplace port ZmodAdcClkIn_p_0 -pg 1 -lvl 6 -x 1800 -y 100 -defaultsOSRD
preplace port ZmodAdcClkIn_n_1 -pg 1 -lvl 6 -x 1800 -y 140 -defaultsOSRD
preplace port iZmodSync_0 -pg 1 -lvl 6 -x 1800 -y 180 -defaultsOSRD
preplace port iZmodSync_1 -pg 1 -lvl 6 -x 1800 -y 200 -defaultsOSRD
preplace port sZmodCh2CouplingL_0 -pg 1 -lvl 6 -x 1800 -y 500 -defaultsOSRD
preplace port sZmodCh2CouplingH_0 -pg 1 -lvl 6 -x 1800 -y 480 -defaultsOSRD
preplace port sZmodCh1CouplingL_0 -pg 1 -lvl 6 -x 1800 -y 460 -defaultsOSRD
preplace port sZmodRelayComH_0 -pg 1 -lvl 6 -x 1800 -y 600 -defaultsOSRD
preplace port sZmodCh2GainL_0 -pg 1 -lvl 6 -x 1800 -y 580 -defaultsOSRD
preplace port sZmodCh2GainH_0 -pg 1 -lvl 6 -x 1800 -y 560 -defaultsOSRD
preplace port sZmodCh1GainL_0 -pg 1 -lvl 6 -x 1800 -y 540 -defaultsOSRD
preplace port sZmodCh1CouplingH_0 -pg 1 -lvl 6 -x 1800 -y 440 -defaultsOSRD
preplace port sZmodADC_Sclk_0 -pg 1 -lvl 6 -x 1800 -y 420 -defaultsOSRD
preplace port sZmodADC_CS_0 -pg 1 -lvl 6 -x 1800 -y 220 -defaultsOSRD
preplace port sZmodADC_SDIO_0 -pg 1 -lvl 6 -x 1800 -y 400 -defaultsOSRD
preplace port sZmodCh1GainH_0 -pg 1 -lvl 6 -x 1800 -y 520 -defaultsOSRD
preplace port sZmodRelayComL_0 -pg 1 -lvl 6 -x 1800 -y 620 -defaultsOSRD
preplace port sZmodRelayComH_1 -pg 1 -lvl 6 -x 1800 -y 860 -defaultsOSRD
preplace port sZmodCh2CouplingL_1 -pg 1 -lvl 6 -x 1800 -y 760 -defaultsOSRD
preplace port sZmodCh2CouplingH_1 -pg 1 -lvl 6 -x 1800 -y 740 -defaultsOSRD
preplace port sZmodADC_Sclk_1 -pg 1 -lvl 6 -x 1800 -y 680 -defaultsOSRD
preplace port sZmodCh1CouplingL_1 -pg 1 -lvl 6 -x 1800 -y 720 -defaultsOSRD
preplace port sZmodCh1CouplingH_1 -pg 1 -lvl 6 -x 1800 -y 700 -defaultsOSRD
preplace port sZmodADC_CS_1 -pg 1 -lvl 6 -x 1800 -y 660 -defaultsOSRD
preplace port sZmodADC_SDIO_1 -pg 1 -lvl 6 -x 1800 -y 640 -defaultsOSRD
preplace port sZmodCh2GainL_1 -pg 1 -lvl 6 -x 1800 -y 840 -defaultsOSRD
preplace port sZmodCh2GainH_1 -pg 1 -lvl 6 -x 1800 -y 820 -defaultsOSRD
preplace port sZmodCh1GainL_1 -pg 1 -lvl 6 -x 1800 -y 800 -defaultsOSRD
preplace port sZmodCh1GainH_1 -pg 1 -lvl 6 -x 1800 -y 780 -defaultsOSRD
preplace port sZmodRelayComL_1 -pg 1 -lvl 6 -x 1800 -y 880 -defaultsOSRD
preplace port sys_clk_led -pg 1 -lvl 6 -x 1800 -y 380 -defaultsOSRD
preplace portBus dZmodADC_Data_0 -pg 1 -lvl 0 -x 0 -y 650 -defaultsOSRD
preplace portBus dZmodADC_Data_1 -pg 1 -lvl 0 -x 0 -y 670 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 1 -x 230 -y 100 -defaultsOSRD
preplace inst ADC_4x -pg 1 -lvl 4 -x 1260 -y 620 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 3 -x 910 -y 220 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 1 -x 230 -y 310 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 2 -x 610 -y 200 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 5 -x 1650 -y 1010 -defaultsOSRD
preplace inst system_ila_0 -pg 1 -lvl 5 -x 1650 -y 260 -defaultsOSRD
preplace inst blink_led -pg 1 -lvl 5 -x 1650 -y 380 -defaultsOSRD
preplace netloc dZmodADC_Data_0_0_1 1 0 4 NJ 650 NJ 650 NJ 650 NJ
preplace netloc ZmodDcoClk_1_0_1 1 0 4 NJ 630 NJ 630 NJ 630 NJ
preplace netloc ZmodDcoClk_0_0_1 1 0 4 NJ 610 NJ 610 NJ 610 NJ
preplace netloc dZmodADC_Data_1_0_1 1 0 4 NJ 670 NJ 670 NJ 670 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 5 20 200 460 50 760 130 1060 160 1480
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 2 20 410 430
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 1 1 450 180n
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 1 2 440 40 770J
preplace netloc xlconcat_0_dout 1 3 3 1050 150 NJ 150 1750
preplace netloc ADC_4x_adcs_rst_done 1 4 1 1540 900n
preplace netloc ADC_4x_adcs_init_done 1 4 1 1530 920n
preplace netloc ADC_4x_adcs_relay_init_done 1 4 1 1520 940n
preplace netloc ADC_4x_adc0_config_error 1 4 1 1500 960n
preplace netloc ADC_4x_adc1_config_error 1 4 1 1480 980n
preplace netloc ADC_4x_adc0_data_ovf 1 4 1 1460 1000n
preplace netloc ADC_4x_adc1_data_ovf 1 4 1 1450 1020n
preplace netloc axi_gpio_0_gpio2_io_o 1 3 1 1050 250n
preplace netloc ADC_4x_ZmodAdcClkIn_p_1 1 4 2 1490J 160 NJ
preplace netloc ADC_4x_ZmodAdcClkIn_n_0 1 4 2 1460J 120 NJ
preplace netloc ADC_4x_ZmodAdcClkIn_p_0 1 4 2 1450J 100 NJ
preplace netloc ADC_4x_ZmodAdcClkIn_n_1 1 4 2 1470J 130 1780J
preplace netloc ADC_4x_iZmodSync_0 1 4 2 1510J 180 NJ
preplace netloc ADC_4x_iZmodSync_1 1 4 2 1500J 170 1760J
preplace netloc ADC_4x_sZmodCh2CouplingL_0 1 4 2 NJ 500 NJ
preplace netloc ADC_4x_sZmodCh2CouplingH_0 1 4 2 NJ 480 NJ
preplace netloc ADC_4x_sZmodCh1CouplingL_0 1 4 2 NJ 460 NJ
preplace netloc ADC_4x_sZmodRelayComH_0 1 4 2 NJ 600 NJ
preplace netloc ADC_4x_sZmodCh2GainL_0 1 4 2 NJ 580 NJ
preplace netloc ADC_4x_sZmodCh2GainH_0 1 4 2 NJ 560 NJ
preplace netloc ADC_4x_sZmodCh1GainL_0 1 4 2 NJ 540 NJ
preplace netloc ADC_4x_sZmodCh1CouplingH_0 1 4 2 1450J 450 1780J
preplace netloc ADC_4x_sZmodADC_Sclk_0 1 4 2 1510J 440 1760J
preplace netloc ADC_4x_sZmodADC_CS_0 1 4 2 1520J 140 1770J
preplace netloc Net 1 4 2 1460J 470 1770J
preplace netloc ADC_4x_sZmodCh1GainH_0 1 4 2 NJ 520 NJ
preplace netloc ADC_4x_sZmodRelayComL_0 1 4 2 NJ 620 NJ
preplace netloc ADC_4x_sZmodRelayComH_1 1 4 2 NJ 860 NJ
preplace netloc ADC_4x_sZmodCh2CouplingL_1 1 4 2 NJ 760 NJ
preplace netloc ADC_4x_sZmodCh2CouplingH_1 1 4 2 NJ 740 NJ
preplace netloc ADC_4x_sZmodADC_Sclk_1 1 4 2 NJ 680 NJ
preplace netloc ADC_4x_sZmodCh1CouplingL_1 1 4 2 NJ 720 NJ
preplace netloc ADC_4x_sZmodCh1CouplingH_1 1 4 2 NJ 700 NJ
preplace netloc ADC_4x_sZmodADC_CS_1 1 4 2 NJ 660 NJ
preplace netloc Net1 1 4 2 NJ 640 NJ
preplace netloc ADC_4x_sZmodCh2GainL_1 1 4 2 NJ 840 NJ
preplace netloc ADC_4x_sZmodCh2GainH_1 1 4 2 NJ 820 NJ
preplace netloc ADC_4x_sZmodCh1GainL_1 1 4 2 NJ 800 NJ
preplace netloc ADC_4x_sZmodCh1GainH_1 1 4 2 NJ 780 NJ
preplace netloc ADC_4x_sZmodRelayComL_1 1 4 2 NJ 880 NJ
preplace netloc adc_data 1 4 1 1530 260n
preplace netloc adc_valid 1 4 1 1540 280n
preplace netloc blink_led_blink_o 1 5 1 NJ 380
preplace netloc processing_system7_0_DDR 1 1 5 NJ 60 NJ 60 NJ 60 NJ 60 NJ
preplace netloc processing_system7_0_FIXED_IO 1 1 5 NJ 80 NJ 80 NJ 80 NJ 80 NJ
preplace netloc axi_interconnect_0_M00_AXI 1 2 1 N 200
preplace netloc processing_system7_0_M_AXI_GP0 1 1 1 450 100n
levelinfo -pg 1 0 230 610 910 1260 1650 1800
pagesize -pg 1 -db -bbox -sgen -220 0 2010 1130
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name

}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""
set_property IS_ENABLED "1" [get_files design_1.bd]
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_1.bd]


