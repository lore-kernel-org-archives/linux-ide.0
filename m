From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: Serial ATA SIS 964
Date: Tue, 24 Feb 2004 10:44:56 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1077615725.665.22.camel@uk2.local>
References: <1077531578.681.21.camel@uk2.local> <403AA727.6030005@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HJmWMW0DFC74AyPmL8Ty"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:29383 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262085AbUBXJoc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2004 04:44:32 -0500
In-Reply-To: <403AA727.6030005@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-HJmWMW0DFC74AyPmL8Ty
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Mr. Garzik,

i have included the driver into my mail, the driver may be posted.
Mrs Daniela Engert has offered me to help.

I have only one SATA disk, so no RAID functionality is tested. I assume
it is a 2 port SATA module with a software RAID.

I hope you will add the missing DMA feature und submit the driver to the
kernel if finished.

best regards
Uwe Koziolek

> Uwe Koziolek wrote:
> > Hello,
> > 
> > i have written a driver for the SIS 180 Controller (included into SIS964
> > Southbridge), Motherboard is K7S8XE+.
> > The Driver is libata-based, running under Kernel 2.6.3
> > 
> > The driver works with programmed IO without problems.
> > My Problem:
> > The busmuster dma does not works. I think i must do some special
> > initialization like the SIS 5513 driver, but i dont have any information
> > about this chip.
> 
> 
> SiS sent me docs and a board...  wanna post your driver?  :)
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--=-HJmWMW0DFC74AyPmL8Ty
Content-Disposition: attachment; filename=sata_sis.c
Content-Type: text/x-c; name=sata_sis.c; charset=
Content-Transfer-Encoding: 7bit

/*
 *  sata_sis.c - Silicon Integrated Systems SATA
 *
 *  Copyright 2004 Uwe Koziolek <uwe.koziolek@gmx.net>
 *
 *  The contents of this file are subject to the Open
 *  Software License version 1.1 that can be found at
 *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
 *  by reference.
 *
 *  Alternatively, the contents of this file may be used under the terms
 *  of the GNU General Public License version 2 (the "GPL") as distributed
 *  in the kernel source COPYING file, in which case the provisions of
 *  the GPL are applicable instead of the above.  If you wish to allow
 *  the use of your version of this file only under the terms of the
 *  GPL and not to allow others to use your version of this file under
 *  the OSL, indicate your decision by deleting the provisions above and
 *  replace them with the notice and other provisions required by the GPL.
 *  If you do not delete the provisions above, a recipient may use your
 *  version of this file under either the OSL or the GPL.
 *
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include "scsi.h"
#include "hosts.h"
#include <linux/libata.h>

#define DRV_NAME	"sata_sis"
#define DRV_VERSION	"0.02"

enum {
	sis_180			= 0,
};

static void sis_set_piomode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int pio);
static void sis_set_udmamode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int udma);
static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);

static struct pci_device_id sis_pci_tbl[] = {
	{ 0x1039, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
	{ }	/* terminate list */
};


static struct pci_driver sis_pci_driver = {
	.name			= DRV_NAME,
	.id_table		= sis_pci_tbl,
	.probe			= sis_init_one,
	.remove			= ata_pci_remove_one,
};

static Scsi_Host_Template sis_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.queuecommand		= ata_scsi_queuecmd,
	.eh_strategy_handler	= ata_scsi_error,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= ATA_MAX_PRD,
	.max_sectors		= ATA_MAX_SECTORS,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.dma_boundary		= ATA_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.bios_param		= ata_std_bios_param,
};

static struct ata_port_operations sis_ops = {
	.port_disable		= ata_port_disable,
	.set_piomode		= sis_set_piomode,
	.set_udmamode		= sis_set_udmamode,
	.tf_load		= ata_tf_load_pio,
	.tf_read		= ata_tf_read_pio,
	.check_status		= ata_check_status_pio,
	.exec_command		= ata_exec_command_pio,
	.phy_reset		= sata_phy_reset,
	.phy_config		= pata_phy_config,
	.bmdma_start            = ata_bmdma_start_pio,
	.fill_sg		= ata_fill_sg,
	.eng_timeout		= ata_eng_timeout,
	.irq_handler		= ata_interrupt,
	.scr_read		= sis_scr_read,
	.scr_write		= sis_scr_write,
	.port_start		= ata_port_start,
	.port_stop		= ata_port_stop,
};

