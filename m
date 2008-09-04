From: Maic Schulte <webmaster@dragontower.de>
Subject: http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux
 - Answer with attachments
Date: Thu, 04 Sep 2008 14:19:52 +0200
Message-ID: <48BFD268.30605@dragontower.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050206080605030706060008"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dd6110.kasserver.com ([85.13.130.239]:53338 "EHLO
	dd6110.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDM2I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 08:28:08 -0400
Received: from [192.168.178.21] (port-92-192-76-191.dynamic.qsc.de [92.192.76.191])
	by dd6110.kasserver.com (Postfix) with ESMTP id 0A015180C37D1
	for <linux-ide@vger.kernel.org>; Thu,  4 Sep 2008 14:19:51 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206080605030706060008
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

You asked for this information:

"Known affected devices

This list is far from complete. If you have a hardware affected by this 
problem, please write to linux-ide and attach the outputs of 
"dmidecode", "hdparm -I /dev/[hs]dX" and "smartctl -a /dev/[hs]dX" where 
dev/[hs]dX is the affected drive."

I use a Dell Inspirion 1300 with a WD IDE 2,5" Notebook-HDD. My OS is 
Ubuntu 8.04. Before I used Ubuntu 7.10 and was not affected by this bug.

Hope, this helps a little bit.

See ya, Maic.

--------------050206080605030706060008
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.3 present.
43 structures occupying 1633 bytes.
Table at 0x000F8050.

Handle 0xDA00, DMI type 218, 77 bytes
OEM-specific Type
	Header and Data:
		DA 4D 00 DA B2 00 0D 5F 0F 37 40 7D 00 00 00 00
		00 7E 00 02 00 00 00 40 00 04 00 01 00 41 00 04
		00 00 00 76 01 76 01 01 00 75 01 75 01 01 00 01
		F0 01 F0 00 00 02 F0 02 F0 00 00 03 F0 03 F0 00
		00 04 F0 04 F0 00 00 FF FF 00 00 00 00

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Dell Inc.
	Version: A10
	Release Date: 11/07/2006
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported

Handle 0x0100, DMI type 1, 25 bytes
System Information
	Manufacturer: Dell Inc.
	Product Name: ME051                           
	Version: Not Specified
	Serial Number: 6RN542J
	UUID: 44454C4C-5200-104E-8035-B6C04F34324A
	Wake-up Type: Power Switch

Handle 0x0200, DMI type 2, 9 bytes
Base Board Information
	Manufacturer: Dell Inc.
	Product Name: 0GD366
	Version:    
	Serial Number: .6RN542J.CN7016661L0J0W.

Handle 0x0300, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Dell Inc.
	Type: Portable
	Lock: Not Present
	Version: Not Specified
	Serial Number: 6RN542J
	Asset Tag: Not Specified
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None

Handle 0x0400, DMI type 4, 32 bytes
Processor Information
	Socket Designation: Microprocessor
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel
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
	Version: Not Specified
	Voltage: 3.3 V
	External Clock: 133 MHz
	Max Speed: 2130 MHz
	Current Speed: 1500 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0700
	L2 Cache Handle: 0x0701
	L3 Cache Handle: Not Provided

Handle 0x0700, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 8 KB
	Maximum Size: 8 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0701, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: 15 ns
	Error Correction Type: None
	System Type: Unified
	Associativity: Other

Handle 0x0804, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0806, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: MONITOR
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x080C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Modem
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x080D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Ethernet
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0900, DMI type 9, 13 bytes
System Slot Information
	Designation: PCMCIA 0
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

Handle 0x0904, DMI type 9, 13 bytes
System Slot Information
	Designation: MiniPCI
	Type: 32-bit Other
	Current Usage: Available
	Length: Other
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0A00, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Intel 915GM/910GML Graphics  

Handle 0x0A01, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: Sigmatel 9200

Handle 0x0B00, DMI type 11, 5 bytes
OEM Strings
	String 1: Dell System
	String 2: 5[0001]
	String 3: 13[PP21L]

Handle 0x0D00, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x1000, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x1100, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_A
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 7F7F7F7FEF000000
	Serial Number: 00000000
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x1101, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_B
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 7F7F7F7FEF000000
	Serial Number: 00000000
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x1300, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0000009FFFF
	Range Size: 640 kB
	Physical Array Handle: 0x1000
	Partition Width: 0

Handle 0x1301, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000100000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2047 MB
	Physical Array Handle: 0x1000
	Partition Width: 0

Handle 0x1400, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0000009FFFF
	Range Size: 640 kB
	Physical Device Handle: 0x1100
	Memory Array Mapped Address Handle: 0x1300
	Partition Row Position: 1

Handle 0x1401, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000100000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1023 MB
	Physical Device Handle: 0x1100
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1

Handle 0x1402, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x1101
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1

Handle 0x1500, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: Bus Mouse
	Buttons: 2

Handle 0x1600, DMI type 126, 26 bytes
Inactive

Handle 0x1B00, DMI type 27, 12 bytes
Cooling Device
	Type: Fan
	Status: OK
	OEM-specific Information: 0x0000DD00

Handle 0x1C00, DMI type 28, 20 bytes
Temperature Probe
	Description: CPU Internal Temperature
	Location: Processor
	Status: OK
	Maximum Value: 127.0 deg C
	Minimum Value 0.0 deg C
	Resolution: 1.000 deg C
	Tolerance: 0.5 deg C
	Accuracy: Unknown
	OEM-specific Information: 0x0000DC00

