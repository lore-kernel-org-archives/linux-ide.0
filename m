From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 5/6] ARM: EYNOS5: SATA controller driver
Date: Sat, 13 Oct 2012 00:45:33 +0200
Message-ID: <2148411.TQLYf6bLAq@flatron>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com> <1349783332-18467-6-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1349783332-18467-6-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On Tuesday 09 of October 2012 17:18:51 Vasanth Ananthan wrote:
> This patch adds a platform driver for SATA controller.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
>  drivers/ata/Makefile                         |    2 +-
>  drivers/ata/sata_exynos.c                    |  274
> ++++++++++++++++++++++++++ 3 files changed, 278 insertions(+), 1
> deletions(-)
>  create mode 100644 drivers/ata/sata_exynos.c
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> b/arch/arm/mach-exynos/include/mach/regs-pmu.h index d4e392b..3716ce8
> 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -367,4 +367,7 @@
> 
>  #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
> 
> +/* Only for EXYNOS5250 */
> +#define EXYNOS5_SATA_PHY_CONTROL		S5P_PMUREG(0x0724)
> +
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index bf3fd91..33fb2f6 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
> -obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o libahci.o
> +obj-$(CONFIG_SATA_EXYNOS)          += sata_phy.o sata_exynos.o
> libahci.o
> 
>  # SFF w/ custom DMA
>  obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/sata_exynos.c b/drivers/ata/sata_exynos.c
> new file mode 100644
> index 0000000..877039e
> --- /dev/null
> +++ b/drivers/ata/sata_exynos.c
> @@ -0,0 +1,274 @@
> +/*
> + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com
> + *
> + * EXYNOS - SATA controller driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as +
> * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/gfp.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/libata.h>
> +#include <linux/ahci_platform.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +
> +#include "ahci.h"
> +#include "sata_phy.h"
> +
> +#define SATA_FREQ	(66*1000*1000)
> +
> +static const struct ata_port_info ahci_port_info[] = {
> +	[0] = {
> +	       .flags = AHCI_FLAG_COMMON,
> +	       .pio_mask = ATA_PIO4,
> +	       .udma_mask = ATA_UDMA6,
> +	       .port_ops = &ahci_ops,
> +	       },

nitpick: Indentation of closing bracket is incorrect.

> +};
> +
> +static struct scsi_host_template ahci_platform_sht = {
> +	AHCI_SHT("ahci_platform"),
> +};
> +
> +struct exynos_sata {
> +	struct clk *sclk;
> +	struct clk *clk;
> +	struct sata_phy *phy;
> +	int irq;
> +};
> +
> +static int __init exynos_sata_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ata_port_info pi = ahci_port_info[0];
> +	const struct ata_port_info *ppi[] = { &pi, NULL };
> +	struct ahci_host_priv *hpriv;
> +	struct exynos_sata *sata;
> +	struct ata_host *host;
> +	struct resource *mem;
> +	int n_ports, i, ret;
> +
> +	sata = kzalloc(sizeof(*sata), GFP_KERNEL);

Why this one isn't also allocated using devm_kzalloc?

> +	if (!sata) {
> +		dev_err(dev, "can't alloc sata\n");
> +		ret = -ENOMEM;
> +		return ret;

return -ENOMEM;

> +	}
> +
> +	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> +	if (!hpriv) {
> +		dev_err(dev, "can't alloc ahci_host_priv\n");
> +		ret = -ENOMEM;
> +		goto err1;
> +	}
> +
> +	hpriv->flags |= (unsigned long)pi.private_data;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(dev, "no mmio space\n");
> +		ret = -EINVAL;
> +		goto err2;
> +	}
> +
> +	sata->irq = platform_get_irq(pdev, 0);
> +	if (sata->irq <= 0) {
> +		dev_err(dev, "no irq\n");
> +		ret = -EINVAL;
> +		goto err2;
> +	}
> +
> +	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> +	if (!hpriv->mmio) {
> +		dev_err(dev, "can't map %pR\n", mem);
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	sata->sclk = clk_get(dev, "sclk_sata");

devm_clk_get?

> +	if (IS_ERR(sata->sclk)) {
> +		dev_err(dev, "failed to get sclk_sata\n");
> +		ret = PTR_ERR(sata->sclk);
> +		goto err3;
> +	}
> +	clk_enable(sata->sclk);
> +
> +	clk_set_rate(sata->sclk, SATA_FREQ);
> +
> +	sata->clk = clk_get(dev, "sata");

devm_clk_get?

> +	if (IS_ERR(sata->clk)) {
> +		dev_err(dev, "failed to get sata clock\n");
> +		ret = PTR_ERR(sata->clk);
> +		goto err4;
> +	}
> +	clk_enable(sata->clk);
> +
> +	/*  Get a gen 3 PHY controller */
> +
> +	sata->phy = sata_get_phy(SATA_PHY_GENERATION3);
> +	if (IS_ERR(sata->phy)) {
> +		dev_err(dev, "failed to get sata phy\n");
> +		ret = PTR_ERR(sata->clk);
> +		goto err5;
> +	}
> +
> +	/* Initialize the controller */
> +
> +	ret = sata_init_phy(sata->phy);
> +	if (ret)
> +		goto err6;
> +
> +	ahci_save_initial_config(dev, hpriv, 0, 0);
> +
> +	/* prepare host */
> +	if (hpriv->cap & HOST_CAP_NCQ)
> +		pi.flags |= ATA_FLAG_NCQ;
> +
> +	if (hpriv->cap & HOST_CAP_PMP)
> +		pi.flags |= ATA_FLAG_PMP;
> +
> +	ahci_set_em_messages(hpriv, &pi);
> +
> +	/* CAP.NP sometimes indicate the index of the last enabled
> +	 * port, at other times, that of the last possible port, so
> +	 * determining the maximum port number requires looking at
> +	 * both CAP.NP and port_map.
> +	 */
> +	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
> +
> +	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
> +	if (!host) {
> +		ret = -ENOMEM;
> +		goto err7;
> +	}
> +
> +	host->private_data = hpriv;
> +
> +	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> +		host->flags |= ATA_HOST_PARALLEL_SCAN;
> +	else
> +		pr_info(KERN_INFO
> +		       "ahci: SSS flag set, parallel bus scan disabled\n");
> +
> +	if (pi.flags & ATA_FLAG_EM)
> +		ahci_reset_em(host);
> +
> +	for (i = 0; i < host->n_ports; i++) {
> +		struct ata_port *ap = host->ports[i];
> +
> +		ata_port_desc(ap, "mmio %pR", mem);
> +		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
> +
> +		/* set enclosure management message type */
> +		if (ap->flags & ATA_FLAG_EM)
> +			ap->em_message_type = hpriv->em_msg_type;
> +
> +		/* disabled/not-implemented port */
> +		if (!(hpriv->port_map & (1 << i)))
> +			ap->ops = &ata_dummy_port_ops;
> +	}
> +
> +	ret = ahci_reset_controller(host);
> +	if (ret)
> +		goto err7;
> +
> +	ahci_init_controller(host);
> +	ahci_print_info(host, "platform");
> +
> +	ret = ata_host_activate(host, sata->irq, ahci_interrupt, 
IRQF_SHARED,
> +				&ahci_platform_sht);
> +	if (ret)
> +		goto err7;
> +
> +	platform_set_drvdata(pdev, sata);
> +
> +	return 0;
> +
> + err7:
> +	sata_shutdown_phy(sata->phy);
> +
> + err6:
> +	sata_put_phy(sata->phy);
> +
> + err5:
> +	clk_disable(sata->clk);
> +	clk_put(sata->clk);
> +
> + err4:
> +	clk_disable(sata->sclk);
> +	clk_put(sata->sclk);
> +
> + err3:
> +	iounmap(hpriv->mmio);
> +
> + err2:
> +	kfree(hpriv);
> +
> + err1:
> +	kfree(sata);
> +
> +	return ret;
> +}
> +
> +static int __devexit exynos_sata_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct exynos_sata *sata = platform_get_drvdata(pdev);
> +	ata_host_detach(host);
> +
> +	sata_shutdown_phy(sata->phy);
> +	sata_put_phy(sata->phy);
> +
> +	clk_disable(sata->sclk);
> +	clk_put(sata->sclk);
> +
> +	clk_disable(sata->clk);
> +	clk_put(sata->clk);
> +
> +	kfree(sata);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ahci_of_match[] = {
> +	{.compatible = "samsung,exynos-sata-ahci",},

nitpick: Space after opening and before closing bracket. 

> +};
> +
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
> +static struct platform_driver exynos_sata_driver = {
> +	.remove = exynos_sata_remove,
> +	.driver = {
> +		   .name = "ahci-sata",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = ahci_of_match,
> +		   },

nitpick: Incorrect indentation.

> +};
> +
> +static int __init exynos_sata_init(void)
> +{
> +	return platform_driver_probe(&exynos_sata_driver, 
exynos_sata_probe);
> +}
> +
> +module_init(exynos_sata_init);
> +
> +static void __exit exynos_sata_exit(void)
> +{
> +	platform_driver_unregister(&exynos_sata_driver);
> +}
> +
> +module_exit(exynos_sata_exit);

module_platform_driver(exynos_sata_driver);

Best regards,
Tomasz Figa
