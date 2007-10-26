From: jeffunit <jeff@jeffunit.com>
Subject: Re: marvell 88SX6081 and linux 2.6.23.1
Date: Thu, 25 Oct 2007 21:42:09 -0700
Message-ID: <20071026044212.ZQST17119.mta11.adelphia.net@dual-xeon.jeffunit.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org>
 <47214B40.5020408@gmail.com>
 <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
 <47215DA9.7070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta13.mail.adelphia.net ([68.168.78.44]:41612 "EHLO
	mta13.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbXJZEpB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 00:45:01 -0400
In-Reply-To: <47215DA9.7070403@gmail.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org>
 <47214B40.5020408@gmail.com>
 <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
 <47215DA9.7070403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, jeffunit <jeff@jeffunit.com>
Cc: linux-ide@vger.kernel.org

At 08:23 PM 10/25/2007, Tejun Heo wrote:
>jeffunit wrote:
> >
> >> jeffunit wrote:
> >> > I built a kernel, 2.6.23.1 today.
> >> > My motherboard is an intel stl2, dual pentium 933 motherboard, with
> >> > about 3gb of ram.
> >> > I also have a promise tx100 controller with an ata hard drive for the
> >> > os, and a sony dvdrw drive.
> >> > There is an intel gigabit ethernet card, and an ati pci video card.
> >> >
> >> > I have an 8 port supermicro sata II controller with the marvell
> >> > 888SX6081 chipset.
> >> > I have four 500gb sata II maxtor hard drives attached to it.
> >> >
> >> > All except /dev/sda1 seem to work fine.
> >> > When I copy/modify files on /dev/sda1, I get the following dmesg
> >> errors:
> >> >
> >> > The machine is designed to be a fileserver, but I am happy to help
> >> debug
> >> > this issue to the best
> >> > of my abilities.
> >> >
> >> > When I boot windows xp, xp sees all 4 of the sata drives, and they work
> >> > without any problems.
> >> >
> >> > Please advise,
> >> > jeff
> >> >
> >> > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >> > ata1.00: edma_err 0x00000084, EDMA self-disable
> >> > ata1.00: cmd c8/00:08:37:02:90/00:00:00:00:00/e5 tag 0 cdb 0x0 data
> >> 4096 in
> >> >          res 51/40:00:37:02:90/00:00:00:00:00/e5 Emask 0x9 (media
> >> error)
> >>
> >> Media errors which is usually localized to certain area of disk.
> >> Replace disk.
> >
> > The disk works fine under windows xp. I never got any errors with it and
> > xp.
>
>And you were accessing the same region of the drive?
>
> > I can swap the first and second hard drive.
> > With the old kernel, the errors stayed with whatever drive was hooked up to
> > the first port of the controller. I will report the results.
>
>Hmmm... Yes please.  Also, please report the result of "smartctl -a
>/dev/sda".

Pardon the long post
I swapped /dev/sda and /dev/sdb cables at the controller.

Here is what smartctl -a said afterward:

sda:
smartctl version 5.37 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     MAXTOR STM3500630AS
Serial Number:    9QG1Y3R3
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Oct 25 21:02:45 2007 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test 
routine completed
                                         without error or no 
self-test has ever
                                         been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 163) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   119   094   006    Pre-fail  Always 
      -       218977613
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       28
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       23
   7 
Seek_Error_Rate         0x000f   066   060   030    Pre-fail  Always 
      -       5082213
   9 
Power_On_Hours          0x0032   100   100   000    Old_age   Always 
      -       74
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       39
187 
Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
      -       0
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   067   056   045    Old_age   Always 
      -       555679777
194 
Temperature_Celsius     0x0022   033   044   000    Old_age   Always 
      -       33 (Lifetime Min/Max 0/21)
195 
Hardware_ECC_Recovered  0x001a   087   056   000    Old_age   Always 
      -       76318315
197 
Current_Pending_Sector  0x0012   100   100   000    Old_age   Always 
      -       1
198 
Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline 
      -       1
199 
UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
      -       0
200 
Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
      -       0
202 
TA_Increase_Count       0x0032   100   253   000    Old_age   Always 
      -       0

SMART Error Log Version: 1
ATA Error Count: 2
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

