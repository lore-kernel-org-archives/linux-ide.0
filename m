From: Franck Bourdonnec <fbourdonnec@chez.com>
Subject: SiS driver K2.4 for 180/182/965/966....
Date: Mon, 30 Jul 2007 01:40:18 +0200
Message-ID: <200707300140.18940.fbourdonnec@chez.com>
Reply-To: fbourdonnec@chez.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_WumcPl++XNyXEAO4Vsxbvg)"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:52540 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753048AbXHBIad (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 04:30:33 -0400
Received: from ntkiller2.dhome.fr ([86.72.26.240]) by sp604005mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JM500DGZ0YESMB0@sp604005mt.gpm.neuf.ld> for
 linux-ide@vger.kernel.org; Thu, 02 Aug 2007 10:30:18 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


--Boundary_(ID_WumcPl++XNyXEAO4Vsxbvg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello Uwe & Jeff,


I'm trying to follow the 'life' of this driver "sata_sis.c".

I want to report back in Kernel 2.4.34 the additions found
since some time. I do this to extend IPCOP usage of
SATA boards and also to contribute to linux kernel if
possible.

It's not easy because there is many source, that seems
like each others, but not exactly

1) http://driver.sis.com/linux/raid/sis18x_20060508.zip
2) what is today in kernel 2.6.21
3) the list of patch against sata_sis.c (git)
4) the kernel 2.4.34 "sata_sis.c" source

After compiling all this, result is a kernel 2.4 driver
that I think, ressemble a lot to the actual 2.6 version.

I would like you just to read the source (test it??) for advice.


========================

Strange thing I noted is:

Sis1180,1184: present in sis18x_20060508.zip but inexistant
elsewhere (particulary in K2.6). Why?

========================

in this fix 
http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.22.y.git;a=commitdiff;h=29da9f6d9cc3685ae7f6c8b817f6ed8864c78a4c

the call to "ata_pci_init_native_mode" function is a little bit changed: 
&ppi becomes ppi.

probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | 
ATA_PORT_SECONDARY);

just a confirmation that this match K2.4 prototype. Sometimes I don't really 
follow some C notation with **  ;-)

==========================

I wasn't sure here:

1)
.host_flags  = ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS | ATA_FLAG_SATA_RESET |
                          ATA_FLAG_NO_LEGACY,
2)
.host_flags  = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
                          ATA_FLAG_NO_LEGACY,
3)
.host_flags  = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,



Choosed 2) because
ATA_FLAG_SLAVE_POSS is positionned in the code (set to one)


=========================

Thank you to have read this.
Hope it's ok. For my project (IPCop) or directly in k2.4
if you don't see major obstacle.

Franck

--Boundary_(ID_WumcPl++XNyXEAO4Vsxbvg)
Content-type: text/x-csrc; charset=us-ascii; name=sis_sata-k2.4.34.c
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=sis_sata-k2.4.34.c

/*
 *  sata_sis.c - Silicon Integrated Systems SATA
 *
 *  Maintained by:  Uwe Koziolek
 *  		    Please ALWAYS copy linux-ide@vger.kernel.org
 *		    on emails.
 *
 *  Copyright 2004 Uwe Koziolek
 *
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
 *
 *  libata documentation is available via 'make {ps|pdf}docs',
 *  as Documentation/DocBook/libata.*
 *
 *  Hardware documentation available under NDA.
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
#include <scsi/scsi_host.h>
#include <linux/libata.h>

#define DRV_NAME	"sata_sis"
#define DRV_VERSION	"0.6"

enum {
	sis_180			= 0,
	SIS_SCR_PCI_BAR		= 5,

	/* PCI configuration registers */
	SIS_GENCTL		= 0x54, /* IDE General Control register */
	SIS_SCR_BASE		= 0xc0, /* sata0 phy SCR registers */
	SIS180_SATA1_OFS	= 0x10, /* offset from sata0->sata1 phy regs */
	SIS182_SATA1_OFS	= 0x20, /* offset from sata0->sata1 phy regs */
	SIS_PMR			= 0x90, /* port mapping register */
	SIS_PMR_COMBINED	= 0x30,

	/* random bits */
	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */

	GENCTL_IOMAPPED_SCR	= (1 << 26), /* if set, SCRs are in IO space */
};

