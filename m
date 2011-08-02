From: Timo Juhani Lindfors <timo.lindfors@iki.fi>
Subject: frequent spin down (acer aspire 5552 / WDC WD5000BPVT-22HXZT1, FwRev=01.01A01)
Date: Wed, 03 Aug 2011 02:27:03 +0300
Message-ID: <84oc07jsxk.fsf@sauna.l.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:40258 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab1HBX1G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2011 19:27:06 -0400
Received: from sauna.l.org (84.248.66.131) by jenni2.inet.fi (8.5.133)
        id 4DF73E8502347D6E for linux-ide@vger.kernel.org; Wed, 3 Aug 2011 02:27:04 +0300
Received: from lindi by sauna.l.org with local (Exim 4.72)
	(envelope-from <timo.lindfors@iki.fi>)
	id 1QoOMZ-0007xe-86
	for linux-ide@vger.kernel.org; Wed, 03 Aug 2011 02:27:03 +0300
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

the hdd in my acer aspire 5552 seems to aggressively (about once a
minute) spin down in grub prompt, single user mode and gnome. This
happens both on AC power and battery.

hdparm -S 0 /dev/sda

does not help but

hdparm -B 255 /dev/sda

seems to help. I'm using debian squeeze. More information from the
installation is available at http://lindi.iki.fi/lindi/acer_aspire_5552/
but here are the basics:

/dev/sda:

 Model=WDC WD5000BPVT-22HXZT1, FwRev=01.01A01, SerialNo=WD-WXF1AC074916
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=50
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=976773168
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode


# dmidecode 2.9
SMBIOS 2.6 present.
51 structures occupying 1880 bytes.
Table at 0x000E6FD0.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Acer
	Version: V2.10
	Release Date: 02/21/2011
	ROM Size: 2048 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Targeted content distribution is supported
	BIOS Revision: 10.240

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Acer
	Product Name: Aspire 5552
	Version: V2.10
	Serial Number: LXR44022161140C7011601
	UUID: C6EE5D01-5D00-11E0-A88C-B870F46C6ADA
	Wake-up Type: Power Switch
	SKU Number: 123456789
	Family: Type1Family

Handle 0x0002, DMI type 2, 16 bytes
Base Board Information
	Manufacturer: Acer
	Product Name: JE51_DN
	Version: V2.10
	Serial Number: LXR44022161140C7011601
	Asset Tag:                  
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Acer
	Type: Notebook
	Lock: Not Present
	Version: V2.10
	Serial Number: LXR44022161140C7011601
	Asset Tag:                  
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
	Designation: J6C1
	Type: x16 <OUT OF SPEC>
	Current Usage: Available
	Length: Long
	Characteristics:
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0005, DMI type 9, 17 bytes
System Slot Information
	Designation: J8C1
	Type: x1 <OUT OF SPEC>
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
	Designation: J7C1
	Type: x1 <OUT OF SPEC>
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0007, DMI type 9, 17 bytes
System Slot Information
	Designation: J8D1
	Type: x1 <OUT OF SPEC>
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0008, DMI type 9, 17 bytes
System Slot Information
	Designation: J8B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 5
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		Cardbus is supported
		Modem ring resume is supported
		PME signal is supported
		SMBus signal is supported

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: Acer
	String 2: zB-xne9zlRXGO
	String 3: XHaEJI7gJn+MZ
	String 4: DN-1RUDylKlj1

Handle 0x000A, DMI type 12, 5 bytes
System Configuration Options
	Option 1: SMI:00B0C102
	Option 2: DSN:                               
	Option 3: DSN:                               
	Option 4: DSN:                               
	Option 5: TIM:            

Handle 0x000B, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Touch Pad
	Interface: PS/2
	Buttons: 4

Handle 0x000C, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000D, DMI type 129, 5 bytes
OEM-specific Type
	Header and Data:
		81 05 0D 00 4F
	Strings:
		em Test 1
		Oem Test 2

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: Network
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G2
	Internal Connector Type: On Board Floppy
	External Reference Designator: OnBoard Floppy Type
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J7J1
	Internal Connector Type: On Board IDE
	External Reference Designator: OnBoard Primary IDE
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: TV OUT
	External Connector Type: Mini DIN
	Port Type: Video Port

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: CRT
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Microphone In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Speaker Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001E, DMI type 40, 18 bytes
Unknown Type
	Header and Data:
		28 12 1E 00 02 06 04 00 05 01 AA 07 00 00 05 02
		DC 05
	Strings:
		PCIExpressx16
		Compiler Version: VC 9.0

