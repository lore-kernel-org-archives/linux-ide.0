From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH v3 2/3] ep93xx: IDE driver platform support code
Date: Mon, 04 Jun 2012 15:00:38 +1000
Message-ID: <4FCC40F6.7040400@gmail.com>
References: <4F86C63C.6030908@metasoft.pl> <4F86C714.4090605@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51152 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2FDFAq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2012 01:00:46 -0400
Received: by pbbrp8 with SMTP id rp8so5485408pbb.19
        for <linux-ide@vger.kernel.org>; Sun, 03 Jun 2012 22:00:46 -0700 (PDT)
In-Reply-To: <4F86C714.4090605@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/04/12 22:14, Rafal Prylowski wrote:

> 
> Add IDE driver platform support code for ep93xx.
> 
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>

Applied to ep93xx-devel. Sorry for the delay.

~Ryan

> ---
>  arch/arm/mach-ep93xx/core.c                  |   96 +++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/platform.h |    3
>  arch/arm/mach-ep93xx/soc.h                   |    1
> 
> Index: linux-2.6/arch/arm/mach-ep93xx/soc.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/soc.h
> +++ linux-2.6/arch/arm/mach-ep93xx/soc.h
> @@ -69,6 +69,7 @@
>  
>  #define EP93XX_BOOT_ROM_BASE		EP93XX_AHB_IOMEM(0x00090000)
>  
> +#define EP93XX_IDE_PHYS_BASE		EP93XX_AHB_PHYS(0x000a0000)
>  #define EP93XX_IDE_BASE			EP93XX_AHB_IOMEM(0x000a0000)
>  
>  #define EP93XX_VIC1_BASE		EP93XX_AHB_IOMEM(0x000b0000)
> Index: linux-2.6/arch/arm/mach-ep93xx/core.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
> +++ linux-2.6/arch/arm/mach-ep93xx/core.c
> @@ -868,6 +868,102 @@ static struct platform_device ep93xx_wdt
>  	.resource	= ep93xx_wdt_resources,
>  };
>  
> +/*************************************************************************
> + * EP93xx IDE
> + *************************************************************************/
> +static struct resource ep93xx_ide_resources[] = {
> +	DEFINE_RES_MEM(EP93XX_IDE_PHYS_BASE, 0x38),
> +	DEFINE_RES_IRQ(IRQ_EP93XX_EXT3),
> +};
> +
> +static struct platform_device ep93xx_ide_device = {
> +	.name		= "ep93xx-ide",
> +	.id		= -1,
> +	.dev		= {
> +		.dma_mask		= &ep93xx_ide_device.dev.coherent_dma_mask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +	},
> +	.num_resources	= ARRAY_SIZE(ep93xx_ide_resources),
> +	.resource	= ep93xx_ide_resources,
> +};
> +
> +void __init ep93xx_register_ide(void)
> +{
> +	platform_device_register(&ep93xx_ide_device);
> +}
> +
> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
> +{
> +	int err;
> +	int i;
> +
> +	err = gpio_request(EP93XX_GPIO_LINE_EGPIO2, dev_name(&pdev->dev));
> +	if (err)
> +		return err;
> +	err = gpio_request(EP93XX_GPIO_LINE_EGPIO15, dev_name(&pdev->dev));
> +	if (err)
> +		goto fail_egpio15;
> +	for (i = 2; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_e;
> +	}
> +	for (i = 4; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_g;
> +	}
> +	for (i = 0; i < 8; i++) {
> +		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
> +		if (err)
> +			goto fail_gpio_h;
> +	}
> +
> +	/* GPIO ports E[7:2], G[7:4] and H used by IDE */
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
> +				 EP93XX_SYSCON_DEVCFG_GONIDE |
> +				 EP93XX_SYSCON_DEVCFG_HONIDE);
> +	return 0;
> +
> +fail_gpio_h:
> +	for (--i; i >= 0; --i)
> +		gpio_free(EP93XX_GPIO_LINE_H(i));
> +	i = 8;
> +fail_gpio_g:
> +	for (--i; i >= 4; --i)
> +		gpio_free(EP93XX_GPIO_LINE_G(i));
> +	i = 8;
> +fail_gpio_e:
> +	for (--i; i >= 2; --i)
> +		gpio_free(EP93XX_GPIO_LINE_E(i));
> +	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
> +fail_egpio15:
> +	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
> +	return err;
> +}
> +EXPORT_SYMBOL(ep93xx_ide_acquire_gpio);
> +
> +void ep93xx_ide_release_gpio(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 2; i < 8; i++)
> +		gpio_free(EP93XX_GPIO_LINE_E(i));
> +	for (i = 4; i < 8; i++)
> +		gpio_free(EP93XX_GPIO_LINE_G(i));
> +	for (i = 0; i < 8; i++)
> +		gpio_free(EP93XX_GPIO_LINE_H(i));
> +	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
> +	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
> +
> +
> +	/* GPIO ports E[7:2], G[7:4] and H used by GPIO */
> +	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
> +			       EP93XX_SYSCON_DEVCFG_GONIDE |
> +			       EP93XX_SYSCON_DEVCFG_HONIDE);
> +}
> +EXPORT_SYMBOL(ep93xx_ide_release_gpio);
> +
>  void __init ep93xx_init_devices(void)
>  {
>  	/* Disallow access to MaverickCrunch initially */
> Index: linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -48,6 +48,9 @@ void ep93xx_register_i2s(void);
>  int ep93xx_i2s_acquire(void);
>  void ep93xx_i2s_release(void);
>  void ep93xx_register_ac97(void);
> +void ep93xx_register_ide(void);
> +int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
> +void ep93xx_ide_release_gpio(struct platform_device *pdev);
>  
>  void ep93xx_init_devices(void);
>  extern struct sys_timer ep93xx_timer;


