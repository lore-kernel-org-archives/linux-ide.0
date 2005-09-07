From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Wed, 7 Sep 2005 10:39:17 +0900
Message-ID: <20050907013917.GA2803@htj.dyndns.org>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org> <20050906093659.GB14270@est.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:26426 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbVIGBja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 21:39:30 -0400
Received: by rproxy.gmail.com with SMTP id r35so1080984rna
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 18:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050906093659.GB14270@est.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

 Hello, Marc.

On Tue, Sep 06, 2005 at 11:36:59AM +0200, Marc Bevand wrote:
> Hello Tejun,
> 
> Tejun Heo wrote:
> |  I'll backport new sil24 to sil24-original tree so that we can
> | eliminate all other factors and compare two drivers again to find the
> | offending difference.  I'm currently in the middle of something so it
> | may take me a day or so.
> 
> Ok.
> 
> By the way, I tried a 32-bit kernel (libata-dev.git current, ALL branch).
> Here is what it gives (dmesg hand-recopied [2]):
> 
>   ata1: SATA max UDMA/100 cmd 0xF8820000 ctl 0x0 bmdma 0x0 irq 169
>   ata2: SATA max UDMA/100 cmd 0xF8822000 ctl 0x0 bmdma 0x0 irq 169
>   ata3: SATA max UDMA/100 cmd 0xF8824000 ctl 0x0 bmdma 0x0 irq 169
>   ata4: SATA max UDMA/100 cmd 0xF8826000 ctl 0x0 bmdma 0x0 irq 169
>   ata1: no device found (phy stat 00000000)
>   scsi0 : sata_sil24
>   ata2: no device found (phy stat 00000000)
>   scsi1 : sata_sil24
>   ata3: dev 0 not supported, ignoring
>   scsi2 : sata_sil24
>   ata4: dev 0 not supported, ignoring
>   scsi3 : sata_sil24
> 
> The disks are still not recognized. But the line [1] that usually displays
> the most important words of the IDENTIFY DEVICE reply is not present. This
> is interesting because it is probably a clue that an early error is occuring
> somewhere before the IDENTIFY DEVICE reply is received. I immediately did
> another test with ATA_DEBUG enabled (dmesg still hand-recopied [2]):

 That's because you set console level not to print DEBUG messages.
There's no path which skips message [1] but prints 'not supported'
message.
> 
> I lack the knowledge to fully interpret this dmesg correctly, but at least
> I know I need to direct my investigations toward ata_dev_identify(). That
> is what is on my TODO list for tomorrow...

 I believe the problem is that although the controller issues commands
to the device and raises interrupt on completion, it doesn't fill in
any data in the buffer we passed to it.  I don't know the reason but
that's the symptom.  Probably I screwed up during controller
initialization or something.

> [1] ataX: dev Y cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 [...]
> [2] Yes I know, next time I will use a serial console

 I really admire your patience for being able to report like you do
with hand copying.

 Here's a big patch against sil24-original branch.  It contains the
followings.

 a. build fix & oops fix for sil24-original branch
 b. backported sata_sil24_new driver
 c. debug messages (you don't need to turn on ATA_DEBUG)
 d. 50ms sleep after completion of IDENTIFY before actually reading data

 Building both sata_sil24 and sata_sil24_new as modules and
loading/unloading them work on my machine.  Can you please try this
and let me know how it goes?

 Thanks.

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -489,6 +489,14 @@ config SCSI_SATA_SIL24
 
 	  If unsure, say N.
 
+config SCSI_SATA_SIL24_NEW
+	tristate "Silicon Image 3124 SATA support [new driver]"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for Silicon Image 3124 Serial ATA.
+
+	  If unsure, say N.
+
 config SCSI_SATA_SIS
 	tristate "SiS 964/180 SATA support"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libat
 obj-$(CONFIG_SCSI_SATA_QSTOR)	+= libata.o sata_qstor.o
 obj-$(CONFIG_SCSI_SATA_SIL)	+= libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_SIL24)	+= libata.o sata_sil24.o
