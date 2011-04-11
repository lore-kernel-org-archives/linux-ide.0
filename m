From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V3 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Mon, 11 Apr 2011 10:22:10 +0200
Message-ID: <20110411082210.GI18601@pengutronix.de>
References: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1302509153-30326-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41935 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab1DKIWQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2011 04:22:16 -0400
Content-Disposition: inline
In-Reply-To: <1302509153-30326-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On Mon, Apr 11, 2011 at 04:05:53PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   76 +++++++++++++++++++++++++=
++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/=
board-mx53_loco.c
> index 0a18f8d..489830a 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,11 +23,13 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/ahci_platform.h>
this shouldn't be needed, as devices-common already #includes it.

> =20
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/imx-uart.h>
>  #include <mach/iomux-mx53.h>
> +#include <mach/ahci_sata.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -38,6 +40,8 @@
> =20
>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
> =20
> +static struct clk *sata_clk, *sata_ref_clk;
> +
>  static iomux_v3_cfg_t mx53_loco_pads[] =3D {
>  	/* FEC */
>  	MX53_PAD_FEC_MDC__FEC_MDC,
> @@ -203,6 +207,77 @@ static const struct imxi2c_platform_data mx53_lo=
co_i2c_data __initconst =3D {
>  	.bitrate =3D 100000,
>  };
> =20
> +/* HW Initialization, if return 0, initialization is successful. */
> +static int mx53_loco_sata_init(struct device *dev, void __iomem *add=
r)
> +{
> +	int ret =3D 0;
> +	struct clk *clk;
> +
> +	sata_clk =3D clk_get(dev, NULL);
> +	if (IS_ERR(sata_clk)) {
> +		dev_err(dev, "no sata clock.\n");
> +		return PTR_ERR(sata_clk);
> +	}
> +	ret =3D clk_enable(sata_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata clock.\n");
> +		clk_put(sata_clk);
> +		return ret;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> +	sata_ref_clk =3D clk_get(NULL, "usb_phy1");
> +	if (IS_ERR(sata_ref_clk)) {
> +		dev_err(dev, "no sata ref clock.\n");
> +		ret =3D PTR_ERR(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +	ret =3D clk_enable(sata_ref_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata ref clock.\n");
> +		clk_put(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +
> +	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
> +	clk =3D clk_get(NULL, "ahb");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no ahb clock.\n");
> +		ret =3D PTR_ERR(clk);
> +		goto release_sata_ref_clk;
> +	}
> +
> +	sata_init(addr, clk);
> +
> +	clk =3D NULL;
This isn't needed. And ah, there is the clk_get. This looks all strange=
=2E
If sata_ref_clk is needed to have ahci working it should be enabled
automatically (maybe by making it a secondary clk?) Otherwise it's
always on. Same for sata_ref_clk -> sata_clk.

> +	return ret;
> +
> +release_sata_ref_clk:
> +	clk_disable(sata_ref_clk);
> +	clk_put(sata_ref_clk);
> +
> +release_sata_clk:
> +	clk_disable(sata_clk);
> +	clk_put(sata_clk);
> +
> +	clk =3D NULL;
not needed

> +	return ret;
> +}
> +
> +static void sata_exit(struct device *dev)
mx53_loco_sata_exit?

> +{
> +	clk_disable(sata_ref_clk);
> +	clk_put(sata_ref_clk);
> +
> +	clk_disable(sata_clk);
> +	clk_put(sata_clk);
> +}
> +
> +static struct ahci_platform_data sata_data =3D {
> +	.init =3D mx53_loco_sata_init,
> +	.exit =3D sata_exit,
> +};
> +
>  static void __init mx53_loco_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> @@ -215,6 +290,7 @@ static void __init mx53_loco_board_init(void)
>  	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
>  	imx53_add_sdhci_esdhc_imx(0, NULL);
>  	imx53_add_sdhci_esdhc_imx(2, NULL);
> +	imx53_add_ahci_imx(0, &sata_data);
>  }

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
