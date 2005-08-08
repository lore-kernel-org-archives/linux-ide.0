From: Erik Slagter <erik@slagter.name>
Subject: Re: DriveStatusError BadCRC
Date: Mon, 08 Aug 2005 11:54:17 +0200
Message-ID: <1123494857.22328.52.camel@localhost.localdomain>
References: <42D7AAD50003D4AA@mail-6.mail.tiscali.sys>
	 <311601c905080707384a2def32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M50d2vw5lcRctuhG9wU7"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:19328 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750791AbVHHJzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 05:55:19 -0400
In-Reply-To: <311601c905080707384a2def32@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-M50d2vw5lcRctuhG9wU7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-07 at 08:38 -0600, Eric D. Mudama wrote:
> 51/84 indicates the crc failed on the incoming write data from your
> system.  These failures should be very rare (on PATA), but the bummer
> is they don't have anything to do with bad blocks on the media or
> degrading heads...
>=20
> What is the temperature like inside your case?  What host adapter are
> you using?  How many drives in the system?

I'd suggest trying another cable... And also a lower UDMA setting.

--=-M50d2vw5lcRctuhG9wU7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC9yvJJgD/6j32wUYRAo8oAJ9EgbrhRZrUqUiSdCQH3zWw/Bo6KgCeNW+8
z++fcMAHETc+egRc+iWoEWw=
=//b3
-----END PGP SIGNATURE-----

--=-M50d2vw5lcRctuhG9wU7--
