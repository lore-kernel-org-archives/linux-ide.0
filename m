From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Wed, 25 Dec 2013 23:40:34 +0100
Message-ID: <20131225224034.GB5531@kw.sim.vm.gnt>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131224194603.GE19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131224194603.GE19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2013 at 02:46:03PM -0500, Jason Cooper wrote:
> On Mon, Dec 23, 2013 at 01:07:35PM +0100, Simon Guinot wrote:
> > From: Lior Amsalem <alior@marvell.com>
> >=20
> > From: Lior Amsalem <alior@marvell.com>
> >=20
> > This patch fixes a SATA hotplug issue on the Armada 370 and Armada XP
> > SoCs. Without it, if a disk is unplugged from a SATA port, then further
> > hotplug notification are now longer received on this port.
> >=20
> > This should be applied to every -stable kernel supporting Armada SoCs.
>=20
> Could we get a little more specific here?  Please determine which commit
> introduced the regression and note it with 'Fixes: <commitish> "oneline"'

Well, since the DT support for the sata_mv driver precedes SATA support
for Armada SoCs, I'd say that the bug has been introduced by:

a6a6de1a "arm: mvebu: SATA support: SoC-level DT data for Armada 370/XP"

Let me know if you agree with that. I will update the commit message
accorgingly.

>=20
> It's really needed here since the sata_mv driver predates the Armada
> SoCs introduction.  Is it possible Kirkwood et al also experience this
> problem?

On my Orion and Kirkwood based bords, SATA disk hotplug works correctly.

Simon

>=20
> thx,
>=20
> Jason.
>=20
> >=20
> > Signed-off-by: Lior Amsalem <alior@marvell.com>
> > Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/ata/sata_mv.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 56be318..89ca472 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -304,6 +304,7 @@ enum {
> >  	MV5_LTMODE		=3D 0x30,
> >  	MV5_PHY_CTL		=3D 0x0C,
> >  	SATA_IFCFG		=3D 0x050,
> > +	LP_PHY_CTL		=3D 0x058,
> > =20
> >  	MV_M2_PREAMP_MASK	=3D 0x7e0,
> > =20
> > @@ -1358,6 +1359,7 @@ static int mv_scr_write(struct ata_link *link, un=
signed int sc_reg_in, u32 val)
> > =20
> >  	if (ofs !=3D 0xffffffffU) {
> >  		void __iomem *addr =3D mv_ap_base(link->ap) + ofs;
> > +		void __iomem *lp_phy_addr =3D mv_ap_base(link->ap) + LP_PHY_CTL;
> >  		if (sc_reg_in =3D=3D SCR_CONTROL) {
> >  			/*
> >  			 * Workaround for 88SX60x1 FEr SATA#26:
> > @@ -1374,6 +1376,14 @@ static int mv_scr_write(struct ata_link *link, u=
nsigned int sc_reg_in, u32 val)
> >  			 */
> >  			if ((val & 0xf) =3D=3D 1 || (readl(addr) & 0xf) =3D=3D 1)
> >  				val |=3D 0xf000;
> > +
> > +			/*
> > +			 * Setting PHY speed according to SControl speed
> > +			 */
> > +			if ((val & 0xf0) =3D=3D 0x10)
> > +				writelfl(0x7, lp_phy_addr);
> > +			else
> > +				writelfl(0x227, lp_phy_addr);
> >  		}
> >  		writelfl(val, addr);
> >  		return 0;
> > --=20
> > 1.8.5.1
> >=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlK7XuIACgkQgtp0PDeOcDqs0ACfXvFsU9NRqbKsT004EdJSh8jD
xDMAn3QpFMxP+F4tzv5eUsDmBFAYZgmN
=ZtuX
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
