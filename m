From: Gavin Cameron <gavin@gavsworld.net>
Subject: Frequent Head Unload Problem
Date: Tue, 14 Apr 2009 17:52:14 +0100
Message-ID: <49E4BF3E.9040105@gavsworld.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050301040904060704060407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:57845 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754423AbZDNRDC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 13:03:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301040904060704060407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

It's been a while since I've been in touch. I previously had 2 problems:
1. PATA DVD writer not working
2. Frequent HDD head unloads

I eventually caved in and replaced the PATA DVD drive with a SATA and 
that works perfectly. However, this head unloading in really annoying 
primarily because the noise the drives makes just doens't sound healthy 
- it's a high pitch squeal and then a couple of clicks.

Anyway, a reminder of the basic system:
     * ASUS M2V M/B (VIA K8T890 / VIA VT8237A chipset)
     * AMD Athlon 64 X2 6000+
     * SATA LiteOn DVD RAM/RW
     * Ubuntu 9.04 (Beta) - kernel 2.6.28-11-generic

Since I last was in touch, I've converted the system to Ubuntu (I was 
hoping that it was a Fedora quirk) with no change in head unloads with 
either 8.10 or 9.04.

I've tried the following in /etc/rc.local :
/sbin/hdparm -B 254 /dev/sda
/sbin/hdparm -B 254 /dev/sdb

Which makes no difference at all. Also, I tried setting 255, but that 
also had no affect.

I've included all of the normal files that I think you may need:

sudo dmidecode > dmidecode.txt
sudo hdparm -I /dev/sda > hdparm-sda.txt
sudo hdparm -I /dev/sdb > hdparm-sdb.txt
sudo smartctl -a /dev/sda > smartctl-sda.txt
sudo smartctl -a /dev/sdb > smartctl-sdb.txt
lsmod > lsmod.txt

Hopefully you can find the root of the problem.

Best regards,
Gavin.

--------------050301040904060704060407
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.4 present.
54 structures occupying 2032 bytes.
Table at 0x000F0750.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 2101   
	Release Date: 02/21/2008
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
	BIOS Revision: 8.12

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: System manufacturer
	Product Name: System Product Name
	Version: System Version
	Serial Number: System Serial Number
	UUID: 400430B4-74FE-D511-B95F-E66E8F0C9B51
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: M2V
	Version: Rev 1.xx
	Serial Number: MB-1234567890
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
	Manufacturer: Chassis Manufacture
	Type: Desktop
	Lock: Not Present
	Version: Chassis Version
	Serial Number: Chassis Serial Number
	Asset Tag: Asset-1234567890
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000001
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: SOCKET AM2
	Type: Central Processor
	Family: Athlon 64
	Manufacturer: AMD              
	ID: 33 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 67, Stepping 3
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
	Version: AMD Athlon(tm) 64 X2 Dual Core Processor 6000+      
	Voltage: 1.5 V
	External Clock: 200 MHz
	Max Speed: 3000 MHz
	Current Speed: 3000 MHz
	Status: Populated, Enabled
	Upgrade: Socket 939
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
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
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

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 6 0
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 6 0
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: 6 0
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: 6 0
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Single-bank Connection)
	Enabled Size: 1024 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Keyboard
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB1
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB2
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB3
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB4
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: None
	External Reference Designator: LPT1
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line_Out
	Internal Connector Type: None
	External Reference Designator: Audio Line_Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line_In
	Internal Connector Type: None
	External Reference Designator: Audio Line_In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Mic_In
	Internal Connector Type: None
	External Reference Designator: Audio Mic_In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LAN1
	Internal Connector Type: None
	External Reference Designator: LAN1
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRI IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SEC IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SB_SATA1
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SB_SATA2
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FLOPPY
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB5
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB6
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB7
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB8
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0020, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEx1
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 13
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0021, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEx16
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	ID: 11
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0022, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0023, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0024, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI3
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0025, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI4
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 4
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0026, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   To Be Filled By O.E.M.

Handle 0x0027, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.
	String 2: To Be Filled By O.E.M.
	String 3: To Be Filled By O.E.M.
	String 4: To Be Filled By O.E.M.

Handle 0x0028, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0029, DMI type 15, 35 bytes
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

