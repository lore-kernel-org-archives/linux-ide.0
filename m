From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Fri, 15 Jan 2010 10:43:55 +0100
Message-ID: <20100115094355.GA4785@pengutronix.de>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de> <20100114.015938.224705378.davem@davemloft.net> <201001141650.17348.bzolnier@gmail.com> <20100115.013117.223126399.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285Ab0AOJn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2010 04:43:57 -0500
Content-Disposition: inline
In-Reply-To: <20100115.013117.223126399.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > bzolnier:
> > - release resources in ide_release() to fix ordering of events
> > - remove stale FIXME note while at it
>=20
> Ok this does look better, Wolfram can you test this?

ACK, looks better. I will test it, might not happen before Sunday, though.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktQONsACgkQD27XaX1/VRtUjwCguv2Gr6W1h32845fSl5m9A4Wg
8AEAnA7fy2cvJQpkpdBwqqL11PWDW9a0
=KKkw
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
