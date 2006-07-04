From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 15/24] ata_generic - generic BIOS setup SFF ATA driver
Date: Tue, 4 Jul 2006 18:14:40 +0000 (UTC)
Message-ID: <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47502 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932303AbWGDSO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:26 -0400
Date: Maw, 04 Gor 2006 19:01:39 +0100
In-Reply-To: <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/Kconfig       |    9 ++
 drivers/scsi/Makefile      |    2 
 drivers/scsi/ata_generic.c |  256 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+), 0 deletions(-)
 create mode 100644 drivers/scsi/ata_generic.c

9027b93110c628892846cacf1ca9875132e2d83b
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 13c5943..fd6a545 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -577,6 +577,15 @@ config SCSI_PATA_EFAR
 
 	  If unsure, say N.
 
+config SCSI_ATA_GENERIC
+	tristate "Generic PATA support"
+	depends on SCSI_SATA && PCI
+	help
+	  This option enables support for generic BIOS configured
+	  PATA controllers via the new ATA layer
+
+	  If unsure, say N.
+
 config SCSI_PATA_HPT366
 	tristate "HPT 366/368 PATA support (Very Experimental)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 0031c76..3654dab 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -174,6 +174,8 @@ obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o s
 obj-$(CONFIG_SCSI_SATA_ULI)	+= libata.o sata_uli.o
 obj-$(CONFIG_SCSI_SATA_MV)	+= libata.o sata_mv.o
 obj-$(CONFIG_SCSI_PDC_ADMA)	+= libata.o pdc_adma.o
+# Should be last but one libata driver
+obj-$(CONFIG_SCSI_ATA_GENERIC)	+= libata.o ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_SCSI_PATA_LEGACY)	+= libata.o pata_legacy.o
 obj-$(CONFIG_SCSI_HPTIOP)	+= hptiop.o
