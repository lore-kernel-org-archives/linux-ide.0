From: "Omar A" <aliencoder@gmail.com>
Subject: Re: regarding frequent head unload problem
Date: Mon, 29 Sep 2008 18:34:19 +0200
Message-ID: <d212b62f0809290934u42c14f2i457810394efaada6@mail.gmail.com>
References: <48E08B99.1070508@kernel.org>
	 <200809291144.m8TBi2ml004281@dsl092-065-009.bos1.dsl.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:62954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYI2QeV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 12:34:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1483027fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 29 Sep 2008 09:34:19 -0700 (PDT)
In-Reply-To: <200809291144.m8TBi2ml004281@dsl092-065-009.bos1.dsl.speakeasy.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Krawitz <rlk@alum.mit.edu>
Cc: Tejun Heo <tj@kernel.org>, contact@i-nz.net, pascal@asmodeus.be, carlos.bessa@gmail.com, andrew.vaselaar@trinity.edu, webmaster@dragontower.de, wolfchri@gmail.com, aklitzing@online.de, aladin7501-01@yahoo.de, linux-ide@vger.kernel.org

Hi,
 My HD seems to unload several times a minute.

root@omar-laptop:~# while : ; do smartctl --all /dev/sda | grep ^193;
sleep 60; done
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3249
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3251
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3251
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3253
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3256
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3258
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3262
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3264
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3266

root@omar-laptop:~# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
Model Number:       WDC WD2500BEVS-75UST0
Serial Number:      WD-WXE708HR3348
Firmware Revision:  01.01A01
Standards:
Supported: 8 7 6 5
Likely used: 8
Configuration:
Logical max current
cylinders 16383 16383
heads 16 16
sectors/track 63 63
--
CHS current addressable sectors:   16514064
LBA    user addressable sectors:  268435455
LBA48  user addressable sectors:  488397168
device size with M = 1024*1024:      238475 MBytes
device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
LBA, IORDY(can be disabled)
Queue depth: 32
Standby timer values: spec'd by Standard, with device specific minimum
R/W multiple sector transfer: Max = 16 Current = 8
Advanced power management level: 128
Recommended acoustic management value: 128, current value: 254
DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
    Cycle time: min=120ns recommended=120ns
PIO: pio0 pio1 pio2 pio3 pio4
    Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
Enabled Supported:
  * SMART feature set
    Security Mode feature set
  * Power Management feature set
  * Write cache
  * Look-ahead
  * Host Protected Area feature set
  * WRITE_BUFFER command
  * READ_BUFFER command
  * NOP cmd
  * DOWNLOAD_MICROCODE
  * Advanced Power Management feature set
    SET_MAX security extension
  * Automatic Acoustic Management feature set
  * 48-bit Address feature set
  * Device Configuration Overlay feature set
  * Mandatory FLUSH_CACHE
  * FLUSH_CACHE_EXT
  * SMART error logging
  * SMART self-test
  * General Purpose Logging feature set
  * WRITE_{DMA|MULTIPLE}_FUA_EXT
  * 64-bit World wide name
  * IDLE_IMMEDIATE with UNLOAD
  * Segmented DOWNLOAD_MICROCODE
  * SATA-I signaling speed (1.5Gb/s)
  * Native Command Queueing (NCQ)
  * Host-initiated interface power management
  * Phy event counters
    DMA Setup Auto-Activate optimization
    Device-initiated interface power management
  * Software settings preservation
  * SMART Command Transport (SCT) feature set
  * SCT Long Sector Access (AC1)
  * SCT LBA Segment Access (AC2)
  * SCT Error Recovery Control (AC3)
  * SCT Features Control (AC4)
  * SCT Data Tables (AC5)
    unknown 206[12] (vendor specific)
    unknown 206[13] (vendor specific)
Security:
Master password revision code = 65534
supported
not enabled
not locked
frozen
not expired: security count
not supported: enhanced erase
92min for SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee25720269e
NAA : 5
IEEE OUI : 14ee
Unique ID : 25720269e
Checksum: correct

This is a Dell Inspiron 1318
2.6.24-19-generic #1 SMP Wed Aug 20 22:56:21 UTC 2008 i686 GNU/Linux

root@omar-laptop:~# smartctl --all /dev/sda
smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD2500BEVS-75UST0
Serial Number:    WD-WXE708HR3348
Firmware Version: 01.01A01
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Sep 29 18:32:08 2008 CEST
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
data collection: 		 (9180) seconds.
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
recommended polling time: 	 ( 110) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0003   188   187   021    Pre-fail
Always       -       1600
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       118
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x000e   100   253   051    Old_age
Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       161
 10 Spin_Retry_Count        0x0012   100   100   051    Old_age
Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       95
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age
Always       -       9
193 Load_Cycle_Count        0x0032   199   199   000    Old_age
Always       -       3274
194 Temperature_Celsius     0x0022   115   104   000    Old_age
Always       -       32
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0010   100   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x0008   100   253   051    Old_age
Offline      -       0
240 Head_Flying_Hours       0x0032   100   100   000    Old_age
Always       -       190
241 Unknown_Attribute       0x0032   195   195   000    Old_age
Always       -       5763852624323
242 Unknown_Attribute       0x0032   200   200   000    Old_age
Always       -       522340900

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%         4         -
# 2  Short offline       Completed without error       00%         1         -
# 3  Short offline       Completed without error       00%         0         -
# 4  Short offline       Completed without error       00%         0         -

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

Hope this helps.

Best Regards


On Mon, Sep 29, 2008 at 1:44 PM, Robert Krawitz <rlk@alum.mit.edu> wrote:
>   Date: Mon, 29 Sep 2008 17:02:33 +0900
>   From: Tejun Heo <tj@kernel.org>
>
>   Hello,
>
>   I'm writing to everyone who reported to me or linux-ide about frequent
>   head unload problem and the report is not yet committed to
>   storage-fixup.conf.
>
>   I'm a bit worried about the explosion of reports because I really
>   wanna avoid creating false entries as they will increase power
>   consumption on Linux unnecessarily.  I've just updated the Known
>   Issues wiki page.  Here are the update parts.
>
>    Note that modern laptop drives are supposed to unload frequently to
>    save power. Unless the unloading is excessive, disabling powersaving
>    is not a good idea. It seems that most modern drives are rated for
>    600,000 load/unload cycles which translates to about two years of
>    uptime at 35 unloads per hour. Even when assuming continuous 12 hours
>    of usage everyday, this means the drive will only reach its rated
>    load/unload cycle limit after four years and shouldn't be considered
>    malfunctioning. Please only report cases where the expected uptime is
>    significantly lower than two years.
>
>    ... Also, please include how many times the drive unloads the head
>    per-hour under nominal usage without any adjustment.
>
>   Machines currently on the storage.fixup list are (or at least supposed
>   to be) the extreme cases where the drive unloads its head multiple
>   times per minute decreasing its life expectancy to under a year.
>   Please double check your machine falls into this category.
>
> Mine was unloading multiple times per minute.  It had accumulated
> 70,000 cycles within the first month or two of use.
>
> --
> Robert Krawitz                                     <rlk@alum.mit.edu>
>
> Tall Clubs International  --  http://www.tall.org/ or 1-888-IM-TALL-2
> Member of the League for Programming Freedom -- mail lpf@uunet.uu.net
> Project lead for Gutenprint   --    http://gimp-print.sourceforge.net
>
> "Linux doesn't dictate how I work, I dictate how Linux works."
> --Eric Crampton
>



--
Am I the Alien?? I guess we will never know :-)
