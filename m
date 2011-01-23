From: BU66ER BAD6ER <debu66er@gmail.com>
Subject: Seagate hard disk firmware issue
Date: Sun, 23 Jan 2011 12:05:27 +0100
Message-ID: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52907 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1AWLF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jan 2011 06:05:29 -0500
Received: by gxk9 with SMTP id 9so983233gxk.19
        for <linux-ide@vger.kernel.org>; Sun, 23 Jan 2011 03:05:28 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

=46our weeks ago I bought a new 2TB Seagate Barracuda internal SATA
drive. That drive has two 667GB ext4 partions (667GB unused) and it is
used for storage. My main system (Debian Sid 64-bit and KDE) resides
on a 40GB SSD, also using ext4.

Two weeks ago I noticed a severe performance drop, where any file
manager couldn't view directories on the 2TB disk without a one or two
minute penalty. After that I have had three hard freezes of that disk
and the entire system. Before the freeze there is very much hd
activity and finally I need to turn the power off. I have now also
made a backup of /dev/sdb1 should it be fatally serious.

I was recommended by someone at the #debian irc to make changes to the
spindown_time but that only helped for a few days. Yesterday, the 3rd
freeze came and the system wouldn't even recognize the disk after
reboot; just 'clicking' waiting for a response. I showed the kern.log
to someone at the same channel who concluded that this should be a
firmware issue.

Here is the latest kern.log which may identify the issue: I hope it
contains the relevant details. But first the output of smartctl -a
/dev/sdb.

I have now set the hdparm spindown_time to 0, disabling disk sleep
which seems to have been the culprit as judged on messages in the
Dolphin file manager etc.

Thanks for any help!


> # smartctl -a /dev/sdb
> smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local buil=
d)
> Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforg=
e.net
>
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Model Family:=A0=A0=A0=A0 Seagate Barracuda LP
> Device Model:=A0=A0=A0=A0 ST32000542AS
> Serial Number:=A0=A0=A0 5XW20H7P
> Firmware Version: CC34
> User Capacity:=A0=A0=A0 2,000,398,934,016 bytes
> Device is:=A0=A0=A0=A0=A0=A0=A0 In smartctl database [for details use=
: -P show]
> ATA Version is:=A0=A0 8
> ATA Standard is:=A0 ATA-8-ACS revision 4
> Local Time is:=A0=A0=A0 Sun Jan 23 11:50:56 2011 CET
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
>
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART overall-health self-assessment test result: PASSED
>
> General SMART Values:
> Offline data collection status:=A0 (0x00) Offline data collection act=
ivity
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 was never started.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Auto Offline Data Coll=
ection: Disabled.
> Self-test execution status:=A0=A0=A0=A0=A0 (=A0=A0 0) The previous se=
lf-test routine completed
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 without error or no se=
lf-test has ever
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 been run.
> Total time to complete Offline
> data collection:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ( 63=
3) seconds.
> Offline data collection
> capabilities:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 (0x73) SMART execute Offline immediate.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Auto Offline data coll=
ection on/off support.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Suspend Offline collec=
tion upon new
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 command.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No Offline surface sca=
n supported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Self-test supported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Conveyance Self-test s=
upported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Selective Self-test su=
pported.
> SMART capabilities:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (0x0003) Saves S=
MART data before entering
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power-saving mode.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Supports SMART auto sa=
ve timer.
> Error logging capability:=A0=A0=A0=A0=A0=A0=A0 (0x01) Error logging s=
upported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 General Purpose Loggin=
g supported.
> Short self-test routine
> recommended polling time:=A0=A0=A0=A0=A0=A0=A0 (=A0=A0 1) minutes.
> Extended self-test routine
> recommended polling time:=A0=A0=A0=A0=A0=A0=A0 ( 255) minutes.
> Conveyance self-test routine
> recommended polling time:=A0=A0=A0=A0=A0=A0=A0 (=A0=A0 2) minutes.
> SCT capabilities:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (0x103f) SCT=
 Status supported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCT Error Recovery Con=
trol supported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCT Feature Control su=
pported.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCT Data Table support=
ed.
>
> SMART Attributes Data Structure revision number: 10
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME=A0=A0=A0=A0=A0=A0=A0=A0=A0 FLAG=A0=A0=A0=A0 VALUE =
WORST THRESH TYPE=A0=A0=A0=A0=A0 UPDATED=A0 WHEN_FAILED RAW_VALUE
> =A0 1 Raw_Read_Error_Rate=A0=A0=A0=A0 0x000f=A0=A0 100=A0=A0 089=A0=A0=
 006=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 =
184733939
> =A0 3 Spin_Up_Time=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0003=A0=A0 100=A0=
=A0 100=A0=A0 000=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=
=A0=A0=A0=A0 0
> =A0 4 Start_Stop_Count=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 099=A0=A0 09=
9=A0=A0 020=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 1160
> =A0 5 Reallocated_Sector_Ct=A0=A0 0x0033=A0=A0 100=A0=A0 100=A0=A0 03=
6=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0
> =A0 7 Seek_Error_Rate=A0=A0=A0=A0=A0=A0=A0=A0 0x000f=A0=A0 100=A0=A0 =
253=A0=A0 030=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 296094
> =A0 9 Power_On_Hours=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0=
 100=A0=A0 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=
=A0=A0=A0 307
> =A010 Spin_Retry_Count=A0=A0=A0=A0=A0=A0=A0 0x0013=A0=A0 100=A0=A0 10=
0=A0=A0 097=A0=A0=A0 Pre-fail=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 0
> =A012 Power_Cycle_Count=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 099=A0=A0 099=A0=
=A0 020=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=
=A0 1186
> 183 Runtime_Bad_Block=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0 100=A0=
=A0 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=
=A0 0
> 184 End-to-End_Error=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0 100=A0=
=A0 099=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=
=A0 0
> 187 Reported_Uncorrect=A0=A0=A0=A0=A0 0x0032=A0=A0 001=A0=A0 001=A0=A0=
 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=
 225
