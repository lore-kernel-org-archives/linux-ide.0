From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 12:17:20 +0200
Message-ID: <1123755440.4226.28.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com> <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
	 <58cb370e05081103031cb9ccdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+jBXhtTUyxt1t+AtVqnK"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:16049 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S964868AbVHKKSF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 06:18:05 -0400
In-Reply-To: <58cb370e05081103031cb9ccdb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--=-+jBXhtTUyxt1t+AtVqnK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-11 at 12:03 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Most current laptops ship with a PATA hard drive, and a PATA
> > > > ATAPI drive.  The easiest way to make them usable under Linux-2.6
>=20
> New laptops rather ship with:
>=20
> SATA (or PATA + bridge) hard disk and PATA ATAPI drive

How do I find out?

As ICH6M features both PATA and SATA connections, I don't see why they'd
use a PATA bridge... The DVD drives use PATA anyway, btw.

> > You are sort of contradicting yourself. My setup (Dell laptop with ICH6=
M
> > and PATA harddisk) defaults to using libata for the PATA hardisk. Only

> Are you sure?

Yes I am sure. I can give you all the data to verify it yourself.

> I suspect that you have SATA-PATA converter inside the laptop

That would be a possibility, but I don't why.

> (or you are simply not using vanilla kernel).

You bet I always use vanilla kernels.

> > with a specific patch (which adds the PCI id to the IDE driver's id
> > list, and which was not quite accepted here) the IDE driver will
> > recognise the ICH6M and use it (and then it works fine).
>=20
> Yes, current situation with ICH6M support really sucks as many laptops
> are set to use combined mode and don't have BIOS option to disable it

Yeah, grmbl.

> so users end up with unusable ATAPI device (=3D=3D limited to PIO mode
> only because DMA region is already reserved by libata and cannot be
> used by IDE driver).

But with the patch (that adds the ID to the IDE driver), it all works.

> OTOH IDE driver should handle combined mode just fine and provide=20
> working ATAPI DMA (+ SMART support for HDD).  I prefer to not go
> this way but the libata development is *extremely* slow (I'm not blaming
> anyone just stating the fact)...

I guess you have a quite bunch of users willing to test here ;-)

--=-+jBXhtTUyxt1t+AtVqnK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+yWwJgD/6j32wUYRAn0zAJwJTvMoGZPn4VtZ2KOYBps/o0lDMwCfYKst
4rdTuHUtDFRQlNWJONK5IkI=
=oZBH
-----END PGP SIGNATURE-----

--=-+jBXhtTUyxt1t+AtVqnK--
