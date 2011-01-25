From: BU66ER BAD6ER <debu66er@gmail.com>
Subject: Re: Seagate hard disk firmware issue
Date: Tue, 25 Jan 2011 07:06:29 +0100
Message-ID: <AANLkTino+1xuzpYjJt0HCNFMP95bNOwWDVO5daehK0ny@mail.gmail.com>
References: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com>
	<4D3E25AF.1080102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37896 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1AYGGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 01:06:30 -0500
Received: by yxt3 with SMTP id 3so1575841yxt.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 22:06:29 -0800 (PST)
In-Reply-To: <4D3E25AF.1080102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear both,

Thanks for the input! I will return this hard disk as soon as possible.

Here below is the latest output.

Best regards!

# smartctl -a /dev/sdb
smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local build)
Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.=
net

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Seagate Barracuda LP
Device Model:     ST32000542AS
Serial Number:    5XW20H7P
=46irmware Version: CC34
User Capacity:    2,000,398,934,016 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 4
Local Time is:    Tue Jan 25 06:57:27 2011 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activit=
y
                                        was never started.
                                        Auto Offline Data Collection: D=
isabled.
Self-test execution status:      (   0) The previous self-test routine =
completed
                                        without error or no self-test h=
as ever
                                        been run.
Total time to complete Offline
data collection:                 ( 633) seconds.
Offline data collection
capabilities:                    (0x73) SMART execute Offline immediate=
=2E
                                        Auto Offline data collection
on/off support.
                                        Suspend Offline collection upon=
 new
                                        command.
                                        No Offline surface scan support=
ed.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before enterin=
g
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging support=
ed.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        ( 255) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x103f) SCT Status supported.
                                        SCT Error Recovery Control supp=
orted.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   096   085   006    Pre-fail
Always       -       166323635
  3 Spin_Up_Time            0x0003   100   100   000    Pre-fail
Always       -       0
  4 Start_Stop_Count        0x0032   099   099   020    Old_age
Always       -       1164
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail
Always       -       499927
  9 Power_On_Hours          0x0032   100   100   000    Old_age
Always       -       334
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail
Always       -       0
 12 Power_Cycle_Count       0x0032   099   099   020    Old_age
Always       -       1190
183 Runtime_Bad_Block       0x0032   100   100   000    Old_age
Always       -       0
184 End-to-End_Error        0x0032   100   100   099    Old_age
Always       -       0
187 Reported_Uncorrect      0x0032   001   001   000    Old_age
Always       -       495
188 Command_Timeout         0x0032   100   099   000    Old_age
Always       -       4295032833
189 High_Fly_Writes         0x003a   100   100   000    Old_age
Always       -       0
190 Airflow_Temperature_Cel 0x0022   081   063   045    Old_age
Always       -       19 (Lifetime Min/Max 19/19)
194 Temperature_Celsius     0x0022   019   040   000    Old_age
Always       -       19 (0 16 0 0)
195 Hardware_ECC_Recovered  0x001a   048   033   000    Old_age
Always       -       166323635
197 Current_Pending_Sector  0x0012   100   099   000    Old_age
Always       -       24
198 Offline_Uncorrectable   0x0010   100   099   000    Old_age
Offline      -       24
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age
Always       -       0
240 Head_Flying_Hours       0x0000   100   253   000    Old_age
Offline      -       65979287602589
241 Total_LBAs_Written      0x0000   100   253   000    Old_age
Offline      -       1931349171
242 Total_LBAs_Read         0x0000   100   253   000    Old_age
Offline      -       2326768434

SMART Error Log Version: 1
ATA Error Count: 573 (device log contains only the most recent five err=
ors)
        CR =3D Command Register [HEX]
        FR =3D Features Register [HEX]
        SC =3D Sector Count Register [HEX]
        SN =3D Sector Number Register [HEX]
        CL =3D Cylinder Low Register [HEX]
        CH =3D Cylinder High Register [HEX]
        DH =3D Device/Head Register [HEX]
        DC =3D Device Command Register [HEX]
        ER =3D Error register [HEX]
        ST =3D Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.

