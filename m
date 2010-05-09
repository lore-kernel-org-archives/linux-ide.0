From: Pierre Pallier <pierre.pallier@gmail.com>
Subject: A new drive with excessive number of load/unload
Date: Sun, 9 May 2010 18:19:48 +0200
Message-ID: <201005091819.48511.pierre.pallier@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kCu5Ld9Yx0fPcNs"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41883 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0EIQTx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 May 2010 12:19:53 -0400
Received: by wyf19 with SMTP id 19so348346wyf.19
        for <linux-ide@vger.kernel.org>; Sun, 09 May 2010 09:19:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_kCu5Ld9Yx0fPcNs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

My system : 
EeePC 1005HA, 
Hitachi HTS543216L9SA00,
Mandriva 2010.0
I counted exactly 117 load/unload cycles in one hour.

Setting APM Level to 254 solved the problem.

Regards,
-- 
Pierre, from France

--Boundary-00=_kCu5Ld9Yx0fPcNs
Content-Type: text/plain;
  charset="UTF-8";
  name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.txt"

# dmidecode 2.10
SMBIOS 2.5 present.
30 structures occupying 1264 bytes.
Table at 0x000F0720.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 0905   
	Release Date: 09/23/2009
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
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
		3.5"/720 kB floppy services are supported (int 13h)
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
	BIOS Revision: 8.12
	Firmware Revision: 0.28

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: 1005HA
	Version: x.x
	Serial Number: 99OAAS485869
	UUID: 80128A40-2616-4681-2444-90E6BA5E5DCE
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: 1005HA
	Version: x.xx
	Serial Number: EeePC-0123456789
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
	Manufacturer: ASUSTeK Computer INC.
	Type: Notebook
	Lock: Present
	Version: x.x
	Serial Number: 0x00000000
	Asset Tag: 0x00000000
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: PBGA 437
	Type: Central Processor
	Family: Core Solo
	Manufacturer: Intel            
	ID: C2 06 01 00 FF FB E9 BF
	Signature: Type 0, Family 6, Model 28, Stepping 2
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
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Atom(TM) CPU N270   @ 1.60GHz              
	Voltage: 1.3 V
	External Clock: 133 MHz
	Max Speed: 1666 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 24 kB
	Maximum Size: 24 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Data
	Associativity: Other

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 kB
	Maximum Size: 0 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0008, DMI type 5, 18 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 2048 MB
	Maximum Total Memory Size: 2048 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 1
		0x0009
	Enabled Error Correcting Capabilities:
		None

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Mic In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J2 - PRI IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J1 - SEC IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   To Be Filled By O.E.M.

Handle 0x0015, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.
	String 2: 1020054400760905
	String 3: 90OAM1BDB1122B81E828Q
	String 4: 5

Handle 0x0016, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0017, DMI type 15, 35 bytes
System Event Log
	Area Length: 4 bytes
	Header Start Offset: 0x0000
	Header Length: 2 bytes
	Data Start Offset: 0x0002
	Access Method: Indexed I/O, one 16-bit index port, one 8-bit data port
	Access Address: Index 0x046A, Data 0x046C
	Status: Invalid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 6
	Descriptor 1: End of log
	Data Format 1: OEM-specific
	Descriptor 2: End of log
	Data Format 2: OEM-specific
	Descriptor 3: End of log
	Data Format 3: OEM-specific
	Descriptor 4: End of log
	Data Format 4: OEM-specific
	Descriptor 5: End of log
	Data Format 5: OEM-specific
	Descriptor 6: End of log
	Data Format 6: OEM-specific

Handle 0x0018, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 1

Handle 0x0019, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000400003FF
	Range Size: 1048577 kB
	Physical Array Handle: 0x0018
	Partition Width: 0

Handle 0x001A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0018
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: SDRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x001A
	Memory Array Mapped Address Handle: 0x0019
	Partition Row Position: 1
	Interleaved Data Depth: 1

Handle 0x001C, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x001D, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_kCu5Ld9Yx0fPcNs
Content-Type: text/plain;
  charset="UTF-8";
  name="hdparm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hdparm.txt"


/dev/sda:

ATA device, with non-removable media
	Model Number:       Hitachi HTS543216L9SA00                 
	Serial Number:      090820FB22045NEU75AA
	Firmware Revision:  FB2OC40C
	Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6; Revision: ATA8-AST T13 Project D1697 Revision 0b
Standards:
	Used: ATA-8-ACS revision 3f 
	Supported: 8 7 6 5 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:      152627 MBytes
	device size with M = 1000*1000:      160041 MBytes (160 GB)
	cache/buffer size  = 7114 KBytes (type=DualPortCache)
	Nominal Media Rotation Rate: 5400
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Vendor, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 128
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
	   *	Advanced Power Management feature set
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
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	64-bit World wide name
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	NCQ priority information
	    	Non-Zero buffer offsets in DMA Setup FIS
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	    	In-order data delivery
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	66min for SECURITY ERASE UNIT. 68min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000cca5e5e7a735
	NAA		: 5
	IEEE OUI	: 000cca
	Unique ID	: 5e5e7a735
Checksum: correct

--Boundary-00=_kCu5Ld9Yx0fPcNs
Content-Type: text/plain;
  charset="UTF-8";
  name="smartctl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="smartctl.txt"

smartctl version 5.38 [i586-mandriva-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     Hitachi HTS543216L9SA00
Serial Number:    090820FB22045NEU75AA
Firmware Version: FB2OC40C
User Capacity:    160 041 885 696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 3f
Local Time is:    Sun May  9 17:00:59 2010 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x85)	Offline data collection activity
					was aborted by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 645) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  67) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   062    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   100   100   040    Pre-fail  Offline      -       2004
  3 Spin_Up_Time            0x0007   253   253   033    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always       -       98
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   040    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0012   100   100   000    Old_age   Always       -       80
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       52
191 G-Sense_Error_Rate      0x000a   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       4
193 Load_Cycle_Count        0x0012   100   100   000    Old_age   Always       -       5518
194 Temperature_Celsius     0x0002   196   196   000    Old_age   Always       -       28 (Lifetime Min/Max 19/43)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       0
223 Load_Retry_Count        0x000a   100   100   000    Old_age   Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


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


--Boundary-00=_kCu5Ld9Yx0fPcNs--
