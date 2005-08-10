From: Erik Slagter <erik@slagter.name>
Subject: Re: libata for SATA HDs.
Date: Wed, 10 Aug 2005 09:41:18 +0200
Message-ID: <1123659678.28278.33.camel@localhost.localdomain>
References: <42EEA9D5.5080304@superbug.demon.co.uk>
	 <42F8B264.5010706@rtr.ca> <1123611529.28278.12.camel@localhost.localdomain>
	 <42F90C3C.6010809@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uCfKtg08P6/TXh+Us22p"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:48352 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S965033AbVHJHmP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Aug 2005 03:42:15 -0400
In-Reply-To: <42F90C3C.6010809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--=-uCfKtg08P6/TXh+Us22p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-09 at 16:04 -0400, Mark Lord wrote:
> > Hmmm, hdparm -S indeed works now, but smartctl doesn't work yet :-(. I
> > was silently hoping that would start working as well.
>=20
> Smartctl wants the "-d ata" option set to speak to libata.

Once again right on the spot! Thanks! Now I think about it, it seems
logical...

--=-uCfKtg08P6/TXh+Us22p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+a+eJgD/6j32wUYRAihEAKCGhK02rC26GYldIYWq++9D4+WqYwCdFqMA
i0qAOKcDE/7RRaj8Kq7F8fs=
=8evG
-----END PGP SIGNATURE-----

--=-uCfKtg08P6/TXh+Us22p--
