From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Subject: HP Compaq 2710p notebook suffers too many head unloads
Date: Wed, 2 Jan 2013 00:50:40 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1301020002520.1546@redclaw.mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-d.mimosa.com ([209.161.207.149]:56494 "EHLO gw-d.mimosa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3ABGP1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2013 01:15:27 -0500
Received: from gw-c.mimosa.com (reddoor.mimosa.com [192.139.70.80])
	by gw-d.mimosa.com (8.12.8/8.12.8) with ESMTP id r025oeh4027002
	for <linux-ide@vger.kernel.org>; Wed, 2 Jan 2013 00:50:40 -0500
Received: from redclaw.mimosa.com (redclaw.mimosa.com. [192.139.70.88])
	by gw-c.mimosa.com (8.12.8/8.12.8) with ESMTP id r025oeSO004761
	for <linux-ide@vger.kernel.org>; Wed, 2 Jan 2013 00:50:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The head unloading problem is as described here:
<https://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux>

I am intending that this report contributes to that table.
(Aside: many of the links in that table are broken.)

My computer is an HP Compaq 2710p notebook/tablet.
<http://h18000.www1.hp.com/products/quickspecs/12718_na/12718_na.html>

It has a Toshiba MK8009GAH 80GB 1.8inch 4200RPM Hard Drive.  I
recently replaced a similar one that failed, perhaps due to excessive
head unloading.  The replacement disk was used.

When I got it:
5349	Power_On_Hours
49711	Load_Cycle_Count
9.29	cycles / hour

Now:
5698	Power_On_Hours
87423	Load_Cycle_Count

While I've had it (i.e. delta of above POH and LCC numbers):
349	Power_On_Hours
37712	Load_Cycle_Count
108.06	cycles / hour

It sure looks like Linux is worse than whatever system used the disk
before I got it.

(For what it's worth, my failing disk reported 21252 Power_On_Hours and
526387 Load_Cycle_Count.  This isn't really useful data since I don't
know what OS was used with it before I purchased it last summer.)

"hdparm -B 254 /dev/sda" stops the count running up.
"hdparm -B 255 /dev/sda" does not.

The OS I use on this system is x86-64 CentOS 6.3.  I don't actually
know why it is accessing the disk 108 times per hour when the machine
is mostly idle.

Here is a transcript of dmidecode and hdparm output.

Note that Advanced power management level is reported as 254 because I
set it that way.  The default was 128.

==== start of transcript ====
[root@redhop hugh]# dmidecode
# dmidecode 2.11
SMBIOS 2.4 present.
27 structures occupying 1291 bytes.
Table at 0x000F2EAF.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: 68MOU Ver. F.15
	Release Date: 01/22/2010
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		3.5"/720 kB floppy services are supported (int 13h)
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
	BIOS Revision: 15.21
	Firmware Revision: 116.58

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Compaq 2710p
	Version: F.15
	Serial Number: USH826020A
	UUID: 1065C9F5-8D46-DD11-0298-98B710202929
	Wake-up Type: Power Switch
	SKU Number: 434566R-999
	Family: 103C_5336AN

Handle 0x0040, DMI type 126, 48 bytes
Inactive

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Hewlett-Packard
	Product Name: 30C8
	Version: KBC Version 74.3A
	Serial Number: Not Specified

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Hewlett-Packard
	Type: Notebook
	Lock: Not Present
	Version: Not Specified
	Serial Number: USH826020A
	Asset Tag: USH826020A
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
	ID: FD 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 13
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
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM)2 Duo CPU     U7500  @ 1.06GHz
	Voltage: 1.1 V
	External Clock: 133 MHz
	Max Speed: 1067 MHz
	Current Speed: 1067 MHz
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
	Installed Size: 64 kB
	Maximum Size: 64 kB
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
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
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
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #1
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Kingston                 
	Serial Number: 4B1E9789
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #2
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Nanya Technology         
	Serial Number: C421170C
	Asset Tag: Not Specified
	Part Number: M2N2G64TU8HD6B-3C 

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x000A
	Partition Width: 2

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 1

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 2

Handle 0x0010, DMI type 22, 26 bytes
Portable Battery
	Location: Primary
	Manufacturer: Hewlett-Packard
	Manufacture Date: 09/11/2007
	Serial Number: 00307       
	Name: HP                
	Chemistry: Lithium Ion
	Design Capacity: 40000 mWh
	Design Voltage: 11100 mV
	SBDS Version: Not Specified
	Maximum Error: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0011, DMI type 126, 26 bytes
Inactive

Handle 0x0012, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0013, DMI type 126, 8 bytes
Inactive

Handle 0x0014, DMI type 126, 20 bytes
Inactive

Handle 0x0085, DMI type 133, 34 bytes
OEM-specific Type
	Header and Data:
		85 22 85 00 01 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00
		00 00
	Strings:
		                
		No battery        

Handle 0x0086, DMI type 134, 34 bytes
OEM-specific Type
	Header and Data:
		86 22 86 00 01 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00
		00 00
	Strings:
		                
		                  

Handle 0x0015, DMI type 144, 26 bytes
OEM-specific Type
	Header and Data:
		90 1A 15 00 FF FF FF FF FF FF FF FF FF FF FF FF
		FF FF FF FF FF FF FF FF 00 00

Handle 0x0016, DMI type 127, 4 bytes
End Of Table

[root@redhop hugh]# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK8009GAH                       
	Serial Number:      X835WF9AW
	Firmware Revision:  BS021C  
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  156301488
	Logical  Sector size:                   512 bytes
	Physical Sector size:                   512 bytes
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
	cache/buffer size  = unknown
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: 254
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
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
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	   *	Advanced Power Management feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	82min for SECURITY ERASE UNIT. 
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct
[root@redhop hugh]# exit
==== end of transcript ====
