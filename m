From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Mon, 11 Jan 2016 11:23:56 +0100
Message-ID: <569382BC.4070008@redhat.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tj@kernel.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 07-01-16 21:53, Brijesh Singh wrote:
> AMD Seattle SATA controller mostly conforms to AHCI interface with some
> special register to control SGPIO interface. In the case of an AHCI
> controller, the SGPIO feature is ideally implemented using the
> "Enclosure Management" register of the AHCI controller, but those
> registeres are not implemented in the Seattle SoC. Instead SoC
> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> be programmed to control the activity, locate and fault LEDs.
>
> The driver is based on ahci_platform driver.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

This driver looks good from a libahci_platform usage pov. So with the
2 remarks from other reviewers fixed this patch is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> CC: robh+dt@kernel.org
> CC: pawel.moll@arm.com
> CC: mark.rutland@arm.com
> CC: ijc+devicetree@hellion.org.uk
> CC: galak@codeaurora.org
> CC: tj@kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-ide@vger.kernel.org
> ---
>   .../devicetree/bindings/ata/sata-seattle.txt       |  34 ++++
>   drivers/ata/Kconfig                                |   8 +
>   drivers/ata/Makefile                               |   1 +
>   drivers/ata/ahci_seattle.c                         | 226 +++++++++++++++++++++
>   4 files changed, 269 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/sata-seattle.txt
>   create mode 100644 drivers/ata/ahci_seattle.c
>
> diff --git a/Documentation/devicetree/bindings/ata/sata-seattle.txt b/Documentation/devicetree/bindings/ata/sata-seattle.txt
> new file mode 100644
> index 0000000..5ad46b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata-seattle.txt
> @@ -0,0 +1,34 @@
> +* AHCI SATA Controller
> +
> +SATA nodes are defined to describe on-chip Serial ATA controllers.
> +The AMD Seattle SATA controller mostly conforms to the AHCI interface
> +with some special SGPIO register to contro activity LED interfaces.
> +
> +In the case of an AHCI controller, the SGPIO feature is ideally implemented
> +using the "Enclosure Management" register of the AHCI controller, but
> +those registeres are not implemented in the Seattle SoC.
> +
> +Each SATA controller should have its own node.
> +
> +
> +Required properties:
> +- compatible        : compatible string should be "amd,seattle-ahci".
> +- interrupts        : <interrupt mapping for SATA IRQ>
> +- reg               : <registers mapping>
> +
> +Optional properties:
> +- dma-coherent      : Present if dma operations are coherent
> +- clocks            : a list of phandle + clock specifier pairs
> +- target-supply     : regulator for SATA target power
> +- phys              : reference to the SATA PHY node
> +- phy-names         : must be "sata-phy"
> +
> +Examples:
> +        sata0@e0300000 {
> +		compatible = "amd,seattle-ahci";
> +		reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;
> +		interrupts = <0x0 0x163 0x4>;
> +		clocks = <0x2>
> +		dma-coherent;
> +        };
> +
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6aaa3f8..56f764d 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -193,6 +193,14 @@ config SATA_FSL
>
>   	  If unsure, say N.
>
> +config SATA_AHCI_SEATTLE
> +	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
> +	depends on ARCH_SEATTLE
> +	help
> +	 This option enables support for AMD Seattle SATA host controller.
> +
> +	 If unsure, say N
> +
>   config SATA_INIC162X
>   	tristate "Initio 162x SATA support (Very Experimental)"
>   	depends on PCI
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index af45eff..9c0a96a 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ATA)		+= libata.o
>   # non-SFF interface
>   obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
>   obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
> +obj-$(CONFIG_SATA_AHCI_SEATTLE)	+= ahci_seattle.o libahci.o libahci_platform.o
>   obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o libahci_platform.o
>   obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>   obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
> diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
> new file mode 100644
> index 0000000..8c9ab67
> --- /dev/null
> +++ b/drivers/ata/ahci_seattle.c
> @@ -0,0 +1,226 @@
> +/*
> + * AMD Seattle AHCI SATA driver
> + *
> + * Copyright (c) 2015, Advanced Micro Devices
> + * Author: Brijesh Singh <brijesh.singh@amd.com>
> + *
> + * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
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
> +#include "ahci.h"
> +
> +/* SGPIO Control Register definition
> + *
> + * Bit		Type		Description
> + * 31		RW		OD7.2 (activity)
> + * 30		RW		OD7.1 (locate)
> + * 29		RW		OD7.0 (fault)
> + * 28...8	RW		OD6.2...OD0.0 (3bits per port, 1 bit per LED)
> + * 7		RO		SGPIO feature flag
> + * 6:4		RO		Reserved
> + * 3:0		RO		Number of ports (0 means no port supported)
> + */
> +#define ACTIVITY_BIT_POS(x)		(8 + (3 * x))
> +#define LOCATE_BIT_POS(x)		(ACTIVITY_BIT_POS(x) + 1)
> +#define FAULT_BIT_POS(x)		(LOCATE_BIT_POS(x) + 1)
> +
> +#define ACTIVITY_MASK			0x00010000
> +#define LOCATE_MASK			0x00080000
> +#define FAULT_MASK			0x00400000
> +
> +#define DRV_NAME "ahci-seattle"
> +
> +static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32 state,
> +					    ssize_t size);
> +
> +struct seattle_plat_data {
> +	void __iomem *sgpio_ctrl;
> +};
> +
> +static struct ata_port_operations ahci_port_ops = {
> +	.inherits		= &ahci_ops,
> +};
> +
> +static const struct ata_port_info ahci_port_info = {
> +	.flags		= AHCI_FLAG_COMMON,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_port_ops,
> +};
> +
> +static struct ata_port_operations ahci_seattle_ops = {
> +	.inherits		= &ahci_ops,
> +	.transmit_led_message   = seattle_transmit_led_message,
> +};
> +
> +static const struct ata_port_info ahci_port_seattle_info = {
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_EM | ATA_FLAG_SW_ACTIVITY,
> +	.link_flags	= ATA_LFLAG_SW_ACTIVITY,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_seattle_ops,
> +};
> +
> +static struct scsi_host_template ahci_platform_sht = {
> +	AHCI_SHT(DRV_NAME),
> +};
> +
> +static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32 state,
> +					    ssize_t size)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	struct seattle_plat_data *plat_data = hpriv->plat_data;
> +	unsigned long flags;
> +	int pmp;
> +	struct ahci_em_priv *emp;
> +	u32 val;
> +
> +	/* get the slot number from the message */
> +	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
> +	if (pmp < EM_MAX_SLOTS)
> +		emp = &pp->em_priv[pmp];
> +	else
> +		return -EINVAL;
> +
> +	val = ioread32(plat_data->sgpio_ctrl);
> +	if (state & ACTIVITY_MASK)
> +		val |= 1 << ACTIVITY_BIT_POS((ap->port_no));
> +	else
> +		val &= ~(1 << ACTIVITY_BIT_POS((ap->port_no)));
> +
> +	if (state & LOCATE_MASK)
> +		val |= 1 << LOCATE_BIT_POS((ap->port_no));
> +	else
> +		val &= ~(1 << LOCATE_BIT_POS((ap->port_no)));
> +
> +	if (state & FAULT_MASK)
> +		val |= 1 << FAULT_BIT_POS((ap->port_no));
> +	else
> +		val &= ~(1 << FAULT_BIT_POS((ap->port_no)));
> +
> +	iowrite32(val, plat_data->sgpio_ctrl);
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +
> +	/* save off new led state for port/slot */
> +	emp->led_state = state;
> +
> +	spin_unlock_irqrestore(ap->lock, flags);
> +
> +	return size;
> +}
> +
> +static const struct ata_port_info *ahci_seattle_get_port_info(
> +		struct platform_device *pdev, struct ahci_host_priv *hpriv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct seattle_plat_data *plat_data;
> +	u32 val;
> +
> +	plat_data = devm_kzalloc(dev, sizeof(*plat_data), GFP_KERNEL);
> +	if (IS_ERR(plat_data))
> +		return &ahci_port_info;
> +
> +	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
> +	if (IS_ERR(plat_data->sgpio_ctrl))
> +		return &ahci_port_info;
> +
> +	val = ioread32(plat_data->sgpio_ctrl);
> +
> +	if (!(val & 0xf))
> +		return &ahci_port_info;
> +
> +	hpriv->em_loc = 0;
> +	hpriv->em_buf_sz = 4;
> +	hpriv->em_msg_type = EM_MSG_TYPE_LED;
> +	hpriv->plat_data = plat_data;
> +
> +	dev_info(dev, "SGPIO LED control is enabled.\n");
> +	return &ahci_port_seattle_info;
> +}
> +
> +static int ahci_seattle_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct ahci_host_priv *hpriv;
> +
> +	hpriv = ahci_platform_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	rc = ahci_platform_init_host(pdev, hpriv,
> +				     ahci_seattle_get_port_info(pdev, hpriv),
> +				     &ahci_platform_sht);
> +	if (rc)
> +		goto disable_resources;
> +
> +	return 0;
> +disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +	return rc;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> +			 ahci_platform_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ahci_of_match[] = {
> +	{ .compatible = "amd,seattle-ahci", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "AMDI0600", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
> +#endif
> +
> +static struct platform_driver ahci_seattle_driver = {
> +	.probe = ahci_seattle_probe,
> +	.remove = ata_platform_remove_one,
> +	.driver = {
> +		.name = DRV_NAME,
> +#ifdef CONFIG_OF
> +		.of_match_table = ahci_of_match,
> +#endif
> +#ifdef CONFIG_ACPI
> +		.acpi_match_table = ahci_acpi_match,
> +#endif
> +		.pm = &ahci_pm_ops,
> +	},
> +};
> +module_platform_driver(ahci_seattle_driver);
> +
> +MODULE_DESCRIPTION("Seattle AHCI SATA platform driver");
> +MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRV_NAME);
>