Error 573 occurred at disk power-on lifetime: 317 hours (13 days + 5 ho=
urs)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 83 74 1b 07  Error: UNC at LBA =3D 0x071b7483 =3D 119239811

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 7f 74 1b e7 00      13:20:31.001  READ DMA
  27 00 00 00 00 00 e0 00      13:20:31.000  READ NATIVE MAX ADDRESS EX=
T
  ec 00 00 00 00 00 a0 00      13:20:30.992  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      13:20:30.986  SET FEATURES [Set transfer=
 mode]
  27 00 00 00 00 00 e0 00      13:20:30.964  READ NATIVE MAX ADDRESS EX=
T

Error 572 occurred at disk power-on lifetime: 317 hours (13 days + 5 ho=
urs)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 83 74 1b 07  Error: UNC at LBA =3D 0x071b7483 =3D 119239811

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 7f 74 1b e7 00      13:20:27.236  READ DMA
  27 00 00 00 00 00 e0 00      13:20:27.235  READ NATIVE MAX ADDRESS EX=
T
  ec 00 00 00 00 00 a0 00      13:20:27.227  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      13:20:27.223  SET FEATURES [Set transfer=
 mode]
  27 00 00 00 00 00 e0 00      13:20:27.199  READ NATIVE MAX ADDRESS EX=
T

Error 571 occurred at disk power-on lifetime: 317 hours (13 days + 5 ho=
urs)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 83 74 1b 07  Error: UNC at LBA =3D 0x071b7483 =3D 119239811

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 7f 74 1b e7 00      13:20:23.451  READ DMA
  27 00 00 00 00 00 e0 00      13:20:23.451  READ NATIVE MAX ADDRESS EX=
T
  ec 00 00 00 00 00 a0 00      13:20:23.442  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      13:20:23.438  SET FEATURES [Set transfer=
 mode]
  27 00 00 00 00 00 e0 00      13:20:23.407  READ NATIVE MAX ADDRESS EX=
T

Error 570 occurred at disk power-on lifetime: 317 hours (13 days + 5 ho=
urs)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 83 74 1b 07  Error: UNC at LBA =3D 0x071b7483 =3D 119239811

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 7f 74 1b e7 00      13:20:19.659  READ DMA
  27 00 00 00 00 00 e0 00      13:20:19.658  READ NATIVE MAX ADDRESS EX=
T
  ec 00 00 00 00 00 a0 00      13:20:19.650  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      13:20:19.619  SET FEATURES [Set transfer=
 mode]
  27 00 00 00 00 00 e0 00      13:20:19.534  READ NATIVE MAX ADDRESS EX=
T

Error 569 occurred at disk power-on lifetime: 317 hours (13 days + 5 ho=
urs)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 83 74 1b 07  Error: UNC at LBA =3D 0x071b7483 =3D 119239811

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 08 7f 74 1b e7 00      13:20:15.894  READ DMA
  27 00 00 00 00 00 e0 00      13:20:15.893  READ NATIVE MAX ADDRESS EX=
T
  ec 00 00 00 00 00 a0 00      13:20:15.885  IDENTIFY DEVICE
  ef 03 46 00 00 00 a0 00      13:20:15.880  SET FEATURES [Set transfer=
 mode]
  27 00 00 00 00 00 e0 00      13:20:15.857  READ NATIVE MAX ADDRESS EX=
T

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
If Selective self-test is pending on power-up, resume after 0 minute de=
lay.

