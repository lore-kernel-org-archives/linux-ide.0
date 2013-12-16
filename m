From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Subject: RE: [PATCH] pci: imx: enable pcie msi support
Date: Mon, 16 Dec 2013 05:44:12 +0000
Message-ID: <4e5813d860164fcd8cca2c3d10a60272@BN1PR03MB138.namprd03.prod.outlook.com>
References: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com>
 <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
 <201312091200.53928.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.46.163.244] ([207.46.163.244]:24130 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750846Ab3LPGCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Dec 2013 01:02:46 -0500
In-Reply-To: <201312091200.53928.jbe@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "marex@denx.de" <marex@denx.de>, "hrhaan@gmail.com" <hrhaan@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Juergen:

Thanks for your review.

> -----Original Message-----
> From: J=FCrgen Beisert [mailto:jbe@pengutronix.de]
> Sent: Monday, December 09, 2013 7:01 PM
> To: Richard Zhu
> Cc: marex@denx.de; hrhaan@gmail.com; shawn.guo@linaro.org; jgarzik@po=
box.com;
> tj@kernel.org; linux-ide@vger.kernel.org; Zhu Richard-R65037
> Subject: Re: [PATCH] pci: imx: enable pcie msi support
>=20
> Hi Richard,
>=20
> On Monday 09 December 2013 10:25:19 Richard Zhu wrote:
> > [...]
> > +static int dw_msi_check_device(struct msi_chip *chip, struct pci_d=
ev *pdev,
> > +		int nvec, int type)
> > +{
> > +	struct pcie_port *pp =3D sys_to_pcie(pdev->bus->sysdata);
> > +	u32 val;
> > +
> > +	if (pp->quirks & DW_PCIE_QUIRK_MSI_SELF_EN) {
> > +		if ((type =3D=3D PCI_CAP_ID_MSI) || (type =3D=3D PCI_CAP_ID_MSIX=
)) {
> > +			/* Set MSI enable of RC here */
> > +			val =3D readl(pp->dbi_base + 0x50);
> > +			if ((val & (PCI_MSI_FLAGS_ENABLE << 16)) =3D=3D 0) {
> > +				val |=3D PCI_MSI_FLAGS_ENABLE << 16;
> > +				writel(val, pp->dbi_base + 0x50);
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Maybe I'm wrong: but does setting this bit not already happen in func=
tion
> msi_set_enable() in 'drivers/pci/msi.c' (just to a 16 bit register, s=
o there's
> no bit shift required)?
>=20
[Richard] yes, this bit would be set in msi_set_enable invoked by msi_c=
apability_init.
But I can't monitor that this bit is set when e1000e is probed. :(.
So I had to set this bit explicitly here.

> Regards,
> Juergen
>=20
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
> Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.peng=
utronix.de/  |
>=20
Best Regards
Richard Zhu

