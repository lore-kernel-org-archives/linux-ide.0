From: "Martin K. Petersen" <mkp@mkp.net>
Subject: [PATCH] pata_cs5536: ATA driver for Geode companion chip (PCI)
Date: Fri, 05 Oct 2007 02:06:48 -0400
Message-ID: <yq17im2858n.fsf_-_@sermon.lab.mkp.net>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:51698 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbXJEGGt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Oct 2007 02:06:49 -0400
In-Reply-To: <20071004160834.GA28667@cosmic.amd.com> (Jordan Crouse's message of "Thu\, 4 Oct 2007 10\:08\:34 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org


This is a driver specifically for the ATA controller on the Geode
CS5536 companion chip.  The PCI device ID for this device was
previously claimed by pata_amd.c but the PIO timings were not correct.
This driver also works around a bug in some BIOSes that emulate
unaligned access to the PCI config registers poorly.

Signed-off-by: Martin K. Petersen <mkp@mkp.net>

---

diff -r de183081194a drivers/ata/Kconfig
--- a/drivers/ata/Kconfig	Tue Oct 02 18:00:56 2007 +0000
+++ b/drivers/ata/Kconfig	Fri Oct 05 01:04:49 2007 -0400
@@ -254,6 +254,15 @@ config PATA_CS5535
 
 	  If unsure, say N.
 
+config PATA_CS5536
+	tristate "CS5536 PATA support (Experimental)"
+	depends on PCI && X86 && !X86_64 && EXPERIMENTAL
+	help
+	  This option enables support for the AMD CS5536
+	  companion chip used with the Geode LX processor family.
+
+	  If unsure, say N.
+
 config PATA_CYPRESS
 	tristate "Cypress CY82C693 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
diff -r de183081194a drivers/ata/Makefile
--- a/drivers/ata/Makefile	Tue Oct 02 18:00:56 2007 +0000
+++ b/drivers/ata/Makefile	Fri Oct 05 01:04:49 2007 -0400
@@ -27,6 +27,7 @@ obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
 obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
 obj-$(CONFIG_PATA_CS5535)	+= pata_cs5535.o
+obj-$(CONFIG_PATA_CS5536)	+= pata_cs5536.o
 obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
 obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
 obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
diff -r de183081194a drivers/ata/pata_amd.c
--- a/drivers/ata/pata_amd.c	Tue Oct 02 18:00:56 2007 +0000
+++ b/drivers/ata/pata_amd.c	Fri Oct 05 01:04:49 2007 -0400
@@ -693,7 +693,9 @@ static const struct pci_device_id amd[] 
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
+#ifndef CONFIG_PATA_CS5536	/* Temporary */
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
+#endif
 
 	{ },
 };
