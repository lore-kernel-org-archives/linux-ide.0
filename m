From: "Andy Vaselaar" <andrew.vaselaar@trinity.edu>
Subject: Frequent head unloads  info
Date: Mon, 15 Sep 2008 18:56:43 -0500
Message-ID: <op.uhjrgs2b70fqr1@blacktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=----------aHGoiMqEpIuWuBYmGiUTZM
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:61121 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbYIOX4u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 19:56:50 -0400
Received: by wx-out-0506.google.com with SMTP id h27so1000910wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 16:56:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------------aHGoiMqEpIuWuBYmGiUTZM
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit


hdparm -B255 /dev/sda

seems to stop it from unloading the heads.

Thanks!

-andy
------------aHGoiMqEpIuWuBYmGiUTZM
Content-Disposition: attachment; filename=smart.txt
Content-Type: text/plain; name=smart.txt
Content-Transfer-Encoding: 7bit

smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 5400.2 series
Device Model:     ST9120821A
Serial Number:    5PL09EL9
Firmware Version: 3.04
User Capacity:    120,034,123,776 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Mon Sep 15 18:54:20 2008 CDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 426) seconds.
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
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 ( 111) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   110   099   006    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   095   095   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   095   095   020    Old_age   Always       -       5257
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       24
  7 Seek_Error_Rate         0x000f   079   060   030    Pre-fail  Always       -       97630102
  9 Power_On_Hours          0x0032   094   094   000    Old_age   Always       -       5504
 10 Spin_Retry_Count        0x0013   100   100   034    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   098   098   020    Old_age   Always       -       3022
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Temperature_Celsius     0x0022   064   052   045    Old_age   Always       -       606339108
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       404
193 Load_Cycle_Count        0x0032   012   012   000    Old_age   Always       -       176916
194 Temperature_Celsius     0x0022   036   048   000    Old_age   Always       -       36 (Lifetime Min/Max 0/11)
195 Hardware_ECC_Recovered  0x001a   067   046   000    Old_age   Always       -       28454145
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   197   000    Old_age   Always       -       29
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

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


------------aHGoiMqEpIuWuBYmGiUTZM
Content-Disposition: attachment; filename=hdparm.txt
Content-Type: text/plain; name=hdparm.txt
Content-Transfer-Encoding: 7bit


/dev/sda:

ATA device, with non-removable media
	Model Number:       ST9120821A                              
	Serial Number:      5PL09EL9
	Firmware Revision:  3.04    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = ?
	Advanced power management level: disabled
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	   *	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	    	Advanced Power Management feature set
	    	SET_MAX security extension
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	SMART Command Transport (SCT) feature set
Security: 
		supported
		enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	Security level maximum
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by CSEL
Checksum: correct

------------aHGoiMqEpIuWuBYmGiUTZM
Content-Disposition: attachment; filename=dmi.txt
Content-Type: text/plain; name=dmi.txt
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.33 present.
64 structures occupying 2086 bytes.
Table at 0x000E0010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: IBM
	Version: 70ET37WW (1.01 )
	Release Date: 01/31/2005
	Address: 0xDC000
	Runtime Size: 144 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: IBM
	Product Name: 1871W8P
	Version: ThinkPad T43
	Serial Number: L3BAXP0
	UUID: 71F12081-47E2-11CB-BE81-BF2F1897792E
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: IBM
	Product Name: 1871W8P
	Version: Not Available
	Serial Number: VJ0PG5B91RP

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: IBM
	Type: Notebook
	Lock: Not Present
	Version: Not Available
	Serial Number: Not Available
	Asset Tag: No Asset Information
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 126, 17 bytes
Inactive

Handle 0x0005, DMI type 126, 17 bytes
Inactive

Handle 0x0006, DMI type 4, 35 bytes
Processor Information
	Socket Designation: None
	Type: Central Processor
	Family: Pentium M
	Manufacturer: GenuineIntel
	ID: D8 06 00 00 FF FB E9 AF
	Signature: Type 0, Family 6, Model 13, Stepping 8
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
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Pentium(R) M processor
	Voltage: 1.3 V
	External Clock: 533 MHz
	Max Speed: 1866 MHz
	Current Speed: 1866 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000B
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0007, DMI type 5, 20 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 2048 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 2.9 V
	Associated Memory Slots: 2
		0x0008
		0x0009
	Enabled Error Correcting Capabilities:
		Unknown

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 1
	Bank Connections: 0 3
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 2
	Bank Connections: 4 7
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x000C, DMI type 126, 9 bytes
Inactive

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Infrared
	External Connector Type: Infrared
	Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: External Monitor
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0010, DMI type 126, 9 bytes
Inactive

