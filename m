From: Vincenzo Ciancia <ciancia@di.unipi.it>
Subject: One drive which perform frequent head unloads under Linux
Date: Thu, 25 Sep 2008 11:14:39 +0200
Message-ID: <1222334079.13537.2.camel@frattaglia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1BX9pB1j2rgrEPYEplri"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from horus.di.unipi.it ([131.114.3.13]:57590 "EHLO
	mailserver.di.unipi.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752269AbYIYJaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Sep 2008 05:30:05 -0400
Received: from [131.114.3.114] (dhcp-131-114-3-114 [131.114.3.114])
	(authenticated bits=0)
	by mailserver.di.unipi.it (8.13.1/8.13.1) with ESMTP id m8P9EmOU005928
	for <linux-ide@vger.kernel.org>; Thu, 25 Sep 2008 11:14:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-1BX9pB1j2rgrEPYEplri
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, I own a toshiba m400 and I already had to replace a disk in less
than one year (luckily, it was covered by warranty). I noticed that
Load_Cycle_Count was indeed increasing. Using hdparm -B 255 fixes it,
but also 254 seems to fix it (and I guess it is better to have some
power management than none at all?). 

I am not subscribed to the list so if you need more information just ask
me. I followed instructions at

http://ata.wiki.kernel.org/index.php/Known_issues#How_to_determine_whether_a_machine_has_this_problem



--=-1BX9pB1j2rgrEPYEplri
Content-Disposition: attachment; filename="dmidecode"
Content-Type: text/plain; name="dmidecode"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.4 present.
44 structures occupying 1406 bytes.
Table at 0x000EC000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: TOSHIBA
	Version: Version 3.80
	Release Date: 05/22/2008
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		VLB is supported
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 3.80
	Firmware Revision: 2.30

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: TOSHIBA
	Product Name: PORTEGE M400
	Version: PPM40E-00700UIT
	Serial Number: 66863013G
	UUID: FB294580-5E55-11DD-8000-B00A66863013
	Wake-up Type: Other
	SKU Number: 0000000000
	Family: 0000000000

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: Portable PC
	Version: Version A0
	Serial Number: $$C063N3Y0

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: TOSHIBA
	Type: Notebook
	Lock: Not Present
	Version: Version 1.0
	Serial Number: 00000000
	Asset Tag: 0000000000
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 32 bytes
Processor Information
	Socket Designation: uFC-PGA Socket
	Type: Central Processor
	Family: <OUT OF SPEC>
	Manufacturer: Intel Corporation
	ID: E8 06 00 00 00 00 00 00
	Version:  
	Voltage: 1.3 V
	External Clock: 166 MHz
	Max Speed: 1660 MHz
	Current Speed: 1660 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0012
	L2 Cache Handle: 0x0013
	L3 Cache Handle: Not Provided

Handle 0x0009, DMI type 5, 20 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: Other
	Current Interleave: Other
	Maximum Memory Module Size: 2048 MB
	Maximum Total Memory Size: 4096 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		Other
		DIMM
		SDRAM
	Memory Module Voltage: Unknown
	Associated Memory Slots: 2
		0x000A
		0x000B
	Enabled Error Correcting Capabilities:
		None

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: SO-DIMM
	Bank Connections: 0 1
	Current Speed: 4 ns
	Type: Other DIMM SDRAM
	Installed Size: 512 MB (Single-bank Connection)
	Enabled Size: 512 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: SO-DIMM
	Bank Connections: 2
	Current Speed: 4 ns
	Type: Other DIMM SDRAM
	Installed Size: 512 MB (Single-bank Connection)
	Enabled Size: 512 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0012, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: 1 ns
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0013, DMI type 7, 19 bytes
Cache Information
	Socket Designation: CPU Internal
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: 1 ns
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: EXTERNAL MONITOR PORT
	External Connector Type: DB-15 female
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: BUILT-IN MODEM PORT
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: BUILT-IN LAN PORT
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: USB PORT
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: USB PORT
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: USB PORT
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: HEADPHONE JACK
	External Connector Type: Mini Jack (headphones)
	Port Type: Other

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: 1394 PORT
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: MICROPHONE JACK
	External Connector Type: Other
	Port Type: Other

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: DOCKING INTERFACE PORT
	External Connector Type: Other
	Port Type: Other

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: WIRELESS LAN
	External Connector Type: Other
	Port Type: Other

Handle 0x0021, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator:  
	Internal Connector Type: None
	External Reference Designator: BLUETOOTH
	External Connector Type: Other
	Port Type: Other

Handle 0x0037, DMI type 9, 13 bytes
System Slot Information
	Designation: PCMCIA0
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: In Use
	Length: Other
	ID: Adapter 1, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Hot-plug devices are supported

Handle 0x0038, DMI type 9, 13 bytes
System Slot Information
	Designation: SD CARD
	Type: Other
	Current Usage: In Use
	Length: Other
	Characteristics:
		3.3 V is provided
		Opening is shared
		Hot-plug devices are supported

Handle 0x0039, DMI type 9, 13 bytes
System Slot Information
	Designation: MEMORY STICK
	Type: Other
	Current Usage: In Use
	Length: Other
	Characteristics:
		3.3 V is provided
		Opening is shared
		Hot-plug devices are supported

Handle 0x003A, DMI type 9, 13 bytes
System Slot Information
	Designation: XD PICTURE CARD
	Type: 8-bit Other
	Current Usage: In Use
	Length: Other
	Characteristics:
		3.3 V is provided
		Opening is shared
		Hot-plug devices are supported

