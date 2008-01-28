From: Zan Lynx <zlynx@acm.org>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 10:20:30 -0700
Message-ID: <1201540830.6526.19.camel@localhost>
References: <200801272122.21823.gene.heskett@gmail.com>
	 <200801280754.53768.gene.heskett@gmail.com>
	 <18333.57152.472830.608248@harpo.it.uu.se>
	 <200801281135.14555.gene.heskett@gmail.com>  <1201539043.31293.7.camel@zem>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rbt0sZQVa8wgMzyfU6Z6"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762109AbYA1RUo@vger.kernel.org>
In-Reply-To: <1201539043.31293.7.camel@zem>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Walton <calvin.walton@gmail.com>
Cc: Gene Heskett <gene.heskett@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


--=-rbt0sZQVa8wgMzyfU6Z6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2008-01-28 at 11:50 -0500, Calvin Walton wrote:
> On Mon, 2008-01-28 at 11:35 -0500, Gene Heskett wrote:
> > On Monday 28 January 2008, Mikael Pettersson wrote:
> > >Unfortunately we also see:
> > > > [   48.285456] nvidia: module license 'NVIDIA' taints kernel.
> > > > [   48.549725] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC4] -=
> GSI
> > > > 19 (level, high) -> IRQ 20 [   48.550149] NVRM: loading NVIDIA UNIX=
 x86
> > > > Kernel Module  169.07  Thu Dec 13 18:42:56 PST 2007
> > >
> > >We have no way of debugging that module, so please try 2.6.24 without =
it.
> >=20
> > Sorry, I can't do this and have a working machine.  The nv driver has s=
uffered=20
> > bit rot or something since the FC2 days when it COULD run a 19" crt at=20
> > 1600x1200, and will not drive this 20" wide screen lcd 1680x1050 monito=
r at=20
> > more than 800x600, which is absolutely butt ugly fuzzy, looking like a =
jpg=20
> > compressed to 10%.  The system is not usable on a day to basis without =
the=20
> > nvidia driver.
>=20
> You should probably give the nouveau[1] driver a try, if only for
> testing purposes; if you are running an NV4x (G6x or G7x) card in
> particular, it works a lot better than the nv driver for 2d support.
>=20
> 1. http://nouveau.freedesktop.org/wiki/InstallNouveau

But nouveau is much less stable than nv.  For testing purposes, go with
stable.

I'm not sure why it won't run his screen though.  I can use nv to run a
1920x1200 laptop LCD.  It *is* dog slow (although nouveau was not any
better with a NV17 / 440-Go -- render support for AA fonts seems to be
missing), but it does work.
--=20
Zan Lynx <zlynx@acm.org>

--=-rbt0sZQVa8wgMzyfU6Z6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHng7eG8fHaOLTWwgRAhMlAJ0Uzwl/qwupf9IoWkBLLiQCu0/i/QCfVx25
a7yZlkrffM2PZwl/qINLPyo=
=jYrN
-----END PGP SIGNATURE-----

--=-rbt0sZQVa8wgMzyfU6Z6--
