From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: libata driver for MPIIX
Date: Thu, 08 Dec 2005 14:41:48 +0000
Message-ID: <1134052908.17102.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:51594 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932118AbVLHOm3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Dec 2005 09:42:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is the first cut for the MPIIX driver. This chip isn't actually
handled by the existing drivers/ide/pci code which grabs the device then
skips all meaningful tuning of it.

Its actually sufficiently different to the PIIX and friends that it
makes sense to have a seperate driver for it.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm2/drivers/scsi/pata_mpiix.c linux-2.6.14-mm2/drivers/scsi/pata_mpiix.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_mpiix.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2/drivers/scsi/pata_mpiix.c	2005-12-08 14:32:30.546301224 +0000
@@ -0,0 +1,223 @@
+/*
+ * pata_mpiix.c 	- Intel MPIIX PATA for new ATA layer
+ *			  (C) 2005 Red Hat Inc
+ *			  Alan Cox <alan@redhat.com>
+ *
+ * The MPIIX is different enough to the PIIX4 and friends that we give it
+ * a separate driver. The old ide/pci code handles this by just not tuning
+ * MPIIX at all. May also handle original PIIX but need data sheets.
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
+
+#define DRV_NAME "pata_mpiix"
+#define DRV_VERSION "0.1"
+
+/**
+ *	mpiix_phy_reset		-	probe reset
+ *	@ap: ATA port
+ *
+ *	Perform the ATA probe and bus reset sequence plus specific handling
+ *	for this hardware. The MPIIX has the enable bits in a different place
+ *	to PIIX4 and friends. As a pure PIO device it has no cable detect
+ */
+
+static void mpiix_phy_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	static const struct pci_bits mpiix_enable_bits[] = {
+		{ 0x6D, 1, 0x80, 0x00 },
+		{ 0x6F, 1, 0x08, 0x00 }
+	};
+
+	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->hard_port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
+	ap->cbl = ATA_CBL_PATA40;
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
+/**
+ *	mpiix_set_piomode	-	set initial PIO mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Called to do the PIO mode setup. The MPIIX allows us to program the
+ *	IORDY sample point (2-5 clocks), recovery 1-4 clocks and whether
+ *	prefetching or iordy are used.
+ *
+ *	This would get very ugly because we can only program timing for one
+ *	device at a time, the other gets PIO0. Fortunately libata calls 
+ *	our qc_issue_prot command before a command is issued so we can
+ *	flip the timings back and forth to reduce the pain.
+ */
+
+static void mpiix_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	int control = 0;
+	int pio = adev->pio_mode - XFER_PIO_0;
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	u16 idetim;
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	pci_read_config_word(pdev, 0x6C, &idetim);
+	/* Mask the IORDY/TIME/PPE0 bank for this device */
+	if(adev->class == ATA_DEV_ATA)
+		control |= 4;	/* PPE enable for disk */
+	/* As with PIIX we need libata core code for pio/iordy */
+	if(pio > 2)
+		control |= 2;	/* IORDY */
+	if(pio > 0)
+		control |= 1;	/* This drive is on the fast timing bank */
+
+	/* Mask out timing and clear both TIME bank selects */
+	idetim &= 0xCCEE;
+	idetim &= ~(0x07  << (2 * adev->devno));
+	idetim |= (control << (2 * adev->devno));
+	
+	idetim |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
+	pci_write_config_word(pdev, 0x6C, idetim);
+	
+	/* We use ap->private_data as a pointer to the device currently
+	   loaded for timing */
+	ap->private_data = adev;
+}
+
+/**
+ *	mpiix_qc_issue_prot	-	command issue
+ *	@qc: command pending
+ *
+ *	Called when the libata layer is about to issue a command. We wrap
+ *	this interface so that we can load the correct ATA timings if
+ *	neccessary. Our logic also clears TIME0/TIME1 for the other device so
+ *	that, even if we get this wrong, cycles to the other device will
+ *	be made PIO0.
+ */
+
+static int mpiix_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	if(qc->dev != ap->private_data)
+		mpiix_set_piomode(ap, qc->dev);
+		
+	return ata_qc_issue_prot(qc);
+}
+
+static struct scsi_host_template mpiix_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
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
+	.ordered_flush		= 1,
+};
+
+static struct ata_port_operations mpiix_port_ops = {
+	.port_disable	= ata_port_disable,
+	.set_piomode	= mpiix_set_piomode,
+
+	.tf_load	= ata_tf_load,
+	.tf_read	= ata_tf_read,
+	.check_status 	= ata_check_status,
+	.exec_command	= ata_exec_command,
+	.dev_select 	= ata_std_dev_select,
+
+	.phy_reset	= mpiix_phy_reset,
+
+	.qc_prep 	= ata_qc_prep,
+	.qc_issue	= mpiix_qc_issue_prot,
+	.eng_timeout	= ata_eng_timeout,
+
+	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
+	.port_start	= ata_port_start,
+	.port_stop	= ata_port_stop,
+	.host_stop	= ata_host_stop
+};
+
+static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht = &mpiix_sht,
+		.host_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask = 0x1f,
+		.port_ops = &mpiix_port_ops
+	};
+	static struct ata_port_info *port_info[2] = { &info, &info };
+	static int printed_version;
+	u16 idetim;
+	
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
+		
+	/* MPIIX has many functions which can be turned on or off according
+	   to other devices present. Make sure IDE is enabled before we try
+	   and use it */
+	   
+	pci_read_config_word(dev, 0x6C, &idetim);
+	if(!(idetim & 0x8000))
+		return -ENODEV;
+
+	return ata_pci_init_one(dev, port_info, 2);
+}
+
+static const struct pci_device_id mpiix[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, },
+};
+
+static struct pci_driver mpiix_pci_driver = {
+        .name 		= DRV_NAME,
+	.id_table	= mpiix,
+	.probe 		= mpiix_init_one,
+	.remove		= ata_pci_remove_one
+};
+
+static int __init mpiix_init(void)
+{
+	return pci_module_init(&mpiix_pci_driver);
+}
+
+
+static void __exit mpiix_exit(void)
+{
+	pci_unregister_driver(&mpiix_pci_driver);
+}
+
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("low-level driver for Intel MPIIX");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, mpiix);
+MODULE_VERSION(DRV_VERSION);
+
+module_init(mpiix_init);
+module_exit(mpiix_exit);