> 188 Command_Timeout=A0=A0=A0=A0=A0=A0=A0=A0 0x0032=A0=A0 100=A0=A0 09=
9=A0=A0 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 4295032833
> 189 High_Fly_Writes=A0=A0=A0=A0=A0=A0=A0=A0 0x003a=A0=A0 100=A0=A0 10=
0=A0=A0 000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 0
> 190 Airflow_Temperature_Cel 0x0022=A0=A0 063=A0=A0 063=A0=A0 045=A0=A0=
=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 37 (Life=
time Min/Max 19/37)
> 194 Temperature_Celsius=A0=A0=A0=A0 0x0022=A0=A0 037=A0=A0 040=A0=A0 =
000=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=
 37 (0 16 0 0)
> 195 Hardware_ECC_Recovered=A0 0x001a=A0=A0 052=A0=A0 033=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 18473=
3939
> 197 Current_Pending_Sector=A0 0x0012=A0=A0 100=A0=A0 099=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 40
> 198 Offline_Uncorrectable=A0=A0 0x0010=A0=A0 100=A0=A0 099=A0=A0 000=A0=
=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 40
> 199 UDMA_CRC_Error_Count=A0=A0=A0 0x003e=A0=A0 200=A0=A0 200=A0=A0 00=
0=A0=A0=A0 Old_age=A0=A0 Always=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 0
> 240 Head_Flying_Hours=A0=A0=A0=A0=A0=A0 0x0000=A0=A0 100=A0=A0 253=A0=
=A0 000=A0=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=
 210019605808507
> 241 Total_LBAs_Written=A0=A0=A0=A0=A0 0x0000=A0=A0 100=A0=A0 253=A0=A0=
 000=A0=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 =
546635184
> 242 Total_LBAs_Read=A0=A0=A0=A0=A0=A0=A0=A0 0x0000=A0=A0 100=A0=A0 25=
3=A0=A0 000=A0=A0=A0 Old_age=A0=A0 Offline=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=
=A0=A0 2195715347
>
> SMART Error Log Version: 1
> ATA Error Count: 303 (device log contains only the most recent five e=
rrors)
> =A0=A0=A0=A0=A0=A0=A0 CR =3D Command Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 FR =3D Features Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 SC =3D Sector Count Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 SN =3D Sector Number Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 CL =3D Cylinder Low Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 CH =3D Cylinder High Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 DH =3D Device/Head Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 DC =3D Device Command Register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 ER =3D Error register [HEX]
> =A0=A0=A0=A0=A0=A0=A0 ST =3D Status register [HEX]
> Powered_Up_Time is measured from power on, and printed as
> DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
> SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.
>
> Error 303 occurred at disk power-on lifetime: 305 hours (12 days + 17=
 hours)
> =A0 When the command that caused the error occurred, the device was a=
ctive or idle.
>
> =A0 After command completion occurred, registers were:
> =A0 ER ST SC SN CL CH DH
> =A0 -- -- -- -- -- -- --
> =A0 40 51 00 58 e9 a8 00=A0 Error: UNC at LBA =3D 0x00a8e958 =3D 1106=
9784
>
> =A0 Commands leading to the command that caused the error were:
> =A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_=
Name
> =A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 ------------------=
--
> =A0 c8 00 08 57 e9 a8 e0 00=A0=A0=A0=A0=A0 02:02:27.917=A0 READ DMA
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:27.916=A0 READ NATIV=
E MAX ADDRESS EXT
> =A0 ec 00 00 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:27.908=A0 IDENTIFY D=
EVICE
> =A0 ef 03 46 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:27.877=A0 SET FEATUR=
ES [Set transfer mode]
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:27.788=A0 READ NATIV=
E MAX ADDRESS EXT
>
> Error 302 occurred at disk power-on lifetime: 305 hours (12 days + 17=
 hours)
> =A0 When the command that caused the error occurred, the device was a=
ctive or idle.
>
> =A0 After command completion occurred, registers were:
> =A0 ER ST SC SN CL CH DH
> =A0 -- -- -- -- -- -- --
> =A0 40 51 00 58 e9 a8 00=A0 Error: UNC at LBA =3D 0x00a8e958 =3D 1106=
9784
>
> =A0 Commands leading to the command that caused the error were:
> =A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_=
Name
> =A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 ------------------=
--
> =A0 c8 00 08 57 e9 a8 e0 00=A0=A0=A0=A0=A0 02:02:24.081=A0 READ DMA
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:24.080=A0 READ NATIV=
E MAX ADDRESS EXT
> =A0 ec 00 00 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:24.071=A0 IDENTIFY D=
EVICE
> =A0 ef 03 46 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:24.066=A0 SET FEATUR=
ES [Set transfer mode]
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:24.044=A0 READ NATIV=
E MAX ADDRESS EXT
>
> Error 301 occurred at disk power-on lifetime: 305 hours (12 days + 17=
 hours)
> =A0 When the command that caused the error occurred, the device was a=
ctive or idle.
>
> =A0 After command completion occurred, registers were:
> =A0 ER ST SC SN CL CH DH
> =A0 -- -- -- -- -- -- --
> =A0 40 51 00 58 e9 a8 00=A0 Error: UNC at LBA =3D 0x00a8e958 =3D 1106=
9784
>
> =A0 Commands leading to the command that caused the error were:
> =A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_=
Name
> =A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 ------------------=
--
> =A0 c8 00 08 57 e9 a8 e0 00=A0=A0=A0=A0=A0 02:02:20.320=A0 READ DMA
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:20.319=A0 READ NATIV=
E MAX ADDRESS EXT
> =A0 ec 00 00 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:20.310=A0 IDENTIFY D=
EVICE
> =A0 ef 03 46 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:20.302=A0 SET FEATUR=
ES [Set transfer mode]
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:20.279=A0 READ NATIV=
E MAX ADDRESS EXT
>
> Error 300 occurred at disk power-on lifetime: 305 hours (12 days + 17=
 hours)
> =A0 When the command that caused the error occurred, the device was a=
ctive or idle.
>
> =A0 After command completion occurred, registers were:
> =A0 ER ST SC SN CL CH DH
> =A0 -- -- -- -- -- -- --
> =A0 40 51 00 58 e9 a8 00=A0 Error: UNC at LBA =3D 0x00a8e958 =3D 1106=
9784
>
> =A0 Commands leading to the command that caused the error were:
> =A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_=
Name
> =A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 ------------------=
--
> =A0 c8 00 08 57 e9 a8 e0 00=A0=A0=A0=A0=A0 02:02:16.559=A0 READ DMA
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:16.558=A0 READ NATIV=
E MAX ADDRESS EXT
> =A0 ec 00 00 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:16.546=A0 IDENTIFY D=
EVICE
> =A0 ef 03 46 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:16.538=A0 SET FEATUR=
ES [Set transfer mode]
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:16.506=A0 READ NATIV=
E MAX ADDRESS EXT
>
> Error 299 occurred at disk power-on lifetime: 305 hours (12 days + 17=
 hours)
