From: Francois Cartegnie <fcartegnie@free.fr>
Subject: Drives which perform frequent head unloads under Linux
Date: Tue, 3 Feb 2009 14:29:19 +0100
Message-ID: <200902031429.19457.fcartegnie@free.fr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vaEiJJGQrnHllD2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:58901 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbZBCNab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2009 08:30:31 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 43A06787469
	for <linux-ide@vger.kernel.org>; Tue,  3 Feb 2009 14:30:25 +0100 (CET)
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 488414B01A6
	for <linux-ide@vger.kernel.org>; Tue,  3 Feb 2009 14:29:22 +0100 (CET)
Received: from [192.168.0.50] (lns-bzn-21-82-64-93-219.adsl.proxad.net [82.64.93.219])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 26A004B01FA
	for <linux-ide@vger.kernel.org>; Tue,  3 Feb 2009 14:29:20 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_vaEiJJGQrnHllD2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

MSI Megabook S425
MK8025GAS (unload every 8/10sec)
Workaround with APM to 254 (but doesn't disable totally).

--Boundary-00=_vaEiJJGQrnHllD2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="msi-s425-smartctl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="msi-s425-smartctl"

smartctl version 5.38 [i586-mandriva-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Toshiba 2.5" HDD series (80 GB and above)
Device Model:     TOSHIBA MK8025GAS
Serial Number:    Y52G4752S
Firmware Version: KA023A
User Capacity:    80 026 361 856 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Feb  3 14:15:21 2009 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 375) seconds.
Offline data collection
capabilities: 			 (0x1b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					No Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  75) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   050    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   100   100   050    Pre-fail  Offline      -       0
  3 Spin_Up_Time            0x0027   100   100   001    Pre-fail  Always       -       1375
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       4674
  5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   050    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   050    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0032   094   094   000    Old_age   Always       -       2791
 10 Spin_Retry_Count        0x0033   186   100   030    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       1141
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       52
193 Load_Cycle_Count        0x0032   090   090   000    Old_age   Always       -       100209
194 Temperature_Celsius     0x0022   100   100   000    Old_age   Always       -       26 (Lifetime Min/Max 9/64)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       1
220 Disk_Shift              0x0002   100   100   000    Old_age   Always       -       8338
222 Loaded_Hours            0x0032   096   096   000    Old_age   Always       -       1996
223 Load_Retry_Count        0x0032   100   100   000    Old_age   Always       -       0
224 Load_Friction           0x0022   100   100   000    Old_age   Always       -       0
226 Load-in_Time            0x0026   100   100   000    Old_age   Always       -       141
240 Head_Flying_Hours       0x0001   100   100   001    Pre-fail  Offline      -       0

SMART Error Log Version: 1
ATA Error Count: 1
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 1 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 6e ad 2e e0  Error: ICRC, ABRT 1 sectors at LBA = 0x002ead6e = 3059054

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 80 ef ac 2e e0 00      00:01:48.034  READ DMA
  c8 00 08 e7 ac 2e e0 00      00:01:48.017  READ DMA
  ca 00 08 67 a8 2e e0 00      00:01:48.016  WRITE DMA
  ca 00 01 29 ad 2e e0 00      00:01:48.015  WRITE DMA
  ca 00 01 28 ad 2e e0 00      00:01:48.015  WRITE DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      2765         -
# 2  Extended offline    Completed without error       00%      2754         -
# 3  Extended offline    Completed without error       00%      2694         -
# 4  Extended offline    Completed without error       00%      2671         -
# 5  Extended offline    Completed without error       00%      1712         -
# 6  Extended offline    Completed without error       00%      1676         -
# 7  Extended offline    Completed without error       00%      1631         -

Device does not support Selective Self Tests/Logging

--Boundary-00=_vaEiJJGQrnHllD2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="msi-s425-dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="msi-s425-dmidecode"

# dmidecode 2.9
SMBIOS 2.3 present.
15 structures occupying 757 bytes.
Table at 0x000F9CA0.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: A1022IMS V1.20
	Release Date: 10/05/2005
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: MICRO-STAR INT'L CO.,LTD.
	Product Name: MS-1022
	Version: 0221
	Serial Number: 0FFFFFFFFh
	UUID: 00020003-0004-0005-0006-000700080009
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: MICRO-STAR INT'L CO.,LTD.
	Type: Notebook
	Lock: Not Present
	Version: N/A 
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0003, DMI type 4, 35 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel            
	ID: D8 06 00 00 FF FB E9 AF
	Version: Intel(R) Pentium(R) M processor 1.73GHz             
	Voltage: 3.3 V 2.9 V
	External Clock: 532 MHz
	Max Speed: 1729 MHz
	Current Speed: 1729 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0004
	L2 Cache Handle: 0x0005
	L3 Cache Handle: 0x0006
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0005, DMI type 7, 19 bytes
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

Handle 0x0006, DMI type 7, 19 bytes
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

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: Oz711MP1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Short
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported

Handle 0x0008, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0009, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000400003FF
	Range Size: 1048577 kB
	Physical Array Handle: 0x0008
	Partition Width: 0

Handle 0x000A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0008
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: Other
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x000B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000200003FF
	Range Size: 524289 kB
	Physical Device Handle: 0x000A
	Memory Array Mapped Address Handle: 0x0009
	Partition Row Position: <OUT OF SPEC>

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0008
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: Other
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x000D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x000400003FF
	Range Size: 524289 kB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x0009
	Partition Row Position: 16
	Interleave Position: 32

Handle 0x000E, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_vaEiJJGQrnHllD2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="msi-s425-hdparm"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="msi-s425-hdparm"


/dev/hda:

 Model=TOSHIBA MK8025GAS, FwRev=KA023A, SerialNo=Y52G4752S
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=48
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6

 * signifies the current active mode


--Boundary-00=_vaEiJJGQrnHllD2--