Handle 0x001F, DMI type 41, 11 bytes
Unknown Type
	Header and Data:
		29 0B 1F 00 01 85 01 00 00 00 01
	Strings:
		82567LM Gigabit Network Connection

Handle 0x0020, DMI type 4, 42 bytes
Processor Information
	Socket Designation: Socket S1G4
	Type: Central Processor
	Family: <OUT OF SPEC>
	Manufacturer: AMD processor
	ID: 63 0F 10 00 FF FB 8B 17
	Version: AMD Athlon(tm) II P340 Dual-Core Processor
	Voltage: 1.2 V
	External Clock: 200 MHz
	Max Speed: 2200 MHz
	Current Speed: 2200 MHz
	Status: Populated, Enabled
	Upgrade: <OUT OF SPEC>
	L1 Cache Handle: 0x0021
	L2 Cache Handle: 0x0022
	L3 Cache Handle: Not Provided
	Serial Number: NotSupport
	Asset Tag: FFFF
	Part Number: FFFF
	Core Count: 2
	Core Enabled: 2
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0021, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Disabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 256 KB
	Maximum Size: 256 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 2-way Set-associative

Handle 0x0022, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Disabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0023, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 6 GB
	Error Information Handle: No Error
	Number Of Devices: 2

Handle 0x0024, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: 0x0025
	Total Width: 64 bits
	Data Width: 8 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: <OUT OF SPEC>
	Type Detail: Synchronous
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Kingston
	Serial Number: 8813843C
	Asset Tag: Unknown
	Part Number: ACR256X64D3S1333C9

Handle 0x0025, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0026, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0027, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0024
	Memory Array Mapped Address Handle: 0x002D
	Partition Row Position: 1

Handle 0x0028, DMI type 17, 28 bytes
Memory Device
	Array Handle: 0x0023
	Error Information Handle: 0x0029
	Total Width: 64 bits
	Data Width: 8 bits
	Size: 4096 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK0
	Type: <OUT OF SPEC>
	Type Detail: Synchronous
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Nanya Technology
	Serial Number: A14B1815
	Asset Tag: Unknown
	Part Number: NT4GC64B8HB0NS-CG 

Handle 0x0029, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x002A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: None
	Current Speed: Unknown
	Type: Unknown DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x002B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x0017FFFFFFF
	Range Size: 4 GB
	Physical Device Handle: 0x0028
	Memory Array Mapped Address Handle: 0x002D
	Partition Row Position: 1

Handle 0x002C, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x002D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0017FFFFFFF
	Range Size: 6 GB
	Physical Array Handle: 0x0023
	Partition Width: 0

Handle 0x002E, DMI type 5, 20 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		Unknown
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 4096 MB
	Maximum Total Memory Size: 8192 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		Other
	Memory Module Voltage: Unknown
	Associated Memory Slots: 2
		0x0026
		0x002A
	Enabled Error Correcting Capabilities:
		None

Handle 0x002F, DMI type 170, 82 bytes
OEM-specific Type
	Header and Data:
		AA 52 2F 00 01 00 09 00 7F 00 0F 00 0E 00 03 02
		01 00 23 02 08 00 21 02 01 00 41 02 04 00 42 02
		20 00 43 02 40 00 44 02 08 00 45 02 10 00 48 02
		01 00 49 02 02 00 61 02 08 00 62 02 01 00 63 02
		02 00 64 02 04 00 81 02 04 00 82 02 08 00 83 02
		02 00

Handle 0x0030, DMI type 171, 29 bytes
OEM-specific Type
	Header and Data:
		AB 1D 30 00 01 02 10 12 97 02 E4 14 92 16 04 8F
		05 02 B0 05 02 10 83 43 07 8C 16 2E 00

Handle 0x0031, DMI type 172, 6 bytes
OEM-specific Type
	Header and Data:
		AC 06 31 00 01 00

Handle 0x0032, DMI type 127, 4 bytes
End Of Table



-Timo
