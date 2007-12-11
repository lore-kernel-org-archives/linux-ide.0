From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: SATA drive keeps hard resetting
Date: Tue, 11 Dec 2007 12:50:09 +0300
Message-ID: <475E5D51.8010902@msgid.tls.msk.ru>
References: <475E08FC.9010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:24475 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXLKJuM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Dec 2007 04:50:12 -0500
In-Reply-To: <475E08FC.9010809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org

Mat=ED=ADas Alejandro Torres wrote:
> Hi all,
>=20
> I have a SATA drive in a motherboard with an ATI SB600 chipset that
> until now worked just fine.
> The disk seems fine but after a while it start making noises (like
> spinning up) and the computer freezes during 2 or 3 seconds. I think =
my
> SATA drive is broken, or maybe the motherboard. This is what dmesg sa=
ys:
>=20
> [  229.096000] ata4: exception Emask 0x10 SAct 0x0 SErr 0x90200 actio=
n 0x6 frozen

See http://marc.info/?l=3Dlinux-ide&m=3D119707355016060&w=3D2
=2E..
> I'm using Ubuntu 7.10 with kernel 2.6.22-14-generic in a dual process=
or
> computer. Below there's some hardware information. The output of dmes=
g
> is attached. Thanks!

That patch will not apply cleanly to 2.6.22 - it will show rejects
in libata-core.c.  Those are OK - it's a cleanup of wrongly blacklisted
drives.  The main part - in ahci.c - is the one that's needed.

> [  229.096000] ata4: (irq_stat 0x00400000, PHY RDY changed)
> [  229.096000] ata4: hard resetting port
> [  233.400000] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

By the way, which drive it is?  If it's Seagate, pull out its
only jumper (factory preset) which limits it to SATAI.

/mjt
