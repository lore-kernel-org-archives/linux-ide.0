From: akpm@osdl.org
Subject: [patch 11/12] pata_marvell: Marvell 6101/6145 PATA driver
Date: Fri, 20 Oct 2006 14:39:44 -0700
Message-ID: <200610202139.k9KLdirn003592@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:45187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992748AbWJTVkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a legacy mode PATA driver for the 6101/45 and will also drive the SATA
ports 1 & 2 in legacy mode as well if desired.  Tested and confirmed working
by users.  The chip supports AHCI type behaviour for SATA and has a more
advanced PATA interface as well so this driver will get it working but not get
best performance for now.

[akpm@osdl.org: build fix, warning fix]
Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/Kconfig        |    9 +
 drivers/ata/Makefile       |    1 
 drivers/ata/pata_marvell.c |  219 +++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)

diff -puN drivers/ata/Kconfig~pata_marvell-marvell-6101-6145-pata-driver drivers/ata/Kconfig
--- a/drivers/ata/Kconfig~pata_marvell-marvell-6101-6145-pata-driver
+++ a/drivers/ata/Kconfig
@@ -341,6 +341,15 @@ config PATA_TRIFLEX
 
 	  If unsure, say N.
 
+config PATA_MARVELL
+	tristate "Marvell PATA support via legacy mode"
+	depends on PCI
+	help
+	  This option enables limited support for the Marvell 88SE6145 ATA
+	  controller.
+
+	  If unsure, say N.
+
 config PATA_MPIIX
 	tristate "Intel PATA MPIIX support"
 	depends on PCI
diff -puN drivers/ata/Makefile~pata_marvell-marvell-6101-6145-pata-driver drivers/ata/Makefile
--- a/drivers/ata/Makefile~pata_marvell-marvell-6101-6145-pata-driver
+++ a/drivers/ata/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PATA_NETCELL)	+= pata_netce
 obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
 obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
 obj-$(CONFIG_PATA_OPTIDMA)	+= pata_optidma.o
+obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
 obj-$(CONFIG_PATA_OLDPIIX)	+= pata_oldpiix.o
 obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
diff -puN /dev/null drivers/ata/pata_marvell.c
--- /dev/null
+++ a/drivers/ata/pata_marvell.c
@@ -0,0 +1,219 @@
+/*
+ *	Marvell PATA driver.
+ *
+ *	For the moment we drive the PATA port in legacy mode. That
+ *	isn't making full use of the device functionality but it is
+ *	easy to get working.
+ *
+ *	(c) 2006 Red Hat  <alan@redhat.com>
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
+#include <linux/ata.h>
+
+#define DRV_NAME	"pata_marvell"
+#define DRV_VERSION	"0.0.5t"
+
+/**
+ *	marvell_pre_reset	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform the PATA port setup we need.
+ */
+
+static int marvell_pre_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 devices;
+	void __iomem *barp;
+	int i;
+
+	/* Check if our port is enabled */
+
+	barp = pci_iomap(pdev, 5, 0x10);
+	if (barp == NULL)
+		return -ENOMEM;
+	printk("BAR5:");
+	for(i = 0; i <= 0x0F; i++)
+		printk("%02X:%02X ", i, readb(barp + i));
+	printk("\n");
+
+	devices = readl(barp + 0x0C);
+	pci_iounmap(pdev, barp);
+
+	if (pdev->device == 0x6145 && ap->port_no == 0 && !(devices & 0x10))	/* PATA enable ? */
+		return -ENOENT;
+
+	/* Cable type */
+	switch(ap->port_no)
+	{
+		case 0:
+			/* Might be backward, docs unclear */
+			if(inb(ap->ioaddr.bmdma_addr + 1) & 1)
+				ap->cbl = ATA_CBL_PATA80;
+			else
+				ap->cbl = ATA_CBL_PATA40;
+
+		case 1: /* Legacy SATA port */
+			ap->cbl = ATA_CBL_SATA;
+			break;
+	}
+	return ata_std_prereset(ap);
+}
+
+/**
+ *	marvell_error_handler - Setup and error handler
+ *	@ap: Port to handle
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void marvell_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+}
+
+/* No PIO or DMA methods needed for this device */
+
+static struct scsi_host_template marvell_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	/* Use standard CHS mapping rules */
+	.bios_param		= ata_std_bios_param,
+};
+
+static const struct ata_port_operations marvell_ops = {
+	.port_disable		= ata_port_disable,
+
+	/* Task file is PCI ATA format, use helpers */
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= marvell_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	/* BMDMA handling is PCI ATA format, use helpers */
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	/* Timeout handling */
+	.eng_timeout		= ata_eng_timeout,
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	/* Generic PATA PCI ATA helpers */
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+
+/**
+ *	marvell_init_one - Register Marvell ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in marvell_pci_tbl matching with @pdev
+ *
+ *	Called from kernel PCI layer.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht		= &marvell_sht,
+		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask 	= 0x3f,
+
+		.port_ops	= &marvell_ops,
+	};
+	static struct ata_port_info info_sata = {
+		.sht		= &marvell_sht,
+		/* Slave possible as its magically mapped not real */
+		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask 	= 0x7f,
+
+		.port_ops	= &marvell_ops,
+	};
+	struct ata_port_info *port_info[2] = { &info, &info_sata };
+	int n_port = 2;
+
+	if (pdev->device == 0x6101)
+		n_port = 1;
+
+	return ata_pci_init_one(pdev, port_info, n_port);
+}
+
+static const struct pci_device_id marvell_pci_tbl[] = {
+	{ PCI_DEVICE(0x11AB, 0x6101), },
+	{ PCI_DEVICE(0x11AB, 0x6145), },
+	{ }	/* terminate list */
+};
+
+static struct pci_driver marvell_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= marvell_pci_tbl,
+	.probe			= marvell_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static int __init marvell_init(void)
+{
+	return pci_register_driver(&marvell_pci_driver);
+}
+
+static void __exit marvell_exit(void)
+{
+	pci_unregister_driver(&marvell_pci_driver);
+}
+
+module_init(marvell_init);
+module_exit(marvell_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("SCSI low-level driver for Marvell ATA in legacy mode");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, marvell_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+
_