Handle 0x002A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x002B, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0012FFFFFFF
	Range Size: 4864 MB
	Physical Array Handle: 0x002A
	Partition Width: 0

Handle 0x002C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz (1.2 ns)
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x002D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x002C
	Memory Array Mapped Address Handle: 0x002B
	Partition Row Position: 1

Handle 0x002E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz (1.2 ns)
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x002F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x002E
	Memory Array Mapped Address Handle: 0x002B
	Partition Row Position: 1

Handle 0x0030, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz (1.2 ns)
	Manufacturer: Manufacturer2
	Serial Number: SerNum2
	Asset Tag: AssetTagNum2
	Part Number: PartNum2

Handle 0x0031, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000BFFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0030
	Memory Array Mapped Address Handle: 0x002B
	Partition Row Position: 1

Handle 0x0032, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002A
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz (1.2 ns)
	Manufacturer: Manufacturer3
	Serial Number: SerNum3
	Asset Tag: AssetTagNum3
	Part Number: PartNum3

Handle 0x0033, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x000C0000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0032
	Memory Array Mapped Address Handle: 0x002B
	Partition Row Position: 1

Handle 0x0034, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0035, DMI type 127, 4 bytes
End Of Table


--------------050301040904060704060407
Content-Type: text/plain;
 name="hdparm-sda.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm-sda.txt"


/dev/sda:

ATA device, with non-removable media
	Model Number:       Hitachi HDS721616PLAT80                 
	Serial Number:      PV6904Z21D6ZRN
	Firmware Revision:  P22OA8BA
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 1 
	Supported: 7 6 5 4 & some of 8
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
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: disabled
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
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
	    	Power-Up In Standby feature set
	    	SET_FEATURES required to spinup after power up
	    	Address Offset Reserved Area Boot
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	64-bit World wide name
	   *	URG for READ_STREAM[_DMA]_EXT
	   *	URG for WRITE_STREAM[_DMA]_EXT
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
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
	64min for SECURITY ERASE UNIT. 
Logical Unit WWN Device Identifier: 5000cca325d3a633
	NAA		: 5
	IEEE OUI	: cca
	Unique ID	: 325d3a633
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--------------050301040904060704060407
Content-Type: text/plain;
 name="hdparm-sdb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm-sdb.txt"


/dev/sdb:

ATA device, with non-removable media
	Model Number:       Maxtor 6L200P0                          
	Serial Number:      L409V7GH            
	Firmware Revision:  BAH41G10
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0 
	Supported: 7 6 5 4 & some of 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  398297088
	device size with M = 1024*1024:      194481 MBytes
	device size with M = 1000*1000:      203928 MBytes (203 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 254
	Recommended acoustic management value: 192, current value: 254
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
	   *	WRITE_VERIFY command
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
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	URG for READ_STREAM[_DMA]_EXT
	   *	URG for WRITE_STREAM[_DMA]_EXT
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Data Tables (AC5)
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 1 determined by the jumper
Checksum: correct

--------------050301040904060704060407
Content-Type: text/plain;
 name="smartctl-sda.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl-sda.txt"

smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Hitachi Deskstar 7K160
Device Model:     Hitachi HDS721616PLAT80
Serial Number:    PV6904Z21D6ZRN
Firmware Version: P22OA8BA
User Capacity:    160,041,885,696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 1
Local Time is:    Tue Apr 14 17:42:30 2009 BST
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
data collection: 		 (2865) seconds.
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
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  48) minutes.
SCT capabilities: 	       (0x003f)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   100   100   050    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0007   120   120   024    Pre-fail  Always       -       166 (Average 165)
  4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always       -       806
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   020    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0012   100   100   000    Old_age   Always       -       3664
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       797
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       873
193 Load_Cycle_Count        0x0012   100   100   000    Old_age   Always       -       873
194 Temperature_Celsius     0x0002   200   200   000    Old_age   Always       -       30 (Lifetime Min/Max 9/38)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       0

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


--------------050301040904060704060407
Content-Type: text/plain;
 name="smartctl-sdb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl-sdb.txt"

smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Maxtor DiamondMax 10 family (ATA/133 and SATA/150)
Device Model:     Maxtor 6L200P0
Serial Number:    L409V7GH
Firmware Version: BAH41G10
User Capacity:    203,928,109,056 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Tue Apr 14 17:42:35 2009 BST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x05)	Offline data collection activity
					was aborted by an interrupting command from host.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (1622) seconds.
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
recommended polling time: 	 (  82) minutes.
SCT capabilities: 	       (0x0021)	SCT Status supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   204   204   063    Pre-fail  Always       -       11089
  4 Start_Stop_Count        0x0032   252   252   000    Old_age   Always       -       2526
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline      -       0
  7 Seek_Error_Rate         0x000a   234   225   000    Old_age   Always       -       16
  8 Seek_Time_Performance   0x0027   246   238   187    Pre-fail  Always       -       60653
  9 Power_On_Minutes        0x0032   229   229   000    Old_age   Always       -       698h+16m
 10 Spin_Retry_Count        0x002b   253   205   157    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   249   249   000    Old_age   Always       -       1643
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always       -       0
194 Temperature_Celsius     0x0032   037   253   000    Old_age   Always       -       29
195 Hardware_ECC_Recovered  0x000a   253   251   000    Old_age   Always       -       21746
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   194   001   000    Old_age   Offline      -       768
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always       -       0
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always       -       0
207 Spin_High_Current       0x002a   253   209   000    Old_age   Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age   Always       -       0
209 Offline_Seek_Performnce 0x0024   240   240   000    Old_age   Offline      -       158
210 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
212 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0

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


--------------050301040904060704060407
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod.txt"

Module                  Size  Used by
binfmt_misc            18572  1 
bridge                 63904  0 
stp                    11140  1 bridge
bnep                   22912  2 
input_polldev          12688  0 
video                  29204  0 
output                 11648  1 video
lp                     19588  0 
snd_usb_audio         108832  1 
snd_pcm_oss            52352  0 
snd_mixer_oss          24960  1 snd_pcm_oss
snd_hda_intel         557364  5 
snd_pcm                99336  4 snd_usb_audio,snd_pcm_oss,snd_hda_intel
snd_seq_dummy          11524  0 
snd_usb_lib            27392  1 snd_usb_audio
snd_seq_oss            41984  0 
snd_seq_midi           15744  0 
snd_rawmidi            33920  2 snd_usb_lib,snd_seq_midi
arc4                   10240  2 
snd_seq_midi_event     16512  2 snd_seq_oss,snd_seq_midi
snd_hwdep              16776  1 snd_usb_audio
ecb                    11392  2 
snd_seq                66272  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              34064  2 snd_pcm,snd_seq
snd_seq_device         16276  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    78792  22 snd_usb_audio,snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_pcm,snd_seq_oss,snd_rawmidi,snd_hwdep,snd_seq,snd_timer,snd_seq_device
ath5k                 116224  0 
joydev                 20864  0 
soundcore              16800  1 snd
mac80211              251144  1 ath5k
pwc                    96064  0 
snd_page_alloc         18704  2 snd_hda_intel,snd_pcm
pcmcia                 47640  0 
led_class              13064  1 ath5k
compat_ioctl32         18304  1 pwc
hid_logitech           18560  0 
ff_memless             14472  1 hid_logitech
psmouse                64028  0 
k8temp                 13440  0 
videodev               45184  2 pwc,compat_ioctl32
ppdev                  16904  0 
pcspkr                 11136  0 
usbhid                 47040  1 hid_logitech
shpchp                 44572  0 
serio_raw              14468  0 
cfg80211               43168  2 ath5k,mac80211
yenta_socket           35596  1 
rsrc_nonstatic         19584  1 yenta_socket
pcmcia_core            49188  3 pcmcia,yenta_socket,rsrc_nonstatic
nvidia               8123768  40 
v4l1_compat            23940  1 videodev
parport_pc             45096  1 
parport                49584  3 lp,ppdev,parport_pc
btusb                  21784  2 
i2c_viapro             17304  0 
usb_storage            94912  0 
floppy                 75816  0 
atl1                   45448  0 
mii                    14464  1 atl1
fbcon                  49792  0 
tileblit               11264  1 fbcon
font                   17024  1 fbcon
bitblit                14464  1 fbcon
softcursor             10368  1 bitblit

--------------050301040904060704060407--
