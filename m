From: James Brown <jbrownfirst@gmail.com>
Subject: Drives which perform frequent head unloads under Linux
Date: Thu, 28 Jul 2011 08:11:13 +0000
Message-ID: <4E3119A1.2090003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020306090102050503070303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55063 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab1G1ILk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jul 2011 04:11:40 -0400
Received: by qyk9 with SMTP id 9so1396082qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 28 Jul 2011 01:11:39 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306090102050503070303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have the above problem with TOSHIBA MK5076GSX

The needed logs are attached (I have excluded serial numbers and etc.
from them, for protecting of my privacy).
I inform you that the drive unloads the head per-hour under nominal
usage without any adjustment about 8 - 10 times.

Yours,

                    James

--------------020306090102050503070303
Content-Type: text/plain;
 name="dmidecode.logs"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmidecode.logs"

~$ sudo dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
34 structures occupying 1108 bytes.
Table at 0x000DF810.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Acer   
	Version: v1.3206
	Release Date: 06/04/07
	Address: 0xE63F0
	Runtime Size: 105488 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer, inc.
	Product Name: TravelMate 3040 
	Version: Not Applicable
	Serial Number: XXXXXXXXXXXXXXXXXXX
	UUID: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer, Inc.
	Product Name: Ness2           
	Version: Not Applicable
	Serial Number: XXXXXXXXXXXXXXXXXXXX

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Acer, Inc.
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:                                  
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU         T5
	Voltage: 3.3 V
	External Clock: 166 MHz
	Max Speed: 1666 MHz
	Current Speed: 1666 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 2048 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J19
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J23
	Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J11
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J11
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000C, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x000D, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel Calistoga
	String 2: Chipset CRB Platform

Handle 0x000E, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x000F, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Invalid, Not Full
	Change Token: 0x00000090
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0010, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0011, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0012, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0010
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0013, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x0010
	Partition Width: 0

Handle 0x0014, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0015, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0012
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0016, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0017, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Enabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x0018, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0019, DMI type 26, 20 bytes
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001A, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x001B
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001B, DMI type 28, 20 bytes
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001C, DMI type 29, 20 bytes
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x001E, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001F, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 1F 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x0020, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 20 00 FF FF

Handle 0x0021, DMI type 127, 4 bytes
End Of Table



--------------020306090102050503070303
Content-Type: text/x-log;
 name="hdparm_I.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdparm_I.log"


/dev/sda:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK5076GSX                       
	Serial Number:      xxxxxxxxxxxx
	Firmware Revision:  GS001A  
	Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6
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
	LBA48  user addressable sectors:  976773168
	Logical  Sector size:                   512 bytes
	Physical Sector size:                   512 bytes
	device size with M = 1024*1024:      476940 MBytes
	device size with M = 1000*1000:      500107 MBytes (500 GB)
	cache/buffer size  = 8192 KBytes
	Form Factor: 2.5 inch
	Nominal Media Rotation Rate: 5400
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 254
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
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
	   *	SET_MAX security extension
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
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Gen2 signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	Idle-Unload when NCQ is active
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
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
		frozen
	not	expired: security count
		supported: enhanced erase
	156min for SECURITY ERASE UNIT. 156min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000039xxxxxxxx
	NAA		: 5
	IEEE OUI	: 000039
	Unique ID	: xxxxxxxxx
Checksum: correct

--------------020306090102050503070303
Content-Type: text/x-log;
 name="smartctl.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="smartctl.log"

smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Device Model:     TOSHIBA MK5076GSX
Serial Number:    xxxxxxxxxxxx
Firmware Version: GS001A
User Capacity:    500 107 862 016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Jul 28 09:35:09 2011 MSD
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
data collection: 		 ( 120) seconds.
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
recommended polling time: 	 ( 166) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   050    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   100   100   050    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0027   100   100   001    Pre-fail  Always       -       1992
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       32
  5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   050    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   050    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       47
 10 Spin_Retry_Count        0x0033   100   100   030    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       32
191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       5
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always       -       524
194 Temperature_Celsius     0x0022   100   100   000    Old_age   Always       -       43 (Lifetime Min/Max 27/53)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       0
220 Disk_Shift              0x0002   100   100   000    Old_age   Always       -       90
222 Loaded_Hours            0x0032   100   100   000    Old_age   Always       -       43
223 Load_Retry_Count        0x0032   100   100   000    Old_age   Always       -       0
224 Load_Friction           0x0022   100   100   000    Old_age   Always       -       0
226 Load-in_Time            0x0026   100   100   000    Old_age   Always       -       304
240 Head_Flying_Hours       0x0001   100   100   001    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%        46         -
# 2  Extended offline    Aborted by host               90%        35         -
# 3  Extended offline    Aborted by host               90%        34         -

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


--------------020306090102050503070303--
