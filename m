From: "Rodrigo Severo" <rodrigo@fabricadeideias.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA hd
Date: Tue, 17 Apr 2007 14:30:08 -0300
Message-ID: <a7108f870704171030i6076a147lc4580ee720ba3e82@mail.gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>
	 <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>
	 <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com>
	 <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>
	 <4624FD7F.4070200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.230]:7392 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161162AbXDQRaK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 13:30:10 -0400
Received: by qb-out-0506.google.com with SMTP id q10so3110056qbq
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 10:30:09 -0700 (PDT)
In-Reply-To: <4624FD7F.4070200@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 4/17/07, Tejun Heo <htejun@gmail.com> wrote:
> Certainly not.  Can you post the result of 'smartctl -d ata -a /dev/sdX'?

Here is smartctl -d ata -a /dev/sda for the same HD that presented the
previous log messages:
-----------------------------------------------------------------------------------------------------
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG HD400LJ
Serial Number:    S0H2J1UL602108
Firmware Version: ZZ100-14
User Capacity:    400,088,457,216 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 4a
Local Time is:    Tue Apr 17 14:20:20 2007 BRT

==> WARNING: May need -F samsung or -F samsung2 enabled; see manual for details.

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
data collection: 		 (7576) seconds.
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
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 129) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail
Always       -       0
  3 Spin_Up_Time            0x0007   100   100   015    Pre-fail
Always       -       7936
  4 Start_Stop_Count        0x0032   100   100   000    Old_age
Always       -       8
  5 Reallocated_Sector_Ct   0x0033   253   253   010    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x000f   253   253   051    Pre-fail
Always       -       0
  8 Seek_Time_Performance   0x0025   253   253   015    Pre-fail
Offline      -       0
  9 Power_On_Hours          0x0032   253   253   000    Old_age
Always       -       16
 10 Spin_Retry_Count        0x0033   253   253   051    Pre-fail
Always       -       0
 11 Calibration_Retry_Count 0x0012   253   253   000    Old_age
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age
Always       -       8
190 Unknown_Attribute       0x0022   061   060   000    Old_age
Always       -       39
194 Temperature_Celsius     0x0022   121   118   000    Old_age
Always       -       39
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age
Always       -       507637
196 Reallocated_Event_Count 0x0032   253   253   000    Old_age
Always       -       0
197 Current_Pending_Sector  0x0012   253   253   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0030   253   253   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
Always       -       0
200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age
Always       -       0
201 Soft_Read_Error_Rate    0x000a   253   253   000    Old_age
Always       -       0
202 TA_Increase_Count       0x0032   253   253   000    Old_age
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


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
-----------------------------------------------------------------------------------------------------

I bought a new SATA board this morning. lspci -v:
-----------------------------------------------------------------------------------------------------
01:07.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at c000 [size=16]
        I/O ports at c400 [size=16]
        I/O ports at c800 [size=16]
        I/O ports at cc00 [size=16]
        I/O ports at d000 [size=32]
        I/O ports at d400 [size=256]
        [virtual] Expansion ROM at 30040000 [disabled] [size=64K]
        Capabilities: [e0] Power Management version 2
-----------------------------------------------------------------------------------------------------

This is the SATA board running now. Everything else is exactly the
same. I got no syslog messages after rsyncing 255GB.

I believe the smartctl output is still valid despite having other SATA board.

Please let me know if there is anything else I can do to help debug this issue.

I can put the ULi M5281/M5283 back for tests.


Thanks for your attention,

Rodrigo Severo
