From: Al Bogner <suse-linux@ml082.pinguin.uni.cc>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Tue, 9 Mar 2010 11:34:32 +0100
Message-ID: <201003091134.32731.suse-linux@ml082.pinguin.uni.cc>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc> <4B96013F.1050904@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailbackup.inode.at ([213.229.60.24]:44987 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0CIKfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 05:35:50 -0500
In-Reply-To: <4B96013F.1050904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Am Dienstag 09 M=E4rz 2010 09:05:19 schrieb Tejun Heo:
> Hello,
>=20
> Sorry about very late reply.
>=20
> On 02/09/2010 03:33 AM, Al Bogner wrote:
> > I append info of an 1.5 TB WD Caviar green drive with a lot of star=
t/stop
> > cycles. I would like to mention, that I have 4 1 TB Caviar green
> > (WD10EADS) which work fine!
> >
> > The e-SATA drive is used with this machine:
> > http://www.smolts.org/client/show/pub_b214fce2-b5b5-4a32-ba7e-cf9de=
6d5575
> >7 but has problems with other machines too.
> >
> > I use Openesuse 11.1
> > Kernel 2.6.27.42-0.1-default
> > FANTEC Fanbox FB-35US2 (probably JMicron 20360/20363 AHCI Controlle=
r)
> > storage-fixup-0.2-25.3 is installed, but not especially configured
> >
> > If you need more info let me know.
>=20
> How fast does it increase?  ie. counts / hour.

Hi,

I can't give you exact values. It depends how busy the drive is. If the=
 drivec=20
is busy the drive has less spindowns.


Device Model:     WDC WD15EARS-00Z5B1
=46irmware Version: 80.00A80



9 Power_On_Hours          0x0032   100   100   000    Old_age   Always =
     =20
-       11
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s      =20
-       4
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Alway=
s      =20
-       127




ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDAT=
ED =20
WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail  Alway=
s      =20
-       0
  3 Spin_Up_Time            0x0027   219   219   021    Pre-fail  Alway=
s      =20
-       4025
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Alway=
s      =20
-       6
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Alway=
s      =20
-       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age   Alway=
s      =20
-       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Alway=
s      =20
-       31
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s      =20
-       5
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Alway=
s      =20
-       2
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Alway=
s      =20
-       644
194 Temperature_Celsius     0x0022   116   113   000    Old_age   Alway=
s      =20
-       34
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Alway=
s      =20
-       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Alway=
s      =20
-       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age   Offli=
ne     =20
-       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Alway=
s      =20
-       0
200 Multi_Zone_Error_Rate   0x0008   200   200   000    Old_age   Offli=
ne     =20
-       0




 9 Power_On_Hours          0x0032   100   100   000    Old_age   Always=
      =20
-       34
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s      =20
-       5
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Alway=
s      =20
-       655




Since I used wdidle3 and switched to no spindown (62 min) it looks like=
 this:


  9 Power_On_Hours          0x0032   100   100   000    Old_age   Alway=
s      =20
-       383
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Alway=
s      =20
-       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Alway=
s      =20
-       26
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Alway=
s      =20
-       4
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Alway=
s      =20
-       819

Al
