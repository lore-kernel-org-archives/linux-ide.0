From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Sun, 29 Oct 2006 21:31:06 +0000
Message-ID: <20061029213106.GA25865@deepthought.linux.bogus>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.103.221.47] ([81.103.221.47]:63414 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030341AbWJ2Vbc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Oct 2006 16:31:32 -0500
Content-Disposition: inline
In-Reply-To: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sun, Oct 29, 2006 at 08:20:17PM +0100, Gregor Jasny wrote:
> Hi,
>=20
> Today I tried the new cdparanoia from Debian Sid (3.10+debian~pre0-2)=
=2E
> When I started ripping with "cdparanoia -d /dev/scd0 1" my system
> freezes after some seconds. There is no oops and even the console
> cursor stops blinking.
>=20
> If I start cdparanoia with -g /dev/scd0 it starts ripping and but the
> kernel prints many "program cdparanoia not setting count and/or
> reply_len properly" warnings. But this seems to be a cdparanoia bug.
>=20
> My CDROM:
> Vendor:                    PIONEER
> Product:                   DVD-ROM DVD-106
> Revision level:            1.22
>=20
 I'm guessing this is really an IDE drive ?  If so, I suspect the
problem is in scsi emulation (which doesn't deny that the bug might
be at least partly in the application, although hanging the box is
nasty).

 Specifically, I've just compiled that version with the debian patch
on my (non-debian) amd64 and successfully ripped a CD (without any
log messages) on both 2.6.18 and 2.6.19-rc3 using /dev/hdc.

 So, if this isn't a real SCSI drive, as a work-around you could try
disabling ide-scsi and use the IDE device name.

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
