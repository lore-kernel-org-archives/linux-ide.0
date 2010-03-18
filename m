From: Al Bogner <suse-linux@ml082.pinguin.uni.cc>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 18 Mar 2010 17:15:59 +0100
Message-ID: <201003181716.00173.suse-linux@ml082.pinguin.uni.cc>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B9D0772.4080306@teksavvy.com> <4B9D7924.1020908@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailbackup.inode.at ([213.229.60.24]:39906 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0CRSXJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 14:23:09 -0400
In-Reply-To: <4B9D7924.1020908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

Am Montag 15 M=C3=A4rz 2010 01:02:44 schrieb Tejun Heo:
> Hello,
>=20
> On 03/15/2010 12:57 AM, Mark Lord wrote:
> > No.  The vendor-unique commands appear to download a small firmware
> > packet to the drive, which reprograms it for a longer "IDLE-3" time=
out.
> >
> > "IDLE-3" is what WD call this vendor-specific "powersaving" mode,
> > and it is not intended to be adjustable.  Except via that little
> > DOS utility hack, and even WD no longer make that available.
> >
> > But I found it by googling for it, and it can change the timeout
> > up to 30 seconds from the default of 8.  So I set my WD 1.5TB drive
> > to use 30, and things are now acceptable.
> >
> > Ugh (again)!
>=20
> I'm currently talking with WD but in general I'm leaning toward simpl=
y
> leaving it alone.  The manufacturer is actively preventing those
> timesouts from being adjusted and they probably have a pretty good
> rationale for that.  If those drives expire before their warrnty, it'=
s
> a matter between the customer and the vendor.  I really don't see muc=
h
> point in trying to circumvent it.  Anyways, I'll let you guys know
> where the conversation w/ WDC leads to.

WD said to me I can send them the disk, but didn't accept, that this is=
 a=20
firmware bug.

Today I got a brandnew WD20EARS (2TB) and it is the same. After about a=
n 1/2=20
hr. I had 12 cycles with an _un_formatted disk.

I cannot accept, that it should be a warranty issue, because this reduc=
es the=20
lifetime _after_ the warranty and increases the possibility to loose da=
ta, at=20
least for those who don't use a raid.

I would be happy to have a native linux utility to change this.


Device Model:     WDC WD20EARS-00S8B1
=46irmware Version: 80.00A80
User Capacity:    2.000.398.934.016 bytes

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDAT=
ED =20
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   100   253   051    Pre-fail  Alway=
s      =20
-       0
  3 Spin_Up_Time            0x0027   100   253   021    Pre-fail  Alway=
s      =20
-       0
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Alway=
s      =20
-       4
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Alway=
s      =20
-       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age   Alway=
s      =20
-       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Alway=
s      =20
-       0
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s      =20
-       3
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Alway=
s      =20
-       2
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Alway=
s      =20
-       12
194 Temperature_Celsius     0x0022   116   116   000    Old_age   Alway=
s      =20
-       36
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Alway=
s      =20
-       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Alway=
s      =20
-       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age   Offli=
ne      -      =20
0
199 UDMA_CRC_Error_Count    0x0032   200   253   000    Old_age   Alway=
s      =20
-       0
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age   Offli=
ne      -      =20
0



Al
