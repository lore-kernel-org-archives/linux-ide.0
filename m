From: Bob Ham <rah@bash.sh>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 18:15:29 +0100
Message-ID: <1185988529.16340.5.camel@orchid.arb.net>
References: <1185880124.3483.25.camel@localhost>
	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>
	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com>
	 <1185983536.16340.3.camel@orchid.arb.net>  <46B0ADB6.60207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cEZEHMy8eKqnrCCzT8Xt"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:43523 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757214AbXHASCz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 14:02:55 -0400
In-Reply-To: <46B0ADB6.60207@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


--=-cEZEHMy8eKqnrCCzT8Xt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-08-01 at 19:58 +0400, Sergei Shtylyov wrote:
> Bob Ham wrote:
>=20
> >>>>>>>I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controlle=
r for
> >>>>>>>a while now, using a proprietary binary driver from Highpoint in a=
 linux
> >>>>>>>2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes =
on
> >>>>>>>boot, as reported by others.
>=20
> >>>>>>  Can we see a bootlog please?
>=20
> >>>>>   ... and the output of 'lspci -v' too.
>=20
> >>    If possible, turn off that driver,=20
> >>then post that output...
>=20
> > This is the output of the boot using the pata_hpt37x driver:
>=20
>     Hrm... what I asked for was 'lspci -v' output. :-)

On Tue, 2007-07-31 at 22:22 +0100, Bob Ham wrote:=20

> lspci gives:
>=20
> 00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>         Subsystem: Triones Technologies, Inc. Unknown device 0001
>         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>         I/O ports at efa0 [size=3D8]
>         I/O ports at ef9c [size=3D4]
>         I/O ports at ef90 [size=3D8]
>         I/O ports at ef98 [size=3D4]
>         I/O ports at ec00 [size=3D256]
>         Expansion ROM at fe700000 [disabled] [size=3D128K]
>         Capabilities: [60] Power Management version 2
>=20
> 00:0d.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>         Subsystem: Triones Technologies, Inc. Unknown device 0001
>         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>         I/O ports at eff0 [size=3D8]
>         I/O ports at efe4 [size=3D4]
>         I/O ports at efa8 [size=3D8]
>         I/O ports at efe0 [size=3D4]
>         I/O ports at ed00 [size=3D256]
>         Capabilities: [60] Power Management version 2


I'll check out the patch you pointed to.

--=20
Bob Ham <rah@bash.sh>

--=-cEZEHMy8eKqnrCCzT8Xt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGsL+t7whsMRnFexQRAhedAKC8X/r/a3IbSWhuhJTG/P/Qn61gLQCfY4RX
WSv4NhIQIrnGRj0o1xmBgcI=
=FPll
-----END PGP SIGNATURE-----

--=-cEZEHMy8eKqnrCCzT8Xt--

