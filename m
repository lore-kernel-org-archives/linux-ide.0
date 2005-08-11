From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 17:29:17 +0200
Message-ID: <1123774157.4422.3.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com> <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
	 <58cb370e05081103031cb9ccdb@mail.gmail.com>
	 <1123755440.4226.28.camel@localhost.localdomain>
	 <58cb370e050811032658a2b61e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4hRl/8WJSbs9sVvL00EA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:13186 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751092AbVHKPaJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 11:30:09 -0400
In-Reply-To: <58cb370e050811032658a2b61e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-4hRl/8WJSbs9sVvL00EA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-11 at 12:26 +0200, Bartlomiej Zolnierkiewicz wrote:
> > As ICH6M features both PATA and SATA connections, I don't see why they'=
d
> > use a PATA bridge... The DVD drives use PATA anyway, btw.
>=20
> AFAIR ICH6M has only one PATA port and putting both HDD and DVD drive
> on the same PATA port would sacrifice performance (because only one PATA
> device can be used at a time).

That's duff. The PATA harddisk that is used in my laptop, also comes in
a SATA version...



--=-4hRl/8WJSbs9sVvL00EA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+27NJgD/6j32wUYRAjlAAJ44tEwX017H8LnK+wgHwGbto7T+ewCfRXAa
7J/dhgANuD14WH7MozHNOU4=
=vw8i
-----END PGP SIGNATURE-----

--=-4hRl/8WJSbs9sVvL00EA--