> =A0 When the command that caused the error occurred, the device was a=
ctive or idle.
>
> =A0 After command completion occurred, registers were:
> =A0 ER ST SC SN CL CH DH
> =A0 -- -- -- -- -- -- --
> =A0 40 51 00 58 e9 a8 00=A0 Error: UNC at LBA =3D 0x00a8e958 =3D 1106=
9784
>
> =A0 Commands leading to the command that caused the error were:
> =A0 CR FR SC SN CL CH DH DC=A0=A0 Powered_Up_Time=A0 Command/Feature_=
Name
> =A0 -- -- -- -- -- -- -- --=A0 ----------------=A0 ------------------=
--
> =A0 c8 00 08 57 e9 a8 e0 00=A0=A0=A0=A0=A0 02:02:12.770=A0 READ DMA
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:12.769=A0 READ NATIV=
E MAX ADDRESS EXT
> =A0 ec 00 00 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:12.761=A0 IDENTIFY D=
EVICE
> =A0 ef 03 46 00 00 00 a0 00=A0=A0=A0=A0=A0 02:02:12.754=A0 SET FEATUR=
ES [Set transfer mode]
> =A0 27 00 00 00 00 00 e0 00=A0=A0=A0=A0=A0 02:02:12.725=A0 READ NATIV=
E MAX ADDRESS EXT
>
> SMART Self-test log structure revision number 1
> No self-tests have been logged.=A0 [To run self-tests, use: smartctl =
-t]
>
>
> SMART Selective self-test log data structure revision number 1
> =A0SPAN=A0 MIN_LBA=A0 MAX_LBA=A0 CURRENT_TEST_STATUS
> =A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_test=
ing
> =A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_test=
ing
> =A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_test=
ing
> =A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_test=
ing
> =A0=A0=A0 5=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 0=A0 Not_test=
ing
> Selective self-test flags (0x0):
> =A0 After scanning selected spans, do NOT read-scan remainder of disk=
=2E
> If Selective self-test is pending on power-up, resume after 0 minute =
delay.

and here is the output of kern.log

