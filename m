From: Erik Slagter <erik@slagter.name>
Subject: RE: [PATCH] ich6m-pciid-piix.patch
Date: Sun, 03 Jul 2005 12:46:07 +0200
Message-ID: <1120387567.4300.46.camel@localhost.localdomain>
References: <26CEE2C804D7BE47BC4686CDE863D0F5043A573F@orsmsx410>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m4snwOMHNjMy4aNqetbs"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:27023 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261277AbVGCKnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 06:43:52 -0400
In-Reply-To: <26CEE2C804D7BE47BC4686CDE863D0F5043A573F@orsmsx410>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


--=-m4snwOMHNjMy4aNqetbs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[cc-ing to list now, sorry, forgot that]

On Sat, 2005-07-02 at 11:44 -0700, Gaston, Jason D wrote:
> Please do not apply this patch.  The ICH6M SATA DID is all ready being us=
ed in the SATA ata_piix.c and ahci.c drivers.  Adding the ICH6M SATA DID to=
 the PATA piix.c driver will conflict.  This patch would add the ICH6M SATA=
 controller DID 0x2653 to the PATA piix.c driver.

That why you either enable piix support from the standard ide driver xor
from libsata. The comments in the configure script even mention this
fact!

--=-m4snwOMHNjMy4aNqetbs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCx8HvJgD/6j32wUYRAtsuAJ0X3xWRQg4kqvgynSCY1AQC8pY9sACZAdfU
91p89/JzE7xjRQbA33H5t1I=
=n6hZ
-----END PGP SIGNATURE-----

--=-m4snwOMHNjMy4aNqetbs--
