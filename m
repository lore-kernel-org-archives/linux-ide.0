From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: libata - oldpiix driver
Date: Thu, 08 Dec 2005 14:48:49 +0000
Message-ID: <1134053330.17102.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:25749 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750914AbVLHOtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Dec 2005 09:49:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Early PIIX devices are quite different to the later ones and have some
more awkward constraints, notably the lack of SITRE and seperate slave
timing. 

In the old IDE drivers this chipset is handled (badly) by the piix
driver. For libata I've split it out so that all the detail differences
that piix doesn't handle and which make it scribble into wrong registers
and stuff don't end up mucking up the piix4/ich driver code with a
million conditions.

I'll post some updates to the ata_piix driver later today hopefully as
I'm still debugging that one, but have added MWDMA, errata and other
chipset support plus fixed a couple of bugs with slave devices and a pci
config space scribble when using pre ICH chips.

Thanks to Maciej for having the data sheet around.

Alan


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2/drivers/scsi/pata_oldpiix.c	2005-12-07 17:26:37.000000000 +0000
@@ -0,0 +1,337 @@
+/*
+ *    pata_oldpiix.c - Intel PATA/SATA controllers
+ *
+ *	(C) 2005 Red Hat <alan@redhat.com>
+ *
+ *    Some parts based on ata_piix.c by Jeff Garzik and others.
+ *
+ *    Early PIIX differs significantly from the later PIIX as it lacks
+ *    SITRE and the slave timing registers. This means that you have to
+ *    set timing per channel, or be clever. Libata tells us whenever it
+ *    does drive selection and we use this to reload the timings. 
+ *
+ *    Because of these behaviour differences PIIX gets its own driver module.
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
+#define DRV_NAME	"pata_oldpiix"
+#define DRV_VERSION	"0.1"
+
+/**
+ *	oldpiix_pata_phy_reset - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void oldpiix_pata_phy_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	static struct pci_bits oldpiix_enable_bits[] = {
+		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
+		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
+	};
+
+	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->hard_port_no])) {
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
+ *	oldpiix_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	unsigned int idetm_port= ap->hard_port_no ? 0x42 : 0x40;
+	u16 idetm_data;
+	int control = 0;
+	
+	/*
+	 *	See Intel Document 298600-004 for the timing programing rules
+	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
+	 *	timing port at 0x44.
+	 */
+
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	if (pio > 2)
+		control |= 1;	/* TIME1 enable */
+	if (pio > 2)	/* PIO 3/4 require IORDY */
+		control |= 2;	/* IE enable */
+	/* FIXME: Check for PIO2 if the required timing needs IORDY
+	   We should push this up into libata and have a requires_iordy() */
+
+	/* Intel specifies that the PPE functionality is for disk only */	   
+	if (adev->class == ATA_DEV_ATA)
+		control |= 4;	/* PPE enable */
+		
+	pci_read_config_word(dev, idetm_port, &idetm_data);
+
+	/* Enable PPE, IE and TIME as appropriate. Clear the other
+	   drive timing bits */
+	if(adev->devno == 0) {
+		idetm_data &= 0xCCE0;
+		idetm_data |= control;
+	} else {
+		idetm_data &= 0xCC0E;
+		idetm_data |= (control << 4);
+	}
+	idetm_data |= (timings[pio][0] << 12) |
+			(timings[pio][1] << 8);
+	pci_write_config_word(dev, idetm_port, idetm_data);
+
+	/* Track which port is configured */
+	ap->private_data = adev;
+}
+
+/**
+ *	oldpiix_set_dmamode - Initialize host controller PATA DMA timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: Device to program
+ *	@isich: True if the device is an ICH and has IOCFG registers
+ *
+ *	Set MWDMA mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void oldpiix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
+	u8 idetm_port		= ap->hard_port_no ? 0x42 : 0x40;
+	u16 idetm_data;
+	
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	/*
+	 * MWDMA is driven by the PIO timings. We must also enable
+	 * IORDY unconditionally along with TIME1. PPE has already
+	 * been set when the PIO timing was set.
+	 */
+
+	unsigned int mwdma	= adev->dma_mode - XFER_MW_DMA_0;
+	unsigned int control;
+	const unsigned int needed_pio[3] = {
+		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
+	};
+	int pio = needed_pio[mwdma] - XFER_PIO_0;
+
+	pci_read_config_word(dev, idetm_port, &idetm_data);
+	
+
+	control = 3;	/* IORDY|TIME0 */
+	/* Intel specifies that the PPE functionality is for disk only */	   
+	if (adev->class == ATA_DEV_ATA)
+		control |= 4;	/* PPE enable */
+	
+	/* If the drive MWDMA is faster than it can do PIO then
+	   we must force PIO into PIO0 */
+	   
+	if (adev->pio_mode < needed_pio[mwdma])
+		/* Enable DMA timing only */
+		control |= 8;	/* PIO cycles in PIO0 */
+
+	/* Mask out the relevant control and timing bits we will load. Also
+	   clear the other drive TIME register as a precaution */
+	if(adev->devno == 0) {
+		idetm_data &= 0xCCE0;	
+		idetm_data |= control;
+	} else {
+		idetm_data &= 0xCC0E;
+		idetm_data |= (control << 4);
+	}
+	idetm_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
+	pci_write_config_word(dev, idetm_port, idetm_data);
+
+	/* Track which port is configured */
+	ap->private_data = adev;
+}
+
+/**
+ *	oldpiix_qc_issue_prot	-	command issue
+ *	@qc: command pending
+ *
+ *	Called when the libata layer is about to issue a command. We wrap
+ *	this interface so that we can load the correct ATA timings if
+ *	neccessary. Our logic also clears TIME0/TIME1 for the other device so
+ *	that, even if we get this wrong, cycles to the other device will
+ *	be made PIO0.
+ */
+
+static int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *adev = qc->dev;
+	
+	if(adev != ap->private_data) {
+		if(adev->dma_mode)
+			oldpiix_set_dmamode(ap, adev);
+		else
+			oldpiix_set_dmamode(ap, adev);
+	}
+	return ata_qc_issue_prot(qc);
+}
+
+
+static struct scsi_host_template oldpiix_sht = {
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
+static const struct ata_port_operations oldpiix_pata_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= oldpiix_set_piomode,
+	.set_dmamode		= oldpiix_set_dmamode,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= oldpiix_pata_phy_reset,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= oldpiix_qc_issue_prot,
+
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+
+/**
+ *	oldpiix_init_one - Register PIIX ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in oldpiix_pci_tbl matching with @pdev
+ *
+ *	Called from kernel PCI layer.  We probe for combined mode (sigh),
+ *	and then hand over control to libata, for it to do the rest.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	static struct ata_port_info info = {
+		.sht		= &oldpiix_sht,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma1-2 */
+		.port_ops	= &oldpiix_pata_ops,
+	};
+	static struct ata_port_info *port_info[2] = { &info, &info };
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
+
+	return ata_pci_init_one(pdev, port_info, 2);
+}
+
+static const struct pci_device_id oldpiix_pci_tbl[] = {
+	{ 0x8086, 0x1230, PCI_ANY_ID, PCI_ANY_ID, },
+	{ }	/* terminate list */
+};
+
+static struct pci_driver oldpiix_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= oldpiix_pci_tbl,
+	.probe			= oldpiix_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static int __init oldpiix_init(void)
+{
+	int rc;
+
+	DPRINTK("pci_module_init\n");
+	rc = pci_module_init(&oldpiix_pci_driver);
+	if (rc)
+		return rc;
+
+	DPRINTK("done\n");
+	return 0;
+}
+
+static void __exit oldpiix_exit(void)
+{
+	pci_unregister_driver(&oldpiix_pci_driver);
+}
+
+
+module_init(oldpiix_init);
+module_exit(oldpiix_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("SCSI low-level driver for early PIIX series controllers");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, oldpiix_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+

