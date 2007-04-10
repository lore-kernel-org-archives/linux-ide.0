From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_acpi: Add ACPI method driver
Date: Wed, 11 Apr 2007 00:12:16 +0100
Message-ID: <20070411001216.072eb8d5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60851 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161021AbXDJXJN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:09:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

This adds a driver that use the ACPI methods to drive the hardware. It
can therefore in theory drive any SFF like controller for which the BIOS
provides methods.

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/ata/libata-acpi.h b/drivers/ata/libata-acpi.h
new file mode 100644
index 0000000..d630ec3
--- /dev/null
+++ b/drivers/ata/libata-acpi.h
@@ -0,0 +1,47 @@
+/*
+ *  libata-acpi.h - helper library for ATA ACPI drivers
+ *
+ *  Copyright 2007 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2007 Alan Cox
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
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
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ */
+
+#ifndef __LIBATA_ACPI_H__
+#define __LIBATA_ACPI_H__
+
+struct acpi_drive
+{
+	u32 pio;
+	u32 dma;
+};
+
+struct acpi_gtm {
+	struct acpi_drive drive[2];
+	u32 flags;
+};
+
+extern int ata_acpi_gtm(const struct ata_port *p, void *handle, struct acpi_gtm *gtm);
+extern int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm);
+extern void *ata_pata_acpi_handle(const struct ata_port *ap);
+extern int ata_pata_acpi_present(struct pci_dev *pdev);
+
+#endif
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 365c306..b8e0232 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -169,6 +169,15 @@ config SATA_ACPI
 	  You can disable this at kernel boot time by using the
 	  option libata.noacpi=1
 
+config PATA_ACPI
+	tristate "ACPI firmware driver for PATA"
+	depends on ACPI && PCI && SATA_ACPI
+	help
+	  This option enables an ACPI method driver which drives
+	  motherboard PATA controller interfaces through the ACPI
+	  firmware in the BIOS. This driver can sometimes handle
+	  otherwise unsupported hardware.
+
 config PATA_ALI
 	tristate "ALi PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b7055e3..b581888 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -62,6 +62,8 @@ obj-$(CONFIG_PATA_TRIFLEX)	+= pata_trifl
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
+# Should be last but two libata driver
+obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
 # Should be last but one libata driver
 obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 03a0acf..e0194ea 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -15,7 +15,7 @@
 #include <linux/libata.h>
 #include <linux/pci.h>
 #include "libata.h"
-
+#include "libata-acpi.h"
 #include <acpi/acpi_bus.h>
 #include <acpi/acnames.h>
 #include <acpi/acnamesp.h>
@@ -707,3 +707,88 @@ out:
 }
 
 
