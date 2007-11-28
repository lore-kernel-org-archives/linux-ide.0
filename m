From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Current sata_inic attempts (was pata_pcmcia: Minor cleanups and
 support for dual channel cards)
Date: Wed, 28 Nov 2007 09:39:52 +0000
Message-ID: <20071128093952.77652450@the-village.bc.nu>
References: <20071119144307.7b67f09e@the-village.bc.nu>
	<474774A6.5020906@garzik.org>
	<20071126154047.63021652@the-village.bc.nu>
	<474CCAC5.7030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48355 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757623AbXK1JnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 04:43:23 -0500
In-Reply-To: <474CCAC5.7030407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org

On Wed, 28 Nov 2007 10:56:21 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> > setup and it821x fixes can go to mainstream for 2.6.25 I think - no bad
> > reports yet.
> > 
> > BTW so we don't duplicate work right now I'm working on a full DMA engine
> > based driver for the INIC162x. Dunno if I'll ever get it to work as the
> > docs are a bit minimal but we shall see.
> 
> Great, are you gonna use the ADMA interface?

This is the plan. I have the driver trying to do this but right now I get
a single unsolicited CDB back when I reset the bus and my identify
command times out.

Alan

--
/*
 *  inic.c - Intio INIC IDMA SATA support
 *
 *  Copyright 2007 Red Hat, Inc.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  Theory of operation:
 *	The Initio controllers expose the taskfile registers for limited
 *	use and a full DMA engine which can do queuing and the like.
 *
 *	Commands are issued using the qc->tag entry as the command slot.
 *	For each command you fill in a descriptor holding taskfile, hob
 *	taskfile and other bits, plus if need be a DMA table. After
 *	filling in the blocks the command is queued to the fifo and
 *	eventually it hands it back on an IRQ in the reply fifo. At that
 *	point the completion taskfile status etc is in the descriptor.
 *
 *	The DMA controller can be set to either freeze on errors or to
 *	continue.
 *
 *  Notes:
 *	Post reset we seem to get a 'free' command response with tag 0.
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/dma-mapping.h>
#include <linux/device.h>
#include <linux/dmi.h>
#include <scsi/scsi_host.h>
#include <scsi/scsi_cmnd.h>
#include <linux/libata.h>

#define DRV_NAME	"sata_inic"
#define DRV_VERSION	"0.01"

enum {
	INIC_MAX_PORTS		= 16,
	INIC_DMA_BOUNDARY	= 0xffffffff,
	INIC_USE_CLUSTERING	= 1,
	INIC_MAX_CMDS		= 32,
	INIC_CMDPTR_SZ		= 4 * INIC_MAX_CMDS,
	INIC_MAX_SG		= 128,
	INIC_CMD_SZ		= 32,
	INIC_CMD_SLOT_SZ	= INIC_MAX_CMDS * INIC_CMD_SZ,
	
	INIC_ATAPI_LEN		= 16,
	INIC_ATAPI_SZ		= INIC_MAX_CMDS * INIC_CMD_SZ,
	
	INIC_PRD_ENTRY_LEN	= 8,
	INIC_PRD_LEN		= INIC_PRD_ENTRY_LEN * INIC_MAX_SG,
	INIC_PRD_SZ		= INIC_PRD_LEN * INIC_CMD_SZ,
	
	PORT_SIZE		= 0x40,
	
	NR_PORTS		= 2,
	
	MMIO_BAR		= 5,
	CARDBUS_MMIO_BAR	= 1,

	/* Register Offsets for each port */
	TASKFILE		= 0x00,
	ACTRL			= 0x08,
	INTSTAT			= 0x09,
		CHINTP		= 0x80,
		CHQINT		= 0x20,
		CHUIRQ		= 0x10,
		FTLINT		= 0x08,
		CHCINT		= 0x04,
		CHON		= 0x02,
		CHOFF		= 0x01,
	MINTSTAT		= 0x0A,
	IDMCTL			= 0x14,
		CTL_MMSTR	= 0x8000,
		CTL_MSLVSEL	= 0x6000,
		CTL_MSLV	= 0x1000,
		CTL_HWFRZEN	= 0x0200,
		CTL_AIEN	= 0x0100,
		CTL_AGO		= 0x0080,
		CTL_APSE	= 0x0040,
		CTL_ARSTADM	= 0x0020,
		CTL_AABRT	= 0x0010,
		CTL_AAUTEN	= 0x0008,
		CTL_ARSTA	= 0x0004,
		CTL_UNFREZ	= 0x0002,
		CTL_FREZEN	= 0x0001,
	IDMSTAT			= 0x16,	
	CPBLAR			= 0x18,	
	PTQFIFO			= 0x1C,
	PTQCNT			= 0x1D,
	RPQFIFO			= 0x1E,
	RPQCNT			= 0x1F,
	SSTATUS			= 0x20,
	SACTIVE			= 0x2C,

	/* Global register offsets from MMIO BAR */
	GCTRL			= 0x7C,
		GCTRL_PAGE1	= 0x8000,
		GCTRL_SOFTRST	= 0x2000,
		GCTRL_PWRDWN	= 0x1000,
		GCTRL_INTDIS	= 0x0100,
		GCTRL_LEDEN	= 0x0008,
		GCTRL_MIREN	= 0x0004,
		GCTRL_EEPRG	= 0x0002,
	GSTAT			= 0x7E,
	GINTS			= 0xBC,
	GIMSK			= 0xBE,
	
	/* PRD Flags */
	PRD_END			= 0x80000000,
	PRD_IOM			= 0x40000000,
	PRD_DIRO		= 0x20000000,
	PRD_ORD			= 0x10000000,
	PRD_DINT		= 0x08000000,
	PRD_PKT			= 0x04000000,
	PRD_IGEX		= 0x02000000,

	/* CPB flags */
	CPB_DEVDIR		= 0x10,
	CPB_CIEN		= 0x08,
	CPB_CDAT		= 0x04,
	CPB_CQUE		= 0x02,
	CPB_CVLD		= 0x01
};

