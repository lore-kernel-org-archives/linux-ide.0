From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
Date: Mon, 30 Jun 2014 11:59:40 +0200
Message-ID: <20140630095940.GB10058@kwain>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com>
 <53AB1CFD.4040500@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52755 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751590AbaF3J7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2014 05:59:55 -0400
Content-Disposition: inline
In-Reply-To: <53AB1CFD.4040500@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org

Sergei,

On Wed, Jun 25, 2014 at 11:03:25PM +0400, Sergei Shtylyov wrote:
> On 06/23/2014 05:39 PM, Antoine T=E9nart wrote:
>=20
> >The Berlin SoC has a two SATA ports. Add a PHY driver to handle them=
=2E
>=20
> >The mode selection can let us think this PHY can be configured to fi=
t
> >other purposes. But there are reasons to think the SATA mode will be
> >the only one usable: the PHY registers are only accessible indirectl=
y
> >through two registers in the SATA range, the PHY seems to be integra=
ted
> >and no information tells us the contrary. For these reasons, make th=
e
> >driver a SATA PHY driver.
>=20
>    I'm not even sure why you want to make it a separate driver if
> the registers are mapped to SATA controller's range.

We discussed this before and decided to move all the PHY related
functions to a dedicated PHY driver. This allows to have a generic
ahci_platform driver only using the common functions defined in the
libahci. And the PHY subsystem is there to handle PHYs, so it's a good
idea to use it, right?

> [...]
>=20
> >diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-=
sata.c
> >new file mode 100644
> >index 000000000000..317f62358165
> >--- /dev/null
> >+++ b/drivers/phy/phy-berlin-sata.c
> >@@ -0,0 +1,246 @@
> [...]
> +#define HOST_VSA_ADDR		0x0
> +#define HOST_VSA_DATA		0x4
> +#define PORT_VSR_ADDR		0x78
> +#define PORT_VSR_DATA		0x7c
> +#define PORT_SCR_CTL		0x2c
>=20
>    Could you keep this list sorted?

Sure.

>=20
> [...]
>=20
> +struct phy_berlin_desc {
> +	struct phy	*phy;
> +	u32		val;
>=20
>    Hm, aren't these power down bits? Why not call the field according=
ly?

Yes. I'll update.

>=20
> [...]
>=20
> >+static int phy_berlin_sata_power_on(struct phy *phy)
> >+{
> >+	struct phy_berlin_desc *desc =3D phy_get_drvdata(phy);
> >+	struct phy_berlin_priv *priv =3D to_berlin_sata_phy_priv(desc);
> >+	void __iomem *ctrl_reg =3D priv->base + 0x60 + (desc->index * 0x80=
);
> >+	int ret =3D 0;
> >+	u32 regval;
> >+
> >+	clk_prepare_enable(priv->clk);
> >+
> >+	spin_lock(&priv->lock);
> >+
> >+	/* Power on PHY */
> >+	writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> >+	regval =3D readl(priv->base + HOST_VSA_DATA);
> >+	regval &=3D ~(desc->val);
>=20
>    Parens not needed here.
>=20
> >+	writel(regval, priv->base + HOST_VSA_DATA);
> >+
> >+	/* Configure MBus */
> >+	writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> >+	regval =3D readl(priv->base + HOST_VSA_DATA);
> >+	regval |=3D MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUEST_SIZE_1=
28;
> >+	writel(regval, priv->base + HOST_VSA_DATA);
>=20
>    It probably makes sense to factor these address/data register
> writes into a separate function like phy_berlin_sata_reg_setbits().

I'm not sure. phy_berlin_sata_reg_setbits() is there for common access,
but the way to configure MBus and p[ower on the PHY is specific to them=
=2E
It would add functions only used once.

>=20
> [...]
> >+	/* set the controller speed */
> >+	writel(0x31, ctrl_reg + PORT_SCR_CTL);
>=20
>    Value undocumented? Or is this the SATA SControl register by chanc=
e?

Some magic is still there...

>=20
> [...]
>=20
> >+static int phy_berlin_sata_probe(struct platform_device *pdev)
> >+{
> >+	struct device *dev =3D &pdev->dev;
> >+	struct phy *phy;
> >+	struct phy_provider *phy_provider;
> >+	struct phy_berlin_priv *priv;
> >+	struct resource *res;
> >+	int i;
> >+
> >+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >+	if (!priv)
> >+		return -ENOMEM;
> >+
> >+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	if (!res)
> >+		return -EINVAL;
> >+
> >+	priv->base =3D devm_ioremap(dev, res->start, resource_size(res));
>=20
>    Can't you use devm_ioremap_resource()?

The SATA PHY registers are inside the SATA ones. We can't use
devm_ioremap_resource() then.


Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
