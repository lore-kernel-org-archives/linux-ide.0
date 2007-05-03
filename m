From: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Thu, 03 May 2007 13:04:59 +0200
Message-ID: <4639C1DB.3030501@jogback.se>
References: <463828F6.7020209@jogback.se> <46388862.1020709@gmail.com> <4638928E.60700@jogback.se> <4639A6A3.20001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.jogback.se ([192.165.82.16]:37399 "EHLO jogback.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161843AbXECLEj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 May 2007 07:04:39 -0400
In-Reply-To: <4639A6A3.20001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Lars Michael Jogb=E4ck wrote:
>  =20
>>> I think the disk attached to port 0 might be bad.  Please report th=
e
>>> result of 'smartctl -d ata -a /dev/sdX' where sdX is the device att=
ached
>>> to the failing port.
>>>
>>>  =20
>>>      =20
>> SMART Error Log Version: 1
>> No Errors Logged
>>    =20
>
> I was hoping to see some error logs but no.  Hardware_ECC_Recovered
> count seems high (385707184) but I dunno whether the value is normal =
or
> not.  Different manufacturers use different norms in counting them.  =
If
> you have other disks of the same model, you can compare the values an=
d
> see whether if it's unusually high.
>  =20
I think that is normal for that kind of disk. This is another disk but=20
the same model (this one is attached to a 3ware 9500-controller)
and it shows the same.

smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Al=
len
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     SAMSUNG HD501LJ
Serial Number:    S0VVJ1NP300014
=46irmware Version: CR100-10
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  Not recognized. Minor revision code: 0x52
Local Time is:    Thu May  3 12:36:32 2007 CEST

=3D=3D> WARNING: May need -F samsung or -F samsung2 enabled; see manual=
 for=20
details.

SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activit=
y
                                        was never started.
                                        Auto Offline Data Collection:=20
Disabled.
Self-test execution status:      (   0) The previous self-test routine=20
completed
                                        without error or no self-test=20
has ever
                                        been run.
Total time to complete Offline
data collection:                 (8852) seconds.
Offline data collection
capabilities:                    (0x5b) SMART execute Offline immediate=
=2E
                                        Auto Offline data collection=20
on/off support.
                                        Suspend Offline collection upon=
 new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        No Conveyance Self-test support=
ed.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before enterin=
g
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging support=
ed.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 151) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     =20
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail =20
Always       -       3
  3 Spin_Up_Time            0x0007   100   100   015    Pre-fail =20
Always       -       7104
  4 Start_Stop_Count        0x0032   100   100   000    Old_age  =20
Always       -       7
  5 Reallocated_Sector_Ct   0x0033   253   253   010    Pre-fail =20
Always       -       0
  7 Seek_Error_Rate         0x000f   253   253   051    Pre-fail =20
Always       -       0
  8 Seek_Time_Performance   0x0025   253   253   015    Pre-fail =20
Offline      -       0
  9 Power_On_Hours          0x0032   253   253   000    Old_age  =20
Always       -       97
 10 Spin_Retry_Count        0x0033   253   253   051    Pre-fail =20
Always       -       0
 11 Calibration_Retry_Count 0x0012   253   253   000    Old_age  =20
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age  =20
Always       -       7
187 Unknown_Attribute       0x0032   253   253   000    Old_age  =20
Always       -       0
188 Unknown_Attribute       0x0032   253   253   000    Old_age  =20
Always       -       0
190 Unknown_Attribute       0x0022   068   067   000    Old_age  =20
Always       -       32
194 Temperature_Celsius     0x0022   142   139   000    Old_age  =20
Always       -       32
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age  =20
Always       -       455228167
196 Reallocated_Event_Count 0x0032   253   253   000    Old_age  =20
Always       -       0
197 Current_Pending_Sector  0x0012   253   253   000    Old_age  =20
Always       -       0
198 Offline_Uncorrectable   0x0030   253   253   000    Old_age  =20
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age  =20
Always       -       0
200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age  =20
Always       -       0
201 Soft_Read_Error_Rate    0x000a   100   100   000    Old_age  =20
Always       -       0
202 TA_Increase_Count       0x0032   253   253   000    Old_age  =20
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining =20
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%       =20
97         -

SMART Selective Self-Test Log Data Structure Revision Number (0) should=
 be 1
SMART Selective self-test log data structure revision number 0
Warning: ATA Specification requires selective self-test log data=20
structure revision number =3D 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute de=
lay.