Jan 22 07:26:59 my kernel: [    0.439387] SCSI subsystem initialized
Jan 22 07:26:59 my kernel: [    0.443964] ehci_hcd 0000:00:1d.7: USB
2.0 started, EHCI 1.00
Jan 22 07:26:59 my kernel: [    0.443981] usb usb1: New USB device
found, idVendor=3D1d6b, idProduct=3D0002
Jan 22 07:26:59 my kernel: [    0.443983] usb usb1: New USB device
strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jan 22 07:26:59 my kernel: [    0.443984] usb usb1: Product: EHCI Host
Controller
Jan 22 07:26:59 my kernel: [    0.443986] usb usb1: Manufacturer:
Linux 2.6.32-5-amd64 ehci_hcd
Jan 22 07:26:59 my kernel: [    0.443987] usb usb1: SerialNumber: 0000:=
00:1d.7
Jan 22 07:26:59 my kernel: [    0.444064] usb usb1: configuration #1
chosen from 1 choice
Jan 22 07:26:59 my kernel: [    0.444105] hub 1-0:1.0: USB hub found
Jan 22 07:26:59 my kernel: [    0.444110] hub 1-0:1.0: 8 ports detected
Jan 22 07:26:59 my kernel: [    0.444170] uhci_hcd 0000:00:1d.0: PCI
INT A -> GSI 23 (level, low) -> IRQ 23
Jan 22 07:26:59 my kernel: [    0.444176] uhci_hcd 0000:00:1d.0:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.444178] uhci_hcd 0000:00:1d.0: UHCI
Host Controller
Jan 22 07:26:59 my kernel: [    0.444184] uhci_hcd 0000:00:1d.0: new
USB bus registered, assigned bus number 2
Jan 22 07:26:59 my kernel: [    0.444203] uhci_hcd 0000:00:1d.0: irq
23, io base 0x0000b880
Jan 22 07:26:59 my kernel: [    0.444225] usb usb2: New USB device
found, idVendor=3D1d6b, idProduct=3D0001
Jan 22 07:26:59 my kernel: [    0.444227] usb usb2: New USB device
strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jan 22 07:26:59 my kernel: [    0.444229] usb usb2: Product: UHCI Host
Controller
Jan 22 07:26:59 my kernel: [    0.444230] usb usb2: Manufacturer:
Linux 2.6.32-5-amd64 uhci_hcd
Jan 22 07:26:59 my kernel: [    0.444231] usb usb2: SerialNumber: 0000:=
00:1d.0
Jan 22 07:26:59 my kernel: [    0.444268] usb usb2: configuration #1
chosen from 1 choice
Jan 22 07:26:59 my kernel: [    0.444285] hub 2-0:1.0: USB hub found
Jan 22 07:26:59 my kernel: [    0.444289] hub 2-0:1.0: 2 ports detected
Jan 22 07:26:59 my kernel: [    0.444323]   alloc irq_desc for 19 on no=
de -1
Jan 22 07:26:59 my kernel: [    0.444325]   alloc kstat_irqs on node -1
Jan 22 07:26:59 my kernel: [    0.444329] uhci_hcd 0000:00:1d.1: PCI
INT B -> GSI 19 (level, low) -> IRQ 19
Jan 22 07:26:59 my kernel: [    0.444333] uhci_hcd 0000:00:1d.1:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.444335] uhci_hcd 0000:00:1d.1: UHCI
Host Controller
Jan 22 07:26:59 my kernel: [    0.444340] uhci_hcd 0000:00:1d.1: new
USB bus registered, assigned bus number 3
Jan 22 07:26:59 my kernel: [    0.444364] uhci_hcd 0000:00:1d.1: irq
19, io base 0x0000bc00
Jan 22 07:26:59 my kernel: [    0.444387] usb usb3: New USB device
found, idVendor=3D1d6b, idProduct=3D0001
Jan 22 07:26:59 my kernel: [    0.444388] usb usb3: New USB device
strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jan 22 07:26:59 my kernel: [    0.444390] usb usb3: Product: UHCI Host
Controller
Jan 22 07:26:59 my kernel: [    0.444391] usb usb3: Manufacturer:
Linux 2.6.32-5-amd64 uhci_hcd
Jan 22 07:26:59 my kernel: [    0.444392] usb usb3: SerialNumber: 0000:=
00:1d.1
Jan 22 07:26:59 my kernel: [    0.444429] usb usb3: configuration #1
chosen from 1 choice
Jan 22 07:26:59 my kernel: [    0.444447] hub 3-0:1.0: USB hub found
Jan 22 07:26:59 my kernel: [    0.444451] hub 3-0:1.0: 2 ports detected
Jan 22 07:26:59 my kernel: [    0.444485]   alloc irq_desc for 18 on no=
de -1
Jan 22 07:26:59 my kernel: [    0.444486]   alloc kstat_irqs on node -1
Jan 22 07:26:59 my kernel: [    0.444489] uhci_hcd 0000:00:1d.2: PCI
INT C -> GSI 18 (level, low) -> IRQ 18
Jan 22 07:26:59 my kernel: [    0.444493] uhci_hcd 0000:00:1d.2:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.444495] uhci_hcd 0000:00:1d.2: UHCI
Host Controller
Jan 22 07:26:59 my kernel: [    0.444500] uhci_hcd 0000:00:1d.2: new
USB bus registered, assigned bus number 4
Jan 22 07:26:59 my kernel: [    0.444523] uhci_hcd 0000:00:1d.2: irq
18, io base 0x0000c000
Jan 22 07:26:59 my kernel: [    0.444546] usb usb4: New USB device
found, idVendor=3D1d6b, idProduct=3D0001
Jan 22 07:26:59 my kernel: [    0.444547] usb usb4: New USB device
strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jan 22 07:26:59 my kernel: [    0.444549] usb usb4: Product: UHCI Host
Controller
Jan 22 07:26:59 my kernel: [    0.444550] usb usb4: Manufacturer:
Linux 2.6.32-5-amd64 uhci_hcd
Jan 22 07:26:59 my kernel: [    0.444551] usb usb4: SerialNumber: 0000:=
00:1d.2
Jan 22 07:26:59 my kernel: [    0.444586] usb usb4: configuration #1
chosen from 1 choice
Jan 22 07:26:59 my kernel: [    0.444606] hub 4-0:1.0: USB hub found
Jan 22 07:26:59 my kernel: [    0.444610] hub 4-0:1.0: 2 ports detected
Jan 22 07:26:59 my kernel: [    0.444641] uhci_hcd 0000:00:1d.3: PCI
INT D -> GSI 16 (level, low) -> IRQ 16
Jan 22 07:26:59 my kernel: [    0.444645] uhci_hcd 0000:00:1d.3:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.444648] uhci_hcd 0000:00:1d.3: UHCI
Host Controller
Jan 22 07:26:59 my kernel: [    0.444652] uhci_hcd 0000:00:1d.3: new
USB bus registered, assigned bus number 5
Jan 22 07:26:59 my kernel: [    0.444676] uhci_hcd 0000:00:1d.3: irq
16, io base 0x0000c080
Jan 22 07:26:59 my kernel: [    0.444699] usb usb5: New USB device
found, idVendor=3D1d6b, idProduct=3D0001
Jan 22 07:26:59 my kernel: [    0.444701] usb usb5: New USB device
strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
Jan 22 07:26:59 my kernel: [    0.444702] usb usb5: Product: UHCI Host
Controller
Jan 22 07:26:59 my kernel: [    0.444704] usb usb5: Manufacturer:
Linux 2.6.32-5-amd64 uhci_hcd
Jan 22 07:26:59 my kernel: [    0.444705] usb usb5: SerialNumber: 0000:=
00:1d.3
Jan 22 07:26:59 my kernel: [    0.444747] usb usb5: configuration #1
chosen from 1 choice
Jan 22 07:26:59 my kernel: [    0.444765] hub 5-0:1.0: USB hub found
Jan 22 07:26:59 my kernel: [    0.444769] hub 5-0:1.0: 2 ports detected
Jan 22 07:26:59 my kernel: [    0.449570] Floppy drive(s): fd0 is 1.44M
Jan 22 07:26:59 my kernel: [    0.449771] libata version 3.00 loaded.
Jan 22 07:26:59 my kernel: [    0.451665] via-rhine.c:v1.10-LK1.4.3
2007-03-06 Written by Donald Becker
Jan 22 07:26:59 my kernel: [    0.451684]   alloc irq_desc for 22 on no=
de -1
Jan 22 07:26:59 my kernel: [    0.451685]   alloc kstat_irqs on node -1
Jan 22 07:26:59 my kernel: [    0.451689] via-rhine 0000:01:02.0: PCI
INT A -> GSI 22 (level, low) -> IRQ 22
Jan 22 07:26:59 my kernel: [    0.456630] ata_piix 0000:00:1f.1: versio=
n 2.13
Jan 22 07:26:59 my kernel: [    0.456912] ata_piix 0000:00:1f.1: PCI
INT A -> GSI 18 (level, low) -> IRQ 18
Jan 22 07:26:59 my kernel: [    0.456937] ata_piix 0000:00:1f.1:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.457559] scsi0 : ata_piix
Jan 22 07:26:59 my kernel: [    0.457622] eth0: VIA Rhine III at
0x1d800, 00:11:95:86:8d:f8, IRQ 22.
Jan 22 07:26:59 my kernel: [    0.458339] eth0: MII PHY found at
address 1, status 0x786d advertising 05e1 Link 45e1.
Jan 22 07:26:59 my kernel: [    0.458343] scsi1 : ata_piix
Jan 22 07:26:59 my kernel: [    0.459329] ata1: PATA max UDMA/100 cmd
0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
Jan 22 07:26:59 my kernel: [    0.459331] ata2: PATA max UDMA/100 cmd
0x170 ctl 0x376 bmdma 0xffa8 irq 15
Jan 22 07:26:59 my kernel: [    0.459348] ata_piix 0000:00:1f.2: PCI
INT B -> GSI 19 (level, low) -> IRQ 19
Jan 22 07:26:59 my kernel: [    0.459351] ata_piix 0000:00:1f.2: MAP [
P0 P2 P1 P3 ]
Jan 22 07:26:59 my kernel: [    0.459376] ata_piix 0000:00:1f.2:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    0.459416]   alloc irq_desc for 21 on no=
de -1
Jan 22 07:26:59 my kernel: [    0.459418]   alloc kstat_irqs on node -1
Jan 22 07:26:59 my kernel: [    0.459422] firewire_ohci 0000:01:01.0:
PCI INT A -> GSI 21 (level, low) -> IRQ 21
Jan 22 07:26:59 my kernel: [    0.459499] scsi2 : ata_piix
Jan 22 07:26:59 my kernel: [    0.459561] scsi3 : ata_piix
Jan 22 07:26:59 my kernel: [    0.461184] ata3: SATA max UDMA/133 cmd
0xcc00 ctl 0xc880 bmdma 0xc400 irq 19
Jan 22 07:26:59 my kernel: [    0.461185] ata4: SATA max UDMA/133 cmd
0xc800 ctl 0xc480 bmdma 0xc408 irq 19
Jan 22 07:26:59 my kernel: [    0.471598] FDC 0 is a post-1991 82077
Jan 22 07:26:59 my kernel: [    0.535975] firewire_ohci: Added fw-ohci
device 0000:01:01.0, OHCI version 1.0
Jan 22 07:26:59 my kernel: [    0.628338] ata4.00: ATA-8:
ST32000542AS, CC34, max UDMA/133
Jan 22 07:26:59 my kernel: [    0.628341] ata4.00: 3907029168 sectors,
multi 16: LBA48 NCQ (depth 0/32)
Jan 22 07:26:59 my kernel: [    0.644250] ata4.00: configured for UDMA/=
133
Jan 22 07:26:59 my kernel: [    0.844252] ata3.00: ATA-7: INTEL
SSDSA2M040G2GC, 2CV102HD, max UDMA/133
Jan 22 07:26:59 my kernel: [    0.844255] ata3.00: 78165360 sectors,
multi 16: LBA48 NCQ (depth 0/32)
Jan 22 07:26:59 my kernel: [    0.844296] ata3.01: ATAPI: TSSTcorp
CDDVDW SH-S223C, SB04, max UDMA/100
Jan 22 07:26:59 my kernel: [    0.852166] ata3.00: configured for UDMA/=
133
Jan 22 07:26:59 my kernel: [    0.908202] ata3.01: configured for UDMA/=
100
Jan 22 07:26:59 my kernel: [    0.931374] scsi 2:0:0:0: Direct-Access
   ATA      INTEL SSDSA2M040 2CV1 PQ: 0 ANSI: 5