Handle 0x0011, DMI type 126, 9 bytes
Inactive

Handle 0x0012, DMI type 126, 9 bytes
Inactive

Handle 0x0013, DMI type 126, 9 bytes
Inactive

Handle 0x0014, DMI type 126, 9 bytes
Inactive

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Microphone Jack
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Headphone Jack
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: S-Video-Out
	External Connector Type: Other
	Port Type: Video Port

Handle 0x0018, DMI type 126, 9 bytes
Inactive

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Modem
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Ethernet
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001D, DMI type 126, 9 bytes
Inactive

Handle 0x001E, DMI type 126, 9 bytes
Inactive

Handle 0x001F, DMI type 126, 9 bytes
Inactive

Handle 0x0020, DMI type 126, 9 bytes
Inactive

Handle 0x0021, DMI type 126, 9 bytes
Inactive

Handle 0x0022, DMI type 9, 13 bytes
System Slot Information
	Designation: CardBus Slot 1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Other
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Zoom Video is supported
		Modem ring resume is supported
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0023, DMI type 126, 13 bytes
Inactive

Handle 0x0024, DMI type 126, 13 bytes
Inactive

Handle 0x0025, DMI type 126, 13 bytes
Inactive

Handle 0x0026, DMI type 9, 13 bytes
System Slot Information
	Designation: Mini-PCI Slot 1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Other
	ID: 1
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0027, DMI type 126, 13 bytes
Inactive

Handle 0x0028, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Disabled
	Description: IBM Embedded Security hardware

Handle 0x0029, DMI type 11, 5 bytes
OEM Strings
	String 1: IBM ThinkPad Embedded Controller -[70HT26WW-1.03    ]-

Handle 0x002A, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x002B, DMI type 15, 25 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Full
	Change Token: 0x0000002B
	Header Format: Type 1
	Supported Log Type Descriptors: 1
	Descriptor 1: POST error
	Data Format 1: POST results bitmap

Handle 0x002C, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x002D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM 1
	Bank Locator: Bank 0/1
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x002E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM 2
	Bank Locator: Bank 2/3
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x002F, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0030, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x002C
	Partition Width: 0

Handle 0x0031, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x002D
	Memory Array Mapped Address Handle: 0x0030
	Partition Row Position: 1

Handle 0x0032, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x002E
	Memory Array Mapped Address Handle: 0x0030
	Partition Row Position: 1

Handle 0x0033, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Track Point
	Interface: PS/2
	Buttons: 3

Handle 0x0034, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 0

Handle 0x0035, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Enabled
	Keyboard Password Status: Disabled
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x0036, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0037, DMI type 131, 17 bytes
OEM-specific Type
	Header and Data:
		83 11 37 00 01 02 03 FF FF 1F 00 00 00 00 00 02
		00
	Strings:
		BOOTINF 20h
		BOOTDEV 21h
		KEYPTRS 23h

Handle 0x0038, DMI type 131, 11 bytes
OEM-specific Type
	Header and Data:
		83 0B 38 00 00 00 E8 FF C5 01 01
	Strings:
		IBM System Metrics

Handle 0x0039, DMI type 132, 7 bytes
OEM-specific Type
	Header and Data:
		84 07 39 00 01 DA 36

Handle 0x003A, DMI type 133, 5 bytes
OEM-specific Type
	Header and Data:
		85 05 3A 00 01
	Strings:
		KHOIHGIUCCHHII

Handle 0x003B, DMI type 134, 13 bytes
OEM-specific Type
	Header and Data:
		86 0D 3B 00 B0 01 52 BA 81 03 E8 F6 D3

Handle 0x003C, DMI type 135, 13 bytes
OEM-specific Type
	Header and Data:
		87 0D 3C 00 54 50 07 00 01 01 00 00 00

Handle 0x003D, DMI type 135, 18 bytes
OEM-specific Type
	Header and Data:
		87 12 3D 00 54 50 07 01 01 9B 00 00 00 00 00 00
		00 00

Handle 0x003E, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 3E 00 5A 5A

Handle 0x003F, DMI type 127, 4 bytes
End Of Table


------------aHGoiMqEpIuWuBYmGiUTZM--

