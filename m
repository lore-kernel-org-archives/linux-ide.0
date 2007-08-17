From: Vladislav Buzov <vbuzov@ru.mvista.com>
Subject: [RFC] Sandisk DOC H3 Linux driver
Date: Fri, 17 Aug 2007 20:25:57 +0400
Message-ID: <20070817162557.GA6819@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [212.176.242.38] ([212.176.242.38]:53476 "EHLO
	dolphin.spb.rtsoft.ru" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752964AbXHQQue (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2007 12:50:34 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-mtd@lists.infradead.org

Hello folks,

I'm currently working on Linux port for a board with the Sandsik DOC H3
Embedded flash device installed. This is a new generation of DOC devices
oriented to the open source products. The H3 is significantly different
from previous DOC generations since it completely implements MTD layer
(NAND driver + TrueFFS proprietary driver) inside of the chip, and
provides ATA-like interface to the external CPU. While old DOC chips are
true MTD devices requiring proprietary TrueFFS driver running on a host
operating system.

I've surfed the net trying to find some community attempts to enable the
DOC H3 in Linux kernel but didn't have a luck. So, first of all I'm
wondering if somebody knows if there are community activities in this
direction. I'm sending this email to the both linux-mtd and linux-ide
lists because of a dual nature of the DOC H3.

I've been investigating this matter for a couple weeks and now I do see
why it might be difficult to implement the DOC H3 Linux driver. Sandisk
does not provide any comprehensive DOC H3 documentation freely. The one
I've found myself does not have much details:

http://www.m-sys.com/NR/rdonlyres/C7C40791-65D7-4807-B857-E0E8D28E8EAE/0/DOC_H3_DS_Rev01.pdf|DOC_H3_DS_Rev.0.1.pdf

Instead of documentation, Sandisk equips its customers with GPL licensed
DOC H3 SDK. It is a multi-tier complex software stack mostly intended to
provide the same interface to legacy applications working on the top of
the proprietary TrueFFS driver for previous DOC generations. This SDK is
self-sufficient, easily portable to various platforms (Windows, VxWorks,
etc.). Thus, it is absolutely impossible to integrate this SDK into
Linux kernel.

After further analysis I found out that the lack of documentation is not
the only problem. As mentioned above the DOC H3 provides an ATA-like
interface implemented with deviation of ATA standards. From one side, It
responds to standard ATA commands like ATA IDENTIFY, implements the same
ATA ports to operate with device, etc. But from other side it has some
specific features. Couple of them are listed below:

- The device requires low-level formatting via vendor-specific ATA
commands. It may be split to several (up to 15) partitions each of them
is represented as a separate "disk". So, detection, reading and writing
a "disk" are to be done via vendor specific commands only.

- The DOC H3 ATA ports are 16-bit (unlike standard 8-bit ATA ones) Also,
  documentation above says that it is a little-endian device and recommends to
swap byte lanes to connect it to big-endian CPUs. So, ATA registers may be big
endian.

I've tried to implement simple Linux driver (the patch is embedded
below) to make it possible to use the DOC H3 as ATA disk (or set of
disks). I decided to use an obsolete Linux ATA infrastructure
(drivers/ide) instead of new libata one since the old one seems to be
more flexible to accommodate the DOC H3 specific features above. I was
trying to avoid hacking a generic code but had to introduce some
modifications anyway.

I understand that this driver is not acceptable since I have hacked generic
code like ide.c or ide-disk.c. Also I understand that DOC H3 support in the
kernel might need libata-based driver. It doesn't seem straightforward to me
how to make it. So, I'm looking for comments, advise and recommendations on
how to re-implement the driver in a proper way.

The DOC H3 device is being seen more often in embedded systems and we
would like to see it supported in mainline. Even if this current
driver is completely unacceptable for upstream inclusion, I would like
to use it as a starting point for discussions and would like to
work with others who may already be writing a driver to reduce
duplicated effort.

Thanks,
Vlad.

