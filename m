From: "Li, Yan" <yan.i.li@intel.com>
Subject: Storage fixup for WDC WD1600BEVT-22ZCT0 in an MSI Wind U100 netbook
Date: Mon, 13 Jul 2009 10:44:18 +0800
Message-ID: <20090713024418.GA11947@sage.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6914 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbZGMCoV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Jul 2009 22:44:21 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: yanli@infradead.org


--lEGEL1/lMxI0MVQ2
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This is the storage fix up for a WDC WD1600BEVT-22ZCT0 hard drive in
an MSI Wind U100 Netbook.  This netbook I have been using has a
Power_On_Hours of 38h and Load_Cycle_Count of 6617 (174 cycle/h). And
the noisy clicking sound can be heard every a few seconds.  I found
that Power Management Level 254 is acceptable for it.

Please be noted that the "smartcrl -a" output was taken today, when
I'd used it for a long time with Power Management Level 254/255 so the
Load_Cycle_Count/Power_On_Hours in it doesn't reflect the status of
it's default setting (Power Management Level 128). The
Load_Cycle_Count/Power_On_Hours in above paragraph was recorded months
ago without changing its default Power Management Level, thus very
high.

Thank you. Please call me if you need any more information.

--=20
Best regards,
Li, Yan

Moblin Team, Opensource Technology Center, SSG, Intel
Office tel.: +86-10-82171695 (inet: 8-758-1695)
OpenPGP key: 5C6C31EF
IRC: yanli on network irc.freenode.net

--vkogqOf2sHV7VnPd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="storage-fixup-for-msi-wind-u100.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 8bcc46eb3b1a6a2760b9a040e9e2ebd36f8b812b Mon Sep 17 00:00:00 2001
Message-Id: <8bcc46eb3b1a6a2760b9a040e9e2ebd36f8b812b.1247212168.git.yan.i.=
li@intel.com>
=46rom: Yan Li <yan.i.li@intel.com>
Date: Fri, 10 Jul 2009 15:49:01 +0800
Subject: [PATCH] for MSI Wind U100


Signed-off-by: Yan Li <yan.i.li@intel.com>
---
 storage-fixup.conf |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/storage-fixup.conf b/storage-fixup.conf
index e47d966..03a94e1 100644
--- a/storage-fixup.conf
+++ b/storage-fixup.conf
@@ -188,3 +188,10 @@ dmi system-manufacturer		ASUSTeK Computer Inc.
 dmi system-product-name		M50SV
 ata model			WDC WD*BEVE*
 act hdparm -B 254 $DEV
+
+# Reported drive model: WDC WD1600BEVT-22ZCT0
+rule msi-wind-u100-ms-n011
+dmi system-manufacturer		MICRO-STAR INTERNATIONAL CO., LTD
+dmi system-product-name		U-100
+ata model			WDC WD*BEVT*
+act hdparm -B 254 $DEV
--=20
1.5.6.5


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmidecode.out"
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.10
SMBIOS 2.4 present.
45 structures occupying 1626 bytes.
Table at 0x3F607010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 4.6.3
	Release Date: 07/16/2008
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 4.6

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
	Product Name: U-100
	Version: Ver.001
	Serial Number: FFFFFFFF
	UUID: 00020003-0004-0005-0006-000700080009
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
	Product Name: U-100
	Version: Ver.001
	Serial Number: FFFFFFFF
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: MICRO-STAR INTERNATIONAL CO., LTD
	Type: Desktop
	Lock: Present
	Version: Ver.001
	Serial Number: FFFFFFFF
	Asset Tag: To Be Filled By O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel           =20
	ID: C2 06 01 00 FF FB E9 BF
	Signature: Type 0, Family 6, Model 28, Stepping 2
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
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Atom(TM) CPU N270   @ 1.60GH         =20
	Voltage: 3.3 V 2.9 V
	External Clock: 533 MHz
	Max Speed: 4000 MHz
	Current Speed: 1599 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 24 kB
	Maximum Size: 24 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Unified
	Associativity: Other

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 126, 19 bytes
Inactive

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: TV Out
	External Connector Type: Mini Centronics Type-14
	Port Type: Other

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2A
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2B
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J5A1
	Internal Connector Type: None
	External Reference Designator: USB5
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1E1 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8J2 - SATA 0
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J7H1 - SATA 1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3C1 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3C1 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J4J1 - MAIN POWER
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J1 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J7J1 - IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 9, 13 bytes
System Slot Information
	Designation: J6C1
	Type: x16 PCI Express
	Current Usage: Available
	Length: Long
	ID: 0
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x001C, DMI type 9, 13 bytes
System Slot Information
	Designation: J7C1
	Type: x1 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x001D, DMI type 9, 13 bytes
System Slot Information
	Designation: J8C1
	Type: x1 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x001E, DMI type 9, 13 bytes
System Slot Information
	Designation: J8B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x001F, DMI type 9, 13 bytes
