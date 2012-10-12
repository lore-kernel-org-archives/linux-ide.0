From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 6/6] ARM: EXYNOS5: SATA PHY controller driver
Date: Sat, 13 Oct 2012 00:50:27 +0200
Message-ID: <10179968.slaZyPIETn@flatron>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com> <1349783332-18467-7-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35425 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab2JLWu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2012 18:50:27 -0400
In-Reply-To: <1349783332-18467-7-git-send-email-vasanthananthan@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>

Hi,

On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:
> This patch adds a platform driver and I2C client driver for SATA PHY
> controller
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  drivers/ata/Makefile          |    2 +-
>  drivers/ata/sata_exynos_phy.c |  303
> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304
> insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/sata_exynos_phy.c
> 
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 33fb2f6..769d945 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
> -obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o sata_exynos.o
> libahci.o +obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o
> sata_exynos_phy.o sata_exynos.o libahci.o
> 
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/sata_exynos_phy.c
> b/drivers/ata/sata_exynos_phy.c new file mode 100644
> index 0000000..44861de
> --- /dev/null
> +++ b/drivers/ata/sata_exynos_phy.c
> @@ -0,0 +1,303 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com
> + *
> + * EXYNOS - SATA PHY controller driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as +
> * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ahci_platform.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +
> +#include <plat/cpu.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +#include <mach/regs-pmu.h>
> +#include <mach/regs-sata.h>
> +
> +#include "sata_phy.h"
> +
> +#define	SATA_TIME_LIMIT		1000
> +
> +static struct i2c_client *i2c_client;
> +
> +static struct i2c_driver sataphy_i2c_driver;
> +
> +struct exynos_sata_phy {
> +	void __iomem *mmio;
> +	struct resource *mem;
> +	struct clk *clk;
> +};
> +
> +static bool sata_is_reg(void __iomem *base, u32 reg, u32 checkbit, u32
> Status) +{

Please use lowercase for variable names.

> +	if ((readl(base + reg) & checkbit) == Status)
> +		return true;
> +	else
> +		return false;
> +}
> +
> +static bool wait_for_reg_status(void __iomem *base, u32 reg, u32
> checkbit, +				u32 Status)

Same here.

> +{
> +	u16 time_limit_cnt = 0;
> +	while (!sata_is_reg(base, reg, checkbit, Status)) {
> +		if (time_limit_cnt == SATA_TIME_LIMIT)
> +			return false;
> +		udelay(1000);
> +		time_limit_cnt++;
> +	}
> +	return true;
> +}
> +
> +int sataphy_init(struct sata_phy *phy)

static int sataphy_init(struct sata_phy *phy) ?

