From: Pascal Vandeputte <pascal@asmodeus.be>
Subject: frequent disk head unloads under Linux: additional hardware
Date: Sun, 07 Sep 2008 22:54:48 +0200
Message-ID: <48C43F98.401@asmodeus.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010205090501010505010304"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx-out.mail002.coreserver.be ([83.143.245.22]:44047 "EHLO
	mx-out.mail002.coreserver.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754616AbYIGUyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 16:54:51 -0400
Received: from radiohead.asmodeus.be (unknown [213.49.144.27])
	by mx-out.mail002.coreserver.be (Postfix) with ESMTP id E9FA7A12F8E3
	for <linux-ide@vger.kernel.org>; Sun,  7 Sep 2008 22:54:49 +0200 (CEST)
Received: from [192.168.74.206] (deus.asmodeus.be [192.168.74.206])
	by radiohead.asmodeus.be (Postfix) with ESMTP id BBE661E5243
	for <linux-ide@vger.kernel.org>; Sun,  7 Sep 2008 22:54:49 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205090501010505010304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've been highly frustrated for more than a year about this problem with 
my HP nx7400 laptop and its Seagate Momentus 5400.2 disk (which is 
otherwise a really fine piece of equipment). By switching from Ubuntu to 
openSUSE today, I had to look for the Suse way of fixing this up 
(instead of editing /etc/hdparm.conf on Ubuntu), and I stumbled upon the 
storage-fixup script which is really nice!

As my harddisk isn't included in by default yet, I've attached the 
required information to this e-mail.

Adding this to /etc/storage-fixup.conf solves it:

    # Reported drive model: ST9100824AS
    rule hp-nx7400
    dmi system-manufacturer Hewlett-Packard
    dmi system-product-name HP Compaq nx7400*
    ata model ST9*AS
    act hdparm -B 255 $DEV

An unfortunate side-effect of meddling with the power saving on my 
system occurs at shutdown: for some reason I can clearly hear the drive 
spin down and then suddenly spin up and initialize again before the 
power is killed... This doesn't happen if I leave everything at default 
settings. Restoring the default setting (128) manually before shutting 
down doesn't prevent this either. It's weird and I've been working 
around it by rebooting and using the power button when I see GRUB appear.

I don't know if others have reported similar behavior.

Thanks for the effort,
Greetings,

Pascal Vandeputte


--------------010205090501010505010304
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
23 structures occupying 1029 bytes.
Table at 0x000F3A78.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: 68YGU Ver. F.0C
	Release Date: 07/25/2007
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 15.12
	Firmware Revision: 64.23

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Compaq nx7400 (RH403ET#UUG)
	Version: F.0C
	Serial Number: CNU6460H7D
	UUID: F209EE5C-97D7-DD11-1198-6D990C43B529
	Wake-up Type: Power Switch
	SKU Number: RH403ET#UUG
	Family: 103C_5336AN

Handle 0x0040, DMI type 126, 33 bytes
Inactive

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Hewlett-Packard
	Product Name: 30A2
	Version: KBC Version 40.17
	Serial Number: Not Specified

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Hewlett-Packard
	Type: Notebook
	Lock: Not Present
	Version: Not Specified
	Serial Number: CNU6460H7D
	Asset Tag: CNU6460H7D
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: External Interface Enabled

Handle 0x0041, DMI type 126, 32 bytes
Inactive

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U10
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R)
	ID: F6 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 6
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
	Version: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz
	Voltage: 1.1 V
	External Clock: 166 MHz
	Max Speed: 1833 MHz
	Current Speed: 1833 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: None
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PC CARD-Slot 0
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Short
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: 8

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: www.hp.com
	String 2: ABS 70/71 79 7A 7B 7C

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: No Error
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #1
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 7F7F7F7F7F510000
	Serial Number: 04187626
	Asset Tag: Not Specified
	Part Number: 64T128021HDL3SB   

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #2
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: CE00000000000000
	Serial Number: F45BF1C1
	Asset Tag: Not Specified
	Part Number: M4 70T2953CZ3-CE6 

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 1

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 2

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0085, DMI type 133, 34 bytes
OEM-specific Type
	Header and Data:
		85 22 85 00 01 A0 0F 56 07 2E 07 02 00 2B 00 1B
		00 40 30 00 00 30 2A 02 E0 40 00 00 12 10 15 10
		1B 10
	Strings:
		01101 10/13/2006
		HP                

Handle 0x0086, DMI type 126, 34 bytes
Inactive

Handle 0x0011, DMI type 144, 26 bytes
OEM-specific Type
	Header and Data:
		90 1A 11 00 FF FF FF FF FF FF FF FF FF FF FF FF
		FF FF FF FF FF FF FF FF 00 00

Handle 0x0012, DMI type 127, 4 bytes
End Of Table



--------------010205090501010505010304
Content-Type: text/plain;
 name="hdparm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm"


/dev/sda:

ATA device, with non-removable media
	Model Number:       ST9100824AS                             
	Serial Number:      5PL3FK4S
	Firmware Revision:  7.24    
Standards:
	Supported: 7 6 5 4 
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	17475
	heads		16	15
	sectors/track	63	63
	--
	CHS current addressable sectors:   16513875
	LBA    user addressable sectors:  195371568
	LBA48  user addressable sectors:  195371568
	device size with M = 1024*1024:       95396 MBytes
	device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 128
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
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
	    	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Phy event counters
	   *	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	62min for SECURITY ERASE UNIT. 62min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct


--------------010205090501010505010304
Content-Type: text/plain;
 name="smartctl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl"

smartctl 5.39 2008-05-08 21:56 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-8 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Momentus 5400.2 series
Device Model:     ST9100824AS
Serial Number:    5PL3FK4S
Firmware Version: 7.24
User Capacity:    100,030,242,816 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sun Sep  7 21:20:50 2008 CEST
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
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  63) minutes.
SCT capabilities: 	       (0x0001)	SCT Status supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   118   099   006    Pre-fail  Always       -       185697728
  3 Spin_Up_Time            0x0002   095   094   000    Old_age   Always       -       0
  4 Start_Stop_Count        0x0033   100   100   020    Pre-fail  Always       -       782
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   079   060   030    Pre-fail  Always       -       85069371
  9 Power_On_Hours          0x0032   095   095   000    Old_age   Always       -       4489
 10 Spin_Retry_Count        0x0013   100   100   034    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0033   100   100   020    Pre-fail  Always       -       700
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always       -       0
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
190 Airflow_Temperature_Cel 0x0022   060   055   045    Old_age   Always       -       40 (Lifetime Min/Max 40/40)
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       38
193 Load_Cycle_Count        0x0032   037   037   000    Old_age   Always       -       126746
194 Temperature_Celsius     0x0022   040   045   000    Old_age   Always       -       40 (0 8 0 0)
195 Hardware_ECC_Recovered  0x001a   082   054   000    Old_age   Always       -       195816853
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      1947         -
# 2  Short offline       Completed without error       00%      1945         -

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



--------------010205090501010505010304--
