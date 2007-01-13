From: Brad Fitzpatrick <brad@danga.com>
Subject: Re: Norco DS-1220 (sil3726+sil3124) / libata-tj bug report
Date: Sat, 13 Jan 2007 02:18:43 +0000 (UTC)
Message-ID: <Pine.LNX.4.58.0701130214230.17363@mailx>
References: <Pine.LNX.4.58.0701050332200.26166@mailx> <45A1AD84.5060202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.danga.com ([207.7.148.197]:49478 "EHLO danga.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161144AbXAMCSU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jan 2007 21:18:20 -0500
In-Reply-To: <45A1AD84.5060202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun,

On Mon, 8 Jan 2007, Tejun Heo wrote:

> > Disks in DS-1220 show up, kinda, but don't work.  Errors reading /
> > writing blocks.  Tried a single disk in both a PMP port and a direct
> > (non-sil3726) port.
>
> From full dmesg...
>
> The following is when the drive is attached via PMP.
>
> 18:29:55 ata3.01: (irq_stat 0x00020002, device error via D2H FIS)
> 18:29:55 ata3.01: tag 0 cmd 0xc8 Emask 0x1 stat 0x50 err 0x0 (device error)
>
> And directly.
>
> 19:30:23 ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> 19:30:23 ata6.00: (irq_stat 0x00060002, device error via D2H FIS)
> 19:30:23 ata6.00: tag 0 cmd 0xc4 Emask 0x1 stat 0x50 err 0x0 (device error)
> 19:30:23 ata6: EH complete
>
> Looks like a dead drive to me.  Care to post the result of 'smartctl -d
> ata -a /dev/sdX' and test other drives?

I tried another disk (but of the same type), and got the same results both
direct and via PMP.

Are these disks too old to be hot-plugged?  (but I recall the
identical errors happening on boot after I power-cycled the enclosure
and the host...)

Smartctl says:

smartctl -d ata -a /dev/sdd
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Western Digital Caviar SE (Serial ATA) family
Device Model:     WDC WD2500JD-00GBB0
Serial Number:    WD-WMAEP2562042
Firmware Version: 02.05D02
User Capacity:    250,059,350,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Jan  9 09:24:43 2007 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0) The previous self-test routine completed
                                        without error or no self-test has ever
                                        been run.
Total time to complete Offline
data collection:                 (7599) seconds.
Offline data collection
capabilities:                    (0x79) SMART execute Offline immediate.
                                        No Auto Offline data collection support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        No General Purpose Logging support.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        (  95) minutes.
Conveyance self-test routine
recommended polling time:        (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0007   120   116   021    Pre-fail  Always       -       4533
  4 Start_Stop_Count        0x0032   100   100   040    Old_age   Always       -       36
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000b   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   081   081   000    Old_age   Always       -       14040
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0013   100   253   051    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       36
194 Temperature_Celsius     0x0022   121   253   000    Old_age   Always       -       29
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0012   200   200   000    Old_age   Always       -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   155   051    Pre-fail  Offline      -       0

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

========


Sorry for the delay.

Let me know if I can test anything else.... different versions, etc.

I'll buy a new disk this weekend and try that out as well.

- Brad