static struct ata_port_info sis_port_info[] = {
	/* sis_180 */
	{
		.sht		= &sis_sht,
		.host_flags	= ATA_FLAG_SATA, ATA_FLAG_NO_LEGACY |
				  ATA_FLAG_SRST,
		.pio_mask	= 0x03,			/* pio3-4 */
		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
		.port_ops	= &sis_ops,
	}
};

MODULE_AUTHOR("Uwe Koziolek");
MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, sis_pci_tbl);


static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
{
	DPRINTK("ENTER/LEAVE sc_reg=%d\n", sc_reg);
	if (sc_reg >= 16) return 0xffffffffU;
	return inl(ap->ioaddr.scr_addr+(sc_reg*4));
}

static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
{
	DPRINTK("ENTER/LEAVE sc_reg=%d, val=%08x\n", sc_reg,  val);
	if (sc_reg >= 16) return;
	outl(val, ap->ioaddr.scr_addr+(sc_reg*4));
}

static void sis_set_piomode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int pio)
{
/* this hack forces IO to uses PIO intead of DMA, because the DMA code
 * for this chipset is not completed yet.
 */
	DPRINTK("ENTER/LEAVE\n");
	adev->flags |= ATA_DFLAG_PIO;
}

static void sis_set_udmamode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int udma)
{
	DPRINTK("ENTER/LEAVE\n");
}

static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
{
	struct ata_probe_ent *probe_ent = NULL;
	struct ata_port_info *port0 = &sis_port_info[sis_180];
	int rc;

	DPRINTK("ENTER\n");

	rc = pci_enable_device(pdev);
	if (rc)
		return rc;

	rc = pci_request_regions(pdev, DRV_NAME);
	if (rc)
		goto err_out;

	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
	if (rc)
		goto err_out_regions;

	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
	if (!probe_ent) {
		rc = -ENOMEM;
		goto err_out_regions;
	}

	memset(probe_ent, 0, sizeof(*probe_ent));
	probe_ent->pdev = pdev;
	INIT_LIST_HEAD(&probe_ent->node);

	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
	probe_ent->sht = port0->sht;
	probe_ent->host_flags = port0->host_flags;
	probe_ent->pio_mask = port0->pio_mask;
	probe_ent->udma_mask = port0->udma_mask;
	probe_ent->port_ops = port0->port_ops;

	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
	ata_std_ports(&probe_ent->port[0]);
	probe_ent->port[0].ctl_addr =
		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
	probe_ent->port[0].scr_addr = pci_resource_start(pdev, 5);
	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
	ata_std_ports(&probe_ent->port[1]);
	probe_ent->port[1].ctl_addr =
		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
	probe_ent->port[1].scr_addr = pci_resource_start(pdev, 5) + 64;

	probe_ent->n_ports = 2;
	probe_ent->irq = pdev->irq;
	probe_ent->irq_flags = SA_SHIRQ;

	pci_set_master(pdev);

	ata_device_add(probe_ent);
	kfree(probe_ent);

	DPRINTK("LEAVE\n");
	return 0;

err_out_regions:
	pci_release_regions(pdev);

err_out:
	pci_disable_device(pdev);
	return rc;

}

static int __init sis_init(void)
{
	int rc;

	rc = pci_module_init(&sis_pci_driver);
	if (rc)
		return rc;

	return 0;
}

static void __exit sis_exit(void)
{
	pci_unregister_driver(&sis_pci_driver);
}


module_init(sis_init);
module_exit(sis_exit);

--=-HJmWMW0DFC74AyPmL8Ty--

