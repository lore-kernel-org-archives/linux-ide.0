From: Tobias Stegmann <tobias_stegmann@gmx.net>
Subject: an affected device for the head unload wikipage
Date: Sun, 27 Jul 2008 12:16:49 +0200
Message-ID: <488C4B11.8030603@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5DD27C6D48AA4D81F3D98549"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751205AbYG0KRA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jul 2008 06:17:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DD27C6D48AA4D81F3D98549
Content-Type: multipart/mixed;
 boundary="------------000700020602030602070901"

This is a multi-part message in MIME format.
--------------000700020602030602070901
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hey guys,

here are the dmidecode and hdparm -i outputs of my HP Pavilion dv9533
Notebook PC.

This notebook got 2 hdds (same model) built in, so I added both hdparm
outputs.


Thanks,
Tobias

--------------000700020602030602070901
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
19 structures occupying 726 bytes.
Table at 0x000DF010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.2A   =20
	Release Date: 02/22/2008
	Address: 0xE6970
	Runtime Size: 104080 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv9500 Notebook PC   =20
	Version: Rev 1
	Serial Number: CNF735270B
	UUID: 434E4637-3335-3237-3042-001B248ED3C4
	Wake-up Type: Power Switch
	SKU Number: GS463EA#ABD
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Quanta
	Product Name: 30DA
	Version: 85.24
	Serial Number: None2

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Quanta
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag:                    =20
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000004

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket S1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 81 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 104, Stepping 1
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
	Version: AMD Turion(tm) 64 X2 Mobile TL60
	Voltage: 1.6 V
	External Clock: 200 MHz
	Max Speed: 2000 MHz
	Current Speed: 2000 MHz
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
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
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
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 1
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 2
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0009, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   =20

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#ABD
	String 3: ABS 70/71 6A 6B 6C 6D

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 1
	Bank Locator: Bank 0,1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 2
	Bank Locator: Bank 2,3
	Type: DDR2
	Type Detail: Unknown
	Speed: 667 MHz (1.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000B
	Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000D
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0011, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0012, DMI type 127, 4 bytes
End Of Table


--------------000700020602030602070901
Content-Type: text/plain;
 name="hdparm_sda"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hdparm_sda"


/dev/sda:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK1637GSX                      =20
	Serial Number:      87AVT4OXT
	Firmware Revision:  DL032C =20
Standards:
	Supported: 7 6 5 4=20
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	device size with M =3D 1024*1024:      152627 MBytes
	device size with M =3D 1000*1000:      160041 MBytes (160 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: 254
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *=
udma5=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
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
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Phy event counters
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	78min for SECURITY ERASE UNIT. 78min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

--------------000700020602030602070901
Content-Type: text/plain;
 name="hdparm_sdb"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hdparm_sdb"


/dev/sdb:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK1637GSX                      =20
	Serial Number:      87AVT4OWT
	Firmware Revision:  DL032C =20
Standards:
	Supported: 7 6 5 4=20
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	device size with M =3D 1024*1024:      152627 MBytes
	device size with M =3D 1000*1000:      160041 MBytes (160 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: 254
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *=
udma5=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
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
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Phy event counters
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	78min for SECURITY ERASE UNIT. 78min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

--------------000700020602030602070901--

--------------enig5DD27C6D48AA4D81F3D98549
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIjEsZDIbFMNGhSCARAoIoAJ9N+aKwaIlCQTUVn2M2O9hZLcyDBACfVsZR
c6MtS6iBWHPgI/EqzfJqsgc=
=6WfC
-----END PGP SIGNATURE-----

--------------enig5DD27C6D48AA4D81F3D98549--