Jan 22 07:26:59 my kernel: [    0.932025] scsi 2:0:1:0: CD-ROM
   TSSTcorp CDDVDW SH-S223C  SB04 PQ: 0 ANSI: 5
Jan 22 07:26:59 my kernel: [    0.932170] scsi 3:0:0:0: Direct-Access
   ATA      ST32000542AS     CC34 PQ: 0 ANSI: 5
Jan 22 07:26:59 my kernel: [    0.936896] sd 2:0:0:0: [sda] 78165360
512-byte logical blocks: (40.0 GB/37.2 GiB)
Jan 22 07:26:59 my kernel: [    0.936928] sd 3:0:0:0: [sdb] 3907029168
512-byte logical blocks: (2.00 TB/1.81 TiB)
Jan 22 07:26:59 my kernel: [    0.936936] sd 2:0:0:0: [sda] Write Prote=
ct is off
Jan 22 07:26:59 my kernel: [    0.936938] sd 2:0:0:0: [sda] Mode
Sense: 00 3a 00 00
Jan 22 07:26:59 my kernel: [    0.936955] sd 2:0:0:0: [sda] Write
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan 22 07:26:59 my kernel: [    0.936965] sd 3:0:0:0: [sdb] Write Prote=
ct is off
Jan 22 07:26:59 my kernel: [    0.936967] sd 3:0:0:0: [sdb] Mode
Sense: 00 3a 00 00
Jan 22 07:26:59 my kernel: [    0.936982] sd 3:0:0:0: [sdb] Write
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan 22 07:26:59 my kernel: [    0.937065]  sda:
Jan 22 07:26:59 my kernel: [    0.937146]  sdb: sda1 sda2 sda3 sda4
Jan 22 07:26:59 my kernel: [    0.937822] sd 2:0:0:0: [sda] Attached SC=
SI disk
Jan 22 07:26:59 my kernel: [    0.964915]  sdb1 sdb2 sdb3
Jan 22 07:26:59 my kernel: [    0.965125] sd 3:0:0:0: [sdb] Attached SC=
SI disk
Jan 22 07:26:59 my kernel: [    1.034615] sr0: scsi3-mmc drive:
52x/52x writer dvd-ram cd/rw xa/form2 cdda tray
Jan 22 07:26:59 my kernel: [    1.034618] Uniform CD-ROM driver Revisio=
n: 3.20
Jan 22 07:26:59 my kernel: [    1.034693] sr 2:0:1:0: Attached scsi CD-=
ROM sr0
Jan 22 07:26:59 my kernel: [    1.037201] sd 2:0:0:0: Attached scsi
generic sg0 type 0
Jan 22 07:26:59 my kernel: [    1.037275] sr 2:0:1:0: Attached scsi
generic sg1 type 5
Jan 22 07:26:59 my kernel: [    1.037314] sd 3:0:0:0: Attached scsi
generic sg2 type 0
Jan 22 07:26:59 my kernel: [    1.039983] firewire_core: created
device fw0: GUID 0011060001112679, S400
Jan 22 07:26:59 my kernel: [    1.347010] PM: Starting manual resume fr=
om disk
Jan 22 07:26:59 my kernel: [    1.347013] PM: Resume from partition 8:2
Jan 22 07:26:59 my kernel: [    1.347014] PM: Checking hibernation imag=
e.
Jan 22 07:26:59 my kernel: [    1.347244] PM: Error -22 checking image =
file
Jan 22 07:26:59 my kernel: [    1.347246] PM: Resume from disk failed.
Jan 22 07:26:59 my kernel: [    1.361769] EXT4-fs (sda3): mounted
filesystem with ordered data mode
Jan 22 07:26:59 my kernel: [    1.505412] udev[360]: starting version 1=
64
Jan 22 07:26:59 my kernel: [    1.555655] ACPI: SSDT 000000007ff9e0b0
001D2 (v01    AMI   CPU1PM 00000001 INTL 20060113)
Jan 22 07:26:59 my kernel: [    1.555852] processor LNXCPU:00:
registered as cooling_device0
Jan 22 07:26:59 my kernel: [    1.556183] ACPI: SSDT 000000007ff9e290
00143 (v01    AMI   CPU2PM 00000001 INTL 20060113)
Jan 22 07:26:59 my kernel: [    1.556330] processor LNXCPU:01:
registered as cooling_device1
Jan 22 07:26:59 my kernel: [    1.559003] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
Jan 22 07:26:59 my kernel: [    1.559011] ACPI: Power Button [PWRB]
Jan 22 07:26:59 my kernel: [    1.559057] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Jan 22 07:26:59 my kernel: [    1.559059] ACPI: Power Button [PWRF]
Jan 22 07:26:59 my kernel: [    1.568373] input: PC Speaker as
/devices/platform/pcspkr/input/input4
Jan 22 07:26:59 my kernel: [    1.598983] intel_rng: FWH not detected
Jan 22 07:26:59 my kernel: [    2.026042] nvidia: module license
'NVIDIA' taints kernel.
Jan 22 07:26:59 my kernel: [    2.026046] Disabling lock debugging due
to kernel taint
Jan 22 07:26:59 my kernel: [    2.239933] input: ImPS/2 Generic Wheel
Mouse as /devices/platform/i8042/serio1/input/input5
Jan 22 07:26:59 my kernel: [    2.247908] i801_smbus 0000:00:1f.3: PCI
INT B -> GSI 19 (level, low) -> IRQ 19
Jan 22 07:26:59 my kernel: [    2.250796] parport_pc 00:07: reported
by Plug and Play ACPI
Jan 22 07:26:59 my kernel: [    2.250890] parport0: PC-style at 0x378
(0x778), irq 7 [PCSPP,TRISTATE,EPP]
Jan 22 07:26:59 my kernel: [    2.276519] parport0: Printer,
Hewlett-Packard HP LaserJet 1100
Jan 22 07:26:59 my kernel: [    2.495774] nvidia 0000:04:00.0: PCI INT
A -> GSI 16 (level, low) -> IRQ 16
Jan 22 07:26:59 my kernel: [    2.495780] nvidia 0000:04:00.0: setting
latency timer to 64
Jan 22 07:26:59 my kernel: [    2.495784] vgaarb: device changed
decodes: PCI:0000:04:00.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+=
mem
Jan 22 07:26:59 my kernel: [    2.495862] NVRM: loading NVIDIA UNIX
x86_64 Kernel Module  195.36.31  Thu Jun  3 08:19:50 PDT 2010
Jan 22 07:26:59 my kernel: [    2.549543] HDA Intel 0000:00:1b.0: PCI
INT A -> GSI 16 (level, low) -> IRQ 16
Jan 22 07:26:59 my kernel: [    2.549567] HDA Intel 0000:00:1b.0:
setting latency timer to 64
Jan 22 07:26:59 my kernel: [    2.619123] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/input/input6
Jan 22 07:26:59 my kernel: [    2.709931] Adding 249848k swap on
/dev/sda2.  Priority:-1 extents:1 across:249848k SS
Jan 22 07:26:59 my kernel: [    2.784474] loop: module loaded
Jan 22 07:26:59 my kernel: [    3.118288] EXT4-fs (sda4): mounted
filesystem with ordered data mode
Jan 22 07:26:59 my kernel: [    3.174861] EXT4-fs (sdb1): mounted
filesystem with ordered data mode
Jan 22 07:26:59 my kernel: [    3.212696] EXT4-fs (sdb2): mounted
filesystem with ordered data mode
Jan 22 07:26:59 my kernel: [    3.331711] ip_tables: (C) 2000-2006
Netfilter Core Team
Jan 22 07:26:59 my kernel: [    3.341759] nf_conntrack version 0.5.0
(16384 buckets, 65536 max)
Jan 22 07:26:59 my kernel: [    3.341943] CONFIG_NF_CT_ACCT is
deprecated and will be removed soon. Please use
Jan 22 07:26:59 my kernel: [    3.341945] nf_conntrack.acct=3D1 kernel
parameter, acct=3D1 nf_conntrack module option or
Jan 22 07:26:59 my kernel: [    3.341946] sysctl
net.netfilter.nf_conntrack_acct=3D1 to enable it.
Jan 22 07:26:59 my kernel: [    3.365328] ip6_tables: (C) 2000-2006
Netfilter Core Team
Jan 22 07:26:59 my kernel: [    8.449954] fuse init (API version 7.13)
Jan 22 07:27:00 my kernel: [    9.362940]   alloc irq_desc for 27 on no=
de -1
Jan 22 07:27:00 my kernel: [    9.362942]   alloc kstat_irqs on node -1
Jan 22 07:27:00 my kernel: [    9.362957] atl1 0000:02:00.0: irq 27
for MSI/MSI-X
Jan 22 07:27:00 my kernel: [    9.363242] ADDRCONF(NETDEV_UP): eth1:
link is not ready
Jan 22 07:27:00 my kernel: [    9.365260] eth0: link up, 100Mbps,
full-duplex, lpa 0x45E1
Jan 22 07:27:01 my kernel: [    9.861987] lp0: using parport0
(interrupt-driven).
Jan 22 07:27:01 my kernel: [    9.864872] ppdev: user-space parallel po=
rt driver
Jan 22 07:27:11 my kernel: [   19.896007] eth0: no IPv6 routers present
Jan 22 07:28:33 my kernel: [  102.645811] CPU0 attaching NULL sched-dom=
ain.
Jan 22 07:28:33 my kernel: [  102.645816] CPU1 attaching NULL sched-dom=
ain.
Jan 22 07:28:33 my kernel: [  102.668591] CPU0 attaching sched-domain:
Jan 22 07:28:33 my kernel: [  102.668594]  domain 0: span 0-1 level MC
Jan 22 07:28:33 my kernel: [  102.668596]   groups: 0 1
Jan 22 07:28:33 my kernel: [  102.668601] CPU1 attaching sched-domain:
Jan 22 07:28:33 my kernel: [  102.668603]  domain 0: span 0-1 level MC
Jan 22 07:28:33 my kernel: [  102.668606]   groups: 1 0
Jan 22 15:07:58 my kernel: [27667.804537] ata4: lost interrupt (Status =
0x50)
Jan 22 15:07:58 my kernel: [27667.804557] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:07:58 my kernel: [27667.804562] ata4.00: failed command: READ=
 DMA EXT
