From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset
Date: Wed, 14 Nov 2007 00:57:18 +0000
Message-ID: <20071114005718.7b151b37@the-village.bc.nu>
References: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>
	<20071103162203.5388a37f@the-village.bc.nu>
	<47323E13.3030205@rtr.ca>
	<20071107232132.238fdf04@the-village.bc.nu>
	<47324A16.5010205@rtr.ca>
	<4738B364.5030806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51046 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759510AbXKNA6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 19:58:12 -0500
In-Reply-To: <4738B364.5030806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, greg.freemyer@gmail.com, linux-ide@vger.kernel.org

First guess

/*
 * pata_ninja32.c 	- Ninja32 PATA for new ATA layer
 *			  (C) 2007 Red Hat Inc
 *			  Alan Cox <alan@redhat.com>
 *
 * Note: The controller like many controllers has shared timings for
 * PIO and DMA. We thus flip to the DMA timings in dma_start and flip back
 * in the dma_stop function. Thus we actually don't need a set_dmamode
 * method as the PIO method is always called and will set the right PIO
 * timing parameters.
 *
 * The Ninja32 Cardbus is not a generic SFF controller. Instead it is
 * laid out as follows off BAR 0. This is based upon Mark Lord's delkin
 * driver and the extensive analysis done by the BSD developers, notably
 * ITOH Yasufumi.
 *
 *	Base + 0x00 IRQ Status
 *	Base + 0x01 IRQ control
 *	Base + 0x02 Chipset control
 *	Base + 0x04 VDMA and reset control + wait bits
 *	Base + 0x08 BMIMBA
 *	Base + 0x0C DMA Length
 *	Base + 0x10 Taskfile
 *	Base + 0x18 BMDMA Status ?
 *	Base + 0x1C
 *	Base + 0x1D Bus master control
 *		bit 0 = enable
 *		bit 1 = 0 write/1 read
 *		bit 2 = 1 sgtable
 *		bit 3 = go
 *		bit 4-6 wait bits
 *		bit 7 = done
 *	Base + 0x1E AltStatus
 *	Base + 0x1F timing register
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <scsi/scsi_host.h>
#include <linux/libata.h>

#define DRV_NAME "pata_ninja32"
#define DRV_VERSION "0.0.1"

/**
 *	ninja32_configure_piomode	-	set chip PIO timing
 *	@ap: ATA interface
 *	@adev: ATA device
 *	@pio: PIO mode
 *
 *	Called to do the PIO mode setup. Our timing registers are shared
 *	so a configure_dmamode call will undo any work we do here and vice
 *	versa
 */

static void ninja32_configure_piomode(struct ata_port *ap, struct ata_device *adev, int pio)
{
	static u16 pio_timing[5] = {
		0xd6, 0x85, 0x44, 0x33, 0x13
	};
	iowrite8(pio_timing[pio], ap->ioaddr.bmdma_addr + 0x1f);
}

/**
 *	ninja32_set_piomode	-	set initial PIO mode data
 *	@ap: ATA interface
 *	@adev: ATA device
 *
 *	Called to do the PIO mode setup. Our timing registers are shared
 *	but we want to set the PIO timing by default.
 */

static void ninja32_set_piomode(struct ata_port *ap, struct ata_device *adev)
{
	ninja32_configure_piomode(ap, adev, adev->pio_mode - XFER_PIO_0);
}

static struct scsi_host_template ninja32_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= LIBATA_MAX_PRD,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.dma_boundary		= ATA_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.slave_destroy		= ata_scsi_slave_destroy,
	.bios_param		= ata_std_bios_param,
};

static struct ata_port_operations ninja32_port_ops = {
	.set_piomode	= ninja32_set_piomode,
	.mode_filter	= ata_pci_default_filter,

	.tf_load	= ata_tf_load,
	.tf_read	= ata_tf_read,
	.check_status 	= ata_check_status,
	.exec_command	= ata_exec_command,
	.dev_select 	= ata_std_dev_select,

	.freeze		= ata_bmdma_freeze,
	.thaw		= ata_bmdma_thaw,
	.error_handler	= ata_bmdma_error_handler,
	.post_internal_cmd = ata_bmdma_post_internal_cmd,
	.cable_detect	= ata_cable_40wire,

	.bmdma_setup 	= ata_bmdma_setup,
	.bmdma_start 	= ata_bmdma_start,
	.bmdma_stop	= ata_bmdma_stop,
	.bmdma_status 	= ata_bmdma_status,

	.qc_prep 	= ata_qc_prep,
	.qc_issue	= ata_qc_issue_prot,

	.data_xfer	= ata_data_xfer,

	.irq_handler	= ata_interrupt,
	.irq_clear	= ata_bmdma_irq_clear,
	.irq_on		= ata_irq_on,

	.port_start	= ata_sff_port_start,
};

static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
{
	struct ata_host *host;
	struct ata_port *ap;
	void __iomem *base;
	int rc;
	
	host = ata_host_alloc(&dev->dev, 1);
	if (!host)
		return -ENOMEM;
	ap = host->ports[0];

	/* Set up the PCI device */
	rc = pcim_enable_device(dev);
	if (rc)
		return rc;
	rc = pcim_iomap_regions(dev, 1 << 0, DRV_NAME);
	if (rc == -EBUSY)
		pcim_pin_device(dev);
	if (rc)
		return rc;

	host->iomap = pcim_iomap_table(dev);
	rc = pci_set_dma_mask(dev, ATA_DMA_MASK);
	if (rc)
		return rc;
	rc = pci_set_consistent_dma_mask(dev, ATA_DMA_MASK);
	if (rc)
		return rc;
	pci_set_master(dev);
		
	/* Set up the register mappings */
	base = host->iomap[0];
	if (!base)
		return -ENOMEM;
	ap->ops = &ninja32_port_ops;
	ap->pio_mask = 0x1F;
	ap->flags |= ATA_FLAG_SLAVE_POSS;
	
	ap->ioaddr.cmd_addr = base + 0x10;
	ap->ioaddr.ctl_addr = base + 0x1E;
	ap->ioaddr.altstatus_addr = base + 0x1E;
	ap->ioaddr.bmdma_addr = base;
	ata_std_ports(&ap->ioaddr);
	
	return ata_host_activate(host, dev->irq, ata_interrupt, IRQF_SHARED, &ninja32_sht);
}

static const struct pci_device_id ninja32[] = {
	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{ },
};

static struct pci_driver ninja32_pci_driver = {
	.name 		= DRV_NAME,
	.id_table	= ninja32,
	.probe 		= ninja32_init_one,
	.remove		= ata_pci_remove_one
};

static int __init ninja32_init(void)
{
	return pci_register_driver(&ninja32_pci_driver);
}

static void __exit ninja32_exit(void)
{
	pci_unregister_driver(&ninja32_pci_driver);
}

MODULE_AUTHOR("Alan Cox");
MODULE_DESCRIPTION("low-level driver for Ninja32 ATA");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, ninja32);
MODULE_VERSION(DRV_VERSION);

module_init(ninja32_init);
module_exit(ninja32_exit);
