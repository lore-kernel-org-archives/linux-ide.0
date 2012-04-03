From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 2/3] ep93xx: IDE driver platform support code
Date: Tue, 3 Apr 2012 12:41:05 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409DF4@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0D6C.1010801@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:5659 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab2DCRlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 13:41:11 -0400
In-Reply-To: <4F7B0D6C.1010801@metasoft.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On Tuesday, April 03, 2012 7:47 AM, Rafal Prylowski wrote:
>
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>

There should be some sort of commit blurb here..
>
> ---
>  arch/arm/mach-ep93xx/core.c                  |   85 +++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/platform.h |    3
>  arch/arm/mach-ep93xx/soc.h                   |    1
>  3 files changed, 89 insertions(+)
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
> @@ -868,6 +868,91 @@ static struct platform_device ep93xx_wdt
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

Looks good. For this ep93xx core piece:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

