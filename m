From: gene heskett <gheskett@wdtv.com>
Subject: Re: Seagate hard disk firmware issue
Date: Sat, 30 Apr 2011 08:08:59 -0400
Message-ID: <201104300808.59185.gheskett@wdtv.com>
References: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com> <AANLkTino+1xuzpYjJt0HCNFMP95bNOwWDVO5daehK0ny@mail.gmail.com> <BANLkTim5m51Qx=wm+C1LhEG7dE4C-nkGOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:40655 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1D3MPp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Apr 2011 08:15:45 -0400
In-Reply-To: <BANLkTim5m51Qx=wm+C1LhEG7dE4C-nkGOw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: BU66ER BAD6ER <debu66er@gmail.com>

On Saturday, April 30, 2011 07:56:21 AM BU66ER BAD6ER did opine:
This <linux-ide@vger.kernel.org> is a mailing list.  WTH when I click on 
reply-to-list, do I always have to copy/paste the lists address in the To: 
line?  fscking PIMA!

More below, where it should be.

> Hi,
> 
> Some time ago, I returned my hard disk and got a new one. Lately, I'm
> having performance issues again and I suspect there is a hardware
> error again like last time. If you could confirm this I would be most
> grateful.
> 
> Thanks in advance!
> 
> # smartctl -a /dev/sdb
> smartctl 5.41 2011-03-16 r3296
> [x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
> Copyright (C) 2002-11 by Bruce Allen,
> http://smartmontools.sourceforge.net
> 
> === START OF INFORMATION SECTION ===
> Device Model:     ST2000DL003-9VT166
> Serial Number:    5YD1YD5P
> Firmware Version: CC32
> User Capacity:    2,000,398,934,016 bytes
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   8
> ATA Standard is:  ATA-8-ACS revision 4
> Local Time is:    Sat Apr 30 12:59:32 2011 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status:  (0x82) Offline data collection activity
>                                         was completed without error.
>                                         Auto Offline Data Collection:
> Enabled. Self-test execution status:      (   0) The previous self-test
> routine completed without error or no self-test has ever been run.
> Total time to complete Offline
> data collection:                (  623) seconds.
> Offline data collection
> capabilities:                    (0x7b) SMART execute Offline immediate.
>                                         Auto Offline data collection
> on/off support.
>                                         Suspend Offline collection upon
> new command.
>                                         Offline surface scan supported.
>                                         Self-test supported.
>                                         Conveyance Self-test supported.
>                                         Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before entering
>                                         power-saving mode.
>                                         Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                         General Purpose Logging
> supported. Short self-test routine
> recommended polling time:        (   1) minutes.
> Extended self-test routine
> recommended polling time:        ( 255) minutes.
> Conveyance self-test routine
> recommended polling time:        (   2) minutes.
> SCT capabilities:              (0x30b7) SCT Status supported.
>                                         SCT Feature Control supported.
>                                         SCT Data Table supported.
> 
> SMART Attributes Data Structure revision number: 10
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
> UPDATED  WHEN_FAILED RAW_VALUE
>   1 Raw_Read_Error_Rate     0x000f   096   082   006    Pre-fail
> Always       -       2447656
>   3 Spin_Up_Time            0x0003   097   092   000    Pre-fail
> Always       -       0
>   4 Start_Stop_Count        0x0032   100   100   020    Old_age
> Always       -       265
>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail
> Always       -       0
>   7 Seek_Error_Rate         0x000f   060   060   030    Pre-fail
> Always       -       1108085
>   9 Power_On_Hours          0x0032   100   100   000    Old_age
> Always       -       717
>  10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail
> Always       -       0
>  12 Power_Cycle_Count       0x0032   100   100   020    Old_age
> Always       -       74
> 183 Runtime_Bad_Block       0x0032   100   100   000    Old_age
> Always       -       0
> 184 End-to-End_Error        0x0032   100   100   099    Old_age
> Always       -       0
> 187 Reported_Uncorrect      0x0032   001   001   000    Old_age
> Always       -       792
> 188 Command_Timeout         0x0032   100   100   000    Old_age
> Always       -       0
> 189 High_Fly_Writes         0x003a   100   100   000    Old_age
> Always       -       0
> 190 Airflow_Temperature_Cel 0x0022   065   062   045    Old_age
> Always       -       35 (Min/Max 35/35)
> 191 G-Sense_Error_Rate      0x0032   100   100   000    Old_age
> Always       -       0
> 192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
> Always       -       202
> 193 Load_Cycle_Count        0x0032   100   100   000    Old_age
> Always       -       265
> 194 Temperature_Celsius     0x0022   035   040   000    Old_age
> Always       -       35 (0 19 0 0)
> 195 Hardware_ECC_Recovered  0x001a   015   009   000    Old_age
> Always       -       2447656
> 197 Current_Pending_Sector  0x0012   096   096   000    Old_age
> Always       -       368
> 198 Offline_Uncorrectable   0x0010   096   096   000    Old_age
> Offline      -       368
> 199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
> Always       -       0
> 240 Head_Flying_Hours       0x0000   100   253   000    Old_age
> Offline      -       9354438771404
> 241 Total_LBAs_Written      0x0000   100   253   000    Old_age
> Offline      -       793142133
> 242 Total_LBAs_Read         0x0000   100   253   000    Old_age
> Offline      -       307847059
> 
> SMART Error Log Version: 1
> ATA Error Count: 828 (device log contains only the most recent five
> errors) CR = Command Register [HEX]
>         FR = Features Register [HEX]
>         SC = Sector Count Register [HEX]
>         SN = Sector Number Register [HEX]
>         CL = Cylinder Low Register [HEX]
>         CH = Cylinder High Register [HEX]
>         DH = Device/Head Register [HEX]
>         DC = Device Command Register [HEX]
>         ER = Error register [HEX]
>         ST = Status register [HEX]
> Powered_Up_Time is measured from power on, and printed as
> DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
> SS=sec, and sss=millisec. It "wraps" after 49.710 days.
> 
> Error 828 occurred at disk power-on lifetime: 705 hours (29 days + 9
> hours) When the command that caused the error occurred, the device was
> active or idle.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 ff ff ff ef 00      03:44:18.432  READ DMA EXT
>   27 00 00 00 00 00 e0 00      03:44:18.431  READ NATIVE MAX ADDRESS EXT
>   ec 00 00 00 00 00 a0 00      03:44:18.423  IDENTIFY DEVICE
>   ef 03 46 00 00 00 a0 00      03:44:18.391  SET FEATURES [Set transfer
> mode] 27 00 00 00 00 00 e0 00      03:44:18.391  READ NATIVE MAX
> ADDRESS EXT
> 
> Error 827 occurred at disk power-on lifetime: 705 hours (29 days + 9
> hours) When the command that caused the error occurred, the device was
> active or idle.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 ff ff ff ef 00      03:44:15.060  READ DMA EXT
>   27 00 00 00 00 00 e0 00      03:44:15.059  READ NATIVE MAX ADDRESS EXT
>   ec 00 00 00 00 00 a0 00      03:44:15.051  IDENTIFY DEVICE
>   ef 03 46 00 00 00 a0 00      03:44:15.019  SET FEATURES [Set transfer
> mode] 27 00 00 00 00 00 e0 00      03:44:15.019  READ NATIVE MAX
> ADDRESS EXT
> 
> Error 826 occurred at disk power-on lifetime: 705 hours (29 days + 9
> hours) When the command that caused the error occurred, the device was
> active or idle.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 ff ff ff ef 00      03:44:11.687  READ DMA EXT
>   27 00 00 00 00 00 e0 00      03:44:11.686  READ NATIVE MAX ADDRESS EXT
>   ec 00 00 00 00 00 a0 00      03:44:11.662  IDENTIFY DEVICE
>   ef 03 46 00 00 00 a0 00      03:44:11.566  SET FEATURES [Set transfer
> mode] 27 00 00 00 00 00 e0 00      03:44:11.566  READ NATIVE MAX
> ADDRESS EXT
> 
> Error 825 occurred at disk power-on lifetime: 705 hours (29 days + 9
> hours) When the command that caused the error occurred, the device was
> active or idle.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 ff ff ff ef 00      03:44:08.323  READ DMA EXT
>   27 00 00 00 00 00 e0 00      03:44:08.322  READ NATIVE MAX ADDRESS EXT
>   ec 00 00 00 00 00 a0 00      03:44:08.314  IDENTIFY DEVICE
>   ef 03 46 00 00 00 a0 00      03:44:08.282  SET FEATURES [Set transfer
> mode] 27 00 00 00 00 00 e0 00      03:44:08.282  READ NATIVE MAX
> ADDRESS EXT
> 
> Error 824 occurred at disk power-on lifetime: 705 hours (29 days + 9
> hours) When the command that caused the error occurred, the device was
> active or idle.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   40 51 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455
> 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>   -- -- -- -- -- -- -- --  ----------------  --------------------
>   25 00 08 ff ff ff ef 00      03:44:04.950  READ DMA EXT
>   27 00 00 00 00 00 e0 00      03:44:04.949  READ NATIVE MAX ADDRESS EXT
>   ec 00 00 00 00 00 a0 00      03:44:04.941  IDENTIFY DEVICE
>   ef 03 46 00 00 00 a0 00      03:44:04.910  SET FEATURES [Set transfer
> mode] 27 00 00 00 00 00 e0 00      03:44:04.909  READ NATIVE MAX
> ADDRESS EXT
> 
> SMART Self-test log structure revision number 1
> No self-tests have been logged.  [To run self-tests, use: smartctl -t]
> 
> 
> SMART Selective self-test log data structure revision number 1
>  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
>     1        0        0  Not_testing
>     2        0        0  Not_testing
>     3        0        0  Not_testing
>     4        0        0  Not_testing
>     5        0        0  Not_testing
> Selective self-test flags (0x0):
>   After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute
> delay.

I might run the selftest (long) to get a better idea, but if there is not a 
firmware update for this drive on the Seagate site, I believe I'd be asking 
for an RA forthwith.

Be aware that I just updated 2 identical 1 terrabyte Seagate drives about 3 
weeks ago, and the firmware update, while it did not scramble tha partition 
table data, did scramble the partition labels AND the blkid's of the boot 
drive only.  The second drive no longer is hanging the system with bus 
resets, but it still has a write speed of about 3.5 megs/second.  I had to 
re-install.  Fortunately I had data backups from the night before courtesy 
amanda.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
<http://tinyurl.com/ddg5bz>
<http://www.cantrip.org/gatto.html>
Row, row, row your bits, gently down the stream...
