From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata update
Date: Wed, 17 Nov 2004 10:09:47 -0500
Message-ID: <20041117150947.GA24320@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:57744 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262340AbUKQPJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Nov 2004 10:09:53 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ide@vger.kernel.org


Here's the queue of stuff that was waiting on 2.4.28 release...

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/Config.in        |    1 
 drivers/scsi/Makefile         |    1 
 drivers/scsi/ahci.c           | 1040 ++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c       |   16 
 drivers/scsi/libata-core.c    |  346 +++++++++----
 drivers/scsi/libata-scsi.c    |   94 ++-
 drivers/scsi/libata.h         |    7 
 drivers/scsi/sata_nv.c        |   16 
 drivers/scsi/sata_promise.c   |   67 +-
 drivers/scsi/sata_sil.c       |    8 
 drivers/scsi/sata_sis.c       |    9 
 drivers/scsi/sata_svw.c       |    7 
 drivers/scsi/sata_sx4.c       |   13 
 drivers/scsi/sata_uli.c       |    9 
 drivers/scsi/sata_via.c       |    3 
 drivers/scsi/sata_vsc.c       |   13 
 include/linux/ata.h           |   44 -
 include/linux/libata-compat.h |   66 ++
 include/linux/libata.h        |   61 +-
 include/linux/mm.h            |    5 
 20 files changed, 1560 insertions(+), 266 deletions(-)

through these ChangeSets:

Bartlomiej Zolnierkiewicz:
  o libata PIO bugfix
  o make ATAPI PIO work
  o arbitrary size ATAPI PIO support bugfixes
  o [libata] arbitrary size ATAPI PIO support
  o REQUEST_SENSE support for ATAPI

Christoph Hellwig:
  o fix sata_svw compile

Jeff Garzik:
  o [libata ahci] minor fixes
  o [libata] fix DocBook bugs
  o [libata] bump versions, add MODULE_VERSION() tags
  o [libata] remove dependence on PCI (2.4 stub version)
  o Remove silly comment from linux/ata.h
  o Resync linux/ata.h with 2.6.x
  o Add nth_page() helper
  o [libata ahci] bump version to 1.00
  o [libata] add ssleep() function
  o [libata] cosmetic: make syncing with 2.6 easier
  o [libata] use kunmap_atomic() correctly
  o [libata] return ENOTTY rather than EOPNOTSUPP for unknown-ioctl
  o [libata] fix minor 2.6 backport problems
  o [libata] add AHCI driver

Jeremy Higdon:
  o per-port LED control for sata_vsc

Mark Lord:
  o Export ata_scsi_simulate() for use by non-libata drivers

Matthijs Melchior:
  o [libata ahci] fix rather serious (and/or embarassing) bugs

Meelis Roos:
  o ata.h undefined types in USB

Nishanth Aravamudan:
  o scsi/ahci: replace schedule_timeout() with msleep()/ssleep()

Tobias Lorenz:
  o [libata sata_promise] s/sata/ata/

diff -Nru a/drivers/scsi/Config.in b/drivers/scsi/Config.in
--- a/drivers/scsi/Config.in	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/Config.in	2004-11-17 10:07:20 -05:00
@@ -69,6 +69,7 @@
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
 dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
 dep_mbool 'Serial ATA (SATA) support' CONFIG_SCSI_SATA $CONFIG_SCSI
