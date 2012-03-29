From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 2/3] ep93xx: IDE driver platform support code
Date: Thu, 29 Mar 2012 11:26:41 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206970255B6@AUSP01VMBX24.collaborationhost.net>
References: <4F7418E7.4060500@metasoft.pl> <4F741B07.7040107@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail127.messagelabs.com ([216.82.250.115]:50905 "EHLO
	mail127.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab2C2Q0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2012 12:26:54 -0400
In-Reply-To: <4F741B07.7040107@metasoft.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "bzolnier@gmail.com" <bzolnier@gmail.com>, "ryan@bluewatersys.com" <ryan@bluewatersys.com>, "sshtylyov@ru.montavista.com" <sshtylyov@ru.montavista.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday, March 29, 2012 1:19 AM, Rafal Prylowski wrote:
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> ---
>  arch/arm/mach-ep93xx/core.c                  |   36 +++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/platform.h |    1
>  arch/arm/mach-ep93xx/soc.h                   |    1
>  3 files changed, 38 insertions(+)
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
> @@ -868,6 +868,42 @@ static struct platform_device ep93xx_wdt
>  	.resource	= ep93xx_wdt_resources,
>  };
>  
> +/*************************************************************************
> + * EP93xx IDE
> + *************************************************************************/
> +static struct resource ep93xx_ide_resources[] = {
> +	[0] = {
> +		.start	= EP93XX_IDE_PHYS_BASE,
> +		.end	= EP93XX_IDE_PHYS_BASE + 0xffff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_EP93XX_EXT3,
> +		.end	= IRQ_EP93XX_EXT3,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};

Please use the DEFINE_RES_* macros.
Also, the last register in the IDE interface is at offset 0x34, so something like this:

static struct resource ep93xx_ide_resources[] = {
	DEFINE_RES_MEM(EP93XX_IDE_PHYS_BASE, 0x38),
	DEFINE_RES_IRQ(IRQ_EP93XX_EXT3),
};

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
> +	/* GPIO ports E, G and H used by IDE */
> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
> +				 EP93XX_SYSCON_DEVCFG_GONIDE |
> +				 EP93XX_SYSCON_DEVCFG_HONIDE);
> +	platform_device_register(&ep93xx_ide_device);
> +}

Please create ep93xx_ide_acquire_gpio and ep93xx_ide_acquire_gpio functions
to set/clear the necessary SYSCON bits during the probe/remove of the ide driver.

This should also address your concern mentioned in PATCH 0/3 about making sure
the pin muxing is correct when the driver is loaded.

The *_acquire_gpio function should also gpio_request  the pins before setting the
SYSCON bits. That way if any of the pins are unavailable the driver will not load. Make
sure to gpio_free the pins in the *_release_gpio function.  Look at how the keypad
is handled for an example.

> +
>  void __init ep93xx_init_devices(void)
>  {
>  	/* Disallow access to MaverickCrunch initially */
> Index: linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -48,6 +48,7 @@ void ep93xx_register_i2s(void);
>  int ep93xx_i2s_acquire(void);
>  void ep93xx_i2s_release(void);
>  void ep93xx_register_ac97(void);
> +void ep93xx_register_ide(void);
>  
>  void ep93xx_init_devices(void);
>  extern struct sys_timer ep93xx_timer;

Regards,
Hartley

