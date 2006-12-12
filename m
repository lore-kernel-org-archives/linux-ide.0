From: Mauro Ziliani <mauro.ziliani@tin.it>
Subject: Re: Seagate ST3808110AS and Sil3114 RAID1 trouble.
Date: Tue, 12 Dec 2006 08:54:40 +0100
Message-ID: <457E6040.7060402@tin.it>
References: <457D1F0F.20204@tin.it> <457D2307.7060301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060106060207020209030109"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 81-174-11-230.f5.ngi.it ([81.174.11.230]:56716 "EHLO
	mercurio.cosmo.lan" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbWLLHzD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 02:55:03 -0500
In-Reply-To: <457D2307.7060301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106060207020209030109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo ha scritto:
> What's the kernel version?  Your drive is reporting errors on reads and
> writes.
>   
Kernel is a 2.16.18.2 SMP onto a Dual Pentium 3 866MHz.
The distribution is Debian Sarge 3.1r2.
> I dunno what PowerMax tests for.  Can you please the result of 'smartctl
> -d ata -a /dev/sdX'?
>
>   
Powermax is the officiali test utility for Seagate and Maxtor disk.
Attached I put the smartctl report about /dev/sdb1 and /dev/sdc1, the
two sata disk on md0 raid
> Doesn't really matter.  All are software raid anyway.  If you wanna use
> BIOS raid, you gotta setup dm raid which goes along with it.
>   

Thansk a lot.


--------------060106060207020209030109
Content-Type: text/plain;
 name="smartctl.sdc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl.sdc1"

smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     ST3808110AS
Serial Number:    4LR0459K
Firmware Version: 3.AAD
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Dec 11 10:31:22 2006 CET
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
data collection: 		 ( 430) seconds.
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
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  27) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   118   079   006    Pre-fail  Always       -       170819894
  3 Spin_Up_Time            0x0003   099   099   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       40
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   079   060   030    Pre-fail  Always       -       96592598
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always       -       2710
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       74
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Unknown_Attribute       0x0022   068   046   045    Old_age   Always       -       555614240
194 Temperature_Celsius     0x0022   032   054   000    Old_age   Always       -       32 (Lifetime Min/Max 0/21)
195 Hardware_ECC_Recovered  0x001a   072   046   000    Old_age   Always       -       144579171
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   189   000    Old_age   Always       -       48
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 24 (device log contains only the most recent five errors)
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

