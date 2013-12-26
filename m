From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Thu, 26 Dec 2013 12:54:28 +0100
Message-ID: <20131226115428.GC5531@kw.sim.vm.gnt>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131224194603.GE19878@titan.lakedaemon.net>
 <20131225224034.GB5531@kw.sim.vm.gnt>
 <20131226085355.2fd1969c@skate>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131226085355.2fd1969c@skate>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 08:53:55AM +0100, Thomas Petazzoni wrote:
> Dear Simon Guinot,
>=20
> On Wed, 25 Dec 2013 23:40:34 +0100, Simon Guinot wrote:
>=20
> > > > This should be applied to every -stable kernel supporting Armada
> > > > SoCs.
> > >=20
> > > Could we get a little more specific here?  Please determine which
> > > commit introduced the regression and note it with 'Fixes:
> > > <commitish> "oneline"'
> >=20
> > Well, since the DT support for the sata_mv driver precedes SATA
> > support for Armada SoCs, I'd say that the bug has been introduced by:
> >=20
> > a6a6de1a "arm: mvebu: SATA support: SoC-level DT data for Armada
> > 370/XP"
> >=20
> > Let me know if you agree with that. I will update the commit message
> > accorgingly.
>=20
> In some sense, we could say that this is not a regression. According to
> what you mean, SATA hotplug has *never* been working on Armada 370/XP.
> So technically, it could be seen as a new feature for this platform,
> and is therefore not a regression (i.e something that used to work, and
> that no longer works). There has been no kernel release for which SATA
> hotplug was working for Armada 370/XP.

I agree with that. It is not correct to call this issue a regression.
But, it would also be nice to have this patch applied in the stable
branches 3.10 and onwards. Maybe, I could just add this information
while CC'ing Linux stable ?

Regards,

Simon

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlK8GPQACgkQgtp0PDeOcDoV/ACglYo3xaRZtssvtccnKYexeBwN
+nMAn0uwn85zx1TgZgqOu6bK9LugIvql
=ehg0
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
