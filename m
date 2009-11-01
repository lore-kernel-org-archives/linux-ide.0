From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] S3C: ide: Add Samsung S3C IDE controller driver
Date: Sun,  1 Nov 2009 14:07:09 +0900
Message-ID: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:41607 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZKAFHj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 01:07:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, Thomas Abraham <thomas.ab@samsung.com>

This patch adds Samsung S3C IDE controller driver. This driver supports
PIO and UDMA modes of data transfer.

Note: This patch depends the following patch series.
[PATCH 0/7] S3C64XX: Add platform support for Samsung S3C IDE controller driver

Signed-off-by: Abhilash Kesavan <a.kesavan <at> samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab <at> samsung.com>
---
 drivers/ide/Kconfig    |    9 +
 drivers/ide/Makefile   |    1 +
 drivers/ide/ide-proc.c |    1 +
 drivers/ide/s3c-ide.c  |  822 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ide.h    |    2 +-
 5 files changed, 834 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ide/s3c-ide.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 9a5d0aa..35610bc 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -292,6 +292,15 @@ config BLK_DEV_IDEPNP
 	  would like the kernel to automatically detect and activate
 	  it, say Y here.

+config BLK_DEV_IDE_S3C
+	tristate "Samsung S3C IDE Controller"
+	depends on PLAT_S3C64XX
+	select BLK_DEV_IDEDMA
+	help
+	  Say Y here if you want to support onchip CF/IDE controller
+	  in Samsung SoC. It will be configured for True IDE mode with
+	  support for PIO and UDMA mode of data transfer.
+
 config BLK_DEV_IDEDMA_SFF
 	bool

diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 81df925..a64a723 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
 obj-$(CONFIG_BLK_DEV_SIS5513)		+= sis5513.o
 obj-$(CONFIG_BLK_DEV_SL82C105)		+= sl82c105.o
 obj-$(CONFIG_BLK_DEV_SLC90E66)		+= slc90e66.o
+obj-$(CONFIG_BLK_DEV_IDE_S3C)		+= s3c-ide.o
 obj-$(CONFIG_BLK_DEV_TC86C001)		+= tc86c001.o
 obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 3242698..d18478f 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -51,6 +51,7 @@ static int proc_ide_read_imodel
 	case ide_au1xxx:	name = "au1xxx";	break;
 	case ide_palm3710:      name = "palm3710";      break;
 	case ide_acorn:		name = "acorn";		break;
+	case ide_s3c: 		name = "s3c-ide";	break;
 	default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