+dep_tristate '  AHCI SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_AHCI $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_SVW $CONFIG_SCSI_SATA $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Intel PIIX/ICH SATA support' CONFIG_SCSI_ATA_PIIX $CONFIG_SCSI_SATA $CONFIG_PCI
 dep_tristate '  NVIDIA SATA support (EXPERIMENTAL)' CONFIG_SCSI_SATA_NV $CONFIG_SCSI_SATA $CONFIG_PCI
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/Makefile	2004-11-17 10:07:20 -05:00
@@ -130,6 +130,7 @@
 obj-$(CONFIG_SCSI_CPQFCTS)	+= cpqfc.o
 obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700.o
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
+obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/ahci.c	2004-11-17 10:07:20 -05:00
@@ -0,0 +1,1040 @@
+/*
+ *  ahci.c - AHCI SATA support
+ *
+ *  Copyright 2004 Red Hat, Inc.
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ * Version 1.0 of the AHCI specification:
+ * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <asm/io.h>
+
+#define DRV_NAME	"ahci"
+#define DRV_VERSION	"1.00"
+
+#define msleep libata_msleep   /* 2.4-specific */
+
+enum {
+	AHCI_PCI_BAR		= 5,
+	AHCI_MAX_SG		= 168, /* hardware max is 64K */
+	AHCI_DMA_BOUNDARY	= 0xffffffff,
+	AHCI_USE_CLUSTERING	= 0,
+	AHCI_CMD_SLOT_SZ	= 32 * 32,
+	AHCI_RX_FIS_SZ		= 256,
+	AHCI_CMD_TBL_HDR	= 0x80,
+	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
+	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
+				  AHCI_RX_FIS_SZ,
+	AHCI_IRQ_ON_SG		= (1 << 31),
+	AHCI_CMD_ATAPI		= (1 << 5),
+	AHCI_CMD_WRITE		= (1 << 6),
+
+	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+
+	board_ahci		= 0,
+
+	/* global controller registers */
+	HOST_CAP		= 0x00, /* host capabilities */
+	HOST_CTL		= 0x04, /* global host control */
+	HOST_IRQ_STAT		= 0x08, /* interrupt status */
+	HOST_PORTS_IMPL		= 0x0c, /* bitmap of implemented ports */
+	HOST_VERSION		= 0x10, /* AHCI spec. version compliancy */
+
+	/* HOST_CTL bits */
+	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
+	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+
+	/* HOST_CAP bits */
+	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+
+	/* registers for each SATA port */
+	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
+	PORT_LST_ADDR_HI	= 0x04, /* command list DMA addr hi */
+	PORT_FIS_ADDR		= 0x08, /* FIS rx buf addr */
+	PORT_FIS_ADDR_HI	= 0x0c, /* FIS rx buf addr hi */
+	PORT_IRQ_STAT		= 0x10, /* interrupt status */
+	PORT_IRQ_MASK		= 0x14, /* interrupt enable/disable mask */
+	PORT_CMD		= 0x18, /* port command */
+	PORT_TFDATA		= 0x20,	/* taskfile data */
+	PORT_SIG		= 0x24,	/* device TF signature */
+	PORT_CMD_ISSUE		= 0x38, /* command issue */
+	PORT_SCR		= 0x28, /* SATA phy register block */
+	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
+	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
+	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
+	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
+
+	/* PORT_IRQ_{STAT,MASK} bits */
+	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
+	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+
+	PORT_IRQ_FATAL		= PORT_IRQ_TF_ERR |
+				  PORT_IRQ_HBUS_ERR |
+				  PORT_IRQ_HBUS_DATA_ERR |
+				  PORT_IRQ_IF_ERR,
+	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
+				  PORT_IRQ_CONNECT | PORT_IRQ_SG_DONE |
+				  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_FIS |
+				  PORT_IRQ_DMAS_FIS | PORT_IRQ_PIOS_FIS |
+				  PORT_IRQ_D2H_REG_FIS,
+
+	/* PORT_CMD bits */
+	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
+	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
+	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
+
+	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+};
+
+struct ahci_cmd_hdr {
+	u32			opts;
+	u32			status;
+	u32			tbl_addr;
+	u32			tbl_addr_hi;
+	u32			reserved[4];
+};
+
+struct ahci_sg {
+	u32			addr;
+	u32			addr_hi;
+	u32			reserved;
+	u32			flags_size;
+};
+
+struct ahci_host_priv {
+	unsigned long		flags;
+	u32			cap;	/* cache of HOST_CAP register */
+	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+};
+
+struct ahci_port_priv {
+	struct ahci_cmd_hdr	*cmd_slot;
+	dma_addr_t		cmd_slot_dma;
+	void			*cmd_tbl;
+	dma_addr_t		cmd_tbl_dma;
+	struct ahci_sg		*cmd_tbl_sg;
+	void			*rx_fis;
+	dma_addr_t		rx_fis_dma;
+};
+
+static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int ahci_qc_issue(struct ata_queued_cmd *qc);
+static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static void ahci_phy_reset(struct ata_port *ap);
+static void ahci_irq_clear(struct ata_port *ap);
+static void ahci_eng_timeout(struct ata_port *ap);
+static int ahci_port_start(struct ata_port *ap);
+static void ahci_port_stop(struct ata_port *ap);
+static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_qc_prep(struct ata_queued_cmd *qc);
+static u8 ahci_check_status(struct ata_port *ap);
+static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+
+static Scsi_Host_Template ahci_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.detect			= ata_scsi_detect,
+	.release		= ata_scsi_release,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= AHCI_MAX_SG,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.use_new_eh_code	= ATA_SHT_NEW_EH_CODE,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= AHCI_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations ahci_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= ahci_check_status,
+	.dev_select		= ata_noop_dev_select,
+
+	.phy_reset		= ahci_phy_reset,
+
+	.qc_prep		= ahci_qc_prep,
+	.qc_issue		= ahci_qc_issue,
+
+	.eng_timeout		= ahci_eng_timeout,
+
+	.irq_handler		= ahci_interrupt,
+	.irq_clear		= ahci_irq_clear,
+
+	.scr_read		= ahci_scr_read,
+	.scr_write		= ahci_scr_write,
+
+	.port_start		= ahci_port_start,
+	.port_stop		= ahci_port_stop,
+	.host_stop		= ahci_host_stop,
+};
+
+static struct ata_port_info ahci_port_info[] = {
+	/* board_ahci */
+	{
+		.sht		= &ahci_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03, /* pio3-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
+};
+
+static struct pci_device_id ahci_pci_tbl[] = {
+	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },
+	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },
+	{ }	/* terminate list */
+};
+
+
+static struct pci_driver ahci_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= ahci_pci_tbl,
+	.probe			= ahci_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+
+static inline unsigned long ahci_port_base_ul (unsigned long base, unsigned int port)
+{
+	return base + 0x100 + (port * 0x80);
+}
+
+static inline void *ahci_port_base (void *base, unsigned int port)
+{
+	return (void *) ahci_port_base_ul((unsigned long)base, port);
+}
+
+static void ahci_host_stop(struct ata_host_set *host_set)
+{
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	kfree(hpriv);
+}
+
+static int ahci_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp;
+	int rc;
+	void *mem, *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	dma_addr_t mem_dma;
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+	memset(pp, 0, sizeof(*pp));
+
+	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
+	if (!mem) {
+		rc = -ENOMEM;
+		goto err_out_kfree;
+	}
+	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+
+	/*
+	 * First item in chunk of DMA memory: 32-slot command table,
+	 * 32 bytes each in size
+	 */
+	pp->cmd_slot = mem;
+	pp->cmd_slot_dma = mem_dma;
+
+	mem += AHCI_CMD_SLOT_SZ;
+	mem_dma += AHCI_CMD_SLOT_SZ;
+
+	/*
+	 * Second item: Received-FIS area
+	 */
+	pp->rx_fis = mem;
+	pp->rx_fis_dma = mem_dma;
+
+	mem += AHCI_RX_FIS_SZ;
+	mem_dma += AHCI_RX_FIS_SZ;
+
+	/*
+	 * Third item: data area for storing a single command
+	 * and its scatter-gather table
+	 */
+	pp->cmd_tbl = mem;
+	pp->cmd_tbl_dma = mem_dma;
+
+	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR;
+
+	ap->private_data = pp;
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+
+	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
+	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
+	       PORT_CMD_START, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
+
+err_out_kfree:
+	kfree(pp);
+err_out:
+	ata_port_stop(ap);
+	return rc;
+}
+
+
+static void ahci_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
+	 * this is slightly incorrect.
+	 */
+	msleep(500);
+
+	ap->private_data = NULL;
+	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
+			  pp->cmd_slot, pp->cmd_slot_dma);
+	kfree(pp);
+	ata_port_stop(ap);
+}
+
+static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
+{
+	unsigned int sc_reg;
+
+	switch (sc_reg_in) {
+	case SCR_STATUS:	sc_reg = 0; break;
+	case SCR_CONTROL:	sc_reg = 1; break;
+	case SCR_ERROR:		sc_reg = 2; break;
+	case SCR_ACTIVE:	sc_reg = 3; break;
+	default:
+		return 0xffffffffU;
+	}
+
+	return readl((void *) ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+
+static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
+			       u32 val)
+{
+	unsigned int sc_reg;
+
+	switch (sc_reg_in) {
+	case SCR_STATUS:	sc_reg = 0; break;
+	case SCR_CONTROL:	sc_reg = 1; break;
+	case SCR_ERROR:		sc_reg = 2; break;
+	case SCR_ACTIVE:	sc_reg = 3; break;
+	default:
+		return;
+	}
+
+	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ata_taskfile tf;
+	struct ata_device *dev = &ap->device[0];
+	u32 tmp;
+
+	__sata_phy_reset(ap);
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	dev->class = ata_dev_classify(&tf);
+	if (!ata_dev_present(dev))
+		ata_port_disable(ap);
+}
+
+static u8 ahci_check_status(struct ata_port *ap)
+{
+	void *mmio = (void *) ap->ioaddr.cmd_addr;
+
+	return readl(mmio + PORT_TFDATA) & 0xFF;
+}
+
+static void ahci_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ahci_port_priv *pp = qc->ap->private_data;
+	unsigned int i;
+
+	VPRINTK("ENTER\n");
+
+	/*
+	 * Next, the S/G list.
+	 */
+	for (i = 0; i < qc->n_elem; i++) {
+		u32 sg_len;
+		dma_addr_t addr;
+
+		addr = sg_dma_address(&qc->sg[i]);
+		sg_len = sg_dma_len(&qc->sg[i]);
+
+		pp->cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
+		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
+		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
+	}
+}
+
+static void ahci_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ahci_port_priv *pp = qc->ap->private_data;
+	u32 opts;
+	const u32 cmd_fis_len = 5; /* five dwords */
+
+	/*
+	 * Fill in command slot information (currently only one slot,
+	 * slot 0, is currently since we don't do queueing)
+	 */
+
+	opts = (qc->n_elem << 16) | cmd_fis_len;
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		opts |= AHCI_CMD_WRITE;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_NODATA:
+	case ATA_PROT_ATAPI_DMA:
+		opts |= AHCI_CMD_ATAPI;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	pp->cmd_slot[0].opts = cpu_to_le32(opts);
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+
+	/*
+	 * Fill in command table information.  First, the header,
+	 * a SATA Register - Host to Device command FIS.
+	 */
+	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	ahci_fill_sg(qc);
+}
+
+static inline void ahci_dma_complete (struct ata_port *ap,
+                                     struct ata_queued_cmd *qc,
+				     int have_err)
+{
+	/* get drive status; clear intr; complete txn */
+	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
+			have_err ? ATA_ERR : 0);
+}
+
+static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+	int work;
+
+	/* stop DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop.  TODO: this could be
+	 * as long as 500 msec
+	 */
+	work = 1000;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			break;
+		udelay(10);
+	}
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* if DRQ/BSY is set, device needs to be reset.
+	 * if so, issue COMRESET
+	 */
+	tmp = readl(port_mmio + PORT_TFDATA);
+	if (tmp & (ATA_BUSY | ATA_DRQ)) {
+		writel(0x301, port_mmio + PORT_SCR_CTL);
+		readl(port_mmio + PORT_SCR_CTL); /* flush */
+		udelay(10);
+		writel(0x300, port_mmio + PORT_SCR_CTL);
+		readl(port_mmio + PORT_SCR_CTL); /* flush */
+	}
+
+	/* re-start DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+}
+
+static void ahci_eng_timeout(struct ata_port *ap)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
+
+	DPRINTK("ENTER\n");
+
+	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (!qc) {
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
+		       ap->id);
+	} else {
+		/* hack alert!  We cannot use the supplied completion
+	 	 * function from inside the ->eh_strategy_handler() thread.
+	 	 * libata is the only user of ->eh_strategy_handler() in
+	 	 * any kernel, so the default scsi_done() assumes it is
+	 	 * not being called from the SCSI EH.
+	 	 */
+		qc->scsidone = scsi_finish_command;
+		ata_qc_complete(qc, ATA_ERR);
+	}
+
+}
+
+static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 status, serr, ci;
+
+	serr = readl(port_mmio + PORT_SCR_ERR);
+	writel(serr, port_mmio + PORT_SCR_ERR);
+
+	status = readl(port_mmio + PORT_IRQ_STAT);
+	writel(status, port_mmio + PORT_IRQ_STAT);
+
+	ci = readl(port_mmio + PORT_CMD_ISSUE);
+	if (likely((ci & 0x1) == 0)) {
+		if (qc) {
+			ata_qc_complete(qc, 0);
+			qc = NULL;
+		}
+	}
+
+	if (status & PORT_IRQ_FATAL) {
+		ahci_intr_error(ap, status);
+		if (qc)
+			ata_qc_complete(qc, ATA_ERR);
+	}
+
+	return 1;
+}
+
+static void ahci_irq_clear(struct ata_port *ap)
+{
+	/* TODO */
+}
+
+static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int i, handled = 0;
+	void *mmio;
+	u32 irq_stat, irq_ack = 0;
+
+	VPRINTK("ENTER\n");
+
+	hpriv = host_set->private_data;
+	mmio = host_set->mmio_base;
+
+	/* sigh.  0xffffffff is a valid return from h/w */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	irq_stat &= hpriv->port_map;
+	if (!irq_stat)
+		return IRQ_NONE;
+
+        spin_lock(&host_set->lock);
+
+        for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+		u32 tmp;
+
+		VPRINTK("port %u\n", i);
+		ap = host_set->ports[i];
+		tmp = irq_stat & (1 << i);
+		if (tmp && ap) {
+			struct ata_queued_cmd *qc;
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (ahci_host_intr(ap, qc))
+				irq_ack |= (1 << i);
+		}
+	}
+
+	if (irq_ack) {
+		writel(irq_ack, mmio + HOST_IRQ_STAT);
+		handled = 1;
+	}
+
+        spin_unlock(&host_set->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+static int ahci_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
+
+	writel(1, port_mmio + PORT_SCR_ACT);
+	readl(port_mmio + PORT_SCR_ACT);	/* flush */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	return 0;
+}
+
+static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
+			    unsigned int port_idx)
+{
+	VPRINTK("ENTER, base==0x%lx, port_idx %u\n", base, port_idx);
+	base = ahci_port_base_ul(base, port_idx);
+	VPRINTK("base now==0x%lx\n", base);
+
+	port->cmd_addr		= base;
+	port->scr_addr		= base + PORT_SCR;
+
+	VPRINTK("EXIT\n");
+}
+
+static int ahci_host_init(struct ata_probe_ent *probe_ent)
+{
+	struct ahci_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	void __iomem *mmio = probe_ent->mmio_base;
+	u32 tmp, cap_save;
+	u16 tmp16;
+	unsigned int i, j, using_dac;
+	int rc;
+	void __iomem *port_mmio;
+
+	cap_save = readl(mmio + HOST_CAP);
+	cap_save &= ( (1<<28) | (1<<17) );
+	cap_save |= (1 << 27);
+
+	/* global controller reset */
+	tmp = readl(mmio + HOST_CTL);
+	if ((tmp & HOST_RESET) == 0) {
+		writel(tmp | HOST_RESET, mmio + HOST_CTL);
+		readl(mmio + HOST_CTL); /* flush */
+	}
+
+	/* reset must complete within 1 second, or
+	 * the hardware should be considered fried.
+	 */
+	ssleep(1);
+
+	tmp = readl(mmio + HOST_CTL);
+	if (tmp & HOST_RESET) {
+		printk(KERN_ERR DRV_NAME "(%s): controller reset failed (0x%x)\n",
+			pci_name(pdev), tmp);
+		return -EIO;
+	}
+
+	writel(HOST_AHCI_EN, mmio + HOST_CTL);
+	(void) readl(mmio + HOST_CTL);	/* flush */
+	writel(cap_save, mmio + HOST_CAP);
+	writel(0xf, mmio + HOST_PORTS_IMPL);
+	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
+
+	pci_read_config_word(pdev, 0x92, &tmp16);
+	tmp16 |= 0xf;
+	pci_write_config_word(pdev, 0x92, tmp16);
+
+	hpriv->cap = readl(mmio + HOST_CAP);
+	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+
+	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
+		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
+
+	using_dac = hpriv->cap & HOST_CAP_64;
+	if (using_dac &&
+	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+		hpriv->flags |= HOST_CAP_64;
+	} else {
+		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
+				pci_name(pdev));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < probe_ent->n_ports; i++) {
+#if 0 /* BIOSen initialize this incorrectly */
+		if (!(hpriv->port_map & (1 << i)))
+			continue;
+#endif
+
+		port_mmio = ahci_port_base(mmio, i);
+		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
+
+		ahci_setup_port(&probe_ent->port[i],
+				(unsigned long) mmio, i);
+
+		/* make sure port is not active */
+		tmp = readl(port_mmio + PORT_CMD);
+		VPRINTK("PORT_CMD 0x%x\n", tmp);
+		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
+			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
+			tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
+				 PORT_CMD_FIS_RX | PORT_CMD_START);
+			writel(tmp, port_mmio + PORT_CMD);
+			readl(port_mmio + PORT_CMD); /* flush */
+
+			/* spec says 500 msecs for each bit, so
+			 * this is slightly incorrect.
+			 */
+			msleep(500);
+		}
+
+		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
+
+		j = 0;
+		while (j < 100) {
+			msleep(10);
+			tmp = readl(port_mmio + PORT_SCR_STAT);
+			if ((tmp & 0xf) == 0x3)
+				break;
+			j++;
+		}
+
+		tmp = readl(port_mmio + PORT_SCR_ERR);
+		VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
+		writel(tmp, port_mmio + PORT_SCR_ERR);
+
+		/* ack any pending irq events for this port */
+		tmp = readl(port_mmio + PORT_IRQ_STAT);
+		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		if (tmp)
+			writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+		writel(1 << i, mmio + HOST_IRQ_STAT);
+
+		/* set irq mask (enables interrupts) */
+		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+	}
+
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+/* move to PCI layer, integrate w/ MSI stuff */
+static void pci_enable_intx(struct pci_dev *pdev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+}
+
+static void ahci_print_info(struct ata_probe_ent *probe_ent)
+{
+	struct ahci_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
+	void *mmio = probe_ent->mmio_base;
+	u32 vers, cap, impl, speed;
+	const char *speed_s;
+	u16 cc;
+	const char *scc_s;
+
+	vers = readl(mmio + HOST_VERSION);
+	cap = hpriv->cap;
+	impl = hpriv->port_map;
+
+	speed = (cap >> 20) & 0xf;
+	if (speed == 1)
+		speed_s = "1.5";
+	else if (speed == 2)
+		speed_s = "3";
+	else
+		speed_s = "?";
+
+	pci_read_config_word(pdev, 0x0a, &cc);
+	if (cc == 0x0101)
+		scc_s = "IDE";
+	else if (cc == 0x0106)
+		scc_s = "SATA";
+	else if (cc == 0x0104)
+		scc_s = "RAID";
+	else
+		scc_s = "unknown";
+
+	printk(KERN_INFO DRV_NAME "(%s) AHCI %02x%02x.%02x%02x "
+		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
+	       	,
+	       	pci_name(pdev),
+
+	       	(vers >> 24) & 0xff,
+	       	(vers >> 16) & 0xff,
+	       	(vers >> 8) & 0xff,
+	       	vers & 0xff,
+
+		((cap >> 8) & 0x1f) + 1,
+		(cap & 0x1f) + 1,
+		speed_s,
+		impl,
+		scc_s);
+
+	printk(KERN_INFO DRV_NAME "(%s) flags: "
+	       	"%s%s%s%s%s%s"
+	       	"%s%s%s%s%s%s%s\n"
+	       	,
+	       	pci_name(pdev),
+
+		cap & (1 << 31) ? "64bit " : "",
+		cap & (1 << 30) ? "ncq " : "",
+		cap & (1 << 28) ? "ilck " : "",
+		cap & (1 << 27) ? "stag " : "",
+		cap & (1 << 26) ? "pm " : "",
+		cap & (1 << 25) ? "led " : "",
+
+		cap & (1 << 24) ? "clo " : "",
+		cap & (1 << 19) ? "nz " : "",
+		cap & (1 << 18) ? "only " : "",
+		cap & (1 << 17) ? "pmp " : "",
+		cap & (1 << 15) ? "pio " : "",
+		cap & (1 << 14) ? "slum " : "",
+		cap & (1 << 13) ? "part " : ""
+		);
+}
+
+static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	struct ata_probe_ent *probe_ent = NULL;
+	struct ahci_host_priv *hpriv;
+	unsigned long base;
+	void *mmio_base;
+	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int rc;
+
+	VPRINTK("ENTER\n");
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	pci_enable_intx(pdev);
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->dev = pci_dev_to_dev(pdev);
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	mmio_base = ioremap(pci_resource_start(pdev, AHCI_PCI_BAR),
+		            pci_resource_len(pdev, AHCI_PCI_BAR));
+	if (mmio_base == NULL) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+	base = (unsigned long) mmio_base;
+
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto err_out_iounmap;
+	}
+	memset(hpriv, 0, sizeof(*hpriv));
+
+	probe_ent->sht		= ahci_port_info[board_idx].sht;
+	probe_ent->host_flags	= ahci_port_info[board_idx].host_flags;
+	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
+	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
+	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
+
+       	probe_ent->irq = pdev->irq;
+       	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->mmio_base = mmio_base;
+	probe_ent->private_data = hpriv;
+
+	/* initialize adapter */
+	rc = ahci_host_init(probe_ent);
+	if (rc)
+		goto err_out_hpriv;
+
+	ahci_print_info(probe_ent);
+
+	ata_add_to_probe_list(probe_ent);
+
+	return 0;
+
+err_out_hpriv:
+	kfree(hpriv);
+err_out_iounmap:
+	iounmap(mmio_base);
+err_out_free_ent:
+	kfree(probe_ent);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+
+static int __init ahci_init(void)
+{
+	int rc;
+
+	rc = pci_module_init(&ahci_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = scsi_register_module(MODULE_SCSI_HA, &ahci_sht);
+	if (rc) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	pci_unregister_driver(&ahci_pci_driver);
+	return rc;
+}
+
+
+static void __exit ahci_exit(void)
+{
+	scsi_unregister_module(MODULE_SCSI_HA, &ahci_sht);
+	pci_unregister_driver(&ahci_pci_driver);
+}
+
+
+MODULE_AUTHOR("Jeff Garzik");
+MODULE_DESCRIPTION("AHCI SATA low-level driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, ahci_pci_tbl);
+
+module_init(ahci_init);
+module_exit(ahci_exit);
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/ata_piix.c	2004-11-17 10:07:20 -05:00
@@ -32,7 +32,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"1.02"
+#define DRV_VERSION	"1.03"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -248,6 +248,7 @@
 MODULE_DESCRIPTION("SCSI low-level driver for Intel PIIX/ICH ATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
@@ -261,7 +262,7 @@
  */
 static void piix_pata_cbl_detect(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	u8 tmp, mask;
 
 	/* no 80c support in host controller? */
@@ -294,8 +295,9 @@
 
 static void piix_pata_phy_reset(struct ata_port *ap)
 {
-	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &piix_enable_bits[ap->hard_port_no])) {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return;
@@ -323,7 +325,7 @@
  */
 static int piix_sata_probe (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	int combined = (ap->flags & ATA_FLAG_SLAVE_POSS);
 	int orig_mask, mask, i;
 	u8 pcs;
@@ -393,7 +395,7 @@
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
-	struct pci_dev *dev	= ap->host_set->pdev;
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
@@ -445,7 +447,7 @@
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
-	struct pci_dev *dev	= ap->host_set->pdev;
+	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
 	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/libata-core.c	2004-11-17 10:07:20 -05:00
@@ -57,6 +57,7 @@
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
+static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static LIST_HEAD(ata_probe_list);
@@ -65,28 +66,7 @@
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
-
-/**
- *	msleep - sleep for a number of milliseconds
- *	@msecs: number of milliseconds to sleep
- *
- *	Issues schedule_timeout call for the specified number
- *	of milliseconds.
- *
- *	LOCKING:
- *	None.
- */
-
-static void msleep(unsigned long msecs)
-{
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(msecs) + 1);
-}
-
-void libata_msleep(unsigned long msecs)
-{
-	msleep(msecs);
-}
+MODULE_VERSION(DRV_VERSION);
 
 /**
  *	ata_tf_load - send taskfile registers to host controller
@@ -601,7 +581,7 @@
 
 /**
  *	ata_udma_string - convert UDMA bit offset to string
- *	@udma_mask: mask of bits supported; only highest bit counts.
+ *	@mask: mask of bits supported; only highest bit counts.
  *
  *	Determine string which represents the highest speed
  *	(highest bit in @udma_mask).
@@ -838,7 +818,7 @@
 
 /**
  *	ata_dev_id_string - Convert IDENTIFY DEVICE page into string
- *	@dev: Device whose IDENTIFY DEVICE results we will examine
+ *	@id: IDENTIFY DEVICE results we will examine
  *	@s: string into which data is output
  *	@ofs: offset into identify device page
  *	@len: length of string to return. must be an even number.
@@ -851,17 +831,17 @@
  *	caller.
  */
 
-void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+void ata_dev_id_string(u16 *id, unsigned char *s,
 		       unsigned int ofs, unsigned int len)
 {
 	unsigned int c;
 
 	while (len > 0) {
-		c = dev->id[ofs] >> 8;
+		c = id[ofs] >> 8;
 		*s = c;
 		s++;
 
-		c = dev->id[ofs] & 0xff;
+		c = id[ofs] & 0xff;
 		*s = c;
 		s++;
 
@@ -1037,7 +1017,7 @@
 	BUG_ON(qc == NULL);
 
 	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
-	qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+	qc->dma_dir = DMA_FROM_DEVICE;
 	qc->tf.protocol = ATA_PROT_PIO;
 	qc->nsect = 1;
 
@@ -1104,7 +1084,7 @@
 	 */
 
 	/* we require LBA and DMA support (bits 8 & 9 of word 49) */
-	if (!ata_id_has_dma(dev) || !ata_id_has_lba(dev)) {
+	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
 		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
 		goto err_out_nosup;
 	}
@@ -1122,7 +1102,7 @@
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
-		if (!ata_id_is_ata(dev))	/* sanity check */
+		if (!ata_id_is_ata(dev->id))	/* sanity check */
 			goto err_out_nosup;
 
 		tmp = dev->id[ATA_ID_MAJOR_VER];
@@ -1136,11 +1116,11 @@
 			goto err_out_nosup;
 		}
 
-		if (ata_id_has_lba48(dev)) {
+		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
-			dev->n_sectors = ata_id_u64(dev, 100);
+			dev->n_sectors = ata_id_u64(dev->id, 100);
 		} else {
-			dev->n_sectors = ata_id_u32(dev, 60);
+			dev->n_sectors = ata_id_u32(dev->id, 60);
 		}
 
 		ap->host->max_cmd_len = 16;
@@ -1155,7 +1135,7 @@
 
 	/* ATAPI-specific feature tests */
 	else {
-		if (ata_id_is_ata(dev))		/* sanity check */
+		if (ata_id_is_ata(dev->id))		/* sanity check */
 			goto err_out_nosup;
 
 		rc = atapi_cdb_len(dev->id);
@@ -1785,8 +1765,10 @@
 }
 
 /**
- *	ata_choose_xfer_mode -
- *	@ap:
+ *	ata_choose_xfer_mode - attempt to find best transfer mode
+ *	@ap: Port for which an xfer mode will be selected
+ *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
+ *	@xfer_shift_out: (output) bit shift that selects this mode
  *
  *	LOCKING:
  *
@@ -1869,7 +1851,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg = qc->sg;
-	int dir = qc->pci_dma_dir;
+	int dir = qc->dma_dir;
 
 	assert(qc->flags & ATA_QCFLAG_DMAMAP);
 	assert(sg != NULL);
@@ -1880,9 +1862,9 @@
 	DPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	if (qc->flags & ATA_QCFLAG_SG)
-		pci_unmap_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
+		dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	else
-		pci_unmap_single(ap->host_set->pdev, sg_dma_address(&sg[0]),
+		dma_unmap_single(ap->host_set->dev, sg_dma_address(&sg[0]),
 				 sg_dma_len(&sg[0]), dir);
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
@@ -1993,12 +1975,14 @@
 static int ata_sg_setup_one(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	int dir = qc->pci_dma_dir;
+	int dir = qc->dma_dir;
 	struct scatterlist *sg = qc->sg;
 	dma_addr_t dma_address;
 
-	dma_address = pci_map_single(ap->host_set->pdev, qc->buf_virt,
+	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg_dma_len(sg), dir);
+	if (dma_mapping_error(dma_address))
+		return -1;
 
 	sg_dma_address(sg) = dma_address;
 
@@ -2028,8 +2012,8 @@
 	VPRINTK("ENTER, ata%u\n", ap->id);
 	assert(qc->flags & ATA_QCFLAG_SG);
 
-	dir = qc->pci_dma_dir;
-	n_elem = pci_map_sg(ap->host_set->pdev, sg, qc->n_elem, dir);
+	dir = qc->dma_dir;
+	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
 	if (n_elem < 1)
 		return -1;
 
@@ -2187,14 +2171,20 @@
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
+	unsigned int offset;
 	unsigned char *buf;
 
 	if (qc->cursect == (qc->nsect - 1))
 		ap->pio_task_state = PIO_ST_LAST;
 
 	page = sg[qc->cursg].page;
-	buf = kmap(page) +
-	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
+	buf = kmap(page) + offset;
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2213,11 +2203,64 @@
 	kunmap(page);
 }
 
-static void atapi_pio_sector(struct ata_queued_cmd *qc)
+static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+{
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	struct scatterlist *sg = qc->sg;
+	struct ata_port *ap = qc->ap;
+	struct page *page;
+	unsigned char *buf;
+	unsigned int offset, count;
+
+	if (qc->curbytes == qc->nbytes - bytes)
+		ap->pio_task_state = PIO_ST_LAST;
+
+next_sg:
+	sg = &qc->sg[qc->cursg];
+
+next_page:
+	page = sg->page;
+	offset = sg->offset + qc->cursg_ofs;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
+	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+
+	/* don't cross page boundaries */
+	count = min(count, (unsigned int)PAGE_SIZE - offset);
+
+	buf = kmap(page) + offset;
+
+	bytes -= count;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
+
+	if (qc->cursg_ofs == sg_dma_len(sg)) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
+
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	/* do the actual data transfer */
+	ata_data_xfer(ap, buf, count, do_write);
+
+	kunmap(page);
+
+	if (bytes) {
+		if (qc->cursg_ofs < sg_dma_len(sg))
+			goto next_page;
+		goto next_sg;
+	}
+}
+
+static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
-	unsigned int i, ireason, bc_lo, bc_hi, bytes;
+	unsigned int ireason, bc_lo, bc_hi, bytes;
 	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
 	ap->ops->tf_read(ap, &qc->tf);
@@ -2235,16 +2278,7 @@
 	if (do_write != i_write)
 		goto err_out;
 
-	/* make sure byte count is multiple of sector size; not
-	* required by standard (warning! warning!), but IDE driver
-	* does this to simplify things a bit.  We are lazy, and
-	* follow suit.
-	*/
-	if (bytes & (ATA_SECT_SIZE - 1))
-		goto err_out;
-
-	for (i = 0; i < (bytes >> 9); i++)
-		ata_pio_sector(qc);
+	__atapi_pio_bytes(qc, bytes);
 
 	return;
 
@@ -2285,19 +2319,30 @@
 		}
 	}
 
-	/* handle BSY=0, DRQ=0 as error */
-	if ((status & ATA_DRQ) == 0) {
-		ap->pio_task_state = PIO_ST_ERR;
-		return;
-	}
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	if (is_atapi_taskfile(&qc->tf))
-		atapi_pio_sector(qc);
-	else
+	if (is_atapi_taskfile(&qc->tf)) {
+		/* no more data to transfer or unsupported ATAPI command */
+		if ((status & ATA_DRQ) == 0) {
+			ap->pio_task_state = PIO_ST_IDLE;
+
+			ata_irq_on(ap);
+
+			ata_qc_complete(qc, status);
+			return;
+		}
+
+		atapi_pio_bytes(qc);
+	} else {
+		/* handle BSY=0, DRQ=0 as error */
+		if ((status & ATA_DRQ) == 0) {
+			ap->pio_task_state = PIO_ST_ERR;
+			return;
+		}
+
 		ata_pio_sector(qc);
+	}
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -2356,6 +2401,59 @@
 	}
 }
 
+static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
+				struct scsi_cmnd *cmd)
+{
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int using_pio = dev->flags & ATA_DFLAG_PIO;
+	int rc;
+
+	DPRINTK("ATAPI request sense\n");
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	/* FIXME: is this needed? */
+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+
+	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
+	qc->dma_dir = DMA_FROM_DEVICE;
+
+	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	qc->cdb[0] = REQUEST_SENSE;
+	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
+
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.command = ATA_CMD_PACKET;
+
+	if (using_pio) {
+		qc->tf.protocol = ATA_PROT_ATAPI;
+		qc->tf.lbam = (8 * 1024) & 0xff;
+		qc->tf.lbah = (8 * 1024) >> 8;
+
+		qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+	} else {
+		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		qc->tf.feature |= ATAPI_PKT_DMA;
+	}
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc)
+		ata_port_disable(ap);
+	else
+		wait_for_completion(&wait);
+
+	DPRINTK("EXIT\n");
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2377,10 +2475,29 @@
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
 
 	DPRINTK("ENTER\n");
 
+	/* FIXME: doesn't this conflict with timeout handling? */
+	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
+		struct scsi_cmnd *cmd = qc->scsicmd;
+
+		if (cmd->owner == SCSI_OWNER_ERROR_HANDLER) {
+
+			/* finish completing original command */
+			__ata_qc_complete(qc);
+
+			atapi_request_sense(ap, dev, cmd);
+
+			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
+			scsi_finish_command(cmd);
+
+			goto out;
+		}
+	}
+
 	/* hack alert!  We cannot use the supplied completion
 	 * function from inside the ->eh_strategy_handler() thread.
 	 * libata is the only user of ->eh_strategy_handler() in
@@ -2414,7 +2531,7 @@
 		ata_qc_complete(qc, drv_stat);
 		break;
 	}
-
+out:
 	DPRINTK("EXIT\n");
 }
 
@@ -2503,6 +2620,7 @@
 		qc->dev = dev;
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
+		qc->nbytes = qc->curbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
@@ -2518,6 +2636,30 @@
 	return 0;
 }
 
+static void __ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int tag, do_clear = 0;
+
+	qc->flags = 0;
+	tag = qc->tag;
+	if (likely(ata_tag_valid(tag))) {
+		if (tag == ap->active_tag)
+			ap->active_tag = ATA_TAG_POISON;
+		qc->tag = ATA_TAG_POISON;
+		do_clear = 1;
+	}
+
+	if (qc->waiting) {
+		struct completion *waiting = qc->waiting;
+		qc->waiting = NULL;
+		complete(waiting);
+	}
+
+	if (likely(do_clear))
+		clear_bit(tag, &ap->qactive);
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -2529,8 +2671,6 @@
 
 void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
-	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
 	int rc;
 
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
@@ -2548,23 +2688,7 @@
 	if (rc != 0)
 		return;
 
-	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
-		do_clear = 1;
-	}
-
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
-
-	if (likely(do_clear))
-		clear_bit(tag, &ap->qactive);
+	__ata_qc_complete(qc);
 
 	VPRINTK("EXIT\n");
 }
@@ -2983,9 +3107,9 @@
 
 int ata_port_start (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 
-	ap->prd = pci_alloc_consistent(pdev, ATA_PRD_TBL_SZ, &ap->prd_dma);
+	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
 	if (!ap->prd)
 		return -ENOMEM;
 
@@ -2996,9 +3120,9 @@
 
 void ata_port_stop (struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 
-	pci_free_consistent(pdev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
+	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
 /**
@@ -3044,7 +3168,7 @@
 	host->max_channel = 1;
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
-	host->pci_dev = ent->pdev;
+	host->pci_dev = to_pci_dev(ent->dev);
 
 	ap->flags = ATA_FLAG_PORT_DISABLED;
 	ap->id = host->unique_id;
@@ -3130,7 +3254,7 @@
 int ata_device_add(struct ata_probe_ent *ent)
 {
 	unsigned int count = 0, i;
-	struct pci_dev *pdev = ent->pdev;
+	struct device *dev = ent->dev;
 	struct ata_host_set *host_set;
 
 	DPRINTK("ENTER\n");
@@ -3142,7 +3266,7 @@
 	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
 	spin_lock_init(&host_set->lock);
 
-	host_set->pdev = pdev;
+	host_set->dev = dev;
 	host_set->n_ports = ent->n_ports;
 	host_set->irq = ent->irq;
 	host_set->mmio_base = ent->mmio_base;
@@ -3211,7 +3335,7 @@
 		}
 	}
 
-	pci_set_drvdata(pdev, host_set);
+	dev_set_drvdata(dev, host_set);
 
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
@@ -3310,7 +3434,7 @@
 }
 
 static struct ata_probe_ent *
-ata_probe_ent_alloc(int n, struct pci_dev *pdev, struct ata_port_info **port)
+ata_probe_ent_alloc(int n, struct device *dev, struct ata_port_info **port)
 {
 	struct ata_probe_ent *probe_ent;
 	int i;
@@ -3318,7 +3442,7 @@
 	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
-		       pci_name(pdev));
+		       pci_name(to_pci_dev(dev)));
 		return NULL;
 	}
 
@@ -3326,7 +3450,7 @@
 
 	for (i = 0; i < n; i++) {
 		INIT_LIST_HEAD(&probe_ent[i].node);
-		probe_ent[i].pdev = pdev;
+		probe_ent[i].dev = dev;
 
 		probe_ent[i].sht = port[i]->sht;
 		probe_ent[i].host_flags = port[i]->host_flags;
@@ -3340,10 +3464,12 @@
 	return probe_ent;
 }
 
+#ifdef CONFIG_PCI
 struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
-	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(1, pdev, port);
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(1, pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -3372,7 +3498,8 @@
 struct ata_probe_ent *
 ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
-	struct ata_probe_ent *probe_ent = ata_probe_ent_alloc(2, pdev, port);
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(2, pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;
 
@@ -3538,7 +3665,8 @@
 
 void ata_pci_remove_one (struct pci_dev *pdev)
 {
-	struct ata_host_set *host_set = pci_get_drvdata(pdev);
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
 	struct ata_port *ap;
 	unsigned int i;
 	Scsi_Host_Template *sht;
@@ -3577,7 +3705,7 @@
 
 	kfree(host_set);
 	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
+	dev_set_drvdata(dev, NULL);
 }
 
 /**
@@ -3628,6 +3756,7 @@
 
 	return (tmp == bits->val) ? 1 : 0;
 }
+#endif /* CONFIG_PCI */
 
 
 /**
@@ -3659,7 +3788,6 @@
  * Do not depend on ABI/API stability.
  */
 
-EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
@@ -3674,8 +3802,6 @@
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
-EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
-EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_check_status);
 EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
@@ -3690,15 +3816,23 @@
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
-EXPORT_SYMBOL_GPL(ata_pci_init_one);
-EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_detect);
 EXPORT_SYMBOL_GPL(ata_add_to_probe_list);
 EXPORT_SYMBOL_GPL(libata_msleep);
+EXPORT_SYMBOL_GPL(ssleep);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL_GPL(pci_test_config_bits);
+EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
+EXPORT_SYMBOL_GPL(ata_pci_init_one);
+EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+#endif /* CONFIG_PCI */
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/libata-scsi.c	2004-11-17 10:07:20 -05:00
@@ -36,9 +36,6 @@
 #include "libata.h"
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *));
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
 
@@ -101,7 +98,7 @@
 		return 0;
 
 	default:
-		rc = -EOPNOTSUPP;
+		rc = -ENOTTY;
 		break;
 	}
 
@@ -160,6 +157,7 @@
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
+ *	@drv_stat: value contained in ATA status register
  *
  *	Converts an ATA error into a SCSI error. While we are at it
  *	we decode and dump the ATA error for the user so that they
@@ -373,7 +371,7 @@
 	tf->protocol = ATA_PROT_NODATA;
 
 	if ((tf->flags & ATA_TFLAG_LBA48) &&
-	    (ata_id_has_flush_ext(qc->dev)))
+	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
 		tf->command = ATA_CMD_FLUSH;
