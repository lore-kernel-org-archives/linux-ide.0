From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP
 SoCs
Date: Fri, 31 Jan 2014 11:46:44 +0100
Message-ID: <20140131104643.GC10250@kw.sim.vm.gnt>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
 <20140126083210.2998ef12@skate>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140126083210.2998ef12@skate>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 08:32:10AM +0100, Thomas Petazzoni wrote:
> Dear Simon Guinot,

Hi Thomas,

>=20
> On Tue, 14 Jan 2014 15:50:06 +0100, Simon Guinot wrote:
>=20
> > +			if (hpriv->hp_flags & MV_HP_FIX_LP_PHY_CTL) {
> > +				void __iomem *lp_phy_addr =3D
> > +					mv_ap_base(link->ap) + LP_PHY_CTL;
> > +				/*
> > +				 * Set PHY speed according to SControl speed.
> > +				 */
> > +				if ((val & 0xf0) =3D=3D 0x10)
> > +					writelfl(0x7, lp_phy_addr);
> > +				else
> > +					writelfl(0x227, lp_phy_addr);
> > +			}
>=20
> I think we could do a little bit better than these magical values.
>=20
> The datasheet says:
>=20
>  * bits 12:9, PIN_PHY_GEN_RX. Value 0x0 =3D> 1.5 Gbps, value 0x1 =3D> 3 G=
bps
>  * bits 8:5, PIN_PHY_GEN_TX. Value 0x0 =3D> 1.5 Gbps, value 0x1 =3D> 3 Gb=
ps
>  * bit 2, PIN_PU_TX. Value 0x0 =3D> Power down, value 0x1 =3D> Power up.
>  * bit 1, PIN_PU_RX. Value 0x0 =3D> Power down, value 0x1 =3D> Power up.
>  * bit 0, PIN_PU_PLL. Value 0x0 =3D> Power down, value 0x1 =3D> Power up.

I missed this section in the datasheet...

>=20
> So maybe something like:
>=20
> #define PIN_PHY_GEN_1_5		0
> #define PIN_PHY_GEN_3		1
>=20
> #define PIN_PHY_GEN_RX(gen)	((gen) << 9)
> #define PIN_PHY_GEN_TX(gen)	((gen) << 5)
> #define PIN_PU_TX		BIT(2)
> #define PIN_PU_RX		BIT(1)
> #define PIN_PU_PLL		BIT(0)
>=20
>=20
> 		u32 sata_gen;
>=20
> 		if ((val & 0xf0) =3D=3D 0x10)
> 			sata_gen =3D PIN_PHY_GEN_1_5;
> 		else
> 			sata_gen =3D PIN_PHY_GEN_3;
>=20
> 		writelfl(PIN_PHY_GEN_RX(sata_gen) |
> 			 PIN_PHY_GEN_TX(sata_gen) |
> 			 PIN_PU_TX | PIN_PU_RX | PIN_PU_PLL,
> 			 lp_phy_addr);

Yes, it is much more understandable.

>=20
>=20
> > +	/*
> > +	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
> > +	 * updated in the LP_PHY_CTL register.
> > +	 */
> > +	if (pdev->dev.of_node &&
> > +		of_device_is_compatible(pdev->dev.of_node,
> > +					"marvell,armada-370-xp-sata"))
>=20
> Testing whether pdev->dev.of_node is not NULL does not seems to be
> useful. A quick read of of_device_is_compatible() and the function it's
> calling seem to indicate that of_device_is_compatible will return false
> if the passed struct device_node * is NULL.

I see.

It seems to me, you already have a patch ready to send. Isn't it ?
Or do you want me to do the update ?

Simon

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlLrfxMACgkQgtp0PDeOcDpKqQCdGoe5T8oH5ShDDFSNqOWmBzRo
6VEAn1kfdpW3YqNxR98W4dntpDIOpf7H
=xGE+
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
