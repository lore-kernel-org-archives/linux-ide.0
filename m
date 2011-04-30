From: BU66ER BAD6ER <debu66er@gmail.com>
Subject: Re: Seagate hard disk firmware issue
Date: Sun, 1 May 2011 00:39:54 +0200
Message-ID: <BANLkTimxqcuhFEt-F0R3qkQ6fqTQH8iiXg@mail.gmail.com>
References: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com>
	<AANLkTino+1xuzpYjJt0HCNFMP95bNOwWDVO5daehK0ny@mail.gmail.com>
	<BANLkTim5m51Qx=wm+C1LhEG7dE4C-nkGOw@mail.gmail.com>
	<201104300808.59185.gheskett@wdtv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55817 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab1D3Wj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Apr 2011 18:39:56 -0400
Received: by gyd10 with SMTP id 10so1611782gyd.19
        for <linux-ide@vger.kernel.org>; Sat, 30 Apr 2011 15:39:55 -0700 (PDT)
In-Reply-To: <201104300808.59185.gheskett@wdtv.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sat, Apr 30, 2011 at 2:08 PM, gene heskett <gheskett@wdtv.com> wrote=
:
> On Saturday, April 30, 2011 07:56:21 AM BU66ER BAD6ER did opine:
> This <linux-ide@vger.kernel.org> is a mailing list. =A0WTH when I cli=
ck on
> reply-to-list, do I always have to copy/paste the lists address in th=
e To:
> line? =A0fscking PIMA!
>
> More below, where it should be.
>
>> Hi,
>>
>> Some time ago, I returned my hard disk and got a new one. Lately, I'=
m
>> having performance issues again and I suspect there is a hardware
>> error again like last time. If you could confirm this I would be mos=
t
>> grateful.
>>
>> Thanks in advance!
>>
>> # smartctl -a /dev/sdb
>> smartctl 5.41 2011-03-16 r3296
>> [x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
>> Copyright (C) 2002-11 by Bruce Allen,
>> http://smartmontools.sourceforge.net
>>
>> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
>> Device Model: =A0 =A0 ST2000DL003-9VT166
>> Serial Number: =A0 =A05YD1YD5P
>> Firmware Version: CC32
>> User Capacity: =A0 =A02,000,398,934,016 bytes
>> Device is: =A0 =A0 =A0 =A0Not in smartctl database [for details use:=
 -P showall]
>> ATA Version is: =A0 8
>> ATA Standard is: =A0ATA-8-ACS revision 4
>> Local Time is: =A0 =A0Sat Apr 30 12:59:32 2011 CEST
>> SMART support is: Available - device has SMART capability.
>> SMART support is: Enabled
>>
>> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
>> SMART overall-health self-assessment test result: PASSED
>>
>> General SMART Values:
>> Offline data collection status: =A0(0x82) Offline data collection ac=
tivity
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 was completed without error.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Auto Offline Data Collection:
>> Enabled. Self-test execution status: =A0 =A0 =A0( =A0 0) The previou=
s self-test
>> routine completed without error or no self-test has ever been run.
>> Total time to complete Offline
>> data collection: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0( =A0623) seconds.
>> Offline data collection
>> capabilities: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7b) SMART ex=
ecute Offline immediate.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Auto Offline data collection
>> on/off support.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Suspend Offline collection upon
>> new command.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Offline surface scan supported.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Self-test supported.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Conveyance Self-test supported.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Selective Self-test supported.
>> SMART capabilities: =A0 =A0 =A0 =A0 =A0 =A0(0x0003) Saves SMART data=
 before entering
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 power-saving mode.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Supports SMART auto save timer.
>> Error logging capability: =A0 =A0 =A0 =A0(0x01) Error logging suppor=
ted.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 General Purpose Logging
>> supported. Short self-test routine
>> recommended polling time: =A0 =A0 =A0 =A0( =A0 1) minutes.
>> Extended self-test routine
>> recommended polling time: =A0 =A0 =A0 =A0( 255) minutes.
>> Conveyance self-test routine
>> recommended polling time: =A0 =A0 =A0 =A0( =A0 2) minutes.
>> SCT capabilities: =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30b7) SCT Status sup=
ported.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 SCT Feature Control supported.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 SCT Data Table supported.
>>
>> SMART Attributes Data Structure revision number: 10
>> Vendor Specific SMART Attributes with Thresholds:
>> ID# ATTRIBUTE_NAME =A0 =A0 =A0 =A0 =A0FLAG =A0 =A0 VALUE WORST THRES=
H TYPE
>> UPDATED =A0WHEN_FAILED RAW_VALUE
>> =A0 1 Raw_Read_Error_Rate =A0 =A0 0x000f =A0 096 =A0 082 =A0 006 =A0=
 =A0Pre-fail
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 2447656
>> =A0 3 Spin_Up_Time =A0 =A0 =A0 =A0 =A0 =A00x0003 =A0 097 =A0 092 =A0=
 000 =A0 =A0Pre-fail
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> =A0 4 Start_Stop_Count =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 020=
 =A0 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 265