---

 drivers/ide/Kconfig           |    5 
 drivers/ide/Makefile          |    2 
 drivers/ide/doch_h3/doch_h3.c |  375 ++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/doch_h3/doch_h3.h |   96 ++++++++++
 drivers/ide/ide-disk.c        |   23 ++
 drivers/ide/ide-probe.c       |   11 +
 include/linux/doch_ata.h      |   84 +++++++++
 include/linux/ide.h           |    4 
 8 files changed, 600 insertions(+)

diff -pruN linux.orig/drivers/ide/Kconfig linux/drivers/ide/Kconfig
--- linux.orig/drivers/ide/Kconfig	2007-07-31 15:32:43.000000000 +0400
+++ linux/drivers/ide/Kconfig		2007-07-31 15:48:07.000000000 +0400
@@ -903,6 +903,11 @@ config BLK_DEV_MPC8xx_IDE
 
 	  If unsure, say N.
 
+config BLK_DEV_DOC_H3
+	bool "Sandisk DOC H3 support"
+	help
+	  This option provides support for the Sandisk DiskOnChip H3 embedded flash.
+
 choice
 	prompt "Type of MPC8xx IDE interface"
 	depends on BLK_DEV_MPC8xx_IDE
diff -pruN linux.orig/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux.orig/drivers/ide/Makefile	2007-07-31 15:32:42.000000000 +0400
+++ linux/drivers/ide/Makefile		2007-07-31 15:44:26.000000000 +0400
@@ -42,6 +42,8 @@ ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= p
 # built-in only drivers from h8300/
 ide-core-$(CONFIG_H8300)		+= h8300/ide-h8300.o
 
