From: Alexander Clausen <alex@gc-web.de>
Subject: Frequent head unloading
Date: Sun, 16 Nov 2008 15:07:39 +0100
Message-ID: <4920292B.5060804@gc-web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000504040904040901090202"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:36064 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbYKPO1Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 09:27:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.gc-web.de (Postfix) with ESMTP id 5252D8A0002
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 15:07:42 +0100 (CET)
Received: from mail.gc-web.de ([127.0.0.1])
	by localhost (server2.gc-web.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id anW+XVRxZaWE for <linux-ide@vger.kernel.org>;
	Sun, 16 Nov 2008 15:07:40 +0100 (CET)
Received: from [192.168.0.62] (p57990E22.dip.t-dialin.net [87.153.14.34])
	by mail.gc-web.de (Postfix) with ESMTP id 19A628A0001
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 15:07:40 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504040904040901090202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
I _think_ I got a case of frequent head unloading here. See attachments.

   hdparm -B255 /dev/sda

seems to stop the clunking noises.

Alex

--------------000504040904040901090202
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.8
SMBIOS 2.3 present.
26 structures occupying 724 bytes.
Table at 0x000F0800.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 06/16/2006
	Address: 0xE0000
	Runtime Size: 128 kB
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
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer:  
	Product Name:  
	Version:  
	Serial Number:  
	UUID: Not Present
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer:  
	Product Name: CN900-8237R
	Version:  
	Serial Number:  

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
	Socket Designation: NanoBGA2
	Type: Central Processor
	Family: Other
	Manufacturer: VIA
	ID: A9 06 00 00 FF B8 C9 A7
	Version: VIA C7
	Voltage: 11.9 V
	External Clock: 100 MHz
	Max Speed: 1300 MHz
	Current Speed: 1000 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0007
	L2 Cache Handle: 0x0008
	L3 Cache Handle: Not Provided
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0005, DMI type 5, 18 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: Eight-way Interleave
	Current Interleave: Four-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 1024 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 2.9 V
	Associated Memory Slots: 1
		0x0006
	Enabled Error Correcting Capabilities: None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A0
	Bank Connections: 0
	Current Speed: 37 ns
	Type: Other
	Installed Size: 512 MB (Single-bank Connection)
	Enabled Size: 512 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0008, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Other
	Port Type: USB

Handle 0x0012, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0013, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x0014, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 512 MB
	Error Information Handle: Not Provided
	Number Of Devices: 1

Handle 0x0015, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0014
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None
	Speed: Unknown
	Manufacturer: None
	Serial Number: None
	Asset Tag: None
	Part Number: None

Handle 0x0016, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Array Handle: 0x0014
	Partition Width: 0

Handle 0x0017, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0015
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: 1

Handle 0x0018, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0019, DMI type 127, 4 bytes
End Of Table


--------------000504040904040901090202
Content-Type: text/plain;
 name="smart_sda"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smart_sda"

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD1600BEVS-22UST0
Serial Number:    WD-WXE807225378
Firmware Version: 01.01A01
User Capacity:    160.041.885.696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sun Nov 16 14:52:13 2008 CET
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
data collection: 		 (6900) seconds.
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
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  84) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   186   186   021    Pre-fail  Always       -       1700
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       44
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   091   091   000    Old_age   Always       -       6992
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       44
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       31
193 Load_Cycle_Count        0x0032   001   001   000    Old_age   Always       -       3073414
194 Temperature_Celsius     0x0022   113   113   000    Old_age   Always       -       34
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   100   253   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%       164         -

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


--------------000504040904040901090202
Content-Type: text/plain;
 name="smart_sdb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smart_sdb"

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD1600BEVS-00VAT0
Serial Number:    WD-WXE708KHF557
Firmware Version: 11.01A11
User Capacity:    160.041.885.696 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sun Nov 16 14:52:16 2008 CET
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
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  64) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0027   160   160   021    Pre-fail  Always       -       1000
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       9
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age   Always       -       0
  9 Power_On_Hours          0x0032   099   099   000    Old_age   Always       -       1295
 10 Spin_Retry_Count        0x0033   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       8
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       6
193 Load_Cycle_Count        0x0032   195   195   000    Old_age   Always       -       16822
194 Temperature_Celsius     0x0022   108   108   000    Old_age   Always       -       35
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   100   253   051    Pre-fail  Offline      -       0

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


--------------000504040904040901090202--