struct inic_port_priv {
	struct ata_link		*active_link;
	u32			*cmd_ptr;
	dma_addr_t		cmd_ptr_dma;
	void			*cmd_slot;
	dma_addr_t		cmd_slot_dma;
	void			*prd_buf;
	dma_addr_t		prd_buf_dma;
	void			*atapi_buf;
	dma_addr_t		atapi_buf_dma;
};

static int inic_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val);
static int inic_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val);
static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
static unsigned int inic_qc_issue(struct ata_queued_cmd *qc);
static void inic_irq_clear(struct ata_port *ap);
static int inic_port_start(struct ata_port *ap);
static void inic_port_stop(struct ata_port *ap);
static void inic_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
static void inic_qc_prep(struct ata_queued_cmd *qc);
static u8 inic_check_status(struct ata_port *ap);
static void inic_freeze(struct ata_port *ap);
static void inic_thaw(struct ata_port *ap);
static void inic_error_handler(struct ata_port *ap);
static void inic_post_internal_cmd(struct ata_queued_cmd *qc);
static int inic_port_resume(struct ata_port *ap);
static unsigned int inic_fill_ata_sg(struct ata_queued_cmd *qc, void *cmd_tbl);
#ifdef CONFIG_PM
static int inic_port_suspend(struct ata_port *ap, pm_message_t mesg);
static int inic_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
static int inic_pci_device_resume(struct pci_dev *pdev);
#endif

static struct scsi_host_template inic_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.change_queue_depth	= ata_scsi_change_queue_depth,
	.can_queue		= INIC_MAX_CMDS - 1,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= INIC_MAX_SG,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= 1,
	.proc_name		= DRV_NAME,
	.dma_boundary		= INIC_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.slave_destroy		= ata_scsi_slave_destroy,
	.bios_param		= ata_std_bios_param,
};

static const struct ata_port_operations inic_ops = {
	.check_status		= inic_check_status,
	.check_altstatus	= inic_check_status,
	.dev_select		= ata_noop_dev_select,

	.tf_read		= inic_tf_read,

	.qc_prep		= inic_qc_prep,
	.qc_issue		= inic_qc_issue,

	.irq_clear		= inic_irq_clear,

	.scr_read		= inic_scr_read,
	.scr_write		= inic_scr_write,

	.freeze			= inic_freeze,
	.thaw			= inic_thaw,

	.error_handler		= inic_error_handler,
	.post_internal_cmd	= inic_post_internal_cmd,

#ifdef CONFIG_PM
	.port_suspend		= inic_port_suspend,
	.port_resume		= inic_port_resume,
#endif

	.port_start		= inic_port_start,
	.port_stop		= inic_port_stop,
};

#define INIC_HFLAGS(flags)	.private_data	= (void *)(flags)

static const struct ata_port_info inic_port_info[] = {
	/* board_inic */
	{
		.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &inic_ops,
	},
};

static const struct pci_device_id inic_pci_tbl[] = {
	{ PCI_VDEVICE(INIT, 0x1622), },
	{ PCI_VDEVICE(INIT, 0x1623), },
	{ }	/* terminate list */
};


static struct pci_driver inic_pci_driver = {
	.name			= DRV_NAME,
	.id_table		= inic_pci_tbl,
	.probe			= inic_init_one,
	.remove			= ata_pci_remove_one,
#ifdef CONFIG_PM
	.suspend		= inic_pci_device_suspend,
	.resume			= inic_pci_device_resume,
#endif
};


/*
 *	SATA Phy functions
 */

static int inic_scr_offset(struct ata_port *ap, unsigned int sc_reg)
{
	static const int offset[] = {
		[SCR_STATUS]	= 0,
		[SCR_ERROR]	= 4,
		[SCR_CONTROL]	= 8,
	};
	if (sc_reg < ARRAY_SIZE(offset))
		return offset[sc_reg];
	return -1;
}

static int inic_scr_read(struct ata_port *ap, unsigned int sc_reg, u32 *val)
{
	void __iomem *scr_addr = ap->ioaddr.scr_addr;
	int offset = inic_scr_offset(ap, sc_reg);

	if (offset != -1) {
		*val = ioread32(scr_addr + offset);
		if (sc_reg == SCR_ERROR)
			*val &= ~SERR_PHYRDY_CHG;
		return 0;
	}
	return -EINVAL;
}

static int inic_scr_write(struct ata_port *ap, unsigned int sc_reg, u32 val)
{
	int offset = inic_scr_offset(ap, sc_reg);
	void __iomem *scr_addr = ap->ioaddr.scr_addr;

	if (offset != -1) {
		iowrite32(val, scr_addr + offset);
		return 0;
	}
	return -EINVAL;
}