System Slot Information
	Designation: J9B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 4
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0020, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:    To Be Filled By O.E.M.

Handle 0x0021, DMI type 10, 6 bytes
On Board Device Information
	Type: <OUT OF SPEC>
	Status: Enabled
	Description: To Be Filled By O.E.M.

Handle 0x0022, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.

Handle 0x0023, DMI type 12, 5 bytes
System Configuration Options
	Option 1: To Be Filled By O.E.M.

Handle 0x0024, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0025, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2048 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0026, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Array Handle: 0x0025
	Partition Width: 0

Handle 0x0027, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: Unknown
	Form Factor: DIMM
	Set: Unknown
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x0028, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0027
	Memory Array Mapped Address Handle: 0x0026
	Partition Row Position: 1

Handle 0x0029, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: 64 bits
	Size: Unknown
	Form Factor: DIMM
	Set: Unknown
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x002A, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0029
	Memory Array Mapped Address Handle: 0x0026
	Partition Row Position: 1

Handle 0x002B, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x002C, DMI type 127, 4 bytes
End Of Table


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hdparm-I.output"
Content-Transfer-Encoding: quoted-printable


/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD1600BEVT-22ZCT0                  =20
	Serial Number:      WD-WXC808139193
	Firmware Revision:  11.01A11
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
	Supported: 8 7 6 5=20
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
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: 128
	Recommended acoustic management value: 128, current value: 128
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
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
	   *	Host Protected Area feature set
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
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	64-bit World wide name
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	Segmented DOWNLOAD_MICROCODE
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	52min for SECURITY ERASE UNIT. 52min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee25774d8d6
	NAA		: 5
	IEEE OUI	: 14ee
	Unique ID	: 25774d8d6
Checksum: correct

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smartctl-a.out"
Content-Transfer-Encoding: quoted-printable

smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     WDC WD1600BEVT-22ZCT0
Serial Number:    WD-WXC808139193
Firmware Version: 11.01A11
User Capacity:    160,041,885,696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Jul 13 10:39:43 2009 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine comp=
leted
					without error or no self-test has ever=20
					been run.
Total time to complete Offline=20
data collection: 		 (5160) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine=20
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  64) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.
SCT capabilities: 	       (0x303f)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  =
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail  Always   =
    -       0
  3 Spin_Up_Time            0x0027   159   158   021    Pre-fail  Always   =
    -       1050
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always   =
    -       146
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always   =
    -       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age   Always   =
    -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always   =
    -       416
 10 Spin_Retry_Count        0x0033   100   100   051    Pre-fail  Always   =
    -       0
 11 Calibration_Retry_Count 0x0032   100   100   000    Old_age   Always   =
    -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always   =
    -       137
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always   =
    -       19
193 Load_Cycle_Count        0x0032   196   196   000    Old_age   Always   =
    -       12848
194 Temperature_Celsius     0x0022   100   088   000    Old_age   Always   =
    -       43
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always   =
    -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always   =
    -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age   Offline  =
    -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always   =
    -       0
200 Multi_Zone_Error_Rate   0x0009   100   253   051    Pre-fail  Offline  =
    -       0

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


--vkogqOf2sHV7VnPd--

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCAAGBQJKWp+CAAoJEO4BY5RcbDHv6vAP/0x9du9maedydwgvxxMyd06b
e0DmKLh+szRq0TetcsCuMUvKiEe4D55q+jEcz+YdGiYdURSIa00KBr/rjQ5Of3Ui
BvsYo2BQlU+jaShgbLlNeOOhKh60hM0en47mpfSmGi6zA2rmuoULCVtuhlo2D8Jw
IfyTbtuQrJIkZ49pkitB+BCHuhgV5ue9LZQhhrNtaWEAD1dO0iwX3GRlfvwcvDeu
eAc6vSn8xrdMwch3C9shNWizrLScPa96/EcaViCU2WjG1o5N424I9gG7eYldtZst
K8o28TPOVWxzEDWgRRauu1vz+1HlxXq2xu1kmlEotAGM93LoVn8WVHEw61zpp9Ov
7PDtK2AUdi51WGK0DPzFG6kbvmUn4k5QyEzbX147Z2seZJh0sM5ujO4bD/j0yaU/
uUeMvKlNgINAQqLPQc3NHthKpSL7E3O0EV5xc8NIV2cgVohnnnKKDT6fFUb7xN6q
BBoZZZdQ/T1jnT7K034s9qGOtz48/AH0+dqPsQZNT3OqJa1/YX36QvPxA+OYdhyM
ceCFOdQdBqBIJ/aCK/l1OzmZKCxEuPXZbOK4toe7XsYpmTTTsQMKpekRD71+Cyxm
3No6rdTZ7SoWXx2KZFeOXwKqKp6LUgUGj0lcTw4eo6NM4Zhy/OpNfQbv2uq2FakM
cOpSWU0zS7ubA+jYHP7Q
=8Myp
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