+ide-core-$(CONFIG_BLK_DEV_DOC_H3)	+= doch_h3/doch_h3.o
+
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 
diff -pruN linux.orig/drivers/ide/doch_h3/doch_h3.c linux/drivers/ide/doch_h3/doch_h3.c
--- linux.orig/drivers/ide/doch_h3/doch_h3.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/ide/doch_h3/doch_h3.c		2007-07-31 18:56:27.000000000 +0400
@@ -0,0 +1,375 @@
+/*
+ * ATA driver for Sandisk DOC H3 Embedded Flash Device
+ *
+ * Author: Vladislav Buzov <vbuzov@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+#include "doch_h3.h"
+
+/* #define DEBUG */
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...) printk(fmt, ## args)
+#else
+#define DPRINTK(fmt, args...) do { } while(0)
+#endif
+	
+
+static struct doch_device doch;
+
+/********************************************************
+ *		DOC H3 ATA stuff			*
+ ********************************************************/
+
+static void
+doch_ata_selectproc(ide_drive_t *drive)
+{
+	/*
+	 * All "drvies" are located on a single DOCH ATA device.
+	 * Ugly hack: always clear device select number bit.
+	 */
+
+	drive->select.all &= ~0x10;
+}	
+
+/*Find available HW interface */
+static ide_hwif_t *doch_find_hwif (void)
+{
+	int index;
+	ide_hwif_t *hwif;
+
+	for (index = 0; index < MAX_HWIFS; ++index) {
+		hwif = &ide_hwifs[index];
+		if (!hwif->io_ports[IDE_DATA_OFFSET])
+		return hwif;
+	}
+
+	return NULL;
+}
+
+/* Register DOC in IDE core */
+static void __init doch_ata_init(void) 
+{
+	ide_hwif_t *hwif;
+	unsigned long port = doch.ata_regs;
+	int i;
+	
+	hwif = doch_find_hwif();
+	if (!hwif)
+		return;
+
+	
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET;
+	     i++, port += 2)
+		hwif->hw.io_ports[i] = port;
+
+	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = doch.ata_regs + DOCH_ATA_CONTROL;
+
+	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->hw.io_ports));
+
+	/* Set up IO operations */
+	default_hwif_mmiops(hwif);
+
+	/* DOC H3 may have 15 "disks" */
+	hwif->selectproc = doch_ata_selectproc;
+
+	hwif->hw.irq = hwif->irq = doch.irq;
+	hwif->hw.chipset = ide_generic;
+	hwif->hw.dma = NO_DMA;
+	hwif->noprobe = 0;
+
+	doch.hwif = hwif;
+}
+
+/* Register DOC H3 in ide core */
+static void __init doch_ata_probe(void)
+{
+	if (doch.hwif)
+		probe_hwif_init(doch.hwif);
+}
+
+
+/********************************************************
+ *		DOC H3 specific routines 		*
+ ********************************************************/
+
+/*
+ * Wait untill device is ready.
+ */
+static int
+doch_wait_ready(unsigned long timeout, unsigned long good, unsigned long bad)
+{
+	unsigned long jiffies_f;
+	unsigned char stat;
+	
+	jiffies_f = jiffies + timeout;
+	do {
+		if (time_after(jiffies, timeout)) {
+			printk("Device is not ready\n");
+			return 0;
+		}
+		msleep(50); /* give drive a breather */
+		stat = doch.hwif->INB(doch.ata_regs + DOCH_ATA_STATUS);
+	} while (!OK_STAT(stat, good, bad));
+
+	return 1;
+}
+
+/*
+ * Get infromation about DOC H3 device. It mostly need here to
+ * get the number of available TrueFFS partitions to use as
+ * separate disks.
+ */
+static int doch_get_device_info(void)
+{
+	unsigned char *device_info;
+	unsigned short part_num;
+
+	device_info = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+	if (device_info == NULL) {
+		printk(KERN_ERR "Not enough memory memory\n");
+		return -ENOMEM;
+	}
+	
+	doch.hwif->OUTB(DOCH_IDENTIFY_DISKONCHIP_DEVICE,
+			doch.ata_regs + DOCH_ATA_FEATURE);
+
+	doch.hwif->OUTB(DOCH_EXT_DEVICE_CTRL,
+			doch.ata_regs + DOCH_ATA_COMMAND);
+	
+	if (!doch_wait_ready(WAIT_WORSTCASE, DATA_READY, BAD_R_STAT)) {
+		printk("Can't retierve device informatiion\n");
+		return -ENODEV;
+	}
+		
+	doch.hwif->INSW(doch.ata_regs + DOCH_ATA_DATA, device_info,
+			SECTOR_SIZE);
+
+	if (!doch_wait_ready(WAIT_READY, READY_STAT, BUSY_STAT)) {
+		printk("DOCH device is not ready\n");
+		return -EBUSY;
+	}
+
+	/*
+	 * Get Partition size in sectors
+ 	 * FIXME: Add partition info structure definition 
+	 */
+	device_info += 124;
+	
+	part_num = *(unsigned short *)device_info;
+	part_num = __le16_to_cpu(part_num);
+
+	DPRINTK("Found DOC device with %d paritions\n", part_num);
+
+	/* The first two partition are not for generl-purpose use */
+	doch.disk_number = (part_num > 2 ? part_num - 2 : 0);
+
+	/*FIXME: It leads to kernel crash */
+	//kfree(device_info);
+
+	return 0;
+}
+
+/*
+ * Get information about particular partion.
+ */
+static int doch_get_disk_info(int disk_num)
+{
+	unsigned char *part_info;
+	unsigned long part_size;
+
+	part_info = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+	if (part_info == NULL) {
+		printk(KERN_ERR "Not enough memory memory\n");
+		return -ENOMEM;
+	}
+		
+	/* Get partition information */
+	doch.hwif->OUTB(disk_num + 2, doch.ata_regs + DOCH_ATA_NSECTOR);
+
+	doch.hwif->OUTB(DOCH_GET_PARTITION_INFO, 
+			doch.ata_regs + DOCH_ATA_FEATURE);
+	
+	doch.hwif->OUTB(DOCH_PARTITION_MANAGEMENT,
+			doch.ata_regs + DOCH_ATA_COMMAND);
+
+	if (!doch_wait_ready(WAIT_WORSTCASE, DATA_READY, BAD_R_STAT)) {
+		printk("Can't retierve device informatiion\n");
+		return -ENODEV;
+	}
+		
+	doch.hwif->INSW(doch.ata_regs + DOCH_ATA_DATA, part_info,
+			SECTOR_SIZE);
+
+	if (!doch_wait_ready(WAIT_READY, READY_STAT, BUSY_STAT)) {
+		printk("DOCH device is not ready\n");
+		return -EBUSY;
+	}
+	
+	/* Get Partition size in sectors
+	 * FIXME: Add partition info structure definition 
+	 */
+	part_info += 16;
+	
+	part_size = *(unsigned long *)part_info;
+	part_size = __le32_to_cpu(part_size);
+	
+	doch.disks[disk_num].part_num = disk_num + 2;
+	doch.disks[disk_num].disk_size = part_size;
+
+	DPRINTK("Found disk: size = %d\n", part_size);
+
+	/* FIXME: It leads to kernel crash */
+	//kfree(part_info);
+
+	return 0;
+}
+
+/********************************************************
+ *		DOC H3 initialization	 		*
+ ********************************************************/
+/*
+ * Fix drive and hd_driveid structures for each "disk" (DOC partition)
+ * to set up a correct size and remove some unsupported features.
+ */
+int doch_fix_driveid(ide_drive_t *drive, struct hd_driveid *id)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int drive_num;
+
+	drive_num = drive - hwif->drives;
+	if (drive_num >= doch.disk_number)
+		return -ENODEV;
+
+	id->lba_capacity = doch.disks[drive_num].disk_size;
+		
+	drive->special.b.recalibrate = 0;
+	drive->special.b.set_geometry = 0;
+
+	return 0;
+}
+
+
+/* Probe for DOC device and its partitons */
+static int __init doch_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct doch_platform *doch_platform = pdev->dev.platform_data;
+	struct resource *res = NULL;
+	unsigned int size;
+	int ret = 0;
+	int num;
+	
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) 
+		return -ENODEV;
+	
+	doch.base_phys = res->start;
+	
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res)
+		return -ENODEV;
+
+	doch.irq = res->start;
+
+	/* TODO: Add automatic probing for memory window size */
+	if (doch_platform->window_128kb)
+		size = 0x20000;
+	else
+		size = 0x2000;
+	
+	doch.base = (unsigned long)ioremap(doch.base_phys, size);
+	if (!doch.base) {
+		printk("Unable to remap DOC H3 8Kb memory\n");
+		return -ENOMEM;
+	}
+
+	if (doch_platform->window_128kb) {
+		doch.ata_regs = doch.base + DOCH_ATA_REGS_OFFSET_128KB;
+		doch.ata_data = doch.base + DOCH_ATA_DATA_OFFSET_128KB;
+		doch.conf_regs = doch.base + DOCH_CONF_REGS_OFFSET_128KB;
+	} else {
+		doch.ata_regs = doch.base + DOCH_ATA_REGS_OFFSET_8KB;
+		doch.ata_data = doch.base + DOCH_ATA_DATA_OFFSET_8KB;
+		doch.conf_regs = doch.base + DOCH_CONF_REGS_OFFSET_8KB;
+	}
+	
+	DPRINTK("Mapped DOC H3 %dKb 0x%x -> 0x%x\n",
+		(size >> 10), doch.base_phys, doch.base);
+
+	if (doch_platform->byte_lane_swapping)
+		/* Swap the byte lanes */
+		doch_cfg_write(doch, DOCH_ENDIAN_CTRL, 0x0101); 
+	
+	/* Init doch.hwif structure */
+	doch_ata_init();
+
+	/* Try to identify DOC device */
+	ret = doch_get_device_info();
+	if (ret)
+		return ret;
+	
+	if (doch.disk_number == 0) {
+		printk("Device does not seem to be formatted\n");
+		return -ENODEV;
+	}
+
+	for (num = 0; num < doch.disk_number; num++) {
+		ret = doch_get_disk_info(num);
+		if (ret)
+			return ret;
+	}
+
+	doch_ata_probe();
+	
+	return ret;
+}
+
+static int __exit doch_remove(struct device *dev)
+{
+	ide_unregister(ide_hwifs - doch.hwif);
+	iounmap((void __iomem *)doch.base);
+	
+	return 0;
+}
+
+static struct device_driver doch_driver = {
+	.name	= "doc_h3",
+	.bus	= &platform_bus_type,
+	.probe	= doch_probe,
+	.remove	= __devexit_p(doch_remove),
+};
+
+static int __init doch_init(void)
+{
+	printk("Sandisk DOC H3 embedded flash driver\n");
+	return driver_register(&doch_driver);
+}
+
+static void __exit doch_exit(void)
+{
+	driver_unregister(&doch_driver);
+}
+
+module_init(doch_init);
+module_exit(doch_exit);
+
diff -pruN linux.orig/drivers/ide/doch_h3/doch_h3.h linux/drivers/ide/doch_h3/doch_h3.h
--- linux.orig/drivers/ide/doch_h3/doch_h3.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/ide/doch_h3/doch_h3.h		2007-07-31 18:34:54.000000000 +0400
@@ -0,0 +1,96 @@
+/*
+ * ATA driver for Sandisk DOC H3 Embedded Flash Device
+ *
+ * Author: Vladislav Buzov <vbuzov@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _DRIVERS_DOC_H3_H
+#define _DRIVERS_DOC_H3_H
+
+#include <linux/doch_ata.h>
+#include <asm/irq.h>
+
+
+/* TODO: Add support for various platforms */
+
+#define DOCH_SWAP_BYTE_LANES
+
+/*
+ * DOCH registers offsets
+ */
+#define DOCH_ATA_REGS_OFFSET_8KB	0x0800
+#define DOCH_ATA_DATA_OFFSET_8KB	0x1000
+#define DOCH_CONF_REGS_OFFSET_8KB	0x1400
+
+#define DOCH_ATA_REGS_OFFSET_128KB	0x0
+#define DOCH_ATA_DATA_OFFSET_128KB	0x0800
+#define DOCH_CONF_REGS_OFFSET_128KB	0x1400
+
+/*
+ * DOC configuration registerrs offsets.
+ * Relative to DOCH_CONF_REG_OFFSET.
+ */
+
+#define DOCH_CHIP_ID1		0x00
+#define DOCH_CHIP_ID2		0x22
+#define DOCH_BURST_MODE_CTRL	0x02
+#define DOCH_BURST_MODE_EXIT	0x04
+#define DOCH_DONWLOAD_CONTROL	0x06
+#define DOCH_IPL_CONTROL	0x08
+#define DCOH_WARM_BOOT		0x0a
+#define DOCH_POWER_DOWN		0x0c
+#define DOCH_DMA_CTRL		0x0e
+#define DOCH_DMA_NEGATION	0x18
+#define DOCH_SW_LOCK		0x10
+#define DOCH_ENDIAN_CTRL	0x12
+#define DOCH_POWER_MODE		0x16
+#define DOCH_VERSION_REG	0x1a
+
+/* Represent on DOCH partition */
+struct doch_disk {
+	/* TrueFFS partiton number.
+	 * Required for reading/writing sectors to disk
+	 */
+	unsigned int part_num;
+	
+	/* Disk capacity in sectors */
+	unsigned int hw_sector_size;
+	unsigned int disk_size;
+};
+
+typedef struct doch_disk doch_disk_t;
+
+struct doch_device {
+	/* Respective hwif structure */
+	ide_hwif_t *hwif;
+	
+	unsigned long base_phys;
+	unsigned long base;
+	unsigned long ata_regs;
+	unsigned long ata_data;
+	unsigned long conf_regs;
+
+	int irq;
+	
+	unsigned int disk_number;
+	doch_disk_t disks[MAX_DRIVES];
+};
+
+/* DOCH configuration registers access routines */
+static inline void
+doch_cfg_write(struct doch_device doch, u8 reg, u16 val)
+{
+	*(volatile u16 *)(doch.conf_regs + reg) = val;
+}
+
+static inline u16
+doch_cfg_read(struct doch_device doch, u8 reg)
+{
+	*(volatile u16 *)(doch.conf_regs + reg);
+}
+
+#endif /* _DRIVERS_DOC_H3_H */
diff -pruN linux.orig/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux.orig/drivers/ide/ide-disk.c	2007-07-31 15:34:01.000000000 +0400
+++ linux/drivers/ide/ide-disk.c	2007-08-17 18:25:06.000000000 +0400
@@ -71,6 +71,11 @@
 #include <asm/io.h>
 #include <asm/div64.h>
 
