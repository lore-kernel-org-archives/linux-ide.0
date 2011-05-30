From: Paul Kosinski <prk@iment.com>
Subject: AHCI driver fails to IDENTIFY in kernel 2.6.39, adapter card ASUS
 U3S6 (Marvell 1b4b:9120)
Date: Mon, 30 May 2011 13:51:33 -0400
Message-ID: <20110530135133.1642dc87@ime5.iment.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/psv3Mff82RP9kd0QtTuxUkj"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iment3.iment.com ([65.18.195.176]:40292 "EHLO iment3.iment.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936Ab1E3SM2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 May 2011 14:12:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

--MP_/psv3Mff82RP9kd0QtTuxUkj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

I recently built a 2.6.39 kernel (from kernel.org) in order to take
advantage of the ASUS U3S6 adapter card's USB 3.0 capability. The
card's SATA capability had been working nicely (via the AHCI driver)
with the stock openSUSE 11.1 kernel (2.6.27.7-9-default), but that
kernel doesn't have the XHCI driver for USB3.

With the 2.6.39 kernel, the situation is reversed: the card's USB3
works, but SATA doesn't. In particular, the booting process reports
"failed to IDENTIFY (I/O error, err_mask=0x4)" for disks attached to
that adapter, even after trying lower link speeds.

With both kernels, the AHCI driver attached to the SATA adapter by
default, as its PCI ID (1b4b:9120) isn't in any of the tables in
"/lib/modules/2.6.x.y/modules.*".

Since the kernel is Open Source, I looked in the ahci.c files for
both 2.3.39 and 2.6.27.7-9-default, hoping to discover some obvious
difference that would explain the failure. Instead I discovered that
the ahci.c for 2.6.27.7-9-default is about twice as big as ahci.c for
2.6.39. Even though part of that difference is explained by the the
fact that 2.6.27.7-9-default doesn't have an ahci.h file, the diff
was far too extensive to pursue. (I get plenty of that -- debugging
code I didn't write -- at work.)

By the way, kernel 2.6.35.12 also fails in this manner, so it isn't
a recent regression.

For your perusal I have attached to this email the ahci.c from
openSUSE's 2.6.27.7-9-default kernel, along with the boot.msg
showing how 2.6.39 fails (search for "failed to IDENTIFY").

Thanks for your attention, and I hope that a quick solution can be
found.

Paul Kosinski

P.S. As an amusing side note, since the U3S6 card uses a Marvell
chip, I also looked at sata_mv.c. To my amazement, it said it was
originally written by Brett Russ, with whom I had worked closely
about 2 years ago -- i.e., after he did sata_mv -- at my company
(Tervela Inc.).


--MP_/psv3Mff82RP9kd0QtTuxUkj
Content-Type: text/x-csrc
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ahci.c

/*
 *  ahci.c - AHCI SATA support
 *
 *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
 *    		    Please ALWAYS copy linux-ide@vger.kernel.org
 *		    on emails.
 *
 *  Copyright 2004-2005 Red Hat, Inc.
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
 * libata documentation is available via 'make {ps|pdf}docs',
 * as Documentation/DocBook/libata.*
 *
 * AHCI hardware documentation:
 * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
 * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
 *
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

#define DRV_NAME	"ahci"
#define DRV_VERSION	"3.0"

static int ahci_skip_host_reset;
module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");

static int ahci_enable_alpm(struct ata_port *ap,
		enum link_pm policy);
static void ahci_disable_alpm(struct ata_port *ap);
static ssize_t ahci_led_show(struct ata_port *ap, char *buf);
static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
			      size_t size);
static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
					ssize_t size);
#define MAX_SLOTS 8

enum {
	AHCI_PCI_BAR		= 5,
	AHCI_MAX_PORTS		= 32,
	AHCI_MAX_SG		= 168, /* hardware max is 64K */
	AHCI_DMA_BOUNDARY	= 0xffffffff,
	AHCI_MAX_CMDS		= 32,
	AHCI_CMD_SZ		= 32,
	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
	AHCI_RX_FIS_SZ		= 256,
	AHCI_CMD_TBL_CDB	= 0x40,
	AHCI_CMD_TBL_HDR_SZ	= 0x80,
	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR_SZ + (AHCI_MAX_SG * 16),
	AHCI_CMD_TBL_AR_SZ	= AHCI_CMD_TBL_SZ * AHCI_MAX_CMDS,
	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_AR_SZ +
				  AHCI_RX_FIS_SZ,
	AHCI_IRQ_ON_SG		= (1 << 31),
	AHCI_CMD_ATAPI		= (1 << 5),
	AHCI_CMD_WRITE		= (1 << 6),
	AHCI_CMD_PREFETCH	= (1 << 7),
	AHCI_CMD_RESET		= (1 << 8),
	AHCI_CMD_CLR_BUSY	= (1 << 10),

	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
	RX_FIS_SDB		= 0x58, /* offset of SDB FIS data */
	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */

	board_ahci		= 0,
	board_ahci_vt8251	= 1,
	board_ahci_ign_iferr	= 2,
	board_ahci_sb600	= 3,
	board_ahci_mv		= 4,
	board_ahci_sb700	= 5,
	board_ahci_mcp65	= 6,
	board_ahci_nopmp	= 7,

	/* global controller registers */
	HOST_CAP		= 0x00, /* host capabilities */
	HOST_CTL		= 0x04, /* global host control */
	HOST_IRQ_STAT		= 0x08, /* interrupt status */
	HOST_PORTS_IMPL		= 0x0c, /* bitmap of implemented ports */
	HOST_VERSION		= 0x10, /* AHCI spec. version compliancy */
	HOST_EM_LOC		= 0x1c, /* Enclosure Management location */
	HOST_EM_CTL		= 0x20, /* Enclosure Management Control */

	/* HOST_CTL bits */
	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */

	/* HOST_CAP bits */
	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */

	/* registers for each SATA port */
	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
	PORT_LST_ADDR_HI	= 0x04, /* command list DMA addr hi */
	PORT_FIS_ADDR		= 0x08, /* FIS rx buf addr */
	PORT_FIS_ADDR_HI	= 0x0c, /* FIS rx buf addr hi */
	PORT_IRQ_STAT		= 0x10, /* interrupt status */
	PORT_IRQ_MASK		= 0x14, /* interrupt enable/disable mask */
	PORT_CMD		= 0x18, /* port command */
	PORT_TFDATA		= 0x20,	/* taskfile data */
	PORT_SIG		= 0x24,	/* device TF signature */
	PORT_CMD_ISSUE		= 0x38, /* command issue */
	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */

	/* PORT_IRQ_{STAT,MASK} bits */
	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */

	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */

	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
				  PORT_IRQ_IF_ERR |
				  PORT_IRQ_CONNECT |
				  PORT_IRQ_PHYRDY |
				  PORT_IRQ_UNK_FIS |
				  PORT_IRQ_BAD_PMP,
	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
				  PORT_IRQ_TF_ERR |
				  PORT_IRQ_HBUS_DATA_ERR,
	DEF_PORT_IRQ		= PORT_IRQ_ERROR | PORT_IRQ_SG_DONE |
				  PORT_IRQ_SDB_FIS | PORT_IRQ_DMAS_FIS |
				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,

	/* PORT_CMD bits */
	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
	PORT_CMD_CLO		= (1 << 3), /* Command list override */
	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */

	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */

	/* hpriv->flags bits */
	AHCI_HFLAG_NO_NCQ		= (1 << 0),
	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
	AHCI_HFLAG_NO_HOTPLUG		= (1 << 7), /* ignore PxSERR.DIAG.N */
	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */

	/* ap->flags bits */

	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN |
					  ATA_FLAG_IPM,

	ICH_MAP				= 0x90, /* ICH MAP register */

	/* em_ctl bits */
	EM_CTL_RST			= (1 << 9), /* Reset */
	EM_CTL_TM			= (1 << 8), /* Transmit Message */
	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
};

struct ahci_cmd_hdr {
	__le32			opts;
	__le32			status;
	__le32			tbl_addr;
	__le32			tbl_addr_hi;
	__le32			reserved[4];
};

struct ahci_sg {
	__le32			addr;
	__le32			addr_hi;
	__le32			reserved;
	__le32			flags_size;
};

struct ahci_em_priv {
	enum sw_activity blink_policy;
	struct timer_list timer;
	unsigned long saved_activity;
	unsigned long activity;
	unsigned long led_state;
};

struct ahci_host_priv {
	unsigned int		flags;		/* AHCI_HFLAG_* */
	u32			cap;		/* cap to use */
	u32			port_map;	/* port map to use */
	u32			saved_cap;	/* saved initial cap */
	u32			saved_port_map;	/* saved initial port_map */
	u32 			em_loc; /* enclosure management location */
};

struct ahci_port_priv {
	struct ata_link		*active_link;
	struct ahci_cmd_hdr	*cmd_slot;
	dma_addr_t		cmd_slot_dma;
	void			*cmd_tbl;
	dma_addr_t		cmd_tbl_dma;
	void			*rx_fis;
	dma_addr_t		rx_fis_dma;
	/* for NCQ spurious interrupt analysis */
	unsigned int		ncq_saw_d2h:1;
	unsigned int		ncq_saw_dmas:1;
	unsigned int		ncq_saw_sdb:1;
	u32 			intr_mask;	/* interrupts to enable */
	struct ahci_em_priv	em_priv[MAX_SLOTS];/* enclosure management info
					 	 * per PM slot */
};

static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
static int ahci_port_start(struct ata_port *ap);
static void ahci_port_stop(struct ata_port *ap);
static void ahci_qc_prep(struct ata_queued_cmd *qc);
static void ahci_freeze(struct ata_port *ap);
static void ahci_thaw(struct ata_port *ap);
static void ahci_pmp_attach(struct ata_port *ap);
static void ahci_pmp_detach(struct ata_port *ap);
static int ahci_softreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline);
static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline);
static int ahci_hardreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline);
static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
				 unsigned long deadline);
static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
				unsigned long deadline);
static void ahci_postreset(struct ata_link *link, unsigned int *class);
static void ahci_error_handler(struct ata_port *ap);
static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
static int ahci_port_resume(struct ata_port *ap);
static void ahci_dev_config(struct ata_device *dev);
static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl);
static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
			       u32 opts);
#ifdef CONFIG_PM
static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
static int ahci_pci_device_resume(struct pci_dev *pdev);
#endif
static ssize_t ahci_activity_show(struct ata_device *dev, char *buf);
static ssize_t ahci_activity_store(struct ata_device *dev,
				   enum sw_activity val);
static void ahci_init_sw_activity(struct ata_link *link);

static struct device_attribute *ahci_shost_attrs[] = {
	&dev_attr_link_power_management_policy,
	&dev_attr_em_message_type,
	&dev_attr_em_message,
	NULL
};

static struct device_attribute *ahci_sdev_attrs[] = {
	&dev_attr_sw_activity,
	NULL
};

static struct scsi_host_template ahci_sht = {
	ATA_NCQ_SHT(DRV_NAME),
	.can_queue		= AHCI_MAX_CMDS - 1,
	.sg_tablesize		= AHCI_MAX_SG,
	.dma_boundary		= AHCI_DMA_BOUNDARY,
	.shost_attrs		= ahci_shost_attrs,
	.sdev_attrs		= ahci_sdev_attrs,
};

static struct ata_port_operations ahci_ops = {
	.inherits		= &sata_pmp_port_ops,

	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
	.qc_prep		= ahci_qc_prep,
	.qc_issue		= ahci_qc_issue,
	.qc_fill_rtf		= ahci_qc_fill_rtf,

	.freeze			= ahci_freeze,
	.thaw			= ahci_thaw,
	.softreset		= ahci_softreset,
	.hardreset		= ahci_hardreset,
	.postreset		= ahci_postreset,
	.pmp_softreset		= ahci_softreset,
	.error_handler		= ahci_error_handler,
	.post_internal_cmd	= ahci_post_internal_cmd,
	.dev_config		= ahci_dev_config,

	.scr_read		= ahci_scr_read,
	.scr_write		= ahci_scr_write,
	.pmp_attach		= ahci_pmp_attach,
	.pmp_detach		= ahci_pmp_detach,

	.enable_pm		= ahci_enable_alpm,
	.disable_pm		= ahci_disable_alpm,
	.em_show		= ahci_led_show,
	.em_store		= ahci_led_store,
	.sw_activity_show	= ahci_activity_show,
	.sw_activity_store	= ahci_activity_store,
#ifdef CONFIG_PM
	.port_suspend		= ahci_port_suspend,
	.port_resume		= ahci_port_resume,
#endif
	.port_start		= ahci_port_start,
	.port_stop		= ahci_port_stop,
};

static struct ata_port_operations ahci_vt8251_ops = {
	.inherits		= &ahci_ops,
	.hardreset		= ahci_vt8251_hardreset,
};

static struct ata_port_operations ahci_p5wdh_ops = {
	.inherits		= &ahci_ops,
	.hardreset		= ahci_p5wdh_hardreset,
};

static struct ata_port_operations ahci_sb600_ops = {
	.inherits		= &ahci_ops,
	.softreset		= ahci_sb600_softreset,
	.pmp_softreset		= ahci_sb600_softreset,
};

#define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)

static const struct ata_port_info ahci_port_info[] = {
	/* board_ahci */
	{
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_ops,
	},
	/* board_ahci_vt8251 */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_vt8251_ops,
	},
	/* board_ahci_ign_iferr */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_ops,
	},
	/* board_ahci_sb600 */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
				 AHCI_HFLAG_SECT255),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_sb600_ops,
	},
	/* board_ahci_mv */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_MSI |
				 AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_ops,
	},
	/* board_ahci_sb700 */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_sb600_ops,
	},
	/* board_ahci_mcp65 */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_ops,
	},
	/* board_ahci_nopmp */
	{
		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
		.flags		= AHCI_FLAG_COMMON,
		.pio_mask	= 0x1f, /* pio0-4 */
		.udma_mask	= ATA_UDMA6,
		.port_ops	= &ahci_ops,
	},
};

static const struct pci_device_id ahci_pci_tbl[] = {
	/* Intel */
	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */

	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },

	/* ATI */
	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
	{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 }, /* ATI SB700/800 */
	{ PCI_VDEVICE(ATI, 0x4391), board_ahci_sb700 }, /* ATI SB700/800 */
	{ PCI_VDEVICE(ATI, 0x4392), board_ahci_sb700 }, /* ATI SB700/800 */
	{ PCI_VDEVICE(ATI, 0x4393), board_ahci_sb700 }, /* ATI SB700/800 */
	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800 */
	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */

	/* VIA */
	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */

	/* NVIDIA */
	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x045c), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x045d), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x045e), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x045f), board_ahci_mcp65 },	/* MCP65 */
	{ PCI_VDEVICE(NVIDIA, 0x0550), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0551), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0552), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0553), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci },		/* MCP67 */
	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f3), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f4), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f5), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f6), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f7), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f8), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07f9), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07fa), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x07fb), board_ahci },		/* MCP73 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad0), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad1), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad2), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad3), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad4), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad5), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad6), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad7), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad8), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab4), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab5), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab6), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab7), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
	{ PCI_VDEVICE(NVIDIA, 0x0bc8), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bc9), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bca), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bcb), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bcc), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bc4), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bc5), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bc6), board_ahci },		/* MCP7B */
	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */

	/* SiS */
	{ PCI_VDEVICE(SI, 0x1184), board_ahci },		/* SiS 966 */
	{ PCI_VDEVICE(SI, 0x1185), board_ahci },		/* SiS 968 */
	{ PCI_VDEVICE(SI, 0x0186), board_ahci },		/* SiS 968 */

	/* Marvell */
	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */

	/* Generic, PCI class code for AHCI */
	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

	{ }	/* terminate list */
};


static struct pci_driver ahci_pci_driver = {
	.name			= DRV_NAME,
	.id_table		= ahci_pci_tbl,
	.probe			= ahci_init_one,
	.remove			= ata_pci_remove_one,
#ifdef CONFIG_PM
	.suspend		= ahci_pci_device_suspend,
	.resume			= ahci_pci_device_resume,
#endif
};

static int ahci_em_messages = 1;
module_param(ahci_em_messages, int, 0444);
/* add other LED protocol types when they become supported */
MODULE_PARM_DESC(ahci_em_messages,
	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");

#if defined(CONFIG_PATA_MARVELL) || defined(CONFIG_PATA_MARVELL_MODULE)
static int marvell_enable;
#else
static int marvell_enable = 1;
#endif
module_param(marvell_enable, int, 0644);
MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");


static inline int ahci_nr_ports(u32 cap)
{
	return (cap & 0x1f) + 1;
}

static inline void __iomem *__ahci_port_base(struct ata_host *host,
					     unsigned int port_no)
{
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];

	return mmio + 0x100 + (port_no * 0x80);
}

static inline void __iomem *ahci_port_base(struct ata_port *ap)
{
	return __ahci_port_base(ap->host, ap->port_no);
}

static void ahci_enable_ahci(void __iomem *mmio)
{
	int i;
	u32 tmp;

	/* turn on AHCI_EN */
	tmp = readl(mmio + HOST_CTL);
	if (tmp & HOST_AHCI_EN)
		return;

	/* Some controllers need AHCI_EN to be written multiple times.
	 * Try a few times before giving up.
	 */
	for (i = 0; i < 5; i++) {
		tmp |= HOST_AHCI_EN;
		writel(tmp, mmio + HOST_CTL);
		tmp = readl(mmio + HOST_CTL);	/* flush && sanity check */
		if (tmp & HOST_AHCI_EN)
			return;
		msleep(10);
	}

	WARN_ON(1);
}

/**
 *	ahci_save_initial_config - Save and fixup initial config values
 *	@pdev: target PCI device
 *	@hpriv: host private area to store config values
 *
 *	Some registers containing configuration info might be setup by
 *	BIOS and might be cleared on reset.  This function saves the
 *	initial values of those registers into @hpriv such that they
 *	can be restored after controller reset.
 *
 *	If inconsistent, config values are fixed up by this function.
 *
 *	LOCKING:
 *	None.
 */
static void ahci_save_initial_config(struct pci_dev *pdev,
				     struct ahci_host_priv *hpriv)
{
	void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
	u32 cap, port_map;
	int i;
	int mv;

	/* make sure AHCI mode is enabled before accessing CAP */
	ahci_enable_ahci(mmio);

	/* Values prefixed with saved_ are written back to host after
	 * reset.  Values without are used for driver operation.
	 */
	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);

	/* some chips have errata preventing 64bit use */
	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
		dev_printk(KERN_INFO, &pdev->dev,
			   "controller can't do 64bit DMA, forcing 32bit\n");
		cap &= ~HOST_CAP_64;
	}

	if ((cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_NO_NCQ)) {
		dev_printk(KERN_INFO, &pdev->dev,
			   "controller can't do NCQ, turning off CAP_NCQ\n");
		cap &= ~HOST_CAP_NCQ;
	}

	if (!(cap & HOST_CAP_NCQ) && (hpriv->flags & AHCI_HFLAG_YES_NCQ)) {
		dev_printk(KERN_INFO, &pdev->dev,
			   "controller can do NCQ, turning on CAP_NCQ\n");
		cap |= HOST_CAP_NCQ;
	}

	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
		dev_printk(KERN_INFO, &pdev->dev,
			   "controller can't do PMP, turning off CAP_PMP\n");
		cap &= ~HOST_CAP_PMP;
	}

	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361 &&
	    port_map != 1) {
		dev_printk(KERN_INFO, &pdev->dev,
			   "JMB361 has only one port, port_map 0x%x -> 0x%x\n",
			   port_map, 1);
		port_map = 1;
	}

	/*
	 * Temporary Marvell 6145 hack: PATA port presence
	 * is asserted through the standard AHCI port
	 * presence register, as bit 4 (counting from 0)
	 */
	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
		if (pdev->device == 0x6121)
			mv = 0x3;
		else
			mv = 0xf;
		dev_printk(KERN_ERR, &pdev->dev,
			   "MV_AHCI HACK: port_map %x -> %x\n",
			   port_map,
			   port_map & mv);
		dev_printk(KERN_ERR, &pdev->dev,
			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");

		port_map &= mv;
	}

	/* cross check port_map and cap.n_ports */
	if (port_map) {
		int map_ports = 0;

		for (i = 0; i < AHCI_MAX_PORTS; i++)
			if (port_map & (1 << i))
				map_ports++;

		/* If PI has more ports than n_ports, whine, clear
		 * port_map and let it be generated from n_ports.
		 */
		if (map_ports > ahci_nr_ports(cap)) {
			dev_printk(KERN_WARNING, &pdev->dev,
				   "implemented port map (0x%x) contains more "
				   "ports than nr_ports (%u), using nr_ports\n",
				   port_map, ahci_nr_ports(cap));
			port_map = 0;
		}
	}

	/* fabricate port_map from cap.nr_ports */
	if (!port_map) {
		port_map = (1 << ahci_nr_ports(cap)) - 1;
		dev_printk(KERN_WARNING, &pdev->dev,
			   "forcing PORTS_IMPL to 0x%x\n", port_map);

		/* write the fixed up value to the PI register */
		hpriv->saved_port_map = port_map;
	}

	/* record values to use during operation */
	hpriv->cap = cap;
	hpriv->port_map = port_map;
}

/**
 *	ahci_restore_initial_config - Restore initial config
 *	@host: target ATA host
 *
 *	Restore initial config stored by ahci_save_initial_config().
 *
 *	LOCKING:
 *	None.
 */
static void ahci_restore_initial_config(struct ata_host *host)
{
	struct ahci_host_priv *hpriv = host->private_data;
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];

	writel(hpriv->saved_cap, mmio + HOST_CAP);
	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
}

static unsigned ahci_scr_offset(struct ata_port *ap, unsigned int sc_reg)
{
	static const int offset[] = {
		[SCR_STATUS]		= PORT_SCR_STAT,
		[SCR_CONTROL]		= PORT_SCR_CTL,
		[SCR_ERROR]		= PORT_SCR_ERR,
		[SCR_ACTIVE]		= PORT_SCR_ACT,
		[SCR_NOTIFICATION]	= PORT_SCR_NTF,
	};
	struct ahci_host_priv *hpriv = ap->host->private_data;

	if (sc_reg < ARRAY_SIZE(offset) &&
	    (sc_reg != SCR_NOTIFICATION || (hpriv->cap & HOST_CAP_SNTF)))
		return offset[sc_reg];
	return 0;
}

static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val)
{
	void __iomem *port_mmio = ahci_port_base(link->ap);
	int offset = ahci_scr_offset(link->ap, sc_reg);

	if (offset) {
		*val = readl(port_mmio + offset);
		return 0;
	}
	return -EINVAL;
}

static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
{
	void __iomem *port_mmio = ahci_port_base(link->ap);
	int offset = ahci_scr_offset(link->ap, sc_reg);

	if (offset) {
		writel(val, port_mmio + offset);
		return 0;
	}
	return -EINVAL;
}

static void ahci_start_engine(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 tmp;

	/* start DMA */
	tmp = readl(port_mmio + PORT_CMD);
	tmp |= PORT_CMD_START;
	writel(tmp, port_mmio + PORT_CMD);
	readl(port_mmio + PORT_CMD); /* flush */
}

static int ahci_stop_engine(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 tmp;

	tmp = readl(port_mmio + PORT_CMD);

	/* check if the HBA is idle */
	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
		return 0;

	/* setting HBA to idle */
	tmp &= ~PORT_CMD_START;
	writel(tmp, port_mmio + PORT_CMD);

	/* wait for engine to stop. This could be as long as 500 msec */
	tmp = ata_wait_register(port_mmio + PORT_CMD,
				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
	if (tmp & PORT_CMD_LIST_ON)
		return -EIO;

	return 0;
}

static void ahci_start_fis_rx(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ahci_host_priv *hpriv = ap->host->private_data;
	struct ahci_port_priv *pp = ap->private_data;
	u32 tmp;

	/* set FIS registers */
	if (hpriv->cap & HOST_CAP_64)
		writel((pp->cmd_slot_dma >> 16) >> 16,
		       port_mmio + PORT_LST_ADDR_HI);
	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);

	if (hpriv->cap & HOST_CAP_64)
		writel((pp->rx_fis_dma >> 16) >> 16,
		       port_mmio + PORT_FIS_ADDR_HI);
	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);

	/* enable FIS reception */
	tmp = readl(port_mmio + PORT_CMD);
	tmp |= PORT_CMD_FIS_RX;
	writel(tmp, port_mmio + PORT_CMD);

	/* flush */
	readl(port_mmio + PORT_CMD);
}

static int ahci_stop_fis_rx(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 tmp;

	/* disable FIS reception */
	tmp = readl(port_mmio + PORT_CMD);
	tmp &= ~PORT_CMD_FIS_RX;
	writel(tmp, port_mmio + PORT_CMD);

	/* wait for completion, spec says 500ms, give it 1000 */
	tmp = ata_wait_register(port_mmio + PORT_CMD, PORT_CMD_FIS_ON,
				PORT_CMD_FIS_ON, 10, 1000);
	if (tmp & PORT_CMD_FIS_ON)
		return -EBUSY;

	return 0;
}

static void ahci_power_up(struct ata_port *ap)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 cmd;

	cmd = readl(port_mmio + PORT_CMD) & ~PORT_CMD_ICC_MASK;

	/* spin up device */
	if (hpriv->cap & HOST_CAP_SSS) {
		cmd |= PORT_CMD_SPIN_UP;
		writel(cmd, port_mmio + PORT_CMD);
	}

	/* wake up link */
	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
}

static void ahci_disable_alpm(struct ata_port *ap)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 cmd;
	struct ahci_port_priv *pp = ap->private_data;

	/* IPM bits should be disabled by libata-core */
	/* get the existing command bits */
	cmd = readl(port_mmio + PORT_CMD);

	/* disable ALPM and ASP */
	cmd &= ~PORT_CMD_ASP;
	cmd &= ~PORT_CMD_ALPE;

	/* force the interface back to active */
	cmd |= PORT_CMD_ICC_ACTIVE;

	/* write out new cmd value */
	writel(cmd, port_mmio + PORT_CMD);
	cmd = readl(port_mmio + PORT_CMD);

	/* wait 10ms to be sure we've come out of any low power state */
	msleep(10);

	/* clear out any PhyRdy stuff from interrupt status */
	writel(PORT_IRQ_PHYRDY, port_mmio + PORT_IRQ_STAT);

	/* go ahead and clean out PhyRdy Change from Serror too */
	ahci_scr_write(&ap->link, SCR_ERROR, ((1 << 16) | (1 << 18)));

	/*
 	 * Clear flag to indicate that we should ignore all PhyRdy
 	 * state changes
 	 */
	hpriv->flags &= ~AHCI_HFLAG_NO_HOTPLUG;

	/*
 	 * Enable interrupts on Phy Ready.
 	 */
	pp->intr_mask |= PORT_IRQ_PHYRDY;
	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);

	/*
 	 * don't change the link pm policy - we can be called
 	 * just to turn of link pm temporarily
 	 */
}

static int ahci_enable_alpm(struct ata_port *ap,
	enum link_pm policy)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 cmd;
	struct ahci_port_priv *pp = ap->private_data;
	u32 asp;

	/* Make sure the host is capable of link power management */
	if (!(hpriv->cap & HOST_CAP_ALPM))
		return -EINVAL;

	switch (policy) {
	case MAX_PERFORMANCE:
	case NOT_AVAILABLE:
		/*
 		 * if we came here with NOT_AVAILABLE,
 		 * it just means this is the first time we
 		 * have tried to enable - default to max performance,
 		 * and let the user go to lower power modes on request.
 		 */
		ahci_disable_alpm(ap);
		return 0;
	case MIN_POWER:
		/* configure HBA to enter SLUMBER */
		asp = PORT_CMD_ASP;
		break;
	case MEDIUM_POWER:
		/* configure HBA to enter PARTIAL */
		asp = 0;
		break;
	default:
		return -EINVAL;
	}

	/*
 	 * Disable interrupts on Phy Ready. This keeps us from
 	 * getting woken up due to spurious phy ready interrupts
	 * TBD - Hot plug should be done via polling now, is
	 * that even supported?
 	 */
	pp->intr_mask &= ~PORT_IRQ_PHYRDY;
	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);

	/*
 	 * Set a flag to indicate that we should ignore all PhyRdy
 	 * state changes since these can happen now whenever we
 	 * change link state
 	 */
	hpriv->flags |= AHCI_HFLAG_NO_HOTPLUG;

	/* get the existing command bits */
	cmd = readl(port_mmio + PORT_CMD);

	/*
 	 * Set ASP based on Policy
 	 */
	cmd |= asp;

	/*
 	 * Setting this bit will instruct the HBA to aggressively
 	 * enter a lower power link state when it's appropriate and
 	 * based on the value set above for ASP
 	 */
	cmd |= PORT_CMD_ALPE;

	/* write out new cmd value */
	writel(cmd, port_mmio + PORT_CMD);
	cmd = readl(port_mmio + PORT_CMD);

	/* IPM bits should be set by libata-core */
	return 0;
}

#ifdef CONFIG_PM
static void ahci_power_down(struct ata_port *ap)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 cmd, scontrol;

	if (!(hpriv->cap & HOST_CAP_SSS))
		return;

	/* put device into listen mode, first set PxSCTL.DET to 0 */
	scontrol = readl(port_mmio + PORT_SCR_CTL);
	scontrol &= ~0xf;
	writel(scontrol, port_mmio + PORT_SCR_CTL);

	/* then set PxCMD.SUD to 0 */
	cmd = readl(port_mmio + PORT_CMD) & ~PORT_CMD_ICC_MASK;
	cmd &= ~PORT_CMD_SPIN_UP;
	writel(cmd, port_mmio + PORT_CMD);
}
#endif

static void ahci_start_port(struct ata_port *ap)
{
	struct ahci_port_priv *pp = ap->private_data;
	struct ata_link *link;
	struct ahci_em_priv *emp;

	/* enable FIS reception */
	ahci_start_fis_rx(ap);

	/* enable DMA */
	ahci_start_engine(ap);

	/* turn on LEDs */
	if (ap->flags & ATA_FLAG_EM) {
		ata_port_for_each_link(link, ap) {
			emp = &pp->em_priv[link->pmp];
			ahci_transmit_led_message(ap, emp->led_state, 4);
		}
	}

	if (ap->flags & ATA_FLAG_SW_ACTIVITY)
		ata_port_for_each_link(link, ap)
			ahci_init_sw_activity(link);

}

static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
{
	int rc;

	/* disable DMA */
	rc = ahci_stop_engine(ap);
	if (rc) {
		*emsg = "failed to stop engine";
		return rc;
	}

	/* disable FIS reception */
	rc = ahci_stop_fis_rx(ap);
	if (rc) {
		*emsg = "failed stop FIS RX";
		return rc;
	}

	return 0;
}

static int ahci_reset_controller(struct ata_host *host)
{
	struct pci_dev *pdev = to_pci_dev(host->dev);
	struct ahci_host_priv *hpriv = host->private_data;
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
	u32 tmp;

	/* we must be in AHCI mode, before using anything
	 * AHCI-specific, such as HOST_RESET.
	 */
	ahci_enable_ahci(mmio);

	/* global controller reset */
	if (!ahci_skip_host_reset) {
		tmp = readl(mmio + HOST_CTL);
		if ((tmp & HOST_RESET) == 0) {
			writel(tmp | HOST_RESET, mmio + HOST_CTL);
			readl(mmio + HOST_CTL); /* flush */
		}

		/*
		 * to perform host reset, OS should set HOST_RESET
		 * and poll until this bit is read to be "0".
		 * reset must complete within 1 second, or
		 * the hardware should be considered fried.
		 */
		tmp = ata_wait_register(mmio + HOST_CTL, HOST_RESET,
					HOST_RESET, 10, 1000);

		if (tmp & HOST_RESET) {
			dev_printk(KERN_ERR, host->dev,
				   "controller reset failed (0x%x)\n", tmp);
			return -EIO;
		}

		/* turn on AHCI mode */
		ahci_enable_ahci(mmio);

		/* Some registers might be cleared on reset.  Restore
		 * initial values.
		 */
		ahci_restore_initial_config(host);
	} else
		dev_printk(KERN_INFO, host->dev,
			   "skipping global host reset\n");

	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
		u16 tmp16;

		/* configure PCS */
		pci_read_config_word(pdev, 0x92, &tmp16);
		if ((tmp16 & hpriv->port_map) != hpriv->port_map) {
			tmp16 |= hpriv->port_map;
			pci_write_config_word(pdev, 0x92, tmp16);
		}
	}

	return 0;
}

static void ahci_sw_activity(struct ata_link *link)
{
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];

	if (!(link->flags & ATA_LFLAG_SW_ACTIVITY))
		return;

	emp->activity++;
	if (!timer_pending(&emp->timer))
		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(10));
}

static void ahci_sw_activity_blink(unsigned long arg)
{
	struct ata_link *link = (struct ata_link *)arg;
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
	unsigned long led_message = emp->led_state;
	u32 activity_led_state;

	led_message &= 0xffff0000;
	led_message |= ap->port_no | (link->pmp << 8);

	/* check to see if we've had activity.  If so,
	 * toggle state of LED and reset timer.  If not,
	 * turn LED to desired idle state.
	 */
	if (emp->saved_activity != emp->activity) {
		emp->saved_activity = emp->activity;
		/* get the current LED state */
		activity_led_state = led_message & 0x00010000;

		if (activity_led_state)
			activity_led_state = 0;
		else
			activity_led_state = 1;

		/* clear old state */
		led_message &= 0xfff8ffff;

		/* toggle state */
		led_message |= (activity_led_state << 16);
		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(100));
	} else {
		/* switch to idle */
		led_message &= 0xfff8ffff;
		if (emp->blink_policy == BLINK_OFF)
			led_message |= (1 << 16);
	}
	ahci_transmit_led_message(ap, led_message, 4);
}

static void ahci_init_sw_activity(struct ata_link *link)
{
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];

	/* init activity stats, setup timer */
	emp->saved_activity = emp->activity = 0;
	setup_timer(&emp->timer, ahci_sw_activity_blink, (unsigned long)link);

	/* check our blink policy and set flag for link if it's enabled */
	if (emp->blink_policy)
		link->flags |= ATA_LFLAG_SW_ACTIVITY;
}

static int ahci_reset_em(struct ata_host *host)
{
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
	u32 em_ctl;

	em_ctl = readl(mmio + HOST_EM_CTL);
	if ((em_ctl & EM_CTL_TM) || (em_ctl & EM_CTL_RST))
		return -EINVAL;

	writel(em_ctl | EM_CTL_RST, mmio + HOST_EM_CTL);
	return 0;
}

static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
					ssize_t size)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
	u32 em_ctl;
	u32 message[] = {0, 0};
	unsigned long flags;
	int pmp;
	struct ahci_em_priv *emp;

	/* get the slot number from the message */
	pmp = (state & 0x0000ff00) >> 8;
	if (pmp < MAX_SLOTS)
		emp = &pp->em_priv[pmp];
	else
		return -EINVAL;

	spin_lock_irqsave(ap->lock, flags);

	/*
	 * if we are still busy transmitting a previous message,
	 * do not allow
	 */
	em_ctl = readl(mmio + HOST_EM_CTL);
	if (em_ctl & EM_CTL_TM) {
		spin_unlock_irqrestore(ap->lock, flags);
		return -EINVAL;
	}

	/*
	 * create message header - this is all zero except for
	 * the message size, which is 4 bytes.
	 */
	message[0] |= (4 << 8);

	/* ignore 0:4 of byte zero, fill in port info yourself */
	message[1] = ((state & 0xfffffff0) | ap->port_no);

	/* write message to EM_LOC */
	writel(message[0], mmio + hpriv->em_loc);
	writel(message[1], mmio + hpriv->em_loc+4);

	/* save off new led state for port/slot */
	emp->led_state = message[1];

	/*
	 * tell hardware to transmit the message
	 */
	writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);

	spin_unlock_irqrestore(ap->lock, flags);
	return size;
}

