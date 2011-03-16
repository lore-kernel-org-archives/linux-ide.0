From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Wed, 16 Mar 2011 09:49:26 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900CB00B@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1300096544-1946-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110315090240.GL29521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:40054
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1CPJuU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Mar 2011 05:50:20 -0400
In-Reply-To: <20110315090240.GL29521@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Sascha:

Best Regards
Richard Zhu


> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Tuesday, March 15, 2011 5:03 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
>
> On Mon, Mar 14, 2011 at 05:55:44PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_loco.c |  120
> > +++++++++++++++++++++++++++++++++++
> >  1 files changed, 120 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c
> > b/arch/arm/mach-mx5/board-mx53_loco.c
> > index 0a18f8d..9a7bbea 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> > @@ -23,11 +23,13 @@
> >  #include <linux/fec.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> > +#include <linux/ahci_platform.h>
> >
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  #include <mach/imx-uart.h>
> >  #include <mach/iomux-mx53.h>
> > +#include <mach/ahci_sata.h>
> >
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -203,6 +205,123 @@ static const struct imxi2c_platform_data
> mx53_loco_i2c_data __initconst = {
> >     .bitrate = 100000,
> >  };
> >
> > +/* HW Initialization, if return 0, initialization is successful. */
> > +static int sata_init(struct device *dev, void __iomem *addr) {
> > +   void __iomem *mmio;
> > +   struct clk *clk;
> > +   int ret = 0;
> > +   u32 tmpdata;
> > +
> > +   clk = clk_get(dev, "imx_sata_clk");
> > +   ret = IS_ERR(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't get clock.\n");
> > +           return ret;
> > +   }
>
> IS_ERR returns 0 or 1 which is not a valid return value here.
Accepted.

>
> > +   ret = clk_enable(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't enable clock.\n");
>
> You have a struct device *, so you should use dev_err.
Accepted.

>
> > +           clk_put(clk);
> > +           return ret;
> > +   }
> > +
> > +   /* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> > +   clk = clk_get(dev, "usb_phy1");
> > +   ret = IS_ERR(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> > +           goto no_input_clk;
> > +   }
> > +   ret = clk_enable(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI Can't enable USB PHY1 clock.\n");
> > +           clk_put(clk);
> > +           goto no_input_clk;
> > +   }
> > +
> > +   /* Get the AHB clock rate, and configure the TIMER1MS reg later */
> > +   clk = clk_get(NULL, "ahb_clk");
> > +   ret = IS_ERR(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't get AHB clock.\n");
> > +           goto no_clk;
> > +   }
> > +
> > +   mmio = ioremap(MX53_SATA_BASE_ADDR, SZ_2K);
> > +   if (mmio == NULL) {
> > +           printk(KERN_ERR "Failed to map SATA REGS\n");
> > +           goto no_clk;
> > +   }
> > +
> > +   tmpdata = readl(mmio + HOST_CAP);
> > +   if (!(tmpdata & HOST_CAP_SSS)) {
> > +           tmpdata |= HOST_CAP_SSS;
> > +           writel(tmpdata, mmio + HOST_CAP);
> > +   }
> > +
> > +   if (!(readl(mmio + HOST_PORTS_IMPL) & 0x1))
> > +           writel((readl(mmio + HOST_PORTS_IMPL) | 0x1),
> > +                   mmio + HOST_PORTS_IMPL);
> > +
> > +   tmpdata = clk_get_rate(clk) / 1000;
> > +   writel(tmpdata, mmio + HOST_TIMER1MS);
> > +
> > +   iounmap(mmio);
> > +
> > +   return ret;
> > +
> > +no_clk:
> > +   clk = clk_get(dev, "usb_phy1");
>
> While technically not strictly necessary at the moment you should balance
> your clk_get / clk_put calls. Everything else is bad taste.
>
Yeah, you are right.
How do you think about add two clk pointers member into ahci_host_priv struct to balance
 clk_get/clk_put pair calls?
Or
Added one private pointer into ahci_host_priv to make a more flexible method for kinds of different platforms to
balance the hw resource(clk, power and so on) balance?


>
> > +   if (IS_ERR(clk)) {
> > +           clk = NULL;
> > +           printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> > +   } else {
> > +           clk_disable(clk);
> > +           clk_put(clk);
> > +   }
> > +
> > +no_input_clk:
> > +   clk = clk_get(dev, "imx_sata_clk");
> > +   if (IS_ERR(clk)) {
> > +           clk = NULL;
> > +           printk(KERN_ERR "IMX AHCI can't get clock.\n");
> > +   } else {
> > +           clk_disable(clk);
> > +           clk_put(clk);
> > +   }
> > +
> > +   return ret;
> > +}
> > +
> > +static void sata_exit(struct device *dev) {
> > +   struct clk *clk;
> > +
> > +   clk = clk_get(dev, "usb_phy1");
> > +   if (IS_ERR(clk)) {
> > +           clk = NULL;
> > +           printk(KERN_ERR "IMX AHCI can't get USB PHY1 CLK.\n");
> > +   } else {
> > +           clk_disable(clk);
> > +           clk_put(clk);
> > +   }
> > +
> > +   clk = clk_get(dev, "imx_sata_clk");
> > +   if (IS_ERR(clk)) {
> > +           clk = NULL;
> > +           printk(KERN_ERR "IMX AHCI can't get clock.\n");
> > +   } else {
> > +           clk_disable(clk);
> > +           clk_put(clk);
> > +   }
> > +}
> > +
> > +static struct ahci_platform_data sata_data = {
> > +   .init = sata_init,
> > +   .exit = sata_exit,
> > +};
> > +
> >  static void __init mx53_loco_board_init(void)  {
> >     mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> > @@ -215,6 +334,7 @@ static void __init mx53_loco_board_init(void)
> >     imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
> >     imx53_add_sdhci_esdhc_imx(0, NULL);
> >     imx53_add_sdhci_esdhc_imx(2, NULL);
> > +   imx53_add_ahci_imx(0, &sata_data);
> >  }
> >
> >  static void __init mx53_loco_timer_init(void)
> > --
> > 1.7.1
> >
> >
> >
>
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |


