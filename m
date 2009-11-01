From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 5/7] S3C64XX: Add platform data and driver resources for IDE controller driver.
Date: Sun, 1 Nov 2009 13:05:02 +0000
Message-ID: <20091101130502.GI8096@trinity.fluff.org>
References: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:34459 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbZKANE5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2009 08:04:57 -0500
Content-Disposition: inline
In-Reply-To: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: ben-linux@fluff.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 01, 2009 at 01:56:43PM +0900, Thomas Abraham wrote:
> This patch adds the following for S3C IDE driver.
> 	- IDE plafrom data strucure definition
> 	- IDE driver resources
> 	- IDE controller GPIO setup code
> 	- IDE platform data setup code
> 	- IDE platform device definition
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c/include/plat/devs.h |    1 +
>  arch/arm/plat-s3c/include/plat/ide.h  |   36 +++++++++++++
>  arch/arm/plat-s3c64xx/dev-ide.c       |   88 +++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/include/plat/ide.h
>  create mode 100644 arch/arm/plat-s3c64xx/dev-ide.c
> 
> diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
> index 0f540ea..4ae0c6a 100644
> --- a/arch/arm/plat-s3c/include/plat/devs.h
> +++ b/arch/arm/plat-s3c/include/plat/devs.h
> @@ -52,6 +52,7 @@ extern struct platform_device s3c_device_nand;
>  
>  extern struct platform_device s3c_device_usbgadget;
>  extern struct platform_device s3c_device_usb_hsotg;
> +extern struct platform_device s3c_device_cfcon;
>  
>  /* s3c2440 specific devices */
>  
> diff --git a/arch/arm/plat-s3c/include/plat/ide.h b/arch/arm/plat-s3c/include/plat/ide.h
> new file mode 100644
> index 0000000..3983891
> --- /dev/null
> +++ b/arch/arm/plat-s3c/include/plat/ide.h
> @@ -0,0 +1,36 @@
> +/* linux/arch/arm/plat-s3c/include/plat/ide.h
> + *
> + * Copyright (C) 2009 Samsung Electronics
> + * 	http://samsungsemi.com
> + *
> + * S3C IDE Platform data definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __PLAT_S3C_IDE_H
> +#define __PLAT_S3C_IDE_H __FILE__
> +
> +/**
> + * struct s3c_ide_platdata - S3C IDE driver platform data.
> + * @setup_gpio: Platform specific ide gpio setup function.
> + *
> + */
> +struct s3c_ide_platdata {
> +	void 	(*setup_gpio)(void);
> +};
> +
> +/*
> + * s3c_ide_set_platdata() - Setup the platform specifc data for IDE driver.
> + * @pdata: Platform data for IDE driver.
> + */
> +extern void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata);
> +
> +/*
> + * s3c64xx_ide_setup_gpio() - Platform specific ide gpio setup function.
> + */
> +extern void s3c64xx_ide_setup_gpio(void);
> +
> +#endif
> diff --git a/arch/arm/plat-s3c64xx/dev-ide.c b/arch/arm/plat-s3c64xx/dev-ide.c
> new file mode 100644
> index 0000000..946d323
> --- /dev/null
> +++ b/arch/arm/plat-s3c64xx/dev-ide.c
> @@ -0,0 +1,88 @@
> +/* linux/arch/arm/plat-s3c64xx/dev-ide.c
> + *
> + * Copyright (C) 2009 Samsung Electronics
> + * 	http://samsungsemi.com
> + *
> + * S3C IDE device definition.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/ata.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/irq.h>
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +#include <plat/regs-clock.h>
> +#include <plat/devs.h>
> +#include <plat/gpio-cfg.h>
> +#include <mach/gpio.h>
> +#include <plat/ide.h>
> +
> +static struct resource s3c_cfcon_resource[] = {
> +	[0] = {
> +		.start  = S3C64XX_PA_CFCON,
> +		.end    = S3C64XX_PA_CFCON + SZ_1M - 1,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = IRQ_CFCON,
> +		.end    = IRQ_CFCON,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device s3c_device_cfcon = {
> +	.name           = "s3c-ide",
> +	.id             = 0,
> +	.num_resources  = ARRAY_SIZE(s3c_cfcon_resource),
> +	.resource       = s3c_cfcon_resource,
> +};
> +EXPORT_SYMBOL(s3c_device_cfcon);
> +
> +void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
> +{
> +	struct s3c_ide_platdata *pd;
> +
> +	pd = (struct s3c_ide_platdata *)kmemdup(pdata,
> +		sizeof(struct s3c_ide_platdata), GFP_KERNEL);

you do not need pd = (struct s3c_ide_platdata *), the result of kmemdup
is 'void *' and thus can be cast to 'struct s3c_ide_platdata *'. Removing
this will make the code flow better.

> +	if (!pd) {
> +		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> +		return;
> +	}
> +	s3c_device_cfcon.dev.platform_data = pd;

doing:

	if (!pd)
		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
	else
		s3c_device_cfcon.dev.platform_data = pd;

would be better.
		
> +}
> +
> +void s3c64xx_ide_setup_gpio(void)
> +{
> +	u32 reg;
> +	u8 i;
> +
> +	reg = __raw_readl(S3C_MEM_SYS_CFG) & (~0x3f);
> +	 __raw_writel(reg | 0x4030, S3C_MEM_SYS_CFG);

less magic constants please.

> +	s3c_gpio_cfgpin(S3C64XX_GPB(4), S3C_GPIO_SFN(4));
> +
> +	/* Set XhiDATA[15:0] pins as CF Data[15:0] */
> +	for (i = 0; i < 16; i++)
> +		s3c_gpio_cfgpin(S3C64XX_GPK(i), S3C_GPIO_SFN(5));
> +
> +	/* Set XhiADDR[2:0] pins as CF ADDR[2:0] */
> +	for (i = 0; i < 3; i++)
> +		s3c_gpio_cfgpin(S3C64XX_GPL(i), S3C_GPIO_SFN(6));
> +
> +	/* Set Xhi ctrl pins as CF ctrl pins(IORDY, IOWR, IORD, CE[0:1]) */
> +	s3c_gpio_cfgpin(S3C64XX_GPM(5), S3C_GPIO_SFN(0));
> +	for (i = 0; i < 5; i++)
> +		s3c_gpio_cfgpin(S3C64XX_GPM(i), S3C_GPIO_SFN(6));
> +}

other than the comments, this looks ok.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

