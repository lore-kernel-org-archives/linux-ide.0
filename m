From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Tue, 15 Mar 2011 10:32:56 +0100
Message-ID: <20110315093256.GN29521@pengutronix.de>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300096544-1946-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52304 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab1COJdG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 05:33:06 -0400
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

Isn't this addr pointer exactly the address you remap again below?

> +{
> +	void __iomem *mmio;
> +	struct clk *clk;
> +	int ret = 0;
> +	u32 tmpdata;
> +
> +	clk = clk_get(dev, "imx_sata_clk");

This one is associated with the device, so passing in dev here is ok,
but...

> +	ret = IS_ERR(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't get clock.\n");
> +		return ret;
> +	}
> +	ret = clk_enable(clk);
> +	if (ret) {
> +		printk(KERN_ERR "IMX AHCI can't enable clock.\n");
> +		clk_put(clk);
> +		return ret;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> +	clk = clk_get(dev, "usb_phy1");

... this clock is not associated with the device, it just happens to be
used for this purpose on LOCO. Or is this this really not LOCO specific
but i.MX53 specific? If this is LOCO specific you should pass NULL as
the device pointer. If this is i.MX53 specific we should discuss about
adding a imx53_init_sata as then all of this function is not LOCO
specific.


Have these patches undergone some Linaro internal review? These are
really not ready for the wider world.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