+int ata_acpi_gtm(const struct ata_port *ap, void *handle, struct acpi_gtm *gtm)
+{
+	acpi_status status;
+	struct acpi_buffer output;
+
+	output.length = ACPI_ALLOCATE_BUFFER;
+	output.pointer = NULL;
+
+	status = acpi_evaluate_object(handle, "_GTM", NULL, &output);
+
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR, "ACPI get timing mode failed.\n");
+		return -EINVAL;
+	}
+	if (output.length < sizeof(struct acpi_gtm) || output.pointer == NULL) {
+		ata_port_printk(ap, KERN_ERR, "ACPI get timing provided invalid data.\n");
+		return -EINVAL;
+	}
+	memcpy(gtm, output.pointer, sizeof(struct acpi_gtm));
+	kfree(output.pointer);
+	return 0;
+}
+
+int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
+{
+	acpi_status status;
+	struct acpi_object_list         input;
+	union acpi_object               in_params[3];
+
+	in_params[0].type = ACPI_TYPE_BUFFER;
+	in_params[0].buffer.length = sizeof(struct acpi_gtm);
+	in_params[0].buffer.pointer = (u8 *)stm;
+	/* Buffers for id may need byteswapping ? */
+	in_params[1].type = ACPI_TYPE_BUFFER;
+	in_params[1].buffer.length = 512;
+	in_params[1].buffer.pointer = (u8 *)ap->device[0].id;
+	in_params[2].type = ACPI_TYPE_BUFFER;
+	in_params[2].buffer.length = 512;
+	in_params[2].buffer.pointer = (u8 *)ap->device[1].id;
+
+	input.count = 3;
+	input.pointer = in_params;
+
+	status = acpi_evaluate_object(handle, "_STM", &input, NULL);
+
+	if (ACPI_FAILURE(status)) {
+		ata_port_printk(ap, KERN_ERR, "ACPI set timing mode failed.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void *ata_pata_find_handle(struct device *dev, int port)
+{
+	acpi_handle handle;
+	acpi_integer devfn;
+
+	if (libata_noacpi)
+		return NULL;
+	if (pata_get_dev_handle(dev, &handle, &devfn) < 0)
+		return NULL;
+	return acpi_get_child(handle, port);
+}
+
+void *ata_pata_acpi_handle(const struct ata_port *ap)
+{
+	return ata_pata_find_handle(ap->host->dev, ap->port_no);
+}
+
+int ata_pata_acpi_present(struct pci_dev *pdev)
+{
+	int present = 0;
+
+	if(ata_pata_find_handle(&pdev->dev, 0))
+		present |= 1;
+	if(ata_pata_find_handle(&pdev->dev, 1))
+		present |= 2;
+	return present;
+}
+
+
+EXPORT_SYMBOL_GPL(ata_acpi_gtm);
+EXPORT_SYMBOL_GPL(ata_acpi_stm);
+EXPORT_SYMBOL_GPL(ata_pata_acpi_handle);
+EXPORT_SYMBOL_GPL(ata_pata_acpi_present);
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
new file mode 100644
index 0000000..3c26178
--- /dev/null
+++ b/drivers/ata/pata_acpi.c
@@ -0,0 +1,424 @@
+/*
+ *	ACPI PATA driver
+ *
+ *	(c) 2007 Red Hat  <alan@redhat.com>
+ *
+ *	TODO - restore modes after mode_filter chews them up
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
+#include <acpi/acpi_bus.h>
+#include <acpi/acnames.h>
+#include <acpi/acnamesp.h>
+#include <acpi/acparser.h>
+#include <acpi/acexcep.h>
+#include <acpi/acmacros.h>
+#include <acpi/actypes.h>
+
+#include <linux/libata.h>
+#include <linux/ata.h>
+
+#include "libata-acpi.h"
+
+#define DRV_NAME	"pata_acpi"
+#define DRV_VERSION	"0.1.1"
+
+struct pata_acpi {
+	void *handle;
+	struct acpi_gtm gtm;
+	void *last;
+	unsigned long mask[2];
+};
+
+/**
+ *	pacpi_pre_reset	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform the PATA port setup we need.
+ */
+
+static int pacpi_pre_reset(struct ata_port *ap)
+{
+	struct pata_acpi *acpi = ap->private_data;
+
+	if (acpi->handle == NULL || ata_acpi_gtm(ap, acpi->handle, &acpi->gtm) < 0)
+		return -ENODEV;
+
+	return ata_std_prereset(ap);
+}
+
+/**
+ *	pacpi_cable_detect	-	cable type detection
+ *	@ap: port to detect
+ *
+ *	Perform device specific cable detection
+ */
+
+static int pacpi_cable_detect(struct ata_port *ap)
+{
+	struct pata_acpi *acpi = ap->private_data;
+
+	if ((acpi->mask[0] | acpi->mask[1]) & (0xF8 << ATA_SHIFT_UDMA))
+		return ATA_CBL_PATA80;
+	else
+		return ATA_CBL_PATA40;
+}
+
+/**
+ *	pacpi_error_handler - Setup and error handler
+ *	@ap: Port to handle
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void pacpi_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, pacpi_pre_reset, ata_std_softreset,
+				  NULL, ata_std_postreset);
+}
+
+/* Welcome to ACPI, bring a bucket */
+static const unsigned int pio_cycle[7] = {
+	600, 383, 240, 180, 120, 100, 80
+};
+static const unsigned int mwdma_cycle[5] = {
+	480, 150, 120, 100, 80
+};
+static const unsigned int udma_cycle[7] = {
+	120, 80, 60, 45, 30, 20, 15
+};
+
+/**
+ *	pacpi_discover_modes	-	filter non ACPI modes
+ *	@adev: ATA device
+ *	@mask: proposed modes
+ *
+ *	Try the modes available and see which ones the ACPI method will
+ *	set up sensibly. From this we get a mask of ACPI modes we can use
+ */
+
+static unsigned long pacpi_discover_modes(struct ata_port *ap, struct ata_device *adev)
+{
+	int unit = adev->devno;
+	struct pata_acpi *acpi = ap->private_data;
+	int i;
+	u32 t;
+	unsigned long mask = (0x7f << ATA_SHIFT_UDMA) | (0x7 << ATA_SHIFT_MWDMA) | (0x1F << ATA_SHIFT_PIO);
+
+	struct acpi_gtm probe;
+
+	probe = acpi->gtm;
+
+	/* We always use the 0 slot for crap hardware */
+	if (!(probe.flags & 0x10))
+		unit = 0;
+
+
+	/* In order to generate a valid mode mask as we need cycle through
+	   trying each proposed speed in turn */
+
+	/* Start by scanning for PIO modes */
+	for (i = 0; i < 7; i++) {
+		probe.drive[unit].pio = pio_cycle[i];
+		ata_acpi_stm(ap, acpi->handle, &probe);
+		ata_acpi_gtm(ap, acpi->handle, &probe);
+		t = probe.drive[unit].pio;
+		if (t == 0xFFFFFFFF || (i &&  t >= pio_cycle[i-1]))
+			mask &= ~(1 << (i + ATA_SHIFT_PIO));
+	}
+
+	/* Select MWDMA */
+	probe.flags &= ~(1 << (2 * unit));
+
+	/* Scan for MWDMA modes */
+	for (i = 0; i < 5; i++) {
+		u32 t;
+		probe.drive[unit].dma = mwdma_cycle[i];
+		ata_acpi_stm(ap, acpi->handle, &probe);
+		ata_acpi_gtm(ap, acpi->handle, &probe);
+
+		t = probe.drive[unit].dma;
+
+		if (t == 0xFFFFFFFF || (i && t >= mwdma_cycle[i-1]))
+			mask &= ~ (1 << (i + ATA_SHIFT_MWDMA));
+	}
+
+	/* Select UDMA */
+	probe.flags |= (1 << (2 * unit));
+
+	/* Scan for UDMA modes */
+	for (i = 0; i < 7; i++) {
+		u32 t;
+		probe.drive[unit].dma = udma_cycle[i];
+		ata_acpi_stm(ap, acpi->handle, &probe);
+		ata_acpi_gtm(ap, acpi->handle, &probe);
+
+		t = probe.drive[unit].dma;
+
+		if (t == 0xFFFFFFFF || (i && t >= udma_cycle[i-1]))
+			mask &= ~ (1 << (i + ATA_SHIFT_UDMA));
+	}
+
+	if (mask & (0xF8 << ATA_SHIFT_UDMA))
+		ap->cbl = ATA_CBL_PATA80;
+
+	/* Restore the programmed timings */
+	ata_acpi_stm(ap, acpi->handle, &acpi->gtm);
+	/* And finally we can hand back the list of speeds that actually are
+	   supported by the BIOS */
+	return mask;
+}
+
+/**
+ *	pacpi_mode_filter	-	mode filter for ACPI
+ *	@adev: device
+ *	@mask: mask of valid modes
+ *
+ *	Filter the valid mode list according to our own specific rules, in
+ *	this case the list of discovered valid modes obtained by ACPI probing
+ */
+
+static unsigned long pacpi_mode_filter(struct ata_device *adev, unsigned long mask)
+{
+	struct pata_acpi *acpi = adev->ap->private_data;
+	return ata_pci_default_filter(adev, mask & acpi->mask[adev->devno]);
+}
+
+/**
+ *	pacpi_set_piomode	-	set initial PIO mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ */
+
+static void pacpi_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	int unit = adev->devno;
+	struct pata_acpi *acpi = ap->private_data;
+
+	if(!(acpi->gtm.flags & 0x10))
+		unit = 0;
+
+	/* Now stuff the nS values into the structure */
+	acpi->gtm.drive[unit].pio = pio_cycle[adev->pio_mode - XFER_PIO_0];
+	ata_acpi_stm(ap, acpi->handle, &acpi->gtm);
+	/* See what mode we actually got */
+	ata_acpi_gtm(ap, acpi->handle, &acpi->gtm);
+}
+
+/**
+ *	pacpi_set_dmamode	-	set initial DMA mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ */
+
+static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	int unit = adev->devno;
+	struct pata_acpi *acpi = ap->private_data;
+
+	if(!(acpi->gtm.flags & 0x10))
+		unit = 0;
+
+	/* Now stuff the nS values into the structure */
+	if (adev->dma_mode >= XFER_UDMA_0) {
+		acpi->gtm.drive[unit].dma = udma_cycle[adev->dma_mode - XFER_UDMA_0];
+		acpi->gtm.flags |= (1 << (2 * unit));
+	} else {
+		acpi->gtm.drive[unit].dma = mwdma_cycle[adev->dma_mode - XFER_MW_DMA_0];
+		acpi->gtm.flags &= ~(1 << (2 * unit));
+	}
+	ata_acpi_stm(ap, acpi->handle, &acpi->gtm);
+	/* See what mode we actually got */
+	ata_acpi_gtm(ap, acpi->handle, &acpi->gtm);
+}
+
+/**
+ *	pacpi_qc_issue_prot	-	command issue
+ *	@qc: command pending
+ *
+ *	Called when the libata layer is about to issue a command. We wrap
+ *	this interface so that we can load the correct ATA timings if
+ *	neccessary.
+ */
+
+static unsigned int pacpi_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *adev = qc->dev;
+	struct pata_acpi *acpi = ap->private_data;
+
+	if (acpi->gtm.flags & 0x10)
+		return ata_qc_issue_prot(qc);
+
+	if (adev != acpi->last) {
+		pacpi_set_piomode(ap, adev);
+		if (adev->dma_mode)
+			pacpi_set_dmamode(ap, adev);
+		acpi->last = adev;
+	}
+	return ata_qc_issue_prot(qc);
+}
+
+/**
+ *	pacpi_port_start	-	port setup
+ *	@ap: ATA port being set up
+ *
+ *	Use the port_start hook to maintain private control structures
+ */
+
+static int pacpi_port_start(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct pata_acpi *acpi;
+
+	int ret;
+
+	acpi = ap->private_data = devm_kzalloc(&pdev->dev, sizeof(struct pata_acpi), GFP_KERNEL);
+	if (ap->private_data == NULL)
+		return -ENOMEM;
+	acpi->handle = ata_pata_acpi_handle(ap);
+
+	acpi->mask[0] = pacpi_discover_modes(ap, &ap->device[0]);
+	acpi->mask[1] = pacpi_discover_modes(ap, &ap->device[1]);
+
+	ret = ata_port_start(ap);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static struct scsi_host_template pacpi_sht = {
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
+	/* Use standard CHS mapping rules */
+	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
+};
+
+static const struct ata_port_operations pacpi_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= pacpi_set_piomode,
+	.set_dmamode		= pacpi_set_dmamode,
+	.mode_filter		= pacpi_mode_filter,
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
+	.error_handler		= pacpi_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= pacpi_cable_detect,
+
+	/* BMDMA handling is PCI ATA format, use helpers */
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= pacpi_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+
+	/* Timeout handling */
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
+
+	/* Generic PATA PCI ATA helpers */
+	.port_start		= pacpi_port_start,
+};
+
+
+/**
+ *	pacpi_init_one - Register ACPI ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in pacpi_pci_tbl matching with @pdev
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
+static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht		= &pacpi_sht,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask 	= 0x7f,
+
+		.port_ops	= &pacpi_ops,
+	};
+	struct ata_port_info *port_info[1] = { &info };
+
+	if (!ata_pata_acpi_present(pdev))
+		return -ENODEV;
+	return ata_pci_init_one(pdev, port_info, 1);
+}
+
+static const struct pci_device_id pacpi_pci_tbl[] = {
+	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 1},
+	{ }	/* terminate list */
+};
+
+static struct pci_driver pacpi_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= pacpi_pci_tbl,
+	.probe			= pacpi_init_one,
+	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+};
+
+static int __init pacpi_init(void)
+{
+	return pci_register_driver(&pacpi_pci_driver);
+}
+
+static void __exit pacpi_exit(void)
+{
+	pci_unregister_driver(&pacpi_pci_driver);
+}
+
+module_init(pacpi_init);
+module_exit(pacpi_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("SCSI low-level driver for ATA in ACPI mode");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, pacpi_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+
