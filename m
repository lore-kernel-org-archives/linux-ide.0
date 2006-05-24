From: Ansgar Knappheide <aknapphe@uos.de>
Subject: Strange error codes on Promise SATAII150TX4
Date: Wed, 24 May 2006 10:43:51 +0200
Message-ID: <44741CC7.8000407@uos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sanode5eth1.rz.Uni-Osnabrueck.DE ([131.173.17.105]:26762 "EHLO
	sanode5eth1.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id S932630AbWEXIny (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 04:43:54 -0400
Received: from sanode11.rz.uni-osnabrueck.de (sanode11eth0.rz.Uni-Osnabrueck.DE [131.173.17.151])
	by sanode5eth1.rz.uni-osnabrueck.de (8.12.11/8.12.11) with ESMTP id k4O8hq30024339
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 10:43:52 +0200
Received: from [131.173.12.120] (cip40.informatik.Uni-Osnabrueck.DE [131.173.12.120])
	by sanode11.rz.uni-osnabrueck.de (8.13.0/8.13.0) with ESMTP id k4O8hpFN015821
	for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 10:43:52 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE-Kernelliste <linux-ide@vger.kernel.org>

I'm using a Promise SATAII150TX4 controller + Maxtor 6L200M0 disk and 
sometimes I get errors like this:
  May 11 17:19:42 ansgar kernel: ata4: status=0x50 { DriveReady 
SeekComplete }
  May 11 17:19:42 ansgar kernel: sda: Current: sense key=0x0
  May 11 17:19:42 ansgar kernel:     ASC=0x0 ASCQ=0x0
  May 11 17:19:42 ansgar kernel: Info fld=0x48858a
  (many of this with different fld value)
in my kernel logs. this errors happen under heavy load when the drive 
has to read/write on many different places on the disk like big copy and 
locate-database-update at the same time. There are no other problems or 
data corruption, but it's confusing, when checking the logs. Perhaps 
there is someone on the list who can explain this error to me and what I 
can do.
BTW a checklog of smartctl -d ata -a /dev/sda (latest CVS version)
smartctl version 5.34 [i686-suse-linux] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Maxtor DiamondMax 10 family
Device Model:     Maxtor 6L200M0
Serial Number:    L40A4PDH
Firmware Version: BANC1E00
User Capacity:    203.928.109.056 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Mon May 15 19:29:55 2006 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

Warning! SMART Attribute Thresholds Structure error: invalid SMART checksum.
=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80)    Offline data collection activity
                    was never started.
                    Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)    The previous self-test 
routine completed
                    without error or no self-test has ever
                    been run.
Total time to complete Offline
data collection:          (1562) seconds.
Offline data collection
capabilities:              (0x5b) SMART execute Offline immediate.
                    Auto Offline data collection on/off support.
                    Suspend Offline collection upon new
                    command.
                    Offline surface scan supported.
                    Self-test supported.
                    No Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    General Purpose Logging supported.
Short self-test routine
recommended polling time:      (   2) minutes.
Extended self-test routine
recommended polling time:      (  81) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   205   204   063    Pre-fail  
Always       -       14329
  4 Start_Stop_Count        0x0032   253   253   000    Old_age   
Always       -       572
  5 Reallocated_Sector_Ct   0x0033   253   253   063    Pre-fail  
Always       -       0
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  
Offline      -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   
Always       -       0
  8 Seek_Time_Performance   0x0027   249   240   187    Pre-fail  
Always       -       39136
  9 Power_On_Minutes        0x0032   248   248   000    Old_age   
Always       -       802h+10m
 10 Spin_Retry_Count        0x002b   253   252   157    Pre-fail  
Always       -       0
 11 Calibration_Retry_Count 0x002b   253   252   223    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   252   252   000    Old_age   
Always       -       640
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   
Always       -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   
Always       -       0
194 Temperature_Celsius     0x0032   032   253   000    Old_age   
Always       -       32
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   
Always       -       12946
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   
Offline      -       0
197 Current_Pending_Sector  0x0008   253   253   000    Old_age   
Offline      -       0
198 Offline_Uncorrectable   0x0008   253   253   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   
Offline      -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   
Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   
Always       -       0
202 TA_Increase_Count       0x000a   253   252   000    Old_age   
Always       -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  
Always       -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   
Always       -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   
Always       -       0
207 Spin_High_Current       0x002a   253   252   000    Old_age   
Always       -       0
208 Spin_Buzz               0x002a   253   252   000    Old_age   
Always       -       0
209 Offline_Seek_Performnce 0x0024   239   239   000    Old_age   
Offline      -       179
210 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0
211 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0
212 Unknown_Attribute       0x0032   253   252   000    Old_age   
Always       -       0

Warning! SMART ATA Error Log Structure error: invalid SMART checksum.
SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      
1163         -
# 2  Short offline       Completed without error       00%      
1163         -
# 3  Offline             Aborted by host               70%         
0         -

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

A. Knappheide

