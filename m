From: Holger Hasselmann <hhasselm@web.de>
Subject: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Mon, 14 Sep 2009 19:50:10 +0200
Message-ID: <4AAE8252.8000206@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060509010204030308060901"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:50486 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbZINRuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2009 13:50:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

This is a multi-part message in MIME format.
--------------060509010204030308060901
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello Tejun,

I want let you know, that the following laptop would need to be included
in the list of the 32bit DMA boards.

First I have used the snapshot 2.6.31-git and was not able to boot until
I reversed the patch 58a09b38cfcd700b796ea07ae3d2e0efbb28b561.

I have tried it with the snapshot 2.6.31-git2 and was not able to boot.

I have checked the latest bios (1.10c) for this laptop and it did not 
worked.

I will attache the dmidecoder output (don't know if this helps).

Hope this info is helpfull.

Thanks and best Regards,
Holger


--------------060509010204030308060901
Content-Type: text/plain;
 name="dmi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi.txt"

# dmidecode 2.10
SMBIOS 2.4 present.
31 structures occupying 1050 bytes.
Table at 0xA7EE3000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD.
	Version: 1.08C
	Release Date: 01/18/08
	Address: 0xE5770
	Runtime Size: 108688 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 1.0
	Firmware Revision: 1.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: FUJITSU SIEMENS
	Product Name: AMILO Pa 2510
	Version: 10600937229
	Serial Number: DUML004930
	UUID: 800283B8-02FC-DC11-87DE-C732C78E212C
	Wake-up Type: Power Switch
	SKU Number: 12345678
	Family: AMILO

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: FUJITSU SIEMENS
	Product Name: F37     
	Version: Not Specified
	Serial Number: 532536A023

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: FUJITSU SIEMENS
	Type: Notebook
	Lock: Not Present
	Version: Not Specified
	Serial Number: DUML004930
	Asset Tag: 00000000000
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket S1G1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 72, Stepping 2
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
	Version: Engineering Samplenology
	Voltage: 1.4 V
	External Clock: 200 MHz
	Max Speed: 4000 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 kB
	Maximum Size: 64 kB
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
	Socket Designation: H0 L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 kB
	Maximum Size: 1024 kB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Modem
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB 4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: USB 5
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: None
	Internal Connector Type: None
	External Reference Designator: HeadPhone
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0011, DMI type 9, 13 bytes
System Slot Information
	Designation: New Card
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0012, DMI type 9, 13 bytes
System Slot Information
	Designation: Mini Card
	Type: x1 PCI Express
	Current Usage: Available
	Length: Other
	ID: 0
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0013, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0014, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x0015, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000000
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0017, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0016
	Error Information Handle: 0xFF3E
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 1
	Bank Locator: Channel B0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0016
	Error Information Handle: 0xFF3E
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 2
	Locator: DIMM 2
	Bank Locator: Channel B1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 800 MHz
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0019, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x001A, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x0016
	Partition Width: 0

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0017
	Memory Array Mapped Address Handle: 0x001A
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 6

Handle 0x001C, DMI type 22, 26 bytes
Portable Battery
	Location: MAIN
	Manufacturer: CELXPERT
	Manufacture Date: SAMSUNG
	Serial Number: e00825401C08C02008128
	Name:     
	Chemistry: Lithium Ion
	Design Capacity: 48840 mWh
	Design Voltage: 11100 mV
	SBDS Version: 1.10
	Maximum Error: 1%
	OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001E, DMI type 127, 4 bytes
End Of Table



--------------060509010204030308060901--