static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);

static const struct pci_device_id sis_pci_tbl[] = {
	{ PCI_VENDOR_ID_SI, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 964/180 */
	{ PCI_VENDOR_ID_SI, 0x0181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 964/180 */
	{ PCI_VENDOR_ID_SI, 0x0182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 965/965L*/
	{ PCI_VENDOR_ID_SI, 0x0183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 965/965L*/
	{ PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
	{ PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 966/680*/
	{ PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 966/966L/968/680*/
	{ PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	
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
	.detect			= ata_scsi_detect,
	.release		= ata_scsi_release,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.eh_strategy_handler	= ata_scsi_error,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= ATA_MAX_PRD,
	.max_sectors		= ATA_MAX_SECTORS,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.use_new_eh_code	= ATA_SHT_NEW_EH_CODE,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.bios_param		= ata_std_bios_param,
};

static const struct ata_port_operations sis_ops = {
	.port_disable		= ata_port_disable,
	.tf_load		= ata_tf_load,
	.tf_read		= ata_tf_read,
	.check_status		= ata_check_status,
	.exec_command		= ata_exec_command,
	.dev_select		= ata_std_dev_select,
	.phy_reset		= sata_phy_reset,
	.bmdma_setup            = ata_bmdma_setup,
	.bmdma_start            = ata_bmdma_start,
	.bmdma_stop		= ata_bmdma_stop,
	.bmdma_status		= ata_bmdma_status,
	.qc_prep		= ata_qc_prep,
	.qc_issue		= ata_qc_issue_prot,
	.eng_timeout		= ata_eng_timeout,
	.irq_handler		= ata_interrupt,
	.irq_clear		= ata_bmdma_irq_clear,
	.scr_read		= sis_scr_read,
	.scr_write		= sis_scr_write,
	.port_start		= ata_port_start,
	.port_stop		= ata_port_stop,
	.host_stop		= ata_host_stop,
};

static struct ata_port_info sis_port_info = {
	.sht		= &sis_sht,
	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
			  ATA_FLAG_NO_LEGACY,
	.pio_mask	= 0x1f,
	.mwdma_mask	= 0x7,
	.udma_mask	= 0x7f,
	.port_ops	= &sis_ops,
};


MODULE_AUTHOR("Uwe Koziolek");
MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
MODULE_VERSION(DRV_VERSION);

static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, struct pci_dev *pdev)
{
	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
	u32 val = 0;

	if (port_no)  {
		switch (pdev->device) {
			case 0x0180:
			case 0x0181:
				addr += SIS180_SATA1_OFS;
				break;
			case 0x0182:
			case 0x0183:
			case 0x1182:
			case 0x1183:
				addr += SIS182_SATA1_OFS;
				break;
			case 0x1184:
			case 0x1180:
				/*
				 *  If hw_id = 0x1184, 0x1180
				 *  read OFF_SET 64h, bit 28 to decide  966 or 966L.
				 *  1: 966L port0 = c0h, port1 = e0h
				 *  0: 966  port0 = c0h, port1 = d0h
				 */
				pci_read_config_dword(pdev, 0x64, &val);
				if (val & 0x10000000)
					addr += SIS182_SATA1_OFS; /* SB-966L */
				else
					addr += SIS180_SATA1_OFS; /* 966 */
				break;
		}
	}

	return addr;
}

static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
{
	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
	u32 val, val2 = 0;
	u8 pmr;

	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
		return 0xffffffff;

	pci_read_config_byte(pdev, SIS_PMR, &pmr);

	pci_read_config_dword(pdev, cfg_addr, &val);

	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);

	return (val|val2) & 0xfffffffb; /* avoid problems with powerdowned ports */
}

static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
{
	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
	u8 pmr;

	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
		return;

	pci_read_config_byte(pdev, SIS_PMR, &pmr);

	pci_write_config_dword(pdev, cfg_addr, val);

	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
		pci_write_config_dword(pdev, cfg_addr+0x10, val);
}

static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
{
	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
	u32 val, val2 = 0;
	u8 pmr;

	if (sc_reg > SCR_CONTROL)
		return 0xffffffffU;

	if (ap->flags & SIS_FLAG_CFGSCR)
		return sis_scr_cfg_read(ap, sc_reg);

	pci_read_config_byte(pdev, SIS_PMR, &pmr);

	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));

	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);

	return (val|val2) & 0xfffffffb;
}

static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
{
	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
	u8 pmr;

	if (sc_reg > SCR_CONTROL)
		return;

	pci_read_config_byte(pdev, SIS_PMR, &pmr);

	if (ap->flags & SIS_FLAG_CFGSCR)
		sis_scr_cfg_write(ap, sc_reg, val);
	else {
		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
	}
}


static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
{
	struct ata_probe_ent *probe_ent = NULL;
	int rc;
	u32 genctl;
	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
	int pci_dev_busy = 0;
	u8 pmr;
	u8 port2_start = 0x20;
	u8  progintf;
	u32 val;

	/* check if the device's programming interface 09h,
	   is compatibility mode
	*/
	pci_read_config_byte(pdev, 0x09, &progintf);
	if ((progintf & 0x3) == 0) {
		pdev_printk(KERN_INFO, pdev,
			"programming interface = %x\n", progintf);
		pdev_printk(KERN_INFO, pdev,
			"SiS-%x device is compatibiltiy mode. Ignore it\n", ent->device);
		rc = -1;
		return rc;
	}

	rc = pci_enable_device(pdev);
	if (rc)
		return rc;

	rc = pci_request_regions(pdev, DRV_NAME);
	if (rc) {
		pci_dev_busy = 1;
		goto err_out;
	}

	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
	if (rc)
		goto err_out_regions;
	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
	if (rc)
		goto err_out_regions;


	/* check and see if the SCRs are in IO space or PCI cfg space */
	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
		pi.host_flags |= SIS_FLAG_CFGSCR;

	/* 0x1180, 0x1184 does not provide SCRs mapping. Set the CFGSCR Flag */	
	if ((ent->device == 0x1184) || (ent->device == 0x1180))
		pi.host_flags |= SIS_FLAG_CFGSCR;

	/* if hardware thinks SCRs are in IO space, but there are
	 * no IO resources assigned, change to PCI cfg space.
	 */
	if ((!(pi.host_flags & SIS_FLAG_CFGSCR)) &&
	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
		genctl &= ~GENCTL_IOMAPPED_SCR;
		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
		pi.host_flags |= SIS_FLAG_CFGSCR;
	}

	pci_read_config_byte(pdev, SIS_PMR, &pmr);
	switch (ent->device) {
		case 0x0180:
		case 0x0181:
			/* link to pata when (pmr&0x30) == 0x10,0x30 */
			if ((pmr & SIS_PMR_COMBINED) == 0) {
				pdev_printk(KERN_INFO, pdev,
				   "Detected SiS 180/181/964 chipset in SATA mode\n");
				port2_start = 64;
			}
			else {
				pdev_printk(KERN_INFO, pdev,
				   "Detected SiS 180/181/964 chipset in combined mode\n");
				port2_start = 0;
				pi.host_flags |= ATA_FLAG_SLAVE_POSS;
 		  	}
			break;

		case 0x0182:
		case 0x0183:
			pci_read_config_dword ( pdev, 0x6C, &val);
			if ( val & (1L << 31)) {
    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 182/1182/1183/965 SATA controller\n");
			    pi.host_flags |= ATA_FLAG_SLAVE_POSS;
			} else {
    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 182/1182/1183/965L SATA controller\n");
			}
			break;

		case 0x1182:
		case 0x1183:
			/* link 1183 to pata driver */
			pci_read_config_dword ( pdev, 0x64, &val);
			if ( val & 0x10000000) {
    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 1182/1183/966 SATA controller\n");
			    pi.host_flags |= ATA_FLAG_SLAVE_POSS;
			} else {
    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 1182/1183/966L SATA controller\n");
			}
			break;

		case 0x1180:
			pdev_printk(KERN_INFO, pdev, "Detected SiS 1180 SATA controller\n");
			port2_start = 0;
			break;

		case 0x1184:
			pdev_printk(KERN_INFO, pdev, "Detected SiS 1184 SATA controller\n");
			port2_start = 0;
			break;
	}

	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
	if (!probe_ent) {
		rc = -ENOMEM;
		goto err_out_regions;
	}

	/*
	 *  Flag "SIS_FLAG_CFGSCR" is not set.
	 *  That will not be 0x1180, 0x1184
	 */
	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
		probe_ent->port[0].scr_addr =
			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
		probe_ent->port[1].scr_addr =
			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + port2_start;
	}

	pci_set_master(pdev);
	pci_intx(pdev, 1);

	ata_add_to_probe_list(probe_ent);

	return 0;

err_out_regions:
	pci_release_regions(pdev);

err_out:
	if (!pci_dev_busy)
		pci_disable_device(pdev);
	return rc;

}

static int __init sis_init(void)
{
	int rc = pci_module_init(&sis_pci_driver);
	if (rc)
		return rc;

	rc = scsi_register_module(MODULE_SCSI_HA, &sis_sht);
	if (rc) {
		pci_unregister_driver(&sis_pci_driver);
		return -ENODEV;
	}

	return 0;
}

static void __exit sis_exit(void)
{
	scsi_unregister_module(MODULE_SCSI_HA, &sis_sht);
	pci_unregister_driver(&sis_pci_driver);
}

module_init(sis_init);
module_exit(sis_exit);


--Boundary_(ID_WumcPl++XNyXEAO4Vsxbvg)
Content-type: text/x-diff; charset=us-ascii; name=sata_k24_k26.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=sata_k24_k26.diff

--- sata_sis_old.c	2007-07-29 03:23:22.000000000 +0200
+++ sata_sis.c	2007-07-30 01:01:56.000000000 +0200
@@ -43,7 +43,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sis"
-#define DRV_VERSION	"0.5"
+#define DRV_VERSION	"0.6"
 
 enum {
 	sis_180			= 0,
@@ -68,9 +68,14 @@
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
-	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
-	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 964/180 */
+	{ PCI_VENDOR_ID_SI, 0x0181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 964/180 */
+	{ PCI_VENDOR_ID_SI, 0x0182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 965/965L*/
+	{ PCI_VENDOR_ID_SI, 0x0183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 965/965L*/
+	{ PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 966/680*/
+	{ PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	/* SiS 966/966L/968/680*/
+	{ PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },	
 	{ }	/* terminate list */
 };
 
@@ -143,15 +148,38 @@
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, int device)
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, struct pci_dev *pdev)
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
+	u32 val = 0;
 
 	if (port_no)  {
-		if (device == 0x182)
-			addr += SIS182_SATA1_OFS;
-		else
-			addr += SIS180_SATA1_OFS;
+		switch (pdev->device) {
+			case 0x0180:
+			case 0x0181:
+				addr += SIS180_SATA1_OFS;
+				break;
+			case 0x0182:
+			case 0x0183:
+			case 0x1182:
+			case 0x1183:
+				addr += SIS182_SATA1_OFS;
+				break;
+			case 0x1184:
+			case 0x1180:
+				/*
+				 *  If hw_id = 0x1184, 0x1180
+				 *  read OFF_SET 64h, bit 28 to decide  966 or 966L.
+				 *  1: 966L port0 = c0h, port1 = e0h
+				 *  0: 966  port0 = c0h, port1 = d0h
+				 */
+				pci_read_config_dword(pdev, 0x64, &val);
+				if (val & 0x10000000)
+					addr += SIS182_SATA1_OFS; /* SB-966L */
+				else
+					addr += SIS180_SATA1_OFS; /* 966 */
+				break;
+		}
 	}
 
 	return addr;
@@ -160,7 +188,7 @@
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
 	u32 val, val2 = 0;
 	u8 pmr;
 
@@ -171,16 +199,17 @@
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
-	return val|val2;
+	return (val|val2) & 0xfffffffb; /* avoid problems with powerdowned ports */
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
 	u8 pmr;
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -190,7 +219,8 @@
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
@@ -210,10 +240,11 @@
 
 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
-	return val | val2;
+	return (val|val2) & 0xfffffffb;
 }
 
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
@@ -230,24 +261,37 @@
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
-			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
+		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
+			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 	}
 }
 
+
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi;
+	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
-	u8 port2_start;
-
-	if (!printed_version++)
-		pdev_printk(KERN_INFO, pdev, "version " DRV_VERSION "\n");
+	u8 port2_start = 0x20;
+	u8  progintf;
+	u32 val;
+
+	/* check if the device's programming interface 09h,
+	   is compatibility mode
+	*/
+	pci_read_config_byte(pdev, 0x09, &progintf);
+	if ((progintf & 0x3) == 0) {
+		pdev_printk(KERN_INFO, pdev,
+			"programming interface = %x\n", progintf);
+		pdev_printk(KERN_INFO, pdev,
+			"SiS-%x device is compatibiltiy mode. Ignore it\n", ent->device);
+		rc = -1;
+		return rc;
+	}
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -266,52 +310,89 @@
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
 
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
-		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
+		pi.host_flags |= SIS_FLAG_CFGSCR;
+
+	/* 0x1180, 0x1184 does not provide SCRs mapping. Set the CFGSCR Flag */	
+	if ((ent->device == 0x1184) || (ent->device == 0x1180))
+		pi.host_flags |= SIS_FLAG_CFGSCR;
 
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
-	if ((!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) &&
+	if ((!(pi.host_flags & SIS_FLAG_CFGSCR)) &&
 	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
 	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
 		genctl &= ~GENCTL_IOMAPPED_SCR;
 		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
-		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
+		pi.host_flags |= SIS_FLAG_CFGSCR;
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	if (ent->device != 0x182) {
-		if ((pmr & SIS_PMR_COMBINED) == 0) {
-			pdev_printk(KERN_INFO, pdev,
-				   "Detected SiS 180/181 chipset in SATA mode\n");
-			port2_start = 64;
-		}
-		else {
-			pdev_printk(KERN_INFO, pdev,
-				   "Detected SiS 180/181 chipset in combined mode\n");
-			port2_start=0;
-		}
+	switch (ent->device) {
+		case 0x0180:
+		case 0x0181:
+			/* link to pata when (pmr&0x30) == 0x10,0x30 */
+			if ((pmr & SIS_PMR_COMBINED) == 0) {
+				pdev_printk(KERN_INFO, pdev,
+				   "Detected SiS 180/181/964 chipset in SATA mode\n");
+				port2_start = 64;
+			}
+			else {
+				pdev_printk(KERN_INFO, pdev,
+				   "Detected SiS 180/181/964 chipset in combined mode\n");
+				port2_start = 0;
+				pi.host_flags |= ATA_FLAG_SLAVE_POSS;
+ 		  	}
+			break;
+
+		case 0x0182:
+		case 0x0183:
+			pci_read_config_dword ( pdev, 0x6C, &val);
+			if ( val & (1L << 31)) {
+    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 182/1182/1183/965 SATA controller\n");
+			    pi.host_flags |= ATA_FLAG_SLAVE_POSS;
+			} else {
+    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 182/1182/1183/965L SATA controller\n");
+			}
+			break;
+
+		case 0x1182:
+		case 0x1183:
+			/* link 1183 to pata driver */
+			pci_read_config_dword ( pdev, 0x64, &val);
+			if ( val & 0x10000000) {
+    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 1182/1183/966 SATA controller\n");
+			    pi.host_flags |= ATA_FLAG_SLAVE_POSS;
+			} else {
+    			    pdev_printk(KERN_INFO, pdev, "Detected SiS 1182/1183/966L SATA controller\n");
+			}
+			break;
+
+		case 0x1180:
+			pdev_printk(KERN_INFO, pdev, "Detected SiS 1180 SATA controller\n");
+			port2_start = 0;
+			break;
+
+		case 0x1184:
+			pdev_printk(KERN_INFO, pdev, "Detected SiS 1184 SATA controller\n");
+			port2_start = 0;
+			break;
 	}
-	else {
-		pdev_printk(KERN_INFO, pdev, "Detected SiS 182 chipset\n");
-		port2_start = 0x20;
-	}
-
-
-
-
 
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
 
+	/*
+	 *  Flag "SIS_FLAG_CFGSCR" is not set.
+	 *  That will not be 0x1180, 0x1184
+	 */
 	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);

--Boundary_(ID_WumcPl++XNyXEAO4Vsxbvg)--
