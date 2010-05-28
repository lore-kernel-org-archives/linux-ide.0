From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/4] ARM: S3C64XX: Add support for Compact Flash driver	on
 SMDK6410
Date: Fri, 28 May 2010 07:44:14 +0200
Message-ID: <000001cafe28$d17393c0$745abb40$%szyprowski@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
 <1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
 <20100527085233.GJ4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53343 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0E1FpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2010 01:45:08 -0400
In-reply-to: <20100527085233.GJ4720@trinity.fluff.org>
Content-language: pl
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Ben Dooks' <ben-linux@fluff.org>, 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Thursday, May 27, 2010 10:53 AM Ben Dooks wrote:

> On Thu, May 27, 2010 at 05:22:01PM +0900, Kukjin Kim wrote:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Following is added for the CF-ATA driver:
> > 	- Platform data strucure definition and instantiation
> > 	- Platform device definition and enabling code
> > 	- Platform-specific gpio setup code
> > 	- CF controller register definitions
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-s3c64xx/Kconfig                   |    7 +++
> >  arch/arm/mach-s3c64xx/Makefile                  |    1 +
> >  arch/arm/mach-s3c64xx/clock.c                   |    6 +++
> >  arch/arm/mach-s3c64xx/include/mach/map.h        |    5 ++-
> >  arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    5 ++
> >  arch/arm/mach-s3c64xx/mach-smdk6410.c           |    9 ++++
> >  arch/arm/mach-s3c64xx/s3c6410.c                 |    1 +
> >  arch/arm/mach-s3c64xx/setup-ide.c               |   55
> ++++++++++++++++++++++
> >  arch/arm/plat-samsung/Kconfig                   |    5 ++
> >  arch/arm/plat-samsung/Makefile                  |    1 +
> >  arch/arm/plat-samsung/dev-ide.c                 |   52
> +++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/ata.h        |   38 +++++++++++++++
> >  arch/arm/plat-samsung/include/plat/devs.h       |    1 +
> >  arch/arm/plat-samsung/include/plat/regs-ata.h   |   56
> +++++++++++++++++++++++
> 
> it would have been useful to keep the plat-samsung changes
> seperate.
> 
> >  14 files changed, 241 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-s3c64xx/setup-ide.c
> >  create mode 100644 arch/arm/plat-samsung/dev-ide.c
> >  create mode 100644 arch/arm/plat-samsung/include/plat/ata.h
> >  create mode 100644 arch/arm/plat-samsung/include/plat/regs-ata.h
> >
> > diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-
> s3c64xx/Kconfig
> > index f5a5972..c00401e 100644
> > --- a/arch/arm/mach-s3c64xx/Kconfig
> > +++ b/arch/arm/mach-s3c64xx/Kconfig
> > @@ -67,6 +67,11 @@ config S3C64XX_SETUP_SDHCI_GPIO
> >  	help
> >  	  Common setup code for S3C64XX SDHCI GPIO configurations
> >
> > +config S3C64XX_SETUP_IDE
> > +	bool
> > +	help
> > +	  Common setup code for S3C64XX IDE.
> > +
> >  # S36400 Macchine support
> >
> >  config MACH_SMDK6400
> > @@ -101,9 +106,11 @@ config MACH_SMDK6410
> >  	select S3C_DEV_USB_HSOTG
> >  	select S3C_DEV_WDT
> >  	select HAVE_S3C2410_WATCHDOG
> > +	select S3C_DEV_IDE
> >  	select S3C64XX_SETUP_SDHCI
> >  	select S3C64XX_SETUP_I2C1
> >  	select S3C64XX_SETUP_FB_24BPP
> > +	select S3C64XX_SETUP_IDE
> >  	help
> >  	  Machine support for the Samsung SMDK6410
> >
> > diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-
> s3c64xx/Makefile
> > index 9d10069..0d52c35 100644
> > --- a/arch/arm/mach-s3c64xx/Makefile
> > +++ b/arch/arm/mach-s3c64xx/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
> >  obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
> >  obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
> >  obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
> > +obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
> >
> >  # PM
> >
> > diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-
> s3c64xx/clock.c
> > index 7a4138b..9dac5c4 100644
> > --- a/arch/arm/mach-s3c64xx/clock.c
> > +++ b/arch/arm/mach-s3c64xx/clock.c
> > @@ -304,6 +304,12 @@ static struct clk init_clocks[] = {
> >  		.id		= -1,
> >  		.parent		= &clk_p,
> >  		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
> > +	}, {
> > +		.name		= "cfcon",
> > +		.id		= -1,
> > +		.parent		= &clk_h,
> > +		.enable		= s3c64xx_hclk_ctrl,
> > +		.ctrlbit	= S3C_CLKCON_HCLK_IHOST,
> >  	}
> >  };
> >
> > diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-
> s3c64xx/include/mach/map.h
> > index e1eab3c..4b1ac79 100644
> > --- a/arch/arm/mach-s3c64xx/include/mach/map.h
> > +++ b/arch/arm/mach-s3c64xx/include/mach/map.h
> > @@ -86,6 +86,9 @@
> >  #define S3C64XX_SZ_GPIO		SZ_4K
> >
> >  #define S3C64XX_PA_SDRAM	(0x50000000)
> > +
> > +#define S3C64XX_PA_CFCON	(0x70300000)
> > +
> >  #define S3C64XX_PA_VIC0		(0x71200000)
> >  #define S3C64XX_PA_VIC1		(0x71300000)
> >
> > @@ -118,7 +121,7 @@
> >  #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
> >  #define S3C_PA_RTC		S3C64XX_PA_RTC
> >  #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
> > -
> > +#define SAMSUNG_PA_CFCON	S3C64XX_PA_CFCON
> >  #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
> >
> >  #endif /* __ASM_ARCH_6400_MAP_H */
> > diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> > index 0114eb0..05332b9 100644
> > --- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> > +++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
> > @@ -34,6 +34,7 @@
> >  #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
> >  #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
> >  #define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
> > +#define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
> >
> >  /* CLKDIV0 */
> >  #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
> > @@ -154,4 +155,8 @@
> >  #define S3C6400_CLKSRC_EPLL_MOUT_SHIFT	(2)
> >  #define S3C6400_CLKSRC_MFC		(1 << 4)
> >
> > +/* MEM_SYS_CFG */
> > +#define MEM_SYS_CFG_INDEP_CF		0x4000
> > +#define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
> > +
> >  #endif /* _PLAT_REGS_CLOCK_H */
> > diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
> s3c64xx/mach-smdk6410.c
> > index d9a0355..cc1bb0f 100644
> > --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> > @@ -56,6 +56,7 @@
> >  #include <mach/regs-gpio.h>
> >  #include <mach/regs-sys.h>
> >  #include <mach/regs-srom.h>
> > +#include <plat/ata.h>
> >  #include <plat/iic.h>
> >  #include <plat/fb.h>
> >  #include <plat/gpio-cfg.h>
> > @@ -242,6 +243,11 @@ static struct platform_device smdk6410_b_pwr_5v = {
> >  };
> >  #endif
> >
> > +static struct s3c_ide_platdata smdk6410_ide_pdata __initdata = {
> > +	.setup_gpio	= s3c_ide_setup_gpio,
> > +	.cfg_mode	= s3c_ide_cfg_mode,
> 
> 
> These should have been called s3c64xx_ide...
> 
> I'll have a think about what we should be doing with this, it might
> be wroth passing this via the archdata and leaving the platform data
> for the board. If these configs are generally going to be per SoC
> then i'd prefer to see this in the archdata and once per SoC.
> 
> > +};
> > +
> >  static struct map_desc smdk6410_iodesc[] = {};
> >
> >  static struct platform_device *smdk6410_devices[] __initdata = {
> > @@ -267,6 +273,7 @@ static struct platform_device *smdk6410_devices[]
> __initdata = {
> >  	&s3c_device_adc,
> >  	&s3c_device_ts,
> >  	&s3c_device_wdt,
> > +	&s3c_device_cfcon,
> >  };
> >
> >  #ifdef CONFIG_REGULATOR
> > @@ -665,6 +672,8 @@ static void __init smdk6410_machine_init(void)
> >  	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
> >  	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
> >
> > +	s3c_ide_set_platdata(&smdk6410_ide_pdata);
> > +
> >  	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
> >  }
> >
> > diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-
> s3c64xx/s3c6410.c
> > index 014401c..1d1dce4 100644
> > --- a/arch/arm/mach-s3c64xx/s3c6410.c
> > +++ b/arch/arm/mach-s3c64xx/s3c6410.c
> > @@ -58,6 +58,7 @@ void __init s3c6410_map_io(void)
> >  	s3c_device_nand.name = "s3c6400-nand";
> >  	s3c_onenand_setname("s3c6410-onenand");
> >  	s3c64xx_onenand1_setname("s3c6410-onenand");
> > +	s3c_device_cfcon.name = "s3c6400-pata";
> >  }
> 
> let's get this sorted out and use one method. see Kyungmin Park's prev.
> comments on the subject.

There are boards that doesn't have cf/ide connector at all. It would be good
to have s3c-dev not compiled in for some custom kernels. It would be better
to hide the driver name change behind a function/macro like it is done for
the one-nand driver.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