+#ifdef CONFIG_BLK_DEV_DOC_H3
+#include <linux/doch_ata.h>
+#endif
+
+
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -233,6 +238,11 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		ide_init_sg_cmd(drive, rq);
 	}
 
+#ifdef CONFIG_BLK_DEV_DOC_H3
+	/* Set up partition number */
+	hwif->OUTB((drive - hwif->drives) + 2, IDE_FEATURE_REG);
+#endif
+
 	if (rq_data_dir(rq) == READ) {
 
 		if (drive->mult_count) {
@@ -243,6 +253,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			command = lba48 ? WIN_READ_EXT : WIN_READ;
 		}
 
+#ifdef CONFIG_BLK_DEV_DOC_H3
+		/*Read Partiton*/
+		command = DOCH_READ_PARTITION;
+#endif
 		ide_execute_command(drive, command, &task_in_intr, WAIT_CMD, NULL);
 		return ide_started;
 	} else {
@@ -254,6 +268,10 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
 
+#ifdef CONFIG_BLK_DEV_DOC_H3
+		/*Write Partiton*/
+		command = DOCH_WRITE_PARTITION;
+#endif
 		/* FIXME: ->OUTBSYNC ? */
 		hwif->OUTB(command, IDE_COMMAND_REG);
 
@@ -744,7 +762,12 @@ static ide_startstop_t idedisk_special (
 			ide_task_t args;
 			memset(&args, 0, sizeof(ide_task_t));
 			args.tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
+#ifdef CONFIG_BLK_DEV_DOC_H3
+			args.tfRegister[IDE_FEATURE_OFFSET] = DOCH_SET_DATA_XFER_MODE;
+			args.tfRegister[IDE_COMMAND_OFFSET] = DOCH_EXT_DEVICE_CTRL;
+#else
 			args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
+#endif
 			args.command_type = IDE_DRIVE_TASK_NO_DATA;
 			args.handler	  = &set_multmode_intr;
 			do_rw_taskfile(drive, &args);
diff -pruN linux.orig/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux.orig/drivers/ide/ide-probe.c	2007-07-31 15:34:01.000000000 +0400
+++ linux/drivers/ide/ide-probe.c	2007-07-31 15:44:26.000000000 +0400
@@ -56,6 +56,10 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_BLKD_DEV_DOC_H3
+#include "doch_h3/doch_h3.h"
+#endif
+
 /**
  *	generic_id		-	add a generic drive id
  *	@drive:	drive to make an ID block for
@@ -147,7 +151,14 @@ static inline void do_identify (ide_driv
 
 	drive->id_read = 1;
 	local_irq_enable();
+
+#ifdef CONFIG_BLK_DEV_DOC_H3
+	/*TODO: Add chek if it is DOC */
+	if(doch_fix_driveid(drive, id))
+		goto err_misc;
+#else
 	ide_fix_driveid(id);
+#endif
 
 #if defined (CONFIG_SCSI_EATA_DMA) || defined (CONFIG_SCSI_EATA_PIO) || defined (CONFIG_SCSI_EATA)
 	/*
diff -pruN linux.orig/include/linux/doch_ata.h linux/include/linux/doch_ata.h
--- linux.orig/include/linux/doch_ata.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/doch_ata.h	2007-07-31 18:48:31.000000000 +0400
@@ -0,0 +1,84 @@
+/*
+ * Sandisk DOC H3 Embedded Flash Device
+ *
+ * Author: Vladislav Buzov <vbuzov@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _LINUX_DOCH_ATA_H
+#define _LINUX_DOCH_ATA_H
+
+#include <linux/ide.h>
+
+/*
+ * DOC ATA registerrs offsets.
+ * Relative to DOCH_ATA_REG_OFFSET.
+ */
+#define DOCH_ATA_DATA		0x00
+#define DOCH_ATA_ERROR		0x02
+#define DOCH_ATA_NSECTOR	0x04
+#define DOCH_ATA_SECTOR		0x06
+#define DOCH_ATA_LCYL		0x08
+#define DOCH_ATA_HCYL		0x0A
+#define DOCH_ATA_SELECT		0x0C
+#define DOCH_ATA_STATUS		0x0E
+#define DOCH_ATA_CONTROL	0x1C
+
+#define DOCH_ATA_FEATURE	DOCH_ATA_ERROR
+#define DOCH_ATA_COMMAND	DOCH_ATA_STATUS
+
+/*
+ * Various DOC vendor ATA commands and subcommands
+ */
+#define DOCH_READ_PARTITION		0x82
+#define DOCH_WRITE_PARTITION		0x83
+#define DOCH_PARTITION_MANAGEMENT	0xfa
+#define DOCH_EXT_DEVICE_CTRL		0xfc
+
+/* PARTITION MANAGEMENT SUBCOMMANDS */
+#define DOCH_GET_PARTITION_INFO		0x00
+#define DOCH_SET_DEFAULT_PARTITION	0x11
+#define DOCH_SET_PARTITION_PROTECTION	0x18
+#define DOCH_GET_PARTITION_USER_ATTR	0x70
+#define DOCH_SET_PARTITION_USER_ATTR	0x71
+#define DOCH_DELETE_PARTITIONS		0xB0
+#define DOCH_ADD_PARTITION		0xB4
+#define DOCH_SECURE_ERASE		0xB8
+
+/* EXT DEVICE CONTROL SUBCOMMANDS*/
+#define DOCH_IDENTIFY_DISKONCHIP_DEVICE	0x00
+#define DOCH_GET_EXTENDED_DEVICE_INFO	0x01
+#define DOCH_SET_DATA_XFER_MODE		0x10
+#define DOCH_ATOMIC_WRITE_SEQUENCE	0x20
+#define DOCH_OPTIMIZE_MEDIA		0x30
+#define DOCH_GET_CUSTOM_PARAM		0x40
+#define DOCH_SET_CUSTOM_PARAM		0x41
+#define DOCH_CALIBRATE_CLOCK		0x50
+#define DOCH_GET_POWER_MODE		0x60
+#define DOCH_SET_POWER_MODE		0x61
+#define DOCH_GET_DISK_USER_ATTR		0x70
+#define DOCH_SET_DISK_USER_ATTR		0x71
+#define DOCH_GET_CONFIGURATION_DATA	0x72
+#define DOCH_SET_CONFIGURATION_DATA	0x73
+#define DOCH_ACTIVATE_DEBUG_MODE	0x7c
+#define DOCH_RETRIEVE_DBG_MSG		0x7e
+#define DOCH_SET_ALERT_LEVEL		0x7f
+#define DOCH_GET_RESET_STATUS		0x80
+#define DOCH_NOTIFY_PLATFORM_RESUMED	0x8e
+#define DOCH_NOTIFY_RESET		0x8f
+
+struct doch_platform
+{
+	/* Indicates how the DOC is connected to the external bus */
+	unsigned int byte_lane_swapping;
+
+	/* Is the DOC has 128KB memory mapped window? */
+	unsigned char window_128kb;
+};
+
+extern int doch_fix_driveid(ide_drive_t *drive, struct hd_driveid *id);
+
+#endif /* _LINUX_DOCH_ATA_H */
diff -pruN linux.orig/include/linux/ide.h linux/include/linux/ide.h
--- linux.orig/include/linux/ide.h	2007-07-31 15:35:34.000000000 +0400
+++ linux/include/linux/ide.h		2007-07-31 15:44:26.000000000 +0400
@@ -179,7 +179,11 @@ typedef unsigned char	byte;	/* used ever
  * Some more useful definitions
  */
 #define PARTN_BITS	6	/* number of minor dev bits for partitions */
+#ifdef CONFIG_BLK_DEV_DOC_H3
+#define MAX_DRIVES	15
+#else
 #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
+#endif
 #define SECTOR_SIZE	512
 #define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
 #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