diff --git a/drivers/scsi/ata_generic.c b/drivers/scsi/ata_generic.c
new file mode 100644
index 0000000..6df7ca5
--- /dev/null
+++ b/drivers/scsi/ata_generic.c
@@ -0,0 +1,256 @@
+/*
+ *  ata_generic.c - Generic PATA/SATA controller driver.
+ *  Copyright 2005 Red Hat Inc <alan@redhat.com>, all rights reserved.
+ *
+ *  Elements from ide/pci/generic.c 
+ *	    Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
+ *	    Portions (C) Copyright 2002  Red Hat Inc <alan@redhat.com>
+ *
+ *  May be copied or modified under the terms of the GNU General Public License
+ *  
+ *  Driver for PCI IDE interfaces implementing the standard bus mastering
+ *  interface functionality. This assumes the BIOS did the drive set up and
+ *  tuning for us. By default we do not grab all IDE class devices as they
+ *  may have other drivers or need fixups to avoid problems. Instead we keep
+ *  a default list of stuff without documentation/driver that appears to
+ *  work.  
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME "ata_generic"
+#define DRV_VERSION "0.2.4"
+
+/*
+ *	A generic parallel ATA driver using libata
+ */
+
+/**
+ *	genpata_pre_reset		-	probe begin
+ *	@ap: ATA port
+ *
+ *	Set up cable type and use generic probe init
+ */
+ 
+static int genpata_pre_reset(struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(ap);
+}
+
+
+/**
+ *	genpata_error_handler - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *	@classes:
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+ 
+static void genpata_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, genpata_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+}
+
+/**
+ *	genpata_set_mode	-	mode setting
+ *	@ap: interface to set up
+ *
+ *	Use a non standard set_mode function. We don't want to be tuned.
+ *	The BIOS configured everything. Our job is not to fiddle. We
+ *	read the dma enabled bits from the PCI configuration of the device
+ *	and respect them. 
+ */
+ 
+static void genpata_set_mode(struct ata_port *ap)
+{
+	int dma_enabled = 0;
+	int i;
+
+	/* Bits 5 and 6 indicate if DMA is active on master/slave */
+	if (ap->ioaddr.bmdma_addr)
+		dma_enabled = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_enabled(dev)) {
+			/* We don't really care */
+			dev->pio_mode = XFER_PIO_0;
+			dev->dma_mode = XFER_MW_DMA_0;
+			/* We do need the right mode information for DMA or PIO 
+			   and this comes from the current configuration flags */
+			/* FIXME: at some point in the future this should become
+			   a library helper which reads the disk modes from the
+			   disk as well */
+			if (dma_enabled & (1 << (5 + i))) {
+				dev->xfer_mode = XFER_MW_DMA_0;
+				dev->xfer_shift = ATA_SHIFT_MWDMA;
+				dev->flags &= ~ATA_DFLAG_PIO;
+			} else {
+				dev->xfer_mode = XFER_PIO_0;
+				dev->xfer_shift = ATA_SHIFT_PIO;
+				dev->flags |= ATA_DFLAG_PIO;
+			}
+		}
+	}
+}
+
+static struct scsi_host_template genpata_sht = {
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
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations genpata_port_ops = {
+	.set_mode	= genpata_set_mode,
+	
+	.port_disable	= ata_port_disable,
+	.tf_load	= ata_tf_load,
+	.tf_read	= ata_tf_read,
+	.check_status 	= ata_check_status,
+	.exec_command	= ata_exec_command,
+	.dev_select 	= ata_std_dev_select,
+
+	.bmdma_setup 	= ata_bmdma_setup,
+	.bmdma_start 	= ata_bmdma_start,
+	.bmdma_stop	= ata_bmdma_stop,
+	.bmdma_status 	= ata_bmdma_status,
+	
+	.data_xfer	= ata_pio_data_xfer,
+
+	.freeze		= ata_bmdma_freeze,
+	.thaw		= ata_bmdma_thaw,
+	.error_handler	= genpata_error_handler,
+	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+
+	.qc_prep 	= ata_qc_prep,
+	.qc_issue	= ata_qc_issue_prot,
+	.eng_timeout	= ata_eng_timeout,
+	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
+	.port_start	= ata_port_start,
+	.port_stop	= ata_port_stop,
+	.host_stop	= ata_host_stop
+};	
+	
+static int all_generic_ide;		/* Set to claim all devices */
+
+/**
+ *	pata_generic_init		-	attach generic IDE
+ *	@dev: PCI device found
+ *	@id: match entry
+ *
+ *	Called each time a matching IDE interface is found. We check if the
+ *	interface is one we wish to claim and if so we perform any chip 
+ *	specific hacks then let the ATA layer do the heavy lifting.
+ */
+ 
+static int pata_generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	u16 command;
+	static struct ata_port_info info = {
+		.sht = &genpata_sht,
+		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.mwdma_mask = 0x07,
+		.udma_mask = 0x3f,
+		.port_ops = &genpata_port_ops
+	};
+	static struct ata_port_info *port_info[2] = { &info, &info };
+		
+	/* Don't use the generic entry unless instructed to do so */
+	if (id->driver_data == 1 && all_generic_ide == 0)
+		return -ENODEV;
+
+	/* Devices that need care */
+	if (dev->vendor == PCI_VENDOR_ID_UMC &&
+	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
+	    (!(PCI_FUNC(dev->devfn) & 1)))
+		return -ENODEV;
+
+	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
+	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
+	    (!(PCI_FUNC(dev->devfn) & 1)))
+		return -ENODEV;
+
+	/* Don't re-enable devices in generic mode or we will break some
+	   motherboards with disabled and unused IDE controllers */
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	if (!(command & PCI_COMMAND_IO))
+		return -ENODEV;
+		
+	if (dev->vendor == PCI_VENDOR_ID_AL)
+	    	ata_pci_clear_simplex(dev);
+
+	return ata_pci_init_one(dev, port_info, 2);
+}
+
+static struct pci_device_id pata_generic[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8673F), }, 
+	{ PCI_DEVICE(PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886A), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_UMC,    PCI_DEVICE_ID_UMC_UM8886BF), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
+	/* Must come last. If you add entries adjust this table appropriately */
+	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 1},
+	{ 0, },
+};
+
+static struct pci_driver pata_generic_pci_driver = {
+        .name 		= DRV_NAME,
+	.id_table	= pata_generic,
+	.probe 		= pata_generic_init_one,
+	.remove		= ata_pci_remove_one
+};
+
+static int __init pata_generic_init(void)
+{
+	return pci_module_init(&pata_generic_pci_driver);
+}
+
+
+static void __exit pata_generic_exit(void)
+{
+	pci_unregister_driver(&pata_generic_pci_driver);
+}
+
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("low-level driver for generic ATA");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, pata_generic);
+MODULE_VERSION(DRV_VERSION);
+
+module_init(pata_generic_init);
+module_exit(pata_generic_exit);
+
+module_param(all_generic_ide, int, 0);
-- 
1.2.GIT

