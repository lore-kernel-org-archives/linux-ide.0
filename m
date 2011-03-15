From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Tue, 15 Mar 2011 10:02:40 +0100
Message-ID: <20110315090240.GL29521@pengutronix.de>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300096544-1946-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43853 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1COJCv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 05:02:51 -0400
Content-Disposition: inline
In-Reply-To: <1300096544-1946-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On Mon, Mar 14, 2011 at 05:55:44PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |  120 +++++++++++++++++++++++++++++++++++
>  1 files changed, 120 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 0a18f8d..9a7bbea 100644
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
> @@ -203,6 +205,123 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>  	.bitrate = 100000,
>  };
>  
> +/* HW Initialization, if return 0, initialization is successful. */
> +static int sata_init(struct device *dev, void __iomem *addr)
> +{
> +	void __iomem *mmio;
> +	struct clk *clk;
> +	int ret = 0;
> +	u32 tmpdata;
> +
> +	clk = clk_get(dev, "imx_sata_clk");
> +	ret = IS_ERR(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't get clock.\n");
> +		return ret;
> +	}

IS_ERR returns 0 or 1 which is not a valid return value here.

> +	ret = clk_enable(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't enable clock.\n");

You have a struct device *, so you should use dev_err.

> +		clk_put(clk);
> +		return ret;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> +	clk = clk_get(dev, "usb_phy1");
> +	ret = IS_ERR(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> +		goto no_input_clk;
> +	}
> +	ret = clk_enable(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI Can't enable USB PHY1 clock.\n");
> +		clk_put(clk);
> +		goto no_input_clk;
> +	}
> +
> +	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
> +	clk = clk_get(NULL, "ahb_clk");
> +	ret = IS_ERR(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't get AHB clock.\n");
> +		goto no_clk;
> +	}
> +
> +	mmio = ioremap(MX53_SATA_BASE_ADDR, SZ_2K);
> +	if (mmio == NULL) {
> +		printk(KERN_ERR "Failed to map SATA REGS\n");
> +		goto no_clk;
> +	}
> +
> +	tmpdata = readl(mmio + HOST_CAP);
> +	if (!(tmpdata & HOST_CAP_SSS)) {
> +		tmpdata |= HOST_CAP_SSS;
> +		writel(tmpdata, mmio + HOST_CAP);
> +	}
> +
> +	if (!(readl(mmio + HOST_PORTS_IMPL) & 0x1))
> +		writel((readl(mmio + HOST_PORTS_IMPL) | 0x1),
> +			mmio + HOST_PORTS_IMPL);
> +
> +	tmpdata = clk_get_rate(clk) / 1000;
> +	writel(tmpdata, mmio + HOST_TIMER1MS);
> +
> +	iounmap(mmio);
> +
> +	return ret;
> +
> +no_clk:
> +	clk = clk_get(dev, "usb_phy1");

While technically not strictly necessary at the moment you should
balance your clk_get / clk_put calls. Everything else is bad taste.


> +	if (IS_ERR(clk)) {
> +		clk = NULL;
> +		printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> +	} else {
> +		clk_disable(clk);
> +		clk_put(clk);
> +	}
> +
> +no_input_clk:
> +	clk = clk_get(dev, "imx_sata_clk");
> +	if (IS_ERR(clk)) {
> +		clk = NULL;
> +		printk(KERN_ERR "IMX AHCI can't get clock.\n");
> +	} else {
> +		clk_disable(clk);
> +		clk_put(clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static void sata_exit(struct device *dev)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(dev, "usb_phy1");
> +	if (IS_ERR(clk)) {
> +		clk = NULL;
> +		printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> +	} else {
> +		clk_disable(clk);
> +		clk_put(clk);
> +	}
> +
> +	clk = clk_get(dev, "imx_sata_clk");
> +	if (IS_ERR(clk)) {
> +		clk = NULL;
> +		printk(KERN_ERR "IMX AHCI can't get clock.\n");
> +	} else {
> +		clk_disable(clk);
> +		clk_put(clk);
> +	}
> +}
> +
> +static struct ahci_platform_data sata_data = {
> +	.init = sata_init,
> +	.exit = sata_exit,
> +};
> +
>  static void __init mx53_loco_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> @@ -215,6 +334,7 @@ static void __init mx53_loco_board_init(void)
>  	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
>  	imx53_add_sdhci_esdhc_imx(0, NULL);
>  	imx53_add_sdhci_esdhc_imx(2, NULL);
> +	imx53_add_ahci_imx(0, &sata_data);
>  }
>  
>  static void __init mx53_loco_timer_init(void)
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