@@ -643,7 +641,7 @@
 			ata_sg_init_one(qc, cmd->request_buffer,
 					cmd->request_bufflen);
 
-		qc->pci_dma_dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+		qc->dma_dir = cmd->sc_data_direction;
 	}
 
 	qc->complete_fn = ata_scsi_qc_complete;
@@ -700,6 +698,7 @@
 /**
  *	ata_scsi_rbuf_put - Unmap response buffer.
  *	@cmd: SCSI command containing buffer to be unmapped.
+ *	@buf: buffer to unmap
  *
  *	Unmaps response buffer contained within @cmd.
  *
@@ -707,19 +706,19 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd)
+static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
 {
 	if (cmd->use_sg) {
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(sg->page, KM_USER0);
+		kunmap_atomic(buf - sg->offset, KM_USER0);
 	}
 }
 
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
  *
  *	Takes care of the hard work of simulating a SCSI command...
@@ -743,7 +742,7 @@
 	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
 	memset(rbuf, 0, buflen);
 	rc = actor(args, rbuf, buflen);
-	ata_scsi_rbuf_put(cmd);
+	ata_scsi_rbuf_put(cmd, rbuf);
 
 	if (rc)
 		ata_bad_cdb(cmd, args->done);
@@ -755,7 +754,7 @@
 
 /**
  *	ata_scsiop_inq_std - Simulate INQUIRY command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -769,8 +768,6 @@
 unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen)
 {
-	struct ata_device *dev = args->dev;
-
 	u8 hdr[] = {
 		TYPE_DISK,
 		0,
@@ -780,7 +777,7 @@
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
-	if (ata_id_removeable(dev))
+	if (ata_id_removeable(args->id))
 		hdr[1] |= (1 << 7);
 
 	VPRINTK("ENTER\n");
@@ -789,8 +786,8 @@
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+		ata_dev_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -814,7 +811,7 @@
 
 /**
  *	ata_scsiop_inq_00 - Simulate INQUIRY EVPD page 0, list of pages
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -842,7 +839,7 @@
 
 /**
  *	ata_scsiop_inq_80 - Simulate INQUIRY EVPD page 80, device serial number
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -864,7 +861,7 @@
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > (ATA_SERNO_LEN + 4))
-		ata_dev_id_string(args->dev, (unsigned char *) &rbuf[4],
+		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
 				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
 	return 0;
@@ -874,7 +871,7 @@
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -903,7 +900,7 @@
 
 /**
  *	ata_scsiop_noop -
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -951,7 +948,7 @@
 
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
- *	@dev: Device associated with this MODE SENSE command
+ *	@id: device IDENTIFY data
  *	@ptr_io: (input/output) Location to store more output data
  *	@last: End of output data buffer
  *
@@ -963,7 +960,7 @@
  *	None.
  */
 