On Tue, Jan 25, 2011 at 2:21 AM, Robert Hancock <hancockrwd@gmail.com> =
wrote:
> On 01/23/2011 05:05 AM, BU66ER BAD6ER wrote:
>>
>> Hi,
>>
>> Four weeks ago I bought a new 2TB Seagate Barracuda internal SATA
>> drive. That drive has two 667GB ext4 partions (667GB unused) and it =
is
>> used for storage. My main system (Debian Sid 64-bit and KDE) resides
>> on a 40GB SSD, also using ext4.
>>
>> Two weeks ago I noticed a severe performance drop, where any file
>> manager couldn't view directories on the 2TB disk without a one or t=
wo
>> minute penalty. After that I have had three hard freezes of that dis=
k
>> and the entire system. Before the freeze there is very much hd
>> activity and finally I need to turn the power off. I have now also
>> made a backup of /dev/sdb1 should it be fatally serious.
>>
>> I was recommended by someone at the #debian irc to make changes to t=
he
>> spindown_time but that only helped for a few days. Yesterday, the 3r=
d
>> freeze came and the system wouldn't even recognize the disk after
>> reboot; just 'clicking' waiting for a response. I showed the kern.lo=
g
>> to someone at the same channel who concluded that this should be a
>> firmware issue.
>>
>> Here is the latest kern.log which may identify the issue: I hope it
>> contains the relevant details. But first the output of smartctl -a
>> /dev/sdb.
>>
>> I have now set the hdparm spindown_time to 0, disabling disk sleep
>> which seems to have been the culprit as judged on messages in the
>> Dolphin file manager etc.
>>
>> Thanks for any help!
>>
>>
>>> # smartctl -a /dev/sdb
>>> smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local bu=
ild)
>>> Copyright (C) 2002-10 by Bruce Allen,
>>> http://smartmontools.sourceforge.net
>>>
>>> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
>>> Model Family: =A0 =A0 Seagate Barracuda LP
>>> Device Model: =A0 =A0 ST32000542AS
>>> Serial Number: =A0 =A05XW20H7P
>>> Firmware Version: CC34
>>> User Capacity: =A0 =A02,000,398,934,016 bytes
>>> Device is: =A0 =A0 =A0 =A0In smartctl database [for details use: -P=
 show]
>>> ATA Version is: =A0 8
>>> ATA Standard is: =A0ATA-8-ACS revision 4
>>> Local Time is: =A0 =A0Sun Jan 23 11:50:56 2011 CET
>>> SMART support is: Available - device has SMART capability.
>>> SMART support is: Enabled
>>>
>>> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
>>> SMART overall-health self-assessment test result: PASSED
>>>
>>> General SMART Values:
>>> Offline data collection status: =A0(0x00) Offline data collection a=
ctivity
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 was never started.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Auto Offline Data Collection:
>>> Disabled.
>>> Self-test execution status: =A0 =A0 =A0( =A0 0) The previous self-t=
est routine
>>> completed
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 without error or no self-test has
>>> ever
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 been run.
>>> Total time to complete Offline
>>> data collection: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ( 633) seconds.
>>> Offline data collection
>>> capabilities: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x73) SMART e=
xecute Offline immediate.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Auto Offline data collection
>>> on/off support.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Suspend Offline collection upon
>>> new
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 command.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 No Offline surface scan
>>> supported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Self-test supported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Conveyance Self-test supported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Selective Self-test supported.
>>> SMART capabilities: =A0 =A0 =A0 =A0 =A0 =A0(0x0003) Saves SMART dat=
a before entering
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 power-saving mode.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Supports SMART auto save timer.
>>> Error logging capability: =A0 =A0 =A0 =A0(0x01) Error logging suppo=
rted.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 General Purpose Logging
>>> supported.
>>> Short self-test routine
>>> recommended polling time: =A0 =A0 =A0 =A0( =A0 1) minutes.
>>> Extended self-test routine
>>> recommended polling time: =A0 =A0 =A0 =A0( 255) minutes.
>>> Conveyance self-test routine
>>> recommended polling time: =A0 =A0 =A0 =A0( =A0 2) minutes.
>>> SCT capabilities: =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x103f) SCT Status su=
pported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 SCT Error Recovery Control
>>> supported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 SCT Feature Control supported.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 SCT Data Table supported.
>>>
>>> SMART Attributes Data Structure revision number: 10
>>> Vendor Specific SMART Attributes with Thresholds:
>>> ID# ATTRIBUTE_NAME =A0 =A0 =A0 =A0 =A0FLAG =A0 =A0 VALUE WORST THRE=
SH TYPE =A0 =A0 =A0UPDATED
>>> =A0WHEN_FAILED RAW_VALUE
>>> =A0 1 Raw_Read_Error_Rate =A0 =A0 0x000f =A0 100 =A0 089 =A0 006 =A0=
 =A0Pre-fail =A0Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 184733939