static void __iomem *inic_mmio(struct ata_port *ap)
{
	return ap->ioaddr.bmdma_addr;
}
	
static void __iomem *inic_host_mmio(struct ata_host *host)
{
	struct ata_port *ap = host->ports[0];
	return ap->ioaddr.bmdma_addr;
}
	
/**
 *	inic_cpb_addr		-	CPB Address
 *	@ap: Port
 *	@tag: CPB number (0-31)
 *
 *	Return the mmio address of the control block for this
 *	command
 */

static void *inic_cpb_addr(struct ata_port *ap, int tag)
{
	struct inic_port_priv *ppriv = ap->private_data;
	return ppriv->cmd_slot + INIC_CMD_SZ * tag;
}

/**
 *	inic_prd_addr		-	PRD Address
 *	@ap: Port
 *	@tag: CPB number (0-31)
 *
 *	Return the mmio address of the PRD block for this
 *	command
 */

static void *inic_prd_addr(struct ata_port *ap, int tag)
{
	struct inic_port_priv *ppriv = ap->private_data;
	return ppriv->prd_buf + INIC_PRD_LEN * tag;
}

/**
 *	inic_atapi_addr		-	ATAPI Buffer Address
 *	@ap: Port
 *	@tag: CPB number (0-31)
 *
 *	Return the mmio address of the ATAPI buffer for this
 *	command
 */

static void *inic_atapi_addr(struct ata_port *ap, int tag)
{
	struct inic_port_priv *ppriv = ap->private_data;
	return ppriv->atapi_buf + INIC_ATAPI_LEN * tag;
}

/**
 *	inic_prd_bus_addr	-	PRD Address
 *	@ap: Port
 *	@tag: CPB number (0-31)
 *
 *	Return the bus address of the PRD block for this
 *	command
 */

static dma_addr_t inic_prd_bus_addr(struct ata_port *ap, int tag)
{
	struct inic_port_priv *ppriv = ap->private_data;
	return ppriv->prd_buf_dma + INIC_PRD_LEN * tag;
}

/**
 *	inic_atapi_bus_addr	-	ATAPI Buffer Address
 *	@ap: Port
 *	@tag: CPB number (0-31)
 *
 *	Return the bus address of the ATAPI buffer for this
 *	command
 */

static dma_addr_t inic_atapi_bus_addr(struct ata_port *ap, int tag)
{
	struct inic_port_priv *ppriv = ap->private_data;
	return ppriv->atapi_buf_dma + INIC_ATAPI_LEN * tag;
}

/**
 *	inic_post_cpb		-	post command
 *	@ap: Port
 *	@cpb CPB number
 *
 *	Post a completely filled CPB to the card and begin
 *	executing the command itself. 
 */

static void inic_post_cpb(struct ata_port *ap, int tag)
{
	void __iomem *mmio = inic_mmio(ap);
	u16 r;
	iowrite8(tag, mmio + PTQFIFO);
	ioread16(mmio + IDMCTL);	/* Flush */
	
	printk("Queued slot %d\n", tag);
	printk("Qlen %d\n", ioread8(mmio + PTQCNT));
	
	r = ioread16(mmio + IDMCTL);
	printk("IDMCTL = %04x ", r);
	r = ioread16(mmio + IDMSTAT);
	printk("IDMSTAT = %04x\n", r);
	r = ioread8(mmio + INTSTAT);
	printk("INTSTAT = %02X\n", r);
	
	printk("Queued\n");
}

/**
 *	inic_completed_tag	-	Get completed CPB
 *	@ap: Port
 *
 *	Return the number of the next completed CPB that is present
 *	in the command FIFO. Each completed CPB handed back by the firmware
 *	has been updated ready for us to use
 */

static int inic_next_cpb(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	u8 cpb = ioread8(mmio + RPQFIFO);
	if (cpb == 0xFF)
		return -1;
	cpb &= 0x1F;
	printk("Completed slot %d\n", cpb);
	return cpb;
}	

static void inic_power_up(struct ata_port *ap)
{
	void __iomem *mmio = inic_host_mmio(ap->host);
	u16 gctrl;
	
	/* Phy Power */
	gctrl = ioread16(mmio + GCTRL);
	gctrl &= ~GCTRL_PWRDWN;
	iowrite16(gctrl, mmio + GCTRL);
		
	iowrite8(0, mmio + MINTSTAT);
	iowrite16(0, mmio + GIMSK); 
	
}

#ifdef CONFIG_PM
static void inic_power_down(struct ata_port *ap)
{
	void __iomem *mmio = inic_host_mmio(ap->host);
	u16 gctrl;
	
	/* Phy Power */
	gctrl = ioread16(mmio + GCTRL);
	gctrl |= GCTRL_PWRDWN;
	iowrite16(gctrl, mmio + GCTRL);
	
}
#endif

/**
 *	inic_reset_port		-	reset DMA engine
 *	@ap: port
 *
 *	Reset the DMA engine and configure it to freeze automatically
 *	when an error occurs.
 */
 
static int inic_reset_port(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	struct inic_port_priv *pp = ap->private_data;
	u16 idmctl;

	printk("Reset port.\n");
	printk("Reset - qlen %d\n", ioread8(mmio + PTQCNT));
	printk("Reset - rqlen %d\n", ioread8(mmio + RPQCNT));
		
	inic_power_up(ap);
	
	idmctl = ioread16(mmio + IDMCTL);
	printk("Reset - idmctl %04x\n", idmctl);
	
	/* Reset the DMA engine */
	idmctl |= CTL_ARSTADM;
	iowrite16(idmctl, mmio + IDMCTL);
	ioread16(mmio + IDMCTL);
	udelay(1);
	/* Enable DMA engine, set it to freeze
	   automatically on errors */
	idmctl &= ~(CTL_APSE|CTL_ARSTADM);
	idmctl |= CTL_AIEN|/*CTL_HWFRZEN|*/CTL_AAUTEN/*|CTL_FREZEN*/;
	iowrite16(idmctl, mmio + IDMCTL);
	if (pp != NULL)
		iowrite32(pp->cmd_ptr_dma, mmio + CPBLAR);
	else
		printk("TOO EARLY\n");
	idmctl |= CTL_AGO;
	iowrite8(0xFF, mmio + INTSTAT);
	
	/* And with the IRQ cleared, now unmask */
	idmctl &= ~CTL_AIEN;
	iowrite16(idmctl, mmio + IDMCTL);
	
	/*FIXME: Shouldnt be needed ? */
	iowrite8(0x01, mmio + 0x0B);
	printk("Reset complete - idmctl %04x\n", idmctl);
	
	mdelay(10);

	return 0;
}

/**
 *	inic_reset_controller	-	initial reset
 *	@host: controller to reset
 *
 *	Perform a chip level reset, and ensure the register bank
 *	visible is bank 0 (operations) not bank 1 (debug). Return with
 *	chip PCI interrupts masked off.
 */

static void inic_reset_controller(struct ata_host *host)
{
	void __iomem *mmio = inic_host_mmio(host);
	u16 r;
	
	r = ioread16(mmio + GCTRL);
	r &= GCTRL_PAGE1|GCTRL_EEPRG|GCTRL_INTDIS;
	r |= GCTRL_SOFTRST/*FIXME|GCTRL_INTDIS*/;
	iowrite16(r, mmio + GCTRL);
	ioread16(mmio + GCTRL);
	udelay(10);		/* Wait for completion */
	r = ioread16(mmio + GCTRL);
	if (r & GCTRL_SOFTRST)
		printk("RST STUCK ??\n");
}


static void inic_port_init(struct pci_dev *pdev, struct ata_port *ap)
{
	/* make sure port is not active */
	inic_reset_port(ap);	/* IRQ is now locked off */
}

static void inic_init_controller(struct ata_host *host)
{
	struct pci_dev *pdev = to_pci_dev(host->dev);
	int i;

	for (i = 0; i < host->n_ports; i++) {
		struct ata_port *ap = host->ports[i];
		if (ata_port_is_dummy(ap))
			continue;
		inic_port_init(pdev, ap);
	}
}

/**
 *	inic_dev_classify	-	classify devices
 *	@ap: port
 *
 *	After a reset use the shadow taskfile registers to classify
 *	the device on the link.
 */

static unsigned int inic_dev_classify(struct ata_port *ap)
{
	struct ata_taskfile tf;
	inic_tf_read(ap, &tf);
	return ata_dev_classify(&tf);
}

/**
 *	inic_tf_read		-	read taskfile
 *	@ap: port
 *	@tf: taskfile to fill
 *
 *	Read the taskfile from the port by using the shadow taskfile
 *	registers. When the queueing engine is used the taskfile basic
 *	information (error/status) is provided by the queueing engine
 *	but not the rest.
 */

static void inic_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
{
	void __iomem *mmio = inic_mmio(ap);
	
	tf->command = ioread8(mmio + 7);
	tf->feature = ioread8(mmio + 1);
	tf->nsect = ioread8(mmio + 2);
	tf->lbal = ioread8(mmio + 3);
	tf->lbam = ioread8(mmio + 4);
	tf->lbah = ioread8(mmio + 5);
	tf->device = ioread8(mmio + 6);
	
	if (tf->flags & ATA_TFLAG_LBA48) {
		iowrite8(tf->ctl | ATA_HOB, mmio + 8);
		tf->hob_feature = ioread8(mmio + 1);
		tf->hob_nsect = ioread8(mmio + 2);
		tf->hob_lbal = ioread8(mmio + 3);
		tf->hob_lbam = ioread8(mmio + 4);
		tf->hob_lbah = ioread8(mmio+ 5);
		iowrite8(tf->ctl, mmio + 8);
		ap->last_ctl = tf->ctl;
	}
}

/**
 *	inic_hardreset		-	Hard reset handler
 *	@link: link to reset
 *	@class: array of detected types
 *	@deadline: timeout
 *
 *	Reset the INIC162x controller. Clear any pending interrupts
 *	and classify the device via the taskfile.
 */

