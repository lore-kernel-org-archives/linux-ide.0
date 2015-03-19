From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH] ata: sata_mv: add proper definitions for LP_PHY_CTL
 register values
Date: Thu, 19 Mar 2015 17:13:54 +0100
Message-ID: <20150319161354.GH1509@kw.sim.vm.gnt>
References: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9135596104911548665=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Christophe Vu-Brugier <cvubrugier@lacie.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-ide@vger.kernel.org


--===============9135596104911548665==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mo5R/H9UGRM/aoK7"
Content-Disposition: inline


--Mo5R/H9UGRM/aoK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 02:36:37PM +0100, Thomas Petazzoni wrote:
> Commit 9013d64e661fc ("ata: sata_mv: fix disk hotplug for Armada
> 370/XP SoCs") added some manipulation of the LP_PHY_CTL register, but
> using magic values. This commit changes the code to use proper
> definitions for the LP_PHY_CTL register, which allows to document what
> the different bits are doing.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Thomas,

The patch looks fine to me.

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

Thanks,

Simon

> ---
>  drivers/ata/sata_mv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index f8c33e3..0281785 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -306,6 +306,11 @@ enum {
>  	MV5_PHY_CTL		=3D 0x0C,
>  	SATA_IFCFG		=3D 0x050,
>  	LP_PHY_CTL		=3D 0x058,
> +	LP_PHY_CTL_PIN_PU_PLL   =3D (1 << 0),
> +	LP_PHY_CTL_PIN_PU_RX    =3D (1 << 1),
> +	LP_PHY_CTL_PIN_PU_TX    =3D (1 << 2),
> +	LP_PHY_CTL_GEN_TX_3G    =3D (1 << 5),
> +	LP_PHY_CTL_GEN_RX_3G    =3D (1 << 9),
> =20
>  	MV_M2_PREAMP_MASK	=3D 0x7e0,
> =20
> @@ -1391,10 +1396,17 @@ static int mv_scr_write(struct ata_link *link, un=
signed int sc_reg_in, u32 val)
>  				/*
>  				 * Set PHY speed according to SControl speed.
>  				 */
> -				if ((val & 0xf0) =3D=3D 0x10)
> -					writelfl(0x7, lp_phy_addr);
> -				else
> -					writelfl(0x227, lp_phy_addr);
> +				u32 lp_phy_val =3D
> +					LP_PHY_CTL_PIN_PU_PLL |
> +					LP_PHY_CTL_PIN_PU_RX  |
> +					LP_PHY_CTL_PIN_PU_TX;
> +
> +				if ((val & 0xf0) !=3D 0x10)
> +					lp_phy_val |=3D
> +						LP_PHY_CTL_GEN_TX_3G |
> +						LP_PHY_CTL_GEN_RX_3G;
> +
> +				writelfl(lp_phy_val, lp_phy_addr);
>  			}
>  		}
>  		writelfl(val, addr);
> --=20
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Mo5R/H9UGRM/aoK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlUK9cIACgkQgtp0PDeOcDp06wCfbxJQpzzeLUL/4yTxeRPiYvzE
0hoAnREUf8AFvQB0GQPowb91yVb8H1R3
=2mS3
-----END PGP SIGNATURE-----

--Mo5R/H9UGRM/aoK7--


--===============9135596104911548665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9135596104911548665==--