Handle 0x2000, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0xB000, DMI type 176, 5 bytes
OEM-specific Type
	Header and Data:
		B0 05 00 B0 00

Handle 0xB100, DMI type 177, 12 bytes
OEM-specific Type
	Header and Data:
		B1 0C 00 B1 00 00 00 00 00 00 00 00

Handle 0xD000, DMI type 208, 10 bytes
OEM-specific Type
	Header and Data:
		D0 0A 00 D0 01 04 FE 00 C9 01

Handle 0xD800, DMI type 216, 9 bytes
OEM-specific Type
	Header and Data:
		D8 09 00 D8 01 03 01 F0 03
	Strings:
		Intel Corp.         
		 
		1219  

Handle 0xD900, DMI type 217, 8 bytes
OEM-specific Type
	Header and Data:
		D9 08 00 D9 01 02 01 03
	Strings:
		US-101
		Proprietary

Handle 0xDB00, DMI type 219, 9 bytes
OEM-specific Type
	Header and Data:
		DB 09 00 DB 03 01 02 03 FF
	Strings:
		System Device Bay
		Floppy, Battery, CD-ROM, CD-RW, DVD, DVD+RW, DVD+/-RW, Hard Disk
		DVD+/-RW  

Handle 0xDC00, DMI type 220, 22 bytes
OEM-specific Type
	Header and Data:
		DC 16 00 DC 01 F0 00 00 02 F0 00 00 00 00 03 F0
		04 F0 00 00 00 00

Handle 0xDD00, DMI type 221, 19 bytes
OEM-specific Type
	Header and Data:
		DD 13 00 DD 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00

Handle 0xD400, DMI type 212, 147 bytes
OEM-specific Type
	Header and Data:
		D4 93 00 D4 70 00 71 00 00 10 2D 2E 5C 00 78 BF
		40 5D 00 78 BF 00 65 00 21 F7 00 66 00 21 F7 08
		5E 00 23 FE 01 5F 00 23 FE 00 F1 00 21 FC 00 F2
		00 21 FC 01 F3 00 21 FC 02 28 00 23 F3 00 29 00
		23 F3 04 2A 00 23 F3 08 2B 00 58 00 00 2C 00 59
		00 00 E7 00 1D F3 04 E6 00 1D F3 00 0E 01 23 FD
		02 0F 01 23 FD 00 9B 00 23 EF 10 9C 00 23 EF 00
		E8 00 23 DF 20 E9 00 23 DF 00 12 01 34 FB 04 13
		01 34 FB 00 08 00 1D DF 00 03 00 1D DF 00 FF FF
		00 00 00

Handle 0xD401, DMI type 212, 137 bytes
OEM-specific Type
	Header and Data:
		D4 89 01 D4 70 00 71 00 03 40 49 4A 42 00 48 7F
		80 43 00 48 7F 00 55 00 47 BF 00 6D 00 47 BF 40
		0C 01 46 FB 04 0D 01 46 FB 00 14 01 46 E7 00 15
		01 46 E7 08 16 01 46 E7 10 0A 01 48 EF 10 0B 01
		48 EF 00 2D 00 48 DF 20 2E 00 48 DF 00 11 01 48
		BF 00 10 01 48 BF 40 F0 00 46 DF 20 ED 00 46 DF
		00 41 01 46 FE 01 40 01 46 FE 00 47 01 42 7F 80
		46 01 42 7F 00 EA 00 67 F3 00 EB 00 67 F3 04 EC
		00 67 F3 08 FF FF 00 00 00

Handle 0xDE00, DMI type 222, 13 bytes
OEM-specific Type
	Header and Data:
		DE 0D 00 DE 01 02 FF FF 00 00 00 00 00

Handle 0x7F00, DMI type 127, 4 bytes
End Of Table


--------------050206080605030706060008
Content-Type: text/plain;
 name="hdparm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm.txt"


/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD1600BEVE-00UYT0                   
	Serial Number:      WD-WXEY07U96240
	Firmware Revision:  01.04A01
Standards:
	Supported: 7 6 5 4 
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	device size with M = 1024*1024:      152627 MBytes
	device size with M = 1000*1000:      160041 MBytes (160 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 8
	Advanced power management level: 254
	Recommended acoustic management value: 128, current value: 128
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
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
	    	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	URG for READ_STREAM[_DMA]_EXT
	   *	URG for WRITE_STREAM[_DMA]_EXT
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[13] (vendor specific)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	72min for SECURITY ERASE UNIT. 
Logical Unit WWN Device Identifier: 50014ee2562584cc
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 2562584cc
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--------------050206080605030706060008
Content-Type: text/plain;
 name="smartctl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl.txt"

smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD1600BEVE-00UYT0
Serial Number:    WD-WXEY07U96240
Firmware Version: 01.04A01
User Capacity:    160.041.885.696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Sep  4 14:16:27 2008 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (7200) seconds.
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
recommended polling time: 	 (  92) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       6
  3 Spin_Up_Time            0x0003   187   186   021    Pre-fail  Always       -       1633
  4 Start_Stop_Count        0x0032   099   099   000    Old_age   Always       -       1219
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   100   253   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       1286
 10 Spin_Retry_Count        0x0013   100   100   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   100   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   099   099   000    Old_age   Always       -       1219
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       23
193 Load_Cycle_Count        0x0032   172   172   000    Old_age   Always       -       86726
194 Temperature_Celsius     0x0022   116   100   000    Old_age   Always       -       31
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   100   253   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Interrupted (host reset)      90%       139         -

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


--------------050206080605030706060008--
