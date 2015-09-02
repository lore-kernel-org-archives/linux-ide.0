From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ahci: added a new driver for supporting Freescale AHCI
 sata
Date: Wed, 2 Sep 2015 10:31:36 +0200
Message-ID: <55E6B3E8.80902@redhat.com>
References: <1441160730-28006-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441160730-28006-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 02-09-15 04:25, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> Currently Freescale QorIQ series SATA is supported by ahci_platform
> driver. Some SoC specific settings have been put in uboot. So whether
> SATA works or not heavily depends on uboot.
> This patch will add a new driver to support QorIQ sata which removes
> the dependency on any other boot loader.
> Freescale QorIQ series sata, like ls1021a ls2085a ls1043a, is
> compatible with serial ATA 3.0 and AHCI 1.3 specification.
>
> Signed-off-by: Yuantian Tang <Yuantian.Tang@freescale.com>

Thanks for the patch looks good overall.

You need to add a Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
(or a similar named file) documenting the compatible strings and
what the devicetree nodes should contain wrt reg, interrupts, etc.
properties. See Documentation/devicetree/bindings/ata/ahci-platform.txt
as an example.

Further comments inline.

> ---
>   drivers/ata/Kconfig         |   9 ++
>   drivers/ata/Makefile        |   1 +
>   drivers/ata/ahci_platform.c |   1 -
>   drivers/ata/ahci_qoriq.c    | 308 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 318 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/ata/ahci_qoriq.c
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 15e40ee..6aaa3f8 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -175,6 +175,15 @@ config AHCI_XGENE
>   	help
>   	 This option enables support for APM X-Gene SoC SATA host controller.
>
> +config AHCI_QORIQ
> +	tristate "Freescale QorIQ AHCI SATA support"
> +	depends on OF
> +	help
> +	  This option enables support for the Freescale QorIQ AHCI SoC's
> +	  onboard AHCI SATA.
> +
> +	  If unsure, say N.
> +
>   config SATA_FSL
>   	tristate "Freescale 3.0Gbps SATA support"
>   	depends on FSL_SOC
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index af70919..af45eff 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o libahci_platform.o
>   obj-$(CONFIG_AHCI_XGENE)	+= ahci_xgene.o libahci.o libahci_platform.o
> +obj-$(CONFIG_AHCI_QORIQ)	+= ahci_qoriq.o libahci.o libahci_platform.o
>
>   # SFF w/ custom DMA
>   obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 1befb11..04975b8 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -76,7 +76,6 @@ static const struct of_device_id ahci_of_match[] = {
>   	{ .compatible = "ibm,476gtr-ahci", },
>   	{ .compatible = "snps,dwc-ahci", },
>   	{ .compatible = "hisilicon,hisi-ahci", },
> -	{ .compatible = "fsl,qoriq-ahci", },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, ahci_of_match);

This will break booting new kernels with old dtb files, something which
in general is considered a big non-no, I suggest adding a comment
that this has been superseded by the new ahci_qoriq.c code, and maybe
add a date to retire the compatible in say a year from now.

> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> new file mode 100644
> index 0000000..943b783
> --- /dev/null
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -0,0 +1,308 @@
> +/*
> + * Freescale QorIQ AHCI SATA platform driver
> + *
> + * Copyright 2015 Freescale, Inc.
> + *   Tang Yuantian <Yuantian.Tang@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/ahci_platform.h>
> +#include <linux/device.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/libata.h>
> +#include "ahci.h"
> +
> +#define DRV_NAME "ahci-qoriq"
> +
> +#define AHCI_PORT_PHY_1_CFG	0xa003fffe
> +#define AHCI_PORT_PHY_2_CFG	0x28183411
> +#define AHCI_PORT_PHY_3_CFG	0x0e081004
> +#define AHCI_PORT_PHY_4_CFG	0x00480811
> +#define AHCI_PORT_PHY_5_CFG	0x192c96a4
> +#define AHCI_PORT_TRANS_CFG	0x08000025
> +
> +#define SATA_ECC_REG_ADDR	0x20220520
> +#define SATA_ECC_DISABLE	0x00020000
> +
> +enum ahci_qoriq_type {
> +	AHCI_LS1021A,
> +	AHCI_LS1043A,
> +	AHCI_LS2085A,
> +};
> +
> +struct ahci_qoriq_priv {
> +	struct ccsr_ahci *reg_base;
> +	enum ahci_qoriq_type type;
> +	void __iomem *ecc_addr;
> +};
> +
> +/* AHCI (sata) register map */
> +struct ccsr_ahci {
> +	u32 res1[0xa4/4];	/* 0x0 - 0xa4 */
> +	u32 pcfg;	/* port config */
> +	u32 ppcfg;	/* port phy1 config */
> +	u32 pp2c;	/* port phy2 config */
> +	u32 pp3c;	/* port phy3 config */
> +	u32 pp4c;	/* port phy4 config */
> +	u32 pp5c;	/* port phy5 config */
> +	u32 paxic;	/* port AXI config */
> +	u32 axicc;	/* AXI cache control */
> +	u32 axipc;	/* AXI PROT control */
> +	u32 ptc;	/* port Trans Config */
> +	u32 pts;	/* port Trans Status */
> +	u32 plc;	/* port link config */
> +	u32 plc1;	/* port link config1 */
> +	u32 plc2;	/* port link config2 */
> +	u32 pls;	/* port link status */
> +	u32 pls1;	/* port link status1 */
> +	u32 pcmdc;	/* port CMD config */
> +	u32 ppcs;	/* port phy control status */
> +	u32 pberr;	/* port 0/1 BIST error */
> +	u32 cmds;	/* port 0/1 CMD status error */
> +};
> +
> +static const struct of_device_id ahci_qoriq_of_match[] = {
> +	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
> +	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
> +	{ .compatible = "fsl,ls2085a-ahci", .data = (void *)AHCI_LS2085A},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
> +
> +static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
> +			  unsigned long deadline)
> +{
> +	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> +	void __iomem *port_mmio = ahci_port_base(link->ap);
> +	u32 px_cmd, px_is, px_val;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	struct ahci_qoriq_priv *qoriq_priv = hpriv->plat_data;
> +	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> +	struct ata_taskfile tf;
> +	bool online;
> +	int rc;
> +
> +	DPRINTK("ENTER\n");
> +
> +	ahci_stop_engine(ap);
> +
> +	/*
> +	 * There is a errata on ls1021a Rev1.0 and Rev2.0 which is:
> +	 * A-009042: The device detection initialization sequence
> +	 * mistakenly resets some registers.
> +	 *
> +	 * Workaround for this is:
> +	 * The software should read and store PxCMD and PxIS values
> +	 * before issuing the device detection initialization sequence.
> +	 * After the sequence is complete, software should restore the
> +	 * PxCMD and PxIS with the stored values.
> +	 */
> +	if (qoriq_priv->type == AHCI_LS1021A) {
> +		px_cmd = readl(port_mmio + PORT_CMD);
> +		px_is = readl(port_mmio + PORT_IRQ_STAT);
> +	}
> +
> +	/* clear D2H reception area to properly wait for D2H FIS */
> +	ata_tf_init(link->device, &tf);
> +	tf.command = ATA_BUSY;
> +	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
> +
> +	rc = sata_link_hardreset(link, timing, deadline, &online,
> +				 ahci_check_ready);
> +
> +	/* restore the PxCMD and PxIS on ls1021 */
> +	if (qoriq_priv->type == AHCI_LS1021A) {
> +		px_val = readl(port_mmio + PORT_CMD);
> +		if (px_val != px_cmd)
> +			writel(px_cmd, port_mmio + PORT_CMD);
> +
> +		px_val = readl(port_mmio + PORT_IRQ_STAT);
> +		if (px_val != px_is)
> +			writel(px_is, port_mmio + PORT_IRQ_STAT);
> +	}
> +
> +	hpriv->start_engine(ap);
> +
> +	if (online)
> +		*class = ahci_dev_classify(ap);
> +
> +	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> +	return rc;
> +}
> +
> +static struct ata_port_operations ahci_qoriq_ops = {
> +	.inherits	= &ahci_ops,
> +	.hardreset	= ahci_qoriq_hardreset,
> +};
> +
> +static const struct ata_port_info ahci_qoriq_port_info = {
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_qoriq_ops,
> +};
> +
> +static struct scsi_host_template ahci_qoriq_sht = {
> +	AHCI_SHT(DRV_NAME),
> +};
> +
> +static int ahci_qoriq_phy_init(struct ahci_qoriq_priv *qpriv)
> +{
> +	struct ccsr_ahci *reg_base = qpriv->reg_base;
> +
> +	switch (qpriv->type) {
> +	case AHCI_LS1021A:
> +		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
> +		writel(AHCI_PORT_PHY_1_CFG, &reg_base->ppcfg);
> +		writel(AHCI_PORT_PHY_2_CFG, &reg_base->pp2c);
> +		writel(AHCI_PORT_PHY_3_CFG, &reg_base->pp3c);
> +		writel(AHCI_PORT_PHY_4_CFG, &reg_base->pp4c);
> +		writel(AHCI_PORT_PHY_5_CFG, &reg_base->pp5c);
> +		writel(AHCI_PORT_TRANS_CFG, &reg_base->ptc);
> +		break;
> +
> +	case AHCI_LS1043A:
> +	case AHCI_LS2085A:
> +		writel(AHCI_PORT_PHY_1_CFG, &reg_base->ppcfg);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ahci_qoriq_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct ahci_host_priv *hpriv;
> +	struct ahci_qoriq_priv *qoriq_priv;
> +	const struct of_device_id *of_id;
> +	int rc;
> +
> +	hpriv = ahci_platform_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;

You may want to move this down in the function to remove
unnecessary goto disable_foo error handling, you can
do this directly before the phy_init.

> +
> +	of_id = of_match_node(ahci_qoriq_of_match, np);
> +	if (!of_id) {
> +		rc = -ENODEV;
> +		goto disable_resources;
> +	}
> +
> +	qoriq_priv = devm_kzalloc(dev, sizeof(*qoriq_priv), GFP_KERNEL);
> +	if (!qoriq_priv) {
> +		rc = -ENOMEM;
> +		goto disable_resources;
> +	}
> +
> +	qoriq_priv->reg_base = of_iomap(np, 0);
> +	if (!qoriq_priv->reg_base) {
> +		rc = -ENOMEM;
> +		goto free_qpriv;
> +	}

You should use devm_ioremap_resource() to map registers so that resources
get released automatically.

In this case hower you already have access to there registers through
hpriv->mmio, so there is no need to map them a second time.

> +
> +	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
> +
> +	if (qoriq_priv->type == AHCI_LS1021A) {
> +		qoriq_priv->ecc_addr =
> +			ioremap((phys_addr_t)SATA_ECC_REG_ADDR, 4);

In a devicetree enabled driver you should never hardcode register
addresses like this, instead they should be specified in the
reg property of the driver.

You should put something like this in the dts:

	reg = <0x01c13400 0x10>, <0x01c14800 0x4>;
	reg-names = "ahci", "sata_ecc";

And then in the code do:

	struct resource *res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sata_ecc");
	qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
	if (IS_ERR(qoriq_priv->ecc_addr))
		return PTR_ERR(qoriq_priv->ecc_addr);

Note the direct return. This is ok to do if you move enable_resources
down as discussed below.

> +		if (!qoriq_priv->ecc_addr) {
> +			rc = -ENOMEM;
> +			goto err_iomap;
> +		}
> +	}
> +	hpriv->plat_data = qoriq_priv;
> +	rc = ahci_qoriq_phy_init(qoriq_priv);
> +	if (rc) {
> +		rc = -ENOMEM;
> +		goto err_iomap2;
> +	}
> +
> +	rc = ahci_platform_init_host(pdev, hpriv, &ahci_qoriq_port_info,
> +				     &ahci_qoriq_sht);
> +	if (rc)
> +		goto err_iomap2;
> +
> +	return 0;
> +
> +err_iomap2:
> +	iounmap(qoriq_priv->ecc_addr);
> +
> +err_iomap:
> +	iounmap(qoriq_priv->reg_base);
> +
> +free_qpriv:
> +	devm_kfree(dev, qoriq_priv);

All these 3 labels + code can go away since devm will do this
automatically when you fail the probe method (assuming you use
devm_ioremap_resource as discussed above).

> +
> +disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +
> +	return rc;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ahci_qoriq_resume(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int rc;
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	rc = ahci_qoriq_phy_init(hpriv->plat_data);
> +	if (rc)
> +		goto disable_resources;
> +
> +	rc = ahci_platform_resume_host(dev);
> +	if (rc)
> +		goto disable_resources;
> +
> +	/* We resumed so update PM runtime state */
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +
> +disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +
> +	return rc;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ahci_qoriq_pm_ops, ahci_platform_suspend,
> +			 ahci_qoriq_resume);
> +
> +static struct platform_driver ahci_qoriq_driver = {
> +	.probe = ahci_qoriq_probe,
> +	.remove = ata_platform_remove_one,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = ahci_qoriq_of_match,
> +		.pm = &ahci_qoriq_pm_ops,
> +	},
> +};
> +module_platform_driver(ahci_qoriq_driver);
> +
> +MODULE_DESCRIPTION("Freescale QorIQ AHCI SATA platform driver");
> +MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
> +MODULE_LICENSE("GPL");
>


Regards,

Hans
