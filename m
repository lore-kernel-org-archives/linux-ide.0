From: "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH] ata: Compact Flash/PCMCIA driver for XLR
Date: Tue, 8 May 2012 20:12:30 +0530
Message-ID: <1336488150-19839-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:1950 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab2EHOmq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 May 2012 10:42:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Kamlakant Patel <kamlakant.patel@broadcom.com>, Jayachandran C <jayachandranc@netlogicmicro.com>

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Add driver for the compact flash interface on Netlogic MIPS SoCs.
The code is based on platform pcmcia driver, but adds interrupt
handling code to ACK interrupts.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 drivers/ata/Kconfig           |    9 ++
 drivers/ata/Makefile          |    1 +
 drivers/ata/pata_xlr_pcmcia.c |  194 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/ata/pata_xlr_pcmcia.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6bdedd7..ba4a734 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -870,6 +870,15 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config PATA_XLR_PCMCIA
+	tristate "Netlogic XLR PATA PCMCIA/CompactFlash support"
+	depends on CPU_XLR
+	help
+	  This option enables support for PCMCIA/CompactFlash driver for
+	  Netlogic XLR SoCs.
+
+	  If unsure, say N.
+
 comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 6ece5b7..772d076 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
 obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
 obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
+obj-$(CONFIG_PATA_XLR_PCMCIA)	+= pata_xlr_pcmcia.o
 
 obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
 
diff --git a/drivers/ata/pata_xlr_pcmcia.c b/drivers/ata/pata_xlr_pcmcia.c
new file mode 100644
index 0000000..84de6d8
--- /dev/null
+++ b/drivers/ata/pata_xlr_pcmcia.c
@@ -0,0 +1,194 @@
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
+#include <linux/ata_platform.h>
+
+#define DRV_NAME "pata_xlr_platform"
+#define DRV_VERSION "1.2"
+
+#define PATA_PCMCIA_BASE	0x1f0
+#define PATA_PCMCIA_STATUS	0x1f7
+#define PATA_PCMCIA_CTL		0x3f6
+
+/*
+ * Provide our own set_mode() as we don't want to change anything that has
+ * already been configured..
+ */
+static int xlr_pata_platform_set_mode(struct ata_link *link,
+					struct ata_device **unused)
+{
+	struct ata_device *dev;
+
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_info(dev, "configured for PIO\n");
+	}
+	return 0;
+}
+
+static struct scsi_host_template pata_platform_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+void xlr_pata_irq_clear(struct ata_port *port)
+{
+	unsigned int reg;
+
+	reg = readl(port->private_data);
+	writel(reg, port->private_data);
+}
+
+bool xlr_pata_irq_check(struct ata_port *port)
+{
+	unsigned int reg;
+
+	reg = readl(port->private_data);
+
+	return (reg != 0);
+}
+
+static struct ata_port_operations pata_platform_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+	.sff_data_xfer		= ata_sff_data_xfer_noirq,
+	.cable_detect		= ata_cable_unknown,
+	.set_mode		= xlr_pata_platform_set_mode,
+	.sff_irq_check		= xlr_pata_irq_check,
+	.sff_check_status	= ata_sff_check_status,
+	.sff_irq_clear		= xlr_pata_irq_clear,
+};
+
+int xlr_pata_platform_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	ata_host_detach(host);
+
+	return 0;
+}
+
+static int __devinit xlr_pata_platform_probe(struct platform_device *pdev)
+{
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct ata_ioports *ioaddr;
+
+	struct resource *io_res;
+	struct resource *irq_res;
+	struct resource *ack_res;
+
+	struct device *dev = &pdev->dev;
+	int irq = 0;
+	int irq_flags = 0;
+
+
+	/*
+	 * Simple resource validation ..
+	 */
+	if (pdev->num_resources != 3) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the I/O base first
+	 */
+	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(io_res == NULL))
+			return -EINVAL;
+
+	ack_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (unlikely(ack_res == NULL))
+		return -EINVAL;
+
+	/*
+	 * And the IRQ
+	 */
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+
+	if (irq_res && irq_res->start > 0) {
+		irq = irq_res->start;
+		irq_flags = irq_res->flags;
+	}
+
+	host = ata_host_alloc(dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+	ap->ops = &pata_platform_port_ops;
+	ap->private_data = ioremap(ack_res->start, resource_size(ack_res));
+	ap->flags |= ATA_FLAG_SLAVE_POSS;
+
+	/*
+	 * Use polling mode if there's no IRQ
+	 */
+	if (!irq) {
+		ap->flags |= ATA_FLAG_PIO_POLLING;
+		ata_port_desc(ap, "no IRQ, using PIO polling");
+	}
+
+	/*
+	 * Handle the MMIO case
+	 */
+	ioaddr = &ap->ioaddr;
+	ioaddr->data_addr = devm_ioremap(dev, io_res->start,
+					resource_size(io_res));
+	ioaddr->cmd_addr = ioaddr->data_addr + PATA_PCMCIA_BASE;
+	ioaddr->altstatus_addr = ioaddr->data_addr + PATA_PCMCIA_STATUS;
+	ioaddr->ctl_addr = ioaddr->data_addr + PATA_PCMCIA_CTL;
+
+	/* Fixup the port shift for platforms that need it */
+	ioaddr->data_addr	= ioaddr->cmd_addr + (ATA_REG_DATA);
+	ioaddr->error_addr	= ioaddr->cmd_addr + (ATA_REG_ERR);
+	ioaddr->feature_addr	= ioaddr->cmd_addr + (ATA_REG_FEATURE);
+	ioaddr->nsect_addr	= ioaddr->cmd_addr + (ATA_REG_NSECT);
+	ioaddr->lbal_addr	= ioaddr->cmd_addr + (ATA_REG_LBAL);
+	ioaddr->lbam_addr	= ioaddr->cmd_addr + (ATA_REG_LBAM);
+	ioaddr->lbah_addr	= ioaddr->cmd_addr + (ATA_REG_LBAH);
+	ioaddr->device_addr	= ioaddr->cmd_addr + (ATA_REG_DEVICE);
+	ioaddr->status_addr	= ioaddr->cmd_addr + (ATA_REG_STATUS);
+	ioaddr->command_addr	= ioaddr->cmd_addr + (ATA_REG_CMD);
+
+	ata_port_desc(ap, "%s cmd 0x%x ctl 0x%x", "mmio",
+			(unsigned int)ap->ioaddr.cmd_addr,
+			(unsigned int)ap->ioaddr.ctl_addr);
+
+	/* activate */
+	return ata_host_activate(host, irq, irq ? ata_sff_interrupt : NULL,
+				 irq_flags, &pata_platform_sht);
+}
+
+static struct platform_driver pata_platform_driver = {
+	.probe		= xlr_pata_platform_probe,
+	.remove		= __devexit_p(xlr_pata_platform_remove),
+	.driver = {
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+	},
+};
+module_platform_driver(pata_platform_driver);
+
+MODULE_AUTHOR("Kamlakant Patel <kamlakant.patel@broadcom.com>");
+MODULE_DESCRIPTION("XLR/XLS SoC PCMCIA/CF driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.9.5