Also, something else happened with error after a while.

=46irst it changed to show this instead:
May  1 23:52:25 cleopatra kernel: ata5.00: limiting SATA link speed to=20
1.5 Gbps
May  1 23:52:25 cleopatra kernel: ata5.00: exception Emask 0x0 SAct 0x0=
=20
SErr 0x0 action 0x6 frozen
May  1 23:52:25 cleopatra kernel: ata5.00: tag 2 cmd 0xea Emask 0x4 sta=
t=20
0x40 err 0x0 (timeout)
May  1 23:52:25 cleopatra kernel: ata5.15: hard resetting port
May  1 23:52:27 cleopatra kernel: ata5.15: SATA link up 3.0 Gbps=20
(SStatus 123 SControl 300)
May  1 23:52:27 cleopatra kernel: ata5.00: hard resetting port
May  1 23:52:28 cleopatra kernel: ata5.00: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 310)
May  1 23:52:28 cleopatra kernel: ata5.01: hard resetting port
May  1 23:52:28 cleopatra kernel: ata5.01: SATA link up 3.0 Gbps=20
(SStatus 123 SControl 300)
May  1 23:52:29 cleopatra kernel: ata5.02: hard resetting port
May  1 23:52:29 cleopatra kernel: ata5.02: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:52:29 cleopatra kernel: ata5.03: hard resetting port
May  1 23:52:30 cleopatra kernel: ata5.03: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:52:30 cleopatra kernel: ata5.04: hard resetting port
May  1 23:52:30 cleopatra kernel: ata5.04: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:52:30 cleopatra kernel: ata5.00: configured for UDMA/100
May  1 23:52:30 cleopatra kernel: ata5.01: configured for UDMA/100
May  1 23:52:30 cleopatra kernel: ata5.02: configured for UDMA/100
May  1 23:52:30 cleopatra kernel: ata5.03: configured for UDMA/100
May  1 23:52:30 cleopatra kernel: ata5.04: configured for UDMA/100
May  1 23:52:30 cleopatra kernel: ata5: EH complete

and later it showed this:
May  1 23:53:36 cleopatra kernel: ata5.00: limiting speed to UDMA/66
May  1 23:53:36 cleopatra kernel: ata5.00: exception Emask 0x0 SAct 0x0=
=20
SErr 0x0 action 0x2 frozen
May  1 23:53:36 cleopatra kernel: ata5.00: tag 0 cmd 0xea Emask 0x4 sta=
t=20
0x40 err 0x0 (timeout)
May  1 23:53:36 cleopatra kernel: ata5.15: hard resetting port
May  1 23:53:38 cleopatra kernel: ata5.15: SATA link up 3.0 Gbps=20
(SStatus 123 SControl 300)
May  1 23:53:38 cleopatra kernel: ata5.00: hard resetting port
May  1 23:53:39 cleopatra kernel: ata5.00: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 310)
May  1 23:53:39 cleopatra kernel: ata5.01: hard resetting port
May  1 23:53:40 cleopatra kernel: ata5.01: SATA link up 3.0 Gbps=20
(SStatus 123 SControl 300)
May  1 23:53:40 cleopatra kernel: ata5.02: hard resetting port
May  1 23:53:40 cleopatra kernel: ata5.02: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:53:40 cleopatra kernel: ata5.03: hard resetting port
May  1 23:53:41 cleopatra kernel: ata5.03: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:53:41 cleopatra kernel: ata5.04: hard resetting port
May  1 23:53:41 cleopatra kernel: ata5.04: SATA link up 1.5 Gbps=20
(SStatus 113 SControl 300)
May  1 23:53:41 cleopatra kernel: ata5.00: configured for UDMA/66
May  1 23:53:41 cleopatra kernel: ata5.01: configured for UDMA/100
May  1 23:53:41 cleopatra kernel: ata5.02: configured for UDMA/100
May  1 23:53:41 cleopatra kernel: ata5.03: configured for UDMA/100
May  1 23:53:41 cleopatra kernel: ata5.04: configured for UDMA/100
May  1 23:53:41 cleopatra kernel: ata5: EH complete

and then it continues with approx 1/hour of the above. So it seems=20
something is strange in the interface between the drive and the=20
computer. I can swap the drive (it's in an raid5-array) to another driv=
e=20
of the same model if helps in any way; but I suspect that it will show=20
the same result.

Regards,
/LM

