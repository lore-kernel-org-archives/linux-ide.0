From: Erik Slagter <erik@slagter.name>
Subject: Re: Looking for support of Promise PDC40775 (SATA 300 TX2plus)
Date: Sun, 07 Aug 2005 11:15:15 +0200
Message-ID: <1123406115.4303.0.camel@localhost.localdomain>
References: <20050806231016.7a4f6553.raphael.bossek@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QpNRWn15ktFF5L3aFhoY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:399 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751339AbVHGJQQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Aug 2005 05:16:16 -0400
In-Reply-To: <20050806231016.7a4f6553.raphael.bossek@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raphael Bossek <raphael.bossek@gmx.de>
Cc: linux-ide <linux-ide@vger.kernel.org>


--=-QpNRWn15ktFF5L3aFhoY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I'm looking for 2.6 support of this kind of Promise controller.
> Is there any progress ongoing to support this kind of hardware
> with SATA and PATA conectors?
> Promise released GPL source code Linux 2.4 driver for this controllers
>=20
> PDC40518        Promise SATAII150 TX4
> PDC20575        Promise SATAII150 TX2plus
  ^^^^^^^^

I have this one working. It's as simple as adding the PCI id.

--=-QpNRWn15ktFF5L3aFhoY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC9dEiJgD/6j32wUYRAuNjAJ4vYMJE2CV2Kz30dN0kWXYx9nq1/wCeP0wU
2PCUnlEy2cp0ieD+OSXhsMk=
=GXC7
-----END PGP SIGNATURE-----

--=-QpNRWn15ktFF5L3aFhoY--
