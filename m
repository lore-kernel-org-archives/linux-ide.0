From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [RFC PATCH 1/2] AHCI Add the AHCI SATA feature on MX53 platforms
Date: Wed, 16 Mar 2011 09:49:34 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900CB010@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110315092223.GM29521@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.181]:41571
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1CPJuI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Mar 2011 05:50:08 -0400
In-Reply-To: <20110315092223.GM29521@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Sascha:
Thanks for your comments.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> Sent: Tuesday, March 15, 2011 5:22 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com;
> kernel@pengutronix.de; linux-ide@vger.kernel.org;
> avorontsov@ru.mvista.com; eric@eukrea.com; eric.miao@linaro.org
> Subject: Re: [RFC PATCH 1/2] AHCI Add the AHCI SATA feature on MX53
> platforms
>
> On Mon, Mar 14, 2011 at 05:55:43PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  arch/arm/mach-mx5/clock-mx51-mx53.c             |   11 +++++
> >  arch/arm/mach-mx5/devices-imx53.h               |    4 ++
> >  arch/arm/plat-mxc/devices/Kconfig               |    4 ++
> >  arch/arm/plat-mxc/devices/Makefile              |    1 +
> >  arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   55
> +++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/ahci_sata.h      |   51
> +++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++++
> >  7 files changed, 136 insertions(+), 0 deletions(-)  create mode
> > 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
> >  create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
> >
> > diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c
> > b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > index 652ace4..2b3d27c 100644
> > --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> > +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > @@ -1380,6 +1380,14 @@ static struct clk esdhc4_mx53_clk = {
> >     .secondary = &esdhc4_ipg_clk,
> >  };
> >
> > +static struct clk sata_clk = {
> > +   .parent = &ipg_clk,
> > +   .enable = _clk_max_enable,
> > +   .enable_reg = MXC_CCM_CCGR4,
> > +   .enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
> > +   .disable = _clk_max_disable,
> > +};
> > +
> >  DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4,
> > MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
> > DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4,
> > MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
> DEFINE_CLOCK(mipi_hsc1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFSET,
> NULL, NULL, &mipi_hsc2_clk, &pll2_sw_clk); @@ -1468,6 +1476,9 @@ static
> struct clk_lookup mx53_lookups[] = {
> >     _REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
> >     _REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> >     _REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> > +   _REGISTER_CLOCK(NULL, "imx_sata_clk", sata_clk)
>
> help!
>
> The NULL pointer here really should be "ahci" to associate this clock
> with the device it is used with. Then think about the "imx_sata_clk"
> string.
> The information "imx" is not relevant. "sata" is redundant as it is
> already associated with the ahci device. We are talking about a field in
> clocks, so no need for "clk". This should read:
>
>       _REGISTER_CLOCK("ahci", NULL, sata_clk)
Accepted.
>
> > +   _REGISTER_CLOCK(NULL, "usb_phy1", usb_phy1_clk)
> > +   _REGISTER_CLOCK(NULL, "ahb_clk", ahb_clk)
>
> no _clk please.
Accepted.
>
> >  };
> >
> >  static void clk_tree_init(void)
> > diff --git a/arch/arm/mach-mx5/devices-imx53.h
> > b/arch/arm/mach-mx5/devices-imx53.h
> > index 9251008..09ebb43 100644
> > --- a/arch/arm/mach-mx5/devices-imx53.h
> > +++ b/arch/arm/mach-mx5/devices-imx53.h
> > @@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data
> > imx53_ecspi_data[] __initconst;  extern const struct imx_imx2_wdt_data
> imx53_imx2_wdt_data[] __initconst;
> >  #define imx53_add_imx2_wdt(id, pdata)      \
> >     imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
> > +
> > +extern const struct imx_ahci_imx_data imx53_ahci_imx_data[]
> __initconst;
> > +#define imx53_add_ahci_imx(id, pdata)   \
> > +   imx_add_ahci_imx(&imx53_ahci_imx_data[id], pdata)
> > diff --git a/arch/arm/plat-mxc/devices/Kconfig
> > b/arch/arm/plat-mxc/devices/Kconfig
> > index b9ab1d5..087595a 100644
> > --- a/arch/arm/plat-mxc/devices/Kconfig
> > +++ b/arch/arm/plat-mxc/devices/Kconfig
> > @@ -71,3 +71,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> >
> >  config IMX_HAVE_PLATFORM_SPI_IMX
> >     bool
> > +
> > +config IMX_HAVE_PLATFORM_SATA_AHCI
> > +   bool
> > +   default y if SOC_IMX53
> > diff --git a/arch/arm/plat-mxc/devices/Makefile
> > b/arch/arm/plat-mxc/devices/Makefile
> > index 75cd2ec..e0b7fa3 100644
> > --- a/arch/arm/plat-mxc/devices/Makefile
> > +++ b/arch/arm/plat-mxc/devices/Makefile
> > @@ -22,3 +22,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) +=
> > platform-mxc_rnga.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) +=
> > platform-sdhci-esdhc-imx.o
> >  obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
> > +obj-$(CONFIG_IMX_HAVE_PLATFORM_SATA_AHCI) +=  platform-ahci-imx.o
> > +
> > +#ifdef CONFIG_SOC_IMX53
> > +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
> > +   imx_ahci_data_entry_single(MX53);
> > +#endif
> > +
> > +struct platform_device *__init imx_add_ahci_imx(
> > +           const struct imx_ahci_imx_data *data,
> > +           const struct ahci_platform_data *pdata) {
> > +   struct resource res[] = {
> > +           {
> > +                   .start = data->iobase,
> > +                   .end = data->iobase + SZ_4K - 1,
> > +                   .flags = IORESOURCE_MEM,
> > +           }, {
> > +                   .start = data->irq,
> > +                   .end = data->irq,
> > +                   .flags = IORESOURCE_IRQ,
> > +           },
> > +   };
> > +
> > +   return imx_add_platform_device_dmamask("ahci", 0 /* -1? */,
>
> I think it doesn't matter much if you use o or -1 here, but please remove
> the comment. btw if you keep 0 here you must use "ahci.0" in registering
> the clock.
>
Accepted.
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