Jan 22 15:07:58 my kernel: [27667.804568] ata4.00: cmd
25/00:38:cf:12:8a/00:00:4d:00:00/e0 tag 0 dma 28672 in
Jan 22 15:07:58 my kernel: [27667.804569]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:07:58 my kernel: [27667.804572] ata4.00: status: { DRDY }
Jan 22 15:07:58 my kernel: [27667.804582] ata4: soft resetting link
Jan 22 15:07:59 my kernel: [27667.987633] ata4.00: configured for UDMA/=
133
Jan 22 15:07:59 my kernel: [27667.987648] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:07:59 my kernel: [27667.987680] ata4: EH complete
Jan 22 15:08:29 my kernel: [27698.804569] ata4: lost interrupt (Status =
0x50)
Jan 22 15:08:29 my kernel: [27698.804592] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:08:29 my kernel: [27698.804597] ata4.00: failed command: READ=
 DMA
Jan 22 15:08:29 my kernel: [27698.804602] ata4.00: cmd
c8/00:80:7f:74:08/00:00:00:00:00/e0 tag 0 dma 65536 in
Jan 22 15:08:29 my kernel: [27698.804603]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:08:29 my kernel: [27698.804605] ata4.00: status: { DRDY }
Jan 22 15:08:29 my kernel: [27698.804616] ata4: soft resetting link
Jan 22 15:08:30 my kernel: [27698.988495] ata4.00: configured for UDMA/=
133
Jan 22 15:08:30 my kernel: [27698.988505] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:08:30 my kernel: [27698.988530] ata4: EH complete
Jan 22 15:09:00 my kernel: [27729.804523] ata4: lost interrupt (Status =
0x50)
Jan 22 15:09:00 my kernel: [27729.804542] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:09:00 my kernel: [27729.804547] ata4.00: failed command: READ=
 DMA