>> =A0 5 Reallocated_Sector_Ct =A0 0x0033 =A0 100 =A0 100 =A0 036 =A0 =A0=
Pre-fail
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> =A0 7 Seek_Error_Rate =A0 =A0 =A0 =A0 0x000f =A0 060 =A0 060 =A0 030=
 =A0 =A0Pre-fail
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 1108085
>> =A0 9 Power_On_Hours =A0 =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 0=
00 =A0 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 717
>> =A010 Spin_Retry_Count =A0 =A0 =A0 =A00x0013 =A0 100 =A0 100 =A0 097=
 =A0 =A0Pre-fail
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> =A012 Power_Cycle_Count =A0 =A0 =A0 0x0032 =A0 100 =A0 100 =A0 020 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 74
>> 183 Runtime_Bad_Block =A0 =A0 =A0 0x0032 =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 184 End-to-End_Error =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 099 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 187 Reported_Uncorrect =A0 =A0 =A00x0032 =A0 001 =A0 001 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 792
>> 188 Command_Timeout =A0 =A0 =A0 =A0 0x0032 =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 189 High_Fly_Writes =A0 =A0 =A0 =A0 0x003a =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 190 Airflow_Temperature_Cel 0x0022 =A0 065 =A0 062 =A0 045 =A0 =A0Ol=
d_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 35 (Min/Max 35/35)
>> 191 G-Sense_Error_Rate =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 192 Power-Off_Retract_Count 0x0032 =A0 100 =A0 100 =A0 000 =A0 =A0Ol=
d_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 202
>> 193 Load_Cycle_Count =A0 =A0 =A0 =A00x0032 =A0 100 =A0 100 =A0 000 =A0=
 =A0Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 265
>> 194 Temperature_Celsius =A0 =A0 0x0022 =A0 035 =A0 040 =A0 000 =A0 =A0=
Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 35 (0 19 0 0)
>> 195 Hardware_ECC_Recovered =A00x001a =A0 015 =A0 009 =A0 000 =A0 =A0=
Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 2447656
>> 197 Current_Pending_Sector =A00x0012 =A0 096 =A0 096 =A0 000 =A0 =A0=
Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 368
>> 198 Offline_Uncorrectable =A0 0x0010 =A0 096 =A0 096 =A0 000 =A0 =A0=
Old_age
>> Offline =A0 =A0 =A0- =A0 =A0 =A0 368
>> 199 UDMA_CRC_Error_Count =A0 =A00x003e =A0 200 =A0 200 =A0 000 =A0 =A0=
Old_age
>> Always =A0 =A0 =A0 - =A0 =A0 =A0 0
>> 240 Head_Flying_Hours =A0 =A0 =A0 0x0000 =A0 100 =A0 253 =A0 000 =A0=
 =A0Old_age
>> Offline =A0 =A0 =A0- =A0 =A0 =A0 9354438771404
>> 241 Total_LBAs_Written =A0 =A0 =A00x0000 =A0 100 =A0 253 =A0 000 =A0=
 =A0Old_age
>> Offline =A0 =A0 =A0- =A0 =A0 =A0 793142133
>> 242 Total_LBAs_Read =A0 =A0 =A0 =A0 0x0000 =A0 100 =A0 253 =A0 000 =A0=
 =A0Old_age
>> Offline =A0 =A0 =A0- =A0 =A0 =A0 307847059
>>
>> SMART Error Log Version: 1
>> ATA Error Count: 828 (device log contains only the most recent five
>> errors) CR =3D Command Register [HEX]
>> =A0 =A0 =A0 =A0 FR =3D Features Register [HEX]
>> =A0 =A0 =A0 =A0 SC =3D Sector Count Register [HEX]
>> =A0 =A0 =A0 =A0 SN =3D Sector Number Register [HEX]
>> =A0 =A0 =A0 =A0 CL =3D Cylinder Low Register [HEX]
>> =A0 =A0 =A0 =A0 CH =3D Cylinder High Register [HEX]
>> =A0 =A0 =A0 =A0 DH =3D Device/Head Register [HEX]
>> =A0 =A0 =A0 =A0 DC =3D Device Command Register [HEX]
>> =A0 =A0 =A0 =A0 ER =3D Error register [HEX]
>> =A0 =A0 =A0 =A0 ST =3D Status register [HEX]
>> Powered_Up_Time is measured from power on, and printed as
>> DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
>> SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.
>>
>> Error 828 occurred at disk power-on lifetime: 705 hours (29 days + 9
>> hours) When the command that caused the error occurred, the device w=
as
>> active or idle.
>>
>> =A0 After command completion occurred, registers were:
>> =A0 ER ST SC SN CL CH DH
>> =A0 -- -- -- -- -- -- --
>> =A0 40 51 00 ff ff ff 0f =A0Error: UNC at LBA =3D 0x0fffffff =3D 268=
435455
>>
>> =A0 Commands leading to the command that caused the error were:
>> =A0 CR FR SC SN CL CH DH DC =A0 Powered_Up_Time =A0Command/Feature_N=
ame
>> =A0 -- -- -- -- -- -- -- -- =A0---------------- =A0-----------------=
---
>> =A0 25 00 08 ff ff ff ef 00 =A0 =A0 =A003:44:18.432 =A0READ DMA EXT
>> =A0 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:18.431 =A0READ NATIVE M=
AX ADDRESS EXT
>> =A0 ec 00 00 00 00 00 a0 00 =A0 =A0 =A003:44:18.423 =A0IDENTIFY DEVI=
CE
>> =A0 ef 03 46 00 00 00 a0 00 =A0 =A0 =A003:44:18.391 =A0SET FEATURES =
[Set transfer
>> mode] 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:18.391 =A0READ NATIVE=
 MAX
