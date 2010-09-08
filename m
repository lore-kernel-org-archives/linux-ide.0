From: Dimitris Fotopoulos <dintua@gmail.com>
Subject: Hard drive with crazy unloading
Date: Wed, 8 Sep 2010 16:30:19 +0300
Message-ID: <20100908133019.GA8862@openBSD.lala>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33814 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0IHNbT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Sep 2010 09:31:19 -0400
Received: by wyf22 with SMTP id 22so28429wyf.19
        for <linux-ide@vger.kernel.org>; Wed, 08 Sep 2010 06:31:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

my laptop model is the following

HP Pavilion dv6-2190ev and the laptop's hard disk is the

Seagate Momentus 7200.4 SATA ST9500420AS.

So far, I have worked around the problem of excessive head
unloading with the command "hdparm -B 254 /dev/sda". After,
this adjustment the hard disk's temperature (according to
the "smartctl -a /dev/sda") rose from 32 Celsius to 36
Celsius.

The drive seems to unload the head 75 times/hour under
nominal usage without any adjustment.

Please, update the "storage-fixup" with my model's specs.

I have attached the requested files.

Thanks for your work,
Dimitris

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmidecode_hp_pavilion_dv6_2190ev

# dmidecode 2.10
SMBIOS 2.6 present.
37 structures occupying 1666 bytes.
Table at 0x000EA8E0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.1C
	Release Date: 05/17/2010
	ROM Size: 1536 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 15.28
	Firmware Revision: 50.37

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv6 Notebook PC
	Version: 049D210000241210000020000
	Serial Number: CNF0031BMK
	UUID: 30464E43-3330-4231-4D4B-00269EEBDFBC
	Wake-up Type: Power Switch
	SKU Number: WA043EA#B1A
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Hewlett-Packard
	Product Name: 3659
	Version: 32.25
	Serial Number: CNF0031BMK
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Hewlett-Packard
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:                     
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000112
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
	Designation: J5C1
	Type: x16 PCI Express x16
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x0005, DMI type 9, 17 bytes
System Slot Information
	Designation: J6C1
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
	Designation: J6C2
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x0007, DMI type 9, 17 bytes
System Slot Information
	Designation: J6D2
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x0008, DMI type 9, 17 bytes
System Slot Information
	Designation: J7C1
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x0009, DMI type 9, 17 bytes
System Slot Information
	Designation: J7D2
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x000A, DMI type 9, 17 bytes
System Slot Information
	Designation: J8C2
	Type: x16 PCI Express x16
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x000B, DMI type 9, 17 bytes
System Slot Information
	Designation: J8C1
	Type: x1 PCI Express x1
	Current Usage: Available
	Length: Other
	Characteristics:
		PME signal is supported
		Hot-plug devices are supported
	Bus Address: 0000:00:1f.7

Handle 0x000C, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Video Graphics Controller

Handle 0x000D, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Realtek Lan Controller

Handle 0x000E, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#B1A
	String 3: ABS 70/71 79 7A 7B 7C
	String 4: CNB1 049D210000241210000020000

Handle 0x000F, DMI type 12, 5 bytes
System Configuration Options
	Option 1: String1 for Type12 Equipment Manufacturer
	Option 2: String2 for Type12 Equipment Manufacturer
	Option 3: String3 for Type12 Equipment Manufacturer
	Option 4: String4 for Type12 Equipment Manufacturer

Handle 0x0010, DMI type 15, 29 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Data Start Offset: 0x0000
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x12345678
	Header Format: OEM-specific
	Supported Log Type Descriptors: 3
	Descriptor 1: POST memory resize
	Data Format 1: None
	Descriptor 2: POST error
	Data Format 2: POST results bitmap
	Descriptor 3: Log area reset/cleared
	Data Format 3: None

Handle 0x0011, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 4

Handle 0x0012, DMI type 22, 26 bytes
Portable Battery
	Location: In the back
	Manufacturer: SMP-SS22
	Name: EV06047
	Chemistry: Lithium Ion
	Design Capacity: 4400 mWh
	Design Voltage: 10800 mV
	SBDS Version: 3.1
	Maximum Error: 1%
	SBDS Serial Number: 1172
	SBDS Manufacture Date: 2009-12-10
	OEM-specific Information: 0xFFFFFFFF

Handle 0x0013, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0014, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: nVidia Video Graphics Controller
	Type: Video
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:01:00.0

Handle 0x0015, DMI type 41, 11 bytes
Onboard Device
	Reference Designation: Bearkat Broadcom 43225 802.11b/g/n WLAN
	Type: Other
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:02:00.0

Handle 0x0016, DMI type 4, 42 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Core 2 Duo
	Manufacturer: Intel(R) Corporation
	ID: 52 06 02 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 37, Stepping 2
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
	Version: Intel(R) Core(TM) i5 CPU       M 520  @ 2.40GHz
	Voltage: 0.0 V
	External Clock: 1066 MHz
	Max Speed: 2400 MHz
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x001A
	L2 Cache Handle: 0x0019
	L3 Cache Handle: 0x0017
	Serial Number: Not Specified
	Asset Tag: FFFF
	Part Number: Not Specified
	Core Count: 2
	Core Enabled: 2
	Thread Count: 4
	Characteristics:
		64-bit capable

Handle 0x0017, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 3072 kB
	Maximum Size: 3072 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Other

Handle 0x0018, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 32 kB
	Maximum Size: 32 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0019, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 256 kB
	Maximum Size: 256 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x001A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 32 kB
	Maximum Size: 32 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 4-way Set-associative

Handle 0x001B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: No Error
	Number Of Devices: 2

Handle 0x001C, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: 0x001D
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: Bottom - Slot 1
	Bank Locator: BANK 0
	Type: <OUT OF SPEC>
	Type Detail: Synchronous
	Speed: 1067 MHz
	Manufacturer: Samsung
	Serial Number: 62833B94
	Asset Tag: Unknown
	Part Number: M471B5673EH1-CF8  
	Rank: Unknown

Handle 0x001D, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x001E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x001C
	Memory Array Mapped Address Handle: 0x0023
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x001F, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: 0x0020
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: Bottom - Slot 2
	Bank Locator: BANK 1
	Type: <OUT OF SPEC>
	Type Detail: Synchronous
	Speed: 1067 MHz
	Manufacturer: Samsung
	Serial Number: 62833B59
	Asset Tag: Unknown
	Part Number: M471B5673EH1-CF8  
	Rank: Unknown

Handle 0x0020, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0021, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x001F
	Memory Array Mapped Address Handle: 0x0023
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x0022, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0023, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x001B
	Partition Width: 0

Handle 0x0024, DMI type 127, 4 bytes
End Of Table


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hdparm_hp_pavilion_dv6_2190ev


/dev/sda:

ATA device, with non-removable media
	Model Number:       ST9500420AS                             
	Serial Number:      5VJ39H6G            
	Firmware Revision:  0006HPM1
	Transport:          Serial
Standards:
	Used: unknown (minor revision code 0x0029) 
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
	LBA48  user addressable sectors:  976773168
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:      476940 MBytes
	device size with M = 1000*1000:      500107 MBytes (500 GB)
	cache/buffer size  = 16384 KBytes
	Form Factor: 2.5 inch
	Nominal Media Rotation Rate: 7200
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 254
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
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	DOWNLOAD_MICROCODE
	   *	Advanced Power Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Gen2 signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Phy event counters
	   *	Idle-Unload when NCQ is active
	   *	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	104min for SECURITY ERASE UNIT. 104min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000c5001f502396
	NAA		: 5
	IEEE OUI	: 000c50
	Unique ID	: 01f502396
Checksum: correct

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=smartctl_hp_pavilion_dv6_2190ev

smartctl 5.39.1 2010-01-28 r3054 [x86_64-unknown-linux-gnu] (openSUSE RPM)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 7200.4 series
Device Model:     ST9500420AS
Serial Number:    5VJ39H6G
Firmware Version: 0006HPM1
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Wed Sep  8 16:23:29 2010 EEST
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
data collection: 		 (   0) seconds.
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
recommended polling time: 	 ( 109) minutes.
SCT capabilities: 	       (0x103f)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   116   099   006    Pre-fail  Always       -       104652286
  3 Spin_Up_Time            0x0002   097   097   000    Old_age   Always       -       0
  4 Start_Stop_Count        0x0033   100   100   000    Pre-fail  Always       -       21
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail  Always       -       954953
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       36
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0033   100   100   020    Pre-fail  Always       -       21
183 Runtime_Bad_Block       0x0032   100   253   000    Old_age   Always       -       0
184 End-to-End_Error        0x0033   100   100   097    Pre-fail  Always       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always       -       0
188 Command_Timeout         0x0032   100   097   000    Old_age   Always       -       36
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
190 Airflow_Temperature_Cel 0x0022   064   048   045    Old_age   Always       -       36 (Lifetime Min/Max 24/36)
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       2
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always       -       1106
194 Temperature_Celsius     0x0022   036   052   000    Old_age   Always       -       36 (0 21 0 0)
195 Hardware_ECC_Recovered  0x001a   050   048   000    Old_age   Always       -       104652286
196 Reallocated_Event_Count 0x0033   100   100   036    Pre-fail  Always       -       0
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
254 Free_Fall_Sensor        0x0032   100   100   000    Old_age   Always       -       0

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


--4Ckj6UjgE2iN1+kY--
