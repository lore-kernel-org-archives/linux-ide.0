Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB898298271;
	Thu, 15 May 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310192; cv=none; b=J07h3NrVbK4ZgMcHMrJ1Mb2GWdcERgJngDFpbkKo6OzlGfCD5vIjoiH6mpC6FOqajVfC+Q71L3y1Mg7Bg2kBoM7l/73vILZR8b8r4R4E6iYQ9F8orRyBSVA6eZ8sPxq36QnK8fZbX0ymZToI4ajTZCEArY+fX3S00yLMNiIJxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310192; c=relaxed/simple;
	bh=AodoqcXXPrd9Uq7N0GICLhOSesKv5xDG9mZyaNSIxJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/bqmV+uLTKiPWj2MyoebUoL7YMgc9bkUW2kWh9mXaRGZMsWo71PZ7ioyO49hf54RQmiIu2/buK2fB2pCEW96lAmbnV9zOqwcOyR9l3umBDLl2+j/cJYc3ByRZWfg1sqCnps9APCR95n3s4WNq/xMJ3ZmyDZiP/5GracdjGxSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG2aEzmo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG2aEzmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53E7C4CEE7;
	Thu, 15 May 2025 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747310191;
	bh=AodoqcXXPrd9Uq7N0GICLhOSesKv5xDG9mZyaNSIxJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fG2aEzmoeJ3fShuvio2BxZWQI3JHHtBzcrE5rF6F2NEM4Vh2VMOnVE6up6RRQP6Fh
	 hP51QcZfxZJJlA0w3cbAtt54rUDmoknOF2Azk2SCHyZqzuWiaRMuPmYbBsaZCXVrou
	 f9pgItdV7SA62hdkg/BzJBVtFeicyQeWZBFLl1HyCwXi52ekKRWAwQZmZQRdK4rdkM
	 nVl9qu+BeaoWWAHuK7lTfE0Pk7rn2wyj4p3kp3e6uuAK+zoZevUC0nENnEPSEja2+v
	 Zb7vLL4GcN65caUWBa5on5OXEpKCXH1xMjv3yZ2k6eBIWNayeeWzSBGTO5nEr78Qe3
	 A30xd4s7D9YPg==
Date: Thu, 15 May 2025 13:56:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: hehuan1@eswincomputing.com
Cc: dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, luyulin@eswincomputing.com,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v1 2/2] sata: eswin: Add eic7700 sata driver
Message-ID: <aCXWalhB7dQmsN8K@ryzen>
References: <20250515085114.1692-1-hehuan1@eswincomputing.com>
 <20250515090018.1720-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515090018.1720-1-hehuan1@eswincomputing.com>

Hello Huan He,