>> ADDRESS EXT
>>
>> Error 827 occurred at disk power-on lifetime: 705 hours (29 days + 9
>> hours) When the command that caused the error occurred, the device w=
as
>> active or idle.
>>
>> =A0 After command completion occurred, registers were:
>> =A0 ER ST SC SN CL CH DH
>> =A0 -- -- -- -- -- -- --
>> =A0 40 51 00 ff ff ff 0f =A0Error: UNC at LBA =3D 0x0fffffff =3D 268=
435455
>>
>> =A0 Commands leading to the command that caused the error were:
>> =A0 CR FR SC SN CL CH DH DC =A0 Powered_Up_Time =A0Command/Feature_N=
ame
>> =A0 -- -- -- -- -- -- -- -- =A0---------------- =A0-----------------=
---
>> =A0 25 00 08 ff ff ff ef 00 =A0 =A0 =A003:44:15.060 =A0READ DMA EXT
>> =A0 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:15.059 =A0READ NATIVE M=
AX ADDRESS EXT
>> =A0 ec 00 00 00 00 00 a0 00 =A0 =A0 =A003:44:15.051 =A0IDENTIFY DEVI=
CE
>> =A0 ef 03 46 00 00 00 a0 00 =A0 =A0 =A003:44:15.019 =A0SET FEATURES =
[Set transfer
>> mode] 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:15.019 =A0READ NATIVE=
 MAX
>> ADDRESS EXT
>>
>> Error 826 occurred at disk power-on lifetime: 705 hours (29 days + 9
>> hours) When the command that caused the error occurred, the device w=
as
>> active or idle.
>>
>> =A0 After command completion occurred, registers were:
>> =A0 ER ST SC SN CL CH DH
>> =A0 -- -- -- -- -- -- --
>> =A0 40 51 00 ff ff ff 0f =A0Error: UNC at LBA =3D 0x0fffffff =3D 268=
435455
>>
>> =A0 Commands leading to the command that caused the error were:
>> =A0 CR FR SC SN CL CH DH DC =A0 Powered_Up_Time =A0Command/Feature_N=
ame
>> =A0 -- -- -- -- -- -- -- -- =A0---------------- =A0-----------------=
---
>> =A0 25 00 08 ff ff ff ef 00 =A0 =A0 =A003:44:11.687 =A0READ DMA EXT
>> =A0 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:11.686 =A0READ NATIVE M=
AX ADDRESS EXT
>> =A0 ec 00 00 00 00 00 a0 00 =A0 =A0 =A003:44:11.662 =A0IDENTIFY DEVI=
CE
>> =A0 ef 03 46 00 00 00 a0 00 =A0 =A0 =A003:44:11.566 =A0SET FEATURES =
[Set transfer
>> mode] 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:11.566 =A0READ NATIVE=
 MAX
>> ADDRESS EXT
>>
>> Error 825 occurred at disk power-on lifetime: 705 hours (29 days + 9
>> hours) When the command that caused the error occurred, the device w=
as
>> active or idle.
>>
>> =A0 After command completion occurred, registers were:
>> =A0 ER ST SC SN CL CH DH
>> =A0 -- -- -- -- -- -- --
>> =A0 40 51 00 ff ff ff 0f =A0Error: UNC at LBA =3D 0x0fffffff =3D 268=
435455
>>
>> =A0 Commands leading to the command that caused the error were:
>> =A0 CR FR SC SN CL CH DH DC =A0 Powered_Up_Time =A0Command/Feature_N=
ame
>> =A0 -- -- -- -- -- -- -- -- =A0---------------- =A0-----------------=
---
>> =A0 25 00 08 ff ff ff ef 00 =A0 =A0 =A003:44:08.323 =A0READ DMA EXT
>> =A0 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:08.322 =A0READ NATIVE M=
AX ADDRESS EXT
>> =A0 ec 00 00 00 00 00 a0 00 =A0 =A0 =A003:44:08.314 =A0IDENTIFY DEVI=
CE
>> =A0 ef 03 46 00 00 00 a0 00 =A0 =A0 =A003:44:08.282 =A0SET FEATURES =
[Set transfer
>> mode] 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:08.282 =A0READ NATIVE=
 MAX
