From: Erik Slagter <erik@slagter.name>
Subject: Re: libata for SATA HDs.
Date: Tue, 09 Aug 2005 20:18:49 +0200
Message-ID: <1123611529.28278.12.camel@localhost.localdomain>
References: <42EEA9D5.5080304@superbug.demon.co.uk>
	 <42F8B264.5010706@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pLgbGbilNmPrHichnX/E"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:51134 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S964914AbVHISTK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 14:19:10 -0400
In-Reply-To: <42F8B264.5010706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--=-pLgbGbilNmPrHichnX/E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-09 at 09:40 -0400, Mark Lord wrote:
> > Can I use the kernel libata and do commands like this now? :
> > hdparm -S60 /dev/sda
>=20
> Yes, but only if you manually apply the "libata-passthru" patch.

Hmmm, hdparm -S indeed works now, but smartctl doesn't work yet :-(. I
was silently hoping that would start working as well.

--=-pLgbGbilNmPrHichnX/E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+POJJgD/6j32wUYRArjkAJ0f7VB+sQMscXKRN8rGjGEHsQh5AACgiFg7
GzziU7H2bhK7JnyfNGz+Dbk=
=oEN7
-----END PGP SIGNATURE-----

--=-pLgbGbilNmPrHichnX/E--
