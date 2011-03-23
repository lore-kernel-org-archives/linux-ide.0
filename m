From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/4] davinci: da850: add support for SATA interface
Date: Wed, 23 Mar 2011 15:09:44 +0300
Message-ID: <4D89E308.8060404@mvista.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com> <1300879949-16379-2-git-send-email-nsekhar@ti.com> <1300879949-16379-3-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46171 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1CWMLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2011 08:11:15 -0400
Received: by eyx24 with SMTP id 24so2113573eyx.19
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2011 05:11:14 -0700 (PDT)
In-Reply-To: <1300879949-16379-3-git-send-email-nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Hello.

On 23-03-2011 14:32, Sekhar Nori wrote:

> Add support for SATA controller on the
> DA850/OMAP-L138/AM18x devices.

> The patch adds the necessary clocks, platform
> resources and a routine to initialize the SATA
> controller.

> The PHY configuration in this patch is
> courtesy the work done by Zegeye Alemu,
> Swaminathan and Mansoor Ahamed from TI.

> While testing this patch, enable port multiplier
> support iff you are actually using one. The
> reasons of this behaviour are discussed
> here: http://patchwork.ozlabs.org/patch/78163/

> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
> Cc: linux-ide@vger.kernel.org
[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 68fe4c2..276199d 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -373,6 +373,14 @@ static struct clk spi1_clk = {
>   	.flags		= DA850_CLK_ASYNC3,
>   };
>
> +static struct clk sata_clk = {
> +	.name		= "sata",
> +	.parent		=&pll0_sysclk2,
> +	.lpsc		= DA850_LPSC1_SATA,
> +	.gpsc		= 1,
> +	.flags		= PSC_FORCE,
> +};
> +
>   static struct clk_lookup da850_clks[] = {
>   	CLK(NULL,		"ref",		&ref_clk),
>   	CLK(NULL,		"pll0",		&pll0_clk),
> @@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
>   	CLK(NULL,		"usb20",	&usb20_clk),
>   	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>   	CLK("spi_davinci.1",	NULL,		&spi1_clk),
> +	CLK("ahci",		NULL,		&sata_clk),
>   	CLK(NULL,		NULL,		NULL),
>   };

    I'd put the above into a separate patch...

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 625d4b6..e061396 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
[...]
> @@ -834,3 +836,139 @@ int __init da8xx_register_spi(int instance, struct spi_board_info *info,
[...]
> +/* Supported DA850 SATA crystal frequencies */
> +#define KHZ_TO_HZ(freq) ((freq) * 1000)
> +static unsigned long da850_sata_xtal[] = {
> +	KHZ_TO_HZ(300000),
> +	KHZ_TO_HZ(250000),
> +	0,			/* Reserved */

    Why reserve a place for it at all?

> +	KHZ_TO_HZ(187500),
> +	KHZ_TO_HZ(150000),
> +	KHZ_TO_HZ(125000),
> +	KHZ_TO_HZ(120000),
> +	KHZ_TO_HZ(100000),
> +	KHZ_TO_HZ(75000),
> +	KHZ_TO_HZ(60000),
> +};
> +
> +static int da850_sata_init(struct device *dev, void __iomem *addr)
> +{
> +	int i, ret;
> +	unsigned int val;
> +
> +	da850_sata_clk = clk_get(dev, NULL);
> +	if (IS_ERR(da850_sata_clk))
> +		return PTR_ERR(da850_sata_clk);
> +
> +	ret = clk_enable(da850_sata_clk);
> +	if (ret)
> +		goto err0;
> +
> +	/* Enable SATA clock receiver */
> +	val = __raw_readl(DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
> +	val&= ~BIT(0);
> +	__raw_writel(val, DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
> +
> +	/* Get the multiplier needed for 1.5GHz PLL output */
> +	for (i = 0; i<  ARRAY_SIZE(da850_sata_xtal); i++) {
> +		if (da850_sata_xtal[i] == da850_sata_refclkpn)
> +			break;
> +	}

    {} not needed.

> +
> +	if (i == ARRAY_SIZE(da850_sata_xtal)) {
> +		ret = -EINVAL;
> +		goto err1;
> +	} else {

    *else* not needed here, after *goto*.

> +		val = SATA_PHY_MPY(i + 1);
> +	}
> +
[...]

> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index e4fc1af..aa6f08e 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
[...]
> @@ -65,6 +66,7 @@ extern unsigned int da850_max_speed;
>   #define DA8XX_GPIO_BASE		0x01e26000
>   #define DA8XX_PSC1_BASE		0x01e27000
>   #define DA8XX_LCD_CNTRL_BASE	0x01e13000
> +#define DA850_SATA_BASE		0x01e18000

    It's used only in devices-da8xx.c -- shouldn't it be declared there?

WBR, Sergei