static ssize_t ahci_led_show(struct ata_port *ap, char *buf)
{
	struct ahci_port_priv *pp = ap->private_data;
	struct ata_link *link;
	struct ahci_em_priv *emp;
	int rc = 0;

	ata_port_for_each_link(link, ap) {
		emp = &pp->em_priv[link->pmp];
		rc += sprintf(buf, "%lx\n", emp->led_state);
	}
	return rc;
}

static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
				size_t size)
{
	int state;
	int pmp;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp;

	state = simple_strtoul(buf, NULL, 0);

	/* get the slot number from the message */
	pmp = (state & 0x0000ff00) >> 8;
	if (pmp < MAX_SLOTS)
		emp = &pp->em_priv[pmp];
	else
		return -EINVAL;

	/* mask off the activity bits if we are in sw_activity
	 * mode, user should turn off sw_activity before setting
	 * activity led through em_message
	 */
	if (emp->blink_policy)
		state &= 0xfff8ffff;

	return ahci_transmit_led_message(ap, state, size);
}

static ssize_t ahci_activity_store(struct ata_device *dev, enum sw_activity val)
{
	struct ata_link *link = dev->link;
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
	u32 port_led_state = emp->led_state;

	/* save the desired Activity LED behavior */
	if (val == OFF) {
		/* clear LFLAG */
		link->flags &= ~(ATA_LFLAG_SW_ACTIVITY);

		/* set the LED to OFF */
		port_led_state &= 0xfff80000;
		port_led_state |= (ap->port_no | (link->pmp << 8));
		ahci_transmit_led_message(ap, port_led_state, 4);
	} else {
		link->flags |= ATA_LFLAG_SW_ACTIVITY;
		if (val == BLINK_OFF) {
			/* set LED to ON for idle */
			port_led_state &= 0xfff80000;
			port_led_state |= (ap->port_no | (link->pmp << 8));
			port_led_state |= 0x00010000; /* check this */
			ahci_transmit_led_message(ap, port_led_state, 4);
		}
	}
	emp->blink_policy = val;
	return 0;
}

static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
{
	struct ata_link *link = dev->link;
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];

	/* display the saved value of activity behavior for this
	 * disk.
	 */
	return sprintf(buf, "%d\n", emp->blink_policy);
}

static void ahci_port_init(struct pci_dev *pdev, struct ata_port *ap,
			   int port_no, void __iomem *mmio,
			   void __iomem *port_mmio)
{
	const char *emsg = NULL;
	int rc;
	u32 tmp;

	/* make sure port is not active */
	rc = ahci_deinit_port(ap, &emsg);
	if (rc)
		dev_printk(KERN_WARNING, &pdev->dev,
			   "%s (%d)\n", emsg, rc);

	/* clear SError */
	tmp = readl(port_mmio + PORT_SCR_ERR);
	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
	writel(tmp, port_mmio + PORT_SCR_ERR);

	/* clear port IRQ */
	tmp = readl(port_mmio + PORT_IRQ_STAT);
	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
	if (tmp)
		writel(tmp, port_mmio + PORT_IRQ_STAT);

	writel(1 << port_no, mmio + HOST_IRQ_STAT);
}

static void ahci_init_controller(struct ata_host *host)
{
	struct ahci_host_priv *hpriv = host->private_data;
	struct pci_dev *pdev = to_pci_dev(host->dev);
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
	int i;
	void __iomem *port_mmio;
	u32 tmp;
	int mv;

	if (hpriv->flags & AHCI_HFLAG_MV_PATA) {
		if (pdev->device == 0x6121)
			mv = 2;
		else
			mv = 4;
		port_mmio = __ahci_port_base(host, mv);

		writel(0, port_mmio + PORT_IRQ_MASK);

		/* clear port IRQ */
		tmp = readl(port_mmio + PORT_IRQ_STAT);
		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
		if (tmp)
			writel(tmp, port_mmio + PORT_IRQ_STAT);
	}

	for (i = 0; i < host->n_ports; i++) {
		struct ata_port *ap = host->ports[i];

		port_mmio = ahci_port_base(ap);
		if (ata_port_is_dummy(ap))
			continue;

		ahci_port_init(pdev, ap, i, mmio, port_mmio);
	}

	tmp = readl(mmio + HOST_CTL);
	VPRINTK("HOST_CTL 0x%x\n", tmp);
	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
	tmp = readl(mmio + HOST_CTL);
	VPRINTK("HOST_CTL 0x%x\n", tmp);
}

static void ahci_dev_config(struct ata_device *dev)
{
	struct ahci_host_priv *hpriv = dev->link->ap->host->private_data;

	if (hpriv->flags & AHCI_HFLAG_SECT255) {
		dev->max_sectors = 255;
		ata_dev_printk(dev, KERN_INFO,
			       "SB600 AHCI: limiting to 255 sectors per cmd\n");
	}
}

static unsigned int ahci_dev_classify(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ata_taskfile tf;
	u32 tmp;

	tmp = readl(port_mmio + PORT_SIG);
	tf.lbah		= (tmp >> 24)	& 0xff;
	tf.lbam		= (tmp >> 16)	& 0xff;
	tf.lbal		= (tmp >> 8)	& 0xff;
	tf.nsect	= (tmp)		& 0xff;

	return ata_dev_classify(&tf);
}

static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
			       u32 opts)
{
	dma_addr_t cmd_tbl_dma;

	cmd_tbl_dma = pp->cmd_tbl_dma + tag * AHCI_CMD_TBL_SZ;

	pp->cmd_slot[tag].opts = cpu_to_le32(opts);
	pp->cmd_slot[tag].status = 0;
	pp->cmd_slot[tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);
	pp->cmd_slot[tag].tbl_addr_hi = cpu_to_le32((cmd_tbl_dma >> 16) >> 16);
}

static int ahci_kick_engine(struct ata_port *ap, int force_restart)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ahci_host_priv *hpriv = ap->host->private_data;
	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
	u32 tmp;
	int busy, rc;

	/* do we need to kick the port? */
	busy = status & (ATA_BUSY | ATA_DRQ);
	if (!busy && !force_restart)
		return 0;

	/* stop engine */
	rc = ahci_stop_engine(ap);
	if (rc)
		goto out_restart;

	/* need to do CLO? */
	if (!busy) {
		rc = 0;
		goto out_restart;
	}

	if (!(hpriv->cap & HOST_CAP_CLO)) {
		rc = -EOPNOTSUPP;
		goto out_restart;
	}

	/* perform CLO */
	tmp = readl(port_mmio + PORT_CMD);
	tmp |= PORT_CMD_CLO;
	writel(tmp, port_mmio + PORT_CMD);

	rc = 0;
	tmp = ata_wait_register(port_mmio + PORT_CMD,
				PORT_CMD_CLO, PORT_CMD_CLO, 1, 500);
	if (tmp & PORT_CMD_CLO)
		rc = -EIO;

	/* restart engine */
 out_restart:
	ahci_start_engine(ap);
	return rc;
}

static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
				struct ata_taskfile *tf, int is_cmd, u16 flags,
				unsigned long timeout_msec)
{
	const u32 cmd_fis_len = 5; /* five dwords */
	struct ahci_port_priv *pp = ap->private_data;
	void __iomem *port_mmio = ahci_port_base(ap);
	u8 *fis = pp->cmd_tbl;
	u32 tmp;

	/* prep the command */
	ata_tf_to_fis(tf, pmp, is_cmd, fis);
	ahci_fill_cmd_slot(pp, 0, cmd_fis_len | flags | (pmp << 12));

	/* issue & wait */
	writel(1, port_mmio + PORT_CMD_ISSUE);

	if (timeout_msec) {
		tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1,
					1, timeout_msec);
		if (tmp & 0x1) {
			ahci_kick_engine(ap, 1);
			return -EBUSY;
		}
	} else
		readl(port_mmio + PORT_CMD_ISSUE);	/* flush */

	return 0;
}

static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
			     int pmp, unsigned long deadline,
			     int (*check_ready)(struct ata_link *link))
{
	struct ata_port *ap = link->ap;
	const char *reason = NULL;
	unsigned long now, msecs;
	struct ata_taskfile tf;
	int rc;

	DPRINTK("ENTER\n");

	/* prepare for SRST (AHCI-1.1 10.4.1) */
	rc = ahci_kick_engine(ap, 1);
	if (rc && rc != -EOPNOTSUPP)
		ata_link_printk(link, KERN_WARNING,
				"failed to reset engine (errno=%d)\n", rc);

	ata_tf_init(link->device, &tf);

	/* issue the first D2H Register FIS */
	msecs = 0;
	now = jiffies;
	if (time_after(now, deadline))
		msecs = jiffies_to_msecs(deadline - now);

	tf.ctl |= ATA_SRST;
	if (ahci_exec_polled_cmd(ap, pmp, &tf, 0,
				 AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY, msecs)) {
		rc = -EIO;
		reason = "1st FIS failed";
		goto fail;
	}

	/* spec says at least 5us, but be generous and sleep for 1ms */
	msleep(1);

	/* issue the second D2H Register FIS */
	tf.ctl &= ~ATA_SRST;
	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);

	/* wait for link to become ready */
	rc = ata_wait_after_reset(link, deadline, check_ready);
	/* link occupied, -ENODEV too is an error */
	if (rc) {
		reason = "device not ready";
		goto fail;
	}
	*class = ahci_dev_classify(ap);

	DPRINTK("EXIT, class=%u\n", *class);
	return 0;

 fail:
	ata_link_printk(link, KERN_ERR, "softreset failed (%s)\n", reason);
	return rc;
}

static int ahci_check_ready(struct ata_link *link)
{
	void __iomem *port_mmio = ahci_port_base(link->ap);
	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;

	return ata_check_ready(status);
}

static int ahci_softreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline)
{
	int pmp = sata_srst_pmp(link);

	DPRINTK("ENTER\n");

	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
}

static int ahci_sb600_check_ready(struct ata_link *link)
{
	void __iomem *port_mmio = ahci_port_base(link->ap);
	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);

	/*
	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
	 * which can save timeout delay.
	 */
	if (irq_status & PORT_IRQ_BAD_PMP)
		return -EIO;

	return ata_check_ready(status);
}

static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
				unsigned long deadline)
{
	struct ata_port *ap = link->ap;
	void __iomem *port_mmio = ahci_port_base(ap);
	int pmp = sata_srst_pmp(link);
	int rc;
	u32 irq_sts;

	DPRINTK("ENTER\n");

	rc = ahci_do_softreset(link, class, pmp, deadline,
			       ahci_sb600_check_ready);

	/*
	 * Soft reset fails on some ATI chips with IPMS set when PMP
	 * is enabled but SATA HDD/ODD is connected to SATA port,
	 * do soft reset again to port 0.
	 */
	if (rc == -EIO) {
		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
		if (irq_sts & PORT_IRQ_BAD_PMP) {
			ata_link_printk(link, KERN_WARNING,
					"failed due to HW bug, retry pmp=0\n");
			rc = ahci_do_softreset(link, class, 0, deadline,
					       ahci_check_ready);
		}
	}

	return rc;
}

static int ahci_hardreset(struct ata_link *link, unsigned int *class,
			  unsigned long deadline)
{
	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
	struct ata_taskfile tf;
	bool online;
	int rc;

	DPRINTK("ENTER\n");

	ahci_stop_engine(ap);

	/* clear D2H reception area to properly wait for D2H FIS */
	ata_tf_init(link->device, &tf);
	tf.command = 0x80;
	ata_tf_to_fis(&tf, 0, 0, d2h_fis);

	rc = sata_link_hardreset(link, timing, deadline, &online,
				 ahci_check_ready);

	ahci_start_engine(ap);

	if (online)
		*class = ahci_dev_classify(ap);

	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
	return rc;
}

static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
				 unsigned long deadline)
{
	struct ata_port *ap = link->ap;
	bool online;
	int rc;

	DPRINTK("ENTER\n");

	ahci_stop_engine(ap);

	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
				 deadline, &online, NULL);

	ahci_start_engine(ap);

	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);

	/* vt8251 doesn't clear BSY on signature FIS reception,
	 * request follow-up softreset.
	 */
	return online ? -EAGAIN : rc;
}

static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
				unsigned long deadline)
{
	struct ata_port *ap = link->ap;
	struct ahci_port_priv *pp = ap->private_data;
	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
	struct ata_taskfile tf;
	bool online;
	int rc;

	ahci_stop_engine(ap);

	/* clear D2H reception area to properly wait for D2H FIS */
	ata_tf_init(link->device, &tf);
	tf.command = 0x80;
	ata_tf_to_fis(&tf, 0, 0, d2h_fis);

	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
				 deadline, &online, NULL);

	ahci_start_engine(ap);

	/* The pseudo configuration device on SIMG4726 attached to
	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
	 * hardreset if no device is attached to the first downstream
	 * port && the pseudo device locks up on SRST w/ PMP==0.  To
	 * work around this, wait for !BSY only briefly.  If BSY isn't
	 * cleared, perform CLO and proceed to IDENTIFY (achieved by
	 * ATA_LFLAG_NO_SRST and ATA_LFLAG_ASSUME_ATA).
	 *
	 * Wait for two seconds.  Devices attached to downstream port
	 * which can't process the following IDENTIFY after this will
	 * have to be reset again.  For most cases, this should
	 * suffice while making probing snappish enough.
	 */
	if (online) {
		rc = ata_wait_after_reset(link, jiffies + 2 * HZ,
					  ahci_check_ready);
		if (rc)
			ahci_kick_engine(ap, 0);
	}
	return rc;
}

static void ahci_postreset(struct ata_link *link, unsigned int *class)
{
	struct ata_port *ap = link->ap;
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 new_tmp, tmp;

	ata_std_postreset(link, class);

	/* Make sure port's ATAPI bit is set appropriately */
	new_tmp = tmp = readl(port_mmio + PORT_CMD);
	if (*class == ATA_DEV_ATAPI)
		new_tmp |= PORT_CMD_ATAPI;
	else
		new_tmp &= ~PORT_CMD_ATAPI;
	if (new_tmp != tmp) {
		writel(new_tmp, port_mmio + PORT_CMD);
		readl(port_mmio + PORT_CMD); /* flush */
	}
}

static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
{
	struct scatterlist *sg;
	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
	unsigned int si;

	VPRINTK("ENTER\n");

	/*
	 * Next, the S/G list.
	 */
	for_each_sg(qc->sg, sg, qc->n_elem, si) {
		dma_addr_t addr = sg_dma_address(sg);
		u32 sg_len = sg_dma_len(sg);

		ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
		ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);
		ahci_sg[si].flags_size = cpu_to_le32(sg_len - 1);
	}

	return si;
}

static void ahci_qc_prep(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;
	struct ahci_port_priv *pp = ap->private_data;
	int is_atapi = ata_is_atapi(qc->tf.protocol);
	void *cmd_tbl;
	u32 opts;
	const u32 cmd_fis_len = 5; /* five dwords */
	unsigned int n_elem;

	/*
	 * Fill in command table information.  First, the header,
	 * a SATA Register - Host to Device command FIS.
	 */
	cmd_tbl = pp->cmd_tbl + qc->tag * AHCI_CMD_TBL_SZ;

	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, cmd_tbl);
	if (is_atapi) {
		memset(cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
		memcpy(cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, qc->dev->cdb_len);
	}

	n_elem = 0;
	if (qc->flags & ATA_QCFLAG_DMAMAP)
		n_elem = ahci_fill_sg(qc, cmd_tbl);

	/*
	 * Fill in command slot information.
	 */
	opts = cmd_fis_len | n_elem << 16 | (qc->dev->link->pmp << 12);
	if (qc->tf.flags & ATA_TFLAG_WRITE)
		opts |= AHCI_CMD_WRITE;
	if (is_atapi)
		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;

	ahci_fill_cmd_slot(pp, qc->tag, opts);
}

static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
{
	struct ahci_host_priv *hpriv = ap->host->private_data;
	struct ahci_port_priv *pp = ap->private_data;
	struct ata_eh_info *host_ehi = &ap->link.eh_info;
	struct ata_link *link = NULL;
	struct ata_queued_cmd *active_qc;
	struct ata_eh_info *active_ehi;
	u32 serror;

	/* determine active link */
	ata_port_for_each_link(link, ap)
		if (ata_link_active(link))
			break;
	if (!link)
		link = &ap->link;

	active_qc = ata_qc_from_tag(ap, link->active_tag);
	active_ehi = &link->eh_info;

	/* record irq stat */
	ata_ehi_clear_desc(host_ehi);
	ata_ehi_push_desc(host_ehi, "irq_stat 0x%08x", irq_stat);

	/* AHCI needs SError cleared; otherwise, it might lock up */
	ahci_scr_read(&ap->link, SCR_ERROR, &serror);
	ahci_scr_write(&ap->link, SCR_ERROR, serror);
	host_ehi->serror |= serror;

	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
	if (hpriv->flags & AHCI_HFLAG_IGN_IRQ_IF_ERR)
		irq_stat &= ~PORT_IRQ_IF_ERR;

	if (irq_stat & PORT_IRQ_TF_ERR) {
		/* If qc is active, charge it; otherwise, the active
		 * link.  There's no active qc on NCQ errors.  It will
		 * be determined by EH by reading log page 10h.
		 */
		if (active_qc)
			active_qc->err_mask |= AC_ERR_DEV;
		else
			active_ehi->err_mask |= AC_ERR_DEV;

		if (hpriv->flags & AHCI_HFLAG_IGN_SERR_INTERNAL)
			host_ehi->serror &= ~SERR_INTERNAL;
	}

	if (irq_stat & PORT_IRQ_UNK_FIS) {
		u32 *unk = (u32 *)(pp->rx_fis + RX_FIS_UNK);

		active_ehi->err_mask |= AC_ERR_HSM;
		active_ehi->action |= ATA_EH_RESET;
		ata_ehi_push_desc(active_ehi,
				  "unknown FIS %08x %08x %08x %08x" ,
				  unk[0], unk[1], unk[2], unk[3]);
	}

	if (sata_pmp_attached(ap) && (irq_stat & PORT_IRQ_BAD_PMP)) {
		active_ehi->err_mask |= AC_ERR_HSM;
		active_ehi->action |= ATA_EH_RESET;
		ata_ehi_push_desc(active_ehi, "incorrect PMP");
	}

	if (irq_stat & (PORT_IRQ_HBUS_ERR | PORT_IRQ_HBUS_DATA_ERR)) {
		host_ehi->err_mask |= AC_ERR_HOST_BUS;
		host_ehi->action |= ATA_EH_RESET;
		ata_ehi_push_desc(host_ehi, "host bus error");
	}

	if (irq_stat & PORT_IRQ_IF_ERR) {
		host_ehi->err_mask |= AC_ERR_ATA_BUS;
		host_ehi->action |= ATA_EH_RESET;
		ata_ehi_push_desc(host_ehi, "interface fatal error");
	}

	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
		ata_ehi_hotplugged(host_ehi);
		ata_ehi_push_desc(host_ehi, "%s",
			irq_stat & PORT_IRQ_CONNECT ?
			"connection status changed" : "PHY RDY changed");
	}

	/* okay, let's hand over to EH */

	if (irq_stat & PORT_IRQ_FREEZE)
		ata_port_freeze(ap);
	else
		ata_port_abort(ap);
}

static void ahci_port_intr(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ata_eh_info *ehi = &ap->link.eh_info;
	struct ahci_port_priv *pp = ap->private_data;
	struct ahci_host_priv *hpriv = ap->host->private_data;
	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
	u32 status, qc_active;
	int rc;

	status = readl(port_mmio + PORT_IRQ_STAT);
	writel(status, port_mmio + PORT_IRQ_STAT);

	/* ignore BAD_PMP while resetting */
	if (unlikely(resetting))
		status &= ~PORT_IRQ_BAD_PMP;

	/* If we are getting PhyRdy, this is
 	 * just a power state change, we should
 	 * clear out this, plus the PhyRdy/Comm
 	 * Wake bits from Serror
 	 */
	if ((hpriv->flags & AHCI_HFLAG_NO_HOTPLUG) &&
		(status & PORT_IRQ_PHYRDY)) {
		status &= ~PORT_IRQ_PHYRDY;
		ahci_scr_write(&ap->link, SCR_ERROR, ((1 << 16) | (1 << 18)));
	}

	if (unlikely(status & PORT_IRQ_ERROR)) {
		ahci_error_intr(ap, status);
		return;
	}

	if (status & PORT_IRQ_SDB_FIS) {
		/* If SNotification is available, leave notification
		 * handling to sata_async_notification().  If not,
		 * emulate it by snooping SDB FIS RX area.
		 *
		 * Snooping FIS RX area is probably cheaper than
		 * poking SNotification but some constrollers which
		 * implement SNotification, ICH9 for example, don't
		 * store AN SDB FIS into receive area.
		 */
		if (hpriv->cap & HOST_CAP_SNTF)
			sata_async_notification(ap);
		else {
			/* If the 'N' bit in word 0 of the FIS is set,
			 * we just received asynchronous notification.
			 * Tell libata about it.
			 */
			const __le32 *f = pp->rx_fis + RX_FIS_SDB;
			u32 f0 = le32_to_cpu(f[0]);

			if (f0 & (1 << 15))
				sata_async_notification(ap);
		}
	}

	/* pp->active_link is valid iff any command is in flight */
	if (ap->qc_active && pp->active_link->sactive)
		qc_active = readl(port_mmio + PORT_SCR_ACT);
	else
		qc_active = readl(port_mmio + PORT_CMD_ISSUE);

	rc = ata_qc_complete_multiple(ap, qc_active);

	/* while resetting, invalid completions are expected */
	if (unlikely(rc < 0 && !resetting)) {
		ehi->err_mask |= AC_ERR_HSM;
		ehi->action |= ATA_EH_RESET;
		ata_port_freeze(ap);
	}
}

static irqreturn_t ahci_interrupt(int irq, void *dev_instance)
{
	struct ata_host *host = dev_instance;
	struct ahci_host_priv *hpriv;
	unsigned int i, handled = 0;
	void __iomem *mmio;
	u32 irq_stat, irq_masked;

	VPRINTK("ENTER\n");

	hpriv = host->private_data;
	mmio = host->iomap[AHCI_PCI_BAR];

	/* sigh.  0xffffffff is a valid return from h/w */
	irq_stat = readl(mmio + HOST_IRQ_STAT);
	if (!irq_stat)
		return IRQ_NONE;

	irq_masked = irq_stat & hpriv->port_map;

	spin_lock(&host->lock);

	for (i = 0; i < host->n_ports; i++) {
		struct ata_port *ap;

		if (!(irq_masked & (1 << i)))
			continue;

		ap = host->ports[i];
		if (ap) {
			ahci_port_intr(ap);
			VPRINTK("port %u\n", i);
		} else {
			VPRINTK("port %u (no irq)\n", i);
			if (ata_ratelimit())
				dev_printk(KERN_WARNING, host->dev,
					"interrupt on disabled port %u\n", i);
		}

		handled = 1;
	}

	/* HOST_IRQ_STAT behaves as level triggered latch meaning that
	 * it should be cleared after all the port events are cleared;
	 * otherwise, it will raise a spurious interrupt after each
	 * valid one.  Please read section 10.6.2 of ahci 1.1 for more
	 * information.
	 *
	 * Also, use the unmasked value to clear interrupt as spurious
	 * pending event on a dummy port might cause screaming IRQ.
	 */
	writel(irq_stat, mmio + HOST_IRQ_STAT);

	spin_unlock(&host->lock);

	VPRINTK("EXIT\n");

	return IRQ_RETVAL(handled);
}

static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ahci_port_priv *pp = ap->private_data;

	/* Keep track of the currently active link.  It will be used
	 * in completion path to determine whether NCQ phase is in
	 * progress.
	 */
	pp->active_link = qc->dev->link;

	if (qc->tf.protocol == ATA_PROT_NCQ)
		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);

	ahci_sw_activity(qc->dev->link);

	return 0;
}

static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
{
	struct ahci_port_priv *pp = qc->ap->private_data;
	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;

	ata_tf_from_fis(d2h_fis, &qc->result_tf);
	return true;
}

static void ahci_freeze(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);

	/* turn IRQ off */
	writel(0, port_mmio + PORT_IRQ_MASK);
}

static void ahci_thaw(struct ata_port *ap)
{
	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
	void __iomem *port_mmio = ahci_port_base(ap);
	u32 tmp;
	struct ahci_port_priv *pp = ap->private_data;

	/* clear IRQ */
	tmp = readl(port_mmio + PORT_IRQ_STAT);
	writel(tmp, port_mmio + PORT_IRQ_STAT);
	writel(1 << ap->port_no, mmio + HOST_IRQ_STAT);

	/* turn IRQ back on */
	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
}

static void ahci_error_handler(struct ata_port *ap)
{
	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
		/* restart engine */
		ahci_stop_engine(ap);
		ahci_start_engine(ap);
	}

	sata_pmp_error_handler(ap);
}

static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;

	/* make DMA engine forget about the failed command */
	if (qc->flags & ATA_QCFLAG_FAILED)
		ahci_kick_engine(ap, 1);
}

static void ahci_pmp_attach(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ahci_port_priv *pp = ap->private_data;
	u32 cmd;

	cmd = readl(port_mmio + PORT_CMD);
	cmd |= PORT_CMD_PMP;
	writel(cmd, port_mmio + PORT_CMD);

	pp->intr_mask |= PORT_IRQ_BAD_PMP;
	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
}

static void ahci_pmp_detach(struct ata_port *ap)
{
	void __iomem *port_mmio = ahci_port_base(ap);
	struct ahci_port_priv *pp = ap->private_data;
	u32 cmd;

	cmd = readl(port_mmio + PORT_CMD);
	cmd &= ~PORT_CMD_PMP;
	writel(cmd, port_mmio + PORT_CMD);

	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
}

static int ahci_port_resume(struct ata_port *ap)
{
	ahci_power_up(ap);
	ahci_start_port(ap);

	if (sata_pmp_attached(ap))
		ahci_pmp_attach(ap);
	else
		ahci_pmp_detach(ap);

	return 0;
}

#ifdef CONFIG_PM
static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
{
	const char *emsg = NULL;
	int rc;

	rc = ahci_deinit_port(ap, &emsg);
	if (rc == 0)
		ahci_power_down(ap);
	else {
		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
		ahci_start_port(ap);
	}

	return rc;
}

static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
{
	struct ata_host *host = dev_get_drvdata(&pdev->dev);
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
	u32 ctl;

	if (mesg.event & PM_EVENT_SLEEP) {
		/* AHCI spec rev1.1 section 8.3.3:
		 * Software must disable interrupts prior to requesting a
		 * transition of the HBA to D3 state.
		 */
		ctl = readl(mmio + HOST_CTL);
		ctl &= ~HOST_IRQ_EN;
		writel(ctl, mmio + HOST_CTL);
		readl(mmio + HOST_CTL); /* flush */
	}

	return ata_pci_device_suspend(pdev, mesg);
}

static int ahci_pci_device_resume(struct pci_dev *pdev)
{
	struct ata_host *host = dev_get_drvdata(&pdev->dev);
	int rc;

	rc = ata_pci_device_do_resume(pdev);
	if (rc)
		return rc;

	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
		rc = ahci_reset_controller(host);
		if (rc)
			return rc;

		ahci_init_controller(host);
	}

	ata_host_resume(host);

	return 0;
}
#endif

static int ahci_port_start(struct ata_port *ap)
{
	struct device *dev = ap->host->dev;
	struct ahci_port_priv *pp;
	void *mem;
	dma_addr_t mem_dma;

	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
	if (!pp)
		return -ENOMEM;

	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
				  GFP_KERNEL);
	if (!mem)
		return -ENOMEM;
	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);

	/*
	 * First item in chunk of DMA memory: 32-slot command table,
	 * 32 bytes each in size
	 */
	pp->cmd_slot = mem;
	pp->cmd_slot_dma = mem_dma;

	mem += AHCI_CMD_SLOT_SZ;
	mem_dma += AHCI_CMD_SLOT_SZ;

	/*
	 * Second item: Received-FIS area
	 */
	pp->rx_fis = mem;
	pp->rx_fis_dma = mem_dma;

	mem += AHCI_RX_FIS_SZ;
	mem_dma += AHCI_RX_FIS_SZ;

	/*
	 * Third item: data area for storing a single command
	 * and its scatter-gather table
	 */
	pp->cmd_tbl = mem;
	pp->cmd_tbl_dma = mem_dma;

	/*
	 * Save off initial list of interrupts to be enabled.
	 * This could be changed later
	 */
	pp->intr_mask = DEF_PORT_IRQ;

	ap->private_data = pp;

	/* engage engines, captain */
	return ahci_port_resume(ap);
}

static void ahci_port_stop(struct ata_port *ap)
{
	const char *emsg = NULL;
	int rc;

	/* de-initialize port */
	rc = ahci_deinit_port(ap, &emsg);
	if (rc)
		ata_port_printk(ap, KERN_WARNING, "%s (%d)\n", emsg, rc);
}

static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
{
	int rc;

	if (using_dac &&
	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
		if (rc) {
			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
			if (rc) {
				dev_printk(KERN_ERR, &pdev->dev,
					   "64-bit DMA enable failed\n");
				return rc;
			}
		}
	} else {
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
	}
	return 0;
}

static void ahci_print_info(struct ata_host *host)
{
	struct ahci_host_priv *hpriv = host->private_data;
	struct pci_dev *pdev = to_pci_dev(host->dev);
	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
	u32 vers, cap, impl, speed;
	const char *speed_s;
	u16 cc;
	const char *scc_s;

	vers = readl(mmio + HOST_VERSION);
	cap = hpriv->cap;
	impl = hpriv->port_map;

	speed = (cap >> 20) & 0xf;
	if (speed == 1)
		speed_s = "1.5";
	else if (speed == 2)
		speed_s = "3";
	else
		speed_s = "?";

	pci_read_config_word(pdev, 0x0a, &cc);
	if (cc == PCI_CLASS_STORAGE_IDE)
		scc_s = "IDE";
	else if (cc == PCI_CLASS_STORAGE_SATA)
		scc_s = "SATA";
	else if (cc == PCI_CLASS_STORAGE_RAID)
		scc_s = "RAID";
	else
		scc_s = "unknown";

	dev_printk(KERN_INFO, &pdev->dev,
		"AHCI %02x%02x.%02x%02x "
		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
		,

		(vers >> 24) & 0xff,
		(vers >> 16) & 0xff,
		(vers >> 8) & 0xff,
		vers & 0xff,

		((cap >> 8) & 0x1f) + 1,
		(cap & 0x1f) + 1,
		speed_s,
		impl,
		scc_s);

	dev_printk(KERN_INFO, &pdev->dev,
		"flags: "
		"%s%s%s%s%s%s%s"
		"%s%s%s%s%s%s%s"
		"%s\n"
		,

		cap & (1 << 31) ? "64bit " : "",
		cap & (1 << 30) ? "ncq " : "",
		cap & (1 << 29) ? "sntf " : "",
		cap & (1 << 28) ? "ilck " : "",
		cap & (1 << 27) ? "stag " : "",
		cap & (1 << 26) ? "pm " : "",
		cap & (1 << 25) ? "led " : "",

		cap & (1 << 24) ? "clo " : "",
		cap & (1 << 19) ? "nz " : "",
		cap & (1 << 18) ? "only " : "",
		cap & (1 << 17) ? "pmp " : "",
		cap & (1 << 15) ? "pio " : "",
		cap & (1 << 14) ? "slum " : "",
		cap & (1 << 13) ? "part " : "",
		cap & (1 << 6) ? "ems ": ""
		);
}

/* On ASUS P5W DH Deluxe, the second port of PCI device 00:1f.2 is
 * hardwired to on-board SIMG 4726.  The chipset is ICH8 and doesn't
 * support PMP and the 4726 either directly exports the device
 * attached to the first downstream port or acts as a hardware storage
 * controller and emulate a single ATA device (can be RAID 0/1 or some
 * other configuration).
 *
 * When there's no device attached to the first downstream port of the
 * 4726, "Config Disk" appears, which is a pseudo ATA device to
 * configure the 4726.  However, ATA emulation of the device is very
 * lame.  It doesn't send signature D2H Reg FIS after the initial
 * hardreset, pukes on SRST w/ PMP==0 and has bunch of other issues.
 *
 * The following function works around the problem by always using
 * hardreset on the port and not depending on receiving signature FIS
 * afterward.  If signature FIS isn't received soon, ATA class is
 * assumed without follow-up softreset.
 */
static void ahci_p5wdh_workaround(struct ata_host *host)
{
	static struct dmi_system_id sysids[] = {
		{
			.ident = "P5W DH Deluxe",
			.matches = {
				DMI_MATCH(DMI_SYS_VENDOR,
					  "ASUSTEK COMPUTER INC"),
				DMI_MATCH(DMI_PRODUCT_NAME, "P5W DH Deluxe"),
			},
		},
		{ }
	};
	struct pci_dev *pdev = to_pci_dev(host->dev);

	if (pdev->bus->number == 0 && pdev->devfn == PCI_DEVFN(0x1f, 2) &&
	    dmi_check_system(sysids)) {
		struct ata_port *ap = host->ports[1];

		dev_printk(KERN_INFO, &pdev->dev, "enabling ASUS P5W DH "
			   "Deluxe on-board SIMG4726 workaround\n");

		ap->ops = &ahci_p5wdh_ops;
		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
	}
}

static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
{
	static const struct dmi_system_id broken_systems[] = {
		{
			.ident = "HP Compaq nx6310",
			.matches = {
				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nx6310"),
			},
			/* PCI slot number of the controller */
			.driver_data = (void *)0x1FUL,
		},

		{ }	/* terminate list */
	};
	const struct dmi_system_id *dmi = dmi_first_match(broken_systems);

	if (dmi) {
		unsigned long slot = (unsigned long)dmi->driver_data;
		/* apply the quirk only to on-board controllers */
		return slot == PCI_SLOT(pdev->devfn);
	}

	return false;
}

static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
{
	static int printed_version;
	unsigned int board_id = ent->driver_data;
	struct ata_port_info pi = ahci_port_info[board_id];
	const struct ata_port_info *ppi[] = { &pi, NULL };
	struct device *dev = &pdev->dev;
	struct ahci_host_priv *hpriv;
	struct ata_host *host;
	int n_ports, i, rc;

	VPRINTK("ENTER\n");

	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);

	if (!printed_version++)
		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");

	/* The AHCI driver can only drive the SATA ports, the PATA driver
	   can drive them all so if both drivers are selected make sure
	   AHCI stays out of the way */
	if (pdev->vendor == PCI_VENDOR_ID_MARVELL && !marvell_enable)
		return -ENODEV;

	/* acquire resources */
	rc = pcim_enable_device(pdev);
	if (rc)
		return rc;

	/* AHCI controllers often implement SFF compatible interface.
	 * Grab all PCI BARs just in case.
	 */
	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
	if (rc == -EBUSY)
		pcim_pin_device(pdev);
	if (rc)
		return rc;

	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
	    (pdev->device == 0x2652 || pdev->device == 0x2653)) {
		u8 map;

		/* ICH6s share the same PCI ID for both piix and ahci
		 * modes.  Enabling ahci mode while MAP indicates
		 * combined mode is a bad idea.  Yield to ata_piix.
		 */
		pci_read_config_byte(pdev, ICH_MAP, &map);
		if (map & 0x3) {
			dev_printk(KERN_INFO, &pdev->dev, "controller is in "
				   "combined mode, can't enable AHCI mode\n");
			return -ENODEV;
		}
	}

	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
	if (!hpriv)
		return -ENOMEM;
	hpriv->flags |= (unsigned long)pi.private_data;

	/* MCP65 revision A1 and A2 can't do MSI */
	if (board_id == board_ahci_mcp65 &&
	    (pdev->revision == 0xa1 || pdev->revision == 0xa2))
		hpriv->flags |= AHCI_HFLAG_NO_MSI;

	if ((hpriv->flags & AHCI_HFLAG_NO_MSI) || pci_enable_msi(pdev))
		pci_intx(pdev, 1);

	/* save initial config */
	ahci_save_initial_config(pdev, hpriv);

	/* prepare host */
	if (hpriv->cap & HOST_CAP_NCQ)
		pi.flags |= ATA_FLAG_NCQ;

	if (hpriv->cap & HOST_CAP_PMP)
		pi.flags |= ATA_FLAG_PMP;

	if (ahci_em_messages && (hpriv->cap & HOST_CAP_EMS)) {
		u8 messages;
		void __iomem *mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
		u32 em_loc = readl(mmio + HOST_EM_LOC);
		u32 em_ctl = readl(mmio + HOST_EM_CTL);

		messages = (em_ctl & 0x000f0000) >> 16;

		/* we only support LED message type right now */
		if ((messages & 0x01) && (ahci_em_messages == 1)) {
			/* store em_loc */
			hpriv->em_loc = ((em_loc >> 16) * 4);
			pi.flags |= ATA_FLAG_EM;
			if (!(em_ctl & EM_CTL_ALHD))
				pi.flags |= ATA_FLAG_SW_ACTIVITY;
		}
	}

	if (ahci_broken_system_poweroff(pdev)) {
		pi.flags |= ATA_FLAG_NO_POWEROFF_SPINDOWN;
		dev_info(&pdev->dev,
			"quirky BIOS, skipping spindown on poweroff\n");
	}

	/* CAP.NP sometimes indicate the index of the last enabled
	 * port, at other times, that of the last possible port, so
	 * determining the maximum port number requires looking at
	 * both CAP.NP and port_map.
	 */
	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));

	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
	if (!host)
		return -ENOMEM;
	host->iomap = pcim_iomap_table(pdev);
	host->private_data = hpriv;

	if (pi.flags & ATA_FLAG_EM)
		ahci_reset_em(host);

	for (i = 0; i < host->n_ports; i++) {
		struct ata_port *ap = host->ports[i];

		ata_port_pbar_desc(ap, AHCI_PCI_BAR, -1, "abar");
		ata_port_pbar_desc(ap, AHCI_PCI_BAR,
				   0x100 + ap->port_no * 0x80, "port");

		/* set initial link pm policy */
		ap->pm_policy = NOT_AVAILABLE;

		/* set enclosure management message type */
		if (ap->flags & ATA_FLAG_EM)
			ap->em_message_type = ahci_em_messages;


		/* disabled/not-implemented port */
		if (!(hpriv->port_map & (1 << i)))
			ap->ops = &ata_dummy_port_ops;
	}

	/* apply workaround for ASUS P5W DH Deluxe mainboard */
	ahci_p5wdh_workaround(host);

	/* initialize adapter */
	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
	if (rc)
		return rc;

	rc = ahci_reset_controller(host);
	if (rc)
		return rc;

	ahci_init_controller(host);
	ahci_print_info(host);

	pci_set_master(pdev);
	return ata_host_activate(host, pdev->irq, ahci_interrupt, IRQF_SHARED,
				 &ahci_sht);
}