static int inic_hardreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline)
{
	struct ata_port *ap = link->ap;
	void __iomem *mmio = inic_mmio(ap);
	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
	int rc;
	u16 idmctl;
	
	idmctl = ioread16(mmio + IDMCTL);
	/* IRQ disable, reset enable */
	idmctl |= CTL_ARSTA | CTL_AIEN;
	iowrite16(idmctl, mmio + IDMCTL);
	ioread16(mmio + IDMCTL);
	mdelay(1);
	/* Deassert reset */
	idmctl &= ~CTL_ARSTA;
	iowrite16(idmctl, mmio + IDMCTL);
	/* Clear interrupts pending and then unmask */
	idmctl &= ~CTL_AIEN;
	iowrite8(0xFF, mmio + INTSTAT);
	iowrite16(idmctl, mmio + IDMCTL);
	
	rc = sata_link_resume(link, timing, deadline);
	if (rc) {
		ata_link_printk(link, KERN_WARNING, "failed to resume "
				"link after reset (errno=%d)\n", rc);
		return rc;
	}

	/* wait a while before checking status */
	ata_wait_after_reset(ap, deadline);
	rc = ata_wait_ready(ap, deadline);
	/* link occupied, -ENODEV too is an error */
	if (rc) {
		ata_link_printk(link, KERN_WARNING, "device not ready "
				"after hardreset (errno=%d)\n", rc);
		return rc;
	}

	if (rc == 0 && ata_link_online(link))
		*class = inic_dev_classify(ap);
	if (rc != -EAGAIN && *class == ATA_DEV_UNKNOWN)
		*class = ATA_DEV_NONE;

	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
	return rc;
}

static void inic_postreset(struct ata_link *link, unsigned int *class)
{
	void __iomem *mmio = inic_host_mmio(link->ap->host);
	u16 gctrl;
	
	/* Unmask IRQ - possible not right spot for it */
	gctrl = ioread16(mmio + GCTRL);
	gctrl &= ~GCTRL_INTDIS;
	iowrite16(gctrl, mmio + GCTRL);
	ata_std_postreset(link, class);
}

/**
 *	inic_check_status	-	Status shadow register
 *	@ap: port
 *
 *	Returns the status shadow register. The DMA queueing engine
 *	returns the per command status in the CPB which is not
 *	accessed by this call.
 */

static u8 inic_check_status(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	return ioread8(mmio + 7);
}

/**
 *	inic_fill_ata_sg	-	Build an ATA PRD
 *	@qc: Command block
 *	@prd: PRD to use
 *
 *	Turn the scatter gather list into a PRD table for the INIC
 *	DMA engine. Much like the standard one except that we seem to have
 *	to work in quad words. FIXME: Need to sort out pad buffer
 */

static unsigned int inic_fill_ata_sg(struct ata_queued_cmd *qc, void *prd)
{
	struct scatterlist *sg;
	u32 *inic_sg = prd;
	unsigned int n_sg = 0;
	u32 flag = 0;

	if (qc->tf.flags & ATA_TFLAG_WRITE)
		flag = PRD_DIRO;	/* Output */
	if (qc->tf.protocol == ATA_PROT_DMA)
		flag |= PRD_ORD;	/* Use UDMA */

	/*
	 * Next, the S/G list. INIC supports sg lists of 256K
	 * qword size per entry. FIXME we will need to pad out
	 * the last qword
	 */

	ata_for_each_sg(sg, qc) {
		dma_addr_t addr = sg_dma_address(sg);
		u32 sg_len = sg_dma_len(sg) >> 3;
		sg_len |= flag;
		*inic_sg++ = cpu_to_le32(addr);
		*inic_sg++ = cpu_to_le32(sg_len);
		n_sg++;
	}
	inic_sg[-1] |= cpu_to_le32(PRD_END);	/* End marker */

	return n_sg;
}

/**
 *	inic_fill_atapi_sg	-	Build an ATAPI PRD
 *	@qc: Command block
 *	@prd: PRD to use
 *
 *	Turn the scatter gather list into a PRD table. The ATAPI table on
 *	the INIC is similar to the ATA one but has a single transfer block
 *	at the start which is the CDB itself.
 */

static unsigned int inic_fill_atapi_sg(struct ata_queued_cmd *qc, void *prd)
{
	struct scatterlist *sg;
	u32 *inic_sg = prd;
	unsigned int n_sg = 0;
	u32 flag = PRD_IGEX;	/* Ignore extra bits for ATAPI */
	void *cdb;
	dma_addr_t cdb_bus;

	if (qc->tf.flags & ATA_TFLAG_WRITE)
		flag = PRD_DIRO;	/* Output */
	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
		flag |= PRD_ORD;	/* Use UDMA */

	/* We keep CDB buffers for mapping */
	cdb = inic_atapi_addr(qc->ap, qc->tag);
	memcpy(cdb, qc->cdb, qc->dev->cdb_len);
	cdb_bus = inic_atapi_bus_addr(qc->ap, qc->tag);
	
	*inic_sg++ = cpu_to_le32(cdb_bus);
	*inic_sg++ = cpu_to_le32(PRD_DIRO|PRD_DINT|PRD_PKT |
							 qc->dev->cdb_len);
	if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
		/*
		 * Next, the S/G list. INIC supports 64K byte size or 256K
		 * qword size per entry. FIXME we will need to pad out
		 * the last qword
		 */

		ata_for_each_sg(sg, qc) {
			dma_addr_t addr = sg_dma_address(sg);
			u32 sg_len = sg_dma_len(sg) >> 3;
			sg_len |= flag;
			*inic_sg++ = cpu_to_le32(addr);
			*inic_sg++ = cpu_to_le32(sg_len);
			n_sg++;
		}
	}
	inic_sg[-1] |= cpu_to_le32(PRD_END);	/* End marker */
	return n_sg;
}