+obj-$(CONFIG_SCSI_SATA_SIL24_NEW) += libata.o sata_sil24_new.o
 obj-$(CONFIG_SCSI_SATA_VIA)	+= libata.o sata_via.o
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
 obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -49,6 +49,8 @@
 
 #include "libata.h"
 
+#define pd(fmt, args...) printk(KERN_ERR "[%-21s]: " fmt, __FUNCTION__ , ##args)
+
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
@@ -1181,6 +1183,7 @@ retry:
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
 
+	pd("issuing 0x%x, dev->id is at %p\n", qc->tf.command, dev->id);
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
@@ -1219,6 +1222,16 @@ retry:
 
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
+	pd("Command successfully completed, sleeping 50ms\n");
+	msleep(50);
+
+	pd("Dumping ID\n");
+	for (i = 0; i < 32; i++) {
+		u16 *p = dev->id + 8 * i;
+		pd("[%03d] %04x %04x %04x %04x  %04x %04x %04x %04x\n",
+		   8 * i, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
+	}
+
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
 	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
@@ -1576,7 +1589,7 @@ static void ata_host_set_dma(struct ata_
  *	PCI/etc. bus probe sem.
  *
  */
-static void ata_set_mode(struct ata_port *ap)
+void ata_set_mode(struct ata_port *ap)
 {
 	unsigned int i, xfer_shift;
 	u8 xfer_mode;
@@ -3912,7 +3925,10 @@ int ata_device_add(struct ata_probe_ent 
 		DPRINTK("ata%u: probe begin\n", ap->id);
 		/* @@ Silicon Image */
 		/* old rc = ata_bus_probe(ap); */
-		rc = host_set->ops->bus_probe(ap);
+		if (host_set->ops->bus_probe)
+			rc = host_set->ops->bus_probe(ap);
+		else
+			rc = ata_bus_probe(ap);
 		DPRINTK("ata%u: probe end\n", ap->id);
 
 		if (rc) {
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -383,7 +383,7 @@ inline void sil_dump_memory(int *p, int 
 
 #endif /* SIL_DEBUG */
 
-void swap_buf_le16(u16 *buf, unsigned int buf_words)
+static void swap_buf_le16(u16 *buf, unsigned int buf_words)
 {
 #ifdef __BIG_ENDIAN
         unsigned int i;
diff --git a/drivers/scsi/sata_sil24_new.c b/drivers/scsi/sata_sil24_new.c
new file mode 100644
--- /dev/null
+++ b/drivers/scsi/sata_sil24_new.c
@@ -0,0 +1,790 @@
+/*
+ * sata_sil24.c - Driver for Silicon Image 3124/3132 SATA-2 controllers
+ *
+ * Copyright 2005  Tejun Heo
+ *
+ * Based on preview driver from Silicon Image.
+ *
+ * NOTE: No NCQ/ATAPI support yet.  The preview driver didn't support
+ * NCQ nor ATAPI, and, unfortunately, I couldn't find out how to make
+ * those work.  Enabling those shouldn't be difficult.  Basic
+ * structure is all there (in libata-dev tree).  If you have any
+ * information about this hardware, please contact me or linux-ide.
+ * Info is needed on...
+ *
+ * - How to issue tagged commands and turn on sactive on issue accordingly.
+ * - Where to put an ATAPI command and how to tell the device to send it.
+ * - How to enable/use 64bit.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <scsi/scsi_host.h>
+#include "scsi.h"
+#include <linux/libata.h>
+#include <asm/io.h>
+
+#define pd(fmt, args...) printk(KERN_ERR "[%-21s]: " fmt, __FUNCTION__ , ##args)
+
+#define DRV_NAME	"sata_sil24"
+#define DRV_VERSION	"0.20"	/* Silicon Image's preview driver was 0.10 */
+
+#define NR_PORTS	4
+
+/*
+ * Port request block (PRB) 32 bytes
+ */
+struct sil24_prb {
+	u16	ctrl;
+	u16	prot;
+	u32	rx_cnt;
+	u8	fis[6 * 4];
+};
+
+/*
+ * Scatter gather entry (SGE) 16 bytes
+ */
+struct sil24_sge {
+	u64	addr;
+	u32	cnt;
+	u32	flags;
+};
+
+/*
+ * Port multiplier
+ */
+struct sil24_port_multiplier {
+	u32	diag;
+	u32	sactive;
+};
+
+enum {
+	/*
+	 * Global controller registers (128 bytes @ BAR0)
+	 */
+		/* 32 bit regs */
+	HOST_SLOT_STAT		= 0x00, /* 32 bit slot stat * 4 */
+	HOST_CTRL		= 0x40,
+	HOST_IRQ_STAT		= 0x44,
+	HOST_PHY_CFG		= 0x48,
+	HOST_BIST_CTRL		= 0x50,
+	HOST_BIST_PTRN		= 0x54,
+	HOST_BIST_STAT		= 0x58,
+	HOST_MEM_BIST_STAT	= 0x5c,
+	HOST_FLASH_CMD		= 0x70,
+		/* 8 bit regs */
+	HOST_FLASH_DATA		= 0x74,
+	HOST_TRANSITION_DETECT	= 0x75,
+	HOST_GPIO_CTRL		= 0x76,
+	HOST_I2C_ADDR		= 0x78, /* 32 bit */
+	HOST_I2C_DATA		= 0x7c,
+	HOST_I2C_XFER_CNT	= 0x7e,
+	HOST_I2C_CTRL		= 0x7f,
+
+	/* HOST_SLOT_STAT bits */
+	HOST_SSTAT_ATTN		= (1 << 31),
+
+	/*
+	 * Port registers
+	 * (8192 bytes @ +0x0000, +0x2000, +0x4000 and +0x6000 @ BAR2)
+	 */
+	PORT_REGS_SIZE		= 0x2000,
+	PORT_PRB		= 0x0000, /* (32 bytes PRB + 16 bytes SGEs * 6) * 31 (3968 bytes) */
+
+	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
+		/* 32 bit regs */
+	PORT_CTRL_STAT		= 0x1000, /* write: ctrl-set, read: stat */
+	PORT_CTRL_CLR		= 0x1004, /* write: ctrl-clear */
+	PORT_IRQ_STAT		= 0x1008, /* high: status, low: interrupt */
+	PORT_IRQ_ENABLE_SET	= 0x1010, /* write: enable-set */
+	PORT_IRQ_ENABLE_CLR	= 0x1014, /* write: enable-clear */
+	PORT_ACTIVATE_UPPER_ADDR= 0x101c,
+	PORT_EXEC_FIFO		= 0x1020, /* command execution fifo */
+	PORT_CMD_ERR		= 0x1024, /* command error number */
+	PORT_FIS_CFG		= 0x1028,
+	PORT_FIFO_THRES		= 0x102c,
+		/* 16 bit regs */
+	PORT_DECODE_ERR_CNT	= 0x1040,
+	PORT_DECODE_ERR_THRESH	= 0x1042,
+	PORT_CRC_ERR_CNT	= 0x1044,
+	PORT_CRC_ERR_THRESH	= 0x1046,
+	PORT_HSHK_ERR_CNT	= 0x1048,
+	PORT_HSHK_ERR_THRESH	= 0x104a,
+		/* 32 bit regs */
+	PORT_PHY_CFG		= 0x1050,
+	PORT_SLOT_STAT		= 0x1800,
+	PORT_CMD_ACTIVATE	= 0x1c00, /* 64 bit cmd activate * 31 (248 bytes) */
+	PORT_EXEC_DIAG		= 0x1e00, /* 32bit exec diag * 16 (64 bytes, 0-10 used on 3124) */
+	PORT_PSD_DIAG		= 0x1e40, /* 32bit psd diag * 16 (64 bytes, 0-8 used on 3124) */
+	PORT_SCONTROL		= 0x1f00,
+	PORT_SSTATUS		= 0x1f04,
+	PORT_SERROR		= 0x1f08,
+	PORT_SACTIVE		= 0x1f0c,
+
+	/* PORT_CTRL_STAT bits */
+	PORT_CS_PORT_RST	= (1 << 0), /* port reset */
+	PORT_CS_DEV_RST		= (1 << 1), /* device reset */
+	PORT_CS_INIT		= (1 << 2), /* port initialize */
+	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
+	PORT_CS_RESUME		= (1 << 6), /* port resume */
+	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
+	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
+	PORT_CS_RDY		= (1 << 31), /* port ready to accept commands */
+
+	/* PORT_IRQ_STAT/ENABLE_SET/CLR */
+	/* bits[11:0] are masked */
+	PORT_IRQ_COMPLETE	= (1 << 0), /* command(s) completed */
+	PORT_IRQ_ERROR		= (1 << 1), /* command execution error */
+	PORT_IRQ_PORTRDY_CHG	= (1 << 2), /* port ready change */
+	PORT_IRQ_PWR_CHG	= (1 << 3), /* power management change */
+	PORT_IRQ_PHYRDY_CHG	= (1 << 4), /* PHY ready change */
+	PORT_IRQ_COMWAKE	= (1 << 5), /* COMWAKE received */
+	PORT_IRQ_UNK_FIS	= (1 << 6), /* Unknown FIS received */
+	PORT_IRQ_SDB_FIS	= (1 << 11), /* SDB FIS received */
+
+	/* bits[27:16] are unmasked (raw) */
+	PORT_IRQ_RAW_SHIFT	= 16,
+	PORT_IRQ_MASKED_MASK	= 0x7ff,
+	PORT_IRQ_RAW_MASK	= (0x7ff << PORT_IRQ_RAW_SHIFT),
+
+	/* ENABLE_SET/CLR specific, intr steering - 2 bit field */
+	PORT_IRQ_STEER_SHIFT	= 30,
+	PORT_IRQ_STEER_MASK	= (3 << PORT_IRQ_STEER_SHIFT),
+
+	/* PORT_CMD_ERR constants */
+	PORT_CERR_DEV		= 1, /* Error bit in D2H Register FIS */
+	PORT_CERR_SDB		= 2, /* Error bit in SDB FIS */
+	PORT_CERR_DATA		= 3, /* Error in data FIS not detected by dev */
+	PORT_CERR_SEND		= 4, /* Initial cmd FIS transmission failure */
+	PORT_CERR_INCONSISTENT	= 5, /* Protocol mismatch */
+	PORT_CERR_DIRECTION	= 6, /* Data direction mismatch */
+	PORT_CERR_UNDERRUN	= 7, /* Ran out of SGEs while writing */
+	PORT_CERR_OVERRUN	= 8, /* Ran out of SGEs while reading */
+	PORT_CERR_PKT_PROT	= 11, /* DIR invalid in 1st PIO setup of ATAPI */
+	PORT_CERR_SGT_BOUNDARY	= 16, /* PLD ecode 00 - SGT not on qword boundary */
+	PORT_CERR_SGT_TGTABRT	= 17, /* PLD ecode 01 - target abort */
+	PORT_CERR_SGT_MSTABRT	= 18, /* PLD ecode 10 - master abort */
+	PORT_CERR_SGT_PCIPERR	= 19, /* PLD ecode 11 - PCI parity err while fetching SGT */
+	PORT_CERR_CMD_BOUNDARY	= 24, /* ctrl[15:13] 001 - PRB not on qword boundary */
+	PORT_CERR_CMD_TGTABRT	= 25, /* ctrl[15:13] 010 - target abort */
+	PORT_CERR_CMD_MSTABRT	= 26, /* ctrl[15:13] 100 - master abort */
+	PORT_CERR_CMD_PCIPERR	= 27, /* ctrl[15:13] 110 - PCI parity err while fetching PRB */
+	PORT_CERR_XFR_UNDEF	= 32, /* PSD ecode 00 - undefined */
+	PORT_CERR_XFR_TGTABRT	= 33, /* PSD ecode 01 - target abort */
+	PORT_CERR_XFR_MSGABRT	= 34, /* PSD ecode 10 - master abort */
+	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
+	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
+
+	/*
+	 * Other constants
+	 */
+	SGE_TRM			= (1 << 31), /* Last SGE in chain */
+	PRB_SOFT_RST		= (1 << 7),  /* Soft reset request (ign BSY?) */
+
+	/* board id */
+	BID_SIL3124		= 0,
+	BID_SIL3132		= 1,
+
+	IRQ_STAT_4PORTS		= 0xf,
+};
+
+struct sil24_cmd_block {
+	struct sil24_prb prb;
+	struct sil24_sge sge[LIBATA_MAX_PRD];
+};
+
+/*
+ * ap->private_data
+ *
+ * The preview driver always returned 0 for status.  We emulate it
+ * here from the previous interrupt.
+ */
+struct sil24_port_priv {
+	struct sil24_cmd_block *cmd_block;	/* 32 cmd blocks */
+	dma_addr_t cmd_block_dma;		/* DMA base addr for them */
+};
+
+/* ap->host_set->private_data */
+struct sil24_host_priv {
+	void *host_base;	/* global controller control (128 bytes @BAR0) */
+	void *port_base;	/* port registers (4 * 8192 bytes @BAR2) */
+};
+
+static u8 sil24_check_status(struct ata_port *ap);
+static u8 sil24_check_err(struct ata_port *ap);
+static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
+static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
+static void sil24_phy_reset(struct ata_port *ap);
+static void sil24_qc_prep(struct ata_queued_cmd *qc);
+static int sil24_qc_issue(struct ata_queued_cmd *qc);
+static void sil24_irq_clear(struct ata_port *ap);
+static void sil24_eng_timeout(struct ata_port *ap);
+static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static int sil24_port_start(struct ata_port *ap);
+static void sil24_port_stop(struct ata_port *ap);
+static void sil24_host_stop(struct ata_host_set *host_set);
+static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+
+static struct pci_device_id sil24_pci_tbl[] = {
+	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
+	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
+};
+
+static struct pci_driver sil24_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= sil24_pci_tbl,
+	.probe			= sil24_init_one,
+	.remove			= ata_pci_remove_one, /* safe? */
+};
+
+static Scsi_Host_Template sil24_sht = {
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
+	.ordered_flush		= 1, /* NCQ not supported yet */
+};
+
+static struct ata_port_operations sil24_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= sil24_check_status,
+	.check_altstatus	= sil24_check_status,
+	.check_err		= sil24_check_err,
+	.dev_select		= ata_noop_dev_select,
+
+	.phy_reset		= sil24_phy_reset,
+
+	.qc_prep		= sil24_qc_prep,
+	.qc_issue		= sil24_qc_issue,
+
+	.eng_timeout		= sil24_eng_timeout,
+
+	.irq_handler		= sil24_interrupt,
+	.irq_clear		= sil24_irq_clear,
+
+	.scr_read		= sil24_scr_read,
+	.scr_write		= sil24_scr_write,
+
+	.port_start		= sil24_port_start,
+	.port_stop		= sil24_port_stop,
+	.host_stop		= sil24_host_stop,
+};
+
+static struct ata_port_info sil24_port_info[] = {
+	/* sil_3124 */
+	{
+		.sht		= &sil24_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_DMA,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil24_ops,
+	},
+	/* sil_3132 */ 
+	{
+		.sht		= &sil24_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_DMA,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil24_ops,
+	},
+};
+
+static u8 sil24_check_status(struct ata_port *ap)
+{
+	return ATA_DRDY;
+}
+
+static u8 sil24_check_err(struct ata_port *ap)
+{
+	return 0;
+}
+
+static int sil24_scr_map[] = {
+	[SCR_CONTROL]	= 0,
+	[SCR_STATUS]	= 1,
+	[SCR_ERROR]	= 2,
+	[SCR_ACTIVE]	= 3,
+};
+
+static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg)
+{
+	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
+		void *addr;
+		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
+		return readl(scr_addr + sil24_scr_map[sc_reg] * 4);
+	}
+	return 0xffffffffU;
+}
+
+static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
+{
+	void *scr_addr = (void *)ap->ioaddr.scr_addr;
+	if (sc_reg < ARRAY_SIZE(sil24_scr_map)) {
+		void *addr;
+		addr = scr_addr + sil24_scr_map[sc_reg] * 4;
+		writel(val, scr_addr + sil24_scr_map[sc_reg] * 4);
+	}
+}
+
+static void sil24_phy_reset(struct ata_port *ap)
+{
+	__sata_phy_reset(ap);
+	/*
+	 * No ATAPI yet.  Just unconditionally indicate ATA device.
+	 * If ATAPI device is attached, it will fail ATA_CMD_ID_ATA
+	 * and libata core will ignore the device.
+	 */
+	if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
+		ap->device[0].class = ATA_DEV_ATA;
+}
+
+static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
+				 struct sil24_cmd_block *cb)
+{
+	struct scatterlist *sg = qc->sg;
+	struct sil24_sge *sge = cb->sge;
+	unsigned i;
+
+	pd("filling %u elements\n", qc->n_elem);
+	for (i = 0; i < qc->n_elem; i++, sg++, sge++) {
+		sge->addr = cpu_to_le64(sg_dma_address(sg));
+		sge->cnt = cpu_to_le32(sg_dma_len(sg));
+		sge->flags = 0;
+		sge->flags = i < qc->n_elem - 1 ? 0 : cpu_to_le32(SGE_TRM);
+		pd("%016llx %u %x\n", sge->addr, sge->cnt, sge->flags);
+	}
+}
+
+static void sil24_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct sil24_port_priv *pp = ap->private_data;
+	struct sil24_cmd_block *cb = pp->cmd_block + qc->tag;
+	struct sil24_prb *prb = &cb->prb;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_PIO:
+	case ATA_PROT_DMA:
+	case ATA_PROT_NODATA:
+		break;
+	default:
+		/* ATAPI isn't supported yet */
+		BUG();
+	}
+
+	ata_tf_to_fis(&qc->tf, prb->fis, 0);
+
+	if (qc->flags & ATA_QCFLAG_DMAMAP)
+		sil24_fill_sg(qc, cb);
+}
+
+static int sil24_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *port = (void *)ap->ioaddr.cmd_addr;
+	struct sil24_port_priv *pp = ap->private_data;
+	dma_addr_t paddr = pp->cmd_block_dma + qc->tag * sizeof(*pp->cmd_block);
+
+	pd("issuing command 0x%x\n", qc->tf.command);
+	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
+	return 0;
+}
+
+static void sil24_irq_clear(struct ata_port *ap)
+{
+	/* unused */
+}
+
+static void sil24_reset_controller(struct ata_port *ap)
+{
+	void *port = (void *)ap->ioaddr.cmd_addr;
+	int cnt;
+	u32 tmp;
+
+	printk(KERN_NOTICE DRV_NAME
+	       " ata%u: resetting controller...\n", ap->id);
+
+	/* Reset controller state.  Is this correct? */
+	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
+	readl(port + PORT_CTRL_STAT);	/* sync */
+
+	/* Max ~100ms */
+	for (cnt = 0; cnt < 1000; cnt++) {
+		udelay(100);
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (!(tmp & PORT_CS_DEV_RST))
+			break;
+	}
+	if (tmp & PORT_CS_DEV_RST)
+		printk(KERN_ERR DRV_NAME
+		       " ata%u: failed to reset controller\n", ap->id);
+}
+
+static void sil24_eng_timeout(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (!qc) {
+		printk(KERN_ERR "ata%u: BUG: tiemout without command\n",
+		       ap->id);
+		return;
+	}
+
+	/*
+	 * hack alert!  We cannot use the supplied completion
+	 * function from inside the ->eh_strategy_handler() thread.
+	 * libata is the only user of ->eh_strategy_handler() in
+	 * any kernel, so the default scsi_done() assumes it is
+	 * not being called from the SCSI EH.
+	 */
+	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
+	qc->scsidone = scsi_finish_command;
+	ata_qc_complete(qc, ATA_ERR);
+
+	sil24_reset_controller(ap);
+}
+
+static void sil24_error_intr(struct ata_port *ap, u32 slot_stat)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	void *port = (void *)ap->ioaddr.cmd_addr;
+	u32 irq_stat, cmd_err, sstatus, serror;
+
+	irq_stat = readl(port + PORT_IRQ_STAT);
+	cmd_err = readl(port + PORT_CMD_ERR);
+	sstatus = readl(port + PORT_SSTATUS);
+	serror = readl(port + PORT_SERROR);
+
+	/* Clear IRQ/errors */
+	writel(irq_stat, port + PORT_IRQ_STAT);
+	if (cmd_err)
+		writel(cmd_err, port + PORT_CMD_ERR);
+	if (serror)
+		writel(serror, port + PORT_SERROR);
+
+	printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
+	       "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+	       ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+
+	if (qc)
+		ata_qc_complete(qc, ATA_ERR);
+
+	sil24_reset_controller(ap);
+}
+
+static inline void sil24_host_intr(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	void *port = (void *)ap->ioaddr.cmd_addr;
+	u32 slot_stat;
+
+	slot_stat = readl(port + PORT_SLOT_STAT);
+	if (!(slot_stat & HOST_SSTAT_ATTN)) {
+		if (qc)
+			ata_qc_complete(qc, 0);
+	} else
+		sil24_error_intr(ap, slot_stat);
+}
+
+static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	struct sil24_host_priv *hpriv = host_set->private_data;
+	unsigned handled = 0;
+	u32 status;
+	int i;
+
+	status = readl(hpriv->host_base + HOST_IRQ_STAT);
+
+	if (status == 0xffffffff) {
+		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
+		       "PCI fault or device removal?\n");
+		goto out;
+	}
+
+	if (!(status & IRQ_STAT_4PORTS))
+		goto out;
+
+	spin_lock(&host_set->lock);
+
+	for (i = 0; i < host_set->n_ports; i++)
+		if (status & (1 << i)) {
+			struct ata_port *ap = host_set->ports[i];
+			if (ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
+				sil24_host_intr(host_set->ports[i]);
+				handled++;
+			} else
+				printk(KERN_ERR DRV_NAME
+				       ": interrupt from disabled port %d\n", i);
+		}
+
+	spin_unlock(&host_set->lock);
+ out:
+	return IRQ_RETVAL(handled);
+}
+
+static int sil24_port_start(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct sil24_port_priv *pp;
+	struct sil24_cmd_block *cb;
+	size_t cb_size = sizeof(*cb);
+	dma_addr_t cb_dma;
+
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+	memset(pp, 0, sizeof(*pp));
+
+	cb = dma_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
+	if (!cb) {
+		kfree(pp);
+		return -ENOMEM;
+	}
+	memset(cb, 0, cb_size);
+
+	pp->cmd_block = cb;
+	pp->cmd_block_dma = cb_dma;
+
+	ap->private_data = pp;
+
+	return 0;
+}
+
+static void sil24_port_stop(struct ata_port *ap)
+{
+	struct device *dev = ap->host_set->dev;
+	struct sil24_port_priv *pp = ap->private_data;
+	size_t cb_size = sizeof(*pp->cmd_block);
+
+	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
+	kfree(pp);
+}
+
+static void sil24_host_stop(struct ata_host_set *host_set)
+{
+	struct sil24_host_priv *hpriv = host_set->private_data;
+
+	iounmap(hpriv->host_base);
+	iounmap(hpriv->port_base);
+	kfree(hpriv);
+}
+
+static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version = 0;
+	unsigned int board_id = (unsigned int)ent->driver_data;
+	struct ata_probe_ent *probe_ent = NULL;
+	struct sil24_host_priv *hpriv = NULL;
+	void *host_base = NULL, *port_base = NULL;
+	int i, rc;
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
+		goto out_disable;
+
+	rc = -ENOMEM;
+	/* ioremap mmio registers */
+	host_base = ioremap(pci_resource_start(pdev, 0),
+			    pci_resource_len(pdev, 0));
+	if (!host_base)
+		goto out_free;
+	port_base = ioremap(pci_resource_start(pdev, 2),
+			    pci_resource_len(pdev, 2));
+	if (!port_base)
+		goto out_free;
+
+	/* allocate & init probe_ent and hpriv */
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent)
+		goto out_free;
+
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		goto out_free;
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->dev = pci_dev_to_dev(pdev);
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->sht		= sil24_port_info[board_id].sht;
+	probe_ent->host_flags	= sil24_port_info[board_id].host_flags;
+	probe_ent->pio_mask	= sil24_port_info[board_id].pio_mask;
+	probe_ent->udma_mask	= sil24_port_info[board_id].udma_mask;
+	probe_ent->port_ops	= sil24_port_info[board_id].port_ops;
+	probe_ent->n_ports	= (board_id == BID_SIL3124) ? 4 : 2;
+
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->mmio_base = port_base;
+	probe_ent->private_data = hpriv;
+
+	memset(hpriv, 0, sizeof(*hpriv));
+	hpriv->host_base = host_base;
+	hpriv->port_base = port_base;
+
+	/*
+	 * Configure the device
+	 */
+	/*
+	 * FIXME: This device is certainly 64-bit capable.  We just
+	 * don't know how to use it.  After fixing 32bit activation in
+	 * this function, enable 64bit masks here.
+	 */
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+	if (rc) {
+		printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
+		       pci_name(pdev));
+		goto out_free;
+	}
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+	if (rc) {
+		printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
+		       pci_name(pdev));
+		goto out_free;
+	}
+
+	/* GPIO off */
+	writel(0, host_base + HOST_FLASH_CMD);
+
+	/* Mask interrupts during initialization */
+	writel(0, host_base + HOST_CTRL);
+
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		void *port = port_base + i * PORT_REGS_SIZE;
+		unsigned long portu = (unsigned long)port;
+		u32 tmp;
+		int cnt;
+
+		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
+		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
+
+		ata_std_ports(&probe_ent->port[i]);
+
+		/* Initial PHY setting */
+		writel(0x20c, port + PORT_PHY_CFG);
+
+		/* Clear port RST */
+		tmp = readl(port + PORT_CTRL_STAT);
+		if (tmp & PORT_CS_PORT_RST) {
+			writel(PORT_CS_PORT_RST, port + PORT_CTRL_CLR);
+			readl(port + PORT_CTRL_STAT);	/* sync */
+			for (cnt = 0; cnt < 10; cnt++) {
+				msleep(10);
+				tmp = readl(port + PORT_CTRL_STAT);
+				if (!(tmp & PORT_CS_PORT_RST))
+					break;
+			}
+			if (tmp & PORT_CS_PORT_RST)
+				printk(KERN_ERR DRV_NAME
+				       "(%s): failed to clear port RST\n",
+				       pci_name(pdev));
+		}
+
+		/* Zero error counters. */
+		writel(0x8000, port + PORT_DECODE_ERR_THRESH);
+		writel(0x8000, port + PORT_CRC_ERR_THRESH);
+		writel(0x8000, port + PORT_HSHK_ERR_THRESH);
+		writel(0x0000, port + PORT_DECODE_ERR_CNT);
+		writel(0x0000, port + PORT_CRC_ERR_CNT);
+		writel(0x0000, port + PORT_HSHK_ERR_CNT);
+
+		/* FIXME: 32bit activation? */
+		writel(0, port + PORT_ACTIVATE_UPPER_ADDR);
+		writel(PORT_CS_32BIT_ACTV, port + PORT_CTRL_STAT);
+
+		/* Configure interrupts */
+		writel(0xffff, port + PORT_IRQ_ENABLE_CLR);
+		writel(PORT_IRQ_COMPLETE | PORT_IRQ_ERROR | PORT_IRQ_SDB_FIS,
+		       port + PORT_IRQ_ENABLE_SET);
+
+		/* Clear interrupts */
+		writel(0x0fff0fff, port + PORT_IRQ_STAT);
+		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+	}
+
+	/* Turn on interrupts */
+	writel(IRQ_STAT_4PORTS, host_base + HOST_CTRL);
+
+	pci_set_master(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+
+	kfree(probe_ent);
+	return 0;
+
+ out_free:
+	if (host_base)
+		iounmap(host_base);
+	if (port_base)
+		iounmap(port_base);
+	kfree(probe_ent);
+	kfree(hpriv);
+	pci_release_regions(pdev);
+ out_disable:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int __init sil24_init(void)
+{
+	return pci_module_init(&sil24_pci_driver);
+}
+
+static void __exit sil24_exit(void)
+{
+	pci_unregister_driver(&sil24_pci_driver);
+}
+
+MODULE_AUTHOR("Tejun Heo");
+MODULE_DESCRIPTION("Silicon Image 3124/3132 SATA low-level driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, sil24_pci_tbl);
+
+module_init(sil24_init);
+module_exit(sil24_exit);