static int __init ahci_init(void)
{
	return pci_register_driver(&ahci_pci_driver);
}

static void __exit ahci_exit(void)
{
	pci_unregister_driver(&ahci_pci_driver);
}


MODULE_AUTHOR("Jeff Garzik");
MODULE_DESCRIPTION("AHCI SATA low-level driver");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, ahci_pci_tbl);
MODULE_VERSION(DRV_VERSION);

module_init(ahci_init);
module_exit(ahci_exit);

--MP_/psv3Mff82RP9kd0QtTuxUkj
Content-Type: application/octet-stream; name=boot.msg.110529-1820
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=boot.msg.110529-1820

SW5zcGVjdGluZyAvYm9vdC9TeXN0ZW0ubWFwLTIuNi4zOS1JTUVWLTExMDQwOApDYW5ub3QgZmlu
ZCBtYXAgZmlsZS4KTm8gbW9kdWxlIHN5bWJvbHMgbG9hZGVkIC0ga2VybmVsIG1vZHVsZXMgbm90
IGVuYWJsZWQuCgpDYW5ub3QgYnVpbGQgc3ltYm9sIHRhYmxlIC0gZGlzYWJsaW5nIHN5bWJvbCBs
b29rdXBzCmtsb2dkIDEuNC4xLCBsb2cgc291cmNlID0ga3N5c2xvZyBzdGFydGVkLgo8NT5bICAg
IDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDIuNi4zOS1JTUVWLTExMDQwOCAocHJrQGltZTUpIChn
Y2MgdmVyc2lvbiA0LjMuMSAyMDA4MDUwNyAocHJlcmVsZWFzZSkgW2djYy00XzMtYnJhbmNoIHJl
dmlzaW9uIDEzNTAzNl0gKFNVU0UgTGludXgpICkgIzEgU01QIFN1biBNYXkgMjkgMTY6MDk6Mjkg
RURUIDIwMTEKPDY+WyAgICAwLjAwMDAwMF0gQ29tbWFuZCBsaW5lOiByb290PS9kZXYvZGlzay9i
eS1pZC9hdGEtV0RDX1dENTAwMEFBS0ItMDBIOEEwX1dELVdDQVNZNzU4NjQ3OS1wYXJ0MSBzcGxh
c2g9bm9uZSBzaG93b3B0cyB2Z2E9MHgzMTcKPDY+WyAgICAwLjAwMDAwMF0gQklPUy1wcm92aWRl
ZCBwaHlzaWNhbCBSQU0gbWFwOgo8Nj5bICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAw
MDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZDgwMCAodXNhYmxlKQo8Nj5bICAgIDAuMDAwMDAwXSAg
QklPUy1lODIwOiAwMDAwMDAwMDAwMDlkODAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQp
Cjw2PlsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZjAwMDAgLSAwMDAwMDAw
MDAwMTAwMDAwIChyZXNlcnZlZCkKPDY+WyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDEwMDAwMCAtIDAwMDAwMDAwZWZlZTAwMDAgKHVzYWJsZSkKPDY+WyAgICAwLjAwMDAwMF0g
IEJJT1MtZTgyMDogMDAwMDAwMDBlZmVlMDAwMCAtIDAwMDAwMDAwZWZlZTMwMDAgKEFDUEkgTlZT
KQo8Nj5bICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGVmZWUzMDAwIC0gMDAwMDAw
MDBlZmVmMDAwMCAoQUNQSSBkYXRhKQo8Nj5bICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAw
MDAwMGVmZWYwMDAwIC0gMDAwMDAwMDBlZmYwMDAwMCAocmVzZXJ2ZWQpCjw2PlsgICAgMC4wMDAw
MDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwZjAwMDAwMDAgLSAwMDAwMDAwMGY0MDAwMDAwIChyZXNl
cnZlZCkKPDY+WyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDBmZWMwMDAwMCAtIDAw
MDAwMDAxMDAwMDAwMDAgKHJlc2VydmVkKQo8Nj5bICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAw
MDAwMDAwMTAwMDAwMDAwIC0gMDAwMDAwMDExMDAwMDAwMCAodXNhYmxlKQo8Nj5bICAgIDAuMDAw
MDAwXSBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90ZWN0aW9uOiBhY3RpdmUKPDY+WyAgICAwLjAw
MDAwMF0gRE1JIDIuNCBwcmVzZW50Lgo8Nz5bICAgIDAuMDAwMDAwXSBETUk6IFN5c3RlbSBtYW51
ZmFjdHVyZXIgU3lzdGVtIFByb2R1Y3QgTmFtZS9NMk4tRSwgQklPUyBBU1VTIE0yTi1FIEFDUEkg
QklPUyBSZXZpc2lvbiAxNzAxIDEwLzMwLzIwMDgKPDc+WyAgICAwLjAwMDAwMF0gZTgyMCB1cGRh
dGUgcmFuZ2U6IDAwMDAwMDAwMDAwMDAwMDAgLSAwMDAwMDAwMDAwMDEwMDAwICh1c2FibGUpID09
PiAocmVzZXJ2ZWQpCjw3PlsgICAgMC4wMDAwMDBdIGU4MjAgcmVtb3ZlIHJhbmdlOiAwMDAwMDAw
MDAwMGEwMDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAodXNhYmxlKQo8Nj5bICAgIDAuMDAwMDAwXSBO
byBBR1AgYnJpZGdlIGZvdW5kCjw2PlsgICAgMC4wMDAwMDBdIGxhc3RfcGZuID0gMHgxMTAwMDAg
bWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKPDc+WyAgICAwLjAwMDAwMF0gTVRSUiBkZWZhdWx0
IHR5cGU6IHVuY2FjaGFibGUKPDc+WyAgICAwLjAwMDAwMF0gTVRSUiBmaXhlZCByYW5nZXMgZW5h
YmxlZDoKPDc+WyAgICAwLjAwMDAwMF0gICAwMDAwMC05RkZGRiB3cml0ZS1iYWNrCjw3PlsgICAg
MC4wMDAwMDBdICAgQTAwMDAtQkZGRkYgdW5jYWNoYWJsZQo8Nz5bICAgIDAuMDAwMDAwXSAgIEMw
MDAwLUM3RkZGIHdyaXRlLXByb3RlY3QKPDc+WyAgICAwLjAwMDAwMF0gICBDODAwMC1GRkZGRiB1
bmNhY2hhYmxlCjw3PlsgICAgMC4wMDAwMDBdIE1UUlIgdmFyaWFibGUgcmFuZ2VzIGVuYWJsZWQ6
Cjw3PlsgICAgMC4wMDAwMDBdICAgMCBiYXNlIDAwMDAwMDAwMDAgbWFzayBGRjgwMDAwMDAwIHdy
aXRlLWJhY2sKPDc+WyAgICAwLjAwMDAwMF0gICAxIGJhc2UgMDA4MDAwMDAwMCBtYXNrIEZGQzAw
MDAwMDAgd3JpdGUtYmFjawo8Nz5bICAgIDAuMDAwMDAwXSAgIDIgYmFzZSAwMEMwMDAwMDAwIG1h
c2sgRkZFMDAwMDAwMCB3cml0ZS1iYWNrCjw3PlsgICAgMC4wMDAwMDBdICAgMyBiYXNlIDAwRTAw
MDAwMDAgbWFzayBGRkYwMDAwMDAwIHdyaXRlLWJhY2sKPDc+WyAgICAwLjAwMDAwMF0gICA0IGJh
c2UgMDBFRkYwMDAwMCBtYXNrIEZGRkZGMDAwMDAgdW5jYWNoYWJsZQo8Nz5bICAgIDAuMDAwMDAw
XSAgIDUgYmFzZSAwMTAwMDAwMDAwIG1hc2sgRkZGMDAwMDAwMCB3cml0ZS1iYWNrCjw3PlsgICAg
MC4wMDAwMDBdICAgNiBkaXNhYmxlZAo8Nz5bICAgIDAuMDAwMDAwXSAgIDcgZGlzYWJsZWQKPDc+
WyAgICAwLjAwMDAwMF0gVE9NMjogMDAwMDAwMDExMDAwMDAwMCBha2EgNDM1Mk0KPDY+WyAgICAw
LjAwMDAwMF0geDg2IFBBVCBlbmFibGVkOiBjcHUgMCwgb2xkIDB4NzA0MDYwMDA3MDQwNiwgbmV3
IDB4NzAxMDYwMDA3MDEwNgo8Nz5bICAgIDAuMDAwMDAwXSBlODIwIHVwZGF0ZSByYW5nZTogMDAw
MDAwMDBlZmYwMDAwMCAtIDAwMDAwMDAxMDAwMDAwMDAgKHVzYWJsZSkgPT0+IChyZXNlcnZlZCkK
PDY+WyAgICAwLjAwMDAwMF0gbGFzdF9wZm4gPSAweGVmZWUwIG1heF9hcmNoX3BmbiA9IDB4NDAw
MDAwMDAwCjw2PlsgICAgMC4wMDAwMDBdIGZvdW5kIFNNUCBNUC10YWJsZSBhdCBbZmZmZjg4MDAw
MDBmNWFmMF0gZjVhZjAKPDc+WyAgICAwLjAwMDAwMF0gaW5pdGlhbCBtZW1vcnkgbWFwcGVkIDog
MCAtIDIwMDAwMDAwCjw3PlsgICAgMC4wMDAwMDBdIEJhc2UgbWVtb3J5IHRyYW1wb2xpbmUgYXQg
W2ZmZmY4ODAwMDAwOTgwMDBdIDk4MDAwIHNpemUgMjA0ODAKPDY+WyAgICAwLjAwMDAwMF0gaW5p
dF9tZW1vcnlfbWFwcGluZzogMDAwMDAwMDAwMDAwMDAwMC0wMDAwMDAwMGVmZWUwMDAwCjw3Plsg
ICAgMC4wMDAwMDBdICAwMDAwMDAwMDAwIC0gMDBlZmUwMDAwMCBwYWdlIDJNCjw3PlsgICAgMC4w
MDAwMDBdICAwMGVmZTAwMDAwIC0gMDBlZmVlMDAwMCBwYWdlIDRrCjw3PlsgICAgMC4wMDAwMDBd
IGtlcm5lbCBkaXJlY3QgbWFwcGluZyB0YWJsZXMgdXAgdG8gZWZlZTAwMDAgQCBlZmVkYTAwMC1l
ZmVlMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5nOiAwMDAwMDAwMTAw
MDAwMDAwLTAwMDAwMDAxMTAwMDAwMDAKPDc+WyAgICAwLjAwMDAwMF0gIDAxMDAwMDAwMDAgLSAw
MTEwMDAwMDAwIHBhZ2UgMk0KPDc+WyAgICAwLjAwMDAwMF0ga2VybmVsIGRpcmVjdCBtYXBwaW5n
IHRhYmxlcyB1cCB0byAxMTAwMDAwMDAgQCAxMGZmZmEwMDAtMTEwMDAwMDAwCjw2PlsgICAgMC4w
MDAwMDBdIFJBTURJU0s6IDM3NzczMDAwIC0gMzdmZjAwMDAKPDQ+WyAgICAwLjAwMDAwMF0gQUNQ
STogUlNEUCAwMDAwMDAwMDAwMGY3ODkwIDAwMDI0ICh2MDIgTnZpZGlhKQo8ND5bICAgIDAuMDAw
MDAwXSBBQ1BJOiBYU0RUIDAwMDAwMDAwZWZlZTMxMDAgMDAwNDQgKHYwMSBOdmlkaWEgQVNVU0FD
UEkgNDIzMDJFMzEgQVdSRCAwMDAwMDAwMCkKPDQ+WyAgICAwLjAwMDAwMF0gQUNQSTogRkFDUCAw
MDAwMDAwMGVmZWVhYzgwIDAwMEY0ICh2MDMgTnZpZGlhIEFTVVNBQ1BJIDQyMzAyRTMxIEFXUkQg
MDAwMDAwMDApCjw0PlsgICAgMC4wMDAwMDBdIEFDUEk6IERTRFQgMDAwMDAwMDBlZmVlMzI4MCAw
Nzk4QSAodjAxIE5WSURJQSBBV1JEQUNQSSAwMDAwMTAwMCBNU0ZUIDAzMDAwMDAwKQo8ND5bICAg
IDAuMDAwMDAwXSBBQ1BJOiBGQUNTIDAwMDAwMDAwZWZlZTAwMDAgMDAwNDAKPDQ+WyAgICAwLjAw
MDAwMF0gQUNQSTogSFBFVCAwMDAwMDAwMGVmZWVhZWMwIDAwMDM4ICh2MDEgTnZpZGlhIEFTVVNB
Q1BJIDQyMzAyRTMxIEFXUkQgMDAwMDAwOTgpCjw0PlsgICAgMC4wMDAwMDBdIEFDUEk6IE1DRkcg
MDAwMDAwMDBlZmVlYWY0MCAwMDAzQyAodjAxIE52aWRpYSBBU1VTQUNQSSA0MjMwMkUzMSBBV1JE
IDAwMDAwMDAwKQo8ND5bICAgIDAuMDAwMDAwXSBBQ1BJOiBBUElDIDAwMDAwMDAwZWZlZWFkYzAg
MDAwOTggKHYwMSBOdmlkaWEgQVNVU0FDUEkgNDIzMDJFMzEgQVdSRCAwMDAwMDAwMCkKPDc+WyAg
ICAwLjAwMDAwMF0gQUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVlMDAwMDAKPDc+WyAgICAw
LjAwMDAwMF0gIFtmZmZmZWEwMDAwMDAwMDAwLWZmZmZlYTAwMDNiZmZmZmZdIFBNRCAtPiBbZmZm
Zjg4MDEwMDAwMDAwMC1mZmZmODgwMTAzOWZmZmZmXSBvbiBub2RlIDAKPDQ+WyAgICAwLjAwMDAw
MF0gWm9uZSBQRk4gcmFuZ2VzOgo8ND5bICAgIDAuMDAwMDAwXSAgIERNQSAgICAgIDB4MDAwMDAw
MTAgLT4gMHgwMDAwMTAwMAo8ND5bICAgIDAuMDAwMDAwXSAgIERNQTMyICAgIDB4MDAwMDEwMDAg
LT4gMHgwMDEwMDAwMAo8ND5bICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIDB4MDAxMDAwMDAgLT4g
MHgwMDExMDAwMAo8ND5bICAgIDAuMDAwMDAwXSBNb3ZhYmxlIHpvbmUgc3RhcnQgUEZOIGZvciBl
YWNoIG5vZGUKPDQ+WyAgICAwLjAwMDAwMF0gZWFybHlfbm9kZV9tYXBbM10gYWN0aXZlIFBGTiBy
YW5nZXMKPDQ+WyAgICAwLjAwMDAwMF0gICAgIDA6IDB4MDAwMDAwMTAgLT4gMHgwMDAwMDA5ZAo8
ND5bICAgIDAuMDAwMDAwXSAgICAgMDogMHgwMDAwMDEwMCAtPiAweDAwMGVmZWUwCjw0PlsgICAg
MC4wMDAwMDBdICAgICAwOiAweDAwMTAwMDAwIC0+IDB4MDAxMTAwMDAKPDc+WyAgICAwLjAwMDAw
MF0gT24gbm9kZSAwIHRvdGFscGFnZXM6IDEwNDgxNzMKPDc+WyAgICAwLjAwMDAwMF0gICBETUEg
em9uZTogNTYgcGFnZXMgdXNlZCBmb3IgbWVtbWFwCjw3PlsgICAgMC4wMDAwMDBdICAgRE1BIHpv
bmU6IDUgcGFnZXMgcmVzZXJ2ZWQKPDc+WyAgICAwLjAwMDAwMF0gICBETUEgem9uZTogMzkyMCBw
YWdlcywgTElGTyBiYXRjaDowCjw3PlsgICAgMC4wMDAwMDBdICAgRE1BMzIgem9uZTogMTQyODAg
cGFnZXMgdXNlZCBmb3IgbWVtbWFwCjw3PlsgICAgMC4wMDAwMDBdICAgRE1BMzIgem9uZTogOTY0
Mzc2IHBhZ2VzLCBMSUZPIGJhdGNoOjMxCjw3PlsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6
IDg5NiBwYWdlcyB1c2VkIGZvciBtZW1tYXAKPDc+WyAgICAwLjAwMDAwMF0gICBOb3JtYWwgem9u
ZTogNjQ2NDAgcGFnZXMsIExJRk8gYmF0Y2g6MTUKPDY+WyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQg
dXNlIG9mIGV4dGVuZGVkIGFwaWMgaWRzIG9uIGh5cGVydHJhbnNwb3J0IGJ1cwo8Nj5bICAgIDAu
MDAwMDAwXSBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0OiAweDEwMDgKPDc+WyAgICAwLjAwMDAwMF0g
QUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVlMDAwMDAKPDY+WyAgICAwLjAwMDAwMF0gQUNQ
STogTEFQSUMgKGFjcGlfaWRbMHgwMF0gbGFwaWNfaWRbMHgwMF0gZW5hYmxlZCkKPDY+WyAgICAw
LjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMV0gbGFwaWNfaWRbMHgwMV0gZW5hYmxl
ZCkKPDY+WyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMl0gbGFwaWNfaWRb
MHgwMl0gZGlzYWJsZWQpCjw2PlsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDIChhY3BpX2lkWzB4
MDNdIGxhcGljX2lkWzB4MDNdIGRpc2FibGVkKQo8Nj5bICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJ
Q19OTUkgKGFjcGlfaWRbMHgwMF0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKPDY+WyAgICAwLjAwMDAw
MF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDFdIGhpZ2ggZWRnZSBsaW50WzB4MV0pCjw2
PlsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAyXSBoaWdoIGVkZ2Ug
bGludFsweDFdKQo8Nj5bICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgw
M10gaGlnaCBlZGdlIGxpbnRbMHgxXSkKPDY+WyAgICAwLjAwMDAwMF0gQUNQSTogSU9BUElDIChp
ZFsweDA0XSBhZGRyZXNzWzB4ZmVjMDAwMDBdIGdzaV9iYXNlWzBdKQo8Nj5bICAgIDAuMDAwMDAw
XSBJT0FQSUNbMF06IGFwaWNfaWQgNCwgdmVyc2lvbiAxNywgYWRkcmVzcyAweGZlYzAwMDAwLCBH
U0kgMC0yMwo8Nj5bICAgIDAuMDAwMDAwXSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2ly
cSAwIGdsb2JhbF9pcnEgMiBkZmwgZGZsKQo8Nj5bICAgIDAuMDAwMDAwXSBBQ1BJOiBJTlRfU1JD
X09WUiAoYnVzIDAgYnVzX2lycSA5IGdsb2JhbF9pcnEgOSBoaWdoIGxldmVsKQo8Nj5bICAgIDAu
MDAwMDAwXSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSAxNCBnbG9iYWxfaXJxIDE0
IGhpZ2ggZWRnZSkKPDY+WyAgICAwLjAwMDAwMF0gQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1
c19pcnEgMTUgZ2xvYmFsX2lycSAxNSBoaWdoIGVkZ2UpCjw3PlsgICAgMC4wMDAwMDBdIEFDUEk6
IElSUTAgdXNlZCBieSBvdmVycmlkZS4KPDc+WyAgICAwLjAwMDAwMF0gQUNQSTogSVJRMiB1c2Vk
IGJ5IG92ZXJyaWRlLgo8Nz5bICAgIDAuMDAwMDAwXSBBQ1BJOiBJUlE5IHVzZWQgYnkgb3ZlcnJp
ZGUuCjw3PlsgICAgMC4wMDAwMDBdIEFDUEk6IElSUTE0IHVzZWQgYnkgb3ZlcnJpZGUuCjw3Plsg
ICAgMC4wMDAwMDBdIEFDUEk6IElSUTE1IHVzZWQgYnkgb3ZlcnJpZGUuCjw2PlsgICAgMC4wMDAw
MDBdIFVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgo8
Nj5bICAgIDAuMDAwMDAwXSBBQ1BJOiBIUEVUIGlkOiAweDEwZGU4MjAxIGJhc2U6IDB4ZmVmZmYw
MDAKPDY+WyAgICAwLjAwMDAwMF0gU01QOiBBbGxvd2luZyA0IENQVXMsIDIgaG90cGx1ZyBDUFVz
Cjw3PlsgICAgMC4wMDAwMDBdIG5yX2lycXNfZ3NpOiA0MAo8Nj5bICAgIDAuMDAwMDAwXSBQTTog
UmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMDAwMDlkMDAwIC0gMDAwMDAwMDAwMDA5
ZTAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAw
MDAwMDAwMDllMDAwIC0gMDAwMDAwMDAwMDBhMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVn
aXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMDAwMGEwMDAwIC0gMDAwMDAwMDAwMDBmMDAw
MAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAw
MDAwMGYwMDAwIC0gMDAwMDAwMDAwMDEwMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0
ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMGVmZWUwMDAwIC0gMDAwMDAwMDBlZmVlMzAwMAo8
Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMGVm
ZWUzMDAwIC0gMDAwMDAwMDBlZmVmMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJl
ZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMGVmZWYwMDAwIC0gMDAwMDAwMDBlZmYwMDAwMAo8Nj5b
ICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMGVmZjAw
MDAwIC0gMDAwMDAwMDBmMDAwMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBu
b3NhdmUgbWVtb3J5OiAwMDAwMDAwMGYwMDAwMDAwIC0gMDAwMDAwMDBmNDAwMDAwMAo8Nj5bICAg
IDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiAwMDAwMDAwMGY0MDAwMDAw
IC0gMDAwMDAwMDBmZWMwMDAwMAo8Nj5bICAgIDAuMDAwMDAwXSBQTTogUmVnaXN0ZXJlZCBub3Nh
dmUgbWVtb3J5OiAwMDAwMDAwMGZlYzAwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMAo8Nj5bICAgIDAu
MDAwMDAwXSBBbGxvY2F0aW5nIFBDSSByZXNvdXJjZXMgc3RhcnRpbmcgYXQgZjQwMDAwMDAgKGdh
cDogZjQwMDAwMDA6YWMwMDAwMCkKPDY+WyAgICAwLjAwMDAwMF0gc2V0dXBfcGVyY3B1OiBOUl9D
UFVTOjggbnJfY3B1bWFza19iaXRzOjggbnJfY3B1X2lkczo0IG5yX25vZGVfaWRzOjEKPDY+WyAg
ICAwLjAwMDAwMF0gUEVSQ1BVOiBFbWJlZGRlZCAyNiBwYWdlcy9jcHUgQGZmZmY4ODAxMGZjMDAw
MDAgczczOTIwIHI4MTkyIGQyNDM4NCB1NTI0Mjg4Cjw3PlsgICAgMC4wMDAwMDBdIHBjcHUtYWxs
b2M6IHM3MzkyMCByODE5MiBkMjQzODQgdTUyNDI4OCBhbGxvYz0xKjIwOTcxNTIKPDc+WyAgICAw
LjAwMDAwMF0gcGNwdS1hbGxvYzogWzBdIDAgMSAyIDMgCjw0PlsgICAgMC4wMDAwMDBdIEJ1aWx0
IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwg
cGFnZXM6IDEwMzI5MzYKPDU+WyAgICAwLjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGluZTogcm9v
dD0vZGV2L2Rpc2svYnktaWQvYXRhLVdEQ19XRDUwMDBBQUtCLTAwSDhBMF9XRC1XQ0FTWTc1ODY0
NzktcGFydDEgc3BsYXNoPW5vbmUgc2hvd29wdHMgdmdhPTB4MzE3Cjw2PlsgICAgMC4wMDAwMDBd
IFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykKPDY+
WyAgICAwLjAwMDAwMF0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTI0Mjg4IChv
cmRlcjogMTAsIDQxOTQzMDQgYnl0ZXMpCjw2PlsgICAgMC4wMDAwMDBdIElub2RlLWNhY2hlIGhh
c2ggdGFibGUgZW50cmllczogMjYyMTQ0IChvcmRlcjogOSwgMjA5NzE1MiBieXRlcykKPDY+WyAg
ICAwLjAwMDAwMF0gQ2hlY2tpbmcgYXBlcnR1cmUuLi4KPDY+WyAgICAwLjAwMDAwMF0gTm8gQUdQ
IGJyaWRnZSBmb3VuZAo8Nj5bICAgIDAuMDAwMDAwXSBOb2RlIDA6IGFwZXJ0dXJlIEAgZTAwMDAw
MDAgc2l6ZSAzMiBNQgo8Nj5bICAgIDAuMDAwMDAwXSBBcGVydHVyZSBwb2ludGluZyB0byBlODIw
IFJBTS4gSWdub3JpbmcuCjw2PlsgICAgMC4wMDAwMDBdIFlvdXIgQklPUyBkb2Vzbid0IGxlYXZl
IGEgYXBlcnR1cmUgbWVtb3J5IGhvbGUKPDY+WyAgICAwLjAwMDAwMF0gUGxlYXNlIGVuYWJsZSB0
aGUgSU9NTVUgb3B0aW9uIGluIHRoZSBCSU9TIHNldHVwCjw2PlsgICAgMC4wMDAwMDBdIFRoaXMg
Y29zdHMgeW91IDY0IE1CIG9mIFJBTQo8Nj5bICAgIDAuMDAwMDAwXSBNYXBwaW5nIGFwZXJ0dXJl
IG92ZXIgNjU1MzYgS0Igb2YgUkFNIEAgZTAwMDAwMDAKPDY+WyAgICAwLjAwMDAwMF0gUE06IFJl
Z2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogMDAwMDAwMDBlMDAwMDAwMCAtIDAwMDAwMDAwZTQwMDAw
MDAKPDY+WyAgICAwLjAwMDAwMF0gTWVtb3J5OiAzOTc2MzA0ay80NDU2NDQ4ayBhdmFpbGFibGUg
KDQxOTZrIGtlcm5lbCBjb2RlLCAyNjM3NTZrIGFic2VudCwgMjE2Mzg4ayByZXNlcnZlZCwgNDM3
NGsgZGF0YSwgNTM2ayBpbml0KQo8Nj5bICAgIDAuMDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGlt
cGxlbWVudGF0aW9uLgo8Nj5bICAgIDAuMDAwMDAwXSAJQ09ORklHX1JDVV9GQU5PVVQgc2V0IHRv
IG5vbi1kZWZhdWx0IHZhbHVlIG9mIDMyCjw2PlsgICAgMC4wMDAwMDBdIAlSQ1UtYmFzZWQgZGV0
ZWN0aW9uIG9mIHN0YWxsZWQgQ1BVcyBpcyBkaXNhYmxlZC4KPDY+WyAgICAwLjAwMDAwMF0gTlJf
SVJRUzo0MzUyIG5yX2lycXM6NzEyIDE2Cjw2PlsgICAgMC4wMDAwMDBdIEV4dGVuZGVkIENNT1Mg
eWVhcjogMjAwMAo8Nz5bICAgIDAuMDAwMDAwXSBzcHVyaW91cyA4MjU5QSBpbnRlcnJ1cHQ6IElS
UTcuCjw2PlsgICAgMC4wMDAwMDBdIENvbnNvbGU6IGNvbG91ciBkdW1teSBkZXZpY2UgODB4MjUK
PDY+WyAgICAwLjAwMDAwMF0gY29uc29sZSBbdHR5MF0gZW5hYmxlZAo8Nz5bICAgIDAuMDAwMDAw
XSBocGV0IGNsb2NrZXZlbnQgcmVnaXN0ZXJlZAo8ND5bICAgIDAuMDAwMDAwXSBGYXN0IFRTQyBj
YWxpYnJhdGlvbiB1c2luZyBQSVQKPDQ+WyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQgMjUxMS41MTIg
TUh6IHByb2Nlc3Nvci4KPDY+WyAgICAwLjAwMDAwMF0gTWFya2luZyBUU0MgdW5zdGFibGUgZHVl
IHRvIFRTQ3MgdW5zeW5jaHJvbml6ZWQKPDY+WyAgICAwLjAwMTAwNl0gQ2FsaWJyYXRpbmcgZGVs
YXkgbG9vcCAoc2tpcHBlZCksIHZhbHVlIGNhbGN1bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5
Li4gNTAyMy4wMiBCb2dvTUlQUyAobHBqPTI1MTE1MTIpCjw2PlsgICAgMC4wMDEwMTNdIHBpZF9t
YXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQo8Nj5bICAgIDAuMDAxMDUzXSBTZWN1cml0
eSBGcmFtZXdvcmsgaW5pdGlhbGl6ZWQKPDY+WyAgICAwLjAwMTA3MF0gU0VMaW51eDogIERpc2Fi
bGVkIGF0IGJvb3QuCjw2PlsgICAgMC4wMDEwODddIE1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50
cmllczogMjU2Cjw3PlsgICAgMC4wMDExOTJdIHRzZWc6IDAwZWZmMDAwMDAKPDY+WyAgICAwLjAw
MTE5NF0gQ1BVOiBQaHlzaWNhbCBQcm9jZXNzb3IgSUQ6IDAKPDY+WyAgICAwLjAwMTE5N10gQ1BV
OiBQcm9jZXNzb3IgQ29yZSBJRDogMAo8Nj5bICAgIDAuMDAxMjAwXSBtY2U6IENQVSBzdXBwb3J0
cyA1IE1DRSBiYW5rcwo8Nj5bICAgIDAuMDAxMjEwXSB1c2luZyBDMUUgYXdhcmUgaWRsZSByb3V0
aW5lCjw2PlsgICAgMC4wMDEyNDBdIEFDUEk6IENvcmUgcmV2aXNpb24gMjAxMTAzMTYKPDY+WyAg
ICAwLjAwNjA3NV0gU2V0dGluZyBBUElDIHJvdXRpbmcgdG8gZmxhdAo8Nj5bICAgIDAuMDA2NTA4
XSAuLlRJTUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBpbjE9MiBhcGljMj0tMSBwaW4yPS0xCjw2
PlsgICAgMC4wMTcwMDZdIENQVTA6IEFNRCBBdGhsb24odG0pIDY0IFgyIER1YWwgQ29yZSBQcm9j
ZXNzb3IgNDgwMCsgc3RlcHBpbmcgMDIKPDY+WyAgICAwLjAxNzk5OF0gUGVyZm9ybWFuY2UgRXZl
bnRzOiBBTUQgUE1VIGRyaXZlci4KPDY+WyAgICAwLjAxNzk5OF0gLi4uIHZlcnNpb246ICAgICAg
ICAgICAgICAgIDAKPDY+WyAgICAwLjAxNzk5OF0gLi4uIGJpdCB3aWR0aDogICAgICAgICAgICAg
IDQ4Cjw2PlsgICAgMC4wMTc5OThdIC4uLiBnZW5lcmljIHJlZ2lzdGVyczogICAgICA0Cjw2Plsg
ICAgMC4wMTc5OThdIC4uLiB2YWx1ZSBtYXNrOiAgICAgICAgICAgICAwMDAwZmZmZmZmZmZmZmZm
Cjw2PlsgICAgMC4wMTc5OThdIC4uLiBtYXggcGVyaW9kOiAgICAgICAgICAgICAwMDAwN2ZmZmZm
ZmZmZmZmCjw2PlsgICAgMC4wMTc5OThdIC4uLiBmaXhlZC1wdXJwb3NlIGV2ZW50czogICAwCjw2
PlsgICAgMC4wMTc5OThdIC4uLiBldmVudCBtYXNrOiAgICAgICAgICAgICAwMDAwMDAwMDAwMDAw
MDBmCjw2PlsgICAgMC4wMTc5OThdIE1DRTogSW4ta2VybmVsIE1DRSBkZWNvZGluZyBlbmFibGVk
Lgo8Nj5bICAgIDAuMDE3OTk4XSBCb290aW5nIE5vZGUgICAwLCBQcm9jZXNzb3JzICAjMQo8Nz5b
ICAgIDAuMDE3OTk4XSBzbXBib290IGNwdSAxOiBzdGFydF9pcCA9IDk4MDAwCjw2PlsgICAgMC4w
MDE5OTldIFN5c3RlbSBoYXMgQU1EIEMxRSBlbmFibGVkCjw2PlsgICAgMC4wMDE5OTldIFN3aXRj
aCB0byBicm9hZGNhc3QgbW9kZSBvbiBDUFUxCjw2PlsgICAgMC4wODgwOTZdIEJyb3VnaHQgdXAg
MiBDUFVzCjw2PlsgICAgMC4wODgxMDJdIFRvdGFsIG9mIDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQg
KDEwMDQ1LjkwIEJvZ29NSVBTKS4KPDY+WyAgICAwLjA4ODQzN10gZGV2dG1wZnM6IGluaXRpYWxp
emVkCjw2PlsgICAgMC4wODg0MzddIFN3aXRjaCB0byBicm9hZGNhc3QgbW9kZSBvbiBDUFUwCjw2
PlsgICAgMC4wODg0MzddIFBNOiBSZWdpc3RlcmluZyBBQ1BJIE5WUyByZWdpb24gYXQgZWZlZTAw
MDAgKDEyMjg4IGJ5dGVzKQo8Nj5bICAgIDAuMDg4NDM3XSBwcmludF9jb25zdHJhaW50czogZHVt
bXk6IAo8Nj5bICAgIDAuMDg4NDM3XSBUaW1lOiAyMjoxODo0NyAgRGF0ZTogMDUvMjkvMTEKPDY+
WyAgICAwLjA4ODQzN10gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgo8Nz5bICAg
IDAuMDg4NDM3XSBub2RlIDAgbGluayAwOiBpbyBwb3J0IFs5MDAwLCBmZmZmXQo8Nj5bICAgIDAu
MDg4NDM3XSBUT006IDAwMDAwMDAwZjAwMDAwMDAgYWthIDM4NDBNCjw3PlsgICAgMC4wODg0Mzdd
IG5vZGUgMCBsaW5rIDA6IG1taW8gW2EwMDAwLCBiZmZmZl0KPDc+WyAgICAwLjA4ODQzN10gbm9k
ZSAwIGxpbmsgMDogbW1pbyBbZjAwMDAwMDAsIGVmZmZmZmZmXQo8Nz5bICAgIDAuMDg4NDM3XSBu
b2RlIDAgbGluayAwOiBtbWlvIFtmNDAwMDAwMCwgZmUwMmZmZmZdCjw3PlsgICAgMC4wODg0Mzdd
IG5vZGUgMCBsaW5rIDA6IG1taW8gW2YwMDAwMDAwLCBmMDlmZmZmZl0KPDY+WyAgICAwLjA4ODQz
N10gVE9NMjogMDAwMDAwMDExMDAwMDAwMCBha2EgNDM1Mk0KPDc+WyAgICAwLjA4ODQzN10gYnVz
OiBbMDAsIDA5XSBvbiBub2RlIDAgbGluayAwCjw3PlsgICAgMC4wODg0MzddIGJ1czogMDAgaW5k
ZXggMCBbaW8gIDB4MDAwMC0weGZmZmZdCjw3PlsgICAgMC4wODg0MzddIGJ1czogMDAgaW5kZXgg
MSBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZl0KPDc+WyAgICAwLjA4ODQzN10gYnVzOiAwMCBp
bmRleCAyIFttZW0gMHhmMGEwMDAwMC0weGZmZmZmZmZmXQo8Nz5bICAgIDAuMDg4NDM3XSBidXM6
IDAwIGluZGV4IDMgW21lbSAweGYwMDAwMDAwLTB4ZjA5ZmZmZmZdCjw3PlsgICAgMC4wODg0Mzdd
IGJ1czogMDAgaW5kZXggNCBbbWVtIDB4MTEwMDAwMDAwLTB4ZmNmZmZmZmZmZl0KPDY+WyAgICAw
LjA4ODQzN10gQUNQSTogYnVzIHR5cGUgcGNpIHJlZ2lzdGVyZWQKPDY+WyAgICAwLjA4ODQzN10g
UENJOiBNTUNPTkZJRyBmb3IgZG9tYWluIDAwMDAgW2J1cyAwMC0zZl0gYXQgW21lbSAweGYwMDAw
MDAwLTB4ZjNmZmZmZmZdIChiYXNlIDB4ZjAwMDAwMDApCjw2PlsgICAgMC4wODg0MzddIFBDSTog
TU1DT05GSUcgYXQgW21lbSAweGYwMDAwMDAwLTB4ZjNmZmZmZmZdIHJlc2VydmVkIGluIEU4MjAK
PDY+WyAgICAwLjA5NDI0OF0gUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMSBmb3IgYmFz
ZSBhY2Nlc3MKPDY+WyAgICAwLjA5NDc1NV0gYmlvOiBjcmVhdGUgc2xhYiA8YmlvLTA+IGF0IDAK
PDc+WyAgICAwLjA5NjM4M10gQUNQSTogRUM6IExvb2sgdXAgRUMgaW4gRFNEVAo8Nj5bICAgIDAu
MTAyMjEyXSBBQ1BJOiBJbnRlcnByZXRlciBlbmFibGVkCjw2PlsgICAgMC4xMDIyMjJdIEFDUEk6
IChzdXBwb3J0cyBTMCBTMSBTMyBTNCBTNSkKPDY+WyAgICAwLjEwMjI0Nl0gQUNQSTogVXNpbmcg
SU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwo8Nj5bICAgIDAuMTA4MTUzXSBBQ1BJOiBObyBk
b2NrIGRldmljZXMgZm91bmQuCjw2PlsgICAgMC4xMDgxNjJdIFBDSTogVXNpbmcgaG9zdCBicmlk
Z2Ugd2luZG93cyBmcm9tIEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlICJwY2k9bm9jcnMiIGFuZCBy
ZXBvcnQgYSBidWcKPDY+WyAgICAwLjEwODIyOF0gQUNQSTogUENJIFJvb3QgQnJpZGdlIFtQQ0kw
XSAoZG9tYWluIDAwMDAgW2J1cyAwMC1mZl0pCjw2PlsgICAgMC4xMDgzMzZdIHBjaV9yb290IFBO
UDBBMDg6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MDAwMC0weDBjZjddCjw2PlsgICAg
MC4xMDgzNDFdIHBjaV9yb290IFBOUDBBMDg6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4
MGQwMC0weGZmZmZdCjw2PlsgICAgMC4xMDgzNDVdIHBjaV9yb290IFBOUDBBMDg6MDA6IGhvc3Qg
YnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZl0KPDY+WyAgICAwLjEwODM1
MF0gcGNpX3Jvb3QgUE5QMEEwODowMDogaG9zdCBicmlkZ2Ugd2luZG93IFttZW0gMHgwMDBjMDAw
MC0weDAwMGRmZmZmXQo8Nj5bICAgIDAuMTA4MzU1XSBwY2lfcm9vdCBQTlAwQTA4OjAwOiBob3N0
IGJyaWRnZSB3aW5kb3cgW21lbSAweGVmZjAwMDAwLTB4ZmViZmZmZmZdCjw3PlsgICAgMC4xMDgz
ODRdIHBjaSAwMDAwOjAwOjAwLjA6IFsxMGRlOjAzNjldIHR5cGUgMCBjbGFzcyAweDAwMDUwMAo8
Nz5bICAgIDAuMTA4NTM0XSBwY2kgMDAwMDowMDowMS4wOiBbMTBkZTowMzYwXSB0eXBlIDAgY2xh
c3MgMHgwMDA2MDEKPDc+WyAgICAwLjEwODU2NV0gcGNpIDAwMDA6MDA6MDEuMTogWzEwZGU6MDM2
OF0gdHlwZSAwIGNsYXNzIDB4MDAwYzA1Cjw3PlsgICAgMC4xMDg1NzZdIHBjaSAwMDAwOjAwOjAx
LjE6IHJlZyAxMDogW2lvICAweGZmMDAtMHhmZjNmXQo8Nz5bICAgIDAuMTA4NTkxXSBwY2kgMDAw
MDowMDowMS4xOiByZWcgMjA6IFtpbyAgMHgxYzAwLTB4MWMzZl0KPDc+WyAgICAwLjEwODU5N10g
cGNpIDAwMDA6MDA6MDEuMTogcmVnIDI0OiBbaW8gIDB4MWM0MC0weDFjN2ZdCjw3PlsgICAgMC4x
MDg2MTddIHBjaSAwMDAwOjAwOjAxLjE6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QgRDNjb2xk
Cjw3PlsgICAgMC4xMDg2MjJdIHBjaSAwMDAwOjAwOjAxLjE6IFBNRSMgZGlzYWJsZWQKPDc+WyAg
ICAwLjEwODYzOF0gcGNpIDAwMDA6MDA6MDIuMDogWzEwZGU6MDM2Y10gdHlwZSAwIGNsYXNzIDB4
MDAwYzAzCjw3PlsgICAgMC4xMDg2NDVdIHBjaSAwMDAwOjAwOjAyLjA6IHJlZyAxMDogW21lbSAw
eGZlMDJmMDAwLTB4ZmUwMmZmZmZdCjw3PlsgICAgMC4xMDg2NjhdIHBjaSAwMDAwOjAwOjAyLjA6
IHN1cHBvcnRzIEQxIEQyCjw3PlsgICAgMC4xMDg2NzBdIHBjaSAwMDAwOjAwOjAyLjA6IFBNRSMg
c3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMDg2NzNdIHBj
aSAwMDAwOjAwOjAyLjA6IFBNRSMgZGlzYWJsZWQKPDc+WyAgICAwLjEwODY4Ml0gcGNpIDAwMDA6
MDA6MDIuMTogWzEwZGU6MDM2ZF0gdHlwZSAwIGNsYXNzIDB4MDAwYzAzCjw3PlsgICAgMC4xMDg2
ODldIHBjaSAwMDAwOjAwOjAyLjE6IHJlZyAxMDogW21lbSAweGZlMDJlMDAwLTB4ZmUwMmUwZmZd
Cjw3PlsgICAgMC4xMDg3MTFdIHBjaSAwMDAwOjAwOjAyLjE6IHN1cHBvcnRzIEQxIEQyCjw3Plsg
ICAgMC4xMDg3MTNdIHBjaSAwMDAwOjAwOjAyLjE6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEg
RDIgRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMDg3MTZdIHBjaSAwMDAwOjAwOjAyLjE6IFBNRSMg
ZGlzYWJsZWQKPDc+WyAgICAwLjEwODczMV0gcGNpIDAwMDA6MDA6MDQuMDogWzEwZGU6MDM2ZV0g
dHlwZSAwIGNsYXNzIDB4MDAwMTAxCjw3PlsgICAgMC4xMDg3NDVdIHBjaSAwMDAwOjAwOjA0LjA6
IHJlZyAyMDogW2lvICAweGZjMDAtMHhmYzBmXQo8Nz5bICAgIDAuMTA4NzYzXSBwY2kgMDAwMDow
MDowNS4wOiBbMTBkZTowMzdmXSB0eXBlIDAgY2xhc3MgMHgwMDAxMDEKPDc+WyAgICAwLjEwODc3
MV0gcGNpIDAwMDA6MDA6MDUuMDogcmVnIDEwOiBbaW8gIDB4MDlmMC0weDA5ZjddCjw3PlsgICAg
MC4xMDg3NzVdIHBjaSAwMDAwOjAwOjA1LjA6IHJlZyAxNDogW2lvICAweDBiZjAtMHgwYmYzXQo8
Nz5bICAgIDAuMTA4Nzc5XSBwY2kgMDAwMDowMDowNS4wOiByZWcgMTg6IFtpbyAgMHgwOTcwLTB4
MDk3N10KPDc+WyAgICAwLjEwODc4M10gcGNpIDAwMDA6MDA6MDUuMDogcmVnIDFjOiBbaW8gIDB4
MGI3MC0weDBiNzNdCjw3PlsgICAgMC4xMDg3ODddIHBjaSAwMDAwOjAwOjA1LjA6IHJlZyAyMDog
W2lvICAweGY3MDAtMHhmNzBmXQo8Nz5bICAgIDAuMTA4NzkxXSBwY2kgMDAwMDowMDowNS4wOiBy
ZWcgMjQ6IFttZW0gMHhmZTAyZDAwMC0weGZlMDJkZmZmXQo8Nz5bICAgIDAuMTA4ODExXSBwY2kg
MDAwMDowMDowNS4xOiBbMTBkZTowMzdmXSB0eXBlIDAgY2xhc3MgMHgwMDAxMDEKPDc+WyAgICAw
LjEwODgxOV0gcGNpIDAwMDA6MDA6MDUuMTogcmVnIDEwOiBbaW8gIDB4MDllMC0weDA5ZTddCjw3
PlsgICAgMC4xMDg4MjNdIHBjaSAwMDAwOjAwOjA1LjE6IHJlZyAxNDogW2lvICAweDBiZTAtMHgw
YmUzXQo8Nz5bICAgIDAuMTA4ODI3XSBwY2kgMDAwMDowMDowNS4xOiByZWcgMTg6IFtpbyAgMHgw
OTYwLTB4MDk2N10KPDc+WyAgICAwLjEwODgzMV0gcGNpIDAwMDA6MDA6MDUuMTogcmVnIDFjOiBb
aW8gIDB4MGI2MC0weDBiNjNdCjw3PlsgICAgMC4xMDg4MzVdIHBjaSAwMDAwOjAwOjA1LjE6IHJl
ZyAyMDogW2lvICAweGYyMDAtMHhmMjBmXQo8Nz5bICAgIDAuMTA4ODM5XSBwY2kgMDAwMDowMDow
NS4xOiByZWcgMjQ6IFttZW0gMHhmZTAyYzAwMC0weGZlMDJjZmZmXQo8Nz5bICAgIDAuMTA4ODU5
XSBwY2kgMDAwMDowMDowNS4yOiBbMTBkZTowMzdmXSB0eXBlIDAgY2xhc3MgMHgwMDAxMDEKPDc+
WyAgICAwLjEwODg2N10gcGNpIDAwMDA6MDA6MDUuMjogcmVnIDEwOiBbaW8gIDB4ZjEwMC0weGYx
MDddCjw3PlsgICAgMC4xMDg4NzFdIHBjaSAwMDAwOjAwOjA1LjI6IHJlZyAxNDogW2lvICAweGYw
MDAtMHhmMDAzXQo8Nz5bICAgIDAuMTA4ODc1XSBwY2kgMDAwMDowMDowNS4yOiByZWcgMTg6IFtp
byAgMHhlZjAwLTB4ZWYwN10KPDc+WyAgICAwLjEwODg3OV0gcGNpIDAwMDA6MDA6MDUuMjogcmVn
IDFjOiBbaW8gIDB4ZWUwMC0weGVlMDNdCjw3PlsgICAgMC4xMDg4ODNdIHBjaSAwMDAwOjAwOjA1
LjI6IHJlZyAyMDogW2lvICAweGVkMDAtMHhlZDBmXQo8Nz5bICAgIDAuMTA4ODg3XSBwY2kgMDAw
MDowMDowNS4yOiByZWcgMjQ6IFttZW0gMHhmZTAyYjAwMC0weGZlMDJiZmZmXQo8Nz5bICAgIDAu
MTA4OTA5XSBwY2kgMDAwMDowMDowNi4wOiBbMTBkZTowMzcwXSB0eXBlIDEgY2xhc3MgMHgwMDA2
MDQKPDc+WyAgICAwLjEwODkzMl0gcGNpIDAwMDA6MDA6MDYuMTogWzEwZGU6MDM3MV0gdHlwZSAw
IGNsYXNzIDB4MDAwNDAzCjw3PlsgICAgMC4xMDg5NDFdIHBjaSAwMDAwOjAwOjA2LjE6IHJlZyAx
MDogW21lbSAweGZlMDI0MDAwLTB4ZmUwMjdmZmZdCjw3PlsgICAgMC4xMDg5NjddIHBjaSAwMDAw
OjAwOjA2LjE6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMDg5
NjldIHBjaSAwMDAwOjAwOjA2LjE6IFBNRSMgZGlzYWJsZWQKPDc+WyAgICAwLjEwODk4N10gcGNp
IDAwMDA6MDA6MGEuMDogWzEwZGU6MDM3Nl0gdHlwZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAg
MC4xMDkwMDldIHBjaSAwMDAwOjAwOjBhLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIg
RDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMDkwMTJdIHBjaSAwMDAwOjAwOjBhLjA6IFBNRSMgZGlz
YWJsZWQKPDc+WyAgICAwLjEwOTAyM10gcGNpIDAwMDA6MDA6MGMuMDogWzEwZGU6MDM3NF0gdHlw
ZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAgMC4xMDkwNDBdIHBjaSAwMDAwOjAwOjBjLjA6IFBN
RSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMDkwNDNd
IHBjaSAwMDAwOjAwOjBjLjA6IFBNRSMgZGlzYWJsZWQKPDc+WyAgICAwLjEwOTA1NV0gcGNpIDAw
MDA6MDA6MGYuMDogWzEwZGU6MDM3N10gdHlwZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAgMC4x
MDkwNzJdIHBjaSAwMDAwOjAwOjBmLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDIgRDNo
b3QgRDNjb2xkCjw3PlsgICAgMC4xMDkwNzVdIHBjaSAwMDAwOjAwOjBmLjA6IFBNRSMgZGlzYWJs
ZWQKPDc+WyAgICAwLjEwOTA4OV0gcGNpIDAwMDA6MDA6MTguMDogWzEwMjI6MTEwMF0gdHlwZSAw
IGNsYXNzIDB4MDAwNjAwCjw3PlsgICAgMC4xMDkxMDRdIHBjaSAwMDAwOjAwOjE4LjE6IFsxMDIy
OjExMDFdIHR5cGUgMCBjbGFzcyAweDAwMDYwMAo8Nz5bICAgIDAuMTA5MTE2XSBwY2kgMDAwMDow
MDoxOC4yOiBbMTAyMjoxMTAyXSB0eXBlIDAgY2xhc3MgMHgwMDA2MDAKPDc+WyAgICAwLjEwOTEy
OV0gcGNpIDAwMDA6MDA6MTguMzogWzEwMjI6MTEwM10gdHlwZSAwIGNsYXNzIDB4MDAwNjAwCjw3
PlsgICAgMC4xMDkxNjZdIHBjaSAwMDAwOjAxOjA2LjA6IFsxMGVjOjgxNjldIHR5cGUgMCBjbGFz
cyAweDAwMDIwMAo8Nz5bICAgIDAuMTA5MTc2XSBwY2kgMDAwMDowMTowNi4wOiByZWcgMTA6IFtp
byAgMHhkYzAwLTB4ZGNmZl0KPDc+WyAgICAwLjEwOTE4M10gcGNpIDAwMDA6MDE6MDYuMDogcmVn
IDE0OiBbbWVtIDB4ZmRlZmYwMDAtMHhmZGVmZjBmZl0KPDc+WyAgICAwLjEwOTIwNl0gcGNpIDAw
MDA6MDE6MDYuMDogcmVnIDMwOiBbbWVtIDB4ZmRlYzAwMDAtMHhmZGVkZmZmZiBwcmVmXQo8Nz5b
ICAgIDAuMTA5MjE2XSBwY2kgMDAwMDowMTowNi4wOiBzdXBwb3J0cyBEMSBEMgo8Nz5bICAgIDAu
MTA5MjE4XSBwY2kgMDAwMDowMTowNi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQxIEQyIEQzaG90
IEQzY29sZAo8Nz5bICAgIDAuMTA5MjIxXSBwY2kgMDAwMDowMTowNi4wOiBQTUUjIGRpc2FibGVk
Cjw3PlsgICAgMC4xMDkyMzRdIHBjaSAwMDAwOjAxOjA3LjA6IFsxMDAyOjUwNTBdIHR5cGUgMCBj
bGFzcyAweDAwMDMwMAo8Nz5bICAgIDAuMTA5MjQ2XSBwY2kgMDAwMDowMTowNy4wOiByZWcgMTA6
IFttZW0gMHhmODAwMDAwMC0weGZiZmZmZmZmIHByZWZdCjw3PlsgICAgMC4xMDkyNTRdIHBjaSAw
MDAwOjAxOjA3LjA6IHJlZyAxNDogW2lvICAweGQ4MDAtMHhkOGZmXQo8Nz5bICAgIDAuMTA5MjYx
XSBwY2kgMDAwMDowMTowNy4wOiByZWcgMTg6IFttZW0gMHhmZGVmODAwMC0weGZkZWZiZmZmXQo8
Nz5bICAgIDAuMTA5Mjg1XSBwY2kgMDAwMDowMTowNy4wOiByZWcgMzA6IFttZW0gMHhmZGVjMDAw
MC0weGZkZWRmZmZmIHByZWZdCjw3PlsgICAgMC4xMDkyOThdIHBjaSAwMDAwOjAxOjA3LjA6IHN1
cHBvcnRzIEQxCjw3PlsgICAgMC4xMDkzMTBdIHBjaSAwMDAwOjAxOjA4LjA6IFsxMGVjOjgxNjld
IHR5cGUgMCBjbGFzcyAweDAwMDIwMAo8Nz5bICAgIDAuMTA5MzE5XSBwY2kgMDAwMDowMTowOC4w
OiByZWcgMTA6IFtpbyAgMHhkNDAwLTB4ZDRmZl0KPDc+WyAgICAwLjEwOTMyNl0gcGNpIDAwMDA6
MDE6MDguMDogcmVnIDE0OiBbbWVtIDB4ZmRlZmUwMDAtMHhmZGVmZTBmZl0KPDc+WyAgICAwLjEw
OTM0OV0gcGNpIDAwMDA6MDE6MDguMDogcmVnIDMwOiBbbWVtIDB4ZmRlYzAwMDAtMHhmZGVkZmZm
ZiBwcmVmXQo8Nz5bICAgIDAuMTA5MzU5XSBwY2kgMDAwMDowMTowOC4wOiBzdXBwb3J0cyBEMSBE
Mgo8Nz5bICAgIDAuMTA5MzYxXSBwY2kgMDAwMDowMTowOC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQxIEQyIEQzaG90IEQzY29sZAo8Nz5bICAgIDAuMTA5MzY0XSBwY2kgMDAwMDowMTowOC4wOiBQ
TUUjIGRpc2FibGVkCjw2PlsgICAgMC4xMDkzODVdIHBjaSAwMDAwOjAwOjA2LjA6IFBDSSBicmlk
Z2UgdG8gW2J1cyAwMS0wMV0gKHN1YnRyYWN0aXZlIGRlY29kZSkKPDc+WyAgICAwLjEwOTM5MF0g
cGNpIDAwMDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhkMDAwLTB4ZGZmZl0KPDc+
WyAgICAwLjEwOTM5M10gcGNpIDAwMDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhm
ZGUwMDAwMC0weGZkZWZmZmZmXQo8Nz5bICAgIDAuMTA5Mzk2XSBwY2kgMDAwMDowMDowNi4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweGY4MDAwMDAwLTB4ZmJmZmZmZmYgcHJlZl0KPDc+WyAgICAw
LjEwOTM5OF0gcGNpIDAwMDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgwMDAwLTB4
MGNmN10gKHN1YnRyYWN0aXZlIGRlY29kZSkKPDc+WyAgICAwLjEwOTQwMV0gcGNpIDAwMDA6MDA6
MDYuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgwZDAwLTB4ZmZmZl0gKHN1YnRyYWN0aXZlIGRl
Y29kZSkKPDc+WyAgICAwLjEwOTQwM10gcGNpIDAwMDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93
IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmXSAoc3VidHJhY3RpdmUgZGVjb2RlKQo8Nz5bICAg
IDAuMTA5NDA2XSBwY2kgMDAwMDowMDowNi4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGMw
MDAwLTB4MDAwZGZmZmZdIChzdWJ0cmFjdGl2ZSBkZWNvZGUpCjw3PlsgICAgMC4xMDk0MDhdIHBj
aSAwMDAwOjAwOjA2LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZWZmMDAwMDAtMHhmZWJmZmZm
Zl0gKHN1YnRyYWN0aXZlIGRlY29kZSkKPDc+WyAgICAwLjEwOTQzNl0gcGNpIDAwMDA6MDI6MDAu
MDogWzExYWI6NzA0Ml0gdHlwZSAwIGNsYXNzIDB4MDAwMTAwCjw3PlsgICAgMC4xMDk0NDhdIHBj
aSAwMDAwOjAyOjAwLjA6IHJlZyAxMDogW21lbSAweGZkZDAwMDAwLTB4ZmRkZmZmZmYgNjRiaXRd
Cjw3PlsgICAgMC4xMDk0NTVdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAxODogW2lvICAweGNjMDAt
MHhjY2ZmXQo8Nj5bICAgIDAuMTA5NDk4XSBwY2kgMDAwMDowMjowMC4wOiBkaXNhYmxpbmcgQVNQ
TSBvbiBwcmUtMS4xIFBDSWUgZGV2aWNlLiAgWW91IGNhbiBlbmFibGUgaXQgd2l0aCAncGNpZV9h
c3BtPWZvcmNlJwo8Nj5bICAgIDAuMTA5NTA4XSBwY2kgMDAwMDowMDowYS4wOiBQQ0kgYnJpZGdl
IHRvIFtidXMgMDItMDJdCjw3PlsgICAgMC4xMDk1MTJdIHBjaSAwMDAwOjAwOjBhLjA6ICAgYnJp
ZGdlIHdpbmRvdyBbaW8gIDB4YzAwMC0weGNmZmZdCjw3PlsgICAgMC4xMDk1MTVdIHBjaSAwMDAw
OjAwOjBhLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmRjMDAwMDAtMHhmZGRmZmZmZl0KPDc+
WyAgICAwLjEwOTUxOF0gcGNpIDAwMDA6MDA6MGEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhm
ZmYwMDAwMC0weDAwMGZmZmZmIHByZWZdIChkaXNhYmxlZCkKPDc+WyAgICAwLjEwOTU1Ml0gcGNp
IDAwMDA6MDM6MDAuMDogWzEwOTU6MzEzMl0gdHlwZSAwIGNsYXNzIDB4MDAwMTgwCjw3PlsgICAg
MC4xMDk1NzRdIHBjaSAwMDAwOjAzOjAwLjA6IHJlZyAxMDogW21lbSAweGZkYmZmMDAwLTB4ZmRi
ZmYwN2YgNjRiaXRdCjw3PlsgICAgMC4xMDk1OTFdIHBjaSAwMDAwOjAzOjAwLjA6IHJlZyAxODog
W21lbSAweGZkYmY4MDAwLTB4ZmRiZmJmZmYgNjRiaXRdCjw3PlsgICAgMC4xMDk2MDNdIHBjaSAw
MDAwOjAzOjAwLjA6IHJlZyAyMDogW2lvICAweGJjMDAtMHhiYzdmXQo8Nz5bICAgIDAuMTA5NjI1
XSBwY2kgMDAwMDowMzowMC4wOiByZWcgMzA6IFttZW0gMHhmZGIwMDAwMC0weGZkYjdmZmZmIHBy
ZWZdCjw3PlsgICAgMC4xMDk2NTddIHBjaSAwMDAwOjAzOjAwLjA6IHN1cHBvcnRzIEQxIEQyCjw2
PlsgICAgMC4xMDk2NzNdIHBjaSAwMDAwOjAzOjAwLjA6IGRpc2FibGluZyBBU1BNIG9uIHByZS0x
LjEgUENJZSBkZXZpY2UuICBZb3UgY2FuIGVuYWJsZSBpdCB3aXRoICdwY2llX2FzcG09Zm9yY2Un
Cjw2PlsgICAgMC4xMDk2ODRdIHBjaSAwMDAwOjAwOjBjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
My0wM10KPDc+WyAgICAwLjEwOTY4OF0gcGNpIDAwMDA6MDA6MGMuMDogICBicmlkZ2Ugd2luZG93
IFtpbyAgMHhiMDAwLTB4YmZmZl0KPDc+WyAgICAwLjEwOTY5MV0gcGNpIDAwMDA6MDA6MGMuMDog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZGIwMDAwMC0weGZkYmZmZmZmXQo8Nz5bICAgIDAuMTA5
Njk0XSBwY2kgMDAwMDowMDowYy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZmZjAwMDAwLTB4
MDAwZmZmZmYgcHJlZl0gKGRpc2FibGVkKQo8Nz5bICAgIDAuMTA5NzIxXSBwY2kgMDAwMDowNDow
MC4wOiBbMTBiNTo4NjA4XSB0eXBlIDEgY2xhc3MgMHgwMDA2MDQKPDc+WyAgICAwLjEwOTczMF0g
cGNpIDAwMDA6MDQ6MDAuMDogcmVnIDEwOiBbbWVtIDB4ZmRhZTAwMDAtMHhmZGFmZmZmZl0KPDc+
WyAgICAwLjEwOTc2M10gcGNpIDAwMDA6MDQ6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBE
M2hvdCBEM2NvbGQKPDc+WyAgICAwLjEwOTc2Nl0gcGNpIDAwMDA6MDQ6MDAuMDogUE1FIyBkaXNh
YmxlZAo8Nj5bICAgIDAuMTExMDE3XSBwY2kgMDAwMDowMDowZi4wOiBQQ0kgYnJpZGdlIHRvIFti
dXMgMDQtMDldCjw3PlsgICAgMC4xMTEwMjhdIHBjaSAwMDAwOjAwOjBmLjA6ICAgYnJpZGdlIHdp
bmRvdyBbaW8gIDB4OTAwMC0weGFmZmZdCjw3PlsgICAgMC4xMTEwMzFdIHBjaSAwMDAwOjAwOjBm
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmQ4MDAwMDAtMHhmZGFmZmZmZl0KPDc+WyAgICAw
LjExMTAzNV0gcGNpIDAwMDA6MDA6MGYuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZmYwMDAw
MC0weDAwMGZmZmZmIHByZWZdIChkaXNhYmxlZCkKPDc+WyAgICAwLjExMTA4Ml0gcGNpIDAwMDA6
MDU6MDEuMDogWzEwYjU6ODYwOF0gdHlwZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAgMC4xMTEx
MjhdIHBjaSAwMDAwOjA1OjAxLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xk
Cjw3PlsgICAgMC4xMTExMzJdIHBjaSAwMDAwOjA1OjAxLjA6IFBNRSMgZGlzYWJsZWQKPDc+WyAg
ICAwLjExMTE1N10gcGNpIDAwMDA6MDU6MDUuMDogWzEwYjU6ODYwOF0gdHlwZSAxIGNsYXNzIDB4
MDAwNjA0Cjw3PlsgICAgMC4xMTExOTddIHBjaSAwMDAwOjA1OjA1LjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMTEyMDFdIHBjaSAwMDAwOjA1OjA1LjA6
IFBNRSMgZGlzYWJsZWQKPDc+WyAgICAwLjExMTIyMF0gcGNpIDAwMDA6MDU6MDcuMDogWzEwYjU6
ODYwOF0gdHlwZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAgMC4xMTEyNjBdIHBjaSAwMDAwOjA1
OjA3LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkCjw3PlsgICAgMC4xMTEy
NjNdIHBjaSAwMDAwOjA1OjA3LjA6IFBNRSMgZGlzYWJsZWQKPDc+WyAgICAwLjExMTI4NF0gcGNp
IDAwMDA6MDU6MDkuMDogWzEwYjU6ODYwOF0gdHlwZSAxIGNsYXNzIDB4MDAwNjA0Cjw3PlsgICAg
MC4xMTEzMjNdIHBjaSAwMDAwOjA1OjA5LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3Qg
RDNjb2xkCjw3PlsgICAgMC4xMTEzMjddIHBjaSAwMDAwOjA1OjA5LjA6IFBNRSMgZGlzYWJsZWQK
PDY+WyAgICAwLjExMTM1Ml0gcGNpIDAwMDA6MDQ6MDAuMDogUENJIGJyaWRnZSB0byBbYnVzIDA1
LTA5XQo8Nz5bICAgIDAuMTExMzU4XSBwY2kgMDAwMDowNDowMC4wOiAgIGJyaWRnZSB3aW5kb3cg
W2lvICAweDkwMDAtMHhhZmZmXQo8Nz5bICAgIDAuMTExMzYyXSBwY2kgMDAwMDowNDowMC4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweGZkODAwMDAwLTB4ZmQ5ZmZmZmZdCjw3PlsgICAgMC4xMTEz
NjZdIHBjaSAwMDAwOjA0OjAwLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmZmMDAwMDAtMHgw
MDBmZmZmZiBwcmVmXSAoZGlzYWJsZWQpCjw3PlsgICAgMC4xMTE0MTRdIHBjaSAwMDAwOjA2OjAw
LjA6IFsxMDMzOjAxOTRdIHR5cGUgMCBjbGFzcyAweDAwMGMwMwo8Nz5bICAgIDAuMTExNDMyXSBw
Y2kgMDAwMDowNjowMC4wOiByZWcgMTA6IFttZW0gMHhmZDlmZTAwMC0weGZkOWZmZmZmIDY0Yml0
XQo8Nz5bICAgIDAuMTExNTAyXSBwY2kgMDAwMDowNjowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQzaG90Cjw3PlsgICAgMC4xMTE1MDZdIHBjaSAwMDAwOjA2OjAwLjA6IFBNRSMgZGlzYWJs
ZWQKPDY+WyAgICAwLjExMzAyMl0gcGNpIDAwMDA6MDU6MDEuMDogUENJIGJyaWRnZSB0byBbYnVz
IDA2LTA2XQo8Nz5bICAgIDAuMTEzMDM1XSBwY2kgMDAwMDowNTowMS4wOiAgIGJyaWRnZSB3aW5k
b3cgW2lvICAweGYwMDAtMHgwMDAwXSAoZGlzYWJsZWQpCjw3PlsgICAgMC4xMTMwMzldIHBjaSAw
MDAwOjA1OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmQ5MDAwMDAtMHhmZDlmZmZmZl0K
PDc+WyAgICAwLjExMzA0NF0gcGNpIDAwMDA6MDU6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0g
MHhmZmYwMDAwMC0weDAwMGZmZmZmIHByZWZdIChkaXNhYmxlZCkKPDc+WyAgICAwLjExMzA5OV0g
cGNpIDAwMDA6MDc6MDAuMDogWzFiNGI6OTEyMF0gdHlwZSAwIGNsYXNzIDB4MDAwMTA2Cjw3Plsg
ICAgMC4xMTMxMTNdIHBjaSAwMDAwOjA3OjAwLjA6IHJlZyAxMDogW2lvICAweGFjMDAtMHhhYzA3
XQo8Nz5bICAgIDAuMTEzMTIyXSBwY2kgMDAwMDowNzowMC4wOiByZWcgMTQ6IFtpbyAgMHhhODAw
LTB4YTgwM10KPDc+WyAgICAwLjExMzEzMV0gcGNpIDAwMDA6MDc6MDAuMDogcmVnIDE4OiBbaW8g
IDB4YTQwMC0weGE0MDddCjw3PlsgICAgMC4xMTMxMzldIHBjaSAwMDAwOjA3OjAwLjA6IHJlZyAx
YzogW2lvICAweGEwMDAtMHhhMDAzXQo8Nz5bICAgIDAuMTEzMTQ4XSBwY2kgMDAwMDowNzowMC4w
OiByZWcgMjA6IFtpbyAgMHg5YzAwLTB4OWMwZl0KPDc+WyAgICAwLjExMzE1Nl0gcGNpIDAwMDA6
MDc6MDAuMDogcmVnIDI0OiBbbWVtIDB4ZmQ4ZmYwMDAtMHhmZDhmZjdmZl0KPDc+WyAgICAwLjEx
MzE2NV0gcGNpIDAwMDA6MDc6MDAuMDogcmVnIDMwOiBbbWVtIDB4ZmQ4ZTAwMDAtMHhmZDhlZmZm
ZiBwcmVmXQo8Nz5bICAgIDAuMTEzMTkxXSBwY2kgMDAwMDowNzowMC4wOiBQTUUjIHN1cHBvcnRl
ZCBmcm9tIEQzaG90Cjw3PlsgICAgMC4xMTMxOTVdIHBjaSAwMDAwOjA3OjAwLjA6IFBNRSMgZGlz
YWJsZWQKPDY+WyAgICAwLjExNTAyMF0gcGNpIDAwMDA6MDU6MDUuMDogUENJIGJyaWRnZSB0byBb
YnVzIDA3LTA3XQo8Nz5bICAgIDAuMTE1MDMyXSBwY2kgMDAwMDowNTowNS4wOiAgIGJyaWRnZSB3
aW5kb3cgW2lvICAweDkwMDAtMHhhZmZmXQo8Nz5bICAgIDAuMTE1MDM2XSBwY2kgMDAwMDowNTow
NS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZkODAwMDAwLTB4ZmQ4ZmZmZmZdCjw3PlsgICAg
MC4xMTUwNDFdIHBjaSAwMDAwOjA1OjA1LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmZmMDAw
MDAtMHgwMDBmZmZmZiBwcmVmXSAoZGlzYWJsZWQpCjw2PlsgICAgMC4xMTUwODRdIHBjaSAwMDAw
OjA1OjA3LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwOC0wOF0KPDc+WyAgICAwLjExNTA5MV0gcGNp
IDAwMDA6MDU6MDcuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhmMDAwLTB4MDAwMF0gKGRpc2Fi
bGVkKQo8Nz5bICAgIDAuMTE1MDk0XSBwY2kgMDAwMDowNTowNy4wOiAgIGJyaWRnZSB3aW5kb3cg
W21lbSAweGZmZjAwMDAwLTB4MDAwZmZmZmZdIChkaXNhYmxlZCkKPDc+WyAgICAwLjExNTA5OV0g
cGNpIDAwMDA6MDU6MDcuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZmYwMDAwMC0weDAwMGZm
ZmZmIHByZWZdIChkaXNhYmxlZCkKPDY+WyAgICAwLjExNTEzMl0gcGNpIDAwMDA6MDU6MDkuMDog
UENJIGJyaWRnZSB0byBbYnVzIDA5LTA5XQo8Nz5bICAgIDAuMTE1MTM4XSBwY2kgMDAwMDowNTow
OS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweGYwMDAtMHgwMDAwXSAoZGlzYWJsZWQpCjw3Plsg
ICAgMC4xMTUxNDJdIHBjaSAwMDAwOjA1OjA5LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmZm
MDAwMDAtMHgwMDBmZmZmZl0gKGRpc2FibGVkKQo8Nz5bICAgIDAuMTE1MTQ3XSBwY2kgMDAwMDow
NTowOS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZmZjAwMDAwLTB4MDAwZmZmZmYgcHJlZl0g
KGRpc2FibGVkKQo8Nz5bICAgIDAuMTE1MTcxXSBwY2lfYnVzIDAwMDA6MDA6IG9uIE5VTUEgbm9k
ZSAwCjw3PlsgICAgMC4xMTUxNzldIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBb
XF9TQl8uUENJMC5fUFJUXQo8Nz5bICAgIDAuMTE1MzczXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IFJv
dXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuSFVCMC5fUFJUXQo8Nj5bICAgIDAuMTE1NTA5XSAgcGNp
MDAwMDowMDogUmVxdWVzdGluZyBBQ1BJIF9PU0MgY29udHJvbCAoMHgxZCkKPDY+WyAgICAwLjEx
NTUxNV0gVW5hYmxlIHRvIGFzc3VtZSBfT1NDIFBDSWUgY29udHJvbC4gRGlzYWJsaW5nIEFTUE0K
PDY+WyAgICAwLjEzODI2Ml0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTksxXSAoSVJRcyAq
NSA3IDkgMTAgMTEgMTQgMTUpCjw2PlsgICAgMC4xMzgzMjBdIEFDUEk6IFBDSSBJbnRlcnJ1cHQg
TGluayBbTE5LMl0gKElSUXMgNSAqNyA5IDEwIDExIDE0IDE1KQo8Nj5bICAgIDAuMTM4Mzc0XSBB
Q1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOSzNdIChJUlFzIDUgNyA5ICoxMCAxMSAxNCAxNSkK
PDY+WyAgICAwLjEzODQyOF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTks0XSAoSVJRcyA1
IDcgOSAxMCAxMSAxNCAxNSkgKjAsIGRpc2FibGVkLgo8Nj5bICAgIDAuMTM4NDg0XSBBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0xOSzVdIChJUlFzIDUgNyA5IDEwICoxMSAxNCAxNSkKPDY+WyAg
ICAwLjEzODUzOV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTks2XSAoSVJRcyA1IDcgOSAq
MTAgMTEgMTQgMTUpCjw2PlsgICAgMC4xMzg1OTNdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBb
TE5LN10gKElSUXMgNSA3IDkgMTAgKjExIDE0IDE1KQo8Nj5bICAgIDAuMTM4NjQ2XSBBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0xOSzhdIChJUlFzIDUgNyA5IDEwIDExIDE0IDE1KSAqMCwgZGlz
YWJsZWQuCjw2PlsgICAgMC4xMzg3MDFdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTFAyUF0g
KElSUXMgNSA3IDkgMTAgMTEgMTQgMTUpICowLCBkaXNhYmxlZC4KPDY+WyAgICAwLjEzODc1Nl0g
QUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMVUJBXSAoSVJRcyA1IDcgOSAxMCAxMSAxNCAxNSkg
KjAsIGRpc2FibGVkLgo8Nj5bICAgIDAuMTM4ODExXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0xNQUNdIChJUlFzIDUgNyA5IDEwIDExIDE0IDE1KSAqMCwgZGlzYWJsZWQuCjw2PlsgICAgMC4x
Mzg4NjddIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTEFaQV0gKElSUXMgNSA3IDkgMTAgKjEx
IDE0IDE1KQo8Nj5bICAgIDAuMTM4OTIxXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xQTVVd
IChJUlFzIDUgNyA5IDEwIDExIDE0IDE1KSAqMCwgZGlzYWJsZWQuCjw2PlsgICAgMC4xMzg5NzZd
IEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTFNNQl0gKElSUXMgNSA3IDkgMTAgMTEgMTQgMTUp
ICowLCBkaXNhYmxlZC4KPDY+WyAgICAwLjEzOTAzNl0gQUNQSTogUENJIEludGVycnVwdCBMaW5r
IFtMVUIyXSAoSVJRcyA1IDcgOSAxMCAxMSAxNCAxNSkgKjAsIGRpc2FibGVkLgo8Nj5bICAgIDAu
MTM5MDkxXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xJREVdIChJUlFzIDUgNyA5IDEwIDEx
IDE0IDE1KSAqMCwgZGlzYWJsZWQuCjw2PlsgICAgMC4xMzkxNDddIEFDUEk6IFBDSSBJbnRlcnJ1
cHQgTGluayBbTFNJRF0gKElSUXMgKjUgNyA5IDEwIDExIDE0IDE1KQo8Nj5bICAgIDAuMTM5MjAy
XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xGSURdIChJUlFzIDUgNyA5ICoxMCAxMSAxNCAx
NSkKPDY+WyAgICAwLjEzOTI1OF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMU0EyXSAoSVJR
cyA1ICo3IDkgMTAgMTEgMTQgMTUpCjw2PlsgICAgMC4xMzkzNTBdIEFDUEk6IFBDSSBJbnRlcnJ1
cHQgTGluayBbQVBDMV0gKElSUXMgMTYpICowCjw2PlsgICAgMC4xMzk0MzNdIEFDUEk6IFBDSSBJ
bnRlcnJ1cHQgTGluayBbQVBDMl0gKElSUXMgMTcpICowCjw2PlsgICAgMC4xMzk1MTVdIEFDUEk6
IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDM10gKElSUXMgMTgpICowCjw2PlsgICAgMC4xMzk1OTZd
IEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDNF0gKElSUXMgMTkpICowLCBkaXNhYmxlZC4K
PDY+WyAgICAwLjEzOTY3OV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBUEM1XSAoSVJRcyAx
NikgKjAKPDY+WyAgICAwLjEzOTc2MV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBUEM2XSAo
SVJRcyAxNikgKjAKPDY+WyAgICAwLjEzOTg0M10gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtB
UEM3XSAoSVJRcyAxNikgKjAKPDY+WyAgICAwLjEzOTkyNF0gQUNQSTogUENJIEludGVycnVwdCBM
aW5rIFtBUEM4XSAoSVJRcyAxNikgKjAsIGRpc2FibGVkLgo8Nj5bICAgIDAuMTQwMDEyXSBBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0FQQ0ZdIChJUlFzIDIwIDIxIDIyIDIzKSAqMCwgZGlzYWJs
ZWQuCjw2PlsgICAgMC4xNDAwOTddIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDSF0gKElS
UXMgMjAgMjEgMjIgMjMpICowLCBkaXNhYmxlZC4KPDY+WyAgICAwLjE0MDE4MV0gQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtBUE1VXSAoSVJRcyAyMCAyMSAyMiAyMykgKjAsIGRpc2FibGVkLgo8
Nj5bICAgIDAuMTQwMjY1XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0FBWkFdIChJUlFzIDIw
IDIxIDIyIDIzKSAqMAo8Nj5bICAgIDAuMTQwMzQ5XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0FQQ1NdIChJUlFzIDIwIDIxIDIyIDIzKSAqMCwgZGlzYWJsZWQuCjw2PlsgICAgMC4xNDA0MzNd
IEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDTF0gKElSUXMgMjAgMjEgMjIgMjMpICowLCBk
aXNhYmxlZC4KPDY+WyAgICAwLjE0MDUxN10gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBUENN
XSAoSVJRcyAyMCAyMSAyMiAyMykgKjAsIGRpc2FibGVkLgo8Nj5bICAgIDAuMTQwNjAxXSBBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0FQQ1pdIChJUlFzIDIwIDIxIDIyIDIzKSAqMCwgZGlzYWJs
ZWQuCjw2PlsgICAgMC4xNDA2ODZdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBTSV0gKElS
UXMgMjAgMjEgMjIgMjMpICowCjw2PlsgICAgMC4xNDA3NzFdIEFDUEk6IFBDSSBJbnRlcnJ1cHQg
TGluayBbQVBTSl0gKElSUXMgMjAgMjEgMjIgMjMpICowCjw2PlsgICAgMC4xNDA4NTVdIEFDUEk6
IFBDSSBJbnRlcnJ1cHQgTGluayBbQVNBMl0gKElSUXMgMjAgMjEgMjIgMjMpICowCjw2PlsgICAg
MC4xNDA5NDddIHZnYWFyYjogZGV2aWNlIGFkZGVkOiBQQ0k6MDAwMDowMTowNy4wLGRlY29kZXM9
aW8rbWVtLG93bnM9aW8rbWVtLGxvY2tzPW5vbmUKPDY+WyAgICAwLjE0MDk1Nl0gdmdhYXJiOiBs
b2FkZWQKPDU+WyAgICAwLjE0MTA3M10gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQKPDc+WyAg
ICAwLjE0MTEzNl0gbGliYXRhIHZlcnNpb24gMy4wMCBsb2FkZWQuCjw2PlsgICAgMC4xNDExODBd
IHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiZnMKPDY+WyAgICAw
LjE0MTE5Ml0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBodWIKPDY+
WyAgICAwLjE0MTIxMF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IK
PDY+WyAgICAwLjE0MTIxMF0gUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGluZwo8Nz5bICAg
IDAuMTQxMjEwXSBQQ0k6IHBjaV9jYWNoZV9saW5lX3NpemUgc2V0IHRvIDY0IGJ5dGVzCjw3Plsg
ICAgMC4xNDEyMTBdIHJlc2VydmUgUkFNIGJ1ZmZlcjogMDAwMDAwMDAwMDA5ZDgwMCAtIDAwMDAw
MDAwMDAwOWZmZmYgCjw3PlsgICAgMC4xNDEyMTBdIHJlc2VydmUgUkFNIGJ1ZmZlcjogMDAwMDAw
MDBlZmVlMDAwMCAtIDAwMDAwMDAwZWZmZmZmZmYgCjw2PlsgICAgMC4xNDEyMTBdIEhQRVQ6IDMg
dGltZXJzIGluIHRvdGFsLCAwIHRpbWVycyB3aWxsIGJlIHVzZWQgZm9yIHBlci1jcHUgdGltZXIK
PDY+WyAgICAwLjE0MTIxMF0gaHBldDA6IGF0IE1NSU8gMHhmZWZmZjAwMCwgSVJRcyAyLCA4LCAz
MQo8Nj5bICAgIDAuMTQxMjEwXSBocGV0MDogMyBjb21wYXJhdG9ycywgMzItYml0IDI1LjAwMDAw
MCBNSHogY291bnRlcgo8Nj5bICAgIDAuMTQ1MDM0XSBTd2l0Y2hpbmcgdG8gY2xvY2tzb3VyY2Ug
aHBldAo8Nj5bICAgIDAuMTQ1NjUyXSBTd2l0Y2hlZCB0byBOT0h6IG1vZGUgb24gQ1BVICMxCjw2
PlsgICAgMC4xNDU2NTVdIFN3aXRjaGVkIHRvIE5PSHogbW9kZSBvbiBDUFUgIzAKPDY+WyAgICAw
LjE0NjIzNF0gcG5wOiBQblAgQUNQSSBpbml0Cjw2PlsgICAgMC4xNDYyNTFdIEFDUEk6IGJ1cyB0
eXBlIHBucCByZWdpc3RlcmVkCjw3PlsgICAgMC4xNDYzODRdIHBucCAwMDowMDogW2J1cyAwMC1m
Zl0KPDc+WyAgICAwLjE0NjM4Nl0gcG5wIDAwOjAwOiBbaW8gIDB4MGNmOC0weDBjZmZdCjw3Plsg
ICAgMC4xNDYzODhdIHBucCAwMDowMDogW2lvICAweDAwMDAtMHgwY2Y3IHdpbmRvd10KPDc+WyAg
ICAwLjE0NjM5MF0gcG5wIDAwOjAwOiBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQo8Nz5bICAg
IDAuMTQ2MzkzXSBwbnAgMDA6MDA6IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRvd10K
PDc+WyAgICAwLjE0NjM5NV0gcG5wIDAwOjAwOiBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZiB3
aW5kb3ddCjw3PlsgICAgMC4xNDYzOTddIHBucCAwMDowMDogW21lbSAweGVmZjAwMDAwLTB4ZmVi
ZmZmZmYgd2luZG93XQo8Nz5bICAgIDAuMTQ2NDc5XSBwbnAgMDA6MDA6IFBsdWcgYW5kIFBsYXkg
QUNQSSBkZXZpY2UsIElEcyBQTlAwYTA4IFBOUDBhMDMgKGFjdGl2ZSkKPDc+WyAgICAwLjE0NjUw
MV0gcG5wIDAwOjAxOiBbaW8gIDB4MTAwMC0weDEwN2ZdCjw3PlsgICAgMC4xNDY1MDNdIHBucCAw
MDowMTogW2lvICAweDEwODAtMHgxMGZmXQo8Nz5bICAgIDAuMTQ2NTA1XSBwbnAgMDA6MDE6IFtp
byAgMHgxNDAwLTB4MTQ3Zl0KPDc+WyAgICAwLjE0NjUwNl0gcG5wIDAwOjAxOiBbaW8gIDB4MTQ4
MC0weDE0ZmZdCjw3PlsgICAgMC4xNDY1MDhdIHBucCAwMDowMTogW2lvICAweDE4MDAtMHgxODdm
XQo8Nz5bICAgIDAuMTQ2NTEwXSBwbnAgMDA6MDE6IFtpbyAgMHgxODgwLTB4MThmZl0KPDY+WyAg
ICAwLjE0NjU3Ml0gc3lzdGVtIDAwOjAxOiBbaW8gIDB4MTAwMC0weDEwN2ZdIGhhcyBiZWVuIHJl
c2VydmVkCjw2PlsgICAgMC4xNDY1NzZdIHN5c3RlbSAwMDowMTogW2lvICAweDEwODAtMHgxMGZm
XSBoYXMgYmVlbiByZXNlcnZlZAo8Nj5bICAgIDAuMTQ2NTgxXSBzeXN0ZW0gMDA6MDE6IFtpbyAg
MHgxNDAwLTB4MTQ3Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKPDY+WyAgICAwLjE0NjU4NV0gc3lzdGVt
IDAwOjAxOiBbaW8gIDB4MTQ4MC0weDE0ZmZdIGhhcyBiZWVuIHJlc2VydmVkCjw2PlsgICAgMC4x
NDY1ODldIHN5c3RlbSAwMDowMTogW2lvICAweDE4MDAtMHgxODdmXSBoYXMgYmVlbiByZXNlcnZl
ZAo8Nj5bICAgIDAuMTQ2NTkzXSBzeXN0ZW0gMDA6MDE6IFtpbyAgMHgxODgwLTB4MThmZl0gaGFz
IGJlZW4gcmVzZXJ2ZWQKPDc+WyAgICAwLjE0NjU5OF0gc3lzdGVtIDAwOjAxOiBQbHVnIGFuZCBQ
bGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGMwMiAoYWN0aXZlKQo8Nz5bICAgIDAuMTQ2Njc1XSBw
bnAgMDA6MDI6IFtpbyAgMHgwMDEwLTB4MDAxZl0KPDc+WyAgICAwLjE0NjY3N10gcG5wIDAwOjAy
OiBbaW8gIDB4MDAyMi0weDAwM2ZdCjw3PlsgICAgMC4xNDY2NzhdIHBucCAwMDowMjogW2lvICAw
eDAwNDQtMHgwMDVmXQo8Nz5bICAgIDAuMTQ2NjgwXSBwbnAgMDA6MDI6IFtpbyAgMHgwMDYyLTB4
MDA2M10KPDc+WyAgICAwLjE0NjY4Ml0gcG5wIDAwOjAyOiBbaW8gIDB4MDA2NS0weDAwNmZdCjw3
PlsgICAgMC4xNDY2ODRdIHBucCAwMDowMjogW2lvICAweDAwNzQtMHgwMDdmXQo8Nz5bICAgIDAu
MTQ2Njg2XSBwbnAgMDA6MDI6IFtpbyAgMHgwMDkxLTB4MDA5M10KPDc+WyAgICAwLjE0NjY4N10g
cG5wIDAwOjAyOiBbaW8gIDB4MDBhMi0weDAwYmZdCjw3PlsgICAgMC4xNDY2ODldIHBucCAwMDow
MjogW2lvICAweDAwZTAtMHgwMGVmXQo8Nz5bICAgIDAuMTQ2NjkyXSBwbnAgMDA6MDI6IFtpbyAg
MHgwNGQwLTB4MDRkMV0KPDc+WyAgICAwLjE0NjY5NF0gcG5wIDAwOjAyOiBbaW8gIDB4MDgwMC0w
eDA4N2ZdCjw3PlsgICAgMC4xNDY2OTZdIHBucCAwMDowMjogW2lvICAweDAyOTAtMHgwMjk3XQo8
Nj5bICAgIDAuMTQ2NzU0XSBzeXN0ZW0gMDA6MDI6IFtpbyAgMHgwNGQwLTB4MDRkMV0gaGFzIGJl
ZW4gcmVzZXJ2ZWQKPDY+WyAgICAwLjE0Njc1OV0gc3lzdGVtIDAwOjAyOiBbaW8gIDB4MDgwMC0w
eDA4N2ZdIGhhcyBiZWVuIHJlc2VydmVkCjw2PlsgICAgMC4xNDY3NjNdIHN5c3RlbSAwMDowMjog
W2lvICAweDAyOTAtMHgwMjk3XSBoYXMgYmVlbiByZXNlcnZlZAo8Nz5bICAgIDAuMTQ2NzY4XSBz
eXN0ZW0gMDA6MDI6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3Rp
dmUpCjw3PlsgICAgMC4xNDY3ODFdIHBucCAwMDowMzogW2RtYSA0XQo8Nz5bICAgIDAuMTQ2Nzgz
XSBwbnAgMDA6MDM6IFtpbyAgMHgwMDAwLTB4MDAwZl0KPDc+WyAgICAwLjE0Njc4NV0gcG5wIDAw
OjAzOiBbaW8gIDB4MDA4MC0weDAwOTBdCjw3PlsgICAgMC4xNDY3ODddIHBucCAwMDowMzogW2lv
ICAweDAwOTQtMHgwMDlmXQo8Nz5bICAgIDAuMTQ2Nzg5XSBwbnAgMDA6MDM6IFtpbyAgMHgwMGMw
LTB4MDBkZl0KPDc+WyAgICAwLjE0NjgxMV0gcG5wIDAwOjAzOiBQbHVnIGFuZCBQbGF5IEFDUEkg
ZGV2aWNlLCBJRHMgUE5QMDIwMCAoYWN0aXZlKQo8Nz5bICAgIDAuMTQ2ODY5XSBwbnAgMDA6MDQ6
IFtpcnEgMCBkaXNhYmxlZF0KPDc+WyAgICAwLjE0Njg4Ml0gcG5wIDAwOjA0OiBbaXJxIDhdCjw3
PlsgICAgMC4xNDY4ODRdIHBucCAwMDowNDogW21lbSAweGZlZmZmMDAwLTB4ZmVmZmYzZmZdCjw3
PlsgICAgMC4xNDY5MDldIHBucCAwMDowNDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURz
IFBOUDAxMDMgKGFjdGl2ZSkKPDc+WyAgICAwLjE0Njk0MF0gcG5wIDAwOjA1OiBbaW8gIDB4MDA3
MC0weDAwNzNdCjw3PlsgICAgMC4xNDY5NjVdIHBucCAwMDowNTogUGx1ZyBhbmQgUGxheSBBQ1BJ
IGRldmljZSwgSURzIFBOUDBiMDAgKGFjdGl2ZSkKPDc+WyAgICAwLjE0Njk3NF0gcG5wIDAwOjA2
OiBbaW8gIDB4MDA2MV0KPDc+WyAgICAwLjE0Njk5OF0gcG5wIDAwOjA2OiBQbHVnIGFuZCBQbGF5
IEFDUEkgZGV2aWNlLCBJRHMgUE5QMDgwMCAoYWN0aXZlKQo8Nz5bICAgIDAuMTQ3MDIzXSBwbnAg
MDA6MDc6IFtpbyAgMHgwMGYwLTB4MDBmZl0KPDc+WyAgICAwLjE0NzAzMF0gcG5wIDAwOjA3OiBb
aXJxIDEzXQo8Nz5bICAgIDAuMTQ3MDU1XSBwbnAgMDA6MDc6IFBsdWcgYW5kIFBsYXkgQUNQSSBk
ZXZpY2UsIElEcyBQTlAwYzA0IChhY3RpdmUpCjw3PlsgICAgMC4xNDczODRdIHBucCAwMDowODog
W2lvICAweDAzZjgtMHgwM2ZmXQo8Nz5bICAgIDAuMTQ3MzkyXSBwbnAgMDA6MDg6IFtpcnEgNF0K
PDc+WyAgICAwLjE0NzQ0N10gcG5wIDAwOjA4OiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJ
RHMgUE5QMDUwMSAoYWN0aXZlKQo8Nz5bICAgIDAuMTQ3NzgxXSBwbnAgMDA6MDk6IFtpbyAgMHgw
MDYwXQo8Nz5bICAgIDAuMTQ3NzgzXSBwbnAgMDA6MDk6IFtpbyAgMHgwMDY0XQo8Nz5bICAgIDAu
MTQ3NzkwXSBwbnAgMDA6MDk6IFtpcnEgMV0KPDc+WyAgICAwLjE0NzgyMl0gcG5wIDAwOjA5OiBQ
bHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMDMwMyBQTlAwMzBiIChhY3RpdmUpCjw3
PlsgICAgMC4xNDg1MDVdIHBucCAwMDowYTogW21lbSAweGYwMDAwMDAwLTB4ZjNmZmZmZmZdCjw2
PlsgICAgMC4xNDg1NjldIHN5c3RlbSAwMDowYTogW21lbSAweGYwMDAwMDAwLTB4ZjNmZmZmZmZd
IGhhcyBiZWVuIHJlc2VydmVkCjw3PlsgICAgMC4xNDg1NzVdIHN5c3RlbSAwMDowYTogUGx1ZyBh
bmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIgKGFjdGl2ZSkKPDc+WyAgICAwLjE0ODcx
NF0gcG5wIDAwOjBiOiBbbWVtIDB4MDAwZDI0MDAtMHgwMDBkM2ZmZl0KPDc+WyAgICAwLjE0ODcx
N10gcG5wIDAwOjBiOiBbbWVtIDB4MDAwZjAwMDAtMHgwMDBmN2ZmZl0KPDc+WyAgICAwLjE0ODcx
OV0gcG5wIDAwOjBiOiBbbWVtIDB4MDAwZjgwMDAtMHgwMDBmYmZmZl0KPDc+WyAgICAwLjE0ODcy
MV0gcG5wIDAwOjBiOiBbbWVtIDB4MDAwZmMwMDAtMHgwMDBmZmZmZl0KPDc+WyAgICAwLjE0ODcy
M10gcG5wIDAwOjBiOiBbbWVtIDB4ZmVmZmYwMDAtMHhmZWZmZjBmZl0KPDc+WyAgICAwLjE0ODcy
NV0gcG5wIDAwOjBiOiBbbWVtIDB4ZWZlZTAwMDAtMHhlZmVmZmZmZl0KPDc+WyAgICAwLjE0ODcy
N10gcG5wIDAwOjBiOiBbbWVtIDB4ZmZmZjAwMDAtMHhmZmZmZmZmZl0KPDc+WyAgICAwLjE0ODcy
OV0gcG5wIDAwOjBiOiBbbWVtIDB4MDAwMDAwMDAtMHgwMDA5ZmZmZl0KPDc+WyAgICAwLjE0ODcz
MV0gcG5wIDAwOjBiOiBbbWVtIDB4MDAxMDAwMDAtMHhlZmVkZmZmZl0KPDc+WyAgICAwLjE0ODcz
M10gcG5wIDAwOjBiOiBbbWVtIDB4ZmVjMDAwMDAtMHhmZWMwMGZmZl0KPDc+WyAgICAwLjE0ODcz
NV0gcG5wIDAwOjBiOiBbbWVtIDB4ZmVlMDAwMDAtMHhmZWVmZmZmZl0KPDc+WyAgICAwLjE0ODcz
N10gcG5wIDAwOjBiOiBbbWVtIDB4ZmVmZmYwMDAtMHhmZWZmZmZmZl0KPDc+WyAgICAwLjE0ODcz
OV0gcG5wIDAwOjBiOiBbbWVtIDB4ZmZmODAwMDAtMHhmZmY4MGZmZl0KPDc+WyAgICAwLjE0ODc0
MV0gcG5wIDAwOjBiOiBbbWVtIDB4ZmZmOTAwMDAtMHhmZmZiZmZmZl0KPDc+WyAgICAwLjE0ODc0
M10gcG5wIDAwOjBiOiBbbWVtIDB4ZmZmZWQwMDAtMHhmZmZlZmZmZl0KPDY+WyAgICAwLjE0ODgy
OF0gc3lzdGVtIDAwOjBiOiBbbWVtIDB4MDAwZDI0MDAtMHgwMDBkM2ZmZl0gaGFzIGJlZW4gcmVz
ZXJ2ZWQKPDY+WyAgICAwLjE0ODgzNF0gc3lzdGVtIDAwOjBiOiBbbWVtIDB4MDAwZjAwMDAtMHgw
MDBmN2ZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkCjw2PlsgICAgMC4xNDg4MzhdIHN5c3RlbSAw
MDowYjogW21lbSAweDAwMGY4MDAwLTB4MDAwZmJmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZAo8
Nj5bICAgIDAuMTQ4ODQzXSBzeXN0ZW0gMDA6MGI6IFttZW0gMHgwMDBmYzAwMC0weDAwMGZmZmZm
XSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKPDY+WyAgICAwLjE0ODg0N10gc3lzdGVtIDAwOjBiOiBb
bWVtIDB4ZmVmZmYwMDAtMHhmZWZmZjBmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKPDY+WyAgICAwLjE0
ODg1Ml0gc3lzdGVtIDAwOjBiOiBbbWVtIDB4ZWZlZTAwMDAtMHhlZmVmZmZmZl0gY291bGQgbm90
IGJlIHJlc2VydmVkCjw2PlsgICAgMC4xNDg4NTZdIHN5c3RlbSAwMDowYjogW21lbSAweGZmZmYw
MDAwLTB4ZmZmZmZmZmZdIGhhcyBiZWVuIHJlc2VydmVkCjw2PlsgICAgMC4xNDg4NjFdIHN5c3Rl
bSAwMDowYjogW21lbSAweDAwMDAwMDAwLTB4MDAwOWZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZl
ZAo8Nj5bICAgIDAuMTQ4ODY2XSBzeXN0ZW0gMDA6MGI6IFttZW0gMHgwMDEwMDAwMC0weGVmZWRm
ZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKPDY+WyAgICAwLjE0ODg3MF0gc3lzdGVtIDAwOjBi
OiBbbWVtIDB4ZmVjMDAwMDAtMHhmZWMwMGZmZl0gY291bGQgbm90IGJlIHJlc2VydmVkCjw2Plsg
ICAgMC4xNDg4NzVdIHN5c3RlbSAwMDowYjogW21lbSAweGZlZTAwMDAwLTB4ZmVlZmZmZmZdIGhh
cyBiZWVuIHJlc2VydmVkCjw2PlsgICAgMC4xNDg4NzldIHN5c3RlbSAwMDowYjogW21lbSAweGZl
ZmZmMDAwLTB4ZmVmZmZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZAo8Nj5bICAgIDAuMTQ4ODg0
XSBzeXN0ZW0gMDA6MGI6IFttZW0gMHhmZmY4MDAwMC0weGZmZjgwZmZmXSBoYXMgYmVlbiByZXNl
cnZlZAo8Nj5bICAgIDAuMTQ4ODg4XSBzeXN0ZW0gMDA6MGI6IFttZW0gMHhmZmY5MDAwMC0weGZm
ZmJmZmZmXSBoYXMgYmVlbiByZXNlcnZlZAo8Nj5bICAgIDAuMTQ4ODkzXSBzeXN0ZW0gMDA6MGI6
IFttZW0gMHhmZmZlZDAwMC0weGZmZmVmZmZmXSBoYXMgYmVlbiByZXNlcnZlZAo8Nz5bICAgIDAu
MTQ4ODk4XSBzeXN0ZW0gMDA6MGI6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAw
YzAxIChhY3RpdmUpCjw2PlsgICAgMC4xNDg5MDldIHBucDogUG5QIEFDUEk6IGZvdW5kIDEyIGRl
dmljZXMKPDY+WyAgICAwLjE0ODkxMl0gQUNQSTogQUNQSSBidXMgdHlwZSBwbnAgdW5yZWdpc3Rl
cmVkCjw2PlsgICAgMC4xNTQ1NjldIHBjaSAwMDAwOjAxOjA3LjA6IGFkZHJlc3Mgc3BhY2UgY29s
bGlzaW9uOiBbbWVtIDB4ZmRlYzAwMDAtMHhmZGVkZmZmZiBwcmVmXSBjb25mbGljdHMgd2l0aCAw
MDAwOjAxOjA2LjAgW21lbSAweGZkZWMwMDAwLTB4ZmRlZGZmZmYgcHJlZl0KPDY+WyAgICAwLjE1
NDU3OV0gcGNpIDAwMDA6MDE6MDguMDogYWRkcmVzcyBzcGFjZSBjb2xsaXNpb246IFttZW0gMHhm
ZGVjMDAwMC0weGZkZWRmZmZmIHByZWZdIGNvbmZsaWN0cyB3aXRoIDAwMDA6MDE6MDYuMCBbbWVt
IDB4ZmRlYzAwMDAtMHhmZGVkZmZmZiBwcmVmXQo8Nj5bICAgIDAuMTU0NjMyXSBwY2kgMDAwMDow
MTowNy4wOiBCQVIgNjogYXNzaWduZWQgW21lbSAweGZkZTAwMDAwLTB4ZmRlMWZmZmYgcHJlZl0K
PDY+WyAgICAwLjE1NDYzOF0gcGNpIDAwMDA6MDE6MDguMDogQkFSIDY6IGFzc2lnbmVkIFttZW0g
MHhmZGUyMDAwMC0weGZkZTNmZmZmIHByZWZdCjw2PlsgICAgMC4xNTQ2NDRdIHBjaSAwMDAwOjAw
OjA2LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMS0wMV0KPDY+WyAgICAwLjE1NDY0OF0gcGNpIDAw
MDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhkMDAwLTB4ZGZmZl0KPDY+WyAgICAw
LjE1NDY1M10gcGNpIDAwMDA6MDA6MDYuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZGUwMDAw
MC0weGZkZWZmZmZmXQo8Nj5bICAgIDAuMTU0NjU3XSBwY2kgMDAwMDowMDowNi4wOiAgIGJyaWRn
ZSB3aW5kb3cgW21lbSAweGY4MDAwMDAwLTB4ZmJmZmZmZmYgcHJlZl0KPDY+WyAgICAwLjE1NDY2
M10gcGNpIDAwMDA6MDA6MGEuMDogUENJIGJyaWRnZSB0byBbYnVzIDAyLTAyXQo8Nj5bICAgIDAu
MTU0NjY3XSBwY2kgMDAwMDowMDowYS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweGMwMDAtMHhj
ZmZmXQo8Nj5bICAgIDAuMTU0NjcxXSBwY2kgMDAwMDowMDowYS4wOiAgIGJyaWRnZSB3aW5kb3cg
W21lbSAweGZkYzAwMDAwLTB4ZmRkZmZmZmZdCjw2PlsgICAgMC4xNTQ2NzZdIHBjaSAwMDAwOjAw
OjBhLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIHByZWYgZGlzYWJsZWRdCjw2PlsgICAgMC4xNTQ2
ODFdIHBjaSAwMDAwOjAwOjBjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMy0wM10KPDY+WyAgICAw
LjE1NDY4NF0gcGNpIDAwMDA6MDA6MGMuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhiMDAwLTB4
YmZmZl0KPDY+WyAgICAwLjE1NDY4OV0gcGNpIDAwMDA6MDA6MGMuMDogICBicmlkZ2Ugd2luZG93
IFttZW0gMHhmZGIwMDAwMC0weGZkYmZmZmZmXQo8Nj5bICAgIDAuMTU0NjkzXSBwY2kgMDAwMDow
MDowYy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSBwcmVmIGRpc2FibGVkXQo8Nj5bICAgIDAuMTU0
Njk4XSBwY2kgMDAwMDowNTowMS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDYtMDZdCjw2PlsgICAg
MC4xNTQ3MDFdIHBjaSAwMDAwOjA1OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIGRpc2FibGVk
XQo8Nj5bICAgIDAuMTU0NzA3XSBwY2kgMDAwMDowNTowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21l
bSAweGZkOTAwMDAwLTB4ZmQ5ZmZmZmZdCjw2PlsgICAgMC4xNTQ3MTJdIHBjaSAwMDAwOjA1OjAx
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIHByZWYgZGlzYWJsZWRdCjw2PlsgICAgMC4xNTQ3MThd
IHBjaSAwMDAwOjA1OjA1LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNy0wN10KPDY+WyAgICAwLjE1
NDcyM10gcGNpIDAwMDA6MDU6MDUuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHg5MDAwLTB4YWZm
Zl0KPDY+WyAgICAwLjE1NDcyOF0gcGNpIDAwMDA6MDU6MDUuMDogICBicmlkZ2Ugd2luZG93IFtt
ZW0gMHhmZDgwMDAwMC0weGZkOGZmZmZmXQo8Nj5bICAgIDAuMTU0NzMzXSBwY2kgMDAwMDowNTow
NS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSBwcmVmIGRpc2FibGVkXQo8Nj5bICAgIDAuMTU0NzQw
XSBwY2kgMDAwMDowNTowNy4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDgtMDhdCjw2PlsgICAgMC4x
NTQ3NDNdIHBjaSAwMDAwOjA1OjA3LjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIGRpc2FibGVkXQo8
Nj5bICAgIDAuMTU0NzQ4XSBwY2kgMDAwMDowNTowNy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSBk
aXNhYmxlZF0KPDY+WyAgICAwLjE1NDc1M10gcGNpIDAwMDA6MDU6MDcuMDogICBicmlkZ2Ugd2lu
ZG93IFttZW0gcHJlZiBkaXNhYmxlZF0KPDY+WyAgICAwLjE1NDc1OV0gcGNpIDAwMDA6MDU6MDku
MDogUENJIGJyaWRnZSB0byBbYnVzIDA5LTA5XQo8Nj5bICAgIDAuMTU0NzYyXSBwY2kgMDAwMDow
NTowOS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lvICBkaXNhYmxlZF0KPDY+WyAgICAwLjE1NDc2OF0g
cGNpIDAwMDA6MDU6MDkuMDogICBicmlkZ2Ugd2luZG93IFttZW0gZGlzYWJsZWRdCjw2PlsgICAg
MC4xNTQ3NzJdIHBjaSAwMDAwOjA1OjA5LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIHByZWYgZGlz
YWJsZWRdCjw2PlsgICAgMC4xNTQ3NzldIHBjaSAwMDAwOjA0OjAwLjA6IFBDSSBicmlkZ2UgdG8g
W2J1cyAwNS0wOV0KPDY+WyAgICAwLjE1NDc4M10gcGNpIDAwMDA6MDQ6MDAuMDogICBicmlkZ2Ug
d2luZG93IFtpbyAgMHg5MDAwLTB4YWZmZl0KPDY+WyAgICAwLjE1NDc4OV0gcGNpIDAwMDA6MDQ6
MDAuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZDgwMDAwMC0weGZkOWZmZmZmXQo8Nj5bICAg
IDAuMTU0NzkzXSBwY2kgMDAwMDowNDowMC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSBwcmVmIGRp
c2FibGVkXQo8Nj5bICAgIDAuMTU0ODAwXSBwY2kgMDAwMDowMDowZi4wOiBQQ0kgYnJpZGdlIHRv
IFtidXMgMDQtMDldCjw2PlsgICAgMC4xNTQ4MDNdIHBjaSAwMDAwOjAwOjBmLjA6ICAgYnJpZGdl
IHdpbmRvdyBbaW8gIDB4OTAwMC0weGFmZmZdCjw2PlsgICAgMC4xNTQ4MDhdIHBjaSAwMDAwOjAw
OjBmLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmQ4MDAwMDAtMHhmZGFmZmZmZl0KPDY+WyAg
ICAwLjE1NDgxMl0gcGNpIDAwMDA6MDA6MGYuMDogICBicmlkZ2Ugd2luZG93IFttZW0gcHJlZiBk
aXNhYmxlZF0KPDc+WyAgICAwLjE1NDgyMV0gcGNpIDAwMDA6MDA6MDYuMDogc2V0dGluZyBsYXRl
bmN5IHRpbWVyIHRvIDY0Cjw3PlsgICAgMC4xNTQ4MjVdIHBjaSAwMDAwOjAwOjBhLjA6IHNldHRp
bmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nz5bICAgIDAuMTU0ODI5XSBwY2kgMDAwMDowMDowYy4w
OiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKPDc+WyAgICAwLjE1NDgzM10gcGNpIDAwMDA6
MDA6MGYuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cjw0PlsgICAgMC4xNTUwMjNdIEFD
UEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDNl0gZW5hYmxlZCBhdCBJUlEgMTYKPDY+WyAgICAw
LjE1NTA0MV0gcGNpIDAwMDA6MDQ6MDAuMDogUENJIElOVCBBIC0+IExpbmtbQVBDNl0gLT4gR1NJ
IDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKPDc+WyAgICAwLjE1NTA0N10gcGNpIDAwMDA6MDQ6
MDAuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cjw0PlsgICAgMC4xNTUxODddIEFDUEk6
IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDN10gZW5hYmxlZCBhdCBJUlEgMTYKPDY+WyAgICAwLjE1
NTE5Ml0gcGNpIDAwMDA6MDU6MDEuMDogUENJIElOVCBBIC0+IExpbmtbQVBDN10gLT4gR1NJIDE2
IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKPDc+WyAgICAwLjE1NTE5OF0gcGNpIDAwMDA6MDU6MDEu
MDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cjw2PlsgICAgMC4xNTUyMDVdIHBjaSAwMDAw
OjA1OjA1LjA6IFBDSSBJTlQgQSAtPiBMaW5rW0FQQzddIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykg
LT4gSVJRIDE2Cjw3PlsgICAgMC4xNTUyMTFdIHBjaSAwMDAwOjA1OjA1LjA6IHNldHRpbmcgbGF0
ZW5jeSB0aW1lciB0byA2NAo8ND5bICAgIDAuMTU1MzQ2XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExp
bmsgW0FQQzVdIGVuYWJsZWQgYXQgSVJRIDE2Cjw2PlsgICAgMC4xNTUzNTJdIHBjaSAwMDAwOjA1
OjA3LjA6IFBDSSBJTlQgQSAtPiBMaW5rW0FQQzVdIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4g
SVJRIDE2Cjw3PlsgICAgMC4xNTUzNThdIHBjaSAwMDAwOjA1OjA3LjA6IHNldHRpbmcgbGF0ZW5j
eSB0aW1lciB0byA2NAo8Nj5bICAgIDAuMTU1MzY0XSBwY2kgMDAwMDowNTowOS4wOiBQQ0kgSU5U
IEEgLT4gTGlua1tBUEM3XSAtPiBHU0kgMTYgKGxldmVsLCBsb3cpIC0+IElSUSAxNgo8Nz5bICAg
IDAuMTU1MzcxXSBwY2kgMDAwMDowNTowOS4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQK
PDc+WyAgICAwLjE1NTM3NV0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA0IFtpbyAgMHgwMDAw
LTB4MGNmN10KPDc+WyAgICAwLjE1NTM3N10gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA1IFtp
byAgMHgwZDAwLTB4ZmZmZl0KPDc+WyAgICAwLjE1NTM3OV0gcGNpX2J1cyAwMDAwOjAwOiByZXNv
dXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmXQo8Nz5bICAgIDAuMTU1MzgyXSBwY2lf
YnVzIDAwMDA6MDA6IHJlc291cmNlIDcgW21lbSAweDAwMGMwMDAwLTB4MDAwZGZmZmZdCjw3Plsg
ICAgMC4xNTUzODRdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgOCBbbWVtIDB4ZWZmMDAwMDAt
MHhmZWJmZmZmZl0KPDc+WyAgICAwLjE1NTM4N10gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSAw
IFtpbyAgMHhkMDAwLTB4ZGZmZl0KPDc+WyAgICAwLjE1NTM4OV0gcGNpX2J1cyAwMDAwOjAxOiBy
ZXNvdXJjZSAxIFttZW0gMHhmZGUwMDAwMC0weGZkZWZmZmZmXQo8Nz5bICAgIDAuMTU1MzkyXSBw
Y2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweGY4MDAwMDAwLTB4ZmJmZmZmZmYgcHJl
Zl0KPDc+WyAgICAwLjE1NTM5NF0gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSA0IFtpbyAgMHgw
MDAwLTB4MGNmN10KPDc+WyAgICAwLjE1NTM5Nl0gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSA1
IFtpbyAgMHgwZDAwLTB4ZmZmZl0KPDc+WyAgICAwLjE1NTM5OF0gcGNpX2J1cyAwMDAwOjAxOiBy
ZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmXQo8Nz5bICAgIDAuMTU1NDAxXSBw
Y2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDcgW21lbSAweDAwMGMwMDAwLTB4MDAwZGZmZmZdCjw3
PlsgICAgMC4xNTU0MDNdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgOCBbbWVtIDB4ZWZmMDAw
MDAtMHhmZWJmZmZmZl0KPDc+WyAgICAwLjE1NTQwNl0gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJj
ZSAwIFtpbyAgMHhjMDAwLTB4Y2ZmZl0KPDc+WyAgICAwLjE1NTQwOF0gcGNpX2J1cyAwMDAwOjAy
OiByZXNvdXJjZSAxIFttZW0gMHhmZGMwMDAwMC0weGZkZGZmZmZmXQo8Nz5bICAgIDAuMTU1NDEx
XSBwY2lfYnVzIDAwMDA6MDM6IHJlc291cmNlIDAgW2lvICAweGIwMDAtMHhiZmZmXQo8Nz5bICAg
IDAuMTU1NDEzXSBwY2lfYnVzIDAwMDA6MDM6IHJlc291cmNlIDEgW21lbSAweGZkYjAwMDAwLTB4
ZmRiZmZmZmZdCjw3PlsgICAgMC4xNTU0MTVdIHBjaV9idXMgMDAwMDowNDogcmVzb3VyY2UgMCBb
aW8gIDB4OTAwMC0weGFmZmZdCjw3PlsgICAgMC4xNTU0MTddIHBjaV9idXMgMDAwMDowNDogcmVz
b3VyY2UgMSBbbWVtIDB4ZmQ4MDAwMDAtMHhmZGFmZmZmZl0KPDc+WyAgICAwLjE1NTQyMF0gcGNp
X2J1cyAwMDAwOjA1OiByZXNvdXJjZSAwIFtpbyAgMHg5MDAwLTB4YWZmZl0KPDc+WyAgICAwLjE1
NTQyMl0gcGNpX2J1cyAwMDAwOjA1OiByZXNvdXJjZSAxIFttZW0gMHhmZDgwMDAwMC0weGZkOWZm
ZmZmXQo8Nz5bICAgIDAuMTU1NDI0XSBwY2lfYnVzIDAwMDA6MDY6IHJlc291cmNlIDEgW21lbSAw
eGZkOTAwMDAwLTB4ZmQ5ZmZmZmZdCjw3PlsgICAgMC4xNTU0MjddIHBjaV9idXMgMDAwMDowNzog
cmVzb3VyY2UgMCBbaW8gIDB4OTAwMC0weGFmZmZdCjw3PlsgICAgMC4xNTU0MjldIHBjaV9idXMg
MDAwMDowNzogcmVzb3VyY2UgMSBbbWVtIDB4ZmQ4MDAwMDAtMHhmZDhmZmZmZl0KPDY+WyAgICAw
LjE1NTQ5NF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyCjw2PlsgICAgMC4xNTU1
NzJdIElQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOCwg
MTA0ODU3NiBieXRlcykKPDY+WyAgICAwLjE1NjI3NV0gVENQIGVzdGFibGlzaGVkIGhhc2ggdGFi
bGUgZW50cmllczogMjYyMTQ0IChvcmRlcjogMTAsIDQxOTQzMDQgYnl0ZXMpCjw2PlsgICAgMC4x
NTgzNDJdIFRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA4LCAxMDQ4
NTc2IGJ5dGVzKQo8Nj5bICAgIDAuMTU4ODg0XSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQg
KGVzdGFibGlzaGVkIDI2MjE0NCBiaW5kIDY1NTM2KQo8Nj5bICAgIDAuMTU4ODkxXSBUQ1AgcmVu
byByZWdpc3RlcmVkCjw2PlsgICAgMC4xNTg4OTddIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDIw
NDggKG9yZGVyOiA0LCA2NTUzNiBieXRlcykKPDY+WyAgICAwLjE1ODk0M10gVURQLUxpdGUgaGFz
aCB0YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRlcjogNCwgNjU1MzYgYnl0ZXMpCjw2PlsgICAgMC4x
NTkxMThdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQo8Nj5bICAgIDAuMTcxNzQz
XSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNhYmxlZCBIVCBNU0kgTWFwcGluZwo8Nj5bICAg
IDAuMTcxNzU1XSBwY2kgMDAwMDowMDowNS4wOiBFbmFibGluZyBIVCBNU0kgTWFwcGluZwo8Nj5b
ICAgIDAuMTcxODAwXSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNhYmxlZCBIVCBNU0kgTWFw
cGluZwo8Nj5bICAgIDAuMTcxODA2XSBwY2kgMDAwMDowMDowNS4xOiBFbmFibGluZyBIVCBNU0kg
TWFwcGluZwo8Nj5bICAgIDAuMTcxODUwXSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNhYmxl
ZCBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcxODU2XSBwY2kgMDAwMDowMDowNS4yOiBFbmFi
bGluZyBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcxOTAxXSBwY2kgMDAwMDowMDowMC4wOiBG
b3VuZCBkaXNhYmxlZCBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcxOTA2XSBwY2kgMDAwMDow
MDowNi4wOiBFbmFibGluZyBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcxOTUyXSBwY2kgMDAw
MDowMDowMC4wOiBGb3VuZCBkaXNhYmxlZCBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcxOTU5
XSBwY2kgMDAwMDowMDowNi4xOiBFbmFibGluZyBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcy
MDE3XSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNhYmxlZCBIVCBNU0kgTWFwcGluZwo8Nj5b
ICAgIDAuMTcyMDIzXSBwY2kgMDAwMDowMDowYS4wOiBFbmFibGluZyBIVCBNU0kgTWFwcGluZwo8
Nj5bICAgIDAuMTcyMDc3XSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNhYmxlZCBIVCBNU0kg
TWFwcGluZwo8Nj5bICAgIDAuMTcyMDgzXSBwY2kgMDAwMDowMDowYy4wOiBFbmFibGluZyBIVCBN
U0kgTWFwcGluZwo8Nj5bICAgIDAuMTcyMTM5XSBwY2kgMDAwMDowMDowMC4wOiBGb3VuZCBkaXNh
YmxlZCBIVCBNU0kgTWFwcGluZwo8Nj5bICAgIDAuMTcyMTQ1XSBwY2kgMDAwMDowMDowZi4wOiBF
bmFibGluZyBIVCBNU0kgTWFwcGluZwo8Nz5bICAgIDAuMTcyMTU5XSBwY2kgMDAwMDowMTowNy4w
OiBCb290IHZpZGVvIGRldmljZQo8Nz5bICAgIDAuMTcyMTk4XSBQQ0k6IENMUyAzMiBieXRlcywg
ZGVmYXVsdCA2NAo8Nj5bICAgIDAuMTcyMjQ2XSBVbnBhY2tpbmcgaW5pdHJhbWZzLi4uCjw2Plsg
ICAgMC4zMjM3NTBdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogODY5MmsgZnJlZWQKPDY+WyAgICAw
LjMyODI4Ml0gUENJLURNQTogRGlzYWJsaW5nIEFHUC4KPDY+WyAgICAwLjMyODM2M10gUENJLURN
QTogYXBlcnR1cmUgYmFzZSBAIGUwMDAwMDAwIHNpemUgNjU1MzYgS0IKPDY+WyAgICAwLjMyODM2
N10gUENJLURNQTogdXNpbmcgR0FSVCBJT01NVS4KPDY+WyAgICAwLjMyODM3M10gUENJLURNQTog
UmVzZXJ2aW5nIDY0TUIgb2YgSU9NTVUgYXJlYSBpbiB0aGUgQUdQIGFwZXJ0dXJlCjw2PlsgICAg
MC4zMzE4ODFdIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQgKGRpc2FibGVkKQo8
NT5bICAgIDAuMzMxOTAwXSB0eXBlPTIwMDAgYXVkaXQoMTMwNjcwNzUyNi4zMzA6MSk6IGluaXRp
YWxpemVkCjw2PlsgICAgMC4zNDkzNDZdIEh1Z2VUTEIgcmVnaXN0ZXJlZCAyIE1CIHBhZ2Ugc2l6
ZSwgcHJlLWFsbG9jYXRlZCAwIHBhZ2VzCjw1PlsgICAgMC4zNDk1MjldIFZGUzogRGlzayBxdW90
YXMgZHF1b3RfNi41LjIKPDQ+WyAgICAwLjM0OTU2MV0gRHF1b3QtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiA1MTIgKG9yZGVyIDAsIDQwOTYgYnl0ZXMpCjw2PlsgICAgMC4zNDk2OTldIG1zZ21u
aSBoYXMgYmVlbiBzZXQgdG8gNzkxMgo8Nj5bICAgIDAuMzQ5Nzc1XSBCbG9jayBsYXllciBTQ1NJ
IGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjUzKQo8Nj5b
ICAgIDAuMzQ5NzgwXSBpbyBzY2hlZHVsZXIgbm9vcCByZWdpc3RlcmVkCjw2PlsgICAgMC4zNDk3
ODNdIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkCjw2PlsgICAgMC4zNDk4MDFdIGlv
IHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkKPDc+WyAgICAwLjM0OTg4Nl0gcGNp
ZXBvcnQgMDAwMDowMDowYS4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKPDc+WyAgICAw
LjM0OTkwN10gcGNpZXBvcnQgMDAwMDowMDowYS4wOiBpcnEgNDAgZm9yIE1TSS9NU0ktWAo8Nz5b
ICAgIDAuMzQ5OTMzXSBwY2llcG9ydCAwMDAwOjAwOjBjLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1l
ciB0byA2NAo8Nz5bICAgIDAuMzQ5OTQ4XSBwY2llcG9ydCAwMDAwOjAwOjBjLjA6IGlycSA0MSBm
b3IgTVNJL01TSS1YCjw3PlsgICAgMC4zNDk5NzJdIHBjaWVwb3J0IDAwMDA6MDA6MGYuMDogc2V0
dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cjw3PlsgICAgMC4zNDk5ODddIHBjaWVwb3J0IDAwMDA6
MDA6MGYuMDogaXJxIDQyIGZvciBNU0kvTVNJLVgKPDc+WyAgICAwLjM1MDAzNl0gcGNpZXBvcnQg
MDAwMDowNDowMC4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKPDc+WyAgICAwLjM1MDA2
Nl0gcGNpZXBvcnQgMDAwMDowNDowMC4wOiBpcnEgNDMgZm9yIE1TSS9NU0ktWAo8Nz5bICAgIDAu
MzUwMTA4XSBwY2llcG9ydCAwMDAwOjA1OjAxLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2
NAo8Nz5bICAgIDAuMzUwMTM2XSBwY2llcG9ydCAwMDAwOjA1OjAxLjA6IGlycSA0NCBmb3IgTVNJ
L01TSS1YCjw3PlsgICAgMC4zNTAxNzhdIHBjaWVwb3J0IDAwMDA6MDU6MDUuMDogc2V0dGluZyBs
YXRlbmN5IHRpbWVyIHRvIDY0Cjw3PlsgICAgMC4zNTAyMDZdIHBjaWVwb3J0IDAwMDA6MDU6MDUu
MDogaXJxIDQ1IGZvciBNU0kvTVNJLVgKPDc+WyAgICAwLjM1MDI0OF0gcGNpZXBvcnQgMDAwMDow
NTowNy4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKPDc+WyAgICAwLjM1MDI3Nl0gcGNp
ZXBvcnQgMDAwMDowNTowNy4wOiBpcnEgNDYgZm9yIE1TSS9NU0ktWAo8Nz5bICAgIDAuMzUwMzE5
XSBwY2llcG9ydCAwMDAwOjA1OjA5LjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nz5b
ICAgIDAuMzUwMzQ3XSBwY2llcG9ydCAwMDAwOjA1OjA5LjA6IGlycSA0NyBmb3IgTVNJL01TSS1Y
Cjw2PlsgICAgMC4zNTA0NTddIHZlc2FmYjogbW9kZSBpcyAxMDI0eDc2OHgxNiwgbGluZWxlbmd0
aD0yMDQ4LCBwYWdlcz05Cjw2PlsgICAgMC4zNTA0NjFdIHZlc2FmYjogc2Nyb2xsaW5nOiByZWRy
YXcKPDY+WyAgICAwLjM1MDQ2NV0gdmVzYWZiOiBUcnVlY29sb3I6IHNpemU9MDo1OjY6NSwgc2hp
ZnQ9MDoxMTo1OjAKPDY+WyAgICAwLjM1MDc0MF0gdmVzYWZiOiBmcmFtZWJ1ZmZlciBhdCAweGY4
MDAwMDAwLCBtYXBwZWQgdG8gMHhmZmZmYzkwMDA0MTAwMDAwLCB1c2luZyAzMDcyaywgdG90YWwg
MTYzODRrCjw2PlsgICAgMC40MTAxNjZdIENvbnNvbGU6IHN3aXRjaGluZyB0byBjb2xvdXIgZnJh
bWUgYnVmZmVyIGRldmljZSAxMjh4NDgKPDY+WyAgICAwLjQ3MDIwN10gZmIwOiBWRVNBIFZHQSBm
cmFtZSBidWZmZXIgZGV2aWNlCjw2PlsgICAgMC40NzA5NTZdIFNlcmlhbDogODI1MC8xNjU1MCBk
cml2ZXIsIDggcG9ydHMsIElSUSBzaGFyaW5nIGRpc2FibGVkCjw2PlsgICAgMC40OTIxNDRdIHNl
cmlhbDgyNTA6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCkgaXMgYSAxNjU1MEEKPDY+WyAg
ICAwLjYzMjg4OF0gMDA6MDg6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCkgaXMgYSAxNjU1
MEEKPDY+WyAgICAwLjY0ODU3OF0gTm9uLXZvbGF0aWxlIG1lbW9yeSBkcml2ZXIgdjEuMwo8Nj5b
ICAgIDAuNjQ5MDU2XSBMaW51eCBhZ3BnYXJ0IGludGVyZmFjZSB2MC4xMDMKPDc+WyAgICAwLjY0
OTU1OF0gcGF0YV9hbWQgMDAwMDowMDowNC4wOiB2ZXJzaW9uIDAuNC4xCjw3PlsgICAgMC42NDk1
OTBdIHBhdGFfYW1kIDAwMDA6MDA6MDQuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cjw2
PlsgICAgMC42NDk4MDddIHNjc2kwIDogcGF0YV9hbWQKPDY+WyAgICAwLjY1MDIwOF0gc2NzaTEg
OiBwYXRhX2FtZAo8Nj5bICAgIDAuNjUwOTg4XSBhdGExOiBQQVRBIG1heCBVRE1BLzEzMyBjbWQg
MHgxZjAgY3RsIDB4M2Y2IGJtZG1hIDB4ZmMwMCBpcnEgMTQKPDY+WyAgICAwLjY1MTc2N10gYXRh
MjogUEFUQSBtYXggVURNQS8xMzMgY21kIDB4MTcwIGN0bCAweDM3NiBibWRtYSAweGZjMDggaXJx
IDE1Cjw2PlsgICAgMC42NTI2MTddIEZpeGVkIE1ESU8gQnVzOiBwcm9iZWQKPDY+WyAgICAwLjY1
MzAyOF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBsaWJ1c3VhbAo8
Nj5bICAgIDAuNjU4MzMwXSBpODA0MjogUE5QOiBQUy8yIENvbnRyb2xsZXIgW1BOUDAzMDM6UFMy
S10gYXQgMHg2MCwweDY0IGlycSAxCjw0PlsgICAgMC42NTkwOTRdIGk4MDQyOiBQTlA6IFBTLzIg
YXBwZWFycyB0byBoYXZlIEFVWCBwb3J0IGRpc2FibGVkLCBpZiB0aGlzIGlzIGluY29ycmVjdCBw
bGVhc2UgYm9vdCB3aXRoIGk4MDQyLm5vcG5wCjw2PlsgICAgMC42NjAzNzRdIHNlcmlvOiBpODA0
MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKPDY+WyAgICAwLjY2MTAxN10gbW91c2VkZXY6
IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKPDY+WyAgICAwLjY2MTc2Ml0g
cnRjX2Ntb3MgMDA6MDU6IFJUQyBjYW4gd2FrZSBmcm9tIFM0Cjw2PlsgICAgMC42NzA0MzJdIHJ0
Y19jbW9zIDAwOjA1OiBydGMgY29yZTogcmVnaXN0ZXJlZCBydGNfY21vcyBhcyBydGMwCjw2Plsg
ICAgMC42NzExNTRdIHJ0YzA6IGFsYXJtcyB1cCB0byBvbmUgeWVhciwgeTNrLCAyNDIgYnl0ZXMg
bnZyYW0sIGhwZXQgaXJxcwo8Nj5bICAgIDAuNjcxOTE1XSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5v
ciBsYWRkZXIKPDY+WyAgICAwLjY3MjM3NV0gY3B1aWRsZTogdXNpbmcgZ292ZXJub3IgbWVudQo8
Nj5bICAgIDAuNjczMDM1XSBUQ1AgY3ViaWMgcmVnaXN0ZXJlZAo8NT5bICAgIDAuNjczNDA2XSBS
ZWdpc3RlcmluZyB0aGUgZG5zX3Jlc29sdmVyIGtleSB0eXBlCjw3PlsgICAgMC42OTU2NzhdIFBN
OiBIaWJlcm5hdGlvbiBpbWFnZSBub3QgcHJlc2VudCBvciBjb3VsZCBub3QgYmUgbG9hZGVkLgo8
Nj5bICAgIDAuNjk1NjkwXSByZWdpc3RlcmVkIHRhc2tzdGF0cyB2ZXJzaW9uIDEKPDY+WyAgICAw
LjcxODE5M10gICBNYWdpYyBudW1iZXI6IDExOjc3ODozNTEKPDY+WyAgICAwLjc0MDMyNV0gaW5w
dXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQgYXMgL2RldmljZXMvcGxhdGZvcm0vaTgw
NDIvc2VyaW8wL2lucHV0L2lucHV0MAo8Nj5bICAgIDAuNzYzMzU2XSBydGNfY21vcyAwMDowNTog
c2V0dGluZyBzeXN0ZW0gY2xvY2sgdG8gMjAxMS0wNS0yOSAyMjoxODo0NyBVVEMgKDEzMDY3MDc1
MjcpCjw2PlsgICAgMC44Mjc4NTZdIGF0YTEuMDA6IEFUQS04OiBXREMgV0Q1MDAwQUFLQi0wMEg4
QTAsIDA1LjA0RTA1LCBtYXggVURNQS8xMzMKPDY+WyAgICAwLjg1MTQ5NF0gYXRhMS4wMDogOTc2
NzczMTY4IHNlY3RvcnMsIG11bHRpIDE6IExCQTQ4IAo8Nz5bICAgIDAuODc1MTQ1XSBhdGExOiBu
dl9tb2RlX2ZpbHRlcjogMHg3ZjM5ZiYweDdmMzlmLT4weDdmMzlmLCBCSU9TPTB4N2YwMDAgKDB4
YzcwMDAwMDApIEFDUEk9MHg3ZjAxZiAoMTU6NjAwOjB4MTMpCjw2PlsgICAgMC44ODE5OTNdIGF0
YTEuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzCjw1PlsgICAgMC45MDU1NTJdIHNjc2kgMDow
OjA6MDogRGlyZWN0LUFjY2VzcyAgICAgQVRBICAgICAgV0RDIFdENTAwMEFBS0ItMCAwNS4wIFBR
OiAwIEFOU0k6IDUKPDU+WyAgICAwLjkyOTY1OF0gc2QgMDowOjA6MDogW3NkYV0gOTc2NzczMTY4
IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoNTAwIEdCLzQ2NSBHaUIpCjw3PlsgICAgMC45Mjk2
OTVdIGF0YTI6IHBvcnQgZGlzYWJsZWQuIGlnbm9yaW5nLgo8NT5bICAgIDAuOTUzNzU3XSBzZCAw
OjA6MDowOiBbc2RhXSBXcml0ZSBQcm90ZWN0IGlzIG9mZgo8Nz5bICAgIDAuOTc3NDcyXSBzZCAw
OjA6MDowOiBbc2RhXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMAo8NT5bICAgIDAuOTc3NDkwXSBz
ZCAwOjA6MDowOiBbc2RhXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxl
ZCwgZG9lc24ndCBzdXBwb3J0IERQTyBvciBGVUEKPDY+WyAgICAxLjAwMTg3M10gc2RhOiBkZXRl
Y3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDUwMDEwNzg2MjAxNgo8Nj5bICAgIDEuMDYw
NjQ1XSAgc2RhOiBzZGExIHNkYTIgc2RhMwo8NT5bICAgIDEuMDg0NjgzXSBzZCAwOjA6MDowOiBb
c2RhXSBBdHRhY2hlZCBTQ1NJIGRpc2sKPDY+WyAgICAxLjEwOTQ1M10gRnJlZWluZyB1bnVzZWQg
a2VybmVsIG1lbW9yeTogNTM2ayBmcmVlZAo8Nj5bICAgIDEuMTMzMjUzXSBXcml0ZSBwcm90ZWN0
aW5nIHRoZSBrZXJuZWwgcmVhZC1vbmx5IGRhdGE6IDgxOTJrCjw2PlsgICAgMS4xNjMwOTVdIEZy
ZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE5MjhrIGZyZWVkCjw2PlsgICAgMS4xODgyNTVd
IEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDUyayBmcmVlZAo8Nz5bICAgIDEuMjkzNzA1
XSBzYXRhX252IDAwMDA6MDA6MDUuMDogdmVyc2lvbiAzLjUKPDQ+WyAgICAxLjI5MzkxMl0gQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtBUFNJXSBlbmFibGVkIGF0IElSUSAyMwo8Nj5bICAgIDEu
MzE3OTI5XSBzYXRhX252IDAwMDA6MDA6MDUuMDogUENJIElOVCBBIC0+IExpbmtbQVBTSV0gLT4g
R1NJIDIzIChsZXZlbCwgbG93KSAtPiBJUlEgMjMKPDU+WyAgICAxLjM0MjM3Ml0gc2F0YV9udiAw
MDAwOjAwOjA1LjA6IFVzaW5nIFNXTkNRIG1vZGUKPDc+WyAgICAxLjM2NjQ4MF0gc2F0YV9udiAw
MDAwOjAwOjA1LjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nj5bICAgIDEuMzY2NzU4
XSBzY3NpMiA6IHNhdGFfbnYKPDY+WyAgICAxLjM5MDIwMF0gc2NzaTMgOiBzYXRhX252Cjw2Plsg
ICAgMS40MTMyMjBdIGF0YTM6IFNBVEEgbWF4IFVETUEvMTMzIGNtZCAweDlmMCBjdGwgMHhiZjAg
Ym1kbWEgMHhmNzAwIGlycSAyMwo8Nj5bICAgIDEuNDM2NjEzXSBhdGE0OiBTQVRBIG1heCBVRE1B
LzEzMyBjbWQgMHg5NzAgY3RsIDB4YjcwIGJtZG1hIDB4ZjcwOCBpcnEgMjMKPDQ+WyAgICAxLjQ1
OTc2Ml0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBUFNKXSBlbmFibGVkIGF0IElSUSAyMgo8
Nj5bICAgIDEuNDgyNjY5XSBzYXRhX252IDAwMDA6MDA6MDUuMTogUENJIElOVCBCIC0+IExpbmtb
QVBTSl0gLT4gR1NJIDIyIChsZXZlbCwgbG93KSAtPiBJUlEgMjIKPDU+WyAgICAxLjUwNjEzN10g
c2F0YV9udiAwMDAwOjAwOjA1LjE6IFVzaW5nIFNXTkNRIG1vZGUKPDc+WyAgICAxLjUyOTY2MF0g
c2F0YV9udiAwMDAwOjAwOjA1LjE6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nj5bICAg
IDEuNTI5OTIxXSBzY3NpNCA6IHNhdGFfbnYKPDY+WyAgICAxLjU1MzEwOF0gc2NzaTUgOiBzYXRh
X252Cjw2PlsgICAgMS41NzYzNjBdIGF0YTU6IFNBVEEgbWF4IFVETUEvMTMzIGNtZCAweDllMCBj
dGwgMHhiZTAgYm1kbWEgMHhmMjAwIGlycSAyMgo8Nj5bICAgIDEuNTk5OTk1XSBhdGE2OiBTQVRB
IG1heCBVRE1BLzEzMyBjbWQgMHg5NjAgY3RsIDB4YjYwIGJtZG1hIDB4ZjIwOCBpcnEgMjIKPDQ+
WyAgICAxLjYwMDE4NF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtBU0EyXSBlbmFibGVkIGF0
IElSUSAyMQo8Nj5bICAgIDEuNjAwMjAyXSBzYXRhX252IDAwMDA6MDA6MDUuMjogUENJIElOVCBD
IC0+IExpbmtbQVNBMl0gLT4gR1NJIDIxIChsZXZlbCwgbG93KSAtPiBJUlEgMjEKPDU+WyAgICAx
LjYwMDIwNV0gc2F0YV9udiAwMDAwOjAwOjA1LjI6IFVzaW5nIFNXTkNRIG1vZGUKPDc+WyAgICAx
LjYwMDQ2M10gc2F0YV9udiAwMDAwOjAwOjA1LjI6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2
NAo8Nj5bICAgIDEuNjAwNzE0XSBzY3NpNiA6IHNhdGFfbnYKPDY+WyAgICAxLjYwMDc5MF0gc2Nz
aTcgOiBzYXRhX252Cjw2PlsgICAgMS42MDA5MDFdIGF0YTc6IFNBVEEgbWF4IFVETUEvMTMzIGNt
ZCAweGYxMDAgY3RsIDB4ZjAwMCBibWRtYSAweGVkMDAgaXJxIDIxCjw2PlsgICAgMS42MDA5MDVd
IGF0YTg6IFNBVEEgbWF4IFVETUEvMTMzIGNtZCAweGVmMDAgY3RsIDB4ZWUwMCBibWRtYSAweGVk
MDggaXJxIDIxCjw2PlsgICAgMS45MTMyMTVdIGF0YTM6IFNBVEEgbGluayB1cCAzLjAgR2JwcyAo
U1N0YXR1cyAxMjMgU0NvbnRyb2wgMzAwKQo8Nj5bICAgIDEuOTY1ODk3XSBhdGEzLjAwOiBBVEEt
ODogU1QzMTUwMDM0MUFTLCBDQzFILCBtYXggVURNQS8xMzMKPDY+WyAgICAxLjk4ODEzM10gYXRh
My4wMDogMjkzMDI3NzE2OCBzZWN0b3JzLCBtdWx0aSAxOiBMQkE0OCBOQ1EgKGRlcHRoIDMxLzMy
KQo8Nj5bICAgIDIuMDM4MTEyXSBhdGEzLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwo8Nj5b
ICAgIDIuMDYwNjA4XSBhdGE1OiBTQVRBIGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFND
b250cm9sIDMwMCkKPDY+WyAgICAyLjA4MzU4OF0gYXRhNzogU0FUQSBsaW5rIHVwIDEuNSBHYnBz
IChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApCjw1PlsgICAgMi4xMDY0OTBdIHNjc2kgMjowOjA6
MDogRGlyZWN0LUFjY2VzcyAgICAgQVRBICAgICAgU1QzMTUwMDM0MUFTICAgICBDQzFIIFBROiAw
IEFOU0k6IDUKPDY+WyAgICAyLjEyOTkzMF0gYXRhNy4wMDogQVRBLTg6IEhpdGFjaGkgSERTNzIz
MDMwQUxBNjQwLCBNS0FPQTU4MCwgbWF4IFVETUEvMTMzCjw1PlsgICAgMi4xMzAwMzJdIHNkIDI6
MDowOjA6IFtzZGJdIDI5MzAyNzcxNjggNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgxLjUwIFRC
LzEuMzYgVGlCKQo8NT5bICAgIDIuMTMwMDcyXSBzZCAyOjA6MDowOiBbc2RiXSBXcml0ZSBQcm90
ZWN0IGlzIG9mZgo8Nz5bICAgIDIuMTMwMDc0XSBzZCAyOjA6MDowOiBbc2RiXSBNb2RlIFNlbnNl
OiAwMCAzYSAwMCAwMAo8NT5bICAgIDIuMTMwMDkxXSBzZCAyOjA6MDowOiBbc2RiXSBXcml0ZSBj
YWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBv
ciBGVUEKPDY+WyAgICAyLjEzMDIzNl0gc2RiOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJv
bSAwIHRvIDE1MDAzMDE5MTAwMTYKPDY+WyAgICAyLjE1MjYzNF0gIHNkYjogc2RiMQo8Nj5bICAg
IDIuMjY4NDIxXSBhdGE3LjAwOiA1ODYwNTMzMTY4IHNlY3RvcnMsIG11bHRpIDE6IExCQTQ4IE5D
USAoZGVwdGggMzEvMzIpCjw1PlsgICAgMi4yNjg1MTBdIHNkIDI6MDowOjA6IFtzZGJdIEF0dGFj
aGVkIFNDU0kgZGlzawo8Nj5bICAgIDIuMjY4NTM0XSBhdGE1LjAwOiBBVEEtODogU1QzMTUwMDM0
MUFTLCBDQzFILCBtYXggVURNQS8xMzMKPDY+WyAgICAyLjI2ODUzNl0gYXRhNS4wMDogMjkzMDI3
NzE2OCBzZWN0b3JzLCBtdWx0aSAxOiBMQkE0OCBOQ1EgKGRlcHRoIDMxLzMyKQo8Nj5bICAgIDIu
MzY2NTcxXSBhdGE3LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwo8Nj5bICAgIDIuMzkxOTM5
XSBhdGE1LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwo8Nj5bICAgIDIuNzIyMzE2XSBhdGE0
OiBTQVRBIGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMwMCkKPDY+WyAg
ICAyLjc3NTAyNF0gYXRhNC4wMDogQVRBLTg6IFNUMzE1MDAzNDFBUywgQ0MxSCwgbWF4IFVETUEv
MTMzCjw2PlsgICAgMi43OTczNjhdIGF0YTQuMDA6IDI5MzAyNzcxNjggc2VjdG9ycywgbXVsdGkg
MTogTEJBNDggTkNRIChkZXB0aCAzMS8zMikKPDY+WyAgICAyLjg2ODg4MF0gYXRhNC4wMDogY29u
ZmlndXJlZCBmb3IgVURNQS8xMzMKPDU+WyAgICAyLjg5MTI2NF0gc2NzaSAzOjA6MDowOiBEaXJl
Y3QtQWNjZXNzICAgICBBVEEgICAgICBTVDMxNTAwMzQxQVMgICAgIENDMUggUFE6IDAgQU5TSTog
NQo8NT5bICAgIDIuOTE0NTM2XSBzZCAzOjA6MDowOiBbc2RjXSAyOTMwMjc3MTY4IDUxMi1ieXRl
IGxvZ2ljYWwgYmxvY2tzOiAoMS41MCBUQi8xLjM2IFRpQikKPDU+WyAgICAyLjkzNzk5M10gc2Qg
MzowOjA6MDogW3NkY10gV3JpdGUgUHJvdGVjdCBpcyBvZmYKPDU+WyAgICAyLjkzNzk5OF0gc2Nz
aSA0OjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBTVDMxNTAwMzQxQVMgICAgIEND
MUggUFE6IDAgQU5TSTogNQo8NT5bICAgIDIuOTM4MTUyXSBzZCA0OjA6MDowOiBbc2RkXSAyOTMw
Mjc3MTY4IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoMS41MCBUQi8xLjM2IFRpQikKPDU+WyAg
ICAyLjkzODE4OV0gc2QgNDowOjA6MDogW3NkZF0gV3JpdGUgUHJvdGVjdCBpcyBvZmYKPDc+WyAg
ICAyLjkzODE5MV0gc2QgNDowOjA6MDogW3NkZF0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKPDU+
WyAgICAyLjkzODIwN10gc2QgNDowOjA6MDogW3NkZF0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJl
YWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBCjw2PlsgICAgMi45
MzgzMjFdIHNkZDogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAxNTAwMzAxOTEw
MDE2Cjw2PlsgICAgMi45NDYxMjJdICBzZGQ6IHNkZDEKPDc+WyAgICAzLjEwMzMxM10gc2QgMzow
OjA6MDogW3NkY10gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKPDU+WyAgICAzLjEwMzM1Ml0gc2Qg
MzowOjA6MDogW3NkY10gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQs
IGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBCjw1PlsgICAgMy4xMDM0MDhdIHNkIDQ6MDowOjA6
IFtzZGRdIEF0dGFjaGVkIFNDU0kgZGlzawo8Nj5bICAgIDMuMTUzMzA1XSBzZGM6IGRldGVjdGVk
IGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMTUwMDMwMTkxMDAxNgo8Nj5bICAgIDMuMTgzMDk5
XSAgc2RjOiBzZGMxCjw1PlsgICAgMy4yMDc0OTVdIHNkIDM6MDowOjA6IFtzZGNdIEF0dGFjaGVk
IFNDU0kgZGlzawo8Nj5bICAgIDMuNTU3MjE4XSBhdGE2OiBTQVRBIGxpbmsgdXAgMy4wIEdicHMg
KFNTdGF0dXMgMTIzIFNDb250cm9sIDMwMCkKPDY+WyAgICAzLjU4NTgwOF0gYXRhNi4wMDogQVRB
LTg6IFNUMzEwMDAzMzNBUywgU0QxQiwgbWF4IFVETUEvMTMzCjw2PlsgICAgMy42MTA3MDZdIGF0
YTYuMDA6IDE5NTM1MjUxNjggc2VjdG9ycywgbXVsdGkgMTogTEJBNDggTkNRIChkZXB0aCAzMS8z
MikKPDY+WyAgICAzLjY0Mjc1Nl0gYXRhNi4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMzMKPDU+
WyAgICAzLjY2NzkzMF0gc2NzaSA1OjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBT
VDMxMDAwMzMzQVMgICAgIFNEMUIgUFE6IDAgQU5TSTogNQo8NT5bICAgIDMuNjkzNDI1XSBzZCA1
OjA6MDowOiBbc2RlXSAxOTUzNTI1MTY4IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoMS4wMCBU
Qi85MzEgR2lCKQo8NT5bICAgIDMuNzE5MTI0XSBzZCA1OjA6MDowOiBbc2RlXSBXcml0ZSBQcm90
ZWN0IGlzIG9mZgo8NT5bICAgIDMuNzE5MTQxXSBzY3NpIDY6MDowOjA6IERpcmVjdC1BY2Nlc3Mg
ICAgIEFUQSAgICAgIEhpdGFjaGkgSERTNzIzMDMgTUtBTyBQUTogMCBBTlNJOiA1Cjw1PlsgICAg
My43MTkyNjNdIHNkIDY6MDowOjA6IFtzZGZdIDU4NjA1MzMxNjggNTEyLWJ5dGUgbG9naWNhbCBi
bG9ja3M6ICgzLjAwIFRCLzIuNzIgVGlCKQo8NT5bICAgIDMuNzE5Mjk2XSBzZCA2OjA6MDowOiBb
c2RmXSBXcml0ZSBQcm90ZWN0IGlzIG9mZgo8Nz5bICAgIDMuNzE5Mjk5XSBzZCA2OjA6MDowOiBb
c2RmXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMAo8NT5bICAgIDMuNzE5MzE0XSBzZCA2OjA6MDow
OiBbc2RmXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24n
dCBzdXBwb3J0IERQTyBvciBGVUEKPDY+WyAgICAzLjcxOTQyOF0gc2RmOiBkZXRlY3RlZCBjYXBh
Y2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDMwMDA1OTI5ODIwMTYKPDY+WyAgICAzLjc1MTMwMF0gIHNk
Zjogc2RmMQo8Nz5bICAgIDMuOTAzOTg2XSBzZCA1OjA6MDowOiBbc2RlXSBNb2RlIFNlbnNlOiAw
MCAzYSAwMCAwMAo8NT5bICAgIDMuOTA0MDI0XSBzZCA1OjA6MDowOiBbc2RlXSBXcml0ZSBjYWNo
ZTogZW5hYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBvciBG
VUEKPDU+WyAgICAzLjkwNDE1Nl0gc2QgNjowOjA6MDogW3NkZl0gQXR0YWNoZWQgU0NTSSBkaXNr
Cjw2PlsgICAgMy45NTg3MzhdIHNkZTogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0
byAxMDAwMjA0ODg2MDE2Cjw2PlsgICAgNC4wMDk5NDFdICBzZGU6IHNkZTEKPDU+WyAgICA0LjAz
NzI5Nl0gc2QgNTowOjA6MDogW3NkZV0gQXR0YWNoZWQgU0NTSSBkaXNrCjw2PlsgICAgNC4zNTgy
MTNdIGF0YTg6IFNBVEEgbGluayB1cCAzLjAgR2JwcyAoU1N0YXR1cyAxMjMgU0NvbnRyb2wgMzAw
KQo8Nj5bICAgIDQuNDE1OTI1XSBhdGE4LjAwOiBBVEEtODogU1QzMTAwMDMzM0FTLCBTRDM1LCBt
YXggVURNQS8xMzMKPDY+WyAgICA0LjQ0Mjg3OF0gYXRhOC4wMDogMTk1MzUyNTE2OCBzZWN0b3Jz
LCBtdWx0aSAxOiBMQkE0OCBOQ1EgKGRlcHRoIDMxLzMyKQo8Nj5bICAgIDQuNTE5ODY3XSBhdGE4
LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwo8NT5bICAgIDQuNTQ2NTA2XSBzY3NpIDc6MDow
OjA6IERpcmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIFNUMzEwMDAzMzNBUyAgICAgU0QzNSBQUTog
MCBBTlNJOiA1Cjw1PlsgICAgNC41NzM3MDNdIHNkIDc6MDowOjA6IFtzZGddIDE5NTM1MjUxNjgg
NTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgxLjAwIFRCLzkzMSBHaUIpCjw1PlsgICAgNC42MDA5
MTZdIHNkIDc6MDowOjA6IFtzZGddIFdyaXRlIFByb3RlY3QgaXMgb2ZmCjw3PlsgICAgNC42Mjc2
OTBdIHNkIDc6MDowOjA6IFtzZGddIE1vZGUgU2Vuc2U6IDAwIDNhIDAwIDAwCjw1PlsgICAgNC42
Mjc3MDddIHNkIDc6MDowOjA6IFtzZGddIFdyaXRlIGNhY2hlOiBlbmFibGVkLCByZWFkIGNhY2hl
OiBlbmFibGVkLCBkb2Vzbid0IHN1cHBvcnQgRFBPIG9yIEZVQQo8Nj5bICAgIDQuNjU1MTc1XSBz
ZGc6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMTAwMDIwNDg4NjAxNgo8Nj5b
ICAgIDQuNzA4OTQxXSAgc2RnOiBzZGcxCjw1PlsgICAgNC43MzYwODZdIHNkIDc6MDowOjA6IFtz
ZGddIEF0dGFjaGVkIFNDU0kgZGlzawo8Nz5bICAgIDQuNzcxMDI2XSBBQ1BJOiBhY3BpX2lkbGUg
cmVnaXN0ZXJlZCB3aXRoIGNwdWlkbGUKPDU+WyAgICA0Ljc3MTA2N10gQUNQSTogcHJvY2Vzc29y
IGxpbWl0ZWQgdG8gbWF4IEMtc3RhdGUgMQo8ND5bICAgIDQuODAxNjg1XSBBQ1BJIFdhcm5pbmc6
IEZvciBcX1RaXy5USFJNLl9QU0w6IFJldHVybiBQYWNrYWdlIHR5cGUgbWlzbWF0Y2ggYXQgaW5k
ZXggMCAtIGZvdW5kIFtOVUxMIE9iamVjdCBEZXNjcmlwdG9yXSwgZXhwZWN0ZWQgUmVmZXJlbmNl
ICgyMDExMDMxNi9uc3ByZWRlZi0xMDU5KQo8Mz5bICAgIDQuODU4NDk0XSBBQ1BJOiBFeHBlY3Rp
bmcgYSBbUmVmZXJlbmNlXSBwYWNrYWdlIGVsZW1lbnQsIGZvdW5kIHR5cGUgMAo8ND5bICAgIDQu
ODg3MjEyXSBBQ1BJOiBJbnZhbGlkIHBhc3NpdmUgdGhyZXNob2xkCjw2PlsgICAgNC45MTU3MDNd
IHRoZXJtYWwgTE5YVEhFUk06MDA6IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96b25lMAo8Nj5bICAg
IDQuOTQzOTk2XSBBQ1BJOiBUaGVybWFsIFpvbmUgW1RIUk1dICg0MCBDKQo8Nj5bICAgIDQuOTky
MjIxXSBVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZlcgo8Nj5bICAgIDUuMDI2MTEy
XSBBQ1BJOiBGYW4gW0ZBTl0gKG9uKQo8Nj5bICAgIDUuMTEzNTMzXSBCSU9TIEVERCBmYWNpbGl0
eSB2MC4xNiAyMDA0LUp1bi0yNSwgMTAgZGV2aWNlcyBmb3VuZAo8ND5bICAgIDUuMTcxMTkyXSB1
ZGV2ZCAoNzkpOiAvcHJvYy83OS9vb21fYWRqIGlzIGRlcHJlY2F0ZWQsIHBsZWFzZSB1c2UgL3By
b2MvNzkvb29tX3Njb3JlX2FkaiBpbnN0ZWFkLgo8Nj5bICAgIDUuMTk4OTA5XSB1ZGV2ZCB2ZXJz
aW9uIDEyOCBzdGFydGVkCjw2PlsgICAgNS4yOTM0NDhdIGVoY2lfaGNkOiBVU0IgMi4wICdFbmhh
bmNlZCcgSG9zdCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIKPDQ+WyAgICA1LjMyODMwOV0gQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtBUENMXSBlbmFibGVkIGF0IElSUSAyMAo8Nj5bICAgIDUu
MzQ2MTIwXSBvaGNpX2hjZDogVVNCIDEuMSAnT3BlbicgSG9zdCBDb250cm9sbGVyIChPSENJKSBE
cml2ZXIKPDY+WyAgICA1LjQwNzcyM10gZWhjaV9oY2QgMDAwMDowMDowMi4xOiBQQ0kgSU5UIEIg
LT4gTGlua1tBUENMXSAtPiBHU0kgMjAgKGxldmVsLCBsb3cpIC0+IElSUSAyMAo8Nz5bICAgIDUu
NDg0MzY4XSBlaGNpX2hjZCAwMDAwOjAwOjAyLjE6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2
NAo8Nj5bICAgIDUuNDg0MzczXSBlaGNpX2hjZCAwMDAwOjAwOjAyLjE6IEVIQ0kgSG9zdCBDb250
cm9sbGVyCjw2PlsgICAgNS41MTk0NjhdIGVoY2lfaGNkIDAwMDA6MDA6MDIuMTogbmV3IFVTQiBi
dXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxCjw2PlsgICAgNS41NTkxMDZdIGVo
Y2lfaGNkIDAwMDA6MDA6MDIuMTogZGVidWcgcG9ydCAxCjw3PlsgICAgNS41ODY4NzddIGVoY2lf
aGNkIDAwMDA6MDA6MDIuMTogY2FjaGUgbGluZSBzaXplIG9mIDMyIGlzIG5vdCBzdXBwb3J0ZWQK
PDY+WyAgICA1LjU4Njk4M10gZWhjaV9oY2QgMDAwMDowMDowMi4xOiBpcnEgMjAsIGlvIG1lbSAw
eGZlMDJlMDAwCjw0PlsgICAgNS41OTAwMDldIENFOiBocGV0IGluY3JlYXNlZCBtaW5fZGVsdGFf
bnMgdG8gMTE1MjAgbnNlYwo8Nj5bICAgIDUuNjQ3MDMyXSBlaGNpX2hjZCAwMDAwOjAwOjAyLjE6
IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAwCjw2PlsgICAgNS42NzQ5OTBdIHVzYiB1c2IxOiBO
ZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MWQ2YiwgaWRQcm9kdWN0PTAwMDIKPDY+WyAg
ICA1LjcwMjUyMl0gdXNiIHVzYjE6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9k
dWN0PTIsIFNlcmlhbE51bWJlcj0xCjw2PlsgICAgNS43Mjk4MjJdIHVzYiB1c2IxOiBQcm9kdWN0
OiBFSENJIEhvc3QgQ29udHJvbGxlcgo8Nj5bICAgIDUuNzU2ODk5XSB1c2IgdXNiMTogTWFudWZh
Y3R1cmVyOiBMaW51eCAyLjYuMzktSU1FVi0xMTA0MDggZWhjaV9oY2QKPDY+WyAgICA1Ljc4NDA3
NV0gdXNiIHVzYjE6IFNlcmlhbE51bWJlcjogMDAwMDowMDowMi4xCjw2PlsgICAgNS44MTEwNTdd
IGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kCjw2PlsgICAgNS44Mzc1NjJdIGh1YiAxLTA6MS4w
OiAxMCBwb3J0cyBkZXRlY3RlZAo8ND5bICAgIDUuODYzNzgxXSBBQ1BJOiBQQ0kgSW50ZXJydXB0
IExpbmsgW0FQQ0ZdIGVuYWJsZWQgYXQgSVJRIDIzCjw2PlsgICAgNS44ODk3MzldIG9oY2lfaGNk
IDAwMDA6MDA6MDIuMDogUENJIElOVCBBIC0+IExpbmtbQVBDRl0gLT4gR1NJIDIzIChsZXZlbCwg
bG93KSAtPiBJUlEgMjMKPDc+WyAgICA1LjkxNjE4Nl0gb2hjaV9oY2QgMDAwMDowMDowMi4wOiBz
ZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKPDY+WyAgICA1LjkxNjE4OV0gb2hjaV9oY2QgMDAw
MDowMDowMi4wOiBPSENJIEhvc3QgQ29udHJvbGxlcgo8Nj5bICAgIDUuOTE2MTk2XSBvaGNpX2hj
ZCAwMDAwOjAwOjAyLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1i
ZXIgMgo8Nj5bICAgIDUuOTcxMjA3XSBvaGNpX2hjZCAwMDAwOjAwOjAyLjA6IGlycSAyMywgaW8g
bWVtIDB4ZmUwMmYwMDAKPDY+WyAgICA2LjA1MDIyOV0gdXNiIHVzYjI6IE5ldyBVU0IgZGV2aWNl
IGZvdW5kLCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAwMQo8Nj5bICAgIDYuMDc2NTg3XSB1
c2IgdXNiMjogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTMsIFByb2R1Y3Q9MiwgU2VyaWFs
TnVtYmVyPTEKPDY+WyAgICA2LjA3NjU4OV0gdXNiIHVzYjI6IFByb2R1Y3Q6IE9IQ0kgSG9zdCBD
b250cm9sbGVyCjw2PlsgICAgNi4wNzY1OTFdIHVzYiB1c2IyOiBNYW51ZmFjdHVyZXI6IExpbnV4
IDIuNi4zOS1JTUVWLTExMDQwOCBvaGNpX2hjZAo8Nj5bICAgIDYuMDc2NTkyXSB1c2IgdXNiMjog
U2VyaWFsTnVtYmVyOiAwMDAwOjAwOjAyLjAKPDY+WyAgICA2LjA3NjgzOF0gaHViIDItMDoxLjA6
IFVTQiBodWIgZm91bmQKPDY+WyAgICA2LjA3Njg0N10gaHViIDItMDoxLjA6IDEwIHBvcnRzIGRl
dGVjdGVkCjw2PlsgICAgNi42NDQ4MjldIEVYVDMtZnM6IGJhcnJpZXJzIG5vdCBlbmFibGVkCjw2
PlsgICAgNi42NTIwNDJdIGtqb3VybmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNl
Y29uZHMKPDY+WyAgICA2LjY1MjU0Ml0gRVhUMy1mcyAoc2RhMSk6IHVzaW5nIGludGVybmFsIGpv
dXJuYWwKPDY+WyAgICA2LjY1MjU0NV0gRVhUMy1mcyAoc2RhMSk6IG1vdW50ZWQgZmlsZXN5c3Rl
bSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlCjw2PlsgICAgOC44MjkzMjFdIHVkZXZkIHZlcnNpb24g
MTI4IHN0YXJ0ZWQKPDU+WyAgICA5LjA4NzU0MF0gc2QgMDowOjA6MDogQXR0YWNoZWQgc2NzaSBn
ZW5lcmljIHNnMCB0eXBlIDAKPDY+WyAgICA5LjI2MDMwNV0gaW5wdXQ6IFBDIFNwZWFrZXIgYXMg
L2RldmljZXMvcGxhdGZvcm0vcGNzcGtyL2lucHV0L2lucHV0MQo8NT5bICAgIDkuMjc2MDk5XSBz
ZCAyOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUgMAo8NT5bICAgIDkuMjc2
MTI4XSBzZCAzOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cyIHR5cGUgMAo8NT5bICAg
IDkuMjc2MTU2XSBzZCA0OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2czIHR5cGUgMAo8
NT5bICAgIDkuMjc2MTgyXSBzZCA1OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2c0IHR5
cGUgMAo8NT5bICAgIDkuMjc2MjA4XSBzZCA2OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMg
c2c1IHR5cGUgMAo8NT5bICAgIDkuMjc2MjM1XSBzZCA3OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdl
bmVyaWMgc2c2IHR5cGUgMAo8Nj5bICAgIDkuNDk5Nzc0XSBzYXRhX212IDAwMDA6MDI6MDAuMDog
dmVyc2lvbiAxLjI4Cjw2PlsgICAgOS41MjQ0MjFdIHNhdGFfbXYgMDAwMDowMjowMC4wOiBQQ0kg
SU5UIEEgLT4gTGlua1tBUEM3XSAtPiBHU0kgMTYgKGxldmVsLCBsb3cpIC0+IElSUSAxNgo8Nj5b
ICAgIDkuNTQ5ODE1XSBzYXRhX212IDAwMDA6MDI6MDAuMDogR2VuLUlJRSAzMiBzbG90cyA0IHBv
cnRzIFNDU0kgbW9kZSBJUlEgdmlhIElOVHgKPDc+WyAgICA5LjU3NTA0NV0gc2F0YV9tdiAwMDAw
OjAyOjAwLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nj5bICAgIDkuNTc2OTc0XSBz
Y3NpOCA6IHNhdGFfbXYKPDY+WyAgICA5LjYwMjU1NV0gc2NzaTkgOiBzYXRhX212Cjw2PlsgICAg
OS42Mjc3NTJdIHNjc2kxMCA6IHNhdGFfbXYKPDY+WyAgICA5LjY1MjQ0Nl0gc2NzaTExIDogc2F0
YV9tdgo8Nj5bICAgIDkuNjc2OTk0XSBhdGE5OiBTQVRBIG1heCBVRE1BLzEzMyBtbWlvIG0xMDQ4
NTc2QDB4ZmRkMDAwMDAgcG9ydCAweGZkZDIyMDAwIGlycSAxNgo8Nj5bICAgIDkuNzAxNDgwXSBh
dGExMDogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGZkZDAwMDAwIHBvcnQgMHhm
ZGQyNDAwMCBpcnEgMTYKPDY+WyAgICA5LjcxMTU0M10gcjgxNjkgR2lnYWJpdCBFdGhlcm5ldCBk
cml2ZXIgMi4zTEstTkFQSSBsb2FkZWQKPDQ+WyAgICA5LjcxMTg2MV0gQUNQSTogUENJIEludGVy
cnVwdCBMaW5rIFtBUEMxXSBlbmFibGVkIGF0IElSUSAxNgo8Nj5bICAgIDkuNzExODY3XSByODE2
OSAwMDAwOjAxOjA2LjA6IFBDSSBJTlQgQSAtPiBMaW5rW0FQQzFdIC0+IEdTSSAxNiAobGV2ZWws
IGxvdykgLT4gSVJRIDE2Cjw2PlsgICAgOS43OTk4MDZdIHI4MTY5IDAwMDA6MDE6MDYuMDogKHVu
cmVnaXN0ZXJlZCBuZXRfZGV2aWNlKTogbm8gUENJIEV4cHJlc3MgY2FwYWJpbGl0eQo8Nj5bICAg
IDkuNzk5OTAxXSBhdGExMTogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBtMTA0ODU3NkAweGZkZDAw
MDAwIHBvcnQgMHhmZGQyNjAwMCBpcnEgMTYKPDY+WyAgICA5Ljc5OTkwNl0gYXRhMTI6IFNBVEEg
bWF4IFVETUEvMTMzIG1taW8gbTEwNDg1NzZAMHhmZGQwMDAwMCBwb3J0IDB4ZmRkMjgwMDAgaXJx
IDE2Cjw2PlsgICAgOS44NzUxMDRdIHI4MTY5IDAwMDA6MDE6MDYuMDogZXRoMDogRmVhdHVyZXMg
Y2hhbmdlZDogMHgwMDAwNDk4MCAtPiAweDAwMDA0MTgwCjw3PlsgICAgOS45MDc2OTldIHNhdGFf
c2lsMjQgMDAwMDowMzowMC4wOiB2ZXJzaW9uIDEuMQo8Nj5bICAgIDkuOTA3NzE5XSBzYXRhX3Np
bDI0IDAwMDA6MDM6MDAuMDogUENJIElOVCBBIC0+IExpbmtbQVBDNV0gLT4gR1NJIDE2IChsZXZl
bCwgbG93KSAtPiBJUlEgMTYKPDc+WyAgICA5LjkzMzQ2N10gc2F0YV9zaWwyNCAwMDAwOjAzOjAw
LjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nj5bICAgIDkuOTM1MjM3XSByODE2OSAw
MDAwOjAxOjA2LjA6IGV0aDA6IFJUTDgxMTBzIGF0IDB4ZmZmZmM5MDAwMDA1ODAwMCwgMDA6MDk6
NWI6YmM6YmE6ZTMsIFhJRCAwNDAwMDAwMCBJUlEgMTYKPDY+WyAgICA5LjkzNTYyNl0gc2NzaTEy
IDogc2F0YV9zaWwyNAo8Nj5bICAgIDkuOTM2ODgwXSBzY3NpMTMgOiBzYXRhX3NpbDI0Cjw2Plsg
ICAgOS45MzY5NDldIGF0YTEzOiBTQVRBIG1heCBVRE1BLzEwMCBob3N0IG0xMjhAMHhmZGJmZjAw
MCBwb3J0IDB4ZmRiZjgwMDAgaXJxIDE2Cjw2PlsgICAgOS45MzY5NTRdIGF0YTE0OiBTQVRBIG1h
eCBVRE1BLzEwMCBob3N0IG0xMjhAMHhmZGJmZjAwMCBwb3J0IDB4ZmRiZmEwMDAgaXJxIDE2Cjw2
PlsgICAxMC4wNjAxNTBdIHI4MTY5IEdpZ2FiaXQgRXRoZXJuZXQgZHJpdmVyIDIuM0xLLU5BUEkg
bG9hZGVkCjw0PlsgICAxMC4wODMyNTNdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbQVBDM10g
ZW5hYmxlZCBhdCBJUlEgMTgKPDY+WyAgIDEwLjEwNjEyNF0gcjgxNjkgMDAwMDowMTowOC4wOiBQ
Q0kgSU5UIEEgLT4gTGlua1tBUEMzXSAtPiBHU0kgMTggKGxldmVsLCBsb3cpIC0+IElSUSAxOAo8
Nj5bICAgMTAuMTI5NTM2XSByODE2OSAwMDAwOjAxOjA4LjA6ICh1bnJlZ2lzdGVyZWQgbmV0X2Rl
dmljZSk6IG5vIFBDSSBFeHByZXNzIGNhcGFiaWxpdHkKPDY+WyAgIDEwLjE1Mzc3MF0gcjgxNjkg
MDAwMDowMTowOC4wOiBldGgxOiBGZWF0dXJlcyBjaGFuZ2VkOiAweDAwMDA0OTgwIC0+IDB4MDAw
MDQxODAKPDY+WyAgIDEwLjE1MzkwNl0gaTJjIGkyYy0wOiBuRm9yY2UyIFNNQnVzIGFkYXB0ZXIg
YXQgMHgxYzAwCjw2PlsgICAxMC4xNTM5MjNdIGkyYyBpMmMtMTogbkZvcmNlMiBTTUJ1cyBhZGFw
dGVyIGF0IDB4MWM0MAo8Nj5bICAgMTAuMjA3NjMzXSB4aGNpX2hjZCAwMDAwOjA2OjAwLjA6IFBD
SSBJTlQgQSAtPiBMaW5rW0FQQzddIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2Cjw3
PlsgICAxMC4yNDUxODldIHhoY2lfaGNkIDAwMDA6MDY6MDAuMDogc2V0dGluZyBsYXRlbmN5IHRp
bWVyIHRvIDY0Cjw2PlsgICAxMC4yNDUxOTRdIHhoY2lfaGNkIDAwMDA6MDY6MDAuMDogeEhDSSBI
b3N0IENvbnRyb2xsZXIKPDY+WyAgIDEwLjI0NjE4NV0gcjgxNjkgMDAwMDowMTowOC4wOiBldGgx
OiBSVEw4MTEwcyBhdCAweGZmZmZjOTAwMDAwNjYwMDAsIDAwOjE0OjZjOjc2OjcyOmUyLCBYSUQg
MDQwMDAwMDAgSVJRIDE4Cjw0PlsgICAxMC4yOTIzOThdIGs4dGVtcCAwMDAwOjAwOjE4LjM6IFRl
bXBlcmF0dXJlIHJlYWRvdXRzIG1pZ2h0IGJlIHdyb25nIC0gY2hlY2sgZXJyYXR1bSAjMTQxCjw2
PlsgICAxMC4yOTQwNDBdIHhoY2lfaGNkIDAwMDA6MDY6MDAuMDogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAzCjw2PlsgICAxMC4zNDQ3OTddIGlucHV0OiBQb3dl
ciBCdXR0b24gYXMgL2RldmljZXMvTE5YU1lTVE06MDAvZGV2aWNlOjAwL1BOUDBDMEM6MDAvaW5w
dXQvaW5wdXQyCjw2PlsgICAxMC4zNzAyMjddIHhoY2lfaGNkIDAwMDA6MDY6MDAuMDogaXJxIDE2
LCBpbyBtZW0gMHhmZDlmZTAwMAo8Nj5bICAgMTAuMzczNzY3XSBBQ1BJOiBQb3dlciBCdXR0b24g
W1BXUkJdCjw2PlsgICAxMC4zNzQxMjldIGlucHV0OiBQb3dlciBCdXR0b24gYXMgL2RldmljZXMv
TE5YU1lTVE06MDAvTE5YUFdSQk46MDAvaW5wdXQvaW5wdXQzCjw2PlsgICAxMC4zNzQ0MTVdIEFD
UEk6IFBvd2VyIEJ1dHRvbiBbUFdSRl0KPDY+WyAgIDEwLjQ2OTI2MV0gYXRhOTogU0FUQSBsaW5r
IHVwIDMuMCBHYnBzIChTU3RhdHVzIDEyMyBTQ29udHJvbCAzMDApCjw3PlsgICAxMC40OTQxOTld
IHhoY2lfaGNkIDAwMDA6MDY6MDAuMDogaXJxIDQ4IGZvciBNU0kvTVNJLVgKPDc+WyAgIDEwLjQ5
NDIwNF0geGhjaV9oY2QgMDAwMDowNjowMC4wOiBpcnEgNDkgZm9yIE1TSS9NU0ktWAo8Nz5bICAg
MTAuNDk0MjA4XSB4aGNpX2hjZCAwMDAwOjA2OjAwLjA6IGlycSA1MCBmb3IgTVNJL01TSS1YCjw2
PlsgICAxMC40OTQyODFdIHVzYiB1c2IzOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9
MWQ2YiwgaWRQcm9kdWN0PTAwMDIKPDY+WyAgIDEwLjUxODg0OV0gdXNiIHVzYjM6IE5ldyBVU0Ig
ZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xCjw2PlsgICAx
MC41NDMzMjNdIHVzYiB1c2IzOiBQcm9kdWN0OiB4SENJIEhvc3QgQ29udHJvbGxlcgo8Nj5bICAg
MTAuNTY4MDUzXSB1c2IgdXNiMzogTWFudWZhY3R1cmVyOiBMaW51eCAyLjYuMzktSU1FVi0xMTA0
MDggeGhjaV9oY2QKPDY+WyAgIDEwLjU5MzQwN10gdXNiIHVzYjM6IFNlcmlhbE51bWJlcjogMDAw
MDowNjowMC4wCjw2PlsgICAxMC42MjIwNjZdIGF0YTkuMDA6IEFUQS04OiBIaXRhY2hpIEhEUzcy
MjAyMEFMQTMzMCwgSktBT0EzTUEsIG1heCBVRE1BLzEzMwo8Nz5bICAgMTAuNjI3MTA4XSB4SENJ
IHhoY2lfYWRkX2VuZHBvaW50IGNhbGxlZCBmb3Igcm9vdCBodWIKPDc+WyAgIDEwLjYyNzExMV0g
eEhDSSB4aGNpX2NoZWNrX2JhbmR3aWR0aCBjYWxsZWQgZm9yIHJvb3QgaHViCjw2PlsgICAxMC42
MjcxMzhdIGh1YiAzLTA6MS4wOiBVU0IgaHViIGZvdW5kCjw2PlsgICAxMC42MjcxNDhdIGh1YiAz
LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkCjw2PlsgICAxMC42MjcyMTRdIHhoY2lfaGNkIDAwMDA6
MDY6MDAuMDogeEhDSSBIb3N0IENvbnRyb2xsZXIKPDY+WyAgIDEwLjYyNzIxOV0geGhjaV9oY2Qg
MDAwMDowNjowMC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVy
IDQKPDY+WyAgIDEwLjc1NDEwNV0gYXRhOS4wMDogMzkwNzAyOTE2OCBzZWN0b3JzLCBtdWx0aSAw
OiBMQkE0OCBOQ1EgKGRlcHRoIDMxLzMyKQo8Nj5bICAgMTAuNzgxMDY2XSB1c2IgdXNiNDogTmV3
IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVjdD0wMDAzCjw2PlsgICAx
MC44MDgwODhdIHVzYiB1c2I0OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVj
dD0yLCBTZXJpYWxOdW1iZXI9MQo8Nj5bICAgMTAuODM1NDM0XSB1c2IgdXNiNDogUHJvZHVjdDog
eEhDSSBIb3N0IENvbnRyb2xsZXIKPDY+WyAgIDEwLjg2MzAyNF0gdXNiIHVzYjQ6IE1hbnVmYWN0
dXJlcjogTGludXggMi42LjM5LUlNRVYtMTEwNDA4IHhoY2lfaGNkCjw2PlsgICAxMC44OTA1OTFd
IHVzYiB1c2I0OiBTZXJpYWxOdW1iZXI6IDAwMDA6MDY6MDAuMAo8Nj5bICAgMTAuODkwNjc0XSBh
dGE5LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwo8NT5bICAgMTAuODkwNzU3XSBzY3NpIDg6
MDowOjA6IERpcmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIEhpdGFjaGkgSERTNzIyMDIgSktBTyBQ
UTogMCBBTlNJOiA1Cjw1PlsgICAxMC44OTA4OThdIHNkIDg6MDowOjA6IEF0dGFjaGVkIHNjc2kg
Z2VuZXJpYyBzZzcgdHlwZSAwCjw1PlsgICAxMC44OTA5OTBdIHNkIDg6MDowOjA6IFtzZGhdIDM5
MDcwMjkxNjggNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgyLjAwIFRCLzEuODEgVGlCKQo8NT5b
ICAgMTAuODkxMDQ1XSBzZCA4OjA6MDowOiBbc2RoXSBXcml0ZSBQcm90ZWN0IGlzIG9mZgo8Nz5b
ICAgMTAuODkxMDQ4XSBzZCA4OjA6MDowOiBbc2RoXSBNb2RlIFNlbnNlOiAwMCAzYSAwMCAwMAo8
NT5bICAgMTAuODkxMDY1XSBzZCA4OjA6MDowOiBbc2RoXSBXcml0ZSBjYWNoZTogZW5hYmxlZCwg
cmVhZCBjYWNoZTogZW5hYmxlZCwgZG9lc24ndCBzdXBwb3J0IERQTyBvciBGVUEKPDY+WyAgIDEw
Ljg5MTE5MF0gc2RoOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDIwMDAzOTg5
MzQwMTYKPDY+WyAgIDExLjEwODY1Nl0gIHNkaDogc2RoMQo8Nz5bICAgMTEuMTExODk0XSB4SENJ
IHhoY2lfYWRkX2VuZHBvaW50IGNhbGxlZCBmb3Igcm9vdCBodWIKPDc+WyAgIDExLjExMTg5N10g
eEhDSSB4aGNpX2NoZWNrX2JhbmR3aWR0aCBjYWxsZWQgZm9yIHJvb3QgaHViCjw2PlsgICAxMS4x
MTIyNTZdIGh1YiA0LTA6MS4wOiBVU0IgaHViIGZvdW5kCjw2PlsgICAxMS4xMTIyNzFdIGh1YiA0
LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkCjw1PlsgICAxMS4xOTE3MDRdIHNkIDg6MDowOjA6IFtz
ZGhdIEF0dGFjaGVkIFNDU0kgZGlzawo8Nj5bICAgMTEuNDE2MjA5XSBhdGExMDogU0FUQSBsaW5r
IGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApCjw2PlsgICAxMS45NDcyMTldIGF0YTEzOiBT
QVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9sIDApCjw2PlsgICAxMi4xNzcyMjFdIGF0
YTExOiBTQVRBIGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMwMCkKPDY+
WyAgIDEyLjIwOTI0MF0gYXRhMTEuMDA6IEFUQS04OiBIaXRhY2hpIEhEUzcyMjAyMEFMQTMzMCwg
SktBT0EzRUEsIG1heCBVRE1BLzEzMwo8Nj5bICAgMTIuMjM1Mzg0XSBhdGExMS4wMDogMzkwNzAy
OTE2OCBzZWN0b3JzLCBtdWx0aSAwOiBMQkE0OCBOQ1EgKGRlcHRoIDMxLzMyKQo8Nj5bICAgMTIu
MjcwMjM5XSBhdGExMS4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMzMKPDU+WyAgIDEyLjI5NjAz
MV0gc2NzaSAxMDowOjA6MDogRGlyZWN0LUFjY2VzcyAgICAgQVRBICAgICAgSGl0YWNoaSBIRFM3
MjIwMiBKS0FPIFBROiAwIEFOU0k6IDUKPDU+WyAgIDEyLjMyMzE5NF0gc2QgMTA6MDowOjA6IFtz
ZGldIDM5MDcwMjkxNjggNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICgyLjAwIFRCLzEuODEgVGlC
KQo8NT5bICAgMTIuMzQ5OTk1XSBzZCAxMDowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNn
OCB0eXBlIDAKPDU+WyAgIDEyLjM3NjUwOV0gc2QgMTA6MDowOjA6IFtzZGldIFdyaXRlIFByb3Rl
Y3QgaXMgb2ZmCjw3PlsgICAxMi40MDI1NjVdIHNkIDEwOjA6MDowOiBbc2RpXSBNb2RlIFNlbnNl
OiAwMCAzYSAwMCAwMAo8NT5bICAgMTIuNDAyOTg4XSBzZCAxMDowOjA6MDogW3NkaV0gV3JpdGUg
Y2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8g
b3IgRlVBCjw2PlsgICAxMi40MzAyODddIHNkaTogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZy
b20gMCB0byAyMDAwMzk4OTM0MDE2Cjw2PlsgICAxMi40NzAzMTldICBzZGk6IHNkaTEKPDU+WyAg
IDEyLjQ5NjYyM10gc2QgMTA6MDowOjA6IFtzZGldIEF0dGFjaGVkIFNDU0kgZGlzawo8Nj5bICAg
MTIuNzA3MjA5XSBhdGExMjogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDAp
Cjw2PlsgICAxNC43NTIzMTddIGF0YTE0OiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250
cm9sIDApCjw2PlsgICAxNC44MTcxNjNdIHVkZXY6IHJlbmFtZWQgbmV0d29yayBpbnRlcmZhY2Ug
ZXRoMCB0byBldGgxCjw2PlsgICAxNC44NDcyNjNdIHVkZXY6IHJlbmFtZWQgbmV0d29yayBpbnRl
cmZhY2UgZXRoMV9yZW5hbWUgdG8gZXRoMAo8Nj5bICAgMTQuOTU3NTA2XSB1c2Jjb3JlOiByZWdp
c3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYnNlcmlhbAo8Nj5bICAgMTQuOTgxODQ5XSBV
U0IgU2VyaWFsIHN1cHBvcnQgcmVnaXN0ZXJlZCBmb3IgZ2VuZXJpYwo8Nj5bICAgMTUuMDA2NzM1
XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYnNlcmlhbF9nZW5l
cmljCjw3PlsgICAxNS4wMTY4NzZdIGFoY2kgMDAwMDowNzowMC4wOiB2ZXJzaW9uIDMuMAo8Nj5b
ICAgMTUuMDE2ODk3XSBhaGNpIDAwMDA6MDc6MDAuMDogUENJIElOVCBBIC0+IExpbmtbQVBDN10g
LT4gR1NJIDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKPDY+WyAgIDE1LjA1NDgxNF0gdXNic2Vy
aWFsOiBVU0IgU2VyaWFsIERyaXZlciBjb3JlCjw3PlsgICAxNS4wNTQ4MjRdIGFoY2kgMDAwMDow
NzowMC4wOiBpcnEgNTEgZm9yIE1TSS9NU0ktWAo8Nj5bICAgMTUuMDU0OTMyXSBhaGNpIDAwMDA6
MDc6MDAuMDogQUhDSSAwMDAxLjAwMDAgMzIgc2xvdHMgMiBwb3J0cyA2IEdicHMgMHgzIGltcGwg
U0FUQSBtb2RlCjw2PlsgICAxNS4wNTQ5MzZdIGFoY2kgMDAwMDowNzowMC4wOiBmbGFnczogNjRi
aXQgbmNxIHNudGYgbGVkIG9ubHkgcG1wIGZicyBwaW8gc2x1bSBwYXJ0IHN4cyAKPDc+WyAgIDE1
LjA1NDk0M10gYWhjaSAwMDAwOjA3OjAwLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8
Nj5bICAgMTUuMDU1MzQ0XSBzY3NpMTQgOiBhaGNpCjw2PlsgICAxNS4wNTU0MTJdIHNjc2kxNSA6
IGFoY2kKPDY+WyAgIDE1LjA1NTQ1MF0gYXRhMTU6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIw
NDhAMHhmZDhmZjAwMCBwb3J0IDB4ZmQ4ZmYxMDAgaXJxIDUxCjw2PlsgICAxNS4wNTU0NTRdIGF0
YTE2OiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZmQ4ZmYwMDAgcG9ydCAweGZkOGZm
MTgwIGlycSA1MQo8Nj5bICAgMTUuNjgyMjE0XSBhdGExNjogU0FUQSBsaW5rIHVwIDMuMCBHYnBz
IChTU3RhdHVzIDEyMyBTQ29udHJvbCAzMzApCjw2PlsgICAxNS43MDYzMjldIGF0YTE1OiBTQVRB
IGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMzMCkKPDQ+WyAgIDIwLjcw
NjMzMV0gYXRhMTYuMDA6IHFjIHRpbWVvdXQgKGNtZCAweGVjKQo8ND5bICAgMjAuNzI5NDU4XSBh
dGExNi4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsIGVycl9tYXNrPTB4NCkKPDQ+
WyAgIDIwLjc1MjgyOF0gYXRhMTUuMDA6IHFjIHRpbWVvdXQgKGNtZCAweGVjKQo8ND5bICAgMjAu
Nzc1ODU4XSBhdGExNS4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsIGVycl9tYXNr
PTB4NCkKPDY+WyAgIDIxLjI1NzIxNV0gYXRhMTY6IFNBVEEgbGluayB1cCAzLjAgR2JwcyAoU1N0
YXR1cyAxMjMgU0NvbnRyb2wgMzMwKQo8Nj5bICAgMjEuMjgwNTE2XSBhdGExNTogU0FUQSBsaW5r
IHVwIDMuMCBHYnBzIChTU3RhdHVzIDEyMyBTQ29udHJvbCAzMzApCjw0PlsgICAzMS4yODAyMjZd
IGF0YTE2LjAwOiBxYyB0aW1lb3V0IChjbWQgMHhlYykKPDQ+WyAgIDMxLjMwMjgzN10gYXRhMTYu
MDA6IGZhaWxlZCB0byBJREVOVElGWSAoSS9PIGVycm9yLCBlcnJfbWFzaz0weDQpCjw0PlsgICAz
MS4zMjU1MDJdIGF0YTE2OiBsaW1pdGluZyBTQVRBIGxpbmsgc3BlZWQgdG8gMS41IEdicHMKPDQ+
WyAgIDMxLjM0ODA0MV0gYXRhMTUuMDA6IHFjIHRpbWVvdXQgKGNtZCAweGVjKQo8ND5bICAgMzEu
MzcwMzAzXSBhdGExNS4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsIGVycl9tYXNr
PTB4NCkKPDQ+WyAgIDMxLjM5MjY5OF0gYXRhMTU6IGxpbWl0aW5nIFNBVEEgbGluayBzcGVlZCB0
byAxLjUgR2Jwcwo8Nj5bICAgMzEuODcyMjE1XSBhdGExNjogU0FUQSBsaW5rIHVwIDEuNSBHYnBz
IChTU3RhdHVzIDExMyBTQ29udHJvbCAzMTApCjw2PlsgICAzMS44OTQzNzFdIGF0YTE1OiBTQVRB
IGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMxMCkKPDQ+WyAgIDYxLjg5
NDIxMl0gYXRhMTYuMDA6IHFjIHRpbWVvdXQgKGNtZCAweGVjKQo8ND5bICAgNjEuOTE2MjU4XSBh
dGExNi4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsIGVycl9tYXNrPTB4NCkKPDQ+
WyAgIDYxLjkzODYxNF0gYXRhMTUuMDA6IHFjIHRpbWVvdXQgKGNtZCAweGVjKQo8ND5bICAgNjEu
OTYwNzM0XSBhdGExNS4wMDogZmFpbGVkIHRvIElERU5USUZZIChJL08gZXJyb3IsIGVycl9tYXNr
PTB4NCkKPDY+WyAgIDYyLjQ0MTIzOF0gYXRhMTY6IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0
YXR1cyAxMTMgU0NvbnRyb2wgMzEwKQo8Nj5bICAgNjIuNDY0MDYzXSBhdGExNTogU0FUQSBsaW5r
IHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMTApCjw2PlsgICA2Mi41MjM4NzRd
IFVTQiBTZXJpYWwgc3VwcG9ydCByZWdpc3RlcmVkIGZvciBHU00gbW9kZW0gKDEtcG9ydCkKPDY+
WyAgIDYyLjU0NzA0NV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBv
cHRpb24KPDY+WyAgIDYyLjU2OTMwMF0gb3B0aW9uOiB2MC43LjI6VVNCIERyaXZlciBmb3IgR1NN
IG1vZGVtcwo8ND5bICAgNjIuNjI0MzEyXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0FBWkFd
IGVuYWJsZWQgYXQgSVJRIDIyCjw2PlsgICA2Mi42NDYyMDldIEhEQSBJbnRlbCAwMDAwOjAwOjA2
LjE6IFBDSSBJTlQgQiAtPiBMaW5rW0FBWkFdIC0+IEdTSSAyMiAobGV2ZWwsIGxvdykgLT4gSVJR
IDIyCjw2PlsgICA2Mi42Njg1NTJdIGhkYV9pbnRlbDogbXNpIGZvciBkZXZpY2UgMTA0Mzo4MWY2
IHNldCB0byAwCjw3PlsgICA2Mi42OTA5NDNdIEhEQSBJbnRlbCAwMDAwOjAwOjA2LjE6IHNldHRp
bmcgbGF0ZW5jeSB0aW1lciB0byA2NAo8Nj5bICAgNjMuMzc5MTk5XSBpbnB1dDogSERBIERpZ2l0
YWwgUENCZWVwIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowNi4xL2lucHV0L2lucHV0
NAo8Nj5bICAgNjUuMDk3MzYxXSBkZXZpY2UtbWFwcGVyOiB1ZXZlbnQ6IHZlcnNpb24gMS4wLjMK
PDY+WyAgIDY1LjEyMDA5OF0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuMjAuMC1pb2N0bCAoMjAx
MS0wMi0wMikgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhhdC5jb20KPDY+WyAgIDY1LjYyMzgy
Nl0gbG9vcDogbW9kdWxlIGxvYWRlZAo8Nj5bICAgNjUuNjM0MzU0XSBFWFQzLWZzOiBiYXJyaWVy
cyBub3QgZW5hYmxlZAo8Nj5bICAgNjUuNjQ3MzkwXSBram91cm5hbGQgc3RhcnRpbmcuICBDb21t
aXQgaW50ZXJ2YWwgNSBzZWNvbmRzCjw2PlsgICA2NS42NDc2OTBdIEVYVDMtZnMgKHNkYTMpOiB1
c2luZyBpbnRlcm5hbCBqb3VybmFsCjw2PlsgICA2NS42NDc2OTRdIEVYVDMtZnMgKHNkYTMpOiBt
b3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZQo8Nj5bICAgNjYuMDc1OTYy
XSBmdXNlIGluaXQgKEFQSSB2ZXJzaW9uIDcuMTYpCktlcm5lbCBsb2dnaW5nIChrc3lzbG9nKSBz
dG9wcGVkLgpLZXJuZWwgbG9nIGRhZW1vbiB0ZXJtaW5hdGluZy4KCkJvb3QgbG9nZ2luZyBzdGFy
dGVkIG9uIC9kZXYvdHR5MSgvZGV2L2NvbnNvbGUpIGF0IFN1biBNYXkgMjkgMjI6MTg6NTIgMjAx
MQoKcmVzdW1lIGRldmljZSAgbm90IGZvdW5kIChpZ25vcmluZykKV2FpdGluZyBmb3IgZGV2aWNl
IC9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0ItMDBIOEEwX1dELVdDQVNZNzU4NjQ3
OS1wYXJ0MSB0byBhcHBlYXI6ICBvawpmc2NrIDEuNDEuMSAoMDEtU2VwLTIwMDgpClsvc2Jpbi9m
c2NrLmV4dDMgKDEpIC0tIC9dIGZzY2suZXh0MyAtYSAtQzAgL2Rldi9kaXNrL2J5LWlkL2F0YS1X
RENfV0Q1MDAwQUFLQi0wMEg4QTBfV0QtV0NBU1k3NTg2NDc5LXBhcnQxIAovZGV2L2Rpc2svYnkt
aWQvYXRhLVdEQ19XRDUwMDBBQUtCLTAwSDhBMF9XRC1XQ0FTWTc1ODY0NzktcGFydDE6IGNsZWFu
LCAxMDU0NzkyLzMwMzQzMTY4IGZpbGVzLCA0MDExOTg5MS8xMjEzNzEwNzUgYmxvY2tzCmZzY2sg
c3VjY2VlZGVkLiBNb3VudGluZyByb290IGRldmljZSByZWFkLXdyaXRlLgpNb3VudGluZyByb290
IC9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0ItMDBIOEEwX1dELVdDQVNZNzU4NjQ3
OS1wYXJ0MQoKQm9vdCBsb2dnaW5nIHN0YXJ0ZWQgb24gL2Rldi90dHkxKC9kZXYvY29uc29sZSAo
ZGVsZXRlZCkpIGF0IFN1biBNYXkgMjkgMTg6MTg6NTUgMjAxMQoKZG9uZQpTdGFydGluZyB1ZGV2
ZDogZG9uZQpMb2FkaW5nIGRyaXZlcnMsIGNvbmZpZ3VyaW5nIGRldmljZXM6IGRvbmUKTG9hZGlu
ZyByZXF1aXJlZCBrZXJuZWwgbW9kdWxlcwpkb25lQWN0aXZhdGluZyBzd2FwLWRldmljZXMgaW4g
L2V0Yy9mc3RhYi4uLgpkb25lU2V0dGluZyB1cCB0aGUgaGFyZHdhcmUgY2xvY2tkb25lCkFjdGl2
YXRpbmcgZGV2aWNlIG1hcHBlci4uLgpkb25lCkNoZWNraW5nIGZpbGUgc3lzdGVtcy4uLgpmc2Nr
IDEuNDEuMSAoMDEtU2VwLTIwMDgpCi9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0It
MDBIOEEwX1dELVdDQVNZNzU4NjQ3OS1wYXJ0MzogY2xlYW4sIDcwLzY4NTQ0IGZpbGVzLCAxMTM2
ODAvMjczMTA0IGJsb2Nrcwpkb25lZG9uZQpNb3VudGluZyBsb2NhbCBmaWxlIHN5c3RlbXMuLi4K
L3Byb2Mgb24gL3Byb2MgdHlwZSBwcm9jIChydykKc3lzZnMgb24gL3N5cyB0eXBlIHN5c2ZzIChy
dykKZGVidWdmcyBvbiAvc3lzL2tlcm5lbC9kZWJ1ZyB0eXBlIGRlYnVnZnMgKHJ3KQp1ZGV2IG9u
IC9kZXYgdHlwZSB0bXBmcyAocncpCmRldnB0cyBvbiAvZGV2L3B0cyB0eXBlIGRldnB0cyAocncs
bW9kZT0wNjIwLGdpZD01KQovZGV2L3NkYTMgb24gL2Jvb3QgdHlwZSBleHQzIChydyxhY2wsdXNl
cl94YXR0cikKZG9uZUxvYWRpbmcgZnVzZSBtb2R1bGUgZG9uZQpNb3VudGluZyBmdXNlIGNvbnRy
b2wgZmlsZXN5c3RlbWRvbmUKU2V0dGluZyBjdXJyZW50IHN5c2N0bCBzdGF0dXMgZnJvbSAvZXRj
L3N5c2N0bC5jb25mCm5ldC5pcHY0LmljbXBfZWNob19pZ25vcmVfYnJvYWRjYXN0cyA9IDEKbmV0
LmlwdjQuY29uZi5hbGwucnBfZmlsdGVyID0gMQpmcy5pbm90aWZ5Lm1heF91c2VyX3dhdGNoZXMg
PSA2NTUzNgpuZXQuaXB2NC5jb25mLmRlZmF1bHQucHJvbW90ZV9zZWNvbmRhcmllcyA9IDEKbmV0
LmlwdjQuY29uZi5hbGwucHJvbW90ZV9zZWNvbmRhcmllcyA9IDEKZG9uZQpBY3RpdmF0aW5nIHJl
bWFpbmluZyBzd2FwLWRldmljZXMgaW4gL2V0Yy9mc3RhYi4uLgpkb25lPG5vdGljZT5raWxscHJv
Yzoga2lsbCg4MTUsMjkpCkNyZWF0aW5nIC92YXIvbG9nL2Jvb3QubXNnCmRvbmVFbmFibGluZyBz
eW4gZmxvb2QgcHJvdGVjdGlvbmRvbmUKRGlzYWJsaW5nIElQIGZvcndhcmRpbmdkb25lCmRvbmUK
QVRURU5USU9OOiBZb3UgaGF2ZSBtb2RpZmllZCAvZXRjL3Jlc29sdi5jb25mLiAgTGVhdmluZyBp
dCB1bnRvdWNoZWQuLi4KWW91IGNhbiBmaW5kIG15IHZlcnNpb24gaW4gL2V0Yy9yZXNvbHYuY29u
Zi5uZXRjb25maWcgLi4uCk1vdW50aW5nIHNlY3VyaXR5ZnMgb24gL3N5cy9rZXJuZWwvc2VjdXJp
dHkgZG9uZQpMb2FkaW5nIEFwcEFybW9yIG1vZHVsZSBmYWlsZWQKU2V0dGluZyB1cCBob3N0bmFt
ZSAnaW1ldidkb25lClNldHRpbmcgdXAgbG9vcGJhY2sgaW50ZXJmYWNlICAgICBsbyAgICAgICAg
CiAgICBsbyAgICAgICAgSVAgYWRkcmVzczogMTI3LjAuMC4xLzggICAKICAgICAgICAgICAgICBJ
UCBhZGRyZXNzOiAxMjcuMC4wLjIvOCAgIApkb25lClN5c3RlbSBCb290IENvbnRyb2w6IFRoZSBz
eXN0ZW0gaGFzIGJlZW4gc2V0IHVwCkZhaWxlZCBmZWF0dXJlczogYm9vdC5hcHBhcm1vcgpTa2lw
cGVkIGZlYXR1cmVzOiBib290LmN5Y2xlClN5c3RlbSBCb290IENvbnRyb2w6IFJ1bm5pbmcgL2V0
Yy9pbml0LmQvYm9vdC5sb2NhbApkb25lPG5vdGljZT5raWxscHJvYzoga2lsbCg4MTUsMykKCklO
SVQ6IEVudGVyaW5nIHJ1bmxldmVsOiAzCgoKCkJvb3QgbG9nZ2luZyBzdGFydGVkIG9uIC9kZXYv
dHR5MSgvZGV2L2NvbnNvbGUpIGF0IFN1biBNYXkgMjkgMTg6MTk6NTQgMjAxMQoKTWFzdGVyIFJl
c291cmNlIENvbnRyb2w6IHByZXZpb3VzIHJ1bmxldmVsOiBOLCBzd2l0Y2hpbmcgdG8gcnVubGV2
ZWw6IDMKPG5vdGljZT5zdGFydHByb2M6IGV4ZWN2ZSAoL3NiaW4vYWNwaWQpIFsgL3NiaW4vYWNw
aWQgXSwgWyBDT05TT0xFPS9kZXYvY29uc29sZSBST09URlNfRlNUWVBFPWV4dDMgU0hFTEw9L2Jp
bi9zaCBURVJNPWxpbnV4IFJPT1RGU19GU0NLPTAgTENfQUxMPVBPU0lYIElOSVRfVkVSU0lPTj1z
eXN2aW5pdC0yLjg2IFJFRElSRUNUPS9kZXYvdHR5MSBDT0xVTU5TPTEyOCBQQVRIPS9iaW46L3Ni
aW46L3Vzci9iaW46L3Vzci9zYmluIHZnYT0weDMxNyBET19DT05GSVJNPSBSVU5MRVZFTD0zIFBX
RD0vIFNQTEFTSENGRz0gUFJFVkxFVkVMPU4gTElORVM9NDggSE9NRT0vIFNITFZMPTIgc3BsYXNo
PW5vbmUgU1BMQVNIPW5vIFJPT1RGU19CTEtERVY9L2Rldi9kaXNrL2J5LWlkL2F0YS1XRENfV0Q1
MDAwQUFLQi0wMEg4QTBfV0QtV0NBU1k3NTg2NDc5LXBhcnQxIF89L3NiaW4vc3RhcnRwcm9jIERB
RU1PTj0vc2Jpbi9hY3BpZCBdClN0YXJ0aW5nIGFjcGlkIGRvbmUKYWNwaWQ6IHN0YXJ0aW5nIHVw
CgoKPG5vdGljZT5zdGFydHByb2M6IGV4ZWN2ZSAoL3NiaW4vc3lzbG9nLW5nKSBbIC9zYmluL3N5
c2xvZy1uZyBdLCBbIENPTlNPTEU9L2Rldi9jb25zb2xlIFJPT1RGU19GU1RZUEU9ZXh0MyBURVJN
PWxpbnV4IFNIRUxMPS9iaW4vc2ggUk9PVEZTX0ZTQ0s9MCBMQ19BTEw9UE9TSVggSU5JVF9WRVJT
SU9OPXN5c3Zpbml0LTIuODYgUkVESVJFQ1Q9L2Rldi90dHkxIENPTFVNTlM9MTI4IFBBVEg9L2Jp
bjovc2JpbjovdXNyL2JpbjovdXNyL3NiaW4gRE9fQ09ORklSTT0gdmdhPTB4MzE3IFJVTkxFVkVM
PTMgU1BMQVNIQ0ZHPSBQV0Q9LyBQUkVWTEVWRUw9TiBMSU5FUz00OCBTSExWTD0yIEhPTUU9LyBT
UExBU0g9bm8gc3BsYXNoPW5vbmUgUk9PVEZTX0JMS0RFVj0vZGV2L2Rpc2svYnktaWQvYXRhLVdE
Q19XRDUwMDBBQUtCLTAwSDhBMF9XRC1XQ0FTWTc1ODY0NzktcGFydDEgXz0vc2Jpbi9zdGFydHBy
b2MgREFFTU9OPS9zYmluL3N5c2xvZy1uZyBdCjxub3RpY2U+c3RhcnRwcm9jOiBleGVjdmUgKC9z
YmluL2tsb2dkKSBbIC9zYmluL2tsb2dkIC1jIDEgLXggXSwgWyBDT05TT0xFPS9kZXYvY29uc29s
ZSBST09URlNfRlNUWVBFPWV4dDMgVEVSTT1saW51eCBTSEVMTD0vYmluL3NoIFJPT1RGU19GU0NL
PTAgTENfQUxMPVBPU0lYIElOSVRfVkVSU0lPTj1zeXN2aW5pdC0yLjg2IFJFRElSRUNUPS9kZXYv
dHR5MSBDT0xVTU5TPTEyOCBQQVRIPS9iaW46L3NiaW46L3Vzci9iaW46L3Vzci9zYmluIERPX0NP
TkZJUk09IHZnYT0weDMxNyBSVU5MRVZFTD0zIFNQTEFTSENGRz0gUFdEPS8gUFJFVkxFVkVMPU4g
TElORVM9NDggU0hMVkw9MiBIT01FPS8gU1BMQVNIPW5vIHNwbGFzaD1ub25lIFJPT1RGU19CTEtE
RVY9L2Rldi9kaXNrL2J5LWlkL2F0YS1XRENfV0Q1MDAwQUFLQi0wMEg4QTBfV0QtV0NBU1k3NTg2
NDc5LXBhcnQxIF89L3NiaW4vc3RhcnRwcm9jIERBRU1PTj0vc2Jpbi9rbG9nZCBdClN0YXJ0aW5n
IHN5c2xvZyBzZXJ2aWNlc2RvbmUKYWNwaWQ6IDIgcnVsZXMgbG9hZGVkCgoKSW5pdGlhbGl6aW5n
IHJhbmRvbSBudW1iZXIgZ2VuZXJhdG9yZG9uZQo8bm90aWNlPnN0YXJ0cHJvYzogZXhlY3ZlICgv
dXNyL3NiaW4vaXJxYmFsYW5jZSkgWyAvdXNyL3NiaW4vaXJxYmFsYW5jZSBdLCBbIENPTlNPTEU9
L2Rldi9jb25zb2xlIFJPT1RGU19GU1RZUEU9ZXh0MyBTSEVMTD0vYmluL3NoIFRFUk09bGludXgg
Uk9PVEZTX0ZTQ0s9MCBMQ19BTEw9UE9TSVggSU5JVF9WRVJTSU9OPXN5c3Zpbml0LTIuODYgUkVE
SVJFQ1Q9L2Rldi90dHkxIENPTFVNTlM9MTI4IFBBVEg9L2Jpbjovc2JpbjovdXNyL2JpbjovdXNy
L3NiaW4gdmdhPTB4MzE3IERPX0NPTkZJUk09IFJVTkxFVkVMPTMgUFdEPS8gU1BMQVNIQ0ZHPSBQ
UkVWTEVWRUw9TiBMSU5FUz00OCBIT01FPS8gU0hMVkw9MiBzcGxhc2g9bm9uZSBTUExBU0g9bm8g
Uk9PVEZTX0JMS0RFVj0vZGV2L2Rpc2svYnktaWQvYXRhLVdEQ19XRDUwMDBBQUtCLTAwSDhBMF9X
RC1XQ0FTWTc1ODY0NzktcGFydDEgXz0vc2Jpbi9zdGFydHByb2MgREFFTU9OPS91c3Ivc2Jpbi9p
cnFiYWxhbmNlIF0KU3RhcnRpbmcgaXJxYmFsYW5jZSBkb25lClN0YXJ0aW5nIEQtQnVzIGRhZW1v
bmRvbmUKTG9hZGluZyBjb25zb2xlIGZvbnQgbGF0OXctMTYucHNmdSAgLW0gdHJpdmlhbCBHMDps
b2FkYWJsZQpkb25lTG9hZGluZyBrZXltYXAgYXNzdW1pbmcgaXNvLTg4NTktMTUgZXVybwpMb2Fk
aW5nIC91c3Ivc2hhcmUva2JkL2tleW1hcHMvaTM4Ni9xd2VydHkvdXMubWFwLmd6CmRvbmVMb2Fk
aW5nIGNvbXBvc2UgdGFibGUgbGF0aW4xLmFkZGRvbmUKU3RhcnQgVW5pY29kZSBtb2RlCmRvbmVM
b2FkaW5nIENQVUZyZXEgbW9kdWxlcyAoQ1BVRnJlcSBub3Qgc3VwcG9ydGVkKQpTdGFydGluZyBI
QUwgZGFlbW9uZG9uZQpTZXR0aW5nIHVwIChsb2NhbGZzKSBuZXR3b3JrIGludGVyZmFjZXM6CiAg
ICBsbyAgICAgICAgCiAgICBsbyAgICAgICAgSVAgYWRkcmVzczogMTI3LjAuMC4xLzggICAKICAg
ICAgICAgICAgICBJUCBhZGRyZXNzOiAxMjcuMC4wLjIvOCAgIApkb25lICAgIGV0aDAgICAgICBk
ZXZpY2U6IFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gUlRMLTgxNjkgR2lnYWJpdCBF
dGhlcm5ldCAocmV2IDEwKQogICAgZXRoMCAgICAgIElQIGFkZHJlc3M6IDEwLjMzLjQwLjY2LzI0
ICAgCmRvbmUgICAgZXRoMSAgICAgIGRldmljZTogUmVhbHRlayBTZW1pY29uZHVjdG9yIENvLiwg
THRkLiBSVEwtODE2OSBHaWdhYml0IEV0aGVybmV0IChyZXYgMTApCmRvbmVTZXR0aW5nIHVwIHNl
cnZpY2UgKGxvY2FsZnMpIG5ldHdvcmsgIC4gIC4gIC4gIC4gIC4gIC4gIC4gIC4gIC4gIC5kb25l
Cjxub3RpY2U+c3RhcnRwcm9jOiBleGVjdmUgKC91c3Ivc2Jpbi94aW5ldGQpIFsgL3Vzci9zYmlu
L3hpbmV0ZCAtcGlkZmlsZSAvdmFyL3J1bi94aW5ldGQuaW5pdC5waWQgXSwgWyBDT05TT0xFPS9k
ZXYvY29uc29sZSBST09URlNfRlNUWVBFPWV4dDMgU0hFTEw9L2Jpbi9zaCBURVJNPWxpbnV4IFJP
T1RGU19GU0NLPTAgTENfQUxMPVBPU0lYIElOSVRfVkVSU0lPTj1zeXN2aW5pdC0yLjg2IFJFRElS
RUNUPS9kZXYvdHR5MSBDT0xVTU5TPTEyOCBQQVRIPS9iaW46L3NiaW46L3Vzci9iaW46L3Vzci9z
YmluIHZnYT0weDMxNyBET19DT05GSVJNPSBSVU5MRVZFTD0zIFBXRD0vIFNQTEFTSENGRz0gUFJF
VkxFVkVMPU4gTElORVM9NDggSE9NRT0vIFNITFZMPTIgc3BsYXNoPW5vbmUgU1BMQVNIPW5vIFJP
T1RGU19CTEtERVY9L2Rldi9kaXNrL2J5LWlkL2F0YS1XRENfV0Q1MDAwQUFLQi0wMEg4QTBfV0Qt
V0NBU1k3NTg2NDc5LXBhcnQxIF89L3NiaW4vc3RhcnRwcm9jIERBRU1PTj0vdXNyL3NiaW4veGlu
ZXRkIF0KPG5vdGljZT5zdGFydHByb2M6IGV4ZWN2ZSAoL3Vzci9zYmluL3NzaGQpIFsgL3Vzci9z
YmluL3NzaGQgLW8gUGlkRmlsZT0vdmFyL3J1bi9zc2hkLmluaXQucGlkIF0sIFsgQ09OU09MRT0v
ZGV2L2NvbnNvbGUgUk9PVEZTX0ZTVFlQRT1leHQzIFNIRUxMPS9iaW4vc2ggVEVSTT1saW51eCBS
T09URlNfRlNDSz0wIExDX0FMTD1QT1NJWCBJTklUX1ZFUlNJT049c3lzdmluaXQtMi44NiBSRURJ
UkVDVD0vZGV2L3R0eTEgQ09MVU1OUz0xMjggUEFUSD0vYmluOi9zYmluOi91c3IvYmluOi91c3Iv
c2JpbiB2Z2E9MHgzMTcgRE9fQ09ORklSTT0gUlVOTEVWRUw9MyBQV0Q9LyBTUExBU0hDRkc9IFBS
RVZMRVZFTD1OIExJTkVTPTQ4IEhPTUU9LyBTSExWTD0yIHNwbGFzaD1ub25lIFNQTEFTSD1ubyBS
T09URlNfQkxLREVWPS9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0ItMDBIOEEwX1dE
LVdDQVNZNzU4NjQ3OS1wYXJ0MSBfPS9zYmluL3N0YXJ0cHJvYyBEQUVNT049L3Vzci9zYmluL3Nz
aGQgXQo8bm90aWNlPnN0YXJ0cHJvYzogZXhlY3ZlICgvdXNyL3NiaW4vY3JvbikgWyAvdXNyL3Ni
aW4vY3JvbiBdLCBbIENPTlNPTEU9L2Rldi9jb25zb2xlIFJPT1RGU19GU1RZUEU9ZXh0MyBTSEVM
TD0vYmluL3NoIFRFUk09bGludXggUk9PVEZTX0ZTQ0s9MCBMQ19BTEw9UE9TSVggSU5JVF9WRVJT
SU9OPXN5c3Zpbml0LTIuODYgUkVESVJFQ1Q9L2Rldi90dHkxIENPTFVNTlM9MTI4IFBBVEg9L2Jp
bjovc2JpbjovdXNyL2JpbjovdXNyL3NiaW4gdmdhPTB4MzE3IERPX0NPTkZJUk09IFJVTkxFVkVM
PTMgUFdEPS8gU1BMQVNIQ0ZHPSBQUkVWTEVWRUw9TiBMSU5FUz00OCBIT01FPS8gU0hMVkw9MiBz
cGxhc2g9bm9uZSBTUExBU0g9bm8gUk9PVEZTX0JMS0RFVj0vZGV2L2Rpc2svYnktaWQvYXRhLVdE
Q19XRDUwMDBBQUtCLTAwSDhBMF9XRC1XQ0FTWTc1ODY0NzktcGFydDEgXz0vc2Jpbi9zdGFydHBy
b2MgREFFTU9OPS91c3Ivc2Jpbi9jcm9uIF0KPG5vdGljZT5zdGFydHByb2M6IGV4ZWN2ZSAoL3Ni
aW4vYXVkaXRkKSBbIC9zYmluL2F1ZGl0ZCAtcyBkaXNhYmxlIF0sIFsgQ09OU09MRT0vZGV2L2Nv
bnNvbGUgUk9PVEZTX0ZTVFlQRT1leHQzIFNIRUxMPS9iaW4vc2ggVEVSTT1saW51eCBST09URlNf
RlNDSz0wIExDX0FMTD1QT1NJWCBJTklUX1ZFUlNJT049c3lzdmluaXQtMi44NiBSRURJUkVDVD0v
ZGV2L3R0eTEgQ09MVU1OUz0xMjggUEFUSD0vYmluOi9zYmluOi91c3IvYmluOi91c3Ivc2JpbiB2
Z2E9MHgzMTcgRE9fQ09ORklSTT0gUlVOTEVWRUw9MyBQV0Q9LyBTUExBU0hDRkc9IFBSRVZMRVZF
TD1OIExJTkVTPTQ4IEhPTUU9LyBTSExWTD0yIHNwbGFzaD1ub25lIFNQTEFTSD1ubyBST09URlNf
QkxLREVWPS9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0ItMDBIOEEwX1dELVdDQVNZ
NzU4NjQ3OS1wYXJ0MSBfPS9zYmluL3N0YXJ0cHJvYyBEQUVNT049L3NiaW4vYXVkaXRkIF0KU3Rh
cnRpbmcgQ1JPTiBkYWVtb25kb25lClN0YXJ0aW5nIFNTSCBkYWVtb25kb25lClN0YXJ0aW5nIGF1
ZGl0ZCBkb25lClN0YXJ0aW5nIElORVQgc2VydmljZXMuICh4aW5ldGQpZG9uZQpTdGFydGluZyBu
ZXR3b3JrIHRpbWUgcHJvdG9jb2wgZGFlbW9uIChOVFBEKTxub3RpY2U+c3RhcnRwcm9jOiBleGVj
dmUgKC91c3Ivc2Jpbi9udHBkKSBbIC91c3Ivc2Jpbi9udHBkIC1wIC92YXIvcnVuL250cC9udHBk
LnBpZCAtZyAtdSBudHA6bnRwIC1pIC92YXIvbGliL250cCAtYyAvZXRjL250cC5jb25mIF0sIFsg
Q09OU09MRT0vZGV2L2NvbnNvbGUgUk9PVEZTX0ZTVFlQRT1leHQzIFNIRUxMPS9iaW4vc2ggVEVS
TT1saW51eCBST09URlNfRlNDSz0wIExDX0FMTD1QT1NJWCBJTklUX1ZFUlNJT049c3lzdmluaXQt
Mi44NiBSRURJUkVDVD0vZGV2L3R0eTEgQ09MVU1OUz0xMjggUEFUSD0vYmluOi9zYmluOi91c3Iv
YmluOi91c3Ivc2JpbiB2Z2E9MHgzMTcgRE9fQ09ORklSTT0gUlVOTEVWRUw9MyBQV0Q9LyBTUExB
U0hDRkc9IFBSRVZMRVZFTD1OIExJTkVTPTQ4IEhPTUU9LyBTSExWTD0yIHNwbGFzaD1ub25lIFNQ
TEFTSD1ubyBST09URlNfQkxLREVWPS9kZXYvZGlzay9ieS1pZC9hdGEtV0RDX1dENTAwMEFBS0It
MDBIOEEwX1dELVdDQVNZNzU4NjQ3OS1wYXJ0MSBfPS9zYmluL3N0YXJ0cHJvYyBEQUVNT049L3Vz
ci9zYmluL250cGQgXQpkb25lClN0YXJ0aW5nIHNtYXJ0ZCBkb25lCmRvbmUKTWFzdGVyIFJlc291
cmNlIENvbnRyb2w6IHJ1bmxldmVsIDMgaGFzIGJlZW4gcmVhY2hlZApTa2lwcGVkIHNlcnZpY2Vz
IGluIHJ1bmxldmVsIDM6IHNwbGFzaAo8bm90aWNlPmtpbGxwcm9jOiBraWxsKDIyMzQsMykK

--MP_/psv3Mff82RP9kd0QtTuxUkj--
