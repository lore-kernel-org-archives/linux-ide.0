From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Fri, 8 Apr 2011 09:36:25 +0200
Message-ID: <20110408073625.GU7285@pengutronix.de>
References: <1300355883-28484-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300355883-28484-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38079 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab1DHHgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 03:36:37 -0400
Content-Disposition: inline
In-Reply-To: <1300355883-28484-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On Thu, Mar 17, 2011 at 05:58:03PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   88 +++++++++++++++++++++++++++++++++++
>  1 files changed, 88 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 0a18f8d..336273b 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -23,11 +23,13 @@
>  #include <linux/fec.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/ahci_platform.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/imx-uart.h>
>  #include <mach/iomux-mx53.h>
> +#include <mach/ahci_sata.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -38,6 +40,8 @@
>  
>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  
> +static struct clk *sata_clk, *sata_ref_clk;
> +
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	/* FEC */
>  	MX53_PAD_FEC_MDC__FEC_MDC,
> @@ -203,6 +207,89 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>  	.bitrate = 100000,
>  };
>  
> +/* HW Initialization, if return 0, initialization is successful. */
> +static int sata_init(struct device *dev, void __iomem *addr)
> +{
> +	int ret = 0;
> +	u32 tmpdata;
> +	struct clk *clk;
> +
> +	sata_clk = clk_get(dev, NULL);
> +	if (IS_ERR(sata_clk)) {
> +		dev_err(dev, "no sata clock.\n");
> +		return PTR_ERR(sata_clk);
> +	}
> +	ret = clk_enable(sata_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata clock.\n");
> +		clk_put(sata_clk);
> +		return ret;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> +	sata_ref_clk = clk_get(NULL, "usb_phy1");
> +	if (IS_ERR(sata_ref_clk)) {
> +		dev_err(dev, "no sata ref clock.\n");
> +		ret = PTR_ERR(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +	ret = clk_enable(sata_ref_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata ref clock.\n");
> +		clk_put(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +
> +	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
> +	clk = clk_get(NULL, "ahb");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no ahb clock.\n");
> +		ret = PTR_ERR(clk);
> +		goto release_sata_ref_clk;
> +	}

When I read code like this I think that a devm_clk_get is overdue.

Also, the ahci driver should handle the regular

> +
> +	tmpdata = readl(addr + HOST_CAP);
> +	if (!(tmpdata & HOST_CAP_SSS)) {
> +		tmpdata |= HOST_CAP_SSS;
> +		writel(tmpdata, addr + HOST_CAP);
> +	}

According to the AHCI spec this bit is read only.

> +
> +	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
> +		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
> +			addr + HOST_PORTS_IMPL);

This is also readonly.

> +
> +	tmpdata = clk_get_rate(clk) / 1000;
> +	clk_put(clk);
> +	writel(tmpdata, addr + HOST_TIMER1MS);

This should be in a more generic place as it needs to be done for every
board. We can put this into some i.MX53 startup function.


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