Error 2 occurred at disk power-on lifetime: 11 hours (0 days + 11 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   10 51 01 2b 7c 48 40  Error: IDNF at LBA = 0x00487c2b = 4750379

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   42 00 00 3f 7a 48 40 00      02:04:42.054  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 78 48 40 00      02:04:42.049  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 78 48 40 00      02:04:42.043  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 76 48 40 00      02:04:42.036  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 74 48 40 00      02:04:47.251  READ VERIFY SECTOR(S) EXT

Error 1 occurred at disk power-on lifetime: 11 hours (0 days + 11 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   10 51 01 57 79 48 40  Error: IDNF at LBA = 0x00487957 = 4749655

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   42 00 00 3f 78 48 40 00      02:04:42.054  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 76 48 40 00      02:04:42.049  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 74 48 40 00      02:04:42.043  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 72 48 40 00      02:04:42.036  READ VERIFY SECTOR(S) EXT
   42 00 00 3f 70 48 40 00      02:04:42.031  READ VERIFY SECTOR(S) EXT

SMART Self-test log structure revision number 1

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


sdb:
smartctl version 5.37 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     MAXTOR STM3500630AS
Serial Number:    9QG1RWTH
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Oct 25 21:02:50 2007 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test 
routine completed
                                         without error or no 
self-test has ever
                                         been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 163) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   114   088   006    Pre-fail  Always 
      -       63140281
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       27
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       12
   7 
Seek_Error_Rate         0x000f   063   060   030    Pre-fail  Always 
      -       2020356
   9 
Power_On_Hours          0x0032   100   100   000    Old_age   Always 
      -       73
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       39
187 
Unknown_Attribute       0x0032   001   001   000    Old_age   Always 
      -       1195
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   067   055   045    Old_age   Always 
      -       572522529
194 
Temperature_Celsius     0x0022   033   045   000    Old_age   Always 
      -       33 (Lifetime Min/Max 0/22)
195 
Hardware_ECC_Recovered  0x001a   097   050   000    Old_age   Always 
      -       140186474
197 
Current_Pending_Sector  0x0012   069   069   000    Old_age   Always 
      -       650
198 
Offline_Uncorrectable   0x0010   069   069   000    Old_age   Offline 
      -       650
199 
UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
      -       0
200 
Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
      -       0
202 
TA_Increase_Count       0x0032   090   243   000    Old_age   Always 
      -       10

SMART Error Log Version: 1
ATA Error Count: 2892 (device log contains only the most recent five errors)
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

Error 2892 occurred at disk power-on lifetime: 57 hours (2 days + 9 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 ca 00 dc e6  Error: UNC at LBA = 0x06dc00ca = 115081418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 c7 00 dc e6 00      04:14:16.881  READ DMA
   27 00 00 00 00 00 e0 02      04:14:16.816  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      04:14:16.813  IDENTIFY DEVICE
   ef 03 42 00 00 00 a0 02      04:14:16.315  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      04:13:46.245  READ NATIVE MAX ADDRESS EXT

Error 2891 occurred at disk power-on lifetime: 57 hours (2 days + 9 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 ca 00 dc e6  Error: UNC at LBA = 0x06dc00ca = 115081418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 c7 00 dc e6 00      04:14:16.881  READ DMA
   27 00 00 00 00 00 e0 02      04:14:16.816  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      04:14:16.813  IDENTIFY DEVICE
   ef 03 42 00 00 00 a0 02      04:14:16.315  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      04:13:46.245  READ NATIVE MAX ADDRESS EXT

Error 2890 occurred at disk power-on lifetime: 57 hours (2 days + 9 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 ca 00 dc e6  Error: UNC at LBA = 0x06dc00ca = 115081418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 c7 00 dc e6 00      04:13:15.418  READ DMA
   27 00 00 00 00 00 e0 02      04:13:15.415  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      04:13:14.917  IDENTIFY DEVICE
   ef 03 42 00 00 00 a0 02      04:12:44.847  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      04:13:46.245  READ NATIVE MAX ADDRESS EXT

Error 2889 occurred at disk power-on lifetime: 57 hours (2 days + 9 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 ca 00 dc e6  Error: UNC at LBA = 0x06dc00ca = 115081418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 c7 00 dc e6 00      04:13:15.418  READ DMA
   27 00 00 00 00 00 e0 02      04:13:15.415  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      04:13:14.917  IDENTIFY DEVICE
   ef 03 42 00 00 00 a0 02      04:12:44.847  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      04:12:44.792  READ NATIVE MAX ADDRESS EXT

Error 2888 occurred at disk power-on lifetime: 57 hours (2 days + 9 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 ca 00 dc e6  Error: UNC at LBA = 0x06dc00ca = 115081418

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 c7 00 dc e6 00      04:12:14.016  READ DMA
   27 00 00 00 00 00 e0 02      04:12:13.518  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      04:11:43.449  IDENTIFY DEVICE
   ef 03 42 00 00 00 a0 02      04:12:44.847  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      04:12:44.792  READ NATIVE MAX ADDRESS EXT

SMART Self-test log structure revision number 1

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


sdc:
smartctl version 5.37 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     MAXTOR STM3500630AS
Serial Number:    9QG1WMBW
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Oct 25 21:02:54 2007 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test 
routine completed
                                         without error or no 
self-test has ever
                                         been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 163) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   114   100   006    Pre-fail  Always 
      -       79425540
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       28
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       0
   7 
Seek_Error_Rate         0x000f   066   060   030    Pre-fail  Always 
      -       5098162
   9 
Power_On_Hours          0x0032   100   100   000    Old_age   Always 
      -       74
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       39
187 
Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
      -       0
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   066   055   045    Old_age   Always 
      -       572522530
194 
Temperature_Celsius     0x0022   034   045   000    Old_age   Always 
      -       34 (Lifetime Min/Max 0/22)
195 
Hardware_ECC_Recovered  0x001a   098   061   000    Old_age   Always 
      -       192191767
197 
Current_Pending_Sector  0x0012   100   100   000    Old_age   Always 
      -       0
198 
Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline 
      -       0
199 
UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
      -       0
200 
Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
      -       0
202 
TA_Increase_Count       0x0032   100   253   000    Old_age   Always 
      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1

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



sdd:
smartctl version 5.37 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     MAXTOR STM3500630AS
Serial Number:    9QG1VJ3Y
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Oct 25 21:02:58 2007 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test 
routine completed
                                         without error or no 
self-test has ever
                                         been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 163) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   117   099   006    Pre-fail  Always 
      -       136511127
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       28
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       4
   7 
Seek_Error_Rate         0x000f   066   060   030    Pre-fail  Always 
      -       5113771
   9 
Power_On_Hours          0x0032   100   100   000    Old_age   Always 
      -       74
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       39
187 
Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
      -       0
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   067   057   045    Old_age   Always 
      -       555679777
194 
Temperature_Celsius     0x0022   033   043   000    Old_age   Always 
      -       33 (Lifetime Min/Max 0/21)
195 
Hardware_ECC_Recovered  0x001a   107   061   000    Old_age   Always 
      -       207450593
197 
Current_Pending_Sector  0x0012   100   100   000    Old_age   Always 
      -       0
198 
Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline 
      -       0
199 
UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
      -       0
200 
Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
      -       0
202 
TA_Increase_Count       0x0032   100   253   000    Old_age   Always 
      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1

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


I then ran
dd if=/dev/sda of=/dev/null bs=1M &
and repeated for sdb, sdc, and sdd.
I got an error
Exit 1                  dd if=/dev/sdb of=/dev/null bs=1M

dmesg says:
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 02 2a 18
sd 1:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 141848
Buffer I/O error on device sdb, logical block 17731
Buffer I/O error on device sdb, logical block 17732
Buffer I/O error on device sdb, logical block 17733
Buffer I/O error on device sdb, logical block 17734
Buffer I/O error on device sdb, logical block 17735
Buffer I/O error on device sdb, logical block 17736
Buffer I/O error on device sdb, logical block 17737
Buffer I/O error on device sdb, logical block 17738
Buffer I/O error on device sdb, logical block 17739
Buffer I/O error on device sdb, logical block 17740
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:08:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:08:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 02 2b 08
sd 1:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 142088
printk: 20 messages suppressed.
Buffer I/O error on device sdb, logical block 17761
ata2: EH complete
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:f8:10:2b:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 126976 in
          res 51/40:00:10:2b:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 02 2b 10
sd 1:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 142096
Buffer I/O error on device sdb, logical block 17762
Buffer I/O error on device sdb, logical block 17763
Buffer I/O error on device sdb, logical block 17764
ata2: EH complete
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 02 2a 18
sd 1:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 141848
printk: 28 messages suppressed.
Buffer I/O error on device sdb, logical block 17731
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: edma_err 0x00000084, EDMA self-disable
ata2.00: cmd c8/00:08:18:2a:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
          res 51/40:00:18:2a:02/00:00:00:00:00/e0 Emask 0x9 (media error)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 1:0:0:0: [sdb] Sense Key : Medium Error [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
         00 02 2a 18
sd 1:0:0:0: [sdb] Add. Sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 141848
Buffer I/O error on device sdb, logical block 17731
ata2: EH complete
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA


I re-ran smartctl -a on /dev/sdb and it says:
smartctl version 5.37 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     MAXTOR STM3500630AS
Serial Number:    9QG1RWTH
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu Oct 25 21:35:03 2007 PDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                         was completed without error.
                                         Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test 
routine completed
                                         without error or no 
self-test has ever
                                         been run.
Total time to complete Offline
data collection:                 ( 430) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         No Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 163) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   114   088   006    Pre-fail  Always 
      -       63140281
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       27
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       12
   7 
Seek_Error_Rate         0x000f   063   060   030    Pre-fail  Always 
      -       2049193
   9 
Power_On_Hours          0x0032   100   100   000    Old_age   Always 
      -       74
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       39
187 
Unknown_Attribute       0x0032   001   001   000    Old_age   Always 
      -       1225
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   061   055   045    Old_age   Always 
      -       656408615
194 
Temperature_Celsius     0x0022   039   045   000    Old_age   Always 
      -       39 (Lifetime Min/Max 0/22)
195 
Hardware_ECC_Recovered  0x001a   072   050   000    Old_age   Always 
      -       142192359
197 
Current_Pending_Sector  0x0012   069   069   000    Old_age   Always 
      -       653
198 
Offline_Uncorrectable   0x0010   069   069   000    Old_age   Offline 
      -       653
199 
UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
      -       0
200 
Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   Offline 
      -       0
202 
TA_Increase_Count       0x0032   089   242   000    Old_age   Always 
      -       11

SMART Error Log Version: 1
ATA Error Count: 2922 (device log contains only the most recent five errors)
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

Error 2922 occurred at disk power-on lifetime: 74 hours (3 days + 2 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 18 2a 02 e0  Error: UNC at LBA = 0x00022a18 = 141848

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 18 2a 02 e0 00      00:30:36.883  READ DMA
   27 00 00 00 00 00 e0 02      00:30:36.758  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      00:30:35.189  IDENTIFY DEVICE
   ef 03 46 00 00 00 a0 02      00:30:38.826  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      00:30:38.769  READ NATIVE MAX ADDRESS EXT

Error 2921 occurred at disk power-on lifetime: 74 hours (3 days + 2 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 18 2a 02 e0  Error: UNC at LBA = 0x00022a18 = 141848

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 18 2a 02 e0 00      00:30:36.883  READ DMA
   27 00 00 00 00 00 e0 02      00:30:36.758  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      00:30:35.189  IDENTIFY DEVICE
   ef 03 46 00 00 00 a0 02      00:30:35.132  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      00:30:35.129  READ NATIVE MAX ADDRESS EXT

Error 2920 occurred at disk power-on lifetime: 74 hours (3 days + 2 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 18 2a 02 e0  Error: UNC at LBA = 0x00022a18 = 141848

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 18 2a 02 e0 00      00:30:33.087  READ DMA
   27 00 00 00 00 00 e0 02      00:30:31.518  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      00:30:35.189  IDENTIFY DEVICE
   ef 03 46 00 00 00 a0 02      00:30:35.132  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      00:30:35.129  READ NATIVE MAX ADDRESS EXT

Error 2919 occurred at disk power-on lifetime: 74 hours (3 days + 2 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 18 2a 02 e0  Error: UNC at LBA = 0x00022a18 = 141848

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 18 2a 02 e0 00      00:30:33.087  READ DMA
   27 00 00 00 00 00 e0 02      00:30:31.518  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      00:30:31.462  IDENTIFY DEVICE
   ef 03 46 00 00 00 a0 02      00:30:31.459  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      00:30:31.443  READ NATIVE MAX ADDRESS EXT

Error 2918 occurred at disk power-on lifetime: 74 hours (3 days + 2 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 51 00 18 2a 02 e0  Error: UNC at LBA = 0x00022a18 = 141848

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 08 18 2a 02 e0 00      00:30:27.863  READ DMA
   27 00 00 00 00 00 e0 02      00:30:31.518  READ NATIVE MAX ADDRESS EXT
   ec 00 00 00 00 00 a0 02      00:30:31.462  IDENTIFY DEVICE
   ef 03 46 00 00 00 a0 02      00:30:31.459  SET FEATURES [Set transfer mode]
   27 00 00 00 00 00 e0 02      00:30:31.443  READ NATIVE MAX ADDRESS EXT

SMART Self-test log structure revision number 1

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


Based on all of the above, I now suspect a hardware problem with
/dev/sdb (as you suspected), which was formerly /dev/sda.
There were two errors with the drive currently attached to /dev/sda, 
but if they
don't come back, I won't worry.

Do you concur?

Thanks,
jeff

