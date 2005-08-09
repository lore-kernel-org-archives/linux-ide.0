From: Erik Slagter <erik@slagter.name>
Subject: Re: libata for SATA HDs.
Date: Tue, 09 Aug 2005 19:01:20 +0200
Message-ID: <1123606880.28278.0.camel@localhost.localdomain>
References: <42EEA9D5.5080304@superbug.demon.co.uk>
	 <42F8B264.5010706@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pB+vc82Hz4kXqTHMQHqX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:48332 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S964885AbVHIRCQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 13:02:16 -0400
In-Reply-To: <42F8B264.5010706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--=-pB+vc82Hz4kXqTHMQHqX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > Google did not help me.=20
> > Can I use the kernel libata and do commands like this now? :
> > hdparm -S60 /dev/sda
> Yes, but only if you manually apply the "libata-passthru" patch.
>=20
> The copy (below) works with 2.6.12, and I'm including it here
> for the benefit of the many who aren't yet ready to adopt a new
> religion (git) just for obtaining this vital functionality.

Right on the spot! Thanks!

--=-pB+vc82Hz4kXqTHMQHqX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+OFgJgD/6j32wUYRAiRNAJ0VLejKfK2/8nu74u5qft7YsJxfaACePwFM
TYOL6unrncyRIg3vQOhFu7o=
=Quha
-----END PGP SIGNATURE-----

--=-pB+vc82Hz4kXqTHMQHqX--