Jan 22 15:09:00 my kernel: [27729.804553] ata4.00: cmd
c8/00:40:3f:21:04/00:00:00:00:00/e0 tag 0 dma 32768 in
Jan 22 15:09:00 my kernel: [27729.804554]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:09:00 my kernel: [27729.804557] ata4.00: status: { DRDY }
Jan 22 15:09:00 my kernel: [27729.804567] ata4: soft resetting link
Jan 22 15:09:01 my kernel: [27729.985869] ata4.00: configured for UDMA/=
133
Jan 22 15:09:01 my kernel: [27729.985876] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:09:01 my kernel: [27729.985889] ata4: EH complete
Jan 22 15:09:31 my kernel: [27760.816048] ata4: lost interrupt (Status =
0x50)
Jan 22 15:09:31 my kernel: [27760.816069] ata4.00: limiting speed to
UDMA/100:PIO4
Jan 22 15:09:31 my kernel: [27760.816073] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:09:31 my kernel: [27760.816077] ata4.00: failed command: READ=
 DMA
Jan 22 15:09:31 my kernel: [27760.816083] ata4.00: cmd
c8/00:48:7f:21:04/00:00:00:00:00/e0 tag 0 dma 36864 in
Jan 22 15:09:31 my kernel: [27760.816085]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:09:31 my kernel: [27760.816087] ata4.00: status: { DRDY }
Jan 22 15:09:31 my kernel: [27760.816098] ata4: soft resetting link
Jan 22 15:09:32 my kernel: [27760.996711] ata4.00: configured for UDMA/=
100
Jan 22 15:09:32 my kernel: [27760.996719] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:09:32 my kernel: [27760.996740] ata4: EH complete
Jan 22 15:10:02 my kernel: [27791.804530] ata4: lost interrupt (Status =
0x50)
Jan 22 15:10:02 my kernel: [27791.804553] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:10:02 my kernel: [27791.804560] ata4.00: failed command: READ=
 DMA
Jan 22 15:10:02 my kernel: [27791.804566] ata4.00: cmd
c8/00:50:c7:7c:08/00:00:00:00:00/e0 tag 0 dma 40960 in
Jan 22 15:10:02 my kernel: [27791.804567]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:10:02 my kernel: [27791.804570] ata4.00: status: { DRDY }
Jan 22 15:10:02 my kernel: [27791.804582] ata4: soft resetting link
Jan 22 15:10:03 my kernel: [27791.988297] ata4.00: configured for UDMA/=
100
Jan 22 15:10:03 my kernel: [27791.988308] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:10:03 my kernel: [27791.988332] ata4: EH complete
Jan 22 15:10:33 my kernel: [27822.804521] ata4: lost interrupt (Status =
0x50)
Jan 22 15:10:33 my kernel: [27822.804539] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:10:33 my kernel: [27822.804544] ata4.00: failed command: READ=
 DMA EXT
Jan 22 15:10:33 my kernel: [27822.804550] ata4.00: cmd
25/00:38:7f:20:8a/00:00:4d:00:00/e0 tag 0 dma 28672 in
Jan 22 15:10:33 my kernel: [27822.804551]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:10:33 my kernel: [27822.804554] ata4.00: status: { DRDY }
Jan 22 15:10:33 my kernel: [27822.804565] ata4: soft resetting link
Jan 22 15:10:34 my kernel: [27822.989794] ata4.00: configured for UDMA/=
100
Jan 22 15:10:34 my kernel: [27822.989800] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:10:34 my kernel: [27822.989814] ata4: EH complete
Jan 22 15:11:04 my kernel: [27853.820104] ata4: lost interrupt (Status =
0x50)
Jan 22 15:11:04 my kernel: [27853.820132] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:11:04 my kernel: [27853.820137] ata4.00: failed command: READ=
 DMA
