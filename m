From: Andrea Turrini <andrea.turrini@gmail.com>
Subject: storage-fixup.conf
Date: Wed, 23 Jul 2008 11:04:41 +0200
Message-ID: <4886F429.8070701@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030009070708000302090806"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:10212 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYGWJCf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 05:02:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so470163ugf.16
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 02:02:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030009070708000302090806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
I've an Acer Aspire 1691wlmi with an Western Digital disk which does 
crazy unloads with openSUSE 11.0.
The same happens to a mac mini which runs an openSUSE 10.3.

I've attached dmidecode and hdparm outputs for both systems.

Regards,
Andrea

--------------030009070708000302090806
Content-Type: text/plain;
 name="hdparm.macmini"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm.macmini"


/dev/sda:

ATA device, with non-removable media
	Model Number:       FUJITSU MHV2080BHPL                     
	Serial Number:      NW83T6526UEP
	Firmware Revision:  0081702E
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 4a 
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
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 254 (0xfe)
	Recommended acoustic management value: 254, current value: 254
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
	   *	DOWNLOAD_MICROCODE
	    	Advanced Power Management feature set
	   *	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	IDLE_IMMEDIATE with UNLOAD
	    	Disable Data Transfer After Error Detection
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	unknown 76[11]
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
	not	supported: enhanced erase
	80min for SECURITY ERASE UNIT. 
Checksum: correct

--------------030009070708000302090806
Content-Type: text/plain;
 name="dmidecode.macmini"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.macmini"

# dmidecode 2.9
SMBIOS 2.4 present.
39 structures occupying 1542 bytes.
Table at 0x000E73F0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Apple Computer, Inc.
	Version:     MM11.88Z.0055.B08.0610121326
	Release Date: 10/12/06
	ROM Size: 2048 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		ACPI is supported
		IEEE 1394 boot is supported
		Smart battery is supported
		Function key-initiated network boot is supported
	BIOS Revision: 0.1

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Apple Computer, Inc.
	Product Name: Macmini1,1
	Version: 1.0
	Serial Number: VM630079U39
	UUID: 9CFE245E-D0C8-BD45-A79F-54EA5FBD3D97
	Wake-up Type: Power Switch
	SKU Number: System SKUNumber
	Family: Napa Mac

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Apple Computer, Inc.
	Product Name: Mac-F4208EC8
	Version: PVT
	Serial Number: 1
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Part Component
	Chassis Handle: 0x0003
	Type: Unknown
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: Apple Computer, Inc.
	Type: Low Profile Desktop
	Lock: Not Present
	Version: Mac-F4208EC8
	Serial Number: VM630079U39
	Asset Tag: Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Other
	Security Status: Other
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: Unspecified
	Contained Elements: 0

Handle 0x0004, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0005, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		<BAD INDEX>
	Currently Installed Language: Not Specified

Handle 0x0106, DMI type 12, 5 bytes
System Configuration Options

Handle 0x0107, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Ethernet
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0108, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: DVI
	External Connector Type: Other
	Port Type: Video Port

Handle 0x0109, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x010A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x010B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x010C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x010D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: FireWire0
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x010E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: iPod Dock
	External Connector Type: Other
	Port Type: Other

Handle 0x010F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Audio Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0110, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Audio Line Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0111, DMI type 9, 13 bytes
System Slot Information
	Designation: AirPort
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Hot-plug devices are supported
		SMBus signal is supported

Handle 0x0112, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: Integrated Graphics Controller 

Handle 0x0113, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Yukon Ethernet Controller

Handle 0x0114, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: Azalia Audio Codec

Handle 0x0115, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: SATA

Handle 0x0116, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: PATA

Handle 0x0117, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 17 01 00 00

Handle 0x0118, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: E8 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU            
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 1660 MHz
	Current Speed: 1660 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x011B
	L2 Cache Handle: 0x0119
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x0119, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x011A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x011B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x011C, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel(R) Corporation
	ID: E8 06 00 00 FF FB E9 BF
	Version: Genuine Intel(R) CPU            
	Voltage: 1.6 V
	External Clock: 166 MHz
	Max Speed: 1660 MHz
	Current Speed: 1660 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x011F
	L2 Cache Handle: 0x011D
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Unknown
	Part Number: Not Specified

Handle 0x011D, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x011E, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x011F, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0120, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0121, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0120
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x00005153
	Asset Tag: Unknown
	Part Number: 0x48594D503536345336344250362D59352020

Handle 0x0122, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0121
	Memory Array Mapped Address Handle: 0x0125
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x0123, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0120
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0xAD00000000000000
	Serial Number: 0x00001299
	Asset Tag: Unknown
	Part Number: 0x48594D503536345336344250362D59352020

Handle 0x0124, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0123
	Memory Array Mapped Address Handle: 0x0125
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x0125, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0120
	Partition Width: 0

Handle 0xFFFD, DMI type 127, 4 bytes
End Of Table


--------------030009070708000302090806
Content-Type: text/plain;
 name="hdparm.acer"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm.acer"


/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD1200BEVE-00WZT0                   
	Serial Number:      WD-WXEY07V39813
	Firmware Revision:  01.01A01
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
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: disabled
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
	    	Advanced Power Management feature set
	   *	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
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
	48min for SECURITY ERASE UNIT. 
Logical Unit WWN Device Identifier: 50014ee2ab72293e
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 2ab72293e
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--------------030009070708000302090806
Content-Type: text/plain;
 name="dmidecode.acer"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.acer"

# dmidecode 2.9
SMBIOS 2.31 present.
36 structures occupying 1076 bytes.
Table at 0x3FEE6000.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Acer   
	Version: 3C25
	Release Date: 03/14/05
	Address: 0xE7A00
	Runtime Size: 99840 bytes
	ROM Size: 512 kB
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
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: Acer, inc.
	Product Name: Aspire 1690     
	Version: Not Applicable
	Serial Number: LXA530507951704D41EM00
	UUID: 80773491-7164-0010-A447-00C09F8D4BF0
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer, Inc.
	Product Name: Crane           
	Version: Not Applicable
	Serial Number: LXA530507951704D41EM00

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer:     , Inc.
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:                                  
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: 52 U
	Number Of Power Cords: 18
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel
	ID: D8 06 00 00 FF FB E9 AF
	Version: A0
	Voltage: 3.3 V
	External Clock: 533 MHz
	Max Speed: 1600 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: Slot 1
	L1 Cache Handle: 0x0008
	L2 Cache Handle: 0x0009
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 5, 20 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 2048 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		FPM
		EDO
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 2
		0x0006
		0x0007
	Enabled Error Correcting Capabilities:
		Unknown

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: M1
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: M2
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes
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

Handle 0x0009, DMI type 7, 19 bytes
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

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J19
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J23
	Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J11
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot J11
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000F, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: ADI

Handle 0x0010, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel Alviso
	String 2: Chipset CRB Platform

Handle 0x0011, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0012, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0013, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 3 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0014, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0013
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0015, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0013
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0016, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0013
	Partition Width: 0

Handle 0x0017, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0014
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0018, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0015
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0019, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x001A, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x001B, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x001C, DMI type 26, 20 bytes
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

Handle 0x001D, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x001E
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001E, DMI type 28, 20 bytes
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

Handle 0x001F, DMI type 29, 20 bytes
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

Handle 0x0020, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0021, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0022, DMI type 136, 8 bytes
OEM-specific Type
	Header and Data:
		88 08 22 00 FF FF 00 00
	Strings:
		..#

Handle 0x0023, DMI type 127, 4 bytes
End Of Table


--------------030009070708000302090806--