>>> =A0 3 Spin_Up_Time =A0 =A0 =A0 =A0 =A0 =A00x0003 =A0 100 =A0 100 =A0=
 000 =A0 =A0Pre-fail =A0Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> =A0 4 Start_Stop_Count =A0 =A0 =A0 =A00x0032 =A0 099 =A0 099 =A0 02=
0 =A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 1160
>>> =A0 5 Reallocated_Sector_Ct =A0 0x0033 =A0 100 =A0 100 =A0 036 =A0 =
=A0Pre-fail =A0Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> =A0 7 Seek_Error_Rate =A0 =A0 =A0 =A0 0x000f =A0 100 =A0 253 =A0 03=
0 =A0 =A0Pre-fail =A0Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 296094
>>> =A0 9 Power_On_Hours =A0 =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 =
000 =A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 307
>>> =A010 Spin_Retry_Count =A0 =A0 =A0 =A00x0013 =A0 100 =A0 100 =A0 09=
7 =A0 =A0Pre-fail =A0Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> =A012 Power_Cycle_Count =A0 =A0 =A0 0x0032 =A0 099 =A0 099 =A0 020 =
=A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 1186
>>> 183 Runtime_Bad_Block =A0 =A0 =A0 0x0032 =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> 184 End-to-End_Error =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 099 =
=A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> 187 Reported_Uncorrect =A0 =A0 =A00x0032 =A0 001 =A0 001 =A0 000 =A0=
 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 225
>>> 188 Command_Timeout =A0 =A0 =A0 =A0 0x0032 =A0 100 =A0 099 =A0 000 =
=A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 4295032833
>>> 189 High_Fly_Writes =A0 =A0 =A0 =A0 0x003a =A0 100 =A0 100 =A0 000 =
=A0 =A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> 190 Airflow_Temperature_Cel 0x0022 =A0 063 =A0 063 =A0 045 =A0 =A0O=
ld_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 37 (Lifetime Min/Max 19/37)
>>> 194 Temperature_Celsius =A0 =A0 0x0022 =A0 037 =A0 040 =A0 000 =A0 =
=A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 37 (0 16 0 0)
>>> 195 Hardware_ECC_Recovered =A00x001a =A0 052 =A0 033 =A0 000 =A0 =A0=
Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 184733939
>>> 197 Current_Pending_Sector =A00x0012 =A0 100 =A0 099 =A0 000 =A0 =A0=
Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 40
>>> 198 Offline_Uncorrectable =A0 0x0010 =A0 100 =A0 099 =A0 000 =A0 =A0=
Old_age =A0 Offline
>>> =A0 =A0 =A0- =A0 =A0 =A0 40
>>> 199 UDMA_CRC_Error_Count =A0 =A00x003e =A0 200 =A0 200 =A0 000 =A0 =
=A0Old_age =A0 Always
>>> =A0 =A0 =A0 - =A0 =A0 =A0 0
>>> 240 Head_Flying_Hours =A0 =A0 =A0 0x0000 =A0 100 =A0 253 =A0 000 =A0=
 =A0Old_age =A0 Offline
>>> =A0 =A0 =A0- =A0 =A0 =A0 210019605808507
>>> 241 Total_LBAs_Written =A0 =A0 =A00x0000 =A0 100 =A0 253 =A0 000 =A0=
 =A0Old_age =A0 Offline
>>> =A0 =A0 =A0- =A0 =A0 =A0 546635184
>>> 242 Total_LBAs_Read =A0 =A0 =A0 =A0 0x0000 =A0 100 =A0 253 =A0 000 =
=A0 =A0Old_age =A0 Offline
>>> =A0 =A0 =A0- =A0 =A0 =A0 2195715347
>
> The SMART data shows there haven't been many start/stops other than f=
rom
> power cycles, so I don't think spindown is related here. The error lo=
g
> entries and the Offline_Uncorrectable and Reported_Uncorrect attribut=
es
> would indicate that your drive is having read errors. Think you likel=
y need
> a new drive.
>
