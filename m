From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] sata_mv: use new sata phy register settings for new
	devices
Date: Sat, 11 Apr 2009 15:02:51 -0700
Message-ID: <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com>
References: <20090411160809.GA10922@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:46476 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZDKWC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 18:02:57 -0400
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id n3BM2sqf002484
	for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 15:02:54 -0700
Received: from gxk24 (gxk24.prod.google.com [10.202.11.24])
	by spaceape14.eur.corp.google.com with ESMTP id n3BM2p6n017751
	for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 15:02:52 -0700
Received: by gxk24 with SMTP id 24so3322128gxk.10
        for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 15:02:51 -0700 (PDT)
In-Reply-To: <20090411160809.GA10922@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

On Sat, Apr 11, 2009 at 9:08 AM, Martin Michlmayr <tbm@cyrius.com> wrot=
e:
> From: Saeed Bishara <saeed@marvell.com>
>
> Marvell's new SoC (65 nano) needs different modification for its SATA
> PHY registers.
>
> Tested-by: Martin Michlmayr <tbm@cyrius.com>
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
>
> ---
> This fixes the SATA problems I saw on the Kirkwood-based QNAP TS-219.
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 37ae5dc..f19f2e3 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -293,6 +293,10 @@ enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FISCFG_WAIT_DEV_ERR =C2=A0 =C2=A0 =3D (1 <=
< 8), =C2=A0 =C2=A0 /* wait for host on DevErr */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FISCFG_SINGLE_SYNC =C2=A0 =C2=A0 =C2=A0=3D=
 (1 << 16), =C2=A0 =C2=A0/* SYNC on DMA activation */
>
> + =C2=A0 =C2=A0 =C2=A0 PHY_MODE9_GEN2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 0x398,
> + =C2=A0 =C2=A0 =C2=A0 PHY_MODE9_GEN1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 0x39c,
> + =C2=A0 =C2=A0 =C2=A0 PHYCFG_OFS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D 0x3a0, =C2=A0 =C2=A0 =C2=A0 =C2=A0/* only in 65n devic=
es */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV5_PHY_MODE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x74,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV5_LTMODE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D 0x30,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0MV5_PHY_CTL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 0x0C,
> @@ -609,6 +613,8 @@ static int mv_soc_reset_hc(struct mv_host_priv *h=
priv,
> =C2=A0static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __i=
omem *mmio);
> =C2=A0static void mv_soc_reset_bus(struct ata_host *host, void __iome=
m *mmio);
> +static void mv_soc_65n_phy_errata(struct mv_host_priv *hpriv,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio, unsigned=
 int port);
> =C2=A0static void mv_reset_pci_bus(struct ata_host *host, void __iome=
m *mmio);
> =C2=A0static void mv_reset_channel(struct mv_host_priv *hpriv, void _=
_iomem *mmio,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int port_no);
> @@ -807,6 +813,14 @@ static const struct mv_hw_ops mv_soc_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset_bus =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D mv_soc_reset_bus,
> =C2=A0};
>
> +static const struct mv_hw_ops mv_soc_65n_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .phy_errata =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D mv_soc_65n_phy_errata,
> + =C2=A0 =C2=A0 =C2=A0 .enable_leds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D mv_soc_enable_leds,
> + =C2=A0 =C2=A0 =C2=A0 .reset_hc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D mv_soc_reset_hc,
> + =C2=A0 =C2=A0 =C2=A0 .reset_flash =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D mv_soc_reset_flash,
> + =C2=A0 =C2=A0 =C2=A0 .reset_bus =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D mv_soc_reset_bus,
> +};
> +
> =C2=A0/*
> =C2=A0* Functions
> =C2=A0*/
> @@ -3359,6 +3373,53 @@ static void mv_soc_reset_bus(struct ata_host *=
host, void __iomem *mmio)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0}
>
> +static void mv_soc_65n_phy_errata(struct mv_host_priv *hpriv,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *mmio, unsigned=
 int port)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *port_mmio =3D mv_port_base(mmio,=
 port);
