From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 15:24:41 -0500
Message-ID: <20090211152441.6b792f48@dhcp-100-2-144.bos.redhat.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
	<49922A2D.508@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47068 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061AbZBKU1R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 15:27:17 -0500
In-Reply-To: <49922A2D.508@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wed, 11 Feb 2009 10:30:21 +0900
Tejun Heo <tj@kernel.org> wrote:

> 
> ext3 doesn't use barrier by default.  Timing out on FLUSH_CACHE is a
> pretty good sign that something is wrong with the disk.  Can you
> please post the output of "smartctl -a /dev/sda"?
> 

smartctl version 5.38 [x86_64-redhat-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG HD160JJ/P
Serial Number:    S0DFJ1NLA12279
Firmware Version: ZM100-34
User Capacity:    160,000,000,000 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 4a
Local Time is:    Wed Feb 11 20:24:01 2009 EST
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
data collection: 		 (3699) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  61) minutes.
SCT capabilities: 	       (0x003f)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail  Always       -       9
  3 Spin_Up_Time            0x0007   100   100   025    Pre-fail  Always       -       5248
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       72
  5 Reallocated_Sector_Ct   0x0033   253   253   010    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000e   253   253   000    Old_age   Always       -       0
  8 Seek_Time_Performance   0x0024   253   253   000    Old_age   Offline      -       0
  9 Power_On_Half_Minutes   0x0032   100   100   000    Old_age   Always       -       109h+27m
 10 Spin_Retry_Count        0x0032   253   253   000    Old_age   Always       -       0
 11 Calibration_Retry_Count 0x0012   253   253   000    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       62
190 Airflow_Temperature_Cel 0x0022   118   100   000    Old_age   Always       -       40
194 Temperature_Celsius     0x0022   118   100   000    Old_age   Always       -       40
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always       -       18436133
196 Reallocated_Event_Count 0x0032   253   253   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   253   253   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   253   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age   Always       -       0
201 Soft_Read_Error_Rate    0x000a   100   100   000    Old_age   Always       -       0
202 TA_Increase_Count       0x0032   253   253   000    Old_age   Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     12919         -
# 2  Short offline       Completed without error       00%      5645         -
# 3  Extended offline    Completed without error       00%         1         -
# 4  Extended offline    Completed without error       00%         1         -
# 5  Short offline       Completed without error       00%         0         -

SMART Selective Self-Test Log Data Structure Revision Number (0) should be 1
SMART Selective self-test log data structure revision number 0
Warning: ATA Specification requires selective self-test log data structure revision number = 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