static void inic_qc_prep(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;
	struct ata_taskfile *tf = &qc->tf;
	int is_atapi = is_atapi_taskfile(tf);
	u32 *cpb;
	u32 *prd = inic_prd_addr(ap, qc->tag);
	u32 r;
	int n_elem;
	u8 *p;
	
	cpb = inic_cpb_addr(ap, qc->tag);
	
	n_elem = 0;
	if (is_atapi)
		n_elem = inic_fill_atapi_sg(qc, prd);
	else if (qc->flags & ATA_QCFLAG_DMAMAP)
		n_elem = inic_fill_ata_sg(qc, prd);

	memset(cpb, 0, INIC_CMD_SZ);
	r = CPB_CVLD;
	if (!is_atapi)
		r |= CPB_CIEN;
	if (n_elem)
		r |= CPB_CDAT;
	if (qc->tf.protocol == ATA_PROT_NCQ)
		r |= CPB_CQUE;
	/* We need result TF if this flag is set or if an error
	   occurs. The freeze flag takes care of the error path
	   but we must avoid issuing any tf result command via
	   queuing */
	if (qc->flags & ATA_QCFLAG_RESULT_TF)
		r &= ~CPB_CQUE;
		
	cpb[0] = cpu_to_le32(r << 24);
	cpb[1] = cpu_to_le32(qc->nbytes);
	cpb[2] = cpu_to_le32(inic_prd_bus_addr(ap, qc->tag));
	cpb[4] = cpu_to_le32(tf->feature | tf->hob_feature << 8 |
				tf->device << 16 | 0 /*FIX*/ << 28);
	cpb[5] = cpu_to_le32(tf->nsect | tf->hob_nsect << 8 | 
				tf->lbal << 16 | tf->hob_lbal << 24);
	cpb[6] = cpu_to_le32(tf->lbam | tf->hob_lbam << 8 | 
				tf->lbah << 16 | tf->hob_lbah << 24);
	cpb[7] = cpu_to_le32(tf->command);

	p = inic_cpb_addr(ap, qc->tag);
	for (r = 0; r < 32; r++) {
		printk("%02X ", p[r]);
		if (r % 8 == 7)
			printk("\n");
	}
}


static void inic_port_intr(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	struct ata_eh_info *ehi = &ap->link.eh_info;
	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
	u8 status;
	u32 serror;
	u8 qc_active;
	int rc = 0, known_irq = 0;

	status = ioread8(mmio + INTSTAT);
	iowrite8(status, mmio + INTSTAT);
	
	printk("Port intr %02X\n", status);
	
	/* Fatal IRQ or Channel unsolicited irq */
	if (unlikely(status & (FTLINT|CHUIRQ))) {
		/* record irq stat */
		ata_ehi_clear_desc(ehi);
		ata_ehi_push_desc(ehi, "irq_stat 0x%08x", status);

		/* Clear SERROR */
		inic_scr_read(ap, SCR_ERROR, &serror);
		inic_scr_write(ap, SCR_ERROR, serror);
		ehi->serror |= serror;
		
		if (status & FTLINT)
			ehi->serror |= SERR_INTERNAL;
		known_irq = 1;
	}
	if (unlikely(status & (CHON|CHOFF))) {
		ata_ehi_hotplugged(ehi);
		ata_ehi_push_desc(ehi, "%s",
			status & CHON ?
			"drive connected" : "drive removed");
		known_irq = 1;
	}	
	if (status & CHCINT) {
		do {
			/* pp->active_link is valid iff any command is in flight */
			qc_active = inic_next_cpb(ap);
			/* FIXME: need to pass a completion function to pull
			   the error/status/flag bits and set eh up */
			if (qc_active != 0xFF)
				ata_qc_complete_multiple(ap, qc_active, NULL);
			/* What about error handling ?? */
		} while(qc_active != 0xFF);
		known_irq = 1;
	}
	if (! resetting)
		return;
	if (rc > 0)
		return;
	if (rc < 0) {
		ehi->err_mask |= AC_ERR_HSM;
		ehi->action |= ATA_EH_SOFTRESET;
		ata_port_freeze(ap);
		return;
	}

	/* hmmm... a spurious interrupt */

	/* if !NCQ, ignore.  No modern ATA device has broken HSM
	 * implementation for non-NCQ commands.
	 */
	if (!ap->link.sactive)
		return;

	if (!known_irq)
		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
				status, ap->link.active_tag, ap->link.sactive);
}

static void inic_irq_clear(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	iowrite8(0xFF, mmio + INTSTAT);
}

static irqreturn_t inic_interrupt(int irq, void *dev_instance)
{
	struct ata_host *host = dev_instance;
	unsigned int i, handled = 0;
	void __iomem *mmio;
	u32 irq_stat, irq_ack = 0;

	mmio = inic_host_mmio(host);;

	irq_stat = ioread16(mmio + GINTS);
	iowrite16(irq_stat, mmio + GINTS);
	if (irq_stat == 0)
		return IRQ_NONE;
		
	printk("Host intr %08X\n", irq_stat);
	spin_lock(&host->lock);

	for (i = 0; i < 2; i++) {
		struct ata_port *ap;
		if (!(irq_stat & (1 << i)))
			continue;
		ap = host->ports[i];
		if (ap)
			inic_port_intr(ap);
		else {
			if (ata_ratelimit())
				dev_printk(KERN_WARNING, host->dev,
					"interrupt on disabled port %u\n", i);
		}
		irq_ack |= (1 << i);
	}
	if (irq_ack)
		handled = 1;
	spin_unlock(&host->lock);
	return IRQ_RETVAL(handled);
}

