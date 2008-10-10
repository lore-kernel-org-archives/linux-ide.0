From: Scott Beardsley <scott@cse.ucdavis.edu>
Subject: SATA resets via SMART selftest
Date: Fri, 10 Oct 2008 13:38:15 -0700
Message-ID: <48EFBD37.8040604@cse.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cse.ucdavis.edu ([128.120.246.11]:37910 "EHLO
	mail.cse.ucdavis.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759671AbYJJVDt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 17:03:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 67B2390002
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 13:38:33 -0700 (PDT)
Received: from mail.cse.ucdavis.edu ([127.0.0.1])
	by localhost (mail.cse.ucdavis.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25744-02 for <linux-ide@vger.kernel.org>;
	Fri, 10 Oct 2008 13:38:23 -0700 (PDT)
Received: from [128.120.246.129] (automatic.cse.ucdavis.edu [128.120.246.129])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 0C75890005
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 13:38:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I originally posted this to smartmontools but was redirected here.

I am running into a problem with short or long smartctl selftests 
causing a disk reset. I'm using kernel.org v2.6.27 (I've also tried a 
few CentOS kernels) and smartmontools v5.38 (the latest of each). When I 
initiate a short selftest it'll run fine for a couple seconds then the 
iowait jumps up while the disk resets. I don't think this is a disk 
issue since I have 36 identical machines (and they all have this same 
reproducible behavior). I also don't think it is a power problem because 
the disks have seated correctly and the machine stays online when the 
cpus are at 100%. The disks seem to be functioning normally because I 
can read and write the whole disk. After I request a short selftest I 
get this in dmesg:

sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd ca/00:40:bf:58:00/00:00:00:00:00/e0 tag 0 dma 32768 out
           res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: link is slow to respond, please be patient (ready=0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting link
ata1: link is slow to respond, please be patient (ready=0)
ata1.00: configured for UDMA/133
ata1: EH complete

Here is some smartctl info that might be helpful (you can see it reset 
three times):

# ./smartctl -d ata -a /dev/sda
smartctl version 5.38 [x86_64-unknown-linux-gnu] Copyright (C) 2002-8
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     ST3500320NS
Serial Number:    9QM6YX2A
Firmware Version: SN05
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Fri Oct 10 12:33:59 2008 CDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                          was completed without error.
                                          Auto Offline Data Collection:
Enabled.
Self-test execution status:      (  41) The self-test routine was
interrupted
                                          by the host with a hard or soft
reset.
Total time to complete Offline
data collection:                 ( 634) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                          Auto Offline data collection
on/off support.
                                          Suspend Offline collection 
upon new
                                          command.
                                          Offline surface scan supported.
                                          Self-test supported.
                                          Conveyance Self-test supported.
                                          Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                          power-saving mode.
                                          Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                          General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 114) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x003d) SCT Status supported.
                                          SCT Feature Control supported.
                                          SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
    1 Raw_Read_Error_Rate     0x000f   072   069   044    Pre-fail
Always       -       20837137
    3 Spin_Up_Time            0x0003   099   099   000    Pre-fail
Always       -       0
    4 Start_Stop_Count        0x0032   100   100   020    Old_age
Always       -       8
    5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail
Always       -       0
    7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail
Always       -       644433
    9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       212
   10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail
Always       -       0
   12 Power_Cycle_Count       0x0032   100   037   020    Old_age
Always       -       8
184 Unknown_Attribute       0x0032   100   100   099    Old_age   Always
        -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always
        -       0
188 Unknown_Attribute       0x0032   100   100   000    Old_age   Always
        -       0
189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always
        -       0
190 Airflow_Temperature_Cel 0x0022   072   070   045    Old_age   Always
        -       28 (Lifetime Min/Max 28/28)
194 Temperature_Celsius     0x0022   028   040   000    Old_age   Always
        -       28 (0 25 0 0)
195 Hardware_ECC_Recovered  0x001a   035   032   000    Old_age   Always
        -       20837137
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always
        -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always
        -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Interrupted (host reset)      00%       212
       -
# 2  Short offline       Interrupted (host reset)      00%       211
       -
# 3  Extended offline    Interrupted (host reset)      00%       166
       -

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

Any ideas?
Scott

