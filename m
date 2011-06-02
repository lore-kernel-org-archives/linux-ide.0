From: Marc MERLIN <marc@merlins.org>
Subject: My laptop HD went RO, WRITE FPDMA QUEUED / SECURITY FREEZE LOCK?
Date: Thu, 2 Jun 2011 08:34:34 -0700
Message-ID: <20110602153434.GA21488@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:56480 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab1FBQRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2011 12:17:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Howdy,

My laptop's hd, after over a year of good behaviour, went read only
last night, and this is what I got in dmesg.

I power cycled the laptop, but I wasn't able to reboot properly.
I then tried again with a boot cdrom and I was able to mount my partitions
and write to them.
After another reboot, the system came back online.

Any idea what happened, and if it's a random burp, or if it's likely to
happen again and I should swap the drive?

Thanks,
Marc

ata1: SError: { RecovData UnrecovData Handshk }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/08:00:66:92:38/00:00:0d:00:00/40 tag 0 ncq 4096 out
         res 50/00:08:3d:ab:54/00:00:0e:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/08:08:56:74:74/00:00:0c:00:00/40 tag 1 ncq 4096 out
         res 50/00:08:3d:ab:54/00:00:0e:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: failed command: READ FPDMA QUEUED
ata1.00: cmd 60/10:10:d2:9a:ec/00:00:09:00:00/40 tag 2 ncq 8192 in
         res 50/00:08:3d:ab:54/00:00:0e:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/08:18:3d:ab:54/00:00:0e:00:00/40 tag 3 ncq 4096 out
         res 50/00:08:3d:ab:54/00:00:0e:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: configured for UDMA/33
ata1.00: configured for UDMA/33
ata1: EH complete
ata1.00: exception Emask 0x10 SAct 0xf SErr 0x400100 action 0x6 frozen
ata1.00: irq_stat 0x08000000, interface fatal error
ata1: SError: { UnrecovData Handshk }
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: cmd 61/08:00:3d:ab:54/00:00:0e:00:00/40 tag 0 ncq 4096 out
         res 50/00:08:66:92:38/00:00:0d:00:00/40 Emask 0x10 (ATA bus error)
ata1.00: status: { DRDY }
ata1.00: failed command: READ FPDMA QUEUED

/dev/sda:

 Model=Hitachi HTS725050A9A364, FwRev=PC4OC70E, SerialNo=091102PCE400VLG24LEC
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=15151kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=976773168
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-2,3,4,5,6,7


smartctl 5.40 2010-03-16 r3077 [i686-pc-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF INFORMATION SECTION ===
Model Family:     Hitachi Travelstar 7K500
Device Model:     Hitachi HTS725050A9A364
Serial Number:    091102PCE400VLG24LEC
Firmware Version: PC4OC70E
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 6
Local Time is:    Thu Jun  2 08:28:23 2011 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 ( 645) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 131) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   062    Pre-fail  Always       -       0
  2 Throughput_Performance  0x0005   118   118   040    Pre-fail  Offline      -       3289
  3 Spin_Up_Time            0x0007   156   156   033    Pre-fail  Always       -       1
  4 Start_Stop_Count        0x0012   099   099   000    Old_age   Always       -       1919
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
  8 Seek_Time_Performance   0x0005   115   115   040    Pre-fail  Offline      -       34
  9 Power_On_Hours          0x0012   078   078   000    Old_age   Always       -       9847
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       1351
191 G-Sense_Error_Rate      0x000a   100   100   000    Old_age   Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       2205810707
193 Load_Cycle_Count        0x0012   087   087   000    Old_age   Always       -       130747
194 Temperature_Celsius     0x0002   152   152   000    Old_age   Always       -       36 (Lifetime Min/Max 6/48)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       4
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       63
223 Load_Retry_Count        0x000a   100   100   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 57 (device log contains only the most recent five errors)
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

