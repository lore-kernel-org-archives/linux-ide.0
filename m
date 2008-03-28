From: Tomas Lund <tlund@nxs.se>
Subject: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 08:04:28 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:51078 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbYC1Hdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 03:33:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by envy.nxs.se (Postfix) with ESMTP id 9A7AD2BF35
	for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 08:04:28 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a SuperMicro X7SBi with ICH9R SATA running 64bit linux 2.6.24.4. I 
have 4 1TB disks connected to the motherboard, and one of the disks is 
logging an error message. Everything is brand new, and hooked up just a 
few weeks ago.

S.M.A.R.T. shows no errors (see output from "smartctl -a" at the bottom of 
this email) after running both a short and long offline selftest, and my 
question is if its possible to tell from this error message what the 
problem is. The result "51/04:00:0a:24:f9" is a bit crypting to me, and it 
would be nice to know what the problem actually is before returning the 
disk.

The box is a 1U SuperMicro chassi with 4 SATA hotplug bays in the front, 
and I tried moving the disk from one slot to another, and the problem 
moved with the disk, so I do not suspect a problem with the hotswap bay or 
the cable.


Error message:


ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata2.00: irq_stat 0x40000001
ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
          res 51/04:00:0a:24:f9/00:00:00:00:00/a9 Emask 0x1 (device error)
ata2.00: status: { DRDY ERR }
ata2.00: error: { ABRT }
ata2.00: configured for UDMA/133
ata2: EH complete
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


I put the entire dmesg at http://tlund.pp.se/envy4_dmesg.txt but I think 
these are the relevant lines about the SATA chipset and the disks from 
booting:


ata2.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg3 type 0


output from "smartctl -d ata -a /dev/sdb" here:


smartctl version 5.36 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD1000FYPS-01ZKB0
Serial Number:    WD-WCASJ0656706
Firmware Version: 02.01B01
User Capacity:    1,000,204,886,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Mar 27 16:49:50 2008 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
 					was suspended by an interrupting command from host.
 					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
 					without error or no self-test has ever
 					been run.
Total time to complete Offline 
data collection: 		 (26400) seconds.
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
recommended polling time: 	 ( 255) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
   3 Spin_Up_Time            0x0003   193   187   021    Pre-fail  Always       -       7325
   4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       194
   5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
   7 Seek_Error_Rate         0x000e   200   200   000    Old_age   Always       -       0
   9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       392
  10 Spin_Retry_Count        0x0012   100   100   000    Old_age   Always       -       0
  11 Calibration_Retry_Count 0x0012   100   253   000    Old_age   Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       15
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       11
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       799
194 Temperature_Celsius     0x0022   124   114   000    Old_age   Always       -       28
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0008   200   200   000    Old_age   Offline      -       0

SMART Error Log Version: 1
ATA Error Count: 108 (device log contains only the most recent five errors)
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

Error 108 occurred at disk power-on lifetime: 392 hours (16 days + 8 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   04 51 00 0a 24 f9 a9

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   ea 00 00 00 00 00 00 08      03:56:15.157  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:56:15.157  [RESERVED FOR SERIAL ATA]
   ea 00 00 00 00 00 00 08      03:56:15.157  FLUSH CACHE EXIT
   ea 00 00 00 00 00 00 08      03:56:00.377  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:56:00.377  [RESERVED FOR SERIAL ATA]

Error 107 occurred at disk power-on lifetime: 392 hours (16 days + 8 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   04 51 00 0a 24 f9 a9

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   ea 00 00 00 00 00 00 08      03:55:34.813  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:55:34.813  [RESERVED FOR SERIAL ATA]
   ea 00 00 00 00 00 00 08      03:55:34.813  FLUSH CACHE EXIT
   ea 00 00 00 00 00 00 08      03:55:10.043  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:55:10.043  [RESERVED FOR SERIAL ATA]

Error 106 occurred at disk power-on lifetime: 392 hours (16 days + 8 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   04 51 00 0a 24 f9 a9

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   ea 00 00 00 00 00 00 08      03:54:47.336  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:54:47.336  [RESERVED FOR SERIAL ATA]
   ea 00 00 00 00 00 00 08      03:54:47.336  FLUSH CACHE EXIT
   ea 00 00 00 00 00 00 08      03:54:32.555  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:54:32.555  [RESERVED FOR SERIAL ATA]

Error 105 occurred at disk power-on lifetime: 392 hours (16 days + 8 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   04 51 00 0a 24 f9 a9

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   ea 00 00 00 00 00 00 08      03:24:22.514  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:24:22.514  [RESERVED FOR SERIAL ATA]
   ea 00 00 00 00 00 00 08      03:24:22.514  FLUSH CACHE EXIT
   ea 00 00 00 00 00 00 08      03:23:52.777  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:23:52.777  [RESERVED FOR SERIAL ATA]

Error 104 occurred at disk power-on lifetime: 392 hours (16 days + 8 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   04 51 00 0a 24 f9 a9

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   ea 00 00 00 00 00 00 08      03:13:33.191  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:13:33.191  [RESERVED FOR SERIAL ATA]
   ea 00 00 00 00 00 00 08      03:13:33.191  FLUSH CACHE EXIT
   ea 00 00 00 00 00 00 08      03:13:03.453  FLUSH CACHE EXIT
   61 08 00 3f 59 70 74 08      03:13:03.453  [RESERVED FOR SERIAL ATA]

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%       373         -
# 2  Short offline       Completed without error       00%       369         -

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


Best regards,
Tomas
