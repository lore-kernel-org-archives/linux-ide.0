From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] pcmcia: add CNF-CDROM-ID for ide
Date: Sun, 6 Sep 2009 17:33:00 +0200
Message-ID: <20090906153300.GA7970@pengutronix.de>
References: <20090806.132413.156910755.davem@davemloft.net> <1249643870-13276-1-git-send-email-w.sang@pengutronix.de> <20090814.130938.131662632.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45880 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996AbZIFPdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Sep 2009 11:33:00 -0400
Content-Disposition: inline
In-Reply-To: <20090814.130938.131662632.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2009 at 01:09:38PM -0700, David Miller wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Fri,  7 Aug 2009 13:17:50 +0200
>=20
> > Fixes this report:
> > http://article.gmane.org/gmane.linux.kernel.pcmcia.devel/2228/
> >=20
> > Reported-by: John McGrath <john@john-mcgrath.com>
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>=20
> Applied, thank you.

I just noticed that it is not in rc9. Is it possible to get it into .31?
Otherwise the ide and pata driver would diverge for this kernel version.

Rgeards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqj1iwACgkQD27XaX1/VRvoNgCdFA/sYA9h4fdFLq44d3HlsLuB
wkYAoMe2G0dDCmVEW/vLhttGwvmXiFwH
=3+2a
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