-static unsigned int ata_msense_caching(struct ata_device *dev, u8 **ptr_io,
+static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
 				       const u8 *last)
 {
 	u8 page[] = {
@@ -973,9 +970,9 @@
 		0, 0, 0, 0, 0, 0, 0, 0		/* 8 zeroes */
 	};
 
-	if (ata_id_wcache_enabled(dev))
+	if (ata_id_wcache_enabled(id))
 		page[2] |= (1 << 2);	/* write cache enable */
-	if (!ata_id_rahead_enabled(dev))
+	if (!ata_id_rahead_enabled(id))
 		page[12] |= (1 << 5);	/* disable read ahead */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
@@ -1029,7 +1026,7 @@
 
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1043,7 +1040,6 @@
 				  unsigned int buflen)
 {
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
-	struct ata_device *dev = args->dev;
 	unsigned int page_control, six_byte, output_len;
 
 	VPRINTK("ENTER\n");
@@ -1071,7 +1067,7 @@
 		break;
 
 	case 0x08:		/* caching */
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		break;
 
 	case 0x0a: {		/* control mode */
@@ -1081,7 +1077,7 @@
 
 	case 0x3f:		/* all pages */
 		output_len += ata_msense_rw_recovery(&p, last);
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		output_len += ata_msense_ctl_mode(&p, last);
 		break;
 
@@ -1103,7 +1099,7 @@
 
 /**
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1116,11 +1112,15 @@
 unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
 			        unsigned int buflen)
 {
-	u64 n_sectors = args->dev->n_sectors;
+	u64 n_sectors;
 	u32 tmp;
 
 	VPRINTK("ENTER\n");
 
+	if (ata_id_has_lba48(args->id))
+		n_sectors = ata_id_u64(args->id, 100);
+	else
+		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
 	tmp = n_sectors;	/* note: truncates, if lba48 */
@@ -1158,7 +1158,7 @@
 
 /**
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1210,9 +1210,15 @@
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		DPRINTK("request check condition\n");
+
 		cmd->result = SAM_STAT_CHECK_CONDITION;
-	else {
+
+		qc->scsidone(cmd);
+
+		return 1;
+	} else {
 		u8 *scsicmd = cmd->cmnd;
 
 		if (scsicmd[0] == INQUIRY) {
@@ -1222,7 +1228,7 @@
 			buflen = ata_scsi_rbuf_get(cmd, &buf);
 			buf[2] = 0x5;
 			buf[3] = (buf[3] & 0xf0) | 2;
-			ata_scsi_rbuf_put(cmd);
+			ata_scsi_rbuf_put(cmd, buf);
 		}
 		cmd->result = SAM_STAT_GOOD;
 	}
@@ -1284,13 +1290,15 @@
 #endif
 	}
 
+	qc->nbytes = cmd->bufflen;
+
 	return 0;
 }
 
 /**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
- *	@cmd: SCSI command to be sent to the device
+ *	@scsidev: SCSI device from which we derive the ATA device
  *
  *	Given various information provided in struct scsi_cmnd,
  *	map that onto an ATA bus, and using that mapping
@@ -1439,7 +1447,7 @@
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(ap, dev, cmd, done);
+			ata_scsi_simulate(dev->id, cmd, done);
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
@@ -1451,8 +1459,7 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@ap: Port to which ATA device is attached.
- *	@dev: Target device for CDB.
+ *	@id: current IDENTIFY data for target device.
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
@@ -1463,15 +1470,14 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *))
+void ata_scsi_simulate(u16 *id,
+		      struct scsi_cmnd *cmd,
+		      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	u8 *scsicmd = cmd->cmnd;
 
-	args.ap = ap;
-	args.dev = dev;
+	args.id = id;
 	args.cmd = cmd;
 	args.done = done;
 
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/libata.h	2004-11-17 10:07:20 -05:00
@@ -26,12 +26,11 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.02"	/* must be exactly four chars */
+#define DRV_VERSION	"1.10"	/* must be exactly four chars */
 
 struct ata_scsi_args {
-	struct ata_port		*ap;
-	struct ata_device	*dev;
-	struct scsi_cmnd		*cmd;
+	u16			*id;
+	struct scsi_cmnd	*cmd;
 	void			(*done)(struct scsi_cmnd *);
 };
 
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_nv.c	2004-11-17 10:07:20 -05:00
@@ -44,7 +44,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.03"
+#define DRV_VERSION			"0.5"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -235,6 +235,7 @@
 MODULE_DESCRIPTION("low-level driver for NVIDIA nForce SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
@@ -379,9 +380,6 @@
 
 	return 0;
 
-err_out_iounmap:
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		iounmap(probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
 err_out_free_ent:
@@ -448,12 +446,13 @@
 
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
 {
+	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	u8 intr_mask;
 	u8 regval;
 
-	pci_read_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, &regval);
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(probe_ent->pdev, NV_MCP_SATA_CFG_20, regval);
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 
 	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
 
@@ -465,6 +464,7 @@
 
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set)
 {
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 	u8 intr_mask;
 	u8 regval;
 
@@ -474,9 +474,9 @@
 
 	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
 
-	pci_read_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, &regval);
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(host_set->pdev, NV_MCP_SATA_CFG_20, regval);
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 }
 
 static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_promise.c	2004-11-17 10:07:20 -05:00
@@ -40,7 +40,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"1.00"
+#define DRV_VERSION	"1.01"
 
 #define msleep libata_msleep	/* 2.4-specific */
 
@@ -74,7 +74,7 @@
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
@@ -86,7 +86,7 @@
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
 
-static Scsi_Host_Template pdc_sata_sht = {
+static Scsi_Host_Template pdc_ata_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.detect			= ata_scsi_detect,
@@ -106,7 +106,7 @@
 	.bios_param		= ata_std_bios_param,
 };
 
-static struct ata_port_operations pdc_sata_ops = {
+static struct ata_port_operations pdc_ata_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= pdc_tf_load_mmio,
 	.tf_read		= ata_tf_read,
@@ -128,28 +128,28 @@
 static struct ata_port_info pdc_port_info[] = {
 	/* board_2037x */
 	{
-		.sht		= &pdc_sata_sht,
+		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_ata_ops,
 	},
 
 	/* board_20319 */
 	{
-		.sht		= &pdc_sata_sht,
+		.sht		= &pdc_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
-		.port_ops	= &pdc_sata_ops,
+		.port_ops	= &pdc_ata_ops,
 	},
 };
 
-static struct pci_device_id pdc_sata_pci_tbl[] = {
+static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -166,17 +166,17 @@
 };
 
 
-static struct pci_driver pdc_sata_pci_driver = {
+static struct pci_driver pdc_ata_pci_driver = {
 	.name			= DRV_NAME,
-	.id_table		= pdc_sata_pci_tbl,
-	.probe			= pdc_sata_init_one,
+	.id_table		= pdc_ata_pci_tbl,
+	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
 };
 
 
 static int pdc_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp;
 	int rc;
 
@@ -191,7 +191,7 @@
 	}
 	memset(pp, 0, sizeof(*pp));
 
-	pp->pkt = pci_alloc_consistent(pdev, 128, &pp->pkt_dma);
+	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
 		rc = -ENOMEM;
 		goto err_out_kfree;
@@ -211,11 +211,11 @@
 
 static void pdc_port_stop(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp = ap->private_data;
 
 	ap->private_data = NULL;
-	pci_free_consistent(pdev, 128, pp->pkt, pp->pkt_dma);
+	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
 	kfree(pp);
 	ata_port_stop(ap);
 }
@@ -483,7 +483,7 @@
 }
 
 
-static void pdc_sata_setup_port(struct ata_ioports *port, unsigned long base)
+static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
 {
 	port->cmd_addr		= base;
 	port->data_addr		= base;
@@ -541,7 +541,7 @@
 	writel(tmp, mmio + PDC_SLEW_CTL);
 }
 
-static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
@@ -576,7 +576,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 3),
@@ -598,8 +598,8 @@
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
 
-	pdc_sata_setup_port(&probe_ent->port[0], base + 0x200);
-	pdc_sata_setup_port(&probe_ent->port[1], base + 0x280);
+	pdc_ata_setup_port(&probe_ent->port[0], base + 0x200);
+	pdc_ata_setup_port(&probe_ent->port[1], base + 0x280);
 
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
@@ -609,8 +609,8 @@
 	case board_20319:
        		probe_ent->n_ports = 4;
 
-		pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
-		pdc_sata_setup_port(&probe_ent->port[3], base + 0x380);
+		pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+		pdc_ata_setup_port(&probe_ent->port[3], base + 0x380);
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
@@ -642,15 +642,15 @@
 }
 
 