Jan 22 15:11:04 my kernel: [27853.820142] ata4.00: cmd
c8/00:40:3f:28:04/00:00:00:00:00/e0 tag 0 dma 32768 in
Jan 22 15:11:04 my kernel: [27853.820143]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:11:04 my kernel: [27853.820145] ata4.00: status: { DRDY }
Jan 22 15:11:04 my kernel: [27853.820156] ata4: soft resetting link
Jan 22 15:11:05 my kernel: [27854.004474] ata4.00: configured for UDMA/=
100
Jan 22 15:11:05 my kernel: [27854.004482] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:11:05 my kernel: [27854.004503] ata4: EH complete
Jan 22 15:11:35 my kernel: [27884.804540] ata4: lost interrupt (Status =
0x50)
Jan 22 15:11:35 my kernel: [27884.804566] ata4.00: limiting speed to
UDMA/33:PIO4
Jan 22 15:11:35 my kernel: [27884.804570] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:11:35 my kernel: [27884.804576] ata4.00: failed command: READ=
 DMA
Jan 22 15:11:35 my kernel: [27884.804582] ata4.00: cmd
c8/00:80:7f:28:04/00:00:00:00:00/e0 tag 0 dma 65536 in
Jan 22 15:11:35 my kernel: [27884.804583]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:11:35 my kernel: [27884.804586] ata4.00: status: { DRDY }
Jan 22 15:11:35 my kernel: [27884.804598] ata4: soft resetting link
Jan 22 15:11:36 my kernel: [27884.984946] ata4.00: configured for UDMA/=
33
Jan 22 15:11:36 my kernel: [27884.984953] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:11:36 my kernel: [27884.984971] ata4: EH complete
Jan 22 15:12:06 my kernel: [27915.804529] ata4: lost interrupt (Status =
0x50)
Jan 22 15:12:06 my kernel: [27915.804548] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 15:12:06 my kernel: [27915.804554] ata4.00: failed command: READ=
 DMA
Jan 22 15:12:06 my kernel: [27915.804559] ata4.00: cmd
c8/00:80:7f:28:04/00:00:00:00:00/e0 tag 0 dma 65536 in
Jan 22 15:12:06 my kernel: [27915.804561]          res
40/00:f0:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 15:12:06 my kernel: [27915.804564] ata4.00: status: { DRDY }
Jan 22 15:12:06 my kernel: [27915.804575] ata4: soft resetting link
Jan 22 15:12:07 my kernel: [27915.984902] ata4.00: configured for UDMA/=
33
Jan 22 15:12:07 my kernel: [27915.984909] ata4.00: device reported
invalid CHS sector 0
Jan 22 15:12:07 my kernel: [27915.984927] ata4: EH complete
Jan 22 15:12:52 my kernel: [27961.780543] cupsd[1898]: segfault at
3cf3b ip 000000000003cf3b sp 00007fff28af19d8 error 14 in
libnss_files-2.11.2.so[7ffb50975000+b000]
Jan 22 15:13:45 my kernel: [28014.828243] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D92.33.33.179
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D58 ID=3D0 DF =
PROTO=3DTCP
SPT=3D80 DPT=3D39734 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.868831] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D195.54.111.91
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D59 ID=3D0 DF =
PROTO=3DTCP
SPT=3D80 DPT=3D36214 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.881609] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D50371=
 PROTO=3DTCP
SPT=3D80 DPT=3D37642 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.892944] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D37335=
 PROTO=3DTCP
SPT=3D80 DPT=3D37625 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.897322] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D34042=
 PROTO=3DTCP
SPT=3D80 DPT=3D37626 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.925305] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.118
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D23674=
 PROTO=3DTCP
SPT=3D80 DPT=3D36969 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.933365] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D39469=
 PROTO=3DTCP
SPT=3D80 DPT=3D37640 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.934029] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D34532=
 PROTO=3DTCP
SPT=3D80 DPT=3D37641 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28014.941446] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.99
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D54104=
 PROTO=3DTCP
SPT=3D80 DPT=3D37639 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:13:46 my kernel: [28015.284273] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D92.33.33.179
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D58 ID=3D0 DF =
PROTO=3DTCP
SPT=3D80 DPT=3D39734 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:14:14 my kernel: [28043.604663] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D195.54.111.91
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D59 ID=3D0 DF =
PROTO=3DTCP
SPT=3D80 DPT=3D36214 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:14:43 my kernel: [28072.785223] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D195.54.111.91
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D59 ID=3D0 DF =
PROTO=3DTCP
SPT=3D80 DPT=3D36214 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 15:14:51 my kernel: [28079.949488] [UFW BLOCK] IN=3Deth0 OUT=3D
MAC=3D00:11:92:86:8d:f8:00:1c:f0:4c:c2:b9:08:00 SRC=3D74.125.79.118
DST=3D192.168.0.198 LEN=3D40 TOS=3D0x00 PREC=3D0x00 TTL=3D55 ID=3D23681=
 PROTO=3DTCP
SPT=3D80 DPT=3D36969 WINDOW=3D0 RES=3D0x00 RST URGP=3D0
Jan 22 16:56:43 my kernel: [34192.816023] ata4: lost interrupt (Status =
0x50)
Jan 22 16:56:43 my kernel: [34192.816040] ata4.00: exception Emask 0x0
SAct 0x0 SErr 0x0 action 0x6 frozen
Jan 22 16:56:43 my kernel: [34192.816044] ata4.00: failed command: WRIT=
E DMA EXT
Jan 22 16:56:43 my kernel: [34192.816048] ata4.00: cmd
35/00:08:bf:00:80/00:00:4d:00:00/e0 tag 0 dma 4096 out
Jan 22 16:56:43 my kernel: [34192.816049]          res
40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
Jan 22 16:56:43 my kernel: [34192.816051] ata4.00: status: { DRDY }
Jan 22 16:56:43 my kernel: [34192.816060] ata4: soft resetting link
Jan 22 16:56:44 my kernel: [34192.996387] ata4.00: configured for UDMA/=
33
Jan 22 16:56:44 my kernel: [34192.996392] ata4.00: device reported
invalid CHS sector 0
Jan 22 16:56:44 my kernel: [34192.996402] ata4: EH complete