> +{
> +	int ret;
> +	u32 val;
> +
> +	/* Values to be written to enable 40 bits interface */
> +	u8 buf[] = { 0x3A, 0x0B };
> +
> +	struct exynos_sata_phy *sata_phy;
> +
> +	sata_phy = (struct exynos_sata_phy *)phy->priv_data;
> +
> +	clk_enable(sata_phy->clk);
> +
> +	writel(S5P_PMU_SATA_PHY_CONTROL_EN, EXYNOS5_SATA_PHY_CONTROL);
> +
> +	val = 0;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> +	val |= 0xFF;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> +	val |= LINK_RESET;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> +	val |= RESET_CMN_RST_N;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> +	val &= ~PHCTRLM_REF_RATE;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> +
> +	/* High speed enable for Gen3 */
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> +	val |= PHCTRLM_HIGH_SPEED;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_CTRL0);
> +	val |= CTRL0_P0_PHY_CALIBRATED_SEL | CTRL0_P0_PHY_CALIBRATED;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_CTRL0);
> +
> +	writel(SATA_PHY_GENERATION3, sata_phy->mmio + EXYNOS5_SATA_MODE0);
> +
> +	ret = i2c_master_send(i2c_client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	/* release cmu reset */
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> +	val &= ~RESET_CMN_RST_N;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> +	val |= RESET_CMN_RST_N;
> +	writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> +
> +	if (wait_for_reg_status(sata_phy->mmio, EXYNOS5_SATA_PHSATA_STATM,
> +				PHSTATM_PLL_LOCKED, 1)) {
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +int sataphy_shutdown(struct sata_phy *phy)

static int sataphy_shutdown(struct sata_phy *phy) ?

> +{
> +
> +	struct exynos_sata_phy *sata_phy;
> +
> +	sata_phy = (struct exynos_sata_phy *)phy->priv_data;
> +
> +	clk_disable(sata_phy->clk);
> +
> +	return 0;
> +}
> +
> +static int sata_i2c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *i2c_id)
> +{
> +	i2c_client = client;
> +	return 0;
> +}
> +
> +static int __init sata_phy_probe(struct platform_device *pdev)
> +{
> +	struct exynos_sata_phy *sataphy;
> +	struct sata_phy *phy;
> +	struct resource *res;
> +	int ret = 0;
> +
> +	phy = kzalloc(sizeof(struct sata_phy), GFP_KERNEL);

devm_

> +	if (!phy) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	sataphy = kzalloc(sizeof(struct exynos_sata_phy), GFP_KERNEL);

devm_

> +	if (!sataphy) {
> +		dev_err(&pdev->dev, "failed to allocate memory\n");
> +		ret = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Could not find IO resource\n");
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	sataphy->mem = request_mem_region(res->start, resource_size(res),
> +								pdev->name);

devm_

> +	if (!sataphy->mem) {
> +		dev_err(&pdev->dev, "Could not request IO resource\n");
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	sataphy->mmio =
> +	    ioremap(res->start, resource_size(res));

devm_

> +

nitpick: Unnecessary blank line.

> +	if (!sataphy->mmio) {
> +		dev_err(&pdev->dev, "failed to remap IO\n");
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	sataphy->clk = clk_get(&pdev->dev, "sata_phy");

devm_

> +	if (IS_ERR(sataphy->clk)) {
> +		dev_err(&pdev->dev, "failed to get clk for PHY\n");
> +		ret = PTR_ERR(sataphy->clk);
> +		sataphy->clk = NULL;
> +		goto err3;
> +	}
> +
> +	phy->init = sataphy_init;
> +	phy->shutdown = sataphy_shutdown;
> +	phy->priv_data = (void *)sataphy;
> +	phy->dev = &pdev->dev;
> +
> +	ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
> +	if (ret < 0)
> +		goto err4;

Do you have any warranties that phy callbacks won't get called before i2c 
device probes and sets i2c_client?

> +
> +	ret = i2c_add_driver(&sataphy_i2c_driver);
> +	if (ret < 0)
> +		goto err5;
> +
> +	platform_set_drvdata(pdev, phy);
> +
> +	return ret;
> +
> + err5:
> +	sata_remove_phy(phy);
> +
> + err4:
> +	clk_put(sataphy->clk);
> +
> + err3:
> +	iounmap(sataphy->mmio);
> +
> + err2:
> +	release_resource(sataphy->mem);
> +
> + err1:
> +	kfree(sataphy);
> +
> + err0:
> +	kfree(phy);
> +
> + out:
> +	return ret;
> +}
> +
> +static int sata_phy_remove(struct platform_device *pdev)
> +{
> +	struct sata_phy *phy;
> +	struct exynos_sata_phy *sataphy;
> +
> +	phy = platform_get_drvdata(pdev);
> +
> +	sataphy = (struct exynos_sata_phy *)phy->priv_data;
> +	sata_remove_phy(phy);
> +
> +	iounmap(sataphy->mmio);
> +
> +	release_resource(sataphy->mem);
> +
> +	clk_disable(sataphy->clk);
> +	clk_put(sataphy->clk);
> +
> +	kfree(sataphy);
> +	kfree(phy);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sata_phy_of_match[] = {
> +	{.compatible = "samsung,exynos-sata-phy",},

nitpick: Space after opening and before closing brackets.

> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, sata_phy_of_match);
> +
> +static const struct i2c_device_id phy_i2c_device_match[] = {
> +	{"sataphy", 0},

Same here.

> +};
> +
> +MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
> +
> +static struct platform_driver sata_phy_driver = {
> +	.probe = sata_phy_probe,
> +	.remove = sata_phy_remove,
> +	.driver = {
> +		   .name = "sata-phy",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = sata_phy_of_match,
> +		   },

nitpick: Wrong indentation of closing bracket.

> +};
> +
> +static struct i2c_driver sataphy_i2c_driver = {
> +	.driver = {
> +		   .name = "i2c-phy",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = phy_i2c_device_match,
> +		   },

nitpick: Wrong indentation of closing bracket.

Best regards,
Tomasz Figa