-static int __init pdc_sata_init(void)
+static int __init pdc_ata_init(void)
 {
 	int rc;
 
-	rc = pci_module_init(&pdc_sata_pci_driver);
+	rc = pci_module_init(&pdc_ata_pci_driver);
 	if (rc)
 		return rc;
 
-	rc = scsi_register_module(MODULE_SCSI_HA, &pdc_sata_sht);
+	rc = scsi_register_module(MODULE_SCSI_HA, &pdc_ata_sht);
 	if (rc) {
 		rc = -ENODEV;
 		goto err_out;
@@ -659,22 +659,23 @@
 	return 0;
 
 err_out:
-	pci_unregister_driver(&pdc_sata_pci_driver);
+	pci_unregister_driver(&pdc_ata_pci_driver);
 	return rc;
 }
 
 
-static void __exit pdc_sata_exit(void)
+static void __exit pdc_ata_exit(void)
 {
-	scsi_unregister_module(MODULE_SCSI_HA, &pdc_sata_sht);
-	pci_unregister_driver(&pdc_sata_pci_driver);
+	scsi_unregister_module(MODULE_SCSI_HA, &pdc_ata_sht);
+	pci_unregister_driver(&pdc_ata_pci_driver);
 }
 
 
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Promise SATA TX2/TX4 low-level driver");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, pdc_sata_pci_tbl);
+MODULE_DEVICE_TABLE(pci, pdc_ata_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
-module_init(pdc_sata_init);
-module_exit(pdc_sata_exit);
+module_init(pdc_ata_init);
+module_exit(pdc_ata_exit);
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_sil.c	2004-11-17 10:07:20 -05:00
@@ -38,7 +38,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"0.54"
+#define DRV_VERSION	"0.8"
 
 enum {
 	sil_3112		= 0,
@@ -87,6 +87,7 @@
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
@@ -190,6 +191,7 @@
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 static void sil_post_set_mode (struct ata_port *ap)
 {
@@ -288,7 +290,7 @@
 	const char *s;
 	unsigned int len;
 
-	ata_dev_id_string(dev, model_num, ATA_ID_PROD_OFS,
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
@@ -360,7 +362,7 @@
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
 	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_sis.c	2004-11-17 10:07:20 -05:00
@@ -38,7 +38,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sis"
-#define DRV_VERSION	"0.10"
+#define DRV_VERSION	"0.5"
 
 enum {
 	sis_180			= 0,
@@ -129,6 +129,7 @@
 MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
 {
@@ -141,22 +142,24 @@
 
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
 	u32 val;
 
 	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return 0xffffffff;
-	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	pci_read_config_dword(pdev, cfg_addr, &val);
 	return val;
 }
 
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return;
-	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+	pci_write_config_dword(pdev, cfg_addr, val);
 }
 
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_svw.c	2004-11-17 10:07:20 -05:00
@@ -49,7 +49,7 @@
 #endif /* CONFIG_PPC_OF */
 
 #define DRV_NAME	"sata_svw"
-#define DRV_VERSION	"1.04"
+#define DRV_VERSION	"1.05"
 
 /* Taskfile registers offsets */
 #define K2_SATA_TF_CMD_OFFSET		0x00
@@ -245,7 +245,7 @@
 		return 0;
 
 	/* Find the OF node for the PCI device proper */
-	np = pci_device_to_OF_node(ap->host_set->pdev);
+	np = pci_device_to_OF_node(to_pci_dev(ap->host_set->dev));
 	if (np == NULL)
 		return 0;
 
@@ -374,7 +374,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 5),
@@ -483,6 +483,7 @@
 MODULE_DESCRIPTION("low-level driver for K2 SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, k2_sata_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 module_init(k2_sata_init);
 module_exit(k2_sata_exit);
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_sx4.c	2004-11-17 10:07:20 -05:00
@@ -40,7 +40,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_sx4"
-#define DRV_VERSION	"0.50"
+#define DRV_VERSION	"0.7"
 
 
 enum {
@@ -249,7 +249,7 @@
 
 static int pdc_port_start(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp;
 	int rc;
 
@@ -264,7 +264,7 @@
 	}
 	memset(pp, 0, sizeof(*pp));
 
-	pp->pkt = pci_alloc_consistent(pdev, 128, &pp->pkt_dma);
+	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
 		rc = -ENOMEM;
 		goto err_out_kfree;
@@ -284,11 +284,11 @@
 
 static void pdc_port_stop(struct ata_port *ap)
 {
-	struct pci_dev *pdev = ap->host_set->pdev;
+	struct device *dev = ap->host_set->dev;
 	struct pdc_port_priv *pp = ap->private_data;
 
 	ap->private_data = NULL;
-	pci_free_consistent(pdev, 128, pp->pkt, pp->pkt_dma);
+	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
 	kfree(pp);
 	ata_port_stop(ap);
 }
@@ -1397,7 +1397,7 @@
 	}
 
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 3),
@@ -1507,6 +1507,7 @@
 MODULE_DESCRIPTION("Promise SATA low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc_sata_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 module_init(pdc_sata_init);
 module_exit(pdc_sata_exit);
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_uli.c	2004-11-17 10:07:20 -05:00
@@ -32,7 +32,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_uli"
-#define DRV_VERSION	"0.11"
+#define DRV_VERSION	"0.2"
 
 enum {
 	uli_5289		= 0,
@@ -124,6 +124,7 @@
 MODULE_DESCRIPTION("low-level driver for ULi Electronics SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
 {
@@ -150,18 +151,20 @@
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
 	u32 val;
 
-	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	pci_read_config_dword(pdev, cfg_addr, &val);
 	return val;
 }
 
 static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
 
-	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+	pci_write_config_dword(pdev, cfg_addr, val);
 }
 
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg)
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_via.c	2004-11-17 10:07:20 -05:00
@@ -38,7 +38,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"0.20"
+#define DRV_VERSION	"1.0"
 
 enum {
 	via_sata		= 0,
@@ -139,6 +139,7 @@
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-11-17 10:07:20 -05:00
+++ b/drivers/scsi/sata_vsc.c	2004-11-17 10:07:20 -05:00
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_vsc"
-#define DRV_VERSION	"0.01"
+#define DRV_VERSION	"1.0"
 
 /* Interrupt register offsets (from chip base address) */
 #define VSC_SATA_INT_STAT_OFFSET	0x00
@@ -291,7 +291,7 @@
 		goto err_out_regions;
 	}
 	memset(probe_ent, 0, sizeof(*probe_ent));
-	probe_ent->pdev = pdev;
+	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	mmio_base = ioremap(pci_resource_start(pdev, 0),
@@ -331,6 +331,14 @@
 
 	pci_set_master(pdev);
 
+	/* 
+	 * Config offset 0x98 is "Extended Control and Status Register 0"
+	 * Default value is (1 << 28).  All bits except bit 28 are reserved in
+	 * DPA mode.  If bit 28 is set, LED 0 reflects all ports' activity.
+	 * If bit 28 is clear, each port has its own LED.
+	 */
+	pci_write_config_dword(pdev, 0x98, 0);
+
 	ata_add_to_probe_list(probe_ent);
 
 	return 0;
@@ -401,6 +409,7 @@
 MODULE_DESCRIPTION("low-level driver for Vitesse VSC7174 SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, vsc_sata_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 module_init(vsc_sata_init);
 module_exit(vsc_sata_exit);
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-11-17 10:07:20 -05:00
+++ b/include/linux/ata.h	2004-11-17 10:07:20 -05:00
@@ -24,6 +24,8 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
+#include <linux/types.h>
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_DMA_BOUNDARY	0xffffUL
 #define ATA_DMA_MASK		0xffffffffULL
@@ -33,8 +35,6 @@
 	ATA_MAX_DEVICES		= 2,	/* per bus/port */
 	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
 	ATA_SECT_SIZE		= 512,
-	ATA_SECT_SIZE_MASK	= (ATA_SECT_SIZE - 1),
-	ATA_SECT_DWORDS		= ATA_SECT_SIZE / sizeof(u32),
 
 	ATA_ID_WORDS		= 256,
 	ATA_ID_PROD_OFS		= 27,
@@ -142,6 +142,10 @@
 	XFER_PIO_2		= 0x0A,
 	XFER_PIO_1		= 0x09,
 	XFER_PIO_0		= 0x08,
+	XFER_SW_DMA_2		= 0x12,
+	XFER_SW_DMA_1		= 0x11,
+	XFER_SW_DMA_0		= 0x10,
+	XFER_PIO_SLOW		= 0x00,
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
@@ -217,24 +221,24 @@
 	u8			command;	/* IO operation */
 };
 
-#define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
-#define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
-#define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
-#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
-#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
-#define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
-#define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
-#define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
-#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
-#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
-#define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
-#define ata_id_u32(dev,n)	\
-	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
-#define ata_id_u64(dev,n)	\
-	( ((u64) dev->id[(n) + 3] << 48) |	\
-	  ((u64) dev->id[(n) + 2] << 32) |	\
-	  ((u64) dev->id[(n) + 1] << 16) |	\
-	  ((u64) dev->id[(n) + 0]) )
+#define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
+#define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
+#define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
+#define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
+#define ata_id_has_pm(id)	((id)[82] & (1 << 3))
+#define ata_id_has_lba(id)	((id)[49] & (1 << 9))
+#define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_u32(id,n)	\
+	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
+#define ata_id_u64(id,n)	\
+	( ((u64) (id)[(n) + 3] << 48) |	\
+	  ((u64) (id)[(n) + 2] << 32) |	\
+	  ((u64) (id)[(n) + 1] << 16) |	\
+	  ((u64) (id)[(n) + 0]) )
 
 static inline int atapi_cdb_len(u16 *dev_id)
 {
diff -Nru a/include/linux/libata-compat.h b/include/linux/libata-compat.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/libata-compat.h	2004-11-17 10:07:20 -05:00
@@ -0,0 +1,66 @@
+#ifndef __LIBATA_COMPAT_H__
+#define __LIBATA_COMPAT_H__
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#define MODULE_VERSION(ver_str)
+
+static inline unsigned long msecs_to_jiffies(unsigned long msecs)
+{
+	return ((HZ * msecs + 999) / 1000);
+}
+struct device {
+	struct pci_dev pdev;
+};
+
+static inline void msleep(unsigned long msecs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(msecs_to_jiffies(msecs) + 1);
+}
+
+static inline void libata_msleep(unsigned long msecs)
+{
+	msleep(msecs);
+}
+
+static inline void ssleep(unsigned long secs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout((HZ * secs) + 1);
+}
+
+static inline struct pci_dev *to_pci_dev(struct device *dev)
+{
+	return (struct pci_dev *) dev;
+}
+
+#define pci_set_consistent_dma_mask(pdev,mask) (0)
+
+#define DMA_FROM_DEVICE PCI_DMA_FROMDEVICE
+
+/* NOTE: dangerous! we ignore the 'gfp' argument */
+#define dma_alloc_coherent(dev,sz,dma,gfp) \
+	pci_alloc_consistent(to_pci_dev(dev),(sz),(dma))
+#define dma_free_coherent(dev,sz,addr,dma_addr) \
+	pci_free_consistent(to_pci_dev(dev),(sz),(addr),(dma_addr))
+
+#define dma_map_sg(dev,a,b,c) \
+	pci_map_sg(to_pci_dev(dev),(a),(b),(c))
+#define dma_unmap_sg(dev,a,b,c) \
+	pci_unmap_sg(to_pci_dev(dev),(a),(b),(c))
+
+#define dma_map_single(dev,a,b,c) \
+	pci_map_single(to_pci_dev(dev),(a),(b),(c))
+#define dma_unmap_single(dev,a,b,c) \
+	pci_unmap_single(to_pci_dev(dev),(a),(b),(c))
+
+#define dma_mapping_error(addr) (0)
+
+#define dev_get_drvdata(dev) \
+	pci_get_drvdata(to_pci_dev(dev))
+#define dev_set_drvdata(dev,ptr) \
+	pci_set_drvdata(to_pci_dev(dev),(ptr))
+
+#endif /* __LIBATA_COMPAT_H__ */
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-11-17 10:07:20 -05:00
+++ b/include/linux/libata.h	2004-11-17 10:07:20 -05:00
@@ -25,9 +25,11 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/tqueue.h>
+#include <linux/libata-compat.h>
 
 /*
  * compile-time options
@@ -68,6 +70,11 @@
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
+static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
+{
+	return (struct device *) pdev;
+}
+
 enum {
 	/* various global constants */
 	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
@@ -185,7 +192,7 @@
 
 struct ata_probe_ent {
 	struct list_head	node;
-	struct pci_dev		*pdev;
+	struct device 		*dev;
 	struct ata_port_operations	*port_ops;
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
@@ -204,7 +211,7 @@
 
 struct ata_host_set {
 	spinlock_t		lock;
-	struct pci_dev		*pdev;
+	struct device 		*dev;
 	unsigned long		irq;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
@@ -227,10 +234,14 @@
 	unsigned int		tag;
 	unsigned int		n_elem;
 
-	int			pci_dma_dir;
+	int			dma_dir;
 
 	unsigned int		nsect;
 	unsigned int		cursect;
+
+	unsigned int		nbytes;
+	unsigned int		curbytes;
+
 	unsigned int		cursg;
 	unsigned int		cursg_ofs;
 
@@ -358,12 +369,6 @@
 	struct ata_port_operations	*port_ops;
 };
 
-struct pci_bits {
-	unsigned int		reg;	/* PCI config register to read */
-	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
-	unsigned long		mask;
-	unsigned long		val;
-};
 
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
@@ -371,9 +376,11 @@
 extern void ata_bus_reset(struct ata_port *ap);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
+#ifdef CONFIG_PCI
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+#endif /* CONFIG_PCI */
 extern int ata_device_add(struct ata_probe_ent *ent);
 extern int ata_scsi_detect(Scsi_Host_Template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
@@ -395,10 +402,6 @@
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-extern struct ata_probe_ent *
-ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
-extern struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
@@ -406,23 +409,35 @@
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
-extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
+extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *));
 extern void ata_add_to_probe_list (struct ata_probe_ent *probe_ent);
 extern int ata_std_bios_param(Disk * disk, kdev_t dev, int *ip);
-extern void libata_msleep(unsigned long msecs);
 
 
-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
+#ifdef CONFIG_PCI
+struct pci_bits {
+	unsigned int		reg;	/* PCI config register to read */
+	unsigned int		width;	/* 1 (8 bit), 2 (16 bit), 4 (32 bit) */
+	unsigned long		mask;
+	unsigned long		val;
+};
+
+extern struct ata_probe_ent *
+ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
+extern struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
+extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
+
+#endif /* CONFIG_PCI */
+
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
@@ -620,9 +635,9 @@
 
 static inline int ata_try_flush_cache(struct ata_device *dev)
 {
-	return ata_id_wcache_enabled(dev) ||
-	       ata_id_has_flush(dev) ||
-	       ata_id_has_flush_ext(dev);
+	return ata_id_wcache_enabled(dev->id) ||
+	       ata_id_has_flush(dev->id) ||
+	       ata_id_has_flush_ext(dev->id);
 }
 
 #endif /* __LINUX_LIBATA_H__ */
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	2004-11-17 10:07:20 -05:00
+++ b/include/linux/mm.h	2004-11-17 10:07:20 -05:00
@@ -199,6 +199,11 @@
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
 
+static inline struct page *nth_page(struct page *page, int n)
+{
+	return page + n;
+}
+
 /*
  * Various page->flags bits:
  *