Handle 0x0058, DMI type 10, 20 bytes
On Board Device 1 Information
	Type: Other
	Status: Enabled
	Description: MODEM
On Board Device 2 Information
	Type: Other
	Status: Enabled
	Description: USB
On Board Device 3 Information
	Type: Video
	Status: Enabled
	Description: VIDEO
On Board Device 4 Information
	Type: Ethernet
	Status: Enabled
	Description: ETHERNET
On Board Device 5 Information
	Type: Sound
	Status: Enabled
	Description: SOUND
On Board Device 6 Information
	Type: Other
	Status: Enabled
	Description: WIRELESS LAN
On Board Device 7 Information
	Type: Other
	Status: Enabled
	Description: BLUETOOTH
On Board Device 8 Information
	Type: Other
	Status: Enabled
	Description: 1394

Handle 0x0059, DMI type 11, 5 bytes
OEM Strings
	String 1: 000000,000000

Handle 0x0069, DMI type 12, 5 bytes
System Configuration Options
	Option 1: TOSHIBA

Handle 0x0080, DMI type 15, 23 bytes
System Event Log
	Area Length: 124 bytes
	Header Start Offset: 0x0000
	Data Start Offset: 0x0000
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0003
	Status: Valid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 0

Handle 0x0081, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0082, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0081
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: Unknown
	Locator: DIMM 0
	Bank Locator: CSA 0 & 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: CE00
	Serial Number: F72D5F0D
	Asset Tag: Not Specified
	Part Number: M4 70T6554CZ3-CD5 

Handle 0x0083, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0081
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: Unknown
	Locator: DIMM 1
	Bank Locator: CSA 2 & 3
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: 7F98
	Serial Number: B51FC940
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x0090, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000A03FF
	Range Size: 641 kB
	Physical Array Handle: 0x0081
	Partition Width: 0

Handle 0x0091, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000100000
	Ending Address: 0x0003F8003FF
	Range Size: 1039361 kB
	Physical Array Handle: 0x0081
	Partition Width: 0

Handle 0x00A0, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000A03FF
	Range Size: 641 kB
	Physical Device Handle: 0x0082
	Memory Array Mapped Address Handle: 0x0090
	Partition Row Position: 1

Handle 0x00A1, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000200003FF
	Range Size: 524289 kB
	Physical Device Handle: 0x0082
	Memory Array Mapped Address Handle: 0x0091
	Partition Row Position: 1

Handle 0x00A2, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x000400003FF
	Range Size: 524289 kB
	Physical Device Handle: 0x0083
	Memory Array Mapped Address Handle: 0x0091
	Partition Row Position: 1

Handle 0x00B0, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 2

Handle 0x00B1, DMI type 22, 26 bytes
Portable Battery
	Location: 1st Battery
	Manufacturer: TOSHIBA
	Manufacture Date: 05/10/06
	Serial Number: 2100050940
	Name: LP665E
	Chemistry: Lithium Ion
	Design Capacity: 0 mWh
	Design Voltage: 10800 mV
	SBDS Version: Not Specified
	Maximum Error: Unknown
	OEM-specific Information: 0x00000000

Handle 0x00B7, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Disabled
	Administrator Password Status: Disabled
	Front Panel Reset Status: Disabled

Handle 0x00D0, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x00E0, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 E0 00 5A 5A

Handle 0xFEFF, DMI type 127, 4 bytes
End Of Table


--=-1BX9pB1j2rgrEPYEplri
Content-Disposition: attachment; filename="hdparm-I_sda"
Content-Type: text/plain; name="hdparm-I_sda"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


/dev/sda:

ATA device, with non-removable media
	Model Number:       HTS541080G9SA00                         
	Serial Number:      MPBDL0XKGB63RG
	Firmware Revision:  MB4OC60R
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 1 
	Supported: 7 6 5 4 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  156301488
	LBA48  user addressable sectors:  156301488
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Vendor, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Advanced power management level: 254
	Recommended acoustic management value: 128, current value: 254
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
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	    	Non-Zero buffer offsets in DMA Setup FIS
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	    	In-order data delivery
	   *	Software settings preservation
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	52min for SECURITY ERASE UNIT. 
Checksum: correct

--=-1BX9pB1j2rgrEPYEplri
Content-Disposition: attachment; filename="smartctl-a_sda"
Content-Type: text/plain; name="smartctl-a_sda"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Hitachi Travelstar 5K100 series
Device Model:     HTS541080G9SA00
Serial Number:    MPBDL0XKGB63RG
Firmware Version: MB4OC60R
User Capacity:    80,026,361,856 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
Local Time is:    Thu Sep 25 11:11:52 2008 CEST
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
recommended polling time: 	 (  55) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   062    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   100   100   040    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0007   253   253   033    Pre-fail  Always       -       1
  4 Start_Stop_Count        0x0012   096   096   000    Old_age   Always       -       6779
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   040    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0012   092   092   000    Old_age   Always       -       3611
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   098   098   000    Old_age   Always       -       3635
191 G-Sense_Error_Rate      0x000a   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       30408819
193 Load_Cycle_Count        0x0012   093   093   000    Old_age   Always       -       72343
194 Temperature_Celsius     0x0002   137   137   000    Old_age   Always       -       40 (Lifetime Min/Max 14/57)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


Warning! SMART Selective Self-Test Log Structure error: invalid SMART checksum.
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


--=-1BX9pB1j2rgrEPYEplri--

