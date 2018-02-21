
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1
#    set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
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

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000} CONFIG.PCW_ENET0_ENET0_IO {<Select>} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {0} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} CONFIG.PCW_EN_CLK0_PORT {0} \
CONFIG.PCW_EN_RST0_PORT {0} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {0} CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_MIO_0_PULLUP {<Select>} CONFIG.PCW_MIO_10_PULLUP {<Select>} \
CONFIG.PCW_MIO_11_PULLUP {<Select>} CONFIG.PCW_MIO_12_PULLUP {<Select>} \
CONFIG.PCW_MIO_16_IOTYPE {<Select>} CONFIG.PCW_MIO_16_PULLUP {<Select>} \
CONFIG.PCW_MIO_16_SLEW {<Select>} CONFIG.PCW_MIO_17_IOTYPE {<Select>} \
CONFIG.PCW_MIO_17_PULLUP {<Select>} CONFIG.PCW_MIO_17_SLEW {<Select>} \
CONFIG.PCW_MIO_18_IOTYPE {<Select>} CONFIG.PCW_MIO_18_PULLUP {<Select>} \
CONFIG.PCW_MIO_18_SLEW {<Select>} CONFIG.PCW_MIO_19_IOTYPE {<Select>} \
CONFIG.PCW_MIO_19_PULLUP {<Select>} CONFIG.PCW_MIO_19_SLEW {<Select>} \
CONFIG.PCW_MIO_1_PULLUP {<Select>} CONFIG.PCW_MIO_1_SLEW {<Select>} \
CONFIG.PCW_MIO_20_IOTYPE {<Select>} CONFIG.PCW_MIO_20_PULLUP {<Select>} \
CONFIG.PCW_MIO_20_SLEW {<Select>} CONFIG.PCW_MIO_21_IOTYPE {<Select>} \
CONFIG.PCW_MIO_21_PULLUP {<Select>} CONFIG.PCW_MIO_21_SLEW {<Select>} \
CONFIG.PCW_MIO_22_IOTYPE {<Select>} CONFIG.PCW_MIO_22_PULLUP {<Select>} \
CONFIG.PCW_MIO_22_SLEW {<Select>} CONFIG.PCW_MIO_23_IOTYPE {<Select>} \
CONFIG.PCW_MIO_23_PULLUP {<Select>} CONFIG.PCW_MIO_23_SLEW {<Select>} \
CONFIG.PCW_MIO_24_IOTYPE {<Select>} CONFIG.PCW_MIO_24_PULLUP {<Select>} \
CONFIG.PCW_MIO_24_SLEW {<Select>} CONFIG.PCW_MIO_25_IOTYPE {<Select>} \
CONFIG.PCW_MIO_25_PULLUP {<Select>} CONFIG.PCW_MIO_25_SLEW {<Select>} \
CONFIG.PCW_MIO_26_IOTYPE {<Select>} CONFIG.PCW_MIO_26_PULLUP {<Select>} \
CONFIG.PCW_MIO_26_SLEW {<Select>} CONFIG.PCW_MIO_27_IOTYPE {<Select>} \
CONFIG.PCW_MIO_27_PULLUP {<Select>} CONFIG.PCW_MIO_27_SLEW {<Select>} \
CONFIG.PCW_MIO_28_PULLUP {<Select>} CONFIG.PCW_MIO_28_SLEW {<Select>} \
CONFIG.PCW_MIO_29_PULLUP {<Select>} CONFIG.PCW_MIO_29_SLEW {<Select>} \
CONFIG.PCW_MIO_2_SLEW {<Select>} CONFIG.PCW_MIO_30_PULLUP {<Select>} \
CONFIG.PCW_MIO_30_SLEW {<Select>} CONFIG.PCW_MIO_31_PULLUP {<Select>} \
CONFIG.PCW_MIO_31_SLEW {<Select>} CONFIG.PCW_MIO_32_PULLUP {<Select>} \
CONFIG.PCW_MIO_32_SLEW {<Select>} CONFIG.PCW_MIO_33_PULLUP {<Select>} \
CONFIG.PCW_MIO_33_SLEW {<Select>} CONFIG.PCW_MIO_34_PULLUP {<Select>} \
CONFIG.PCW_MIO_34_SLEW {<Select>} CONFIG.PCW_MIO_35_PULLUP {<Select>} \
CONFIG.PCW_MIO_35_SLEW {<Select>} CONFIG.PCW_MIO_36_PULLUP {<Select>} \
CONFIG.PCW_MIO_36_SLEW {<Select>} CONFIG.PCW_MIO_37_PULLUP {<Select>} \
CONFIG.PCW_MIO_37_SLEW {<Select>} CONFIG.PCW_MIO_38_PULLUP {<Select>} \
CONFIG.PCW_MIO_38_SLEW {<Select>} CONFIG.PCW_MIO_39_PULLUP {<Select>} \
CONFIG.PCW_MIO_39_SLEW {<Select>} CONFIG.PCW_MIO_3_SLEW {<Select>} \
CONFIG.PCW_MIO_40_PULLUP {<Select>} CONFIG.PCW_MIO_40_SLEW {<Select>} \
CONFIG.PCW_MIO_41_PULLUP {<Select>} CONFIG.PCW_MIO_41_SLEW {<Select>} \
CONFIG.PCW_MIO_42_PULLUP {<Select>} CONFIG.PCW_MIO_42_SLEW {<Select>} \
CONFIG.PCW_MIO_43_PULLUP {<Select>} CONFIG.PCW_MIO_43_SLEW {<Select>} \
CONFIG.PCW_MIO_44_PULLUP {<Select>} CONFIG.PCW_MIO_44_SLEW {<Select>} \
CONFIG.PCW_MIO_45_PULLUP {<Select>} CONFIG.PCW_MIO_45_SLEW {<Select>} \
CONFIG.PCW_MIO_47_PULLUP {<Select>} CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_49_PULLUP {disabled} CONFIG.PCW_MIO_4_SLEW {<Select>} \
CONFIG.PCW_MIO_50_DIRECTION {<Select>} CONFIG.PCW_MIO_50_PULLUP {<Select>} \
CONFIG.PCW_MIO_51_DIRECTION {<Select>} CONFIG.PCW_MIO_51_PULLUP {<Select>} \
CONFIG.PCW_MIO_52_PULLUP {<Select>} CONFIG.PCW_MIO_52_SLEW {<Select>} \
CONFIG.PCW_MIO_53_PULLUP {<Select>} CONFIG.PCW_MIO_53_SLEW {<Select>} \
CONFIG.PCW_MIO_5_SLEW {<Select>} CONFIG.PCW_MIO_6_SLEW {<Select>} \
CONFIG.PCW_MIO_8_SLEW {<Select>} CONFIG.PCW_MIO_9_PULLUP {<Select>} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {0} CONFIG.PCW_SD0_GRP_CD_IO {<Select>} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {0} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART1_BAUD_RATE {9600} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.03} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB0_RESET_ENABLE {0} CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USB_RESET_ENABLE {0} CONFIG.PCW_USE_AXI_FABRIC_IDLE {0} \
CONFIG.PCW_USE_DDR_BYPASS {0} CONFIG.PCW_USE_M_AXI_GP0 {0} \
 ] $processing_system7_0

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]

  # Create port connections

  # Create address segments
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