diff --git a/drivers/ide/s3c-ide.c b/drivers/ide/s3c-ide.c
new file mode 100644
index 0000000..027af17
--- /dev/null
+++ b/drivers/ide/s3c-ide.c
@@ -0,0 +1,822 @@
+/*
+ * s3c-ide.c - Samsung S3C IDE controller Driver
+ *
+ * Copyright (C) 2009 Samsung Electronics
+ *      http://samsungsemi.com/
+ *
+ * The Samsung S3C IDE controller driver provides low-level support for
+ * interfacing with IDE disks. This controller driver supports PIO and
+ * UDMA data transfer modes.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <linux/sysdev.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <plat/regs-ide.h>
+#include <plat/ide.h>
+
+/*
+ * defines ide controller data transfer commands
+ */
+enum {
+	CMD_STOP,
+	CMD_START,
+	CMD_ABORT,
+	CMD_CONTINUE
+};
+
+/*
+ * defines the transfer class
+ */
+enum {
+	XFER_MODE_PIO_CPU,
+	XFER_MODE_PIO_DMA,
+	XFER_MODE_UDMA
+};
+
+/*
+ * defines the bus state
+ */
+enum {
+	BS_IDLE,
+	BS_BUSYW,
+	BS_PREP,
+	BS_BUSYR,
+	BS_PAUSER,
+	BS_PAUSEW,
+	BS_PAUSER2
+};
+
+struct dma_queue_t {
+	ulong addr;
+	ulong len;
+};
+
+/*
+ * struct s3c_ide_device - instance of ide controller device.
+ */
+struct s3c_ide_device {
+	struct platform_device	*pdev;
+	struct clk		*ide_clk;
+	ide_hwif_t 		*hwif;
+	int 			irq;
+	ulong 			piotime[5];
+	ulong 			udmatime[5];
+	void __iomem            *regbase;
+	u32 			index;	/* current queue index */
+	u32 			queue_size; /* total queue size requested */
+	struct dma_queue_t 	table[PRD_ENTRIES];
+	u32 			dma_mode; /* in DMA session */
+};
+
+static inline void ide_writel(struct s3c_ide_device *dev, u32 value, u32 reg)
+{
+	writel(value, dev->regbase + reg);
+}
+
+static inline u32 ide_readl(struct s3c_ide_device *dev, u32 reg)
+{
+	return readl(dev->regbase + reg);
+}
+
+/*
+ * waits until the IDE controller is able to perform next read/write
+ * operation to the disk.
+ */
+static int wait_for_host_ready(struct s3c_ide_device *ide_dev)
+{
+	ulong timeout;
+
+	/* wait for maximum of 20 msec */
+	timeout = jiffies + msecs_to_jiffies(20);
+	while (time_before(jiffies, timeout)) {
+		if ((ide_readl(ide_dev, S3C_ATA_FIFO_STATUS) >> 28) == 0)
+			return 0;
+	}
+	dev_err(&ide_dev->pdev->dev,
+		"ide controller not ready for next taskfile operation");
+	return -1;
+}
+
+/*
+ * writes to one of the task file registers.
+ */
+static void ide_outb(ide_hwif_t *hwif, u8 addr, ulong reg)
+{
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+
+	wait_for_host_ready(ide_dev);
+	__raw_writeb(addr, reg);
+}
+
+/*
+ * reads from one of the task file registers.
+ */
+static u8 ide_inb(ide_hwif_t *hwif, ulong reg)
+{
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+	u8 temp;
+
+	wait_for_host_ready(ide_dev);
+	temp = __raw_readb(reg);
+	wait_for_host_ready(ide_dev);
+	temp = __raw_readb(ide_dev->regbase + S3C_ATA_PIO_RDATA);
+	return temp;
+}
+
+/*
+ * following are ide_tp_ops functions implemented by the IDE
+ * cotnroller driver.
+ */
+static void s3c_ide_exec_command(ide_hwif_t *hwif, u8 cmd)
+{
+	ide_outb(hwif, cmd, hwif->io_ports.command_addr);
+}
+
+static u8 s3c_ide_read_status(ide_hwif_t *hwif)
+{
+	return ide_inb(hwif, hwif->io_ports.status_addr);
+}
+
+static u8 s3c_ide_read_altstatus(ide_hwif_t *hwif)
+{
+	return ide_inb(hwif, hwif->io_ports.ctl_addr);
+}
+
+static void s3c_ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
+{
+	ide_outb(hwif, ctl, hwif->io_ports.ctl_addr);
+}
+
+static void s3c_ide_dev_select(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 select = drive->select | ATA_DEVICE_OBS;
+	ide_outb(hwif, select, hwif->io_ports.device_addr);
+}
+
+static void s3c_ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
+					void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned long data_addr = io_ports->data_addr;
+	unsigned int words = (len + 1) >> 1, i;
+	u16 *temp_addr = (u16 *)buf;
+
+	for (i = 0; i < words; i++, temp_addr++) {
+		wait_for_host_ready(ide_dev);
+		*temp_addr = __raw_readw(data_addr);
+		wait_for_host_ready(ide_dev);
+		*temp_addr = __raw_readw(ide_dev->regbase + S3C_ATA_PIO_RDATA);
+	}
+}
+
+static void s3c_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
+					void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned long data_addr = io_ports->data_addr;
+	unsigned int words = (len + 1) >> 1, i;
+	u16 *temp_addr = (u16 *)buf;
+
+	for (i = 0; i < words; i++, temp_addr++) {
+		wait_for_host_ready(ide_dev);
+		writel(*temp_addr, data_addr);
+	}
+}
+
+static void s3c_ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf,
+				u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+
+	if (valid & IDE_VALID_FEATURE)
+		ide_outb(hwif, tf->feature, io_ports->feature_addr);
+	if (valid & IDE_VALID_NSECT)
+		ide_outb(hwif, tf->nsect, io_ports->nsect_addr);
+	if (valid & IDE_VALID_LBAL)
+		ide_outb(hwif, tf->lbal, io_ports->lbal_addr);
+	if (valid & IDE_VALID_LBAM)
+		ide_outb(hwif, tf->lbam, io_ports->lbam_addr);
+	if (valid & IDE_VALID_LBAH)
+		ide_outb(hwif, tf->lbah, io_ports->lbah_addr);
+	if (valid & IDE_VALID_DEVICE)
+		ide_outb(hwif, tf->device, io_ports->device_addr);
+}
+
+static void s3c_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+				u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+
+	if (valid & IDE_VALID_ERROR)
+		tf->error  = ide_inb(hwif, io_ports->feature_addr);
+	if (valid & IDE_VALID_NSECT)
+		tf->nsect  = ide_inb(hwif, io_ports->nsect_addr);
+	if (valid & IDE_VALID_LBAL)
+		tf->lbal   = ide_inb(hwif, io_ports->lbal_addr);
+	if (valid & IDE_VALID_LBAM)
+		tf->lbam   = ide_inb(hwif, io_ports->lbam_addr);
+	if (valid & IDE_VALID_LBAH)
+		tf->lbah   = ide_inb(hwif, io_ports->lbah_addr);
+	if (valid & IDE_VALID_DEVICE)
+		tf->device = ide_inb(hwif, io_ports->device_addr);
+}
+
+/*
+ * wait for a specified ide bus state
+ */
+static int wait_for_bus_state(struct s3c_ide_device *ide_dev, u8 state)
+{
+	u32 status, current_state;
+	ulong timeout;
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (time_before(jiffies, timeout)) {
+		status = ide_readl(ide_dev, S3C_BUS_FIFO_STATUS);
+		current_state = (status >> 16) & 0x7;
+		if (current_state == state) {
+			if ((state == BS_PAUSER2) || (state == BS_IDLE)) {
+				if (status & 0xFFFF)
+					continue;
+			}
+		}
+		return 0;
+	}
+	return -1;
+}
+
+/*
+ * reads a ide disk device register
+ */
+static u8 read_dev_reg(struct s3c_ide_device *ide_dev, u32 reg)
+{
+	u8 temp;
+
+	wait_for_host_ready(ide_dev);
+	temp = __raw_readb(ide_dev->regbase + reg);
+	wait_for_host_ready(ide_dev);
+	temp = __raw_readb(ide_dev->regbase + S3C_ATA_PIO_RDATA);
+	return temp;
+}
+
+/*
+ * sets the data transfer mode
+ */
+static void set_xfer_mode(struct s3c_ide_device *ide_dev, u8 mode, int rw)
+{
+	u32 reg = ide_readl(ide_dev, S3C_ATA_CFG) & ~(0x39c);
+
+	reg |= mode << 2;
+	if (mode && rw)
+		reg |= 0x10;
+	if (mode == XFER_MODE_UDMA)
+		reg |= 0x380;
+	ide_writel(ide_dev, reg, S3C_ATA_CFG);
+}
+
+static void set_xfer_command(struct s3c_ide_device *ide_dev, u8 cmd)
+{
+	wait_for_host_ready(ide_dev);
+	ide_writel(ide_dev, cmd, S3C_ATA_CMD);
+}
+
+/* Building the Scatter Gather Table */
+static int ide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
+{
+	int i, count = 0, nents = cmd->sg_nents;
+	ide_hwif_t *hwif = drive->hwif;
+	struct request *rq = hwif->rq;
+	struct scatterlist *sg;
+	u32 addr_reg, size_reg;
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+
+	if (rq_data_dir(rq) == WRITE) {
+		addr_reg = S3C_ATA_SBUF_START;
+		size_reg = S3C_ATA_SBUF_SIZE;
+	} else {
+		addr_reg = S3C_ATA_TBUF_START;
+		size_reg = S3C_ATA_TBUF_SIZE;
+	}
+
+	/* save information for interrupt context */
+	if (nents > 1)
+		ide_dev->dma_mode = 1;
+	if (!nents)
+		return 0;
+
+	/* fill the descriptors */
+	sg = hwif->sg_table;
+	for (i = 0, sg = hwif->sg_table; i < nents && sg_dma_len(sg);
+				 i++, sg++) {
+		ide_dev->table[i].addr = sg_dma_address(sg);
+		ide_dev->table[i].len = sg_dma_len(sg);
+		count += ide_dev->table[i].len;
+	}
+	ide_dev->table[i].addr = 0;
+	ide_dev->table[i].len = 0;
+	ide_dev->queue_size = i;
+
+	ide_writel(ide_dev, ide_dev->table[0].len - 0x1, size_reg);
+	ide_writel(ide_dev, ide_dev->table[0].addr, addr_reg);
+
+	ide_dev->index = 1;
+	ide_writel(ide_dev, count, S3C_ATA_XFR_NUM);
+	return 1;
+}
+
+/*
+ * wait for a specified status of the ide disk status
+ */
+static int wait_for_disk_status(ide_drive_t *drive, u8 status)
+{
+	u8 csd;
+	ulong timeout;
+	struct s3c_ide_device *ide_dev = drive->hwif->hwif_data;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (time_before(jiffies, timeout)) {
+		csd = read_dev_reg(ide_dev, S3C_ATA_PIO_CSD);
+		if ((csd == status) || (csd & ATA_ERR))
+			return 0;
+	}
+
+	dev_err(&ide_dev->pdev->dev,
+		"timeout occured while waiting for disk status");
+	return -1;
+}
+
+/*
+ * following are the ide_dma_ops functions implemented by the ide driver
+ */
+static int s3c_ide_dma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
+{
+	return 0;
+}
+
+static void s3c_ide_dma_host_set(ide_drive_t *drive, int on)
+{
+	return;
+}
+
+static int s3c_ide_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
+{
+	if (!ide_build_dmatable(drive, cmd))
+		return 1;
+
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
+static void s3c_ide_dma_start(ide_drive_t *drive)
+{
+	struct request *rq = drive->hwif->rq;
+	uint rw = (rq_data_dir(rq) == WRITE);
+	struct s3c_ide_device *ide_dev = drive->hwif->hwif_data;
+
+	wait_for_disk_status(drive, DRIVE_READY|ATA_DRQ);
+	ide_writel(ide_dev, 0x3, S3C_ATA_IRQ_MSK);
+	set_xfer_mode(ide_dev, XFER_MODE_UDMA, rw);
+	set_xfer_command(ide_dev, CMD_START);
+	return;
+}
+
+static int s3c_ide_dma_end(ide_drive_t *drive)
+{
+	struct s3c_ide_device *ide_dev = drive->hwif->hwif_data;
+
+	if (wait_for_host_ready(ide_dev))
+		return 1;
+
+	if ((ide_readl(ide_dev, S3C_BUS_FIFO_STATUS) >> 16) == BS_PAUSEW)
+		ide_writel(ide_dev, CMD_CONTINUE, S3C_ATA_CMD);
+
+	if (wait_for_bus_state(ide_dev, BS_IDLE))
+		return 1;
+
+	ide_writel(ide_dev, 0x3, S3C_ATA_IRQ_MSK);
+	set_xfer_mode(ide_dev, XFER_MODE_PIO_CPU, 0);
+	if (wait_for_disk_status(drive, DRIVE_READY))
+		return 1;
+	drive->waiting_for_dma = 0;
+	return 0;
+}
+
+static void s3c_ide_dma_lostirq(ide_drive_t *drive)
+{
+	struct s3c_ide_device *ide_dev = drive->hwif->hwif_data;
+	dev_err(&ide_dev->pdev->dev, "irq lost");
+}
+
+
+static int s3c_ide_dma_test_irq(ide_drive_t *drive)
+{
+	return 1;
+}
+
+static void set_ata_enable(struct s3c_ide_device *ide_dev, u8 state)
+{
+	u32 temp = ide_readl(ide_dev, S3C_ATA_CTRL);
+	temp = state ? temp | 1 : temp & ~1;
+	ide_writel(ide_dev, temp , S3C_ATA_CTRL);
+}
+
+static void set_endian_mode(struct s3c_ide_device *ide_dev, u8 mode)
+{
+	u32 reg = ide_readl(ide_dev, S3C_ATA_CFG);
+	reg = mode ? (reg & ~S3C_ATA_CFG_SWAP) : (reg | S3C_ATA_CFG_SWAP);
+	ide_writel(ide_dev, reg, S3C_ATA_CFG);
+}
+
+/*
+ * This function selects the maximum possible transfer speed.
+ */
+static u8 ide_ratefilter(ide_drive_t *drive, u8 speed)
+{
+	if (drive->media != ide_disk)
+		return min(speed, (u8) XFER_PIO_4);
+
+	switch (speed) {
+	case XFER_UDMA_6:
+	case XFER_UDMA_5:
+	speed = XFER_UDMA_4;
+		break;
+	case XFER_UDMA_4:
+	case XFER_UDMA_3:
+	case XFER_UDMA_2:
+	case XFER_UDMA_1:
+	case XFER_UDMA_0:
+		break;
+	default:
+		speed = min(speed, (u8) XFER_PIO_4);
+		break;
+	}
+	return speed;
+}
+
+/*
+ * This function selects the best possible transfer speed.
+ */
+static void s3c_ide_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+{
+	ide_hwif_t *hwif = (ide_hwif_t *)drive->hwif;
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+	u8 speed = ide_ratefilter(drive, xferspeed);
+	u32 ata_cfg;
+
+	/* IORDY is enabled for modes > PIO2 */
+	if (XFER_PIO_0 >= speed && speed <= XFER_PIO_4) {
+		ata_cfg = ide_readl(ide_dev, S3C_ATA_CFG);
+
+		switch (speed) {
+		case XFER_PIO_0:
+		case XFER_PIO_1:
+		case XFER_PIO_2:
+			ata_cfg &= (~S3C_ATA_CFG_IORDYEN);
+			break;
+		case XFER_PIO_3:
+		case XFER_PIO_4:
+			ata_cfg |= S3C_ATA_CFG_IORDYEN;
+			break;
+		}
+		ide_writel(ide_dev, ata_cfg, S3C_ATA_CFG);
+		ide_writel(ide_dev, ide_dev->piotime[speed - XFER_PIO_0],
+				S3C_ATA_PIO_TIME);
+	} else {
+		ide_writel(ide_dev, ide_dev->piotime[0], S3C_ATA_PIO_TIME);
+		ide_writel(ide_dev, ide_dev->udmatime[speed - XFER_UDMA_0],
+				S3C_ATA_UDMA_TIME);
+		set_endian_mode(ide_dev, 1);
+	}
+	ide_config_drive_speed(drive, speed);
+}
+
+static void s3c_ide_tune_drive(ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, 255, pio);
+	(void)s3c_ide_tune_chipset(drive, (XFER_PIO_0 + pio));
+}
+
+static irqreturn_t s3c_irq_handler(int irq, void *dev_id)
+{
+	ide_hwif_t *hwif = (ide_hwif_t *)dev_id;
+	struct s3c_ide_device *ide_dev = hwif->hwif_data;
+	u32 reg = ide_readl(ide_dev, S3C_ATA_IRQ);
+	u32 len, addr;
+	u32 stat;
+
+	ide_writel(ide_dev, reg, S3C_ATA_IRQ);
+	if (ide_dev->dma_mode) {
+		len = ide_dev->table[ide_dev->index].len - 1;
+		addr = ide_dev->table[ide_dev->index].addr;
+		if (reg & 0x10)
+			wait_for_bus_state(ide_dev, BS_PAUSER2);
+		else if (reg & 0x08) {
+			wait_for_bus_state(ide_dev, BS_PAUSEW);
+			ide_writel(ide_dev, len, S3C_ATA_TBUF_SIZE);
+			ide_writel(ide_dev, addr, S3C_ATA_TBUF_START);
+		} else
+			return 1;
+
+		ide_writel(ide_dev, len, S3C_ATA_SBUF_SIZE);
+		ide_writel(ide_dev, addr, S3C_ATA_SBUF_START);
+
+		if (ide_dev->queue_size == ++ide_dev->index)
+			ide_dev->dma_mode = 0;
+
+		ide_writel(ide_dev, CMD_CONTINUE, S3C_ATA_CMD);
+		return 1;
+	}
+
+	stat = ide_readl(ide_dev, S3C_BUS_FIFO_STATUS) >> 16;
+	if (stat == BS_PAUSER2)
+		ide_writel(ide_dev, CMD_CONTINUE, S3C_ATA_CMD);
+	else if (stat == BS_PAUSEW)
+		ide_writel(ide_dev, CMD_CONTINUE, S3C_ATA_CMD);
+
+	return ide_intr(irq, dev_id);
+}
+
+static void setup_timing_value(struct s3c_ide_device *ide_dev, u32 clk_rate)
+{
+	u32 t1, t2, teoc, i;
+	u32 uTdvh1, uTdvs, uTrp, uTss, uTackenv;
+	ulong cycle_time = (uint)(1000000000 / clk_rate);
+
+	/* transfer timing for PIO mode */
+	uint pio_t1[5] = { 70, 50, 30, 30, 30 };
+	uint pio_t2[5] = { 290, 290, 290, 80, 70 };
+	uint pio_teoc[5] = { 20, 20, 10, 10, 10 };
+
+	/* transfer timing for UDMA mode */
+	uint uUdmaTdvh[5] = { 50, 32, 29, 25, 24 };
+	uint uUdmaTdvs[5] = { 70, 48, 31, 20, 7 };
+	uint uUdmaTrp[5] = { 160, 125, 100, 100, 100 };
+	uint uUdmaTss[5] = { 50, 50, 50, 50, 50 };
+	uint uUdmaTackenvMin[5] = { 20, 20, 20, 20, 20 };
+
+	/* calculate pio_time register value for all PIO modes */
+	for (i = 0; i < 5; i++) {
+		t1 = (pio_t1[i] / cycle_time) & 0x0f;
+		t2 = (pio_t2[i] / cycle_time) & 0xff;
+		teoc = (pio_teoc[i] / cycle_time) & 0xff;
+		ide_dev->piotime[i] = (teoc << 12) | (t2 << 4) | t1;
+	}
+
+	/* calculate udma_time register value for all udma modes */
+	for (i = 0; i < 5; i++) {
+		uTdvh1 = (uUdmaTdvh[i] / cycle_time) & 0x0f;
+		uTdvs = (uUdmaTdvs[i] / cycle_time) & 0xff;
+		uTrp = (uUdmaTrp[i] / cycle_time) & 0xff;
+		uTss = (uUdmaTss[i] / cycle_time) & 0x0f;
+		uTackenv = (uUdmaTackenvMin[i] / cycle_time) & 0x0f;
+		ide_dev->udmatime[i] = (uTdvh1 << 24) | (uTdvs << 16) |
+			(uTrp << 8) | (uTss << 4) | uTackenv;
+	}
+}
+
+static void change_mode_to_ata(struct s3c_ide_device *ide_dev)
+{
+	ide_writel(ide_dev, ide_readl(ide_dev,
+		S3C_CFATA_MUX) | S3C_CFATA_MUX_TRUEIDE,	S3C_CFATA_MUX);
+}
+
+static void init_ide_device(struct s3c_ide_device *ide_dev)
+{
+	change_mode_to_ata(ide_dev);
+	set_endian_mode(ide_dev, 1);
+	set_ata_enable(ide_dev, 1);
+}
+
+static void ide_setup_ports(struct ide_hw *hw, struct s3c_ide_device *ide_dev)
+{
+	int i;
+	unsigned long *ata_regs = hw->io_ports_array;
+
+	/* S3C IDE controller does not include irq_addr port */
+	for (i = 0; i < IDE_NR_PORTS-1; i++)
+		*ata_regs++ = (ulong)ide_dev->regbase +
+				S3C_ATA_PIO_DTR + (i << 2);
+}
+
+static u8 s3c_cable_detect(ide_hwif_t *hwif)
+{
+	return ATA_CBL_PATA80;
+}
+
+static const struct ide_port_ops s3c_ide_port_ops = {
+	.set_pio_mode = s3c_ide_tune_drive,
+	.set_dma_mode = s3c_ide_tune_chipset,
+	.cable_detect = s3c_cable_detect,
+};
+
+static const struct ide_tp_ops s3c_ide_tp_ops = {
+	.exec_command   = s3c_ide_exec_command,
+	.read_status    = s3c_ide_read_status,
+	.read_altstatus = s3c_ide_read_altstatus,
+	.write_devctl   = s3c_ide_write_devctl,
+	.dev_select     = s3c_ide_dev_select,
+	.tf_load        = s3c_ide_tf_load,
+	.tf_read        = s3c_ide_tf_read,
+	.input_data     = s3c_ide_input_data,
+	.output_data    = s3c_ide_output_data,
+};
+
+static const struct ide_dma_ops s3c_ide_dma_ops = {
+	.dma_host_set 	= s3c_ide_dma_host_set,
+	.dma_setup 	= s3c_ide_dma_setup,
+	.dma_start 	= s3c_ide_dma_start,
+	.dma_end 	= s3c_ide_dma_end,
+	.dma_test_irq 	= s3c_ide_dma_test_irq,
+	.dma_lost_irq 	= s3c_ide_dma_lostirq,
+};
+
+static const struct ide_port_info s3c_port_info = {
+	.name		= "s3c-ide",
+	.init_dma	= s3c_ide_dma_init,
+	.dma_ops        = &s3c_ide_dma_ops,
+	.port_ops	= &s3c_ide_port_ops,
+	.tp_ops         = &s3c_ide_tp_ops,
+	.chipset	= ide_s3c,
+	.host_flags	= IDE_HFLAG_MMIO | IDE_HFLAG_NO_IO_32BIT |
+				IDE_HFLAG_UNMASK_IRQS,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask      = ATA_UDMA4
+};
+
+static int __devinit s3c_ide_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	struct s3c_ide_device *ide_dev;
+	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
+	struct ide_host *host;
+	int ret = 0;
+	struct ide_hw hw, *hws[] = { &hw };
+
+	ide_dev = kzalloc(sizeof(struct s3c_ide_device), GFP_KERNEL);
+	if (!ide_dev) {
+		dev_err(&pdev->dev, "no memory for s3c device instance\n");
+		return -ENOMEM;
+	}
+	ide_dev->pdev = pdev;
+
+	ide_dev->irq = platform_get_irq(pdev, 0);
+	if (ide_dev->irq < 0) {
+		dev_err(&pdev->dev, "could not obtain irq number\n");
+		ret = -ENODEV;
+		goto release_device_mem;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev,
+			"could not obtain base address of controller\n");
+		ret = -ENODEV;
+		goto release_device_mem;
+	}
+
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+		pdev->name)) {
+		dev_err(&pdev->dev, "could not obtain i/o address\n");
+		ret = -EBUSY;
+		goto release_device_mem;
+	}
+
+	ide_dev->regbase = ioremap(res->start, res->end - res->start + 1);
+	if (ide_dev->regbase == 0) {
+		dev_err(&pdev->dev, "could not remap i/o address\n");
+		ret = -ENOMEM;
+		goto release_mem;
+	}
+
+	ide_dev->ide_clk = clk_get(&pdev->dev, "cfcon");
+	if (IS_ERR(ide_dev->ide_clk)) {
+		dev_err(&pdev->dev, "failed to find clock source\n");
+		ret = PTR_ERR(ide_dev->ide_clk);
+		ide_dev->ide_clk = NULL;
+		goto unmap;
+	}
+
+	if (clk_enable(ide_dev->ide_clk)) {
+		dev_err(&pdev->dev, "failed to enable clock source.\n");
+		ret = -ENODEV;
+		goto clkerr;
+	}
+
+	setup_timing_value(ide_dev, clk_get_rate(ide_dev->ide_clk));
+	if (pdata && (pdata->setup_gpio))
+		pdata->setup_gpio();
+	init_ide_device(ide_dev);
+
+	ide_writel(ide_dev, 0x1f, S3C_ATA_IRQ);
+	ide_writel(ide_dev, 0x1b, S3C_ATA_IRQ_MSK);
+
+	memset(&hw, 0, sizeof(hw));
+	ide_setup_ports(&hw, ide_dev);
+	hw.irq = ide_dev->irq;
+	hw.dev = &pdev->dev;
+
+	host = ide_host_alloc(&s3c_port_info, hws, 1);
+	if (!host) {
+		dev_err(&pdev->dev, "failed to allocate ide host\n");
+		ret = -ENOMEM;
+		goto stop_clk;
+	}
+
+	host->irq_handler = s3c_irq_handler;
+	host->ports[0]->hwif_data = (void *)ide_dev;
+	ide_dev->hwif = host->ports[0];
+	platform_set_drvdata(pdev, host);
+
+	ret = ide_host_register(host, &s3c_port_info, hws);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ide host\n");
+		goto dealloc_ide_host;
+	}
+
+	return 0;
+
+dealloc_ide_host:
+	ide_host_free(host);
+stop_clk:
+	clk_disable(ide_dev->ide_clk);
+clkerr:
+	clk_put(ide_dev->ide_clk);
+unmap:
+	iounmap(ide_dev->regbase);
+release_mem:
+	release_mem_region(res->start, res->end - res->start + 1);
+release_device_mem:
+	kfree(ide_dev);
+	return ret;
+}
+
+static int __devexit s3c_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+	struct resource *res;
+	struct s3c_ide_device *ide_dev = host->ports[0]->hwif_data;
+
+	ide_host_remove(host);
+	iounmap(ide_dev->regbase);
+	clk_disable(ide_dev->ide_clk);
+	clk_put(ide_dev->ide_clk);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+	kfree(ide_dev);
+	return 0;
+}
+
+static struct platform_driver s3c_ide_driver = {
+	.probe		= s3c_ide_probe,
+	.remove		= __devexit_p(s3c_ide_remove),
+	.driver = {
+		.name	= "s3c-ide",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init s3c_ide_init(void)
+{
+	return platform_driver_register(&s3c_ide_driver);
+}
+
+static void __exit s3c_ide_exit(void)
+{
+	platform_driver_unregister(&s3c_ide_driver);
+}
+
+module_init(s3c_ide_init);
+module_exit(s3c_ide_exit);
+
+MODULE_DESCRIPTION("Samsung S3C IDE Controller Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:s3c-cfcon");
diff --git a/include/linux/ide.h b/include/linux/ide.h
index edc93a6..ff9eb0e 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -164,7 +164,7 @@ enum {		ide_unknown,	ide_generic,	ide_pci,
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_4drives,	ide_pmac,	ide_acorn,
-		ide_au1xxx,	ide_palm3710
+		ide_au1xxx,	ide_palm3710,	ide_s3c
 };

 typedef u8 hwif_chipset_t;
-- 
1.5.3.4