static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;
	struct inic_port_priv *pp = ap->private_data;
	void __iomem *mmio = inic_mmio(ap);
	iowrite32(pp->cmd_ptr_dma, mmio + CPBLAR);
	inic_post_cpb(ap, qc->tag);
	return 0;
}

static void inic_freeze(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	u16 idmctl;
	u8 *p;
	int r;
	
	printk("Slot31freeze:\n");
	p = inic_cpb_addr(ap, 31);
	for (r = 0; r < 32; r++) {
		printk("%02X ", p[r]);
		if (r % 8 == 7)
			printk("\n");
	}
	idmctl = ioread16(mmio + IDMCTL);
	printk("FREEZE.. IDMCTL was %04X ", idmctl);
	/* Freeze DMA engine, disable IRQ delivery */
	idmctl &= ~CTL_HWFRZEN;
	idmctl |= CTL_AIEN|CTL_FREZEN;
	iowrite16(idmctl, mmio + IDMCTL);
	printk("FROZEN\n");
}

static void inic_thaw(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	u16 idmctl;
	
	idmctl = ioread16(mmio + IDMCTL);
	printk("THAW.. IDMCTL was %04X ", idmctl);
	/* Q1: Do we need to clear irqs left, q2 should we use AIEN or
	   the global IRQ block */
	/* Unfreeze DMA engine, enable IRQ delivery */
/*	idmctl |= CTL_HWFRZEN; */
	idmctl &= ~(CTL_AIEN|CTL_FREZEN);
	iowrite16(idmctl, mmio + IDMCTL);
	printk("THAWED IDMCTL now %04X\n", idmctl);
}

static void inic_error_handler(struct ata_port *ap)
{
	void __iomem *mmio = inic_mmio(ap);
	u16 r;
	u8 *p;
	
	r = ioread16(mmio + IDMCTL);
	printk("IDMCTL = %04x ", r);
	r = ioread16(mmio + IDMSTAT);
	printk("IDMSTAT = %04x\n", r);
	r = ioread8(mmio + INTSTAT);
	printk("INTSTAT = %04x ", r);
	printk("NEXT RX = %d\n", inic_next_cpb(ap));
	r = ioread8(mmio + PTQCNT);
	printk("FIFO IN = %d\n", r);
	printk("TXQLEN %d\n", ioread8(mmio + PTQCNT));
	
	p = inic_cpb_addr(ap, 31);
	for (r = 0; r < 32; r++) {
		printk("%02X ", p[r]);
		if (r % 8 == 7)
			printk("\n");
	}
#if 0
	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
		/* Resume engine via UNFREZ */
		u16 idmctl;
		void __iomem *mmio = inic_mmio(ap);
		idmctl = ioread16(mmio + IDMCTL);
		idmctl |= CTL_UNFREZ;
		iowrite16(idmctl, mmio + IDMCTL);
	}
#endif
	/* perform recovery */
	ata_do_eh(ap, ata_std_prereset, NULL, inic_hardreset, 
							inic_postreset);
}

static void inic_post_internal_cmd(struct ata_queued_cmd *qc)
{
	/* make DMA engine forget about the failed command */
	if (qc->flags & ATA_QCFLAG_FAILED) {
		inic_reset_port(qc->ap);
	}
}

static int inic_port_resume(struct ata_port *ap)
{
	inic_power_up(ap);
	inic_thaw(ap);
	
	return 0;
}

#ifdef CONFIG_PM
static int inic_port_suspend(struct ata_port *ap, pm_message_t mesg)
{
	inic_power_down(ap);
	return 0;
}

static int inic_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
{
	return ata_pci_device_suspend(pdev, mesg);
}

static int inic_pci_device_resume(struct pci_dev *pdev)
{
	struct ata_host *host = dev_get_drvdata(&pdev->dev);
	int rc;

	rc = ata_pci_device_do_resume(pdev);
	if (rc)
		return rc;

	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
		inic_reset_controller(host);
		inic_init_controller(host);
	}

	ata_host_resume(host);

	return 0;
}
#endif

/**
 *	inic_port_start		-	per port setup
 *	@ap: port being configured
 *
 *	For each INIC port we need to allocate buffers for the PRD,
 *	the DMA mapping of any ATAPI CDB and for the command buffers
 *	themselves for up to 32 command blocks. 
 */
