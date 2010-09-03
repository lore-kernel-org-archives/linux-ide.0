From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: WARNINGs because of ide-proc handling
Date: Fri, 3 Sep 2010 20:59:34 +0200
Message-ID: <20100903185934.GA27291@pengutronix.de>
References: <20100902.151416.242137052.davem@davemloft.net> <20100903055328.GA11991@pengutronix.de> <20100903.053437.68134749.davem@davemloft.net> <20100903.073503.191401190.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41916 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0ICS7f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2010 14:59:35 -0400
Content-Disposition: inline
In-Reply-To: <20100903.073503.191401190.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2010 at 07:35:03AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Fri, 03 Sep 2010 05:34:37 -0700 (PDT)
>=20
> > From: Wolfram Sang <w.sang@pengutronix.de>
> > Date: Fri, 3 Sep 2010 07:53:28 +0200
> >=20
> >>=20
> >>> Thanks for your analysis and suggested patch, I'll take a look at thi=
s.
> >>=20
> >> Thanks for your help. If we can't find something, I'll just do a bisec=
t this
> >> weekend.
> >=20
> > Frankly, at this point, I'm beginning suspect that the procfs stuff
> > simply never warned at some point in the past and that the IDE
> > code has had this problem for a while.
>=20
> I just confirmed that the procfs code only started warning on removal
> of non-present entries this past March, so basically the IDE code has
> silently had this problem of not actually creating any of it's procfs
> nodes for some time now.

Confirming. With 2.6.33, I don't get the warnings, but neither get the
procfs-entries.

Checking my debug-output again, I assume that the hard-disk has the entries,
because it is the first user of ide-gd, so that driver still needs to be
requested. Maybe this is enough delay for the directories to appear? Wild
guess...

> Wolfram I'll look into your patch some more and integrate it, thanks.

Just in case you need a SoB:

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyBRZYACgkQD27XaX1/VRtjGgCfQ5WEpbg+C6dUJVgHZQDAnNIE
0GEAnjvgAr71V/Hx8YRbJM/9ZTT3Ad7Y
=kmvc
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
