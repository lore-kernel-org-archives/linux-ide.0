From: "klaus v." <klaus.viertel@freenet.de>
Subject: crazy harddisc unloading
Date: Fri, 26 Sep 2008 19:20:14 +0200
Message-ID: <1222449614.6178.7.camel@tithonus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+WdTqHr94lNfQmSBhf/D"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout5.freenet.de ([195.4.92.95]:42736 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbYIZRUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Sep 2008 13:20:18 -0400
Received: from [195.4.92.23] (helo=13.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID klaus.viertel@freenet.de) (port 25) (Exim 4.69 #65)
	id 1KjGzH-0001vD-VK
	for linux-ide@vger.kernel.org; Fri, 26 Sep 2008 19:20:15 +0200
Received: from g227210231.adsl.alicedsl.de ([92.227.210.231]:48189)
	by 13.mx.freenet.de with esmtpsa (ID klaus.viertel@freenet.de) (SSLv3:AES256-SHA:256) (port 465) (Exim 4.69 #65)
	id 1KjGzH-00049u-FV
	for linux-ide@vger.kernel.org; Fri, 26 Sep 2008 19:20:15 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-+WdTqHr94lNfQmSBhf/D
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi there,

I've noticed the famous load_cycle bug on my T42 Thinkpad. Since I
trialed and errored on a lot of workarounds, I stumbled over yours.
The necessary output is attached.

Please respond to this email when it has helped (in any way).

regards,
klaus

--=-+WdTqHr94lNfQmSBhf/D
Content-Disposition: attachment; filename=dmidecode
Content-Type: text/plain; name=dmidecode; charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.33 present.
61 structures occupying 2126 bytes.
Table at 0x000E0010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: IBM
	Version: 1RETDLWW (3.17 )
	Release Date: 07/27/2005
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
		AGP is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: IBM
	Product Name: 2373C89
	Version: ThinkPad T42
	Serial Number: L319Z13
	UUID: 9C91A801-47E7-11CB-A402-8D7B253D7AD5
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: IBM
	Product Name: 2373C89
	Version: Not Available
	Serial Number: VJ0BV5940DB

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
	ID: D6 06 00 00 BF F9 E9 AF
	Signature: Type 0, Family 6, Model 13, Stepping 6
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
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
	External Clock: 400 MHz
	Max Speed: 1700 MHz
	Current Speed: 1700 MHz
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
		None

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 1
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 2
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: Not Installed
	Enabled Size: Not Installed
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
	Error Correction Type: Unknown
	System Type: Other
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

Handle 0x0023, DMI type 9, 13 bytes
System Slot Information
	Designation: CardBus Slot 2
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Other
	ID: Adapter 1, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Zoom Video is supported
		Modem ring resume is supported
		PME signal is supported
		Hot-plug devices are supported

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
	String 1: IBM ThinkPad Embedded Controller -[1RHT71WW-3.04    ]-

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
	Status: Invalid, Not Full
	Change Token: 0x00000080
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
	Size: 512 MB
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
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
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
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Array Handle: 0x002C
	Partition Width: 0

Handle 0x0031, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x002D
	Memory Array Mapped Address Handle: 0x0030
	Partition Row Position: 1

Handle 0x0032, DMI type 126, 19 bytes
Inactive

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
	Power-On Password Status: Disabled
	Keyboard Password Status: Disabled
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x0036, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0037, DMI type 131, 102 bytes
OEM-specific Type
	Header and Data:
		83 66 37 00 01 00 00 00 00 01 72 03 40 00 AE 80
		00 02 00 00 00 00 00 2A 00 40 2A 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 16 00 80 16 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00
	Strings:
		IBMCFGDATA

Handle 0x0038, DMI type 131, 17 bytes
OEM-specific Type
	Header and Data:
		83 11 38 00 01 02 03 FF FF 1F 00 00 00 00 00 02
		00
	Strings:
		BOOTINF 20h
		BOOTDEV 21h
		KEYPTRS 23h

Handle 0x0039, DMI type 132, 7 bytes
OEM-specific Type
	Header and Data:
		84 07 39 00 01 D8 36

Handle 0x003A, DMI type 133, 5 bytes
OEM-specific Type
	Header and Data:
		85 05 3A 00 01
	Strings:
		KHOIHGIUCCHHII

Handle 0x003B, DMI type 134, 13 bytes
OEM-specific Type
	Header and Data:
		86 0D 3B 00 07 09 05 20 00 00 00 00 00

Handle 0x003C, DMI type 127, 4 bytes
End Of Table


--=-+WdTqHr94lNfQmSBhf/D
Content-Disposition: attachment; filename=hdparm
Content-Type: text/plain; name=hdparm; charset=UTF-8
Content-Transfer-Encoding: 7bit


/dev/sda:

ATA device, with non-removable media
	Model Number:       HITACHI_DK23EA-40B                      
	Serial Number:      1R2091
	Firmware Revision:  00K3A0B5
Standards:
	Used: ATA/ATAPI-5 T13 1321D revision 3 
	Supported: 5 4 3 & some of 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   78140160
	device size with M = 1024*1024:       38154 MBytes
	device size with M = 1000*1000:       40007 MBytes (40 GB)
Capabilities:
	LBA, IORDY(cannot be disabled)
	bytes avail on r/w long: 4
	Standby timer values: spec'd by Vendor, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: disabled
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
	    	Advanced Power Management feature set
	    	Address Offset Reserved Area Boot
	    	SET_MAX security extension
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	SMART error logging
	   *	SMART self-test
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	40min for SECURITY ERASE UNIT. 40min for ENHANCED SECURITY ERASE UNIT.
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--=-+WdTqHr94lNfQmSBhf/D--