diff -r de183081194a drivers/ata/pata_cs5536.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/ata/pata_cs5536.c	Fri Oct 05 01:04:49 2007 -0400
@@ -0,0 +1,295 @@
+/*
+ * pata_cs5536.c	- CS5536 PATA for new ATA layer
+ *			  (C) 2007 Martin K. Petersen <mkp@mkp.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Documentation:
+ *	Available from AMD web site.
+ *
+ * The IDE timing registers for the CS5536 live in the Geode Machine
+ * Specific Register file and not PCI config space.  Most BIOSes
+ * virtualize the PCI registers so the chip looks like a standard IDE
+ * controller.  Unfortunately not all implementations get this right.
+ * In particular some have problems with unaligned accesses to the
+ * virtualized PCI registers.  This driver always does full dword
+ * writes to work around the issue.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/libata.h>
+#include <scsi/scsi_host.h>
+
+#define DRV_NAME	"pata_cs5536"
+#define DRV_VERSION	"0.0.4"
+
+enum {
+	IDE_CFG			= 0x40,
+	IDE_CFG_CHANEN		= 0x2,
+	IDE_CFG_CABLE		= 0x42,
+
+	IDE_D0_SHIFT		= 24,
+	IDE_D1_SHIFT		= 16,
+	IDE_DRV_MASK		= 0xff,
+
+	IDE_DTC			= 0x48,
+
+	IDE_CAST		= 0x4c,
+	IDE_CAST_D0_SHIFT	= 6,
+	IDE_CAST_D1_SHIFT	= 4,
+	IDE_CAST_DRV_MASK	= 0x3,
+	IDE_CAST_CMD_MASK	= 0xff,
+	IDE_CAST_CMD_SHIFT	= 24,
+
+	IDE_ETC			= 0x50,
+	IDE_ETC_NODMA		= 0x03,
+};
+
+/**
+ *	cs5536_cable_detect	-	detect cable type
+ *	@ap: Port to detect on
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Perform cable detection for ATA66 capable cable. Return a libata
+ *	cable type.
+ */
+
+static int cs5536_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 reg;
+
+	pci_read_config_byte(pdev, IDE_CFG_CABLE, &reg);
+
+	if (reg & (1 << ap->port_no))
+		return ATA_CBL_PATA80;
+	else
+		return ATA_CBL_PATA40;
+}
+
+/**
+ *	cs5536_set_piomode		-	PIO setup
+ *	@ap: ATA interface
+ *	@adev: device on the interface
+ */
+
+static void cs5536_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	static const u8 drv_timings[5] = {
+		0x98, 0x55, 0x32, 0x21, 0x20
+	};
+
+	static const u8 addr_timings[5] = {
+		0x2, 0x1, 0x0, 0x0, 0x0
+	};
+
+	static const u8 cmd_timings[5] = {
+		0x99, 0x92, 0x90, 0x22, 0x20
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_device *pair = ata_dev_pair(adev);
+	int mode = adev->pio_mode - XFER_PIO_0;
+	int cmdmode = mode;
+	int dshift = ap->port_no ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	int cshift = ap->port_no ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
+	u32 dtc, cast, etc;
+
+	if (pair)
+		cmdmode = min(mode, pair->pio_mode - XFER_PIO_0);
+
+	pci_read_config_dword(pdev, IDE_DTC, &dtc);
+	pci_read_config_dword(pdev, IDE_CAST, &cast);
+	pci_read_config_dword(pdev, IDE_ETC, &etc);
+
+	dtc &= ~(IDE_DRV_MASK << dshift);
+	dtc |= drv_timings[mode] << dshift;
+
+	cast &= ~(IDE_CAST_DRV_MASK << cshift);
+	cast |= addr_timings[mode] << cshift;
+
+	cast &= ~(IDE_CAST_CMD_MASK << IDE_CAST_CMD_SHIFT);
+	cast |= cmd_timings[cmdmode] << IDE_CAST_CMD_SHIFT;
+
+	etc &= ~(IDE_DRV_MASK << dshift);
+	etc |= IDE_ETC_NODMA << dshift;
+
+	pci_write_config_dword(pdev, IDE_DTC, dtc);
+	pci_write_config_dword(pdev, IDE_CAST, cast);
+	pci_write_config_dword(pdev, IDE_ETC, etc);
+}
+
+/**
+ *	cs5536_set_dmamode		-	DMA timing setup
+ *	@ap: ATA interface
+ *	@adev: Device being configured
+ *
+ */
+
+static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	static const u8 udma_timings[6] = {
+		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6
+	};
+
+	static const u8 mwdma_timings[3] = {
+		0x67, 0x21, 0x20
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 dtc, etc;
+	int mode = adev->dma_mode;
+	int dshift = ap->port_no ? IDE_D1_SHIFT  : IDE_D0_SHIFT;
+
+	if (mode >= XFER_UDMA_0) {
+		pci_read_config_dword(pdev, IDE_ETC, &etc);
+
+		etc &= ~(IDE_DRV_MASK << dshift);
+		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
+
+		pci_write_config_dword(pdev, IDE_ETC, etc);
+	} else { /* MWDMA */
+		pci_read_config_dword(pdev, IDE_DTC, &dtc);
+
+		dtc &= ~(IDE_DRV_MASK << dshift);
+		dtc |= mwdma_timings[mode] << dshift;
+
+		pci_write_config_dword(pdev, IDE_DTC, dtc);
+	}
+}
+
+static struct scsi_host_template cs5536_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations cs5536_port_ops = {
+	.port_disable	= ata_port_disable,
+	.set_piomode	= cs5536_set_piomode,
+	.set_dmamode	= cs5536_set_dmamode,
+	.mode_filter	= ata_pci_default_filter,
+
+	.tf_load	= ata_tf_load,
+	.tf_read	= ata_tf_read,
+	.check_status	= ata_check_status,
+	.exec_command	= ata_exec_command,
+	.dev_select	= ata_std_dev_select,
+
+	.freeze		= ata_bmdma_freeze,
+	.thaw		= ata_bmdma_thaw,
+	.error_handler	= ata_bmdma_error_handler,
+	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= cs5536_cable_detect,
+
+	.bmdma_setup	= ata_bmdma_setup,
+	.bmdma_start	= ata_bmdma_start,
+	.bmdma_stop	= ata_bmdma_stop,
+	.bmdma_status	= ata_bmdma_status,
+
+	.qc_prep	= ata_qc_prep,
+	.qc_issue	= ata_qc_issue_prot,
+
+	.data_xfer	= ata_data_xfer,
+
+	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
+
+	.port_start	= ata_port_start,
+};
+
+/**
+ *	cs5536_init_one
+ *	@dev: PCI device
+ *	@id: Entry in match table
+ *
+ */
+
+static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	static const struct ata_port_info info = {
+		.sht = &cs5536_sht,
+		.flags = ATA_FLAG_SLAVE_POSS,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = ATA_UDMA5,
+		.port_ops = &cs5536_port_ops
+	};
+
+	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
+	u8 reg;
+
+	pci_read_config_byte(dev, IDE_CFG, &reg);
+
+	if ((reg & IDE_CFG_CHANEN) == 0) {
+		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
+		return -ENODEV;
+	}
+
+	return ata_pci_init_one(dev, ppi);
+}
+
+static const struct pci_device_id cs5536[] = {
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE), },
+	{ },
+};
+
+static struct pci_driver cs5536_pci_driver = {
+	.name		= DRV_NAME,
+	.id_table	= cs5536,
+	.probe		= cs5536_init_one,
+	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
+#endif
+};
+
+static int __init cs5536_init(void)
+{
+	return pci_register_driver(&cs5536_pci_driver);
+}
+
+static void __exit cs5536_exit(void)
+{
+	pci_unregister_driver(&cs5536_pci_driver);
+}
+
+MODULE_AUTHOR("Martin K. Petersen");
+MODULE_DESCRIPTION("low-level driver for the CS5536 IDE controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, cs5536);
+MODULE_VERSION(DRV_VERSION);
+
+module_init(cs5536_init);
+module_exit(cs5536_exit);

