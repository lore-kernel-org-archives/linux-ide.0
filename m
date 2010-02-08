From: Al Bogner <suse-linux@ml082.pinguin.uni.cc>
Subject: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Mon, 8 Feb 2010 19:33:10 +0100
Message-ID: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mjFcLBINFFUHDIX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailbackup.inode.at ([213.229.60.24]:43939 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0BHSqn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Feb 2010 13:46:43 -0500
Received: from [62.99.145.18] (port=44457 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.67)
	(envelope-from <suse-linux@ml082.pinguin.uni.cc>)
	id 1NeYRk-0005Pr-05
	for linux-ide@vger.kernel.org; Mon, 08 Feb 2010 19:34:56 +0100
Received: from [85.127.57.138] (port=2434 helo=client1.localnet)
	by smartmx-16.inode.at with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <suse-linux@ml082.pinguin.uni.cc>)
	id 1NeYQj-0004XC-50
	for linux-ide@vger.kernel.org; Mon, 08 Feb 2010 19:33:54 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_mjFcLBINFFUHDIX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

# If you have a harddrive which does crazy unloading but not listed            
# here, please write to linux-ide@vger.kernel.org with the outputs of          
# "dmidecode" and "hdparm -I DRIVE" attached.  On a laptop the DRIVE           
# is usually /dev/sda.

Hi,

I append info of an 1.5 TB WD Caviar green drive with a lot of start/stop 
cycles. I would like to mention, that I have 4 1 TB Caviar green (WD10EADS) 
which work fine!

The e-SATA drive is used with this machine:
http://www.smolts.org/client/show/pub_b214fce2-b5b5-4a32-ba7e-cf9de6d55757
but has problems with other machines too.

I use Openesuse 11.1
Kernel 2.6.27.42-0.1-default
FANTEC Fanbox FB-35US2 (probably JMicron 20360/20363 AHCI Controller)
storage-fixup-0.2-25.3 is installed, but not especially configured


If you need more info let me know.

Al


--Boundary-00=_mjFcLBINFFUHDIX
Content-Type: text/plain;
  charset="utf-8";
  name="sdc_dmidecode_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdc_dmidecode_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"

# dmidecode 2.9
SMBIOS 2.5 present.
54 structures occupying 2048 bytes.
Table at 0x000FD590.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: V3.4
	Release Date: 01/18/2009
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 8.15

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: MSI
	Product Name: MS-7374
	Version: 1.0
	Serial Number: To Be Filled By O.E.M.
	UUID: 00000000-0000-0000-0000-00218563A101
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: MSI
	Product Name: MS-7374
	Version: 1.0
	Serial Number: To be filled by O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To Be Filled By O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: To Be Filled By O.E.M.
	Type: Desktop
	Lock: Not Present
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 40 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Athlon 64 X2
	Manufacturer: AMD              
	ID: B2 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 107, Stepping 2
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Athlon(tm) Dual Core Processor 5050e            
	Voltage: 1.5 V
	External Clock: 200 MHz
	Max Speed: 2600 MHz
	Current Speed: 2615 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
	Core Count: 2
	Core Enabled: 2
	Characteristics:
		64-bit capable

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 256 KB
	Maximum Size: 256 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0008, DMI type 5, 24 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 4096 MB
	Supported Speeds:
		70 ns
		60 ns
		50 ns
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 4
		0x0009
		0x000A
		0x000B
		0x000C
	Enabled Error Correcting Capabilities:
		None

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 5
	Current Speed: 160 ns
	Type: ECC DIMM
	Installed Size: 2048 MB (Double-bank Connection)
	Enabled Size: 2048 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 0 5
	Current Speed: 162 ns
	Type: ECC DIMM
	Installed Size: 2048 MB (Double-bank Connection)
	Enabled Size: 2048 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: 0
	Current Speed: Unknown
	Type: Other
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000C, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: 0
	Current Speed: Unknown
	Type: Other
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Mic In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6B1 - AUX IN
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6B2 - CDIN
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J2 - PRI IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J1 - SEC IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J4J1 - FLOPPY
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9H1 - FRONT PNL
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1B1 - CHASSIS REAR FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2F1 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8B4 - FRONT FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G2 - FNT USB
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6C3 - FP AUD
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G1 - CONFIG
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0021, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8C1 - SCSI LED
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9J2 - INTRUDER
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G4 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0024, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2H1 - MAIN POWER
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0025, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0026, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0027, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   To Be Filled By O.E.M.