On Thu, May 15, 2025 at 05:00:18PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Add support for the AHCI SATA controller in Eswin's eic7700 soc,
> which supports SATA PHY initialization, reset control,
> and power management.
> 
> Co-developed-by: Yulin Lu <luyulin@eswincomputing.com>
> Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>  drivers/ata/Kconfig        |  12 ++
>  drivers/ata/Makefile       |   1 +
>  drivers/ata/ahci_eic7700.c | 248 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+)
>  create mode 100644 drivers/ata/ahci_eic7700.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e00536b49552..474c09543006 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -185,6 +185,18 @@ config AHCI_DWC
>  
>  	  If unsure, say N.
>  
> +config AHCI_EIC7700
> +	tristate "Eswin AHCI SATA support"
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	select SATA_HOST
> +	help
> +	  This enables the AHCI SATA controller driver for Eswin SoCs. This driver
> +	  is specific to Eswin SoCs and should only be enabled if using such hardware.
> +	  The driver supports eic7700 series chips. The controller supports up
> +	  to 1 port.
> +
> +	  If unsure, say N.
> +
>  config AHCI_ST
>  	tristate "ST AHCI SATA support"
>  	depends on ARCH_STI || COMPILE_TEST
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 20e6645ab737..af00e55fa593 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_DM816)	+= ahci_dm816.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_DWC)		+= ahci_dwc.o libahci.o libahci_platform.o
> +obj-$(CONFIG_AHCI_EIC7700)	+= ahci_eic7700.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_MTK)		+= ahci_mtk.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_MVEBU)	+= ahci_mvebu.o libahci.o libahci_platform.o
> diff --git a/drivers/ata/ahci_eic7700.c b/drivers/ata/ahci_eic7700.c
> new file mode 100644
> index 000000000000..d2b7cafbfdd7
> --- /dev/null
> +++ b/drivers/ata/ahci_eic7700.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN EIC7700 AHCI SATA Driver
> + *
> + * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
> + *
> + * Authors: Yulin Lu <luyulin@eswincomputing.com>
> + *          Huan He <hehuan1@eswincomputing.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/device.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/libata.h>
> +#include <linux/ahci_platform.h>
> +#include <linux/acpi.h>
> +#include <linux/pci_ids.h>
> +#include <linux/iommu.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include "ahci.h"
> +
> +#define DRV_NAME "ahci"
> +
> +/* Register Definitions */
> +#define SATA_REF_CTRL1                0x338
> +#define SATA_PHY_CTRL0                0x328
> +#define SATA_PHY_CTRL1                0x32c
> +#define SATA_LOS_IDEN                 0x33c
> +#define SATA_AXI_LP_CTRL              0x308
> +#define SATA_REG_CTRL                 0x334
> +#define SATA_MPLL_CTRL                0x320
> +#define SATA_RESET_CTRL               0x340
> +#define SATA_RESET_CTRL_ASSERT        0x3
> +#define SATA_RESET_CTRL_DEASSERT      0x0
> +#define SATA_PHY_RESET                BIT(0)
> +#define SATA_P0_RESET                 BIT(1)
> +#define SATA_LOS_LEVEL                0x9
> +#define SATA_LOS_BIAS                 (0x02 << 16)
> +#define SATA_REF_REPEATCLK_EN         BIT(0)
> +#define SATA_REF_USE_PAD              BIT(20)
> +#define SATA_P0_AMPLITUDE_GEN1        0x42
> +#define SATA_P0_AMPLITUDE_GEN2        (0x46 << 8)
> +#define SATA_P0_AMPLITUDE_GEN3        (0x73 << 16)
> +#define SATA_P0_PHY_TX_PREEMPH_GEN1   0x05
> +#define SATA_P0_PHY_TX_PREEMPH_GEN2   (0x05 << 8)
> +#define SATA_P0_PHY_TX_PREEMPH_GEN3   (0x23 << 16)
> +#define SATA_MPLL_MULTIPLIER          (0x3c << 16)
> +#define SATA_M_CSYSREQ                BIT(0)
> +#define SATA_S_CSYSREQ                BIT(16)
> +
> +struct eswin_ahci_plat {
> +	struct reset_control *apb_rst;
> +};
> +
> +static const struct ata_port_info ahci_port_info = {
> +	.flags		= AHCI_FLAG_COMMON,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_platform_ops,
> +};
> +
> +static const struct ata_port_info ahci_port_info_nolpm = {
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_platform_ops,
> +};
> +
> +static struct scsi_host_template ahci_platform_sht = {
> +	AHCI_SHT(DRV_NAME),
> +};
> +
> +static int eswin_sata_init(struct device *dev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		return -1;
> +	}
> +
> +	regmap_write(regmap, SATA_REF_CTRL1, 0x1);
> +	regmap_write(regmap, SATA_PHY_CTRL0, (SATA_P0_AMPLITUDE_GEN1 |
> +						 SATA_P0_AMPLITUDE_GEN2 |
> +						 SATA_P0_AMPLITUDE_GEN3));
> +	regmap_write(regmap, SATA_PHY_CTRL1, (SATA_P0_PHY_TX_PREEMPH_GEN1 |
> +						 SATA_P0_PHY_TX_PREEMPH_GEN2 |
> +						 SATA_P0_PHY_TX_PREEMPH_GEN3));
> +	regmap_write(regmap, SATA_LOS_IDEN, SATA_LOS_LEVEL | SATA_LOS_BIAS);
> +	regmap_write(regmap, SATA_AXI_LP_CTRL, SATA_M_CSYSREQ | SATA_S_CSYSREQ);
> +	regmap_write(regmap, SATA_REG_CTRL, SATA_REF_REPEATCLK_EN | SATA_REF_USE_PAD);
> +	regmap_write(regmap, SATA_MPLL_CTRL, SATA_MPLL_MULTIPLIER);
> +	regmap_write(regmap, SATA_RESET_CTRL, 0x0);
> +
> +	return 0;
> +}

