From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 10 Sep 2008 01:08:24 +0900 (JST)
Message-ID: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mips@linux-mips.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com
List-Id: linux-ide@vger.kernel.org

This is the driver for the Toshiba TX4939 SoC ATA controller.

This controller has standard ATA taskfile registers and DMA
command/status registers, but the register layout is swapped on big
endian.  There are some other endian issue and some special registers
which requires many custom dma_ops/port_ops routines.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-next 20080905.

 drivers/ide/Kconfig          |    6 +
 drivers/ide/mips/Makefile    |    1 +
 drivers/ide/mips/tx4939ide.c |  762 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 769 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ide/mips/tx4939ide.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 325461c..0ed731a 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -736,6 +736,12 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        default "128"
        depends on BLK_DEV_IDE_AU1XXX
 
+config BLK_DEV_IDE_TX4939
+	tristate "TX4939 internal IDE support"
+	depends on SOC_TX4939
+	select BLK_DEV_IDEDMA_SFF
+	select IDE_TIMINGS
+
 config IDE_ARM
 	tristate "ARM IDE support"
 	depends on ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/ide/mips/Makefile b/drivers/ide/mips/Makefile
index 677c7b2..1e0ad98 100644
--- a/drivers/ide/mips/Makefile
+++ b/drivers/ide/mips/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
+obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 
 EXTRA_CFLAGS    := -Idrivers/ide
diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
new file mode 100644
index 0000000..ba9776d
--- /dev/null
+++ b/drivers/ide/mips/tx4939ide.c
@@ -0,0 +1,762 @@
+/*
+ * TX4939 internal IDE driver
+ * Based on RBTX49xx patch from CELF patch archive.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * (C) Copyright TOSHIBA CORPORATION 2005-2007
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define MODNAME	"tx4939ide"
+
+/* ATA Shadow Registers (8bit except for DATA which is 16bit) */
+#define TX4939IDE_DATA	0x000
+#define TX4939IDE_Error_Ft	0x001
+#define TX4939IDE_Sec	0x002
+#define TX4939IDE_LBA0	0x003
+#define TX4939IDE_LBA1	0x004
+#define TX4939IDE_LBA2	0x005
+#define TX4939IDE_Device	0x006
+#define TX4939IDE_St_Cmd	0x007
+#define TX4939IDE_Alt_DevCtl	0x402
+/* H/W DMA Registers  */
+#define TX4939IDE_DMA_Cmd	0x800	/* 8bit */
+#define TX4939IDE_DMA_stat	0x802	/* 8bit */
+#define TX4939IDE_PRD_Ptr	0x804	/* 32bit */
+/* ATA100 CORE Registers (16bit) */
+#define TX4939IDE_Sys_Ctl	0xc00
+#define TX4939IDE_Xfer_Cnt_1	0xc08
+#define TX4939IDE_Xfer_Cnt_2	0xc0a
+#define TX4939IDE_Sec_Cnt	0xc10
+#define TX4939IDE_Strt_AddL	0xc18
+#define TX4939IDE_Strt_AddU	0xc20
+#define TX4939IDE_Add_Ctl	0xc28
+#define TX4939IDE_Lo_BCnt	0xc30
+#define TX4939IDE_Up_BCnt	0xc38
+#define TX4939IDE_PIO_Acc	0xc88
+#define TX4939IDE_H_Rst_Tim	0xc90
+#define TX4939IDE_int_ctl	0xc98
+#define TX4939IDE_Pkt_Cmd	0xcb8
+#define TX4939IDE_Bxfer_cntH	0xcc0
+#define TX4939IDE_Bxfer_cntL	0xcc8
+#define TX4939IDE_Dev_TErr	0xcd0
+#define TX4939IDE_Pkt_xfer_ct	0xcd8
+#define TX4939IDE_Strt_AddT	0xce0
+
+/* bits for int_ctl */
+#define TX4939IDE_INT_ADDRERR	0x80
+#define TX4939IDE_INT_REACHMUL	0x40
+#define TX4939IDE_INT_DEVTIMING	0x20
+#define TX4939IDE_INT_UDMATERM	0x10
+#define TX4939IDE_INT_TIMER	0x08
+#define TX4939IDE_INT_BUSERR	0x04
+#define TX4939IDE_INT_XFEREND	0x02
+#define TX4939IDE_INT_HOST	0x01
+
+#define TX4939IDE_IGNORE_INTS	\
+	(TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL | \
+	 TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_UDMATERM | \
+	 TX4939IDE_INT_TIMER)
+
+#ifdef __BIG_ENDIAN
+#define TX4939IDE_REG32(reg)	(TX4939IDE_##reg ^ 4)
+#define TX4939IDE_REG16(reg)	(TX4939IDE_##reg ^ 6)
+#define TX4939IDE_REG8(reg)	(TX4939IDE_##reg ^ 7)
+#else
+#define TX4939IDE_REG32(reg)	(TX4939IDE_##reg)
+#define TX4939IDE_REG16(reg)	(TX4939IDE_##reg)
+#define TX4939IDE_REG8(reg)	(TX4939IDE_##reg)
+#endif
+
+#define TX4939IDE_readl(base, reg) \
+	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
+#define TX4939IDE_readw(base, reg) \
+	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
+#define TX4939IDE_readb(base, reg) \
+	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
+#define TX4939IDE_writel(val, base, reg) \
+	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
+#define TX4939IDE_writew(val, base, reg) \
+	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
+#define TX4939IDE_writeb(val, base, reg) \
+	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))
+
+#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)
+
+static void tx4939ide_set_mode(ide_drive_t *drive, const u8 speed)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long base = TX4939IDE_BASE(hwif);
+	int is_slave = drive->dn & 1;
+	u16 value;
+	int safe_speed = speed;
+	int i;
+
+	for (i = 0; i < MAX_DRIVES; i++) {
+		if (drive != &hwif->drives[i] &&
+		    (hwif->drives[i].dev_flags & IDE_DFLAG_PRESENT))
+			safe_speed = min(safe_speed,
+					 (int)hwif->drives[i].current_speed);
+	}
+
+	/* Data Transfer Mode Select */
+	switch (speed) {
+	case XFER_UDMA_5:
+		value = 0x00d0;
+		break;
+	case XFER_UDMA_4:
+		value = 0x00c0;
+		break;
+	case XFER_UDMA_3:
+		value = 0x00b0;
+		break;
+	case XFER_UDMA_2:
+		value = 0x00a0;
+		break;
+	case XFER_UDMA_1:
+		value = 0x0090;
+		break;
+	case XFER_UDMA_0:
+		value = 0x0080;
+		break;
+	case XFER_MW_DMA_2:
+		value = 0x0070;
+		break;
+	case XFER_MW_DMA_1:
+		value = 0x0060;
+		break;
+	case XFER_MW_DMA_0:
+		value = 0x0050;
+		break;
+	case XFER_PIO_4:
+		value = 0x0040;
+		break;
+	case XFER_PIO_3:
+		value = 0x0030;
+		break;
+	case XFER_PIO_2:
+		value = 0x0020;
+		break;
+	case XFER_PIO_1:
+		value = 0x0010;
+		break;
+	default:
+	case XFER_PIO_0:
+		value = 0x0000;
+		break;
+	}
+	/* Command Transfer Mode Select */
+	switch (safe_speed) {
+	case XFER_UDMA_5:
+	case XFER_UDMA_4:
+	case XFER_UDMA_3:
+	case XFER_UDMA_2:
+	case XFER_UDMA_1:
+	case XFER_UDMA_0:
+	case XFER_MW_DMA_2:
+	case XFER_MW_DMA_1:
+	case XFER_MW_DMA_0:
+	case XFER_PIO_4:
+		value |= 0x0400;
+		break;
+	case XFER_PIO_3:
+		value |= 0x0300;
+		break;
+	case XFER_PIO_2:
+		value |= 0x0200;
+		break;
+	case XFER_PIO_1:
+		value |= 0x0100;
+		break;
+	default:
+	case XFER_PIO_0:
+		value |= 0x0000;
+		break;
+	}
+
+	if (is_slave)
+		hwif->select_data =
+			(hwif->select_data & ~0xffff0000) | (value << 16);
+	else
+		hwif->select_data = (hwif->select_data & ~0x0000ffff) | value;
+	TX4939IDE_writew(value, base, Sys_Ctl);
+}
+
+static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	tx4939ide_set_mode(drive, XFER_PIO_0 + pio);
+}
+
+static void tx4939ide_check_error_ints(ide_hwif_t *hwif, u16 stat)
+{
+	if (stat & TX4939IDE_INT_BUSERR) {
+		unsigned long base = TX4939IDE_BASE(hwif);
+		/* reset FIFO */
+		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) |
+				 0x4000,
+				 base, Sys_Ctl);
+	}
+	if (stat & (TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL |
+		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
+		pr_err("%s: Error interrupt %#x (%s%s%s%s )\n",
+		       hwif->name, stat,
+		       (stat & TX4939IDE_INT_ADDRERR) ?
+		       " Address-Error" : "",
+		       (stat & TX4939IDE_INT_REACHMUL) ?
+		       " Reach-Multiple" : "",
+		       (stat & TX4939IDE_INT_DEVTIMING) ?
+		       " DEV-Timing" : "",
+		       (stat & TX4939IDE_INT_BUSERR) ?
+		       " Bus-Error" : "");
+}
+
+static void tx4939ide_clear_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif;
+	unsigned long base;
+	u16 ctl;
+
+	/*
+	 * tx4939ide_dma_test_irq() and tx4939ide_dma_end() do all
+	 * jobs for DMA case.
+	 */
+	if (drive->waiting_for_dma)
+		return;
+	hwif = HWIF(drive);
+	base = TX4939IDE_BASE(hwif);
+	ctl = TX4939IDE_readw(base, int_ctl);
+
+	tx4939ide_check_error_ints(hwif, ctl);
+	TX4939IDE_writew(ctl, base, int_ctl);
+}
+
+static u8 tx4939ide_cable_detect(ide_hwif_t *hwif)
+{
+	unsigned long base = TX4939IDE_BASE(hwif);
+
+	return (TX4939IDE_readw(base, Sys_Ctl) & 0x2000)
+		? ATA_CBL_PATA40 : ATA_CBL_PATA80;
+}
+
+static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	u8 unit			= drive->dn & 1;
+	unsigned long base = TX4939IDE_BASE(hwif);
+	u8 dma_stat = TX4939IDE_readb(base, DMA_stat);
+
+	if (on)
+		dma_stat |= (1 << (5 + unit));
+	else
+		dma_stat &= ~(1 << (5 + unit));
+
+	TX4939IDE_writeb(dma_stat, base, DMA_stat);
+}
+
+static int __tx4939ide_dma_setup(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = HWGROUP(drive)->rq;
+	unsigned int reading;
+	u8 dma_stat;
+	unsigned long base = TX4939IDE_BASE(hwif);
+
+	if (rq_data_dir(rq))
+		reading = 0;
+	else
+		reading = 1 << 3;
+
+	/* fall back to pio! */
+	if (!ide_build_dmatable(drive, rq)) {
+		ide_map_sg(drive, rq);
+		return 1;
+	}
+#ifdef __BIG_ENDIAN
+	{
+		unsigned int *table = hwif->dmatable_cpu;
+		while (1) {
+			cpu_to_le64s((u64 *)table);
+			if (*table & 0x80000000)
+				break;
+			table += 2;
+		}
+	}
+#endif
+
+	/* PRD table */
+	TX4939IDE_writel(hwif->dmatable_dma, base, PRD_Ptr);
+
+	/* specify r/w */
+	TX4939IDE_writeb(reading, base, DMA_Cmd);
+
+	/* read DMA status for INTR & ERROR flags */
+	dma_stat = TX4939IDE_readb(base, DMA_stat);
+
+	/* clear INTR & ERROR flags */
+	TX4939IDE_writeb(dma_stat | 6, base, DMA_stat);
+	/* recover intmask cleared by writing to bit2 of DMA_stat */
+	TX4939IDE_writew(TX4939IDE_IGNORE_INTS << 8, base, int_ctl);
+
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
+static int tx4939ide_dma_setup(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long base = TX4939IDE_BASE(hwif);
+	int is_slave = drive->dn & 1;
+	unsigned int nframes;
+	int rc, i;
+	unsigned int sect_size = queue_hardsect_size(drive->queue);
+	u16 select_data;
+
+	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
+	TX4939IDE_writew(select_data, base, Sys_Ctl);
+	if (is_slave)
+		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_2);
+	else
+		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_1);
+
+	rc = __tx4939ide_dma_setup(drive);
+	if (rc == 0) {
+		/* Number of sectors to transfer. */
+		nframes = 0;
+		for (i = 0; i < hwif->sg_nents; i++)
+			nframes += sg_dma_len(&hwif->sg_table[i]);
+		BUG_ON(nframes % sect_size != 0);
+		nframes /= sect_size;
+		BUG_ON(nframes == 0);
+		TX4939IDE_writew(nframes, base, Sec_Cnt);
+	}
+	return rc;
+}
+
+static void tx4939ide_dma_start(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned long base = TX4939IDE_BASE(hwif);
+	u8 dma_cmd;
+
+	/* Note that this is done *after* the cmd has
+	 * been issued to the drive, as per the BM-IDE spec.
+	 */
+	dma_cmd = TX4939IDE_readb(base, DMA_Cmd);
+	/* start DMA */
+	TX4939IDE_writeb(dma_cmd | 1, base, DMA_Cmd);
+
+	wmb();
+}
+
+static int tx4939ide_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 dma_stat = 0, dma_cmd = 0;
+	unsigned long base = TX4939IDE_BASE(hwif);
+	u16 ctl = TX4939IDE_readw(base, int_ctl);
+
+	drive->waiting_for_dma = 0;
+
+	/* get DMA command mode */
+	dma_cmd = TX4939IDE_readb(base, DMA_Cmd);
+	/* stop DMA */
+	TX4939IDE_writeb(dma_cmd & ~1, base, DMA_Cmd);
+
+	/* get DMA status */
+	dma_stat = TX4939IDE_readb(base, DMA_stat);
+
+	/* clear the INTR & ERROR bits */
+	TX4939IDE_writeb(dma_stat | 6, base, DMA_stat);
+	/* recover intmask cleared by writing to bit2 of DMA_stat */
+	TX4939IDE_writew(TX4939IDE_IGNORE_INTS << 8, base, int_ctl);
+
+	/* purge DMA mappings */
+	ide_destroy_dmatable(drive);
+	/* verify good DMA status */
+	wmb();
+
+	if ((dma_stat & 7) == 0 &&
+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
+		/* INT_IDE lost... bug? */
+		return 0;
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
+}
+
+/* returns 1 if dma irq issued, 0 otherwise */
+static int tx4939ide_dma_test_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long base = TX4939IDE_BASE(hwif);
+	u16 ctl = TX4939IDE_readw(base, int_ctl);
+	u8 dma_stat, stat;
+	u16 ide_int;
+	int found = 0;
+
+	tx4939ide_check_error_ints(hwif, ctl);
+	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
+	switch (ide_int) {
+	case TX4939IDE_INT_HOST:
+		/* On error, XFEREND might not be asserted. */
+		stat = TX4939IDE_readb(base, Alt_DevCtl);
+		if ((stat & (ATA_BUSY|ATA_DRQ|ATA_ERR)) == ATA_ERR) {
+			pr_err("%s: detect error %x in %s\n",
+			       drive->name, stat, __func__);
+			found = 1;
+		}
+		/* FALLTHRU */
+	case TX4939IDE_INT_XFEREND:
+		/*
+		 * If only one of XFERINT and HOST was asserted, mask
+		 * this interrupt and wait for an another one.  Note
+		 * that write to bit2 of DMA_stat will clear all
+		 * mask bits.
+		 */
+		ctl |= ide_int << 8;
+		break;
+	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
+		dma_stat = TX4939IDE_readb(base, DMA_stat);
+		if (!(dma_stat & 4))
+			pr_debug("%s: weired interrupt status. "
+				 "DMA_stat %#02x int_ctl %#04x\n",
+				 hwif->name, dma_stat, ctl);
+		found = 1;
+		break;
+	}
+	/*
+	 * Do not clear XFERINT, HOST now.  They will be cleared by
+	 * clearing bit2 of DMA_stat.
+	 */
+	ctl &= ~ide_int;
+	TX4939IDE_writew(ctl, base, int_ctl);
+	return found;
+}
+
+static void tx4939ide_hwif_init(ide_hwif_t *hwif)
+{
+	unsigned long base = TX4939IDE_BASE(hwif);
+	int timeout;
+
+	/* Soft Reset */
+	TX4939IDE_writew(0x8000, base, Sys_Ctl);
+	mmiowb();
+	udelay(1);	/* at least 20 UPSCLK (100ns for 200MHz GBUSCLK) */
+	/* ATA Hard Reset */
+	TX4939IDE_writew(0x0800, base, Sys_Ctl);
+	timeout = 1000;
+	while (TX4939IDE_readw(base, Sys_Ctl) & 0x0800) {
+		if (timeout--)
+			break;
+		udelay(1);
+	}
+	/* mask some interrupts and clear all interrupts */
+	TX4939IDE_writew((TX4939IDE_IGNORE_INTS << 8) | 0xff, base, int_ctl);
+
+#ifdef __BIG_ENDIAN
+	/* This setting does not affect PRD fetch */
+	/* ByteSwap=1, Endian=00 */
+	TX4939IDE_writew(0xc911, base, Add_Ctl);
+#else
+	TX4939IDE_writew(0xc901, base, Add_Ctl);
+#endif
+
+	TX4939IDE_writew(0x0008, base, Lo_BCnt);
+	TX4939IDE_writew(0, base, Up_BCnt);
+}
+
+static int tx4939ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
+{
+	return ide_allocate_dma_engine(hwif);
+}
+
+#ifdef __BIG_ENDIAN
+/* custom iops (independent from SWAP_IO_SPACE) */
+static u8 mm_inb(unsigned long port)
+{
+	return (u8)readb((void __iomem *)port);
+}
+static void mm_outb(u8 value, unsigned long port)
+{
+	writeb(value, (void __iomem *)port);
+}
+static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI = 0xFF;
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
+		u16 data = (tf->hob_data << 8) | tf->data;
+
+		__raw_writew(data, (void __iomem *)io_ports->data_addr);
+	}
+
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+		mm_outb(tf->hob_feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+		mm_outb(tf->hob_nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+		mm_outb(tf->hob_lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+		mm_outb(tf->hob_lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+		mm_outb(tf->hob_lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		mm_outb(tf->feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		mm_outb(tf->nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		mm_outb(tf->lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		mm_outb(tf->lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		mm_outb(tf->lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
+		unsigned long base = TX4939IDE_BASE(hwif);
+		mm_outb((tf->device & HIHI) | drive->select,
+			 io_ports->device_addr);
+		/* Fix ATA100 CORE System Control Register */
+		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) & 0x07f0,
+				 base, Sys_Ctl);
+	}
+}
+static void mm_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u16 data;
+
+		data = __raw_readw((void __iomem *)io_ports->data_addr);
+		tf->data = data & 0xff;
+		tf->hob_data = (data >> 8) & 0xff;
+	}
+
+	/* be sure we're looking at the low order bits */
+	mm_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = mm_inb(io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  = mm_inb(io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   = mm_inb(io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   = mm_inb(io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   = mm_inb(io_ports->lbah_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device = mm_inb(io_ports->device_addr);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		mm_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature = mm_inb(io_ports->feature_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   = mm_inb(io_ports->nsect_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    = mm_inb(io_ports->lbal_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    = mm_inb(io_ports->lbam_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    = mm_inb(io_ports->lbah_addr);
+	}
+}
+
+static void mm_insw_swap(unsigned long port, void *addr, u32 count)
+{
+	unsigned short *ptr = addr;
+	unsigned long size = count * 2;
+	port &= ~1;
+	while (count--)
+		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
+	__ide_flush_dcache_range((unsigned long)addr, size);
+}
+static void mm_outsw_swap(unsigned long port, void *addr, u32 count)
+{
+	unsigned short *ptr = addr;
+	unsigned long size = count * 2;
+	port &= ~1;
+	while (count--) {
+		__raw_writew(cpu_to_le16(*ptr), (void __iomem *)port);
+		ptr++;
+	}
+	__ide_flush_dcache_range((unsigned long)addr, size);
+}
+static void mmio_input_data_swap(ide_drive_t *drive, struct request *rq,
+				 void *buf, unsigned int len)
+{
+	mm_insw_swap(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+static void mmio_output_data_swap(ide_drive_t *drive, struct request *rq,
+				  void *buf, unsigned int len)
+{
+	mm_outsw_swap(drive->hwif->io_ports.data_addr, buf, (len + 1) / 2);
+}
+
+static u8 tx4939ide_read_sff_dma_status(ide_hwif_t *hwif)
+{
+	unsigned long base = TX4939IDE_BASE(hwif);
+	return TX4939IDE_readb(base, DMA_stat);
+}
+
+static const struct ide_tp_ops tx4939ide_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
+
+	.set_irq		= ide_set_irq,
+
+	.tf_load		= mm_tf_load,
+	.tf_read		= mm_tf_read,
+
+	.input_data		= mmio_input_data_swap,
+	.output_data		= mmio_output_data_swap,
+};
+#endif	/* __BIG_ENDIAN */
+
+static const struct ide_port_ops tx4939ide_port_ops = {
+	.set_pio_mode = tx4939ide_set_pio_mode,
+	.set_dma_mode = tx4939ide_set_mode,
+	.clear_irq = tx4939ide_clear_irq,
+	.cable_detect = tx4939ide_cable_detect,
+};
+
+static const struct ide_dma_ops tx4939ide_dma_ops = {
+	.dma_host_set = tx4939ide_dma_host_set,
+	.dma_setup = tx4939ide_dma_setup,
+	.dma_exec_cmd = ide_dma_exec_cmd,
+	.dma_start = tx4939ide_dma_start,
+	.dma_end = tx4939ide_dma_end,
+	.dma_test_irq = tx4939ide_dma_test_irq,
+	.dma_lost_irq = ide_dma_lost_irq,
+	.dma_timeout = ide_dma_timeout,
+};
+
+static const struct ide_port_info tx4939ide_port_info __initdata = {
+	.init_hwif = tx4939ide_hwif_init,
+	.init_dma = tx4939ide_init_dma,
+	.port_ops = &tx4939ide_port_ops,
+	.dma_ops = &tx4939ide_dma_ops,
+#ifdef __BIG_ENDIAN
+	.tp_ops = &tx4939ide_tp_ops,
+#endif
+	.host_flags = IDE_HFLAG_MMIO,
+	.pio_mask = ATA_PIO4,
+	.mwdma_mask = ATA_MWDMA2,
+	.swdma_mask = ATA_SWDMA2,
+	.udma_mask = ATA_UDMA5,
+};
+
+static int __init tx4939ide_probe(struct platform_device *pdev)
+{
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct ide_host *host;
+	struct resource *res;
+	int irq;
+	unsigned long mapbase;
+	int ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
+					      res->end - res->start + 1);
+	if (!mapbase)
+		return -EBUSY;
+	memset(&hw, 0, sizeof(hw));
+	hw.io_ports.data_addr = mapbase + TX4939IDE_REG8(DATA);
+	hw.io_ports.error_addr = mapbase + TX4939IDE_REG8(Error_Ft);
+	hw.io_ports.nsect_addr = mapbase + TX4939IDE_REG8(Sec);
+	hw.io_ports.lbal_addr = mapbase + TX4939IDE_REG8(LBA0);
+	hw.io_ports.lbam_addr = mapbase + TX4939IDE_REG8(LBA1);
+	hw.io_ports.lbah_addr = mapbase + TX4939IDE_REG8(LBA2);
+	hw.io_ports.device_addr = mapbase + TX4939IDE_REG8(Device);
+	hw.io_ports.command_addr = mapbase + TX4939IDE_REG8(St_Cmd);
+	hw.io_ports.ctl_addr = mapbase + TX4939IDE_REG8(Alt_DevCtl);
+	hw.irq = irq;
+	hw.dev = &pdev->dev;
+
+	pr_info("TX4939 IDE interface (%lx,%d)\n", mapbase, irq);
+	ret = ide_host_add(&tx4939ide_port_info, hws, &host);
+	if (ret)
+		return ret;
+	platform_set_drvdata(pdev, host);
+	return 0;
+}
+
+static int __exit tx4939ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+
+	ide_host_remove(host);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tx4939ide_resume(struct platform_device *dev)
+{
+	struct ide_host *host = platform_get_drvdata(dev);
+	ide_hwif_t *hwif = host->ports[0];
+	unsigned long base = TX4939IDE_BASE(hwif);
+
+	tx4939ide_hwif_init(hwif);
+
+	/* restore Sys_Ctl */
+	TX4939IDE_writew(hwif->select_data & 0xffff, base, Sys_Ctl);
+	return 0;
+}
+#else
+#define tx4939ide_resume	NULL
+#endif
+
+static struct platform_driver tx4939ide_driver = {
+	.driver = {
+		.name = MODNAME,
+		.owner = THIS_MODULE,
+	},
+	.remove = __exit_p(tx4939ide_remove),
+	.resume = tx4939ide_resume,
+};
+
+static int __init tx4939ide_init(void)
+{
+	return platform_driver_probe(&tx4939ide_driver, tx4939ide_probe);
+}
+
+static void __exit tx4939ide_exit(void)
+{
+	platform_driver_unregister(&tx4939ide_driver);
+}
+
+module_init(tx4939ide_init);
+module_exit(tx4939ide_exit);
+
+MODULE_DESCRIPTION("TX4939 internal IDE driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tx4939ide");
-- 
1.5.6.3
