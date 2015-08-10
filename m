From: Andy Smith <andy@strugglers.net>
Subject: Re: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and
 Intel s3610 SSDs
Date: Mon, 10 Aug 2015 16:37:38 +0000
Message-ID: <20150810163737.GA4243@bitfolk.com>
References: <20150809042756.GX4243@bitfolk.com>
 <55C8C4A7.2050706@seoss.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T+pC2oWDnZe2L1/G"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bitfolk.com ([85.119.80.223]:43496 "EHLO mail.bitfolk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbbHJQhk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2015 12:37:40 -0400
Content-Disposition: inline
In-Reply-To: <55C8C4A7.2050706@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org


--T+pC2oWDnZe2L1/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tim,

Thanks for getting back to me.

On Mon, Aug 10, 2015 at 04:35:03PM +0100, Tim Small wrote:
> Is there any useful info from smartctl -x ?  e.g. reset counters or
> other logged errors - either drive internal errors or cabling/link
> related "Sata Phy Event Counters" etc.?

I do not think so, but I have attached the output from this for each
drive. sdb is where it has happened most recently (four times since
4th August).

> Is attempting to ready SMART info status (e.g. through some daemon e.g.
> munin hddtemp etc.) actually triggering these errors?  FWIW smartctl -x
> seemed to elicit a reset on an Intel S3510 for me about 5 minutes ago.

I didn't manage to get this machine into service yet before having
this happen so none of this sort of disk monitoring is running. I
can't seem to trigger the problem with any of my usual invocations
of smartctl -i, -A or -x.

