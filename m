From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/3] ahci: exynos: add ahci sata support on Exynos platform
Date: Thu, 03 Oct 2013 13:32:29 +0200
Message-ID: <1534631.KrL0vInDuc@amdc1032>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
 <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1380609183-21430-2-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: tj@kernel.org, kgene.kim@samsung.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, kishon@ti.com, s.nawrocki@samsung.com, ks.giri@samsung.com, aditya.ps@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-ide@vger.kernel.org


Hi,

On Tuesday, October 01, 2013 12:03:01 PM Yuvaraj Kumar C D wrote:
> Exynos5250 contains one Synopsys AHCI SATA controller.The avalaible
> ahci_platform driver is not sufficient to handle the AHCI PHY and PHY
> clock related initialization.
> 
> This patch adds exynos specific ahci sata driver,contained the exynos
> specific initialized codes, re-use the generic ahci_platform driver, and
> keep the generic ahci_platform driver clean as much as possible.
> 
> This patch depends on the below patch
> 	[1].drivers: phy: add generic PHY framework
> 		by Kishon Vijay Abraham I<kishon@ti.com>
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/ata/Kconfig       |    9 ++
>  drivers/ata/Makefile      |    1 +
>  drivers/ata/ahci_exynos.c |  226 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 236 insertions(+)
>  create mode 100644 drivers/ata/ahci_exynos.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 4e73772..99b2392 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -106,6 +106,15 @@ config AHCI_IMX
>  
>  	  If unsure, say N.
>  
> +config AHCI_EXYNOS
> +	tristate "Samsung Exynos AHCI SATA support"
> +	depends on SATA_AHCI_PLATFORM

This should also depend on SOC_EXYNOS5250.

> +	help
> +	  This option enables support for the Samsung's Exynos SoC's
> +	  onboard AHCI SATA.
> +
> +	  If unsure, say N.
> +
>  config SATA_FSL
>  	tristate "Freescale 3.0Gbps SATA support"
>  	depends on FSL_SOC
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 46518c6..0e1f420f 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>  obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
>  obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
> +obj-$(CONFIG_AHCI_EXYNOS)	+= ahci_exynos.o
>  
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/ahci_exynos.c b/drivers/ata/ahci_exynos.c
> new file mode 100644
> index 0000000..7f0af00
> --- /dev/null
> +++ b/drivers/ata/ahci_exynos.c
> @@ -0,0 +1,226 @@
> +/*
> + * Samsung AHCI SATA platform driver
> + * Copyright 2013 Samsung Electronics Co., Ltd.
> + *
> + * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>

This include doesn't seem to be needed.

> +#include <linux/io.h>
> +#include <linux/ahci_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include "ahci.h"
> +
> +#define MHZ             (1000 * 1000)
> +
> +struct exynos_ahci_priv {
> +	struct platform_device *ahci_pdev;
> +	struct clk *sclk;
> +	unsigned int freq;
> +	struct phy *phy;
> +};
> +
> +static int exynos_sata_init(struct device *dev, void __iomem *mmio)
> +{
> +	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	priv->phy = devm_phy_get(dev , "sata-phy");
> +	if (IS_ERR(priv->phy))
> +		return PTR_ERR(priv->phy);

This should happen in ->probe (exynos_sata_init() is also called in
exynos_sata_resume() so the above code will be executed on every
resume operation which is incorrect).

Also please take a look at the following patch:

https://lkml.org/lkml/2013/9/19/173

it adds PHY support to ahci_platform driver, maybe it can be used
for your needs as well.

> +	ret = phy_init(priv->phy);
> +	if (ret < 0) {
> +			dev_err(dev, "failed to init SATA PHY\n");
> +			return ret;
> +	}
> +
> +	ret = clk_prepare_enable(priv->sclk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable source clk\n");
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(priv->sclk, priv->freq * MHZ);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set clk frequency\n");
> +		clk_disable_unprepare(priv->sclk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void exynos_sata_exit(struct device *dev)
> +{
> +	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
> +	if (!IS_ERR(priv->sclk))
> +		clk_disable_unprepare(priv->sclk);
> +}
> +
> +static int exynos_sata_suspend(struct device *dev)
> +{
> +	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
> +
> +	if (!IS_ERR(priv->sclk))
> +		clk_disable_unprepare(priv->sclk);
> +	phy_power_off(priv->phy);
> +	return 0;
> +}
> +
> +static int exynos_sata_resume(struct device *dev)
> +{
> +	struct exynos_ahci_priv *priv = dev_get_drvdata(dev->parent);
> +	phy_power_on(priv->phy);
> +	exynos_sata_init(dev, NULL);
> +	return 0;

It should be:

	return exynos_sata_init(dev, NULL);

Also please fix exynos_sata_suspend() to call exynos_sata_exit().

[...]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