static int inic_port_start(struct ata_port *ap)
{
	struct device *dev = ap->host->dev;
	struct inic_port_priv *pp;
	void *mem;
	dma_addr_t mem_dma;
	int rc;
	void __iomem *mmio = inic_mmio(ap);
	int i;
	u16 idmctl;
	
	idmctl = ioread16(mmio + IDMCTL);
	iowrite16(idmctl|CTL_APSE, mmio + IDMCTL);
	
	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
	if (!pp)
		return -ENOMEM;

	rc = ata_pad_alloc(ap, dev);
	if (rc)
		return rc;
	mem = dmam_alloc_coherent(dev, INIC_CMDPTR_SZ + INIC_CMD_SLOT_SZ + INIC_ATAPI_SZ + INIC_PRD_SZ, &mem_dma,
				  GFP_KERNEL);
	if (!mem)
		return -ENOMEM;

	pp->cmd_ptr = mem;
	pp->cmd_ptr_dma = mem_dma;

	/* The controller also needs to know this base directly */
	iowrite32(mem_dma, mmio + CPBLAR);
	
	mem += INIC_CMDPTR_SZ;
	mem_dma += INIC_CMDPTR_SZ;
	memset(mem, 0, INIC_CMD_SLOT_SZ);

	/*
	 * Next item in chunk of DMA memory: 32-slot command table,
	 * 32 bytes each in size
	 */
	pp->cmd_slot = mem;
	pp->cmd_slot_dma = mem_dma;

	for (i = 0; i < 32; i++)
		pp->cmd_ptr[i] = cpu_to_le32(mem_dma + INIC_CMD_SZ * i);

	mem += INIC_CMD_SLOT_SZ;
	mem_dma += INIC_CMD_SLOT_SZ;
	
	/*
	 * Buffer space for ATAPI CDB blocks
	 */
	pp->atapi_buf = mem;
	pp->atapi_buf_dma = mem_dma;
	
	mem += INIC_ATAPI_SZ;
	mem_dma += INIC_ATAPI_SZ;
	
	/*
	 * Buffer space used for PRD assembly
	 */
	pp->prd_buf = mem;
	pp->prd_buf_dma = mem_dma;

	ap->private_data = pp;
	
	/* engage engines, captain */
	return inic_port_resume(ap);
}

static void inic_port_stop(struct ata_port *ap)
{
	inic_port_stop(ap);
}

/**
 *	inic_configure_dma_masks	-	set for 32bit DMA
 *	@pdev: PCI device
 *
 *	Set the INIC162x up for 32bit DMA limits.
 */

static int inic_configure_dma_masks(struct pci_dev *pdev)
{
	int rc;

	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
	if (rc) {
		dev_printk(KERN_ERR, &pdev->dev,
			   "32-bit DMA enable failed\n");
		return rc;
	}
	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
	if (rc) {
		dev_printk(KERN_ERR, &pdev->dev,
			   "32-bit consistent DMA enable failed\n");
		return rc;
	}
	return 0;
}

/**
 *	inic_init_one		-	INIC controller discovered
 *	@pdev; PCI device
 *	@ent: table entry
 *
 *	Called from the kernel PCI core code when the kernel finds a
 *	device matching our INIC signatures. Allocate the needed resources
 *	start up the controller and let the ATA layer get on with its work
 */

static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
{
	static int printed_version;
	struct ata_port_info pi = inic_port_info[ent->driver_data];
	const struct ata_port_info *ppi[] = { &pi, NULL };
	struct ata_host *host;
	int i, rc;
	void __iomem *mmio;
	int mmio_bar;

	host = ata_host_alloc_pinfo(&pdev->dev, ppi, NR_PORTS);
	if (!host)
		return -ENOMEM;

	WARN_ON(ATA_MAX_QUEUE > INIC_MAX_CMDS);

	if (!printed_version++)
		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");

	/* acquire resources */
	rc = pcim_enable_device(pdev);
	if (rc)
		return rc;

	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {	
		rc = pcim_iomap_regions(pdev, 0x3F, DRV_NAME);
		mmio_bar = MMIO_BAR;
	} else if (pdev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
		rc = pcim_iomap_regions(pdev, 0x03, DRV_NAME);
		mmio_bar = CARDBUS_MMIO_BAR;
	} else
		return -ENODEV;
		
	host->iomap = pcim_iomap_table(pdev);
	if (rc == -EBUSY)
		pcim_pin_device(pdev);
	if (rc)
		return rc;

	mmio = host->iomap[mmio_bar];
	for (i = 0; i < NR_PORTS; i++) {
		struct ata_port *ap = host->ports[i];
		struct ata_ioports *port = &ap->ioaddr;
		unsigned int offset = i * PORT_SIZE;

		ap->pm_policy = NOT_AVAILABLE;
		
		port->cmd_addr = mmio + offset + TASKFILE;
		port->altstatus_addr =
		port->ctl_addr = mmio + offset + ACTRL;
		port->scr_addr = mmio + offset + SSTATUS;
		port->bmdma_addr = mmio + offset;
		ata_std_ports(port);

		ata_port_pbar_desc(ap, MMIO_BAR, -1, "mmio");
	}

	/* initialize adapter */
	
	rc = inic_configure_dma_masks(pdev);
	if (rc)
		return rc;

	pci_set_master(pdev);
	inic_reset_controller(host);
	inic_init_controller(host);

	return ata_host_activate(host, pdev->irq, inic_interrupt, IRQF_SHARED,
				 &inic_sht);
}

static int __init inic_init(void)
{
	return pci_register_driver(&inic_pci_driver);
}

static void __exit inic_exit(void)
{
	pci_unregister_driver(&inic_pci_driver);
}


MODULE_AUTHOR("Alan Cox");
MODULE_DESCRIPTION("INIC SATA low-level driver");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, inic_pci_tbl);
MODULE_VERSION(DRV_VERSION);

module_init(inic_init);
module_exit(inic_exit);
