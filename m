From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 11:37:31 +0200
Message-ID: <1123753051.4226.22.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KUqQ/uoV1ugh6jLleXcM"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:23693 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932304AbVHKJiO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 05:38:14 -0400
In-Reply-To: <42FACCA8.6050408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--=-KUqQ/uoV1ugh6jLleXcM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-10 at 23:57 -0400, Jeff Garzik wrote:

> > Most current laptops ship with a PATA hard drive, and a PATA
> > ATAPI drive.  The easiest way to make them usable under Linux-2.6
> > is to patch libata and turn on ATAPI support, using ata_piix.
>=20
> No, the best thing to do is use the IDE driver for PATA.  That is the=20
> most stable, most well-tested path to ATAPI support at present.
>
> > This REALLY ought to be on by default now, Jeff.
> > Especially since the default is to NOT work at all..
>=20
> Correct, because currently no one should be using libata for PATA support=
.

You are sort of contradicting yourself. My setup (Dell laptop with ICH6M
and PATA harddisk) defaults to using libata for the PATA hardisk. Only
with a specific patch (which adds the PCI id to the IDE driver's id
list, and which was not quite accepted here) the IDE driver will
recognise the ICH6M and use it (and then it works fine).

> Turning on ATAPI and PATA support by default will break existing setups.

> > The libata code is taking forever to catch up to modern reality,
> > mostly because so much of it lives eternally in Jeff's private
> > git repository, where only a few people ever exercise the code.
>=20
> Exaggeration.  We're talking about a single #define here, to enable ATAPI=
.

How about a simple configure option...


--=-KUqQ/uoV1ugh6jLleXcM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+xxbJgD/6j32wUYRAutZAJ9Fj62VAzA3s7OVAy3e4cELjI7T/gCfdjnK
NgRlqxg5VtcYJkpGna4e8r4=
=qnIm
-----END PGP SIGNATURE-----

--=-KUqQ/uoV1ugh6jLleXcM--