As I wrote in patch 1/2, I can't help to wonder if these shouldn't be in a
PHY driver instead.

If it were, you probably wouldn't need this file, as most of it looks like
is it already handled by ahci_dwc.c / libahci_platform.c.

(phy_init() is called from ahci_platform_enable_phys(), which is called
from ahci_platform_enable_resources() which is called from
ahci_dwc_init_host() which is called from ahci_dwc_probe().)


> +
> +static int eswin_ahci_platform_resets(struct ahci_host_priv *hpriv,
> +				 struct device *dev)
> +{
> +	struct eswin_ahci_plat *plat = hpriv->plat_data;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		return -1;
> +	}
> +
> +	plat->apb_rst = devm_reset_control_get_optional(dev, "apb");
> +	if (PTR_ERR(plat->apb_rst) == -EPROBE_DEFER)
> +		return PTR_ERR(plat->apb_rst);
> +
> +	ret = reset_control_assert(plat->apb_rst);
> +	if (ret) {
> +		dev_err(dev, "failed to assert apb_rst\n");
> +		return ret;
> +	}
> +	regmap_write(regmap, SATA_RESET_CTRL, SATA_RESET_CTRL_ASSERT);
> +
> +	regmap_write(regmap, SATA_RESET_CTRL, SATA_RESET_CTRL_DEASSERT);
> +	ret = reset_control_deassert(plat->apb_rst);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert apb_rst\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ahci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ahci_host_priv *hpriv;
> +	struct eswin_ahci_plat *plat;
> +	const struct ata_port_info *port;
> +	int ret;
> +
> +	plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
> +	if (!plat)
> +		return -ENOMEM;
> +
> +	hpriv = ahci_platform_get_resources(pdev, 0);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	hpriv->plat_data = plat;
> +	ret = eswin_ahci_platform_resets(hpriv, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ahci_platform_enable_resources(hpriv);
> +	if (ret)
> +		return ret;
> +
> +	eswin_sata_init(dev);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(41));

This looks wrong.
If I'm not mistaken, the proper way is that the bus which your device
(in this case an AHCI controller) is located on in device tree should
specify 'dma-ranges', and that will set the DMA mask for the devices
on that bus automatically.


> +	if (ret)
> +		return ret;
> +
> +	of_property_read_u32(dev->of_node, "ports-implemented", &hpriv->saved_port_map);
> +
> +	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> +		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;

"hisilicon,hisi-ahci" seems copy pasted from ahci_platform.c, and seems unwanted.


> +
> +	port = acpi_device_get_match_data(dev);
> +	if (!port)
> +		port = &ahci_port_info;
> +
> +	ret = ahci_platform_init_host(pdev, hpriv, port, &ahci_platform_sht);
> +	if (ret)
> +		goto disable_resources;
> +
> +	return 0;
> +
> +disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +	return ret;
> +}
> +
> +static void ahci_remove(struct platform_device *pdev)
> +{
> +	ata_platform_remove_one(pdev);
> +}
> +
> +static int eswin_ahci_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = ahci_platform_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int eswin_ahci_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = ahci_platform_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ahci_pm_ops, eswin_ahci_suspend, eswin_ahci_resume);
> +
> +static const struct of_device_id ahci_of_match[] = {
> +	{ .compatible = "eswin,eic7700-ahci", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
> +static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
> +	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);

This table seems copy pasted from ahci_platform.c, and seems unwanted.
(I assume that your platform does not support ACPI.)


Kind regards,
Niklas
