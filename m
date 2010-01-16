From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Sat, 16 Jan 2010 19:51:24 +0100
Message-ID: <20100116185124.GA7040@pengutronix.de>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de> <20100114.015938.224705378.davem@davemloft.net> <201001141650.17348.bzolnier@gmail.com> <20100115.013117.223126399.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42670 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab0APSv2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 13:51:28 -0500
Content-Disposition: inline
In-Reply-To: <20100115.013117.223126399.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > bzolnier:
> > - release resources in ide_release() to fix ordering of events
> > - remove stale FIXME note while at it
>=20
> Ok this does look better, Wolfram can you test this?

Works as expected.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktSCqsACgkQD27XaX1/VRvJ3gCgp4yZhuz+a7c1VhCZuLBDs3ya
oicAn28/7IO7VcKclGW75PTLxHhb0y5f
=bAW2
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
