From: gene heskett <gheskett@wdtv.com>
Subject: Re: Seagate hard disk firmware issue
Date: Sun, 1 May 2011 13:18:02 -0400
Message-ID: <201105011318.02160.gheskett@wdtv.com>
References: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com> <201104300808.59185.gheskett@wdtv.com> <BANLkTimxqcuhFEt-F0R3qkQ6fqTQH8iiXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wdtv.com ([66.118.69.84]:33566 "EHLO mail.wdtv.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab1EARSH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 May 2011 13:18:07 -0400
In-Reply-To: <BANLkTimxqcuhFEt-F0R3qkQ6fqTQH8iiXg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: BU66ER BAD6ER <debu66er@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sunday, May 01, 2011 01:16:34 PM BU66ER BAD6ER did opine:

> On Sat, Apr 30, 2011 at 2:08 PM, gene heskett <gheskett@wdtv.com> wro=
te:
> > On Saturday, April 30, 2011 07:56:21 AM BU66ER BAD6ER did opine:
> > This <linux-ide@vger.kernel.org> is a mailing list. =EF=BF=BDWTH wh=
en I click
> > on reply-to-list, do I always have to copy/paste the lists address =
in
> > the To: line? =EF=BF=BDfscking PIMA!
> >=20
> > More below, where it should be.
> >=20
> >> Hi,
> >>=20
> >> Some time ago, I returned my hard disk and got a new one. Lately, =
I'm
> >> having performance issues again and I suspect there is a hardware
> >> error again like last time. If you could confirm this I would be m=
ost
> >> grateful.
> >>=20
> >> Thanks in advance!
> >>=20
> >> # smartctl -a /dev/sdb
> >> smartctl 5.41 2011-03-16 r3296
> >> [x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
> >> Copyright (C) 2002-11 by Bruce Allen,
> >> http://smartmontools.sourceforge.net
> >>=20
> >> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> >> Device Model: =EF=BF=BD =EF=BF=BD ST2000DL003-9VT166
> >> Serial Number: =EF=BF=BD =EF=BF=BD5YD1YD5P
> >> Firmware Version: CC32
> >> User Capacity: =EF=BF=BD =EF=BF=BD2,000,398,934,016 bytes
> >> Device is: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDNot in smartctl =
database [for details use: -P
> >> showall] ATA Version is: =EF=BF=BD 8
> >> ATA Standard is: =EF=BF=BDATA-8-ACS revision 4
> >> Local Time is: =EF=BF=BD =EF=BF=BDSat Apr 30 12:59:32 2011 CEST
> >> SMART support is: Available - device has SMART capability.
> >> SMART support is: Enabled
> >>=20
> >> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> >> SMART overall-health self-assessment test result: PASSED
> >>=20
> >> General SMART Values:
> >> Offline data collection status: =EF=BF=BD(0x82) Offline data colle=
ction
> >> activity =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD w=
as completed
> >> without error. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 Auto Offline
> >> Data Collection: Enabled. Self-test execution status: =EF=BF=BD =EF=
=BF=BD =EF=BF=BD( =EF=BF=BD 0)
> >> The previous self-test routine completed without error or no
> >> self-test has ever been run. Total time to complete Offline
> >> data collection: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD( =EF=BF=BD623) seconds.
> >> Offline data collection
> >> capabilities: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD(0x7b) SMART execute Offl=
ine
> >> immediate. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
Auto Offline data
> >> collection on/off support.
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD Suspend Of=
fline collection
> >> upon new command.
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD Offline su=
rface scan
> >> supported. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
Self-test
> >> supported. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
Conveyance
> >> Self-test supported. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
=EF=BF=BD
> >> Selective Self-test supported. SMART capabilities: =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD
> >> =EF=BF=BD(0x0003) Saves SMART data before entering =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD power-saving mode.
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD Supports S=
MART auto save
> >> timer. Error logging capability: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD(0x01) Error logging
> >> supported. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
General Purpose
> >> Logging supported. Short self-test routine
> >> recommended polling time: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD(=
 =EF=BF=BD 1) minutes.
> >> Extended self-test routine
> >> recommended polling time: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD(=
 255) minutes.
> >> Conveyance self-test routine
> >> recommended polling time: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD(=
 =EF=BF=BD 2) minutes.
> >> SCT capabilities: =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD(0x30b7) SCT Status supported.
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD SCT Featur=
e Control
> >> supported. =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=
=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =
SCT Data Table
> >> supported.
> >>=20
> >> SMART Attributes Data Structure revision number: 10
> >> Vendor Specific SMART Attributes with Thresholds:
> >> ID# ATTRIBUTE_NAME =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
=46LAG =EF=BF=BD =EF=BF=BD VALUE WORST THRESH TYPE
> >> UPDATED =EF=BF=BDWHEN_FAILED RAW_VALUE
> >> =EF=BF=BD 1 Raw_Read_Error_Rate =EF=BF=BD =EF=BF=BD 0x000f =EF=BF=BD=
 096 =EF=BF=BD 082 =EF=BF=BD 006 =EF=BF=BD =EF=BF=BDPre-fail
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 2447656
> >> =EF=BF=BD 3 Spin_Up_Time =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=
=BF=BD =EF=BF=BD0x0003 =EF=BF=BD 097 =EF=BF=BD 092 =EF=BF=BD 000 =EF=BF=
=BD =EF=BF=BDPre-fail
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> =EF=BF=BD 4 Start_Stop_Count =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
0x0032 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 020 =EF=BF=BD =EF=BF=BDOld=
_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 265
> >> =EF=BF=BD 5 Reallocated_Sector_Ct =EF=BF=BD 0x0033 =EF=BF=BD 100 =EF=
=BF=BD 100 =EF=BF=BD 036 =EF=BF=BD =EF=BF=BDPre-fail
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> =EF=BF=BD 7 Seek_Error_Rate =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0x000f =EF=BF=BD 060 =EF=BF=BD 060 =EF=BF=BD 030 =EF=BF=BD =EF=BF=BDPr=
e-fail
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 1108085
> >> =EF=BF=BD 9 Power_On_Hours =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 =EF=BF=BD0x0032 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=
=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 717
> >> =EF=BF=BD10 Spin_Retry_Count =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD=
0x0013 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 097 =EF=BF=BD =EF=BF=BDPre=
-fail
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> =EF=BF=BD12 Power_Cycle_Count =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x0032=
 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 020 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 74
> >> 183 Runtime_Bad_Block =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x0032 =EF=BF=BD=
 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 184 End-to-End_Error =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0x0032=
 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 099 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 187 Reported_Uncorrect =EF=BF=BD =EF=BF=BD =EF=BF=BD0x0032 =EF=BF=BD=
 001 =EF=BF=BD 001 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 792
> >> 188 Command_Timeout =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x0032=
 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 189 High_Fly_Writes =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x003a=
 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 190 Airflow_Temperature_Cel 0x0022 =EF=BF=BD 065 =EF=BF=BD 062 =EF=
=BF=BD 045 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 35 (Min/Max 35/35)
> >> 191 G-Sense_Error_Rate =EF=BF=BD =EF=BF=BD =EF=BF=BD0x0032 =EF=BF=BD=
 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 192 Power-Off_Retract_Count 0x0032 =EF=BF=BD 100 =EF=BF=BD 100 =EF=
=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 202
> >> 193 Load_Cycle_Count =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0x0032=
 =EF=BF=BD 100 =EF=BF=BD 100 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 265
> >> 194 Temperature_Celsius =EF=BF=BD =EF=BF=BD 0x0022 =EF=BF=BD 035 =EF=
=BF=BD 040 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 35 (0 19 0 0)
> >> 195 Hardware_ECC_Recovered =EF=BF=BD0x001a =EF=BF=BD 015 =EF=BF=BD=
 009 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 2447656
> >> 197 Current_Pending_Sector =EF=BF=BD0x0012 =EF=BF=BD 096 =EF=BF=BD=
 096 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 368
> >> 198 Offline_Uncorrectable =EF=BF=BD 0x0010 =EF=BF=BD 096 =EF=BF=BD=
 096 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Offline =EF=BF=BD =EF=BF=BD =EF=BF=BD- =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 368
> >> 199 UDMA_CRC_Error_Count =EF=BF=BD =EF=BF=BD0x003e =EF=BF=BD 200 =EF=
=BF=BD 200 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Always =EF=BF=BD =EF=BF=BD =EF=BF=BD - =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 0
> >> 240 Head_Flying_Hours =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x0000 =EF=BF=BD=
 100 =EF=BF=BD 253 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Offline =EF=BF=BD =EF=BF=BD =EF=BF=BD- =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 9354438771404
> >> 241 Total_LBAs_Written =EF=BF=BD =EF=BF=BD =EF=BF=BD0x0000 =EF=BF=BD=
 100 =EF=BF=BD 253 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Offline =EF=BF=BD =EF=BF=BD =EF=BF=BD- =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 793142133
> >> 242 Total_LBAs_Read =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD 0x0000=
 =EF=BF=BD 100 =EF=BF=BD 253 =EF=BF=BD 000 =EF=BF=BD =EF=BF=BDOld_age
> >> Offline =EF=BF=BD =EF=BF=BD =EF=BF=BD- =EF=BF=BD =EF=BF=BD =EF=BF=BD=
 307847059
> >>=20
> >> SMART Error Log Version: 1
> >> ATA Error Count: 828 (device log contains only the most recent fiv=
e
> >> errors) CR =3D Command Register [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD FR =3D Features Register [=
HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD SC =3D Sector Count Regist=
er [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD SN =3D Sector Number Regis=
ter [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD CL =3D Cylinder Low Regist=
er [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD CH =3D Cylinder High Regis=
ter [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD DH =3D Device/Head Registe=
r [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD DC =3D Device Command Regi=
ster [HEX]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD ER =3D Error register [HEX=
]
> >> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD ST =3D Status register [HE=
X]
> >> Powered_Up_Time is measured from power on, and printed as
> >> DDd+hh:mm:SS.sss where DD=3Ddays, hh=3Dhours, mm=3Dminutes,
> >> SS=3Dsec, and sss=3Dmillisec. It "wraps" after 49.710 days.
> >>=20
> >> Error 828 occurred at disk power-on lifetime: 705 hours (29 days +=
 9
> >> hours) When the command that caused the error occurred, the device
> >> was active or idle.
> >>=20
> >> =EF=BF=BD After command completion occurred, registers were:
> >> =EF=BF=BD ER ST SC SN CL CH DH
> >> =EF=BF=BD -- -- -- -- -- -- --
> >> =EF=BF=BD 40 51 00 ff ff ff 0f =EF=BF=BDError: UNC at LBA =3D 0x0f=
ffffff =3D 268435455
> >>=20
> >> =EF=BF=BD Commands leading to the command that caused the error we=
re:
> >> =EF=BF=BD CR FR SC SN CL CH DH DC =EF=BF=BD Powered_Up_Time =EF=BF=
=BDCommand/Feature_Name
> >> =EF=BF=BD -- -- -- -- -- -- -- -- =EF=BF=BD---------------- =EF=BF=
=BD--------------------
> >> =EF=BF=BD 25 00 08 ff ff ff ef 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:18.432 =EF=BF=BDREAD DMA EXT
> >> =EF=BF=BD 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:18.431 =EF=BF=BDREAD NATIVE MAX ADDRESS
> >> EXT =EF=BF=BD ec 00 00 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:18.423 =EF=BF=BDIDENTIFY DEVICE =EF=BF=BD
> >> ef 03 46 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:44:18.391 =
=EF=BF=BDSET FEATURES [Set
> >> transfer mode] 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:18.391 =EF=BF=BDREAD
> >> NATIVE MAX ADDRESS EXT
> >>=20
> >> Error 827 occurred at disk power-on lifetime: 705 hours (29 days +=
 9
> >> hours) When the command that caused the error occurred, the device
> >> was active or idle.
> >>=20
> >> =EF=BF=BD After command completion occurred, registers were:
> >> =EF=BF=BD ER ST SC SN CL CH DH
> >> =EF=BF=BD -- -- -- -- -- -- --
> >> =EF=BF=BD 40 51 00 ff ff ff 0f =EF=BF=BDError: UNC at LBA =3D 0x0f=
ffffff =3D 268435455
> >>=20
> >> =EF=BF=BD Commands leading to the command that caused the error we=
re:
> >> =EF=BF=BD CR FR SC SN CL CH DH DC =EF=BF=BD Powered_Up_Time =EF=BF=
=BDCommand/Feature_Name
> >> =EF=BF=BD -- -- -- -- -- -- -- -- =EF=BF=BD---------------- =EF=BF=
=BD--------------------
> >> =EF=BF=BD 25 00 08 ff ff ff ef 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:15.060 =EF=BF=BDREAD DMA EXT
> >> =EF=BF=BD 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:15.059 =EF=BF=BDREAD NATIVE MAX ADDRESS
> >> EXT =EF=BF=BD ec 00 00 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:15.051 =EF=BF=BDIDENTIFY DEVICE =EF=BF=BD
> >> ef 03 46 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:44:15.019 =
=EF=BF=BDSET FEATURES [Set
> >> transfer mode] 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:15.019 =EF=BF=BDREAD
> >> NATIVE MAX ADDRESS EXT
> >>=20
> >> Error 826 occurred at disk power-on lifetime: 705 hours (29 days +=
 9
> >> hours) When the command that caused the error occurred, the device
> >> was active or idle.
> >>=20
> >> =EF=BF=BD After command completion occurred, registers were:
> >> =EF=BF=BD ER ST SC SN CL CH DH
> >> =EF=BF=BD -- -- -- -- -- -- --
> >> =EF=BF=BD 40 51 00 ff ff ff 0f =EF=BF=BDError: UNC at LBA =3D 0x0f=
ffffff =3D 268435455
> >>=20
> >> =EF=BF=BD Commands leading to the command that caused the error we=
re:
> >> =EF=BF=BD CR FR SC SN CL CH DH DC =EF=BF=BD Powered_Up_Time =EF=BF=
=BDCommand/Feature_Name
> >> =EF=BF=BD -- -- -- -- -- -- -- -- =EF=BF=BD---------------- =EF=BF=
=BD--------------------
> >> =EF=BF=BD 25 00 08 ff ff ff ef 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:11.687 =EF=BF=BDREAD DMA EXT
> >> =EF=BF=BD 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:11.686 =EF=BF=BDREAD NATIVE MAX ADDRESS
> >> EXT =EF=BF=BD ec 00 00 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:11.662 =EF=BF=BDIDENTIFY DEVICE =EF=BF=BD
> >> ef 03 46 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:44:11.566 =
=EF=BF=BDSET FEATURES [Set
> >> transfer mode] 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:11.566 =EF=BF=BDREAD
> >> NATIVE MAX ADDRESS EXT
> >>=20
> >> Error 825 occurred at disk power-on lifetime: 705 hours (29 days +=
 9
> >> hours) When the command that caused the error occurred, the device
> >> was active or idle.
> >>=20
> >> =EF=BF=BD After command completion occurred, registers were:
> >> =EF=BF=BD ER ST SC SN CL CH DH
> >> =EF=BF=BD -- -- -- -- -- -- --
> >> =EF=BF=BD 40 51 00 ff ff ff 0f =EF=BF=BDError: UNC at LBA =3D 0x0f=
ffffff =3D 268435455
> >>=20
> >> =EF=BF=BD Commands leading to the command that caused the error we=
re:
> >> =EF=BF=BD CR FR SC SN CL CH DH DC =EF=BF=BD Powered_Up_Time =EF=BF=
=BDCommand/Feature_Name
> >> =EF=BF=BD -- -- -- -- -- -- -- -- =EF=BF=BD---------------- =EF=BF=
=BD--------------------
> >> =EF=BF=BD 25 00 08 ff ff ff ef 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:08.323 =EF=BF=BDREAD DMA EXT
> >> =EF=BF=BD 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:08.322 =EF=BF=BDREAD NATIVE MAX ADDRESS
> >> EXT =EF=BF=BD ec 00 00 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:08.314 =EF=BF=BDIDENTIFY DEVICE =EF=BF=BD
> >> ef 03 46 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:44:08.282 =
=EF=BF=BDSET FEATURES [Set
> >> transfer mode] 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:08.282 =EF=BF=BDREAD
> >> NATIVE MAX ADDRESS EXT
> >>=20
> >> Error 824 occurred at disk power-on lifetime: 705 hours (29 days +=
 9
> >> hours) When the command that caused the error occurred, the device
> >> was active or idle.
> >>=20
> >> =EF=BF=BD After command completion occurred, registers were:
> >> =EF=BF=BD ER ST SC SN CL CH DH
> >> =EF=BF=BD -- -- -- -- -- -- --
> >> =EF=BF=BD 40 51 00 ff ff ff 0f =EF=BF=BDError: UNC at LBA =3D 0x0f=
ffffff =3D 268435455
> >>=20
> >> =EF=BF=BD Commands leading to the command that caused the error we=
re:
> >> =EF=BF=BD CR FR SC SN CL CH DH DC =EF=BF=BD Powered_Up_Time =EF=BF=
=BDCommand/Feature_Name
> >> =EF=BF=BD -- -- -- -- -- -- -- -- =EF=BF=BD---------------- =EF=BF=
=BD--------------------
> >> =EF=BF=BD 25 00 08 ff ff ff ef 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:04.950 =EF=BF=BDREAD DMA EXT
> >> =EF=BF=BD 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:=
44:04.949 =EF=BF=BDREAD NATIVE MAX ADDRESS
> >> EXT =EF=BF=BD ec 00 00 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:04.941 =EF=BF=BDIDENTIFY DEVICE =EF=BF=BD
> >> ef 03 46 00 00 00 a0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD03:44:04.910 =
=EF=BF=BDSET FEATURES [Set
> >> transfer mode] 27 00 00 00 00 00 e0 00 =EF=BF=BD =EF=BF=BD =EF=BF=BD=
03:44:04.909 =EF=BF=BDREAD
> >> NATIVE MAX ADDRESS EXT
> >>=20
> >> SMART Self-test log structure revision number 1
> >> No self-tests have been logged. =EF=BF=BD[To run self-tests, use: =
smartctl
> >> -t]
> >>=20
> >>=20
> >> SMART Selective self-test log data structure revision number 1
> >> =EF=BF=BDSPAN =EF=BF=BDMIN_LBA =EF=BF=BDMAX_LBA =EF=BF=BDCURRENT_T=
EST_STATUS
> >> =EF=BF=BD =EF=BF=BD 1 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=BF=BDNot_testing
> >> =EF=BF=BD =EF=BF=BD 2 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=BF=BDNot_testing
> >> =EF=BF=BD =EF=BF=BD 3 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=BF=BDNot_testing
> >> =EF=BF=BD =EF=BF=BD 4 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=BF=BDNot_testing
> >> =EF=BF=BD =EF=BF=BD 5 =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=
=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD0 =EF=BF=BDNot_testing
> >> Selective self-test flags (0x0):
> >> =EF=BF=BD After scanning selected spans, do NOT read-scan remainde=
r of disk.
> >> If Selective self-test is pending on power-up, resume after 0 minu=
te
> >> delay.
> >=20
> > I might run the selftest (long) to get a better idea, but if there =
is
> > not a firmware update for this drive on the Seagate site, I believe
> > I'd be asking for an RA forthwith.
> >=20
> > Be aware that I just updated 2 identical 1 terrabyte Seagate drives
> > about 3 weeks ago, and the firmware update, while it did not scramb=
le
> > tha partition table data, did scramble the partition labels AND the
> > blkid's of the boot drive only. =EF=BF=BDThe second drive no longer=
 is
> > hanging the system with bus resets, but it still has a write speed =
of
> > about 3.5 megs/second. =EF=BF=BDI had to re-install. =EF=BF=BDFortu=
nately I had data
> > backups from the night before courtesy amanda.
> >=20
> > --
> > Cheers, Gene
> > "There are four boxes to be used in defense of liberty:
> > =EF=BF=BDsoap, ballot, jury, and ammo. Please use in that order."
> > -Ed Howdershelt (Author)
> > <http://tinyurl.com/ddg5bz>
> > <http://www.cantrip.org/gatto.html>
> > Row, row, row your bits, gently down the stream...
>=20
> Hi, thanks for the reply.
>=20
> Here is my reply, below :)
>=20
> This is the output of smartctl -t long /dev/sdb and smartctl -l
> selftest /dev/sdb. I hope that was the correct procedure.
>=20
> # smartctl -t long /dev/sdb
> smartctl 5.41 2011-03-16 r3296
> [x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
> Copyright (C) 2002-11 by Bruce Allen,
> http://smartmontools.sourceforge.net
>=20
> =3D=3D=3D START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION =3D=3D=3D
> Sending command: "Execute SMART Extended self-test routine immediatel=
y
> in off-line mode".
> Drive command "Execute SMART Extended self-test routine immediately i=
n
> off-line mode" successful.
> Testing has begun.
> Please wait 255 minutes for test to complete.
> Test will complete after Sat Apr 30 23:06:43 2011
>=20
> Use smartctl -X to abort test.
>=20
> # smartctl -l selftest /dev/sdb
> smartctl 5.41 2011-03-16 r3296
> [x86_64-unknown-linux-gnu-2.6.38-2-amd64] (local build)
> Copyright (C) 2002-11 by Bruce Allen,
> http://smartmontools.sourceforge.net
>=20
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART Self-test log structure revision number 1
> Num  Test_Description    Status                  Remaining
> LifeTime(hours)  LBA_of_first_error
> # 1  Extended offline    Completed: read failure       90%       723
>       469696848
>=20
>=20
>=20
> Thanks for any interpretation of this.

Get the RA, a 2Tb drive should still be well in warranty.

--=20
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
<http://tinyurl.com/ddg5bz>
<http://www.cantrip.org/gatto.html>
<Wordplay> You measure your vibrators in "characters per second"?  I ha=
ve
	   bad news for you, c90, you've been masturbating with a
	   dot-matrix printer.
