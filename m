From: Gavin Cameron <gavin@gavsworld.net>
Subject: libata problems
Date: Fri, 18 Jul 2008 16:59:09 +0100
Message-ID: <4880BDCD.4030104@gavsworld.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010800070306030400020203"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ptb-relay01.plus.net ([212.159.14.212]:49694 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYGSCVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2008 22:21:41 -0400
Received: from [80.229.219.204] (helo=picard.gavsworld.net)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1KJsMQ-0004HM-6t
	for linux-ide@vger.kernel.org; Fri, 18 Jul 2008 16:59:11 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800070306030400020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I was hunting for a solution to my problem in the "known issues" section 
of the Wiki - my problem being fully described here:
http://forums.fedoraforum.org/forum/showthread.php?t=192186

Would you be able to shed any light on this problem? Do you require any 
other information from me?

Anyway, as a side issue, I read the first problem about frequent head 
unloads and noticed it as another problem I have. So, as requested, 
attached are the outputs of "dmidecode" and "hdparm"

This is definitelly happening on my PC called "picard" and occasionally 
happens on "kirk" and I'm not sure which drive(s) in "picard" so I've 
attached both.

Regards,
Gavin.

p.s. I'm about to go on holiday, so won't be able to do anything until 
the 27th July.

-- 
I grew a dodgy looking moustache in Speptember
for mens cancer research. Want to donate?:
https://www.bmycharity.com/GavinCameron
--

Gavin Cameron                   http://www.gavsworld.net/
aka "Q" - KIDDA Treasurer           http://www.kidda.org/

"If at first you don't succeed ... reboot and try again!"

Free e-mail SSL signatures at http://cert.startcom.org/

--------------010800070306030400020203
Content-Type: text/plain;
 name="kirk-dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kirk-dmidecode.txt"

# dmidecode 2.9
SMBIOS 2.3 present.
37 structures occupying 1209 bytes.
Table at 0x000F0120.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Award Software International, Inc.
	Version: 6.00 PG
	Release Date: 09/03/2003
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 256 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 KB floppy services are supported (int 13h)
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
		AGP is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer:                 
	Product Name:                 
	Version: 00000000
	Serial Number: 00000000
	UUID: Not Present
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: GA-7DXE 
	Version:         
	Serial Number: 00000000

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer:                 
	Type: Desktop
	Lock: Not Present
	Version:                 
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket A
	Type: Central Processor
	Family: Athlon
	Manufacturer: AMD
	ID: 62 06 00 00 FF FB 83 03
	Signature: Family 6, Model 6, Stepping 2
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
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
	Version: AMD Athlon(tm) XP
	Voltage: 1.6 V
	External Clock: 133 MHz
	Max Speed: 2000 MHz
	Current Speed: 1733 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0009
	L2 Cache Handle: 0x000A
	L3 Cache Handle: Not Provided
	Serial Number: 00000000
	Asset Tag: 00000000
	Part Number: 00000000

Handle 0x0005, DMI type 5, 22 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 512 MB
	Maximum Total Memory Size: 1536 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		Other
		DIMM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 3
		0x0006
		0x0007
		0x0008
	Enabled Error Correcting Capabilities: None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: BANK_0
	Bank Connections: 0 1
	Current Speed: 10 ns
	Type: Other
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: BANK_1
	Bank Connections: 2 3
	Current Speed: 10 ns
	Type: Other
	Installed Size: 512 MB (Double-bank Connection)
	Enabled Size: 512 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: BANK_2
	Bank Connections: 4 5
	Current Speed: 10 ns
	Type: Other
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 256 KB
	Maximum Size: 256 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator:  
	External Connector Type: None
	Port Type: Other

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator:  
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator:  
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: Other
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator: Detected
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0013, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 9
	Characteristics:
		5.0 V is provided

Handle 0x0014, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 10
	Characteristics:
		5.0 V is provided

Handle 0x0015, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 15
	Characteristics:
		5.0 V is provided

Handle 0x0016, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 12
	Characteristics:
		5.0 V is provided

Handle 0x0017, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 13
	Characteristics:
		5.0 V is provided

Handle 0x0018, DMI type 9, 13 bytes
System Slot Information
	Designation: AGP
	Type: 32-bit AGP
	Current Usage: In Use
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Other
	Port Type: USB

Handle 0x001A, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x001B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 1536 MB
	Error Information Handle: Not Provided
	Number Of Devices: 3

Handle 0x001C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: BANK_0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x001D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: BANK_1
	Bank Locator: Bank2/3
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x001E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: BANK_2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x001F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x001B
	Partition Width: 32

Handle 0x0020, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001C
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0021, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0001FFFFC00
	Ending Address: 0x0003FFFFFFF
	Range Size: 524289 kB
	Physical Device Handle: 0x001D
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0022, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x0003FFFFC00
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 kB
	Physical Device Handle: 0x001E
	Memory Array Mapped Address Handle: 0x001F
	Partition Row Position: 1

Handle 0x0023, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0024, DMI type 127, 4 bytes
End Of Table


--------------010800070306030400020203
Content-Type: text/plain;
 name="kirk-hdparm-sda.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kirk-hdparm-sda.txt"


/dev/sda:

ATA device, with non-removable media
	Model Number:       Maxtor 6E040L0                          
	Serial Number:      E13WLVCE            
	Firmware Revision:  NAR61590
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0 
	Supported: 7 6 5 4 
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   80293248
	device size with M = 1024*1024:       39205 MBytes
	device size with M = 1000*1000:       41110 MBytes (41 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: disabled
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
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
	    	Advanced Power Management feature set
	    	SET_MAX security extension
	   *	Automatic Acoustic Management feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

--------------010800070306030400020203
Content-Type: text/plain;
 name="picard-dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="picard-dmidecode.txt"

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
	Bank Connections: 6 1
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 6 1
	Current Speed: 25 ns
	Type: ECC DIMM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown
	Installed Size: Not Installed
	Enabled Size: Not Installed
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
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
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
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer2
	Serial Number: SerNum2
	Asset Tag: AssetTagNum2
	Part Number: PartNum2

Handle 0x0031, DMI type 126, 19 bytes
Inactive

Handle 0x0032, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x002A
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer3
	Serial Number: SerNum3
	Asset Tag: AssetTagNum3
	Part Number: PartNum3

Handle 0x0033, DMI type 126, 19 bytes
Inactive

Handle 0x0034, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0035, DMI type 127, 4 bytes
End Of Table


--------------010800070306030400020203
Content-Type: text/plain;
 name="picard-hdparm-sda.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="picard-hdparm-sda.txt"


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

--------------010800070306030400020203
Content-Type: text/plain;
 name="picard-hdparm-sdb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="picard-hdparm-sdb.txt"


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
	Advanced power management level: disabled
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
	    	Advanced Power Management feature set
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

--------------010800070306030400020203--
