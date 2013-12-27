From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
Date: Fri, 27 Dec 2013 18:37:43 +0100
Message-ID: <20131227173743.GD5531@kw.sim.vm.gnt>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131226180157.GA6919@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131226180157.GA6919@lunn.ch>
Sender: stable-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 07:01:57PM +0100, Andrew Lunn wrote:
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
>=20
> I tested this on Kirkwood, which does not have any issues to
> (re)hotplug. Still works O.K. with this patch.

Hi Andrew,

Thanks for the tests.

>=20
> My only reservation is that neither the Kirkwood nor Dove datasheet
> list the LP_PHY_CTL register. Are we now poking something which does
> not exist on these SoCs? Is that safe?

I will check that.

Simon

>=20
> Tested-by: Andrew Lunn <andrew@lunn.ch>

>=20
>     Andrew
>=20
>=20
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

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlK9uucACgkQgtp0PDeOcDqGRgCdHhXrdC2DuaYm0kRekLp+6NBp
ZzgAn39r5Mh6iVY0R8058nGWp/oa3DOl
=xIaZ
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
