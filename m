From: Denys Dmytriyenko <denis@denix.org>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 00:53:16 -0400
Message-ID: <20080318045316.GA3959@denix.org>
References: <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com>
 <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com>
 <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com>
 <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca>
 <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:41443 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYCRExb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 00:53:31 -0400
Received: from gandalf.denix.org ([71.126.191.34])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JXW00FZ1TKTPST3@vms044.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 17 Mar 2008 23:53:18 -0500 (CDT)
In-reply-to: <47DF4070.3040507@gmail.com>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

On Tue, Mar 18, 2008 at 01:09:20PM +0900, Tejun Heo wrote:
> Denys Dmytriyenko wrote:
> > Meanwhile my system was quite stable lately, except for a few times when it 
> > threw some exceptions below. Can you please help me interpret them and also 
> > point out to how I can do it myself in the future. Thanks in advance.
> > 
> > Mar  8 02:09:49 [kernel] ata8: illegal qc_active transition (00000019->00000038)
> 
> Hmmm... This is first.  Which driver is it?  It means that controller is
> reporting that NCQ command tags which are not issued (or already
> completed) are in-flight.  Due to the way hdd reports NCQ command
> completion, it's not possible for the drive to cause this.  This gotta
> be a bug on the host side (be it controller chip or more likely the
> driver).  The command tag in question is 5.  Only 0, 3 and 4 were in flight.

It is sata_sil24 on 2.6.23.9. If there were related fixes in the recent 
versions, I can retest it.

> > Mar  8 03:19:33 [kernel] ata8: illegal qc_active transition (000000ff->000001f7)
> 
> The same but problematic tag is 8.
> 
> > Mar 14 23:51:43 [kernel] ata3: illegal qc_active transition (0000001b->0000002b)
> 
> Ditto but with tag 5.
> 
> > Mar 14 23:51:55 [kernel] ata3: failed to read log page 10h (errno=-2)
> > Mar 14 23:51:55 [kernel] ata3.00: exception Emask 0x1 SAct 0x3f SErr 0x0 action 0x0
> > Mar 14 23:51:55 [kernel] ata3.00: irq_stat 0x00020002, device error via SDB FIS
> 
> This one is different.  The drive reported device error but the driver
> couldn't get more information about the error (log page 10h contains
> it).  What does smartctl -a on the drive say?

# smartctl -a /dev/sdc
smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Maxtor MaXLine Pro 500 family
Device Model:     Maxtor 7H500F0
Serial Number:    H81DAX1H
Firmware Version: HA431DN0
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Tue Mar 18 00:40:28 2008 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Enabled.
Self-test execution status:      (  32) The self-test routine was interrupted
                                        by the host with a hard or soft reset.
Total time to complete Offline
data collection:                 (9003) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off support.
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
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 206) minutes.

SMART Attributes Data Structure revision number: 32
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   169   168   063    Pre-fail  Always       -       16613
  4 Start_Stop_Count        0x0032   249   249   000    Old_age   Always       -       8406
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always       -       0
  8 Seek_Time_Performance   0x0027   251   241   187    Pre-fail  Always       -       33007
  9 Power_On_Hours          0x0032   242   242   000    Old_age   Always       -       3941
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always       -       263
189 Unknown_Attribute       0x003a   100   100   000    Old_age   Always       -       0
190 Temperature_Celsius     0x0022   063   050   000    Old_age   Always       -       689700901
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always       -       0
194 Temperature_Celsius     0x0032   039   253   000    Old_age   Always       -       37
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always       -       1912
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   002   001   000    Old_age   Offline      -       798
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always       -       0
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age   Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age   Always       -       0
210 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0
212 Unknown_Attribute       0x0032   253   252   000    Old_age   Always       -       0

SMART Error Log Version: 1
ATA Error Count: 42 (device log contains only the most recent five errors)
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

Error 42 occurred at disk power-on lifetime: 3444 hours (143 days + 12 hours)
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 41 28 ff 46 5a 40

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
  60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
  60 08 28 ff 46 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
  60 10 20 2f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED
  60 08 18 1f 47 5a 40 00   2d+07:38:11.073  READ FPDMA QUEUED

Error 41 occurred at disk power-on lifetime: 3405 hours (141 days + 21 hours)
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  00 41 01 10 00 00 a0  Error:

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  2f 00 01 10 00 00 a0 00      12:51:00.112  READ LOG EXT
  60 20 20 7f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
  60 08 18 6f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
  60 30 10 9f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED
  60 08 08 5f 32 4c 40 00      12:51:00.081  READ FPDMA QUEUED

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Offline             Interrupted (host reset)      00%      3941         -
# 2  Offline             Interrupted (host reset)      00%      1940         -
# 3  Offline             Interrupted (host reset)      00%      1894         -

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
Denys
