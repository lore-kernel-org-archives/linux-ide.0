From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V3 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Mon, 11 Apr 2011 10:44:53 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D995C@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1302509153-30326-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110411082210.GI18601@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:24077
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066Ab1DKKpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2011 06:45:03 -0400
In-Reply-To: <20110411082210.GI18601@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Uwe:
Thanks for your comments.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Monday, April 11, 2011 4:22 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [PATCH V3 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
>
> On Mon, Apr 11, 2011 at 04:05:53PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_loco.c |   76
> +++++++++++++++++++++++++++++++++++
> >  1 files changed, 76 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c
> > b/arch/arm/mach-mx5/board-mx53_loco.c
> > index 0a18f8d..489830a 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> > @@ -23,11 +23,13 @@
> >  #include <linux/fec.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> > +#include <linux/ahci_platform.h>
> this shouldn't be needed, as devices-common already #includes it.
Accepted.
>
> >
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  #include <mach/imx-uart.h>
> >  #include <mach/iomux-mx53.h>
> > +#include <mach/ahci_sata.h>
> >
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -38,6 +40,8 @@
> >
> >  #define LOCO_FEC_PHY_RST           IMX_GPIO_NR(7, 6)
> >
> > +static struct clk *sata_clk, *sata_ref_clk;
> > +
> >  static iomux_v3_cfg_t mx53_loco_pads[] = {
> >     /* FEC */
> >     MX53_PAD_FEC_MDC__FEC_MDC,
> > @@ -203,6 +207,77 @@ static const struct imxi2c_platform_data
> mx53_loco_i2c_data __initconst = {
> >     .bitrate = 100000,
> >  };
> >
> > +/* HW Initialization, if return 0, initialization is successful. */
> > +static int mx53_loco_sata_init(struct device *dev, void __iomem
> > +*addr) {
> > +   int ret = 0;
> > +   struct clk *clk;
> > +
> > +   sata_clk = clk_get(dev, NULL);
> > +   if (IS_ERR(sata_clk)) {
> > +           dev_err(dev, "no sata clock.\n");
> > +           return PTR_ERR(sata_clk);
> > +   }
> > +   ret = clk_enable(sata_clk);
> > +   if (ret) {
> > +           dev_err(dev, "can't enable sata clock.\n");
> > +           clk_put(sata_clk);
> > +           return ret;
> > +   }
> > +
> > +   /* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> > +   sata_ref_clk = clk_get(NULL, "usb_phy1");
> > +   if (IS_ERR(sata_ref_clk)) {
> > +           dev_err(dev, "no sata ref clock.\n");
> > +           ret = PTR_ERR(sata_ref_clk);
> > +           goto release_sata_clk;
> > +   }
> > +   ret = clk_enable(sata_ref_clk);
> > +   if (ret) {
> > +           dev_err(dev, "can't enable sata ref clock.\n");
> > +           clk_put(sata_ref_clk);
> > +           goto release_sata_clk;
> > +   }
> > +
> > +   /* Get the AHB clock rate, and configure the TIMER1MS reg later */
> > +   clk = clk_get(NULL, "ahb");
> > +   if (IS_ERR(clk)) {
> > +           dev_err(dev, "no ahb clock.\n");
> > +           ret = PTR_ERR(clk);
> > +           goto release_sata_ref_clk;
> > +   }
> > +
> > +   sata_init(addr, clk);
> > +
> > +   clk = NULL;
> This isn't needed. And ah, there is the clk_get. This looks all strange.
> If sata_ref_clk is needed to have ahci working it should be enabled
> automatically (maybe by making it a secondary clk?) Otherwise it's always
> on. Same for sata_ref_clk -> sata_clk.
>
Accepted. The clk get/put symmetric issue would be fixed later.
About the sata_ref_clk.
Different MX53 boards have the different clks resources.
Some boards need both the sata_clk and usb_phy1 clks, but some other boards don't need usb_phy1 clk.
So it's better that don't let it a secondary clk of sata.

> > +   return ret;
> > +
> > +release_sata_ref_clk:
> > +   clk_disable(sata_ref_clk);
> > +   clk_put(sata_ref_clk);
> > +
> > +release_sata_clk:
> > +   clk_disable(sata_clk);
> > +   clk_put(sata_clk);
> > +
> > +   clk = NULL;
> not needed
Accepted.
>
> > +   return ret;
> > +}
> > +
> > +static void sata_exit(struct device *dev)
> mx53_loco_sata_exit?
>
Accepted.
> > +{
> > +   clk_disable(sata_ref_clk);
> > +   clk_put(sata_ref_clk);
> > +
> > +   clk_disable(sata_clk);
> > +   clk_put(sata_clk);
> > +}
> > +
> > +static struct ahci_platform_data sata_data = {
> > +   .init = mx53_loco_sata_init,
> > +   .exit = sata_exit,
> > +};
> > +
> >  static void __init mx53_loco_board_init(void)  {
> >     mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
> > @@ -215,6 +290,7 @@ static void __init mx53_loco_board_init(void)
> >     imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
> >     imx53_add_sdhci_esdhc_imx(0, NULL);
> >     imx53_add_sdhci_esdhc_imx(2, NULL);
> > +   imx53_add_ahci_imx(0, &sata_data);
> >  }
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |


