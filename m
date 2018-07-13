From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH v3 6/9] ata: ahci_platform: add support for
 port regulator
Date: Fri, 13 Jul 2018 19:07:38 +0800
Message-ID: <E8988FD2-335C-4BB9-87C3-2DE439784976@aosc.io>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com> <1531479786-4911-7-git-send-email-clabbe@baylibre.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBDUQULNAKGQEHCSMXMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1531479786-4911-7-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-ide@vger.kernel.org



=E4=BA=8E 2018=E5=B9=B47=E6=9C=8813=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=887:=
03:03, Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> =E5=86=99=E5=88=B0:
>The SoC R40 AHCI controller need a port regulator to work.

In fact it should be a PHY regulator.

>We cannot use the "target-supply" since it's not a target power
>regulator.
>So this patch add a way to add an optional port regulator.
>
>Signed-off-by: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>---
> drivers/ata/ahci.h             |  1 +
>drivers/ata/libahci_platform.c | 47
>+++++++++++++++++++++++++++++++++++++-----
> 2 files changed, 43 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>index 274c1885a5ad..716fd679dd3e 100644
>--- a/drivers/ata/ahci.h
>+++ b/drivers/ata/ahci.h
>@@ -352,6 +352,7 @@ struct ahci_host_priv {
> 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
> 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
> 	struct regulator	**target_pwrs;	/* Optional */
>+	struct regulator	**port_regulators;/* Optional */
> 	struct regulator	*ahci_regulator;/* Optional */
> 	struct reset_control	*ahci_reset;	/* Optional */
> 	/*
>diff --git a/drivers/ata/libahci_platform.c
>b/drivers/ata/libahci_platform.c
>index 1199ba411c15..d7574b3e1f6a 100644
>--- a/drivers/ata/libahci_platform.c
>+++ b/drivers/ata/libahci_platform.c
>@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  */
> int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
> {
>-	int rc, i;
>+	int rc, i, j;
>=20
> 	if (hpriv->ahci_regulator) {
> 		rc =3D regulator_enable(hpriv->ahci_regulator);
>@@ -164,9 +164,21 @@ int ahci_platform_enable_regulators(struct
>ahci_host_priv *hpriv)
> 		if (rc)
> 			goto disable_target_pwrs;
> 	}
>+	for (j =3D 0; j < hpriv->nports; j++) {
>+		if (!hpriv->port_regulators[j])
>+			continue;
>+
>+		rc =3D regulator_enable(hpriv->port_regulators[j]);
>+		if (rc)
>+			goto disable_port_regulators;
>+	}
>=20
> 	return 0;
>=20
>+disable_port_regulators:
>+	while (--j >=3D 0)
>+		if (hpriv->port_regulators[j])
>+			regulator_disable(hpriv->port_regulators[j]);
> disable_target_pwrs:
> 	while (--i >=3D 0)
> 		if (hpriv->target_pwrs[i])
>@@ -190,9 +202,10 @@ void ahci_platform_disable_regulators(struct
>ahci_host_priv *hpriv)
> 	int i;
>=20
> 	for (i =3D 0; i < hpriv->nports; i++) {
>-		if (!hpriv->target_pwrs[i])
>-			continue;
>-		regulator_disable(hpriv->target_pwrs[i]);
>+		if (hpriv->target_pwrs[i])
>+			regulator_disable(hpriv->target_pwrs[i]);
>+		if (hpriv->port_regulators[i])
>+			regulator_disable(hpriv->port_regulators[i]);
> 	}
>=20
> 	if (hpriv->ahci_regulator)
>@@ -291,9 +304,12 @@ static void ahci_platform_put_resources(struct
>device *dev, void *res)
> 	 * SATA device itself. So we can't use devm for automatically
> 	 * releasing them. We have to do it manually here.
> 	 */
>-	for (c =3D 0; c < hpriv->nports; c++)
>+	for (c =3D 0; c < hpriv->nports; c++) {
> 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
> 			regulator_put(hpriv->target_pwrs[c]);
>+		if (hpriv->port_regulators && hpriv->port_regulators[c])
>+			regulator_put(hpriv->port_regulators[c]);
>+	}
> }
>=20
>static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32
>port,
>@@ -338,6 +354,7 @@ static int ahci_platform_get_regulator(struct
>ahci_host_priv *hpriv, u32 port,
> 				struct device *dev)
> {
> 	struct regulator *target_pwr;
>+	struct regulator *port_regulator;
> 	int rc =3D 0;
>=20
> 	target_pwr =3D regulator_get_optional(dev, "target");
>@@ -346,6 +363,21 @@ static int ahci_platform_get_regulator(struct
>ahci_host_priv *hpriv, u32 port,
> 		hpriv->target_pwrs[port] =3D target_pwr;
> 	else
> 		rc =3D PTR_ERR(target_pwr);
>+	/* Only EPROBE_DEFER is important since it's an optional regulator */
>+	if (rc !=3D -EPROBE_DEFER)
>+		rc =3D 0;
>+	else
>+		return rc;
>+
>+	port_regulator =3D regulator_get_optional(dev, "port");
>+
>+	if (!IS_ERR(port_regulator))
>+		hpriv->port_regulators[port] =3D port_regulator;
>+	else
>+		rc =3D PTR_ERR(port_regulator);
>+	/* Only EPROBE_DEFER is important since it's an optional regulator */
>+	if (rc !=3D -EPROBE_DEFER)
>+		rc =3D 0;
>=20
> 	return rc;
> }
>@@ -454,6 +486,11 @@ struct ahci_host_priv
>*ahci_platform_get_resources(struct platform_device *pdev)
> 		rc =3D -ENOMEM;
> 		goto err_out;
> 	}
>+	hpriv->port_regulators =3D devm_kcalloc(dev, hpriv->nports,
>sizeof(*hpriv->port_regulators), GFP_KERNEL);
>+	if (!hpriv->port_regulators) {
>+		rc =3D -ENOMEM;
>+		goto err_out;
>+	}
>=20
> 	if (child_nodes) {
> 		for_each_child_of_node(dev->of_node, child) {

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