When this first occurred I ran a full SMART long self-test of what
was at the time sdb (at the moment it's sda), and that passed.

> Do the drives work any more reliably on a good PCIe card (such as an
> asmedia ASM1061 controller, or Sil3132 = both < $15 assuming you are
> able to add one) or do you see the same errors?

Unfortunately this is difficult to test as it's in a 1U enclosure
with only 1 slot at the back of the chassis, which is currently
filled. I'll be looking into what I can do with a riser card as a
last resort if I can find out a SATA chipset that is definitely
known to work with the s3610 drives.

Offlist I had someone report that their entire batch of 3710 drives
was suffering this same problem when plugged into Intel C220
chipset; this being on a platform where they previously had other
Intel drives including 3500 and 3700 without issue.

I have a support case open with Intel but they haven't given me any
useful info yet. They actually seem keen to take the drives back
under warranty but it looks like this would result in a replacement
that has the exact same problems. I don't even know if the problem
is in the drive or the SATA chipset or the kernel or what, yet. :(

> Have you checked the Intel docs for errata on either part?

Yep, can't find anything there.

> Disabling NCQ may just be significant, or it may of course just be
> slowing down throughput such that the error is less likely to occur -
> assuming it's timing-related.

Indeed. Disabling NCQ reduces the IOPS performance to around 25% so
it's not something I can just put up with!

Increasing the queue depth to 8 restores pretty much full
performance so I will do some tests to see if this problem re-occurs
there and at other values, but this takes a long time as the problem
only appears rarely for me.

Cheers,
Andy

--T+pC2oWDnZe2L1/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smartctl_x_sda.txt"

smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     INTEL SSDSC2BX016T4
Serial Number:    BTHC511604V41P6PGN
LU WWN Device Id: 5 5cd2e4 04b7b1bfa
Firmware Version: G2010110
User Capacity:    1,600,321,314,816 bytes [1.60 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 T13/2015-D revision 3
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon Aug 10 16:10:10 2015 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM feature is:   Unavailable
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, frozen [SEC2]
Wt Cache Reorder: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x02)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		(  240) seconds.
Offline data collection
capabilities: 			 (0x79) SMART execute Offline immediate.
					No Auto Offline data collection support.
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
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (   2) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  5 Reallocated_Sector_Ct   -O--CK   099   099   000    -    0
  9 Power_On_Hours          -O--CK   100   100   000    -    724
 12 Power_Cycle_Count       -O--CK   100   100   000    -    18
170 Unknown_Attribute       PO--CK   100   100   010    -    0
171 Unknown_Attribute       -O--CK   100   100   000    -    0
172 Unknown_Attribute       -O--CK   100   100   000    -    0
174 Unknown_Attribute       -O--CK   100   100   000    -    3
175 Program_Fail_Count_Chip PO--CK   100   100   010    -    4639433882
183 Runtime_Bad_Block       -O--CK   100   100   000    -    0
184 End-to-End_Error        PO--CK   100   100   090    -    0
187 Reported_Uncorrect      -O--CK   100   100   000    -    0
190 Airflow_Temperature_Cel -O---K   075   064   000    -    25 (Min/Max 23/39)
192 Power-Off_Retract_Count -O--CK   100   100   000    -    3
194 Temperature_Celsius     -O---K   100   100   000    -    25
197 Current_Pending_Sector  -O--C-   100   100   000    -    0
199 UDMA_CRC_Error_Count    -OSRCK   100   100   000    -    0
225 Unknown_SSD_Attribute   -O--CK   100   100   000    -    149925
226 Unknown_SSD_Attribute   -O--CK   100   100   000    -    30
227 Unknown_SSD_Attribute   -O--CK   100   100   000    -    55
228 Power-off_Retract_Count -O--CK   100   100   000    -    43348
232 Available_Reservd_Space PO--CK   100   100   010    -    0
233 Media_Wearout_Indicator -O--CK   100   100   000    -    0
234 Unknown_Attribute       -O--CK   100   100   000    -    0
241 Total_LBAs_Written      -O--CK   100   100   000    -    149925
242 Total_LBAs_Read         -O--CK   100   100   000    -    185746
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01       GPL,SL  R/O      1  Summary SMART error log
0x02       GPL,SL  R/O      8  Comprehensive SMART error log
0x03       GPL,SL  R/O     20  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06       GPL,SL  R/O      1  SMART self-test log
0x07       GPL,SL  R/O      2  Extended self-test log
0x09       GPL,SL  R/W      1  Selective self-test log
0x10       GPL,SL  R/O      1  SATA NCQ Queued Error log
0x11       GPL,SL  R/O      1  SATA Phy Event Counters log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xb0       GPL,SL  VS       1  Device vendor specific log
0xb1       GPL,SL  VS      33  Device vendor specific log
0xb8       GPL,SL  VS       1  Device vendor specific log
0xb9       GPL     VS    1544  Device vendor specific log
0xb9       SL      VS       8  Device vendor specific log
0xba       GPL     VS    1280  Device vendor specific log
0xdf       GPL,SL  VS       1  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (20 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (2 sectors)
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%       348         -

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

SCT Status Version:                  3
SCT Version (vendor specific):       1 (0x0001)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    25 Celsius
Power Cycle Min/Max Temperature:     23/39 Celsius
Lifetime    Min/Max Temperature:     20/57 Celsius
Under/Over Temperature Limit Count:   0/0
Vendor specific:
00 00 64 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/70 Celsius
Min/Max Temperature Limit:            0/70 Celsius
Temperature History Size (Index):    478 (188)

Index    Estimated Time   Temperature Celsius
 189    2015-08-10 08:13    25  ******
 190    2015-08-10 08:14    24  *****
 ...    ..(  2 skipped).    ..  *****
 193    2015-08-10 08:17    24  *****
 194    2015-08-10 08:18    25  ******
 195    2015-08-10 08:19    24  *****
 ...    ..(  2 skipped).    ..  *****
 198    2015-08-10 08:22    24  *****
 199    2015-08-10 08:23    25  ******
 200    2015-08-10 08:24    25  ******
 201    2015-08-10 08:25    24  *****
 ...    ..(  2 skipped).    ..  *****
 204    2015-08-10 08:28    24  *****
 205    2015-08-10 08:29    25  ******
 206    2015-08-10 08:30    25  ******
 207    2015-08-10 08:31    25  ******
 208    2015-08-10 08:32    24  *****
 209    2015-08-10 08:33    24  *****
 210    2015-08-10 08:34    24  *****
 211    2015-08-10 08:35    26  *******
 212    2015-08-10 08:36    27  ********
 213    2015-08-10 08:37    27  ********
 214    2015-08-10 08:38    26  *******
 215    2015-08-10 08:39    25  ******
 ...    ..(  8 skipped).    ..  ******
 224    2015-08-10 08:48    25  ******
 225    2015-08-10 08:49    24  *****
 226    2015-08-10 08:50    24  *****
 227    2015-08-10 08:51    24  *****
 228    2015-08-10 08:52    25  ******
 229    2015-08-10 08:53    25  ******
 230    2015-08-10 08:54    24  *****
 ...    ..(  2 skipped).    ..  *****
 233    2015-08-10 08:57    24  *****
 234    2015-08-10 08:58    25  ******
 235    2015-08-10 08:59    25  ******
 236    2015-08-10 09:00    24  *****
 ...    ..(  2 skipped).    ..  *****
 239    2015-08-10 09:03    24  *****
 240    2015-08-10 09:04    25  ******
 241    2015-08-10 09:05    25  ******
 242    2015-08-10 09:06    24  *****
 ...    ..(  2 skipped).    ..  *****
 245    2015-08-10 09:09    24  *****
 246    2015-08-10 09:10    25  ******
 247    2015-08-10 09:11    24  *****
 ...    ..(  3 skipped).    ..  *****
 251    2015-08-10 09:15    24  *****
 252    2015-08-10 09:16    25  ******
 253    2015-08-10 09:17    26  *******
 254    2015-08-10 09:18    27  ********
 255    2015-08-10 09:19    26  *******
 256    2015-08-10 09:20    25  ******
 257    2015-08-10 09:21    26  *******
 258    2015-08-10 09:22    25  ******
 ...    ..(  6 skipped).    ..  ******
 265    2015-08-10 09:29    25  ******
 266    2015-08-10 09:30    24  *****
 267    2015-08-10 09:31    24  *****
 268    2015-08-10 09:32    25  ******
 269    2015-08-10 09:33    25  ******
 270    2015-08-10 09:34    25  ******
 271    2015-08-10 09:35    24  *****
 ...    ..(  2 skipped).    ..  *****
 274    2015-08-10 09:38    24  *****
 275    2015-08-10 09:39    25  ******
 276    2015-08-10 09:40    25  ******
 277    2015-08-10 09:41    24  *****
 278    2015-08-10 09:42    24  *****
 279    2015-08-10 09:43    24  *****
 280    2015-08-10 09:44    25  ******
 281    2015-08-10 09:45    25  ******
 282    2015-08-10 09:46    24  *****
 ...    ..(  3 skipped).    ..  *****
 286    2015-08-10 09:50    24  *****
 287    2015-08-10 09:51    25  ******
 288    2015-08-10 09:52    24  *****
 ...    ..(  2 skipped).    ..  *****
 291    2015-08-10 09:55    24  *****
 292    2015-08-10 09:56    25  ******
 293    2015-08-10 09:57    25  ******
 294    2015-08-10 09:58    26  *******
 295    2015-08-10 09:59    26  *******
 296    2015-08-10 10:00    27  ********
 297    2015-08-10 10:01    26  *******
 298    2015-08-10 10:02    26  *******
 299    2015-08-10 10:03    26  *******
 300    2015-08-10 10:04    25  ******
 ...    ..(  5 skipped).    ..  ******
 306    2015-08-10 10:10    25  ******
 307    2015-08-10 10:11    24  *****
 308    2015-08-10 10:12    25  ******
 ...    ..(  2 skipped).    ..  ******
 311    2015-08-10 10:15    25  ******
 312    2015-08-10 10:16    24  *****
 313    2015-08-10 10:17    24  *****
 314    2015-08-10 10:18    24  *****
 315    2015-08-10 10:19    25  ******
 316    2015-08-10 10:20    25  ******
 317    2015-08-10 10:21    24  *****
 ...    ..(  2 skipped).    ..  *****
 320    2015-08-10 10:24    24  *****
 321    2015-08-10 10:25    25  ******
 322    2015-08-10 10:26    25  ******
 323    2015-08-10 10:27    24  *****
 ...    ..(  2 skipped).    ..  *****
 326    2015-08-10 10:30    24  *****
 327    2015-08-10 10:31    25  ******
 328    2015-08-10 10:32    25  ******
 329    2015-08-10 10:33    24  *****
 330    2015-08-10 10:34    24  *****
 331    2015-08-10 10:35    24  *****
 332    2015-08-10 10:36    25  ******
 ...    ..(  2 skipped).    ..  ******
 335    2015-08-10 10:39    25  ******
 336    2015-08-10 10:40    26  *******
 337    2015-08-10 10:41    27  ********
 338    2015-08-10 10:42    26  *******
 339    2015-08-10 10:43    26  *******
 340    2015-08-10 10:44    26  *******
 341    2015-08-10 10:45    25  ******
 ...    ..( 10 skipped).    ..  ******
 352    2015-08-10 10:56    25  ******
 353    2015-08-10 10:57    24  *****
 354    2015-08-10 10:58    24  *****
 355    2015-08-10 10:59    25  ******
 ...    ..(  2 skipped).    ..  ******
 358    2015-08-10 11:02    25  ******
 359    2015-08-10 11:03    24  *****
 360    2015-08-10 11:04    24  *****
 361    2015-08-10 11:05    25  ******
 362    2015-08-10 11:06    25  ******
 363    2015-08-10 11:07    25  ******
 364    2015-08-10 11:08    24  *****
 365    2015-08-10 11:09    24  *****
 366    2015-08-10 11:10    24  *****
 367    2015-08-10 11:11    25  ******
 368    2015-08-10 11:12    25  ******
 369    2015-08-10 11:13    25  ******
 370    2015-08-10 11:14    24  *****
 371    2015-08-10 11:15    24  *****
 372    2015-08-10 11:16    25  ******
 ...    ..(  2 skipped).    ..  ******
 375    2015-08-10 11:19    25  ******
 376    2015-08-10 11:20    24  *****
 377    2015-08-10 11:21    26  *******
 378    2015-08-10 11:22    27  ********
 379    2015-08-10 11:23    27  ********
 380    2015-08-10 11:24    26  *******
 381    2015-08-10 11:25    26  *******
 382    2015-08-10 11:26    25  ******
 ...    ..( 16 skipped).    ..  ******
 399    2015-08-10 11:43    25  ******
 400    2015-08-10 11:44    24  *****
 401    2015-08-10 11:45    25  ******
 ...    ..(  2 skipped).    ..  ******
 404    2015-08-10 11:48    25  ******
 405    2015-08-10 11:49    24  *****
 406    2015-08-10 11:50    24  *****
 407    2015-08-10 11:51    25  ******
 ...    ..(  2 skipped).    ..  ******
 410    2015-08-10 11:54    25  ******
 411    2015-08-10 11:55    24  *****
 412    2015-08-10 11:56    24  *****
 413    2015-08-10 11:57    25  ******
 ...    ..(  4 skipped).    ..  ******
 418    2015-08-10 12:02    25  ******
 419    2015-08-10 12:03    26  *******
 420    2015-08-10 12:04    27  ********
 421    2015-08-10 12:05    27  ********
 422    2015-08-10 12:06    26  *******
 423    2015-08-10 12:07    26  *******
 424    2015-08-10 12:08    25  ******
 425    2015-08-10 12:09    26  *******
 426    2015-08-10 12:10    26  *******
 427    2015-08-10 12:11    25  ******
 ...    ..( 31 skipped).    ..  ******
 459    2015-08-10 12:43    25  ******
 460    2015-08-10 12:44    26  *******
 461    2015-08-10 12:45    27  ********
 462    2015-08-10 12:46    28  *********
 463    2015-08-10 12:47    26  *******
 ...    ..(  3 skipped).    ..  *******
 467    2015-08-10 12:51    26  *******
 468    2015-08-10 12:52    25  ******
 ...    ..( 32 skipped).    ..  ******
  23    2015-08-10 13:25    25  ******
  24    2015-08-10 13:26    26  *******
  25    2015-08-10 13:27    27  ********
  26    2015-08-10 13:28    27  ********
  27    2015-08-10 13:29    26  *******
 ...    ..(  2 skipped).    ..  *******
  30    2015-08-10 13:32    26  *******
  31    2015-08-10 13:33    25  ******
  32    2015-08-10 13:34    25  ******
  33    2015-08-10 13:35    25  ******
  34    2015-08-10 13:36    26  *******
  35    2015-08-10 13:37    26  *******
  36    2015-08-10 13:38    25  ******
 ...    ..( 27 skipped).    ..  ******
  64    2015-08-10 14:06    25  ******
  65    2015-08-10 14:07    26  *******
  66    2015-08-10 14:08    27  ********
  67    2015-08-10 14:09    27  ********
  68    2015-08-10 14:10    26  *******
 ...    ..(  2 skipped).    ..  *******
  71    2015-08-10 14:13    26  *******
  72    2015-08-10 14:14    25  ******
  73    2015-08-10 14:15    25  ******
  74    2015-08-10 14:16    25  ******
  75    2015-08-10 14:17    26  *******
  76    2015-08-10 14:18    26  *******
  77    2015-08-10 14:19    25  ******
 ...    ..( 28 skipped).    ..  ******
 106    2015-08-10 14:48    25  ******
 107    2015-08-10 14:49    26  *******
 108    2015-08-10 14:50    27  ********
 109    2015-08-10 14:51    27  ********
 110    2015-08-10 14:52    27  ********
 111    2015-08-10 14:53    26  *******
 112    2015-08-10 14:54    26  *******
 113    2015-08-10 14:55    26  *******
 114    2015-08-10 14:56    25  ******
 115    2015-08-10 14:57    26  *******
 116    2015-08-10 14:58    26  *******
 117    2015-08-10 14:59    26  *******
 118    2015-08-10 15:00    25  ******
 ...    ..(  8 skipped).    ..  ******
 127    2015-08-10 15:09    25  ******
 128    2015-08-10 15:10    26  *******
 ...    ..( 12 skipped).    ..  *******
 141    2015-08-10 15:23    26  *******
 142    2015-08-10 15:24    25  ******
 143    2015-08-10 15:25    25  ******
 144    2015-08-10 15:26    25  ******
 145    2015-08-10 15:27    26  *******
 146    2015-08-10 15:28    25  ******
 147    2015-08-10 15:29    25  ******
 148    2015-08-10 15:30    25  ******
 149    2015-08-10 15:31    26  *******
 150    2015-08-10 15:32    27  ********
 151    2015-08-10 15:33    28  *********
 152    2015-08-10 15:34    27  ********
 153    2015-08-10 15:35    26  *******
 ...    ..(  5 skipped).    ..  *******
 159    2015-08-10 15:41    26  *******
 160    2015-08-10 15:42    25  ******
 ...    ..( 27 skipped).    ..  ******
 188    2015-08-10 16:10    25  ******

SCT Error Recovery Control:
           Read: Disabled
          Write: Disabled

Device Statistics (GP Log 0x04)
Page Offset Size         Value  Description
  1  =====  =                =  == General Statistics (rev 2) ==
  1  0x008  4               18  Lifetime Power-On Resets
  1  0x018  6       9825502659  Logical Sectors Written
  1  0x020  6        395575224  Number of Write Commands
  1  0x028  6      12173068126  Logical Sectors Read
  1  0x030  6        344608437  Number of Read Commands
  4  =====  =                =  == General Errors Statistics (rev 1) ==
  4  0x008  4                0  Number of Reported Uncorrectable Errors
  4  0x010  4                0  Resets Between Cmd Acceptance and Completion
  5  =====  =                =  == Temperature Statistics (rev 1) ==
  5  0x008  1               25  Current Temperature
  5  0x010  1               27  Average Short Term Temperature
  5  0x018  1                -  Average Long Term Temperature
  5  0x020  1               57  Highest Temperature
  5  0x028  1               24  Lowest Temperature
  5  0x030  1               29  Highest Average Short Term Temperature
  5  0x038  1               24  Lowest Average Short Term Temperature
  5  0x040  1                -  Highest Average Long Term Temperature
  5  0x048  1                -  Lowest Average Long Term Temperature
  5  0x050  4                0  Time in Over-Temperature
  5  0x058  1               70  Specified Maximum Operating Temperature
  5  0x060  4                0  Time in Under-Temperature
  5  0x068  1                0  Specified Minimum Operating Temperature
  6  =====  =                =  == Transport Statistics (rev 1) ==
  6  0x008  4              156  Number of Hardware Resets
  6  0x010  4               65  Number of ASR Events
  6  0x018  4                0  Number of Interface CRC Errors
  7  =====  =                =  == Solid State Device Statistics (rev 1) ==
  7  0x008  1                0  Percentage Used Endurance Indicator

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  4            0  Command failed due to ICRC error
0x0003  4            0  R_ERR response for device-to-host data FIS
0x0004  4            0  R_ERR response for host-to-device data FIS
0x0006  4            0  R_ERR response for device-to-host non-data FIS
0x000a  4           12  Device-to-host register FISes sent due to a COMRESET
0x000b  4            0  CRC errors within host-to-device FIS
0x000d  4            0  Non-CRC errors within host-to-device FIS


--T+pC2oWDnZe2L1/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smartctl_x_sdb.txt"

smartctl 6.4 2014-10-07 r4002 [x86_64-linux-3.16.0-4-amd64] (local build)
Copyright (C) 2002-14, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     INTEL SSDSC2BX016T4
Serial Number:    BTHC511604SD1P6PGN
LU WWN Device Id: 5 5cd2e4 04b7b1ba2
Firmware Version: G2010110
User Capacity:    1,600,321,314,816 bytes [1.60 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 T13/2015-D revision 3
SATA Version is:  SATA 2.6, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon Aug 10 16:10:17 2015 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM feature is:   Unavailable
Rd look-ahead is: Enabled
Write cache is:   Enabled
ATA Security is:  Disabled, frozen [SEC2]
Wt Cache Reorder: Enabled

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
data collection: 		(    0) seconds.
Offline data collection
capabilities: 			 (0x79) SMART execute Offline immediate.
					No Auto Offline data collection support.
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
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (   2) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  5 Reallocated_Sector_Ct   -O--CK   099   099   000    -    0
  9 Power_On_Hours          -O--CK   100   100   000    -    723
 12 Power_Cycle_Count       -O--CK   100   100   000    -    18
170 Unknown_Attribute       PO--CK   100   100   010    -    0
171 Unknown_Attribute       -O--CK   100   100   000    -    0
172 Unknown_Attribute       -O--CK   100   100   000    -    0
174 Unknown_Attribute       -O--CK   100   100   000    -    3
175 Program_Fail_Count_Chip PO--CK   100   100   010    -    4639433802
183 Runtime_Bad_Block       -O--CK   100   100   000    -    0
184 End-to-End_Error        PO--CK   100   100   090    -    0
187 Reported_Uncorrect      -O--CK   100   100   000    -    0
190 Airflow_Temperature_Cel -O---K   074   063   000    -    26 (Min/Max 24/39)
192 Power-Off_Retract_Count -O--CK   100   100   000    -    3
194 Temperature_Celsius     -O---K   100   100   000    -    26
197 Current_Pending_Sector  -O--C-   100   100   000    -    0
199 UDMA_CRC_Error_Count    -OSRCK   100   100   000    -    0
225 Unknown_SSD_Attribute   -O--CK   100   100   000    -    106841
226 Unknown_SSD_Attribute   -O--CK   100   100   000    -    20
227 Unknown_SSD_Attribute   -O--CK   100   100   000    -    59
228 Power-off_Retract_Count -O--CK   100   100   000    -    43268
232 Available_Reservd_Space PO--CK   100   100   010    -    0
233 Media_Wearout_Indicator -O--CK   100   100   000    -    0
234 Unknown_Attribute       -O--CK   100   100   000    -    0
241 Total_LBAs_Written      -O--CK   100   100   000    -    106841
242 Total_LBAs_Read         -O--CK   100   100   000    -    154700
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01       GPL,SL  R/O      1  Summary SMART error log
0x02       GPL,SL  R/O      8  Comprehensive SMART error log
0x03       GPL,SL  R/O     20  Ext. Comprehensive SMART error log
0x04       GPL,SL  R/O      8  Device Statistics log
0x06       GPL,SL  R/O      1  SMART self-test log
0x07       GPL,SL  R/O      2  Extended self-test log
0x09       GPL,SL  R/W      1  Selective self-test log
0x10       GPL,SL  R/O      1  SATA NCQ Queued Error log
0x11       GPL,SL  R/O      1  SATA Phy Event Counters log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xb0       GPL,SL  VS       1  Device vendor specific log
0xb1       GPL,SL  VS      33  Device vendor specific log
0xb8       GPL,SL  VS       1  Device vendor specific log
0xb9       GPL     VS    1544  Device vendor specific log
0xb9       SL      VS       8  Device vendor specific log
0xba       GPL     VS    1280  Device vendor specific log
0xdf       GPL,SL  VS       1  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (20 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (2 sectors)
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

SCT Status Version:                  3
SCT Version (vendor specific):       1 (0x0001)
SCT Support Level:                   0
Device State:                        Active (0)
Current Temperature:                    26 Celsius
Power Cycle Min/Max Temperature:     24/39 Celsius
Lifetime    Min/Max Temperature:     20/55 Celsius
Under/Over Temperature Limit Count:   0/0
Vendor specific:
00 00 64 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/70 Celsius
Min/Max Temperature Limit:            0/70 Celsius
Temperature History Size (Index):    478 (319)

Index    Estimated Time   Temperature Celsius
 320    2015-08-10 08:13    25  ******
 ...    ..( 19 skipped).    ..  ******
 340    2015-08-10 08:33    25  ******
 341    2015-08-10 08:34    24  *****
 342    2015-08-10 08:35    26  *******
 343    2015-08-10 08:36    27  ********
 344    2015-08-10 08:37    28  *********
 345    2015-08-10 08:38    26  *******
 ...    ..(  3 skipped).    ..  *******
 349    2015-08-10 08:42    26  *******
 350    2015-08-10 08:43    25  ******
 ...    ..( 18 skipped).    ..  ******
 369    2015-08-10 09:02    25  ******
 370    2015-08-10 09:03    24  *****
 371    2015-08-10 09:04    25  ******
 ...    ..( 11 skipped).    ..  ******
 383    2015-08-10 09:16    25  ******
 384    2015-08-10 09:17    26  *******
 385    2015-08-10 09:18    27  ********
 386    2015-08-10 09:19    27  ********
 387    2015-08-10 09:20    26  *******
 ...    ..(  2 skipped).    ..  *******
 390    2015-08-10 09:23    26  *******
 391    2015-08-10 09:24    25  ******
 ...    ..( 32 skipped).    ..  ******
 424    2015-08-10 09:57    25  ******
 425    2015-08-10 09:58    26  *******
 426    2015-08-10 09:59    27  ********
 427    2015-08-10 10:00    27  ********
 428    2015-08-10 10:01    26  *******
 ...    ..(  2 skipped).    ..  *******
 431    2015-08-10 10:04    26  *******
 432    2015-08-10 10:05    25  ******
 433    2015-08-10 10:06    25  ******
 434    2015-08-10 10:07    25  ******
 435    2015-08-10 10:08    26  *******
 436    2015-08-10 10:09    26  *******
 437    2015-08-10 10:10    25  ******
 ...    ..( 28 skipped).    ..  ******
 466    2015-08-10 10:39    25  ******
 467    2015-08-10 10:40    26  *******
 468    2015-08-10 10:41    27  ********
 469    2015-08-10 10:42    27  ********
 470    2015-08-10 10:43    26  *******
 471    2015-08-10 10:44    27  ********
 472    2015-08-10 10:45    26  *******
 473    2015-08-10 10:46    26  *******
 474    2015-08-10 10:47    25  ******
 475    2015-08-10 10:48    25  ******
 476    2015-08-10 10:49    26  *******
 477    2015-08-10 10:50    26  *******
   0    2015-08-10 10:51    25  ******
 ...    ..( 28 skipped).    ..  ******
  29    2015-08-10 11:20    25  ******
  30    2015-08-10 11:21    26  *******
  31    2015-08-10 11:22    26  *******
  32    2015-08-10 11:23    27  ********
  33    2015-08-10 11:24    27  ********
  34    2015-08-10 11:25    26  *******
  35    2015-08-10 11:26    26  *******
  36    2015-08-10 11:27    26  *******
  37    2015-08-10 11:28    25  ******
  38    2015-08-10 11:29    26  *******
  39    2015-08-10 11:30    26  *******
  40    2015-08-10 11:31    26  *******
  41    2015-08-10 11:32    25  ******
 ...    ..( 29 skipped).    ..  ******
  71    2015-08-10 12:02    25  ******
  72    2015-08-10 12:03    26  *******
  73    2015-08-10 12:04    27  ********
  74    2015-08-10 12:05    28  *********
  75    2015-08-10 12:06    27  ********
  76    2015-08-10 12:07    26  *******
 ...    ..(  5 skipped).    ..  *******
  82    2015-08-10 12:13    26  *******
  83    2015-08-10 12:14    25  ******
  84    2015-08-10 12:15    25  ******
  85    2015-08-10 12:16    26  *******
  86    2015-08-10 12:17    26  *******
  87    2015-08-10 12:18    25  ******
 ...    ..(  2 skipped).    ..  ******
  90    2015-08-10 12:21    25  ******
  91    2015-08-10 12:22    26  *******
  92    2015-08-10 12:23    25  ******
 ...    ..( 16 skipped).    ..  ******
 109    2015-08-10 12:40    25  ******
 110    2015-08-10 12:41    26  *******
 111    2015-08-10 12:42    25  ******
 112    2015-08-10 12:43    25  ******
 113    2015-08-10 12:44    26  *******
 114    2015-08-10 12:45    27  ********
 115    2015-08-10 12:46    28  *********
 116    2015-08-10 12:47    27  ********
 117    2015-08-10 12:48    26  *******
 ...    ..(  9 skipped).    ..  *******
 127    2015-08-10 12:58    26  *******
 128    2015-08-10 12:59    25  ******
 ...    ..(  2 skipped).    ..  ******
 131    2015-08-10 13:02    25  ******
 132    2015-08-10 13:03    26  *******
 133    2015-08-10 13:04    25  ******
 ...    ..(  3 skipped).    ..  ******
 137    2015-08-10 13:08    25  ******
 138    2015-08-10 13:09    26  *******
 139    2015-08-10 13:10    25  ******
 ...    ..( 14 skipped).    ..  ******
 154    2015-08-10 13:25    25  ******
 155    2015-08-10 13:26    27  ********
 156    2015-08-10 13:27    27  ********
 157    2015-08-10 13:28    28  *********
 158    2015-08-10 13:29    27  ********
 159    2015-08-10 13:30    26  *******
 ...    ..(  8 skipped).    ..  *******
 168    2015-08-10 13:39    26  *******
 169    2015-08-10 13:40    25  ******
 170    2015-08-10 13:41    25  ******
 171    2015-08-10 13:42    25  ******
 172    2015-08-10 13:43    26  *******
 173    2015-08-10 13:44    26  *******
 174    2015-08-10 13:45    25  ******
 ...    ..(  2 skipped).    ..  ******
 177    2015-08-10 13:48    25  ******
 178    2015-08-10 13:49    26  *******
 179    2015-08-10 13:50    26  *******
 180    2015-08-10 13:51    25  ******
 ...    ..( 15 skipped).    ..  ******
 196    2015-08-10 14:07    25  ******
 197    2015-08-10 14:08    26  *******
 198    2015-08-10 14:09    27  ********
 199    2015-08-10 14:10    27  ********
 200    2015-08-10 14:11    26  *******
 201    2015-08-10 14:12    27  ********
 202    2015-08-10 14:13    26  *******
 ...    ..(  6 skipped).    ..  *******
 209    2015-08-10 14:20    26  *******
 210    2015-08-10 14:21    25  ******
 211    2015-08-10 14:22    25  ******
 212    2015-08-10 14:23    26  *******
 213    2015-08-10 14:24    26  *******
 214    2015-08-10 14:25    26  *******
 215    2015-08-10 14:26    25  ******
 216    2015-08-10 14:27    25  ******
 217    2015-08-10 14:28    25  ******
 218    2015-08-10 14:29    26  *******
 219    2015-08-10 14:30    26  *******
 220    2015-08-10 14:31    25  ******
 ...    ..(  3 skipped).    ..  ******
 224    2015-08-10 14:35    25  ******
 225    2015-08-10 14:36    26  *******
 226    2015-08-10 14:37    25  ******
 ...    ..(  3 skipped).    ..  ******
 230    2015-08-10 14:41    25  ******
 231    2015-08-10 14:42    26  *******
 232    2015-08-10 14:43    25  ******
 ...    ..(  2 skipped).    ..  ******
 235    2015-08-10 14:46    25  ******
 236    2015-08-10 14:47    26  *******
 237    2015-08-10 14:48    25  ******
 238    2015-08-10 14:49    26  *******
 239    2015-08-10 14:50    27  ********
 240    2015-08-10 14:51    28  *********
 241    2015-08-10 14:52    27  ********
 242    2015-08-10 14:53    27  ********
 243    2015-08-10 14:54    27  ********
 244    2015-08-10 14:55    26  *******
 ...    ..(  5 skipped).    ..  *******
 250    2015-08-10 15:01    26  *******
 251    2015-08-10 15:02    25  ******
 252    2015-08-10 15:03    26  *******
 253    2015-08-10 15:04    26  *******
 254    2015-08-10 15:05    26  *******
 255    2015-08-10 15:06    25  ******
 ...    ..(  2 skipped).    ..  ******
 258    2015-08-10 15:09    25  ******
 259    2015-08-10 15:10    26  *******
 260    2015-08-10 15:11    26  *******
 261    2015-08-10 15:12    25  ******
 262    2015-08-10 15:13    25  ******
 263    2015-08-10 15:14    25  ******
 264    2015-08-10 15:15    26  *******
 265    2015-08-10 15:16    26  *******
 266    2015-08-10 15:17    26  *******
 267    2015-08-10 15:18    25  ******
 268    2015-08-10 15:19    25  ******
 269    2015-08-10 15:20    25  ******
 270    2015-08-10 15:21    26  *******
 271    2015-08-10 15:22    26  *******
 272    2015-08-10 15:23    26  *******
 273    2015-08-10 15:24    25  ******
 274    2015-08-10 15:25    25  ******
 275    2015-08-10 15:26    25  ******
 276    2015-08-10 15:27    26  *******
 277    2015-08-10 15:28    26  *******
 278    2015-08-10 15:29    25  ******
 279    2015-08-10 15:30    26  *******
 280    2015-08-10 15:31    27  ********
 281    2015-08-10 15:32    28  *********
 282    2015-08-10 15:33    28  *********
 283    2015-08-10 15:34    27  ********
 284    2015-08-10 15:35    27  ********
 285    2015-08-10 15:36    26  *******
 ...    ..(  4 skipped).    ..  *******
 290    2015-08-10 15:41    26  *******
 291    2015-08-10 15:42    25  ******
 292    2015-08-10 15:43    25  ******
 293    2015-08-10 15:44    26  *******
 294    2015-08-10 15:45    26  *******
 295    2015-08-10 15:46    26  *******
 296    2015-08-10 15:47    25  ******
 297    2015-08-10 15:48    25  ******
 298    2015-08-10 15:49    25  ******
 299    2015-08-10 15:50    26  *******
 ...    ..(  2 skipped).    ..  *******
 302    2015-08-10 15:53    26  *******
 303    2015-08-10 15:54    25  ******
 304    2015-08-10 15:55    25  ******
 305    2015-08-10 15:56    26  *******
 306    2015-08-10 15:57    26  *******
 307    2015-08-10 15:58    25  ******
 ...    ..(  7 skipped).    ..  ******
 315    2015-08-10 16:06    25  ******
 316    2015-08-10 16:07    26  *******
 ...    ..(  2 skipped).    ..  *******
 319    2015-08-10 16:10    26  *******

SCT Error Recovery Control:
           Read: Disabled
          Write: Disabled

Device Statistics (GP Log 0x04)
Page Offset Size         Value  Description
  1  =====  =                =  == General Statistics (rev 2) ==
  1  0x008  4               18  Lifetime Power-On Resets
  1  0x018  6       7001931834  Logical Sectors Written
  1  0x020  6        392865538  Number of Write Commands
  1  0x028  6      10138428376  Logical Sectors Read
  1  0x030  6        348912307  Number of Read Commands
  4  =====  =                =  == General Errors Statistics (rev 1) ==
  4  0x008  4                0  Number of Reported Uncorrectable Errors
  4  0x010  4                0  Resets Between Cmd Acceptance and Completion
  5  =====  =                =  == Temperature Statistics (rev 1) ==
  5  0x008  1               26  Current Temperature
  5  0x010  1               27  Average Short Term Temperature
  5  0x018  1                -  Average Long Term Temperature
  5  0x020  1               55  Highest Temperature
  5  0x028  1               24  Lowest Temperature
  5  0x030  1               28  Highest Average Short Term Temperature
  5  0x038  1               24  Lowest Average Short Term Temperature
  5  0x040  1                -  Highest Average Long Term Temperature
  5  0x048  1                -  Lowest Average Long Term Temperature
  5  0x050  4                0  Time in Over-Temperature
  5  0x058  1               70  Specified Maximum Operating Temperature
  5  0x060  4                0  Time in Under-Temperature
  5  0x068  1                0  Specified Minimum Operating Temperature
  6  =====  =                =  == Transport Statistics (rev 1) ==
  6  0x008  4              265  Number of Hardware Resets
  6  0x010  4               61  Number of ASR Events
  6  0x018  4                0  Number of Interface CRC Errors
  7  =====  =                =  == Solid State Device Statistics (rev 1) ==
  7  0x008  1                0  Percentage Used Endurance Indicator

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  4            0  Command failed due to ICRC error
0x0003  4            0  R_ERR response for device-to-host data FIS
0x0004  4            0  R_ERR response for host-to-device data FIS
0x0006  4            0  R_ERR response for device-to-host non-data FIS
0x000a  4           15  Device-to-host register FISes sent due to a COMRESET
0x000b  4            0  CRC errors within host-to-device FIS
0x000d  4            0  Non-CRC errors within host-to-device FIS


--T+pC2oWDnZe2L1/G--
