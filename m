From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Thu, 23 Feb 2006 11:07:49 +0900
Message-ID: <43FD18F5.20002@gmail.com>
References: <loom.20060222T182150-518@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:20778 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750754AbWBWCGp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 21:06:45 -0500
Received: by pproxy.gmail.com with SMTP id i75so1899092pye
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 18:06:43 -0800 (PST)
In-Reply-To: <loom.20060222T182150-518@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?Sm9uIEvDpXJlIEhlbGxhbg==?= <hellan@acm.org>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jon K=C3=A5re Hellan wrote:
> My Shuttle SN85G4V2 with Silicon Image 3512 SATA controller has been =
locking up
> frequently for a while. Console message:
>=20
> ata1: command 0x35 timeout, stat 0x58 host_stat 0x61
> ata1: status=3D0x58 { DriveReady SeekComplete DataRequest }
> sd 0:0:0:0: SCSI error: return code =3D 0x8000002
> sda: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> end_request: I/O error, dev sda, sector 57582833
> Buffer I/O error on device sda6, logical block 3097255
> lost page write due to I/O error on sda6
> ATA: abnormal status 0x58 on port 0xF8802087
> ATA: abnormal status 0x58 on port 0xF8802087
>=20
> I have a Seagate ST3200822AS disk, which is on the blacklist in sata_=
sil.
> In sil_pci_tbl in drivers/sata/sata_sil.c, I changed 3512 from sil_31=
12 to
> sil_3112_m15w, enabling SIL_QUIRK_MOD15WRITE for my controller. With =
this, the
> lockups are gone.
>=20
> Looks like MOD15WRITE was turned off for the 3512 between 2.6.13 and =
2.6.14.
> This may have been a mistake, or else my system is unusually flaky.=20
>=20

Hello, Jon K=C3=A5re.

The m15w workaround is an extreme solution and tends to hide whatever=20
bug/errata whether the problem actually is m15w or not. Unfortunately,=20
in the past, we didn't have enough errata information and thus the m15w=
=20
blacklist kept growing (oh... something wrong with Seagate drives? It=20
must be m15w!).

Recently, Silicon Image has opened all the erratas and we're in the=20
process of getting things done correctly. New errata workarounds are=20
being implemented and devices not really affected by m15w are delisted,=
=20
etc... And, unfortunately, due to insufficient information, turning off=
=20
m15w for 3512 and 3114 was done before addind other needed workarounds=20
causing problems for 3512 and 3114 users.

According to the errata information from Silicon Image, SiI3512 does no=
t=20
have m15w bug, neither does ST3200822AS. So, this must be something els=
e=20
and you're not an isolated case. One of my friends reported the same=20
problem but I currently can't test it as he sold his motherboard=20
*really* fast. :-( So, it would be very nice if you can test fixes we'l=
l=20
be able to come up with.

Carlos (Hi!), 3512 + some 7200.7 hangs. Can you think of any related er=
rata?

Thanks.

--=20
tejun