Error 57 occurred at disk power-on lifetime: 9838 hours (409 days + 22 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 01 00 00 a0

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 01 01 00 00 a0 ff      03:06:19.300  WRITE FPDMA QUEUED
  61 08 00 96 d1 98 45 ff      03:06:19.300  WRITE FPDMA QUEUED
  61 08 08 c7 7a b3 40 08      03:06:19.300  WRITE FPDMA QUEUED
  61 08 00 8f d1 98 40 08      03:06:19.300  WRITE FPDMA QUEUED
  ec 00 00 00 00 00 a0 08      03:06:19.300  IDENTIFY DEVICE

Error 56 occurred at disk power-on lifetime: 9838 hours (409 days + 22 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 01 00 00 a0

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 01 01 00 00 a0 ff      03:06:19.000  WRITE FPDMA QUEUED
  61 08 00 ce 7a b3 45 ff      03:06:19.000  WRITE FPDMA QUEUED
  61 08 08 8f d1 98 40 08      03:06:19.000  WRITE FPDMA QUEUED
  61 08 00 c7 7a b3 40 08      03:06:19.000  WRITE FPDMA QUEUED
  ec 00 00 00 00 00 a0 08      03:06:19.000  IDENTIFY DEVICE

Error 55 occurred at disk power-on lifetime: 9838 hours (409 days + 22 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 01 00 00 a0

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 01 01 00 00 a0 ff      03:06:18.700  WRITE FPDMA QUEUED
  61 08 01 01 00 00 a0 ff      03:06:18.700  WRITE FPDMA QUEUED
  61 08 00 96 d1 98 45 ff      03:06:18.700  WRITE FPDMA QUEUED
  61 08 08 c7 7a b3 40 08      03:06:18.700  WRITE FPDMA QUEUED
  61 08 00 8f d1 98 40 08      03:06:18.700  WRITE FPDMA QUEUED

Error 54 occurred at disk power-on lifetime: 9838 hours (409 days + 22 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 01 00 00 a0

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 20 01 01 00 00 a0 ff      03:06:05.300  WRITE FPDMA QUEUED
  61 20 e8 ba 8b 6c 43 ff      03:06:05.300  WRITE FPDMA QUEUED
  61 20 08 92 b6 6b 40 08      03:06:05.300  WRITE FPDMA QUEUED
  61 f8 00 aa 8b 6c 40 08      03:06:05.300  WRITE FPDMA QUEUED
  ec 00 00 00 00 00 a0 08      03:06:05.300  IDENTIFY DEVICE

Error 53 occurred at disk power-on lifetime: 9838 hours (409 days + 22 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 01 01 00 00 a0

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 f8 10 a2 b6 6b 43 ff      03:06:05.000  WRITE FPDMA QUEUED
  61 f8 08 aa 8b 6c 40 08      03:06:05.000  WRITE FPDMA QUEUED
  61 20 00 92 b6 6b 40 08      03:06:05.000  WRITE FPDMA QUEUED
  ec 00 00 00 00 00 a0 08      03:06:05.000  IDENTIFY DEVICE
  ef 03 42 00 00 00 a0 08      03:06:05.000  SET FEATURES [Set transfer mode]

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      9841         -
# 2  Short offline       Completed without error       00%      9825         -
# 3  Short offline       Completed without error       00%      9803         -
# 4  Short offline       Completed without error       00%      9779         -
# 5  Short offline       Completed without error       00%      9756         -
# 6  Extended offline    Completed without error       00%      9741         -
# 7  Short offline       Completed without error       00%      9722         -
# 8  Short offline       Completed without error       00%      9708         -
# 9  Short offline       Completed without error       00%      9694         -
#10  Short offline       Completed without error       00%      9680         -
#11  Short offline       Completed without error       00%      9659         -
#12  Short offline       Completed without error       00%      9635         -
#13  Extended offline    Completed without error       00%      9619         -
#14  Short offline       Completed without error       00%      9616         -
#15  Short offline       Completed without error       00%      9597         -
#16  Short offline       Completed without error       00%      9576         -
#17  Short offline       Completed without error       00%      9556         -
#18  Short offline       Completed without error       00%      9535         -
#19  Short offline       Completed without error       00%      9514         -
#20  Short offline       Completed without error       00%      9492         -
#21  Extended offline    Completed without error       00%      9472         -

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

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