Handle 0x0028, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.

Handle 0x0029, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x002A, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x002B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x002C, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0011FFFFFFF
	Range Size: 4608 MB
	Physical Array Handle: 0x002B
	Partition Width: 0

Handle 0x002D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: Corsair       
	Serial Number: 00000000
	Asset Tag: AssetTagNum0
	Part Number: CM2X2048-6400C5   

Handle 0x002E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x002D
	Memory Array Mapped Address Handle: 0x002C
	Partition Row Position: 1

Handle 0x002F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: Corsair       
	Serial Number: 00000000
	Asset Tag: AssetTagNum1
	Part Number: CM2X2048-6400C5   

Handle 0x0030, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x002F
	Memory Array Mapped Address Handle: 0x002C
	Partition Row Position: 1

Handle 0x0031, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: Other
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: Manufacturer02
	Serial Number: SerNum02
	Asset Tag: AssetTagNum2
	Part Number: ModulePartNumber02

Handle 0x0032, DMI type 126, 19 bytes
Inactive

Handle 0x0033, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: Other
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: Manufacturer03
	Serial Number: SerNum03
	Asset Tag: AssetTagNum3
	Part Number: ModulePartNumber03

Handle 0x0034, DMI type 126, 19 bytes
Inactive

Handle 0x0035, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_mjFcLBINFFUHDIX
Content-Type: text/plain;
  charset="utf-8";
  name="sdc_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdc_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"

smartctl 5.39 2008-10-24 22:33 [x86_64-suse-linux-gnu] (openSUSE RPM)
Copyright (C) 2002-8 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD15EARS-00Z5B1
Serial Number:    WD-WMAVU1371932
Firmware Version: 80.00A80
User Capacity:    1,500,301,910,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Feb  8 18:58:52 2010 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Enabled.

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (31800) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 255) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.
SCT capabilities: 	       (0x3031)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0027   187   187   021    Pre-fail  Always       -       5633
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       8
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x002e   200   200   000    Old_age   Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       44
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       7
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       3
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       765
194 Temperature_Celsius     0x0022   110   109   000    Old_age   Always       -       40
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0008   200   200   000    Old_age   Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%        39         -
# 2  Extended offline    Completed without error       00%         5         -
# 3  Short offline       Completed without error       00%         0         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


--Boundary-00=_mjFcLBINFFUHDIX
Content-Type: text/plain;
  charset="utf-8";
  name="sdc_hdparm_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdc_hdparm_WDC_WD15EARS-00Z5B1_suse111_c1_1006@08_Feb_10_18h_Mon"


/dev/sdc:
 IO_support    =  0 (default) 
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 51329/255/63, sectors = 2930277168, start = 0

 Model=WDC WD15EARS-00Z5B1                     , FwRev=80.00A80, SerialNo=     WD-WMAVU1371932
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=18446744072344861488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


ATA device, with non-removable media
	Model Number:       WDC WD15EARS-00Z5B1                     
	Serial Number:      WD-WMAVU1371932
	Firmware Revision:  80.00A80
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
	Supported: 8 7 6 5 
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 2930277168
	device size with M = 1024*1024:     1430799 MBytes
	device size with M = 1000*1000:     1500301 MBytes (1500 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	unknown 76[12]
	    	DMA Setup Auto-Activate optimization
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	324min for SECURITY ERASE UNIT. 324min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee0ac90a071
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 0ac90a071
Checksum: correct
 Timing cached reads:   2416 MB in  2.00 seconds = 1209.09 MB/sec
 Timing buffered disk reads:  302 MB in  3.02 seconds = 100.07 MB/sec

--Boundary-00=_mjFcLBINFFUHDIX--
