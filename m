From: Marc Bejarano <beej@alum.mit.edu>
Subject: Re: errors on shutdown with PMP
Date: Tue, 31 Jul 2007 12:23:24 -0400
Message-ID: <200707311623.l6VGNR5t017783@outgoing-alum.mit.edu>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu>
 <46AAF12F.9020301@gmail.com>
 <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu>
 <46AEBB71.9040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ALUM-2.MIT.EDU ([18.7.21.145]:42920 "EHLO alum-2.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762077AbXGaQXi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 12:23:38 -0400
In-Reply-To: <46AEBB71.9040003@gmail.com>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu>
 <46AAF12F.9020301@gmail.com>
 <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu>
 <46AEBB71.9040003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

At 00:32 7/31/2007, Tejun Heo wrote:
 >Marc Bejarano wrote:
 >> At 03:33 7/28/2007, Tejun Heo wrote:
 >>>Please post the result of 'smartctl -a /dev/sdX' where sdX is the device
 >>>which went offline.
 >>
 >> i suppose i should have seen that coming.  here you go:
 >> ===
 >> [root@dell ~]# /usr/local/sbin/smartctl -a /dev/sdc
 >> smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6
 >> Bruce Allen
 >> Home page is http://smartmontools.sourceforge.net/
 >>
 >> === START OF INFORMATION SECTION ===
 >> Model Family:     Seagate Barracuda 7200.10 family
 >> Device Model:     ST3750640AS
 >[--snip--]
 >> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
 >> UPDATED  WHEN_FAILED RAW_VALUE
 >>   1 Raw_Read_Error_Rate     0x000f   090   079   006    Pre-fail  Always
 >>      -       66902364
 >>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always
 >>      -       31
 >>   7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always
 >>      -       146651228
 >> 195 Hardware_ECC_Recovered  0x001a   056   049   000    Old_age   Always
 >>      -       102514302
 >> 198 Offline_Uncorrectable   0x0010   099   099   000    Old_age
 >> Offline      -       40
 >
 >Counters don't look too friendly.  Do you happen to have another drive
 >of the same model?

about 100 or so of them ;)

 >If so, can you post smartctl -a of the drive?

here are the other two drives in the unhappy lv:
===

[root@dell ~]# smartctl -a /dev/sdg
smartctl version 5.33 [x86_64-redhat-linux-gnu] Copyright (C) 2002-4 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: ATA      ST3750640AS      Version: 3.AA
Serial number:             5QD05VBA
Device type: disk
Local Time is: Tue Jul 31 12:14:00 2007 EDT
Device does not support SMART
Request Sense failed, [Input/output error]

Error Counter logging not supported

Error Events logging not supported

[GLTSD (Global Logging Target Save Disable) set. Enable Save with '-S on']
Device does not support Self Test logging
[root@dell ~]# /usr/local/sbin/smartctl -a /dev/sdg
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.10 family
Device Model:     ST3750640AS
Serial Number:    5QD05VBA
Firmware Version: 3.AAE
User Capacity:    750,156,374,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Jul 31 12:14:11 2007 EDT
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
recommended polling time:        ( 202) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   091   082   006    Pre-fail  Always 
      -       226717799
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       13
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       15
   7 
Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always 
      -       147856928
   9 
Power_On_Hours          0x0032   098   098   000    Old_age   Always 
      -       2193
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       25
187 
Unknown_Attribute       0x0032   001   001   000    Old_age   Always 
      -       1357
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   062   057   045    Old_age   Always 
      -       281471338545190
194 
Temperature_Celsius     0x0022   038   043   000    Old_age   Always 
      -       38 (Lifetime Min/Max 0/32)
195 
Hardware_ECC_Recovered  0x001a   060   056   000    Old_age   Always 
      -       115252923
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

[root@dell ~]# /usr/local/sbin/smartctl -a /dev/sdl
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.10 family
Device Model:     ST3750640AS
Serial Number:    5QD068ZV
Firmware Version: 3.AAE
User Capacity:    750,156,374,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Jul 31 12:14:17 2007 EDT
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
recommended polling time:        ( 202) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH 
TYPE      UPDATED  WHEN_FAILED RAW_VALUE
   1 
Raw_Read_Error_Rate     0x000f   085   081   006    Pre-fail  Always 
      -       193039852
   3 
Spin_Up_Time            0x0003   093   093   000    Pre-fail  Always 
      -       0
   4 
Start_Stop_Count        0x0032   100   100   020    Old_age   Always 
      -       13
   5 
Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always 
      -       0
   7 
Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always 
      -       148382871
   9 
Power_On_Hours          0x0032   098   098   000    Old_age   Always 
      -       2191
  10 
Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always 
      -       0
  12 
Power_Cycle_Count       0x0032   100   100   020    Old_age   Always 
      -       25
187 
Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
      -       0
189 
Unknown_Attribute       0x003a   100   100   000    Old_age   Always 
      -       0
190 
Temperature_Celsius     0x0022   062   057   045    Old_age   Always 
      -       656736294
194 
Temperature_Celsius     0x0022   038   043   000    Old_age   Always 
      -       38 (Lifetime Min/Max 0/31)
195 
Hardware_ECC_Recovered  0x001a   057   053   000    Old_age   Always 
      -       108137359
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
===

i'll swap out the suspect drive and see how things go without 
it.  assuming things are better, would you like this failing drive 
for your testing?

thanks!
marc

