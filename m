From: Alek Du <alek.du@intel.com>
Subject: [PATCH] libata: Add Intel SCH PATA Support
Date: Tue, 6 May 2008 09:41:31 +0800
Message-ID: <20080506094131.4bd70c8a@dxy.sh.intel.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>
	<481EE284.2010708@ru.mvista.com>
	<20080505224420.44730838@dxy.sh.intel.com>
	<481F2144.5000409@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46489 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbYEFBsY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 21:48:24 -0400
In-Reply-To: <481F2144.5000409@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Sergei and All,

I modified the driver again according to comments from Sergei, please help to review it.


>From 9a318d7ff2fc55811374b5b959524f5afcb8d5a6 Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Mon, 5 May 2008 14:32:04 +0800
Subject: [PATCH] libata: Add Intel SCH PATA Support

This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) PATA controller
support.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/ata/Kconfig    |    9 ++
 drivers/ata/Makefile   |    1 +
 drivers/ata/pata_sch.c |  244 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/pata_sch.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c11df9..1a59f30 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -697,6 +697,15 @@ config PATA_SCC
 
 	  If unsure, say N.
 
+config PATA_SCH
+	tristate "Intel SCH PATA support"
+	depends on PCI
+	help
+	  This option enables support for Intel SCH PATA on the Intel
+	  SCH (US15W, US15L, UL11L) series host controllers.
+
+	  If unsure, say N.
+
 config PATA_BF54X
 	tristate "Blackfin 54x ATAPI support"
 	depends on BF542 || BF548 || BF549
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b693d82..674965f 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
 obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
+obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
 obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
new file mode 100644
index 0000000..84a2384
--- /dev/null
+++ b/drivers/ata/pata_sch.c
@@ -0,0 +1,244 @@
+/*
+ *    pata_sch.c - Intel SCH PATA controllers
+ *
+ *  Copyright (c) 2008 Alek Du <alek.du@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ *  Supports:
+ *    Intel SCH (AF82US15W, AF82US15L, AF82UL11L) chipsets
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <linux/dmi.h>
+
+#define DRV_NAME	"pata_sch"
+#define DRV_VERSION	"0.2"
+
+/* see SCH datasheet page 351 */
+enum {
+	D0TIM	= 0x80,		/* Device 0 Timing Register */
+	D1TIM	= 0x84,		/* Device 1 Timing Register */
+	PM	= 0x07,		/* PIO Mode Bit Mask */
+	MDM	= (0x03 << 8),	/* Multi-word DMA Mode Bit Mask */
+	UDM	= (0x07 << 16), /* Ultra DMA Mode Bit Mask */
+	PPE	= (1 << 30),	/* Prefetch/Post Enable */
+	USD	= (1 << 31),	/* Use Synchronous DMA */
+};
+
+static int sch_init_one(struct pci_dev *pdev,
+			 const struct pci_device_id *ent);
+static void sch_set_piomode(struct ata_port *ap, struct ata_device *adev);
+static void sch_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+#ifdef CONFIG_PM
+static int sch_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
+static int sch_pci_device_resume(struct pci_dev *pdev);
+#endif
+
+static unsigned int in_module_init = 1;
+
+static const struct pci_device_id sch_pci_tbl[] = {
+	/* Intel SCH PATA Controller */
+	{ 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ }	/* terminate list */
+};
+
+static struct pci_driver sch_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= sch_pci_tbl,
+	.probe			= sch_init_one,
+	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= sch_pci_device_suspend,
+	.resume			= sch_pci_device_resume,
+#endif
+};
+
+static struct scsi_host_template sch_sht = {
+	ATA_BMDMA_SHT(DRV_NAME),
+};
+
+static struct ata_port_operations sch_pata_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+	.cable_detect		= ata_cable_unknown,
+	.set_piomode		= sch_set_piomode,
+	.set_dmamode		= sch_set_dmamode,
+};
+
+static struct ata_port_info sch_port_info = {
+	.flags		= 0,
+	.pio_mask	= ATA_PIO4,   /* pio0-4 */
+	.mwdma_mask	= ATA_MWDMA2, /* mwdma0-2 */
+	.udma_mask	= ATA_UDMA5,  /* udma0-5 */
+	.port_ops	= &sch_pata_ops,
+};
+
+MODULE_AUTHOR("Alek Du <alek.du@intel.com>");
+MODULE_DESCRIPTION("SCSI low-level driver for Intel SCH PATA controllers");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, sch_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+
+/**
+ *	sch_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void sch_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned int port	= adev->devno ? D1TIM : D0TIM;
+	unsigned int data;
+
+	pci_read_config_dword(dev, port, &data);
+	/* see SCH datasheet page 351 */
+	/* set PIO mode without PPE */
+	data &= ~(PM | PPE);
+	data |= pio;
+	pci_write_config_dword(dev, port, data);
+}
+
+/**
+ *	sch_set_dmamode - Initialize host controller PATA DMA timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *
+ *	Set MW/UDMA mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void sch_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int dma_mode	= adev->dma_mode;
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned int port	= adev->devno ? D1TIM : D0TIM;
+	unsigned int data;
+
+	pci_read_config_dword(dev, port, &data);
+	/* see SCH datasheet page 351 */
+	if (dma_mode >= XFER_UDMA_0) {
+		/* enable Synchronous DMA mode */
+		data |= USD;
+		data &= ~UDM;
+		data |= (dma_mode - XFER_UDMA_0) << 16;
+	} else { /* must be MWDMA mode, since we masked SWDMA already */
+		data &= ~(USD | MDM);
+		data |= (dma_mode - XFER_MW_DMA_0) << 8;
+	}
+	pci_write_config_dword(dev, port, data);
+}
+
+#ifdef CONFIG_PM
+
+static int sch_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_host_suspend(host, mesg);
+	if (rc)
+		return rc;
+	ata_pci_device_do_suspend(pdev, mesg);
+	return 0;
+}
+
+static int sch_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc == 0)
+		ata_host_resume(host);
+	return rc;
+}
+
+#endif
+
+/**
+ *	sch_init_one - Register SCH ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in sch_pci_tbl matching with @pdev
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int __devinit sch_init_one(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
+{
+	static int printed_version;
+	const struct ata_port_info *ppi[] = { &sch_port_info, NULL };
+	struct ata_host *host;
+	int rc;
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
+
+	/* no hotplugging support (FIXME) */
+	if (!in_module_init)
+		return -ENODEV;
+	/* enable device and prepare host */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+	pci_set_master(pdev);
+	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &sch_sht);
+}
+
+static int __init sch_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&sch_pci_driver);
+	if (rc)
+		return rc;
+	in_module_init = 0;
+	return 0;
+}
+
+static void __exit sch_exit(void)
+{
+	pci_unregister_driver(&sch_pci_driver);
+}
+
+module_init(sch_init);
+module_exit(sch_exit);
-- 
1.5.2.5

BR,
Alek
