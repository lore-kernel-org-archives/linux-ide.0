From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: device error via SDB FIS
Date: Sat, 30 Jun 2007 23:12:19 +0200
Message-ID: <4686C733.1080102@dschroeder.info>
References: <46868E82.8010906@dschroeder.info> <Pine.LNX.4.64.0706301311150.2608@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62711 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbXF3VMg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 17:12:36 -0400
In-Reply-To: <Pine.LNX.4.64.0706301311150.2608@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-ide@vger.kernel.org

Justin Piszcz wrote:
> Run smart tests yet?
> 
> 1. smartctl -d ata -t short /dev/sda
> 2. smartctl -d ata -a /dev/sda (after  few min)
> 
> also replace short with long
> 
> and then paste the output:
> 
> smartctl -d ata -a /dev/sda
> 

<smartctl>
smartctl -a -d ata /dev/sdc

smartctl version 5.37 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG HD501LJ
Serial Number:    S0MUJ1GP506675
Firmware Version: CR100-10
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  Not recognized. Minor revision code: 0x52
Local Time is:    Sat Jun 30 23:11:34 2007 CEST

==> WARNING: May need -F samsung or -F samsung2 enabled; see manual for 
details.

SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                         was never started.
                                         Auto Offline Data Collection: 
Disabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                 (8633) seconds.
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
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 147) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE 
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail 
Always       -       1
   3 Spin_Up_Time            0x0007   100   100   015    Pre-fail 
Always       -       7808
   4 Start_Stop_Count        0x0032   100   100   000    Old_age 
Always       -       9
   5 Reallocated_Sector_Ct   0x0033   253   253   010    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000f   253   253   051    Pre-fail 
Always       -       0
   8 Seek_Time_Performance   0x0025   253   253   015    Pre-fail 
Offline      -       0
   9 Power_On_Hours          0x0032   253   253   000    Old_age 
Always       -       8
  10 Spin_Retry_Count        0x0033   253   253   051    Pre-fail 
Always       -       0
  11 Calibration_Retry_Count 0x0012   253   253   000    Old_age 
Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age 
Always       -       6
187 Unknown_Attribute       0x0032   253   253   000    Old_age   Always 
       -       0
188 Unknown_Attribute       0x0032   253   253   000    Old_age   Always 
       -       0
190 Temperature_Celsius     0x0022   060   055   000    Old_age   Always 
       -       40
194 Temperature_Celsius     0x0022   118   103   000    Old_age   Always 
       -       40
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always 
       -       615567200
196 Reallocated_Event_Count 0x0032   253   253   000    Old_age   Always 
       -       0
197 Current_Pending_Sector  0x0012   253   253   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0030   253   253   000    Old_age 
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always 
       -       0
200 Multi_Zone_Error_Rate   0x000a   253   100   000    Old_age   Always 
       -       0
201 Soft_Read_Error_Rate    0x000a   100   100   000    Old_age   Always 
       -       0
202 TA_Increase_Count       0x0032   253   253   000    Old_age   Always 
       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%         6 
      -
# 2  Short offline       Completed without error       00%         4 
      -

SMART Selective Self-Test Log Data Structure Revision Number (0) should be 1
SMART Selective self-test log data structure revision number 0
Warning: ATA Specification requires selective self-test log data 
structure revision number = 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
</smartctl>
