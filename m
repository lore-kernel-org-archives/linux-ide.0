From: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Wed, 02 May 2007 15:30:54 +0200
Message-ID: <4638928E.60700@jogback.se>
References: <463828F6.7020209@jogback.se> <46388862.1020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.jogback.se ([192.165.82.16]:60462 "EHLO jogback.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2993127AbXEBNa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 May 2007 09:30:59 -0400
In-Reply-To: <46388862.1020709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Lars Michael Jogb=E4ck wrote:
>  =20
>> I have a system with a Sil3124 controller and two Sil3726 port multi=
pliers.
>> I'm running 2.6.18.1 with the patches from
>> http://home-tj.org/wiki/index.php/Libata-tj-stable
>> since I was not able to get the port multipler to work at all with
>> 2.6.21 (perhaps the support for PMP is not fully integrated there).
>>
>> One of my Sil3726 is freezing my system approx one time per hour whe=
n
>> the disks are under load.
>>
>> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata5.00: tag 0 cmd 0xea Emask 0x4 stat 0x40 err 0x0 (timeout)
>>    =20
>
> Hmmm... that's FLUSH_CACHE timing out.
>  =20
Is there a way that I can generate a FLUSH_CACHE event manually somehow=
?
>  =20
>> I suspect that the root-cause of the problem could be drive-related.=
 All
>> the disks on the other Sil3726 are WD4000KD's and the
>> disks attached to this one is 3xWD4000KD and 1xWD4000KS and 1xSamsun=
g
>> HD501LJ. Is there a way of test this?
>>    =20
>
> I think the disk attached to port 0 might be bad.  Please report the
> result of 'smartctl -d ata -a /dev/sdX' where sdX is the device attac=
hed
> to the failing port.
>
>  =20
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Al=
len
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     SAMSUNG HD501LJ
Serial Number:    S0VVJ1NP300009
=46irmware Version: CR100-10
User Capacity:    500,107,862,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  Not recognized. Minor revision code: 0x52
Local Time is:    Wed May  2 15:26:35 2007 CEST

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
data collection:                 (8887) seconds.
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
recommended polling time:        ( 152) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     =20
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail =20
Always       -       2
  3 Spin_Up_Time            0x0007   100   100   015    Pre-fail =20
Always       -       7232
  4 Start_Stop_Count        0x0032   100   100   000    Old_age  =20
Always       -       3
  5 Reallocated_Sector_Ct   0x0033   253   253   010    Pre-fail =20
Always       -       0
  7 Seek_Error_Rate         0x000f   253   253   051    Pre-fail =20
Always       -       0
  8 Seek_Time_Performance   0x0025   253   253   015    Pre-fail =20
Offline      -       0
  9 Power_On_Hours          0x0032   253   253   000    Old_age  =20
Always       -       49
 10 Spin_Retry_Count        0x0033   253   253   051    Pre-fail =20
Always       -       0
 11 Calibration_Retry_Count 0x0012   253   253   000    Old_age  =20
Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age  =20
Always       -       3
187 Unknown_Attribute       0x0032   253   253   000    Old_age  =20
Always       -       0
188 Unknown_Attribute       0x0032   253   253   000    Old_age  =20
Always       -       0
190 Unknown_Attribute       0x0022   070   069   000    Old_age  =20
Always       -       30
194 Temperature_Celsius     0x0022   148   145   000    Old_age  =20
Always       -       30
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age  =20
Always       -       385707184
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
202 TA_Increase_Count       0x0032   100   100   000    Old_age  =20
Always       -       21

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining =20
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%       =20
49         -

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


>> Is there an updated patch-set for port multipliers in a later kernel
>> than 2.6.18.1?
>>    =20
>
> Sorry but not yet.
>
>  =20
Regards,
/LM