> + =C2=A0 =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 reg;
> +
> + =C2=A0 =C2=A0 =C2=A0 reg =3D readl(port_mmio + PHY_MODE3);
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~(0x3 << 27); =C2=A0 =C2=A0/* bits 28=
:27 to 0x1 */
> + =C2=A0 =C2=A0 =C2=A0 reg |=3D (0x1 << 27);
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~(0x3 << 29); =C2=A0 =C2=A0/* bits 30=
:29 to 0x1 */
> + =C2=A0 =C2=A0 =C2=A0 reg |=3D (0x1 << 29);

Saeed,
Any chance these magic numbers can be documented?

No objection to this patch and I would prefer a follow on
patch to document the bits if that's possible.

thanks,
grant

> + =C2=A0 =C2=A0 =C2=A0 writel(reg, port_mmio + PHY_MODE3);
> +
> + =C2=A0 =C2=A0 =C2=A0 reg =3D readl(port_mmio + PHY_MODE4);
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~0x1; =C2=A0 =C2=A0/* bit 0 to 0x0, b=
it 16 must be set */
> + =C2=A0 =C2=A0 =C2=A0 reg |=3D (0x1 << 16);
> + =C2=A0 =C2=A0 =C2=A0 writel(reg, port_mmio + PHY_MODE4);
> +
> + =C2=A0 =C2=A0 =C2=A0 reg =3D readl(port_mmio + PHY_MODE9_GEN2);
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~0xf; =C2=A0 =C2=A0/* bits 3:0 to 0x8=
 */
> + =C2=A0 =C2=A0 =C2=A0 reg |=3D 0x8;
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~(0x1 << 14); =C2=A0 =C2=A0/* bit 14 =
to 0 */
> + =C2=A0 =C2=A0 =C2=A0 writel(reg, port_mmio + PHY_MODE9_GEN2);
> +
> + =C2=A0 =C2=A0 =C2=A0 reg =3D readl(port_mmio + PHY_MODE9_GEN1);
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~0xf; =C2=A0 =C2=A0/* bits 3:0 to 0x8=
 */
> + =C2=A0 =C2=A0 =C2=A0 reg |=3D 0x8;
> + =C2=A0 =C2=A0 =C2=A0 reg &=3D ~(0x1 << 14); =C2=A0 =C2=A0/* bit 14 =
to 0 */
> + =C2=A0 =C2=A0 =C2=A0 writel(reg, port_mmio + PHY_MODE9_GEN1);
> +}
> +
> +/**
> + * =C2=A0 =C2=A0 soc_is_65 - check if the soc is 65 nano device
> + *
> + * =C2=A0 =C2=A0 Detect the type of the SoC, this is done by reading=
 the PHYCFG_OFS
> + * =C2=A0 =C2=A0 register, this register should contain non-zero val=
ue and it exists only
> + * =C2=A0 =C2=A0 in the 65 nano devices, when reading it from older =
devices we get 0.
> + */
> +static bool soc_is_65n(struct mv_host_priv *hpriv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *port0_mmio =3D mv_port_base(hpri=
v->base, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (readl(port0_mmio + PHYCFG_OFS))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;
> + =C2=A0 =C2=A0 =C2=A0 return false;
> +}
> +
> =C2=A0static void mv_setup_ifcfg(void __iomem *port_mmio, int want_ge=
n2i)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 ifcfg =3D readl(port_mmio + SATA_IFCFG=
);
> @@ -3699,7 +3760,10 @@ static int mv_chip_id(struct ata_host *host, u=
nsigned int board_idx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case chip_soc:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hpriv->ops =3D &mv=
_soc_ops;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (soc_is_65n(hpr=
iv))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hpriv->ops =3D &mv_soc_65n_ops;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hpriv->ops =3D &mv_soc_ops;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hp_flags |=3D =
MV_HP_FLAG_SOC | MV_HP_GEN_IIE |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0MV_HP_ERRATA_60X1C0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> @@ -3762,7 +3826,8 @@ static int mv_init_host(struct ata_host *host, =
unsigned int board_idx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0n_hc =3D mv_get_hc_count(host->ports[0]->f=
lags);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (port =3D 0; port < host->n_ports; por=
t++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hpriv->ops->read_p=
reamp(hpriv, port, mmio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hpriv->ops->re=
ad_preamp)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hpriv->ops->read_preamp(hpriv, port, mmio);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D hpriv->ops->reset_hc(hpriv, mmio, n=
_hc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)
>
> --
> Martin Michlmayr
> http://www.cyrius.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
