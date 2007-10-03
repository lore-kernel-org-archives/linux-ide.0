From: "Martin K. Petersen" <mkp@mkp.net>
Subject: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 03 Oct 2007 13:28:16 -0400
Message-ID: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:33835 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbXJCR2R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 13:28:17 -0400
Received: from sermon.lab.mkp.net (groovelator.mkp.net [209.217.122.111])
	by jaguar.mkp.net (Postfix) with ESMTP id 900F187E38
	for <linux-ide@vger.kernel.org>; Wed,  3 Oct 2007 13:28:16 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This is a driver specifically for the ATA controller on the Geode
CS5536 companion chip.  The PCI device ID for this device was
previously claimed by pata_amd.c but there were two problems with
that:

 - Not all Geode platforms emulate the ATA registers in PCI config
   space

 - CS5536 PIO timings are not identical to AMD74XX/8111

pata_cs5536.c relies on Geode Machine Specific Registers to configure
the ATA function and uses the correct PIO timings for the chip.

Signed-off-by: Martin K. Petersen <mkp@mkp.net>

---

diff --git a/arch/i386/kernel/reboot_fixups.c b/arch/i386/kernel/reboot_fixups.c
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index d8046a1..cb80f12 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
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
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 8149c68..c9f12e8 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
 obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
 obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
 obj-$(CONFIG_PATA_CS5535)	+= pata_cs5535.o
+obj-$(CONFIG_PATA_CS5536)	+= pata_cs5536.o
 obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
 obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
 obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 04048fc..e5ef1bf 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -611,14 +611,6 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.udma_mask = ATA_UDMA6,	/* UDMA 133, no swdma */
 			.port_ops = &nv133_port_ops
 		},
-		{	/* 9: AMD CS5536 (Geode companion) */
-			.sht = &amd_sht,
-			.flags = ATA_FLAG_SLAVE_POSS,
-			.pio_mask = 0x1f,
-			.mwdma_mask = 0x07,
-			.udma_mask = ATA_UDMA5,	/* UDMA 100 */
-			.port_ops = &amd100_port_ops
-		}
 	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 	static int printed_version;