>> ADDRESS EXT
>>
>> Error 824 occurred at disk power-on lifetime: 705 hours (29 days + 9
>> hours) When the command that caused the error occurred, the device w=
as
>> active or idle.
>>
>> =A0 After command completion occurred, registers were:
>> =A0 ER ST SC SN CL CH DH
>> =A0 -- -- -- -- -- -- --
>> =A0 40 51 00 ff ff ff 0f =A0Error: UNC at LBA =3D 0x0fffffff =3D 268=
435455
>>
>> =A0 Commands leading to the command that caused the error were:
>> =A0 CR FR SC SN CL CH DH DC =A0 Powered_Up_Time =A0Command/Feature_N=
ame
>> =A0 -- -- -- -- -- -- -- -- =A0---------------- =A0-----------------=
---
>> =A0 25 00 08 ff ff ff ef 00 =A0 =A0 =A003:44:04.950 =A0READ DMA EXT
>> =A0 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:04.949 =A0READ NATIVE M=
AX ADDRESS EXT
>> =A0 ec 00 00 00 00 00 a0 00 =A0 =A0 =A003:44:04.941 =A0IDENTIFY DEVI=
CE
>> =A0 ef 03 46 00 00 00 a0 00 =A0 =A0 =A003:44:04.910 =A0SET FEATURES =
[Set transfer
>> mode] 27 00 00 00 00 00 e0 00 =A0 =A0 =A003:44:04.909 =A0READ NATIVE=
 MAX
>> ADDRESS EXT
>>
>> SMART Self-test log structure revision number 1
>> No self-tests have been logged. =A0[To run self-tests, use: smartctl=
 -t]
>>
>>
>> SMART Selective self-test log data structure revision number 1
>> =A0SPAN =A0MIN_LBA =A0MAX_LBA =A0CURRENT_TEST_STATUS
>> =A0 =A0 1 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 =A0Not_testing
>> =A0 =A0 2 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 =A0Not_testing
>> =A0 =A0 3 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 =A0Not_testing
>> =A0 =A0 4 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 =A0Not_testing
>> =A0 =A0 5 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 =A0Not_testing
>> Selective self-test flags (0x0):
>> =A0 After scanning selected spans, do NOT read-scan remainder of dis=
k.
>> If Selective self-test is pending on power-up, resume after 0 minute
>> delay.
>
> I might run the selftest (long) to get a better idea, but if there is=
 not a
> firmware update for this drive on the Seagate site, I believe I'd be =
asking
> for an RA forthwith.
>
> Be aware that I just updated 2 identical 1 terrabyte Seagate drives a=
bout 3
> weeks ago, and the firmware update, while it did not scramble tha par=
tition
> table data, did scramble the partition labels AND the blkid's of the =
boot
> drive only. =A0The second drive no longer is hanging the system with =
bus
> resets, but it still has a write speed of about 3.5 megs/second. =A0I=
 had to
> re-install. =A0Fortunately I had data backups from the night before c=
ourtesy
> amanda.
>
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
> =A0soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> <http://tinyurl.com/ddg5bz>
> <http://www.cantrip.org/gatto.html>
> Row, row, row your bits, gently down the stream...
>

Hi, thanks for the reply.

Here is my reply, below :)

This is the output of smartctl -t long /dev/sdb and smartctl -l
selftest /dev/sdb. I hope that was the correct procedure.

# smartctl -t long /dev/sdb
smartctl 5.41 2011-03-16 r3296
[x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
Copyright (C) 2002-11 by Bruce Allen, http://smartmontools.sourceforge.=
net

=3D=3D=3D START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION =3D=3D=3D
Sending command: "Execute SMART Extended self-test routine immediately
in off-line mode".
Drive command "Execute SMART Extended self-test routine immediately in
off-line mode" successful.
Testing has begun.
Please wait 255 minutes for test to complete.
Test will complete after Sat Apr 30 23:06:43 2011

Use smartctl -X to abort test.

# smartctl -l selftest /dev/sdb
smartctl 5.41 2011-03-16 r3296
[x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
Copyright (C) 2002-11 by Bruce Allen, http://smartmontools.sourceforge.=
net

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed: read failure       90%       723
      469696848



Thanks for any interpretation of this.
