From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: WARNINGs because of ide-proc handling
Date: Fri, 3 Sep 2010 16:47:35 +0200
Message-ID: <20100903144735.GD4813@pengutronix.de>
References: <20100902.151416.242137052.davem@davemloft.net>
 <20100903055328.GA11991@pengutronix.de>
 <20100903.053437.68134749.davem@davemloft.net>
 <20100903.073503.191401190.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49393 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0ICOrg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2010 10:47:36 -0400
Content-Disposition: inline
In-Reply-To: <20100903.073503.191401190.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2010 at 07:35:03AM -0700, David Miller wrote:

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
>=20
> Wolfram I'll look into your patch some more and integrate it, thanks.

I am still puzzled why my hard-disk does have these entries then. I am
away from that laptop currently, but will check later this evening.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyBCocACgkQD27XaX1/VRtZOACgj+FKOsL0XBz7CphBR+PJXDfx
j7IAoIf8TPHUat6K9DNlZrCOds8I+l4k
=n8w9
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
