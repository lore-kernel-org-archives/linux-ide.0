From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 3/4] davinci: da850: add support for SATA interface
Date: Thu, 24 Mar 2011 14:38:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47E42D@dbde02.ent.ti.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com>
 <1300879949-16379-2-git-send-email-nsekhar@ti.com>
 <1300879949-16379-3-git-send-email-nsekhar@ti.com>
 <4D89E308.8060404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57838 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1CXJJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2011 05:09:12 -0400
In-Reply-To: <4D89E308.8060404@mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sergei,

On Wed, Mar 23, 2011 at 17:39:44, Sergei Shtylyov wrote:

> > diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> > index 68fe4c2..276199d 100644
> > --- a/arch/arm/mach-davinci/da850.c
> > +++ b/arch/arm/mach-davinci/da850.c
> > @@ -373,6 +373,14 @@ static struct clk spi1_clk = {
> >   	.flags		= DA850_CLK_ASYNC3,
> >   };
> >
> > +static struct clk sata_clk = {
> > +	.name		= "sata",
> > +	.parent		=&pll0_sysclk2,
> > +	.lpsc		= DA850_LPSC1_SATA,
> > +	.gpsc		= 1,
> > +	.flags		= PSC_FORCE,
> > +};
> > +
> >   static struct clk_lookup da850_clks[] = {
> >   	CLK(NULL,		"ref",		&ref_clk),
> >   	CLK(NULL,		"pll0",		&pll0_clk),
> > @@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
> >   	CLK(NULL,		"usb20",	&usb20_clk),
> >   	CLK("spi_davinci.0",	NULL,		&spi0_clk),
> >   	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> > +	CLK("ahci",		NULL,		&sata_clk),
> >   	CLK(NULL,		NULL,		NULL),
> >   };
> 
>     I'd put the above into a separate patch...

Why should addition of clock data not be in the same patch
as the one which adds platform resources etc? It is not a big
deal to change, but I would like to know why you request this.

> 
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> > index 625d4b6..e061396 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> [...]
> > @@ -834,3 +836,139 @@ int __init da8xx_register_spi(int instance, struct spi_board_info *info,
> [...]
> > +/* Supported DA850 SATA crystal frequencies */
> > +#define KHZ_TO_HZ(freq) ((freq) * 1000)
> > +static unsigned long da850_sata_xtal[] = {
> > +	KHZ_TO_HZ(300000),
> > +	KHZ_TO_HZ(250000),
> > +	0,			/* Reserved */
> 
>     Why reserve a place for it at all?

Because then this table maps one-to-one to the hardware
defined table. This in turn keeps the init code pretty
simple. Plus, if and when hardware adds support for a
crystal there, the changes to rest of the code are minimal.

> 
> > +	KHZ_TO_HZ(187500),
> > +	KHZ_TO_HZ(150000),
> > +	KHZ_TO_HZ(125000),
> > +	KHZ_TO_HZ(120000),
> > +	KHZ_TO_HZ(100000),
> > +	KHZ_TO_HZ(75000),
> > +	KHZ_TO_HZ(60000),
> > +};
> > +
> > +static int da850_sata_init(struct device *dev, void __iomem *addr)
> > +{
> > +	int i, ret;
> > +	unsigned int val;
> > +
> > +	da850_sata_clk = clk_get(dev, NULL);
> > +	if (IS_ERR(da850_sata_clk))
> > +		return PTR_ERR(da850_sata_clk);
> > +
> > +	ret = clk_enable(da850_sata_clk);
> > +	if (ret)
> > +		goto err0;
> > +
> > +	/* Enable SATA clock receiver */
> > +	val = __raw_readl(DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
> > +	val&= ~BIT(0);
> > +	__raw_writel(val, DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
> > +
> > +	/* Get the multiplier needed for 1.5GHz PLL output */
> > +	for (i = 0; i<  ARRAY_SIZE(da850_sata_xtal); i++) {
> > +		if (da850_sata_xtal[i] == da850_sata_refclkpn)
> > +			break;
> > +	}
> 
>     {} not needed.

Okay, will remove.

> 
> > +
> > +	if (i == ARRAY_SIZE(da850_sata_xtal)) {
> > +		ret = -EINVAL;
> > +		goto err1;
> > +	} else {
> 
>     *else* not needed here, after *goto*.

Yup, will fix.

> 
> > +		val = SATA_PHY_MPY(i + 1);
> > +	}
> > +
> [...]
> 
> > diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> > index e4fc1af..aa6f08e 100644
> > --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> > +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> [...]
> > @@ -65,6 +66,7 @@ extern unsigned int da850_max_speed;
> >   #define DA8XX_GPIO_BASE		0x01e26000
> >   #define DA8XX_PSC1_BASE		0x01e27000
> >   #define DA8XX_LCD_CNTRL_BASE	0x01e13000
> > +#define DA850_SATA_BASE		0x01e18000
> 
>     It's used only in devices-da8xx.c -- shouldn't it be declared there?

Yes, will move. Base addresses for modules like LCD and MMCSD can be
moved as well - should be subject of some future clean-up patch.

Thanks,
Sekhar