Error 24 occurred at disk power-on lifetime: 2597 hours (108 days + 5 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 7f 60 45 a6 e5  Error: ICRC, ABRT 127 sectors at LBA = 0x05a64560 = 94782816

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 a0 3f 45 a6 e5 00   1d+02:54:11.924  READ DMA
  c8 00 08 57 2d a4 e5 00   1d+02:54:10.231  READ DMA
  c8 00 00 37 43 a6 e5 00   1d+02:54:14.160  READ DMA
  c8 00 00 27 22 b0 e5 00   1d+02:54:14.157  READ DMA
  c8 00 88 27 26 b0 e5 00   1d+02:54:14.116  READ DMA

Error 23 occurred at disk power-on lifetime: 2227 hours (92 days + 19 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 2f 90 ff 2a e5  Error: ICRC, ABRT 47 sectors at LBA = 0x052aff90 = 86704016

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 80 3f ff 2a e5 00      01:51:05.680  READ DMA
  ca 00 80 bf fe 2a e5 00      01:51:05.679  WRITE DMA
  c8 00 80 bf fe 2a e5 00      01:51:05.709  READ DMA
  ca 00 80 bf fe 2a e5 00      01:51:05.709  WRITE DMA
  c8 00 80 bf fe 2a e5 00      01:51:05.707  READ DMA

Error 22 occurred at disk power-on lifetime: 2227 hours (92 days + 19 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 1f 20 53 a2 e4  Error: ICRC, ABRT 31 sectors at LBA = 0x04a25320 = 77746976

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 80 bf 52 a2 e4 00      01:38:11.906  READ DMA
  ca 00 80 3f 52 a2 e4 00      01:38:11.899  WRITE DMA
  c8 00 80 3f 52 a2 e4 00      01:38:11.898  READ DMA
  ca 00 80 3f 52 a2 e4 00      01:38:11.897  WRITE DMA
  c8 00 80 3f 52 a2 e4 00      01:38:11.896  READ DMA

Error 21 occurred at disk power-on lifetime: 2226 hours (92 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 6f 50 45 5e e0  Error: ICRC, ABRT 111 sectors at LBA = 0x005e4550 = 6178128

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 80 3f 45 5e e0 00      00:21:37.728  READ DMA
  ca 00 80 bf 44 5e e0 00      00:21:37.727  WRITE DMA
  c8 00 80 bf 44 5e e0 00      00:21:37.726  READ DMA
  ca 00 80 bf 44 5e e0 00      00:21:37.725  WRITE DMA
  c8 00 80 bf 44 5e e0 00      00:21:37.724  READ DMA

Error 20 occurred at disk power-on lifetime: 2225 hours (92 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 d7 90 28 4a e0  Error: ICRC, ABRT 215 sectors at LBA = 0x004a2890 = 4860048

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 48 1f 28 4a e0 00   1d+06:15:04.690  READ DMA EXT
  c8 00 00 1f 27 4a e6 00   1d+06:15:04.686  READ DMA
  25 00 68 b7 25 4a e0 00   1d+06:15:04.680  READ DMA EXT
  25 00 00 b7 23 4a e0 00   1d+06:15:04.676  READ DMA EXT
  25 00 48 6f 22 4a e0 00   1d+06:15:04.772  READ DMA EXT

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      2707         -
# 2  Short offline       Completed without error       00%      2707         -
# 3  Short offline       Completed without error       00%      2209         -
# 4  Extended offline    Completed without error       00%      1834         -
# 5  Short offline       Completed without error       00%      1834         -
# 6  Extended offline    Completed without error       00%         0         -

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



--------------060106060207020209030109
Content-Type: text/plain;
 name="smartctl.sdb1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl.sdb1"

smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     ST3808110AS
Serial Number:    4LR046Q0
Firmware Version: 3.AAD
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Dec 11 10:31:01 2006 CET
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
data collection: 		 ( 430) seconds.
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
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  27) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   092   070   006    Pre-fail  Always       -       146870238
  3 Spin_Up_Time            0x0003   100   099   000    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   020    Old_age   Always       -       41
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   079   060   030    Pre-fail  Always       -       84183228
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always       -       3067
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   020    Old_age   Always       -       75
187 Unknown_Attribute       0x0032   100   100   000    Old_age   Always       -       0
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Unknown_Attribute       0x0022   068   047   045    Old_age   Always       -       538902560
194 Temperature_Celsius     0x0022   032   053   000    Old_age   Always       -       32 (Lifetime Min/Max 0/21)
195 Hardware_ECC_Recovered  0x001a   048   046   000    Old_age   Always       -       8788319
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   184   000    Old_age   Always       -       51
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 142 (device log contains only the most recent five errors)
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

Error 142 occurred at disk power-on lifetime: 3065 hours (127 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 9f 20 fe 51 e0  Error: ICRC, ABRT 159 sectors at LBA = 0x0051fe20 = 5373472

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 80 3f fd 51 e0 00      00:38:43.365  READ DMA EXT
  c8 00 00 3f fc 51 e2 00      00:38:43.364  READ DMA
  c8 00 80 bf fb 51 e2 00      00:38:43.356  READ DMA
  25 00 80 3f f9 51 e0 00      00:38:43.354  READ DMA EXT
  c8 00 00 3f f8 51 e2 00      00:38:43.353  READ DMA

Error 141 occurred at disk power-on lifetime: 3065 hours (127 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 ff c0 c7 37 e0  Error: ICRC, ABRT 255 sectors at LBA = 0x0037c7c0 = 3655616

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 80 3f c7 37 e0 00      00:38:23.407  READ DMA EXT
  c8 00 00 3f c6 37 e2 00      00:38:23.399  READ DMA
  c8 00 80 bf c5 37 e2 00      00:38:23.397  READ DMA
  25 00 80 3f c3 37 e0 00      00:38:23.396  READ DMA EXT
  c8 00 00 3f c2 37 e2 00      00:38:23.388  READ DMA

Error 140 occurred at disk power-on lifetime: 3065 hours (127 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 7f c0 0c 37 e2  Error: ICRC, ABRT 127 sectors at LBA = 0x02370cc0 = 37162176

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 3f 0c 37 e2 00      00:38:21.982  READ DMA
  c8 00 00 3f 0b 37 e2 00      00:38:21.980  READ DMA
  25 00 00 3f 08 37 e0 00      00:38:21.973  READ DMA EXT
  c8 00 00 3f 07 37 e2 00      00:38:21.971  READ DMA
  25 00 00 3f 04 37 e0 00      00:38:21.969  READ DMA EXT

Error 139 occurred at disk power-on lifetime: 3065 hours (127 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 9f a0 78 2e e2  Error: ICRC, ABRT 159 sectors at LBA = 0x022e78a0 = 36599968

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 00 3f 78 2e e2 00      00:38:14.138  READ DMA
  c8 00 80 bf 77 2e e2 00      00:38:14.135  READ DMA
  25 00 80 3f 75 2e e0 00      00:38:14.127  READ DMA EXT
  c8 00 00 3f 74 2e e2 00      00:38:14.125  READ DMA
  c8 00 80 bf 73 2e e2 00      00:38:14.124  READ DMA

Error 138 occurred at disk power-on lifetime: 3065 hours (127 days + 17 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 ff c0 8a 18 e0  Error: ICRC, ABRT 255 sectors at LBA = 0x00188ac0 = 1608384

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  25 00 80 3f 89 18 e0 00      00:37:57.047  READ DMA EXT
  c8 00 00 3f 88 18 e2 00      00:37:57.045  READ DMA
  25 00 00 3f 85 18 e0 00      00:37:57.032  READ DMA EXT
  c8 00 00 3f 84 18 e2 00      00:37:57.031  READ DMA
  25 00 00 3f 81 18 e0 00      00:37:57.030  READ DMA EXT

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%      3066         -
# 2  Short offline       Completed without error       00%      3065         -
# 3  Extended offline    Completed without error       00%      2793         -
# 4  Short offline       Completed without error       00%      2793         -
# 5  Extended offline    Completed without error       00%         0         -

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



--------------060106060207020209030109--
