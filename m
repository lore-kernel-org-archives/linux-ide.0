From: "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH v2] ata: Compact Flash driver for Netlogic XLR/XLS
Date: Mon, 11 Jun 2012 13:58:29 +0530
Message-ID: <1339403309-4855-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:2335 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab2FKI2z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jun 2012 04:28:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Kamlakant Patel <kamlakant.patel@broadcom.com>, Jayachandran C <jayachandranc@netlogicmicro.com>

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Add a platform ATA driver for the CF interface on Netlogic XLR/XLS
MIPS SoCs. Chipselect 6 on the peripheral IO bus on these SoCs can
be configured to act as a Compact Flash interface.

The driver expects three resources to be passed to it:
 0 - memory region corresponding to the CF chipselect
 1 - memory region of the flash interrupt ack register in the
     flash configuration region
 2 - and the IRQ resource for the Compact Flash.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
[Changes in V2 : 
   - fixes for comments by sshtylyov@mvista.com
   - use static functions
   - use devm_request_and_ioremap for register area, and devm_ioremap
     for ack register area.
   - ap->private_data usage - use a structure pata_xlr_priv instead of
     overloading the pointer.
]

 drivers/ata/Kconfig       |    9 +++
 drivers/ata/Makefile      |    1 +
 drivers/ata/pata_xlr_cf.c |  170 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/ata/pata_xlr_cf.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2be8ef1..a086a65 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -871,6 +871,15 @@ config PATA_SAMSUNG_CF
 
 	  If unsure, say N.
 
+config PATA_XLR_CF
+	tristate "Netlogic XLR/XLS CompactFlash support"
+	depends on CPU_XLR
+	help
+	  Support for the CompactFlash interface on Netlogic XLR/XLS
+	  SoCs. Say Y if your Netlogic XLR/XLS board has a CF Slot.
+
+	  If unsure, say N.
+
 config PATA_WINBOND_VLB
 	tristate "Winbond W83759A VLB PATA support (Experimental)"
 	depends on ISA && EXPERIMENTAL
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index a454a13..927f131 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
 obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
 obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
+obj-$(CONFIG_PATA_XLR_CF)	+= pata_xlr_cf.o
 
 obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
 
diff --git a/drivers/ata/pata_xlr_cf.c b/drivers/ata/pata_xlr_cf.c
new file mode 100644
index 0000000..7d699c4
--- /dev/null
+++ b/drivers/ata/pata_xlr_cf.c
@@ -0,0 +1,170 @@
+/*
+ * Copyright (c) 2012 Broadcom Corporation
+ *
+ * Based on Generic platform device PATA driver
+ * Copyright (C) 2006 - 2007  Paul Mundt
+ *
+ * Based on pata_pcmcia:
+ *
+ *   Copyright 2005-2006 Red Hat Inc, all rights reserved.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"pata_xlr_cf"
+#define DRV_VERSION	"1.0"
+
+#define XLR_CF_REG_BASE	0x1f0
+#define XLR_CF_REG_CTRL	0x3f6
+
+struct pata_xlr_priv {
+	void __iomem	*xlr_cf_ackreg;
+};
+
+static int pata_xlr_set_mode(struct ata_link *link, struct ata_device **unused)
+{
+	struct ata_device *dev;
+
+	ata_for_each_dev(dev, link, ENABLED) {
+		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_info(dev, "configured for PIO\n");
+	}
+	return 0;
+}
+
+static struct scsi_host_template pata_xlr_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static void pata_xlr_irq_clear(struct ata_port *port)
+{
+	struct pata_xlr_priv *priv = port->private_data;
+	unsigned int reg;
+
+	reg = readl(priv->xlr_cf_ackreg);
+	writel(reg, priv->xlr_cf_ackreg);
+}
+
+static bool pata_xlr_irq_check(struct ata_port *port)
+{
+	struct pata_xlr_priv *priv = port->private_data;
+	unsigned int reg;
+
+	reg = readl(priv->xlr_cf_ackreg);
+	return (reg != 0);
+}
+
+static struct ata_port_operations pata_xlr_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+	.set_mode		= pata_xlr_set_mode,
+	.sff_irq_check		= pata_xlr_irq_check,
+	.sff_irq_clear		= pata_xlr_irq_clear,
+};
+
+static int pata_xlr_cf_remove(struct platform_device *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+
+	ata_host_detach(host);
+	return 0;
+}
+
+static int __devinit pata_xlr_cf_probe(struct platform_device *pdev)
+{
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct ata_ioports *ioaddr;
+	struct resource *io_res, *irq_res, *ack_res;
+	struct pata_xlr_priv *priv;
+	struct device *dev = &pdev->dev;
+	void __iomem *iodata_addr;
+	int irq = 0;
+
+	/* Simple resource validation */
+	if (pdev->num_resources != 3) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/* Get the I/O base */
+	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (io_res == NULL)
+		return -EINVAL;
+
+	ack_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (ack_res == NULL)
+		return -EINVAL;
+
+	/* And the IRQ */
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (irq_res && irq_res->start > 0)
+		irq = irq_res->start;
+
+	iodata_addr = devm_request_and_ioremap(&pdev->dev, io_res);
+	if (!iodata_addr)
+		return -EBUSY;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->xlr_cf_ackreg = devm_ioremap(&pdev->dev, ack_res->start,
+					 resource_size(ack_res));
+	if (!priv->xlr_cf_ackreg)
+		return -ENOMEM;
+
+	host = ata_host_alloc(dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+	ap->ops = &pata_xlr_port_ops;
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
+	ap->private_data = priv;
+
+	/* Use polling mode if there's no IRQ */
+	if (!irq) {
+		ap->flags |= ATA_FLAG_PIO_POLLING;
+		ata_port_desc(ap, "no IRQ, using PIO polling");
+	}
+
+	ioaddr = &ap->ioaddr;
+	ioaddr->data_addr = iodata_addr;
+	ioaddr->cmd_addr = ioaddr->data_addr + XLR_CF_REG_BASE;
+	ioaddr->altstatus_addr = ioaddr->data_addr + XLR_CF_REG_CTRL;
+	ioaddr->ctl_addr = ioaddr->data_addr + XLR_CF_REG_CTRL;
+
+	ata_sff_std_ports(ioaddr);
+
+	ata_port_desc(ap, "mmio cmd 0x%x ctl 0x%x",
+			(unsigned int)ap->ioaddr.cmd_addr,
+			(unsigned int)ap->ioaddr.ctl_addr);
+
+	/* activate */
+	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
+				 IRQF_DISABLED, &pata_xlr_sht);
+}
+
+static struct platform_driver pata_xlr_driver = {
+	.probe		= pata_xlr_cf_probe,
+	.remove		= __devexit_p(pata_xlr_cf_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+module_platform_driver(pata_xlr_driver);
+
+MODULE_AUTHOR("Kamlakant Patel <kamlakant.patel@broadcom.com>");
+MODULE_DESCRIPTION("XLR/XLS Compact Flash driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.9.5