@@ -693,7 +685,6 @@ static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
-	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
 
 	{ },
 };
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
new file mode 100644
index 0000000..16c6b7f
--- /dev/null
+++ b/drivers/ata/pata_cs5536.c
@@ -0,0 +1,320 @@
+/*
+ * pata_cs5536.c	- CS5536 PATA for new ATA layer
+ *			  (C) 2007 Martin K. Petersen <mkp@mkp.net>
+ *
+ * Based on pata_cs5535.c.
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
+ * Like its predecessor (CS5535), CS5536 exposes its IDE configuration
+ * registers to the Geode Machine Specific Register file instead of
+ * PCI config space.  The 5536 IDE registers are modeled after the AMD
+ * 74xx PCI IDE controller although some of the timing knobs are
+ * subtly different.  Initially the CS5536 was supported by the
+ * pata_amd.c driver as some Geode platforms emulate the PCI config
+ * register support in firmware.  This driver, however, does not
+ * depend on PCI config emulation and accesses the MSR registers
+ * directly.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <asm/msr.h>
+
+#define DRV_NAME	"cs5536"
+#define DRV_VERSION	"0.0.2"
+
+enum {
+	MSR_IDE_BASE		= 0x51300000,
+
+	MSR_IDE_CFG		= (MSR_IDE_BASE + 0x10),
+	MSR_IDE_DTC		= (MSR_IDE_BASE + 0x12),
+	MSR_IDE_CAST		= (MSR_IDE_BASE + 0x13),
+	MSR_IDE_ETC		= (MSR_IDE_BASE + 0x14),
+
+	IDE_CFG_CHANEN		= 0x2,
+	IDE_CFG_CABLE		= 0x10000,
+	IDE_CFG_CABLE_MASK	= 0x30000,
+
+	IDE_DTC_D0_SHIFT	= 24,
+	IDE_DTC_D1_SHIFT	= 16,
+	IDE_DTC_MASK		= 0xff,
+
+	IDE_CAST_D0_SHIFT	= 6,
+	IDE_CAST_D1_SHIFT	= 4,
+	IDE_CAST_DRV_MASK	= 0x3,
+
+	IDE_CAST_CMD_MASK	= 0xff,
+	IDE_CAST_CMD_SHIFT	= 24,
+
+	IDE_ETC_DRV_MASK	= 0xff,
+	IDE_ETC_D0_SHIFT	= 24,
+	IDE_ETC_D1_SHIFT	= 16,
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
+	u32 reg, dummy;
+
+	rdmsr(MSR_IDE_CFG, reg, dummy);
+
+	if (reg & (IDE_CFG_CABLE << ap->port_no))
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
+	struct ata_device *pair = ata_dev_pair(adev);
+	int mode = adev->pio_mode - XFER_PIO_0;
+	int cmdmode = mode;
+	int port = ap->port_no;
+	u32 dtc, cast, etc, dummy;
+
+	/* Command timing has to be for the lowest of the pair of devices */
+	if (pair) {
+		int pairmode = pair->pio_mode - XFER_PIO_0;
+		cmdmode = min(mode, pairmode);
+	}
+
+	rdmsr(MSR_IDE_DTC, dtc, dummy);
+	rdmsr(MSR_IDE_CAST, cast, dummy);
+
+	if (port == 1) {
+		dtc &= ~(IDE_DTC_MASK << IDE_DTC_D1_SHIFT);
+		dtc |= drv_timings[mode] << IDE_DTC_D1_SHIFT;
+		cast &= ~(IDE_CAST_DRV_MASK << IDE_CAST_D1_SHIFT);
+		cast |= addr_timings[mode] << IDE_CAST_D1_SHIFT;
+	} else {
+		dtc &= ~(IDE_DTC_MASK << IDE_DTC_D0_SHIFT);
+		dtc |= drv_timings[mode] << IDE_DTC_D0_SHIFT;
+		cast &= ~(IDE_CAST_DRV_MASK << IDE_CAST_D0_SHIFT);
+		cast |= addr_timings[mode] << IDE_CAST_D0_SHIFT;
+	}
+
+	cast &= ~(IDE_CAST_CMD_MASK << IDE_CAST_CMD_SHIFT);
+	cast |= cmd_timings[cmdmode] << IDE_CAST_CMD_SHIFT;
+	etc = 0x03030000;
+
+	wrmsr(MSR_IDE_DTC, dtc, 0);
+	wrmsr(MSR_IDE_CAST, cast, 0);
+	wrmsr(MSR_IDE_ETC, etc, 0);
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
+	u32 dtc, etc, dummy;
+	int mode = adev->dma_mode;
+	int port = ap->port_no;
+
+	if (mode >= XFER_UDMA_0) {
+		rdmsr(MSR_IDE_ETC, etc, dummy);
+
+		if (port == 1) {
+			etc &= ~(IDE_ETC_DRV_MASK << IDE_ETC_D1_SHIFT);
+			etc |= udma_timings[mode - XFER_UDMA_0]
+				<< IDE_ETC_D1_SHIFT;
+		} else {
+			etc &= ~(IDE_ETC_DRV_MASK << IDE_ETC_D0_SHIFT);
+			etc |= udma_timings[mode - XFER_UDMA_0]
+				<< IDE_ETC_D0_SHIFT;
+		}
+
+		wrmsr(MSR_IDE_ETC, etc, 0);
+	} else { /* MWDMA */
+		rdmsr(MSR_IDE_DTC, dtc, dummy);
+
+		if (port == 1) {
+			dtc &= ~(IDE_DTC_MASK << IDE_DTC_D1_SHIFT);
+			dtc |= mwdma_timings[mode] << IDE_DTC_D1_SHIFT;
+		} else {
+			dtc &= ~(IDE_DTC_MASK << IDE_DTC_D0_SHIFT);
+			dtc |= mwdma_timings[mode] << IDE_DTC_D0_SHIFT;
+		}
+
+		wrmsr(MSR_IDE_DTC, dtc, 0);
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
+	u32 cfg, dummy;
+
+	rdmsr(MSR_IDE_CFG, cfg, dummy);
+
+	if ((cfg & IDE_CFG_CHANEN) == 0) {
+		printk(KERN_ERR "CS5536: disabled by BIOS\n");
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
