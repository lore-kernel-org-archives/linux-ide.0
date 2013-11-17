From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/5] ahci: imx: Pull out the clock enable/disable calls
Date: Sun, 17 Nov 2013 09:15:58 +0100
Message-ID: <20131117091558.556a46bd@ipc1.ka-ro>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58615 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3KQIQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 03:16:56 -0500
In-Reply-To: <1384651251-5548-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Linux-IDE <linux-ide@vger.kernel.org>

Hi,

Marek Vasut wrote:
> The same code for enabling and disabling SATA clock was found in mult=
iple
> places in the driver. Implement functions that enable/disable the SAT=
A clock
> and use them in such places instead of duplicating the code.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 133 ++++++++++++++++++++++++++++-----------=
----------
>  1 file changed, 75 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index ae2d73f..c7ee505 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -47,6 +47,73 @@ static int ahci_imx_hotplug;
>  module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
>  MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=3DDon't supp=
ort, 1=3Dsupport)");
> =20
> +static int imx_sata_clock_enable(struct device *dev, bool config)
> +{
> +	struct imx_ahci_priv *imxpriv =3D dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	imxpriv->gpr =3D
> +		syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(imxpriv->gpr)) {
> +		dev_err(dev, "failed to find fsl,imx6q-iomux-gpr regmap\n");
> +		return PTR_ERR(imxpriv->gpr);
> +	}
> +
> +	ret =3D clk_prepare_enable(imxpriv->sata_ref_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "prepare-enable sata_ref clock err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * set PHY Paremeters, two steps to configure the GPR13,
> +	 * one write for rest of parameters, mask of first write
> +	 * is 0x07fffffd, and the other one write for setting
> +	 * the mpll_clk_en.
> +	 */
> +	if (config) {
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
> +				| IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK
> +				| IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK
> +				| IMX6Q_GPR13_SATA_SPD_MODE_MASK
> +				| IMX6Q_GPR13_SATA_MPLL_SS_EN
> +				| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
> +				| IMX6Q_GPR13_SATA_TX_BOOST_MASK
> +				| IMX6Q_GPR13_SATA_TX_LVL_MASK
> +				| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> +				, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
>
I would prefer the comma to be at the end of the line where one usually
looks for it. Also '#define'ing constants for these bitmasks would make
the code more readable.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
