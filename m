From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
 platforms
Date: Tue, 20 Sep 2011 22:30:37 +0200
Message-ID: <20110920203037.GE31404@pengutronix.de>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
 <1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44537 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab1ITUar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2011 16:30:47 -0400
Content-Disposition: inline
In-Reply-To: <1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On Wed, Aug 31, 2011 at 11:50:31AM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> Tested-By: Hector Oron Martinez <hector.oron@gmail.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c             |   19 ++++
>  arch/arm/mach-mx5/devices-imx53.h               |    4 +
>  arch/arm/plat-mxc/Makefile                      |    1 +
>  arch/arm/plat-mxc/ahci_sata.c                   |  104 +++++++++++++++++++++++
>  arch/arm/plat-mxc/devices/Kconfig               |    4 +
>  arch/arm/plat-mxc/devices/Makefile              |    1 +
>  arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   66 ++++++++++++++
>  arch/arm/plat-mxc/include/mach/ahci_sata.h      |   33 +++++++
>  arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++
>  9 files changed, 242 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/ahci_sata.c
>  create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 7f20308..e1fadaf 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1397,6 +1397,22 @@ static struct clk esdhc4_mx53_clk = {
>  	.secondary = &esdhc4_ipg_clk,
>  };
>  
> diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahci_sata.c
> new file mode 100644
> index 0000000..4f54816
> --- /dev/null
> +++ b/arch/arm/plat-mxc/ahci_sata.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <mach/ahci_sata.h>
> +
> +static struct clk *sata_clk, *sata_ref_clk;

These variables make the driver single instance only.

> +
> +/* AHCI module Initialization, if return 0, initialization is successful. */
> +int sata_init(struct device *dev, void __iomem *addr)

A global function with such a generic name is not a good idea.
Also I wonder how we want to convert this to devicetree when we
implement this as a platform specific hook. It should be done in the
driver.

> +{
> +	u32 tmpdata;
> +	int ret = 0;
> +	struct clk *clk;
> +
> +	sata_clk = clk_get(dev, "ahci");
> +	if (IS_ERR(sata_clk)) {
> +		dev_err(dev, "no sata clock.\n");
> +		return PTR_ERR(sata_clk);
> +	}
> +	ret = clk_enable(sata_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata clock.\n");
> +		goto put_sata_clk;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */

So this function is loco specific or is the comment wrong?

> +	sata_ref_clk = clk_get(dev, "ahci_phy");
> +	if (IS_ERR(sata_ref_clk)) {
> +		dev_err(dev, "no sata ref clock.\n");
> +		ret = PTR_ERR(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +	ret = clk_enable(sata_ref_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata ref clock.\n");
> +		goto put_sata_ref_clk;
> +	}
> +
> +	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
> +	clk = clk_get(dev, "ahci_dma");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no dma clock.\n");
> +		ret = PTR_ERR(clk);
> +		goto release_sata_ref_clk;
> +	}
> +	tmpdata = clk_get_rate(clk) / 1000;
> +	clk_put(clk);
> +
> +	writel(tmpdata, addr + HOST_TIMER1MS);
> +
> +	tmpdata = readl(addr + HOST_CAP);
> +	if (!(tmpdata & HOST_CAP_SSS)) {
> +		tmpdata |= HOST_CAP_SSS;
> +		writel(tmpdata, addr + HOST_CAP);
> +	}
> +
> +	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
> +		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
> +			addr + HOST_PORTS_IMPL);
> +
> +	return 0;
> +
> +release_sata_ref_clk:
> +	clk_disable(sata_ref_clk);
> +put_sata_ref_clk:
> +	clk_put(sata_ref_clk);
> +release_sata_clk:
> +	clk_disable(sata_clk);
> +put_sata_clk:
> +	clk_put(sata_clk);
> +
> +	return ret;
> +}
> +
> +void sata_exit(struct device *dev)
> +{
> +	clk_disable(sata_ref_clk);
> +	clk_put(sata_ref_clk);
> +
> +	clk_disable(sata_clk);
> +	clk_put(sata_clk);
> +
> +}
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
> index bd294ad..f63887b 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -76,3 +76,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>  
>  config IMX_HAVE_PLATFORM_SPI_IMX
>  	bool
> +
> +config IMX_HAVE_PLATFORM_AHCI
> +	bool
> +	default y if ARCH_MX53
> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> index b41bf97..e858ad9 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=  platform-ahci-imx.o
> diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> new file mode 100644
> index 0000000..9e1b460
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <asm/sizes.h>
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +#include <mach/ahci_sata.h>
> +
> +#define imx_ahci_imx_data_entry_single(soc, _devid)		\
> +	{								\
> +		.devid = _devid,					\
> +		.iobase = soc ## _SATA_BASE_ADDR,			\
> +		.irq = soc ## _INT_SATA,				\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
> +	imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
> +#endif
> +
> +static struct ahci_platform_data default_sata_pdata = {
> +	.init = sata_init,
> +	.exit = sata_exit,
> +};
> +
> +struct platform_device *__init imx_add_ahci_imx(
> +		const struct imx_ahci_imx_data *data,
> +		const struct ahci_platform_data *pdata)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = data->iobase,
> +			.end = data->iobase + SZ_4K - 1,
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = data->irq,
> +			.end = data->irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +
> +	if (pdata == NULL)
> +		pdata = &default_sata_pdata;
> +
> +	return imx_add_platform_device_dmamask(data->devid, 0,
> +			res, ARRAY_SIZE(res),
> +			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
> +}
> diff --git a/arch/arm/plat-mxc/include/mach/ahci_sata.h b/arch/arm/plat-mxc/include/mach/ahci_sata.h
> new file mode 100644
> index 0000000..ba297e1
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/ahci_sata.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef __PLAT_MXC_AHCI_SATA_H__
> +#define __PLAT_MXC_AHCI_SATA_H__
> +
> +enum {
> +	HOST_CAP = 0x00,
> +	HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
> +	HOST_PORTS_IMPL	= 0x0c,
> +	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
> +};
> +
> +extern int sata_init(struct device *dev, void __iomem *addr);
> +extern void sata_exit(struct device *dev);
> +#endif /* __PLAT_MXC_AHCI_SATA_H__ */
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 524538a..f04e063 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -301,3 +301,13 @@ struct platform_device *__init imx_add_spi_imx(
>  struct platform_device *imx_add_imx_dma(void);
>  struct platform_device *imx_add_imx_sdma(char *name,
>  	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
> +
> +#include <linux/ahci_platform.h>
> +struct imx_ahci_imx_data {
> +	const char *devid;
> +	resource_size_t iobase;
> +	resource_size_t irq;
> +};
> +struct platform_device *__init imx_add_ahci_imx(
> +		const struct imx_ahci_imx_data *data,
> +		const struct ahci_platform_data *pdata);
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
