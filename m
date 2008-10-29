From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] include old-style rb532 CompactFlash support
Date: Wed, 29 Oct 2008 19:19:19 +0100
Message-ID: <1225304359-11290-1-git-send-email-n0-1@freewrt.org>
References: <20081027205124.GB27227@nuty>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:59051 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYJ2STZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 14:19:25 -0400
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id E45663891A92
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 19:19:21 +0100 (CET)
In-Reply-To: <20081027205124.GB27227@nuty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I copied the driver from the OpenWrt project to FreeWRT at Thu, 16 Nov
2006 and since then maintain it. As the current kernel for rb532 in
FreeWRT is 2.6.19.1, intense testing has only been done basing on the
local patches for the board support. After porting it to the linux-mips
git tree, I could verify the functionality by mounting an ext2
filesystem on the disk and reading/writing files in it.

The changes to gpio.c are rather a dirty hack - the existing code for
gpiolib is so broken, I could not find a way to use the set/get
functions to cleanly access any register other than GPIOD. This issue
has to be addressed separately, so do it this way and at least don't
break existing code.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c       |   39 ++++
 drivers/block/Kconfig        |    8 +
 drivers/block/Makefile       |    2 +
 drivers/block/rb532/Makefile |    3 +
 drivers/block/rb532/ata.c    |  496 ++++++++++++++++++++++++++++++++++++++++++
 drivers/block/rb532/ata.h    |  126 +++++++++++
 drivers/block/rb532/bdev.c   |  302 +++++++++++++++++++++++++
 7 files changed, 976 insertions(+), 0 deletions(-)
 create mode 100644 drivers/block/rb532/Makefile
 create mode 100644 drivers/block/rb532/ata.c
 create mode 100644 drivers/block/rb532/ata.h
 create mode 100644 drivers/block/rb532/bdev.c

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 70c4a67..e2ba29f 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -287,6 +287,45 @@ static struct rb532_gpio_chip rb532_gpio_chip[] = {
 	},
 };
 
+static void rb532_do_gpio_set(int bit, unsigned gpio, void __iomem *addr)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = readl(addr);
+	if (bit)
+		val |= (1 << gpio);
+	else
+		val &= ~(1 << gpio);
+	writel(val, addr);
+	local_irq_restore(flags);
+}
+
+void  rb532_gpio_set_func(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase);
+}
+EXPORT_SYMBOL(rb532_gpio_set_func);
+
+void  rb532_gpio_set_cfg(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOCFG - GPIOBASE);
+}
+EXPORT_SYMBOL(rb532_gpio_set_cfg);
+
+void  rb532_gpio_set_ilevel(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOILEVEL - GPIOBASE);
+}
+EXPORT_SYMBOL(rb532_gpio_set_ilevel);
+
+void  rb532_gpio_set_istat(int bit, unsigned gpio)
+{
+	rb532_do_gpio_set(bit, gpio, rb532_gpio_chip->regbase + GPIOISTAT - GPIOBASE);
+}
+EXPORT_SYMBOL(rb532_gpio_set_istat);
+
 int __init rb532_gpio_init(void)
 {
 	struct resource *r;
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 61ad8d6..20177cf 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -445,4 +445,12 @@ config BLK_DEV_HD
 
 	  If unsure, say N.
 
+config BLK_DEV_CF_MIPS
+	bool "CF slot of RB532 board"
+	depends on MIKROTIK_RB532
+	default y
+	help
+	  The Routerboard 532 has a CF slot on it. Enable the special block
+	  device driver for it.
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 204332b..29e927c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -32,3 +32,5 @@ obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
 
 obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= xen-blkfront.o
+
+obj-$(CONFIG_BLK_DEV_CF_MIPS)	+= rb532/
diff --git a/drivers/block/rb532/Makefile b/drivers/block/rb532/Makefile
new file mode 100644
index 0000000..3e14dc3
--- /dev/null
+++ b/drivers/block/rb532/Makefile
@@ -0,0 +1,3 @@
+## Makefile for the RB532 CF port
+
+obj-y		+= bdev.o ata.o
diff --git a/drivers/block/rb532/ata.c b/drivers/block/rb532/ata.c
new file mode 100644
index 0000000..0d71869
--- /dev/null
+++ b/drivers/block/rb532/ata.c
@@ -0,0 +1,496 @@
+#include <linux/kernel.h>	/* printk() */
+#include <linux/module.h>	/* module to be loadable */
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>	/* request_mem_region() */
+#include <asm/unaligned.h>	/* ioremap() */
+#include <asm/io.h>		/* ioremap() */
+#include <asm/mach-rc32434/rb.h>
+#include <asm/mach-rc32434/gpio.h>
+
+#include "ata.h"
+
+#define REQUEST_MEM_REGION 0
+#define DEBUG 1
+
+#if DEBUG
+#define DEBUGP printk
+#else
+#define DEBUGP(format, args...)
+#endif
+
+#define SECS	1000000		/* unit for wait_not_busy() is 1us */
+
+/*
+unsigned cf_head = 0;
+unsigned cf_cyl = 0;
+unsigned cf_spt = 0;
+unsigned cf_sectors = 0;
+*/
+
+extern void rb532_gpio_set_func(int bit, unsigned gpio);
+extern void  rb532_gpio_set_cfg(int bit, unsigned gpio);
+extern void  rb532_gpio_set_ilevel(int bit, unsigned gpio);
+extern void  rb532_gpio_set_istat(int bit, unsigned gpio);
+
+#define DBUF32 ((volatile u32 *)((unsigned long)dev->baddr | ATA_DBUF_OFFSET))
+
+
+static void cf_do_tasklet(unsigned long dev_l);
+
+
+static inline void wareg(u8 val, unsigned reg, struct cf_mips_dev *dev)
+{
+	writeb(val, dev->baddr + ATA_REG_OFFSET + reg);
+}
+
+static inline u8 rareg(unsigned reg, struct cf_mips_dev *dev)
+{
+	return readb(dev->baddr + ATA_REG_OFFSET + reg);
+}
+
+static inline int cfrdy(struct cf_mips_dev *dev)
+{
+	return gpio_get_value(dev->pin);
+}
+
+static inline void prepare_cf_irq(struct cf_mips_dev *dev)
+{
+	rb532_gpio_set_ilevel(1, dev->pin);	/* interrupt on cf ready (not busy) */
+	rb532_gpio_set_istat(0, dev->pin);	/* clear interrupt status */
+}
+
+static inline int cf_present(struct cf_mips_dev *dev)
+{
+	/* TODO: read and configure CIS into memory mapped mode
+	 * TODO:   parse CISTPL_CONFIG on CF+ cards to get base address (0x200)
+	 * TODO:   maybe adjust power saving setting for Hitachi Microdrive
+	 */
+	int i;
+
+	/* setup CFRDY GPIO as input */
+	rb532_gpio_set_func(0, dev->pin);
+	rb532_gpio_set_cfg(0, dev->pin);
+
+	for (i = 0; i < 0x10; ++i) {
+		if (rareg(i, dev) != 0xff)
+			return 1;
+	}
+	return 0;
+}
+
+static inline int is_busy(struct cf_mips_dev *dev)
+{
+	return !cfrdy(dev);
+}
+
+static int wait_not_busy(int to_us, int wait_for_busy,
+			 struct cf_mips_dev *dev)
+{
+	int us_passed = 0;
+	if (wait_for_busy && !is_busy(dev)) {
+		/* busy must appear within 400ns,
+		 * but it may dissapear before we see it
+		 *  => must not wait for busy in a loop
+		 */
+		ndelay(400);
+	}
+
+	do {
+		if (us_passed)
+			udelay(1);	/* never reached in async mode */
+		if (!is_busy(dev)) {
+			if (us_passed > 1 * SECS) {
+				printk(KERN_WARNING
+				       "cf-mips:   not busy ok (after %dus)"
+				       ", status 0x%02x\n", us_passed,
+				       (unsigned) rareg(ATA_REG_ST, dev));
+			}
+			return CF_TRANS_OK;
+		}
+		if (us_passed == 1 * SECS) {
+			printk(KERN_WARNING
+			       "cf-mips: wait not busy %dus..\n", to_us);
+		}
+		if (dev->async_mode) {
+			dev->to_timer.expires =
+			    jiffies + (to_us * HZ / SECS);
+			dev->irq_enable_time = jiffies;
+			prepare_cf_irq(dev);
+			if (is_busy(dev)) {
+				add_timer(&dev->to_timer);
+				enable_irq(dev->irq);
+				return CF_TRANS_IN_PROGRESS;
+			}
+			continue;
+		}
+		++us_passed;
+	} while (us_passed < to_us);
+
+	printk(KERN_ERR "cf-mips:  wait not busy timeout (%dus)"
+	       ", status 0x%02x, state %d\n",
+	       to_us, (unsigned) rareg(ATA_REG_ST, dev), dev->tstate);
+	return CF_TRANS_FAILED;
+}
+
+static irqreturn_t cf_irq_handler(int irq, void *dev_id)
+{
+	/* While tasklet has not disabled irq, irq will be retried all the time
+	 * because of ILEVEL matching GPIO pin status => deadlock.
+	 * To avoid this, we change ILEVEL to 0.
+	 */
+	struct cf_mips_dev *dev = dev_id;
+
+	rb532_gpio_set_ilevel(0, dev->pin);
+	rb532_gpio_set_istat(0, dev->pin);
+
+	del_timer(&dev->to_timer);
+	tasklet_schedule(&dev->tasklet);
+	return IRQ_HANDLED;
+}
+
+static int do_reset(struct cf_mips_dev *dev)
+{
+	printk(KERN_INFO "cf-mips: resetting..\n");
+
+	wareg(ATA_REG_DC_SRST, ATA_REG_DC, dev);
+	udelay(1);		/* FIXME: how long should we wait here? */
+	wareg(0, ATA_REG_DC, dev);
+
+	return wait_not_busy(30 * SECS, 1, dev);
+}
+
+static int set_multiple(struct cf_mips_dev *dev)
+{
+	if (dev->block_size <= 1)
+		return CF_TRANS_OK;
+
+	wareg(dev->block_size, ATA_REG_SC, dev);
+	wareg(ATA_REG_DH_BASE | ATA_REG_DH_LBA, ATA_REG_DH, dev);
+	wareg(ATA_CMD_SET_MULTIPLE, ATA_REG_CMD, dev);
+
+	return wait_not_busy(10 * SECS, 1, dev);
+}
+
+static int set_cmd(struct cf_mips_dev *dev)
+{
+	//DEBUGP(KERN_INFO "cf-mips: ata cmd 0x%02x\n", dev->tcmd);
+	// sector_count should be <=24 bits..
+	BUG_ON(dev->tsect_start >= 0x10000000);
+	// This way, it addresses 2^24 * 512 = 128G
+
+	if (dev->tsector_count) {
+		wareg(dev->tsector_count & 0xff, ATA_REG_SC, dev);
+		wareg(dev->tsect_start & 0xff, ATA_REG_SN, dev);
+		wareg((dev->tsect_start >> 8) & 0xff, ATA_REG_CL, dev);
+		wareg((dev->tsect_start >> 16) & 0xff, ATA_REG_CH, dev);
+	}
+	wareg(((dev->tsect_start >> 24) & 0x0f) | ATA_REG_DH_BASE | ATA_REG_DH_LBA, ATA_REG_DH, dev);	/* select drive on all commands */
+	wareg(dev->tcmd, ATA_REG_CMD, dev);
+	return wait_not_busy(10 * SECS, 1, dev);
+}
+
+static int do_trans(struct cf_mips_dev *dev)
+{
+	int res;
+	unsigned st;
+	int transfered;
+
+	//printk("do_trans: %d sectors left\n",dev->tsectors_left);
+	while (dev->tsectors_left) {
+		transfered = 0;
+
+		st = rareg(ATA_REG_ST, dev);
+		if (!(st & ATA_REG_ST_DRQ)) {
+			printk(KERN_ERR
+			       "cf-mips: do_trans without DRQ (status 0x%x)!\n",
+			       st);
+			if (st & ATA_REG_ST_ERR) {
+				int errId = rareg(ATA_REG_ERR, dev);
+				printk(KERN_ERR
+				       "cf-mips: %s error, status 0x%x, errid 0x%x\n",
+				       (dev->tread ? "read" : "write"), st,
+				       errId);
+			}
+			return CF_TRANS_FAILED;
+		}
+		do {		/* Fill/read the buffer one block */
+			u32 *qbuf, *qend;
+			qbuf = (u32 *) dev->tbuf;
+			qend = qbuf + CF_SECT_SIZE / sizeof(u32);
+			if (dev->tread) {
+				while (qbuf != qend)
+					put_unaligned(*DBUF32, qbuf++);
+				//*(qbuf++) = *DBUF32;
+			} else {
+				while (qbuf != qend)
+					*DBUF32 = get_unaligned(qbuf++);
+			}
+
+			dev->tsectors_left--;
+			dev->tbuf += CF_SECT_SIZE;
+			dev->tbuf_size -= CF_SECT_SIZE;
+			transfered++;
+		} while (transfered != dev->block_size
+			 && dev->tsectors_left > 0);
+
+		res = wait_not_busy(10 * SECS, 1, dev);
+		if (res != CF_TRANS_OK)
+			return res;
+	};
+
+	st = rareg(ATA_REG_ST, dev);
+	if (st & (ATA_REG_ST_DRQ | ATA_REG_ST_DWF | ATA_REG_ST_ERR)) {
+		if (st & ATA_REG_ST_DRQ) {
+			printk(KERN_ERR
+			       "cf-mips: DRQ after all %d sectors are %s"
+			       ", status 0x%x\n", dev->tsector_count,
+			       (dev->tread ? "read" : "written"), st);
+		} else if (st & ATA_REG_ST_DWF) {
+			printk(KERN_ERR
+			       "cf-mips: write fault, status 0x%x\n", st);
+		} else {
+			int errId = rareg(ATA_REG_ERR, dev);
+			printk(KERN_ERR
+			       "cf-mips: %s error, status 0x%x, errid 0x%x\n",
+			       (dev->tread ? "read" : "write"), st, errId);
+		}
+		return CF_TRANS_FAILED;
+	}
+	return CF_TRANS_OK;
+}
+
+static int cf_do_state(struct cf_mips_dev *dev)
+{
+	int res;
+	switch (dev->tstate) {	/* fall through everywhere */
+	case TS_IDLE:
+		dev->tstate = TS_READY;
+		if (is_busy(dev)) {
+			dev->tstate = TS_AFTER_RESET;
+			res = do_reset(dev);
+			if (res != CF_TRANS_OK)
+				break;
+		}
+	case TS_AFTER_RESET:
+		if (dev->tstate == TS_AFTER_RESET) {
+			dev->tstate = TS_READY;
+			res = set_multiple(dev);
+			if (res != CF_TRANS_OK)
+				break;
+		}
+	case TS_READY:
+		dev->tstate = TS_CMD;
+		res = set_cmd(dev);
+		if (res != CF_TRANS_OK)
+			break;;
+	case TS_CMD:
+		dev->tstate = TS_TRANS;
+	case TS_TRANS:
+		res = do_trans(dev);
+		break;
+	default:
+		printk(KERN_ERR "cf-mips: BUG: unknown tstate %d\n",
+		       dev->tstate);
+		return CF_TRANS_FAILED;
+	}
+	if (res != CF_TRANS_IN_PROGRESS)
+		dev->tstate = TS_IDLE;
+	return res;
+}
+
+static void cf_do_tasklet(unsigned long dev_l)
+{
+	struct cf_mips_dev *dev = (struct cf_mips_dev *) dev_l;
+	int res;
+
+	disable_irq(dev->irq);
+
+	if (dev->tstate == TS_IDLE)
+		return;		/* can happen when irq is first registered */
+
+#if 0
+	DEBUGP(KERN_WARNING
+	       "cf-mips:   not busy ok (tasklet)  status 0x%02x\n",
+	       (unsigned) rareg(ATA_REG_ST, dev));
+#endif
+
+	res = cf_do_state(dev);
+	if (res == CF_TRANS_IN_PROGRESS)
+		return;
+	cf_async_trans_done(dev, res);
+}
+
+static void cf_async_timeout(unsigned long dev_l)
+{
+	struct cf_mips_dev *dev = (struct cf_mips_dev *) dev_l;
+	disable_irq(dev->irq);
+	/* Perhaps send abort to the device? */
+	printk(KERN_ERR "cf-mips:  wait not busy timeout (%lus)"
+	       ", status 0x%02x, state %d\n",
+	       jiffies - dev->irq_enable_time, (unsigned) rareg(ATA_REG_ST,
+								dev),
+	       dev->tstate);
+	dev->tstate = TS_IDLE;
+	cf_async_trans_done(dev, CF_TRANS_FAILED);
+}
+
+int cf_do_transfer(struct cf_mips_dev *dev, sector_t sector,
+		   unsigned long nsect, char *buffer, int is_write)
+{
+	BUG_ON(dev->tstate != TS_IDLE);
+	if (nsect > ATA_MAX_SECT_PER_CMD) {
+		printk(KERN_WARNING
+		       "cf-mips: sector count %lu out of range\n", nsect);
+		return CF_TRANS_FAILED;
+	}
+	if (sector + nsect > dev->sectors) {
+		printk(KERN_WARNING "cf-mips: sector %lu out of range\n",
+		       sector);
+		return CF_TRANS_FAILED;
+	}
+	dev->tbuf = buffer;
+	dev->tbuf_size = nsect * 512;
+	dev->tsect_start = sector;
+	dev->tsector_count = nsect;
+	dev->tsectors_left = dev->tsector_count;
+	dev->tread = (is_write) ? 0 : 1;
+
+	dev->tcmd = (dev->block_size == 1 ?
+		     (is_write ? ATA_CMD_WRITE_SECTORS :
+		      ATA_CMD_READ_SECTORS) : (is_write ?
+					       ATA_CMD_WRITE_MULTIPLE :
+					       ATA_CMD_READ_MULTIPLE));
+
+	return cf_do_state(dev);
+}
+
+static int do_identify(struct cf_mips_dev *dev)
+{
+	u16 sbuf[CF_SECT_SIZE >> 1];
+	int res;
+	char tstr[17];		//serial
+	BUG_ON(dev->tstate != TS_IDLE);
+	dev->tbuf = (char *) sbuf;
+	dev->tbuf_size = CF_SECT_SIZE;
+	dev->tsect_start = 0;
+	dev->tsector_count = 0;
+	dev->tsectors_left = 1;
+	dev->tread = 1;
+	dev->tcmd = ATA_CMD_IDENTIFY_DRIVE;
+
+	DEBUGP(KERN_INFO "cf-mips: identify drive..\n");
+	res = cf_do_state(dev);
+	if (res == CF_TRANS_IN_PROGRESS) {
+		printk(KERN_ERR "cf-mips: BUG: async identify cmd\n");
+		return CF_TRANS_FAILED;
+	}
+	if (res != CF_TRANS_OK)
+		return 0;
+
+	dev->head = sbuf[3];
+	dev->cyl = sbuf[1];
+	dev->spt = sbuf[6];
+	dev->sectors = ((unsigned long) sbuf[7] << 16) | sbuf[8];
+	dev->dtype = sbuf[0];
+	memcpy(tstr, &sbuf[12], 16);
+	tstr[16] = 0;
+	printk(KERN_INFO
+	       "cf-mips: %s detected, C/H/S=%d/%d/%d sectors=%u (%uMB) Serial=%s\n",
+	       (sbuf[0] == 0x848A ? "CF card" : "ATA drive"), dev->cyl,
+	       dev->head, dev->spt, dev->sectors, dev->sectors >> 11,
+	       tstr);
+	return 1;
+}
+
+static void init_multiple(struct cf_mips_dev *dev)
+{
+	int res;
+	DEBUGP(KERN_INFO "cf-mips: detecting block size\n");
+
+	dev->block_size = 128;	/* max block size = 128 sectors (64KB) */
+	do {
+		wareg(dev->block_size, ATA_REG_SC, dev);
+		wareg(ATA_REG_DH_BASE | ATA_REG_DH_LBA, ATA_REG_DH, dev);
+		wareg(ATA_CMD_SET_MULTIPLE, ATA_REG_CMD, dev);
+
+		res = wait_not_busy(10 * SECS, 1, dev);
+		if (res != CF_TRANS_OK) {
+			printk(KERN_ERR
+			       "cf-mips: failed to detect block size: busy!\n");
+			dev->block_size = 1;
+			return;
+		}
+		if ((rareg(ATA_REG_ST, dev) & ATA_REG_ST_ERR) == 0)
+			break;
+		dev->block_size /= 2;
+	} while (dev->block_size > 1);
+
+	printk(KERN_INFO "cf-mips: multiple sectors = %d\n",
+	       dev->block_size);
+}
+
+int cf_init(struct cf_mips_dev *dev)
+{
+	tasklet_init(&dev->tasklet, cf_do_tasklet, (unsigned long) dev);
+	dev->baddr =
+	    ioremap_nocache((unsigned long) dev->base, CFDEV_BUF_SIZE);
+	if (!dev->baddr) {
+		printk(KERN_ERR
+		       "cf-mips: cf_init: ioremap for (%lx,%x) failed\n",
+		       (unsigned long) dev->base, CFDEV_BUF_SIZE);
+		return -EBUSY;
+	}
+
+	if (!cf_present(dev)) {
+		printk(KERN_WARNING "cf-mips: cf card not present\n");
+		iounmap(dev->baddr);
+		return -ENODEV;
+	}
+
+	if (do_reset(dev) != CF_TRANS_OK) {
+		printk(KERN_ERR "cf-mips: cf reset failed\n");
+		iounmap(dev->baddr);
+		return -EBUSY;
+	}
+
+	if (!do_identify(dev)) {
+		printk(KERN_ERR "cf-mips: cf identify failed\n");
+		iounmap(dev->baddr);
+		return -EBUSY;
+	}
+
+/*	set_apm_level(ATA_APM_WITH_STANDBY); */
+	init_multiple(dev);
+
+	init_timer(&dev->to_timer);
+	dev->to_timer.function = cf_async_timeout;
+	dev->to_timer.data = (unsigned long) dev;
+
+	prepare_cf_irq(dev);
+	if (request_irq(dev->irq, cf_irq_handler, 0, "CF Mips", dev)) {
+		printk(KERN_ERR "cf-mips: failed to get irq\n");
+		iounmap(dev->baddr);
+		return -EBUSY;
+	}
+	/* Disable below would be odd, because request will enable, and the tasklet
+	   will disable it itself */
+	//disable_irq(dev->irq);
+
+	dev->async_mode = 1;
+
+	return 0;
+}
+
+void cf_cleanup(struct cf_mips_dev *dev)
+{
+	iounmap(dev->baddr);
+	free_irq(dev->irq, NULL);
+#if REQUEST_MEM_REGION
+	release_mem_region((unsigned long) dev->base, CFDEV_BUF_SIZE);
+#endif
+}
+
+
+/*eof*/
diff --git a/drivers/block/rb532/ata.h b/drivers/block/rb532/ata.h
new file mode 100644
index 0000000..668d65b
--- /dev/null
+++ b/drivers/block/rb532/ata.h
@@ -0,0 +1,126 @@
+#ifndef __CFMIPS_ATA_H__
+#define __CFMIPS_ATA_H__
+
+#include <linux/interrupt.h>
+
+#define CFG_DC_DEV1	(void*)0xb8010010
+#define   CFG_DC_DEVBASE	0x0
+#define   CFG_DC_DEVMASK	0x4
+#define   CFG_DC_DEVC		0x8
+#define   CFG_DC_DEVTC		0xC
+
+#define CFDEV_BUF_SIZE	0x1000
+#define ATA_CIS_OFFSET	0x200
+#define ATA_REG_OFFSET	0x800
+#define ATA_DBUF_OFFSET	0xC00
+
+#define ATA_REG_FEAT	0x1
+#define ATA_REG_SC	0x2
+#define ATA_REG_SN	0x3
+#define ATA_REG_CL	0x4
+#define ATA_REG_CH	0x5
+#define ATA_REG_DH	0x6
+#define   ATA_REG_DH_BASE	0xa0
+#define   ATA_REG_DH_LBA	0x40
+#define   ATA_REG_DH_DRV	0x10
+#define ATA_REG_CMD	0x7
+#define ATA_REG_ST	0x7
+#define   ATA_REG_ST_BUSY	0x80
+#define   ATA_REG_ST_RDY	0x40
+#define   ATA_REG_ST_DWF	0x20
+#define   ATA_REG_ST_DSC	0x10
+#define   ATA_REG_ST_DRQ	0x08
+#define   ATA_REG_ST_CORR	0x04
+#define   ATA_REG_ST_ERR	0x01
+#define ATA_REG_ERR	0xd
+#define ATA_REG_DC	0xe
+#define   ATA_REG_DC_IEN	0x02
+#define   ATA_REG_DC_SRST	0x04
+
+#define ATA_CMD_READ_SECTORS	0x20
+#define ATA_CMD_WRITE_SECTORS	0x30
+#define ATA_CMD_EXEC_DRIVE_DIAG	0x90
+#define ATA_CMD_READ_MULTIPLE	0xC4
+#define ATA_CMD_WRITE_MULTIPLE	0xC5
+#define ATA_CMD_SET_MULTIPLE	0xC6
+#define ATA_CMD_IDENTIFY_DRIVE	0xEC
+#define ATA_CMD_SET_FEATURES	0xEF
+
+#define ATA_FEATURE_ENABLE_APM	0x05
+#define ATA_FEATURE_DISABLE_APM	0x85
+#define ATA_APM_DISABLED	0x00
+#define ATA_APM_MIN_POWER	0x01
+#define ATA_APM_WITH_STANDBY	0x7f
+#define ATA_APM_WITHOUT_STANDBY	0x80
+#define ATA_APM_MAX_PERFORMANCE	0xfe
+
+#define CF_SECT_SIZE	0x200
+/* That is the ratio CF_SECT_SIZE/512 (the kernel sector size) */
+#define CF_KERNEL_MUL	1
+#define ATA_MAX_SECT_PER_CMD	0x100
+
+#define CF_TRANS_FAILED		0
+#define CF_TRANS_OK		1
+#define CF_TRANS_IN_PROGRESS	2
+
+
+enum trans_state {
+	TS_IDLE = 0,
+	TS_AFTER_RESET,
+	TS_READY,
+	TS_CMD,
+	TS_TRANS
+};
+
+/** Struct to hold the cfdev
+Actually, all the data here only has one instance. However, for 
+reasons of programming conformity, it is passed around as a pointer
+*/
+struct cf_mips_dev {
+	void *base;		/* base address for I/O */
+	void *baddr;		/* remapped address */
+
+	int pin;		/* gpio pin */
+	int irq;		/* gpio irq */
+
+	unsigned head;
+	unsigned cyl;
+	unsigned spt;
+	unsigned sectors;
+
+	unsigned short block_size;
+	unsigned dtype;		// ATA or CF
+	struct request_queue *queue;
+	struct gendisk *gd;
+
+	/* Transaction state */
+	enum trans_state tstate;
+	char *tbuf;
+	unsigned long tbuf_size;
+	sector_t tsect_start;
+	unsigned tsector_count;
+	unsigned tsectors_left;
+	int tread;
+	unsigned tcmd;
+	int async_mode;
+	unsigned long irq_enable_time;
+
+	struct request *active_req;	/* A request is being carried out. Is that different from tstate? */
+	int users;
+	struct timer_list to_timer;
+	struct tasklet_struct tasklet;
+
+	/** This lock ensures that the requests to this device are all done
+	atomically. Transfers can run in parallel, requests are all queued
+	one-by-one */
+	spinlock_t lock;
+};
+
+int cf_do_transfer(struct cf_mips_dev *dev, sector_t sector,
+		   unsigned long nsect, char *buffer, int is_write);
+int cf_init(struct cf_mips_dev *dev);
+void cf_cleanup(struct cf_mips_dev *dev);
+
+void cf_async_trans_done(struct cf_mips_dev *dev, int result);
+
+#endif
diff --git a/drivers/block/rb532/bdev.c b/drivers/block/rb532/bdev.c
new file mode 100644
index 0000000..7fb6988
--- /dev/null
+++ b/drivers/block/rb532/bdev.c
@@ -0,0 +1,302 @@
+/* CF-mips driver
+   This is a block driver for the direct (mmaped) interface to the CF-slot,
+   found in Routerboard.com's RB532 board
+   See SDK provided from routerboard.com.
+   
+   Module adapted By P.Christeas <p_christeas@yahoo.com>, 2005-6.
+   Cleaned up and adapted to platform_device by Felix Fietkau <nbd@openwrt.org>
+
+   This work is redistributed under the terms of the GNU General Public License.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+#include <linux/hdreg.h>
+#include <linux/platform_device.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+
+#include <asm/mach-rc32434/rb.h>
+
+#ifdef DEBUG
+#define DEBUGP printk
+#define DLEVEL 1
+#else
+#define DEBUGP(format, args...)
+#define DLEVEL 0
+#endif
+
+#define CF_MIPS_MAJOR 13
+#define MAJOR_NR	CF_MIPS_MAJOR
+#define CF_MAX_PART	16	/* max 15 partitions */
+
+#include "ata.h"
+
+extern void rb532_gpio_set_cfg(int bit, unsigned gpio);
+
+static struct request *active_req = NULL;
+
+static int cf_open(struct block_device *, fmode_t);
+static int cf_release(struct gendisk *, fmode_t);
+static int cf_ioctl(struct block_device *, fmode_t,
+		    unsigned, unsigned long);
+
+static void cf_request(struct request_queue * q);
+static int cf_transfer(const struct request *req);
+
+static struct block_device_operations cf_bdops = {
+	.owner = THIS_MODULE,
+	.open = cf_open,
+	.release = cf_release,
+	.ioctl = cf_ioctl,
+	.media_changed = NULL,
+	.revalidate_disk = NULL,
+	.compat_ioctl = NULL,
+	.direct_access = NULL
+};
+
+
+int cf_mips_probe(struct platform_device *pdev)
+{
+	struct gendisk *cf_gendisk = NULL;
+	struct cf_device *cdev =
+	    (struct cf_device *) pdev->dev.platform_data;
+	struct cf_mips_dev *dev;
+	struct resource *r;
+	int reg_result;
+
+	reg_result = register_blkdev(MAJOR_NR, "cf-mips");
+	if (reg_result < 0) {
+		printk(KERN_WARNING "cf-mips: can't get major %d\n",
+		       MAJOR_NR);
+		return reg_result;
+	}
+
+	dev =
+	    (struct cf_mips_dev *) kmalloc(sizeof(struct cf_mips_dev),
+					   GFP_KERNEL);
+	if (!dev)
+		goto out_err;
+	memset(dev, 0, sizeof(struct cf_mips_dev));
+	cdev->dev = dev;
+
+	dev->pin = cdev->gpio_pin;
+	dev->irq = platform_get_irq_byname(pdev, "cf_irq");
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					 "cf_membase");
+	dev->base = (void *) r->start;
+
+	if (cf_init(dev))
+		goto out_err;
+	printk("init done");
+
+	spin_lock_init(&dev->lock);
+	dev->queue = blk_init_queue(cf_request, &dev->lock);
+	if (!dev->queue) {
+		printk(KERN_ERR "cf-mips: no mem for queue\n");
+		goto out_err;
+	}
+	blk_queue_max_sectors(dev->queue, ATA_MAX_SECT_PER_CMD);
+
+	/* For memory devices, it is always better to avoid crossing segments
+	   inside the same request. */
+/*	if (dev->dtype==0x848A){
+		printk(KERN_INFO "Setting boundary for cf to 0x%x",(dev->block_size*512)-1);
+		blk_queue_segment_boundary(dev->queue, (dev->block_size*512)-1);
+	}*/
+
+	dev->gd = alloc_disk(CF_MAX_PART);
+	cf_gendisk = dev->gd;
+	cdev->gd = dev->gd;
+	if (!cf_gendisk)
+		goto out_err;	/* Last of these goto's */
+
+	cf_gendisk->major = MAJOR_NR;
+	cf_gendisk->first_minor = 0;
+	cf_gendisk->queue = dev->queue;
+	BUG_ON(cf_gendisk->minors != CF_MAX_PART);
+	strcpy(cf_gendisk->disk_name, "cfa");
+	cf_gendisk->fops = &cf_bdops;
+	cf_gendisk->flags = 0;	/* is not yet GENHD_FL_REMOVABLE */
+	cf_gendisk->private_data = dev;
+
+	set_capacity(cf_gendisk, dev->sectors * CF_KERNEL_MUL);
+
+	/* Let the disk go live */
+	add_disk(cf_gendisk);
+	return 0;
+
+      out_err:
+	if (dev->queue) {
+		blk_cleanup_queue(dev->queue);
+	}
+	if (reg_result) {
+		unregister_blkdev(MAJOR_NR, "cf-mips");
+		return reg_result;
+	}
+	if (dev) {
+		cf_cleanup(dev);
+		kfree(dev);
+	}
+	return 1;
+}
+
+static int cf_mips_remove(struct platform_device *pdev)
+{
+	struct cf_device *cdev =
+	    (struct cf_device *) pdev->dev.platform_data;
+	struct cf_mips_dev *dev = (struct cf_mips_dev *) cdev->dev;
+
+	unregister_blkdev(MAJOR_NR, "cf-mips");
+	blk_cleanup_queue(dev->queue);
+
+	del_gendisk(dev->gd);
+	cf_cleanup(dev);
+	return 0;
+}
+
+
+static struct platform_driver cf_driver = {
+	.driver.name = "pata-rb532-cf",
+	.probe = cf_mips_probe,
+	.remove = cf_mips_remove,
+};
+
+static int __init cf_mips_init(void)
+{
+	printk(KERN_INFO "cf-mips module loaded\n");
+	return platform_driver_register(&cf_driver);
+}
+
+static void cf_mips_cleanup(void)
+{
+	platform_driver_unregister(&cf_driver);
+	printk(KERN_INFO "cf-mips module removed\n");
+}
+
+module_init(cf_mips_init);
+module_exit(cf_mips_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(CF_MIPS_MAJOR);
+
+
+static int cf_open(struct block_device *bdev, fmode_t fmode)
+{
+	struct cf_mips_dev *dev = bdev->bd_disk->private_data;
+	int minor = bdev->bd_part->partno;
+
+	if (minor >= CF_MAX_PART)
+		return -ENODEV;
+	//DEBUGP(KERN_INFO "cf-mips module opened, minor %d\n", minor);
+	spin_lock(&dev->lock);
+	dev->users++;
+	spin_unlock(&dev->lock);
+
+	/* dirty workaround to set CFRDY GPIO as an input when some other
+	   program sets it as an output */
+	rb532_gpio_set_cfg(0, dev->pin);
+	return 0;		/* success */
+}
+
+static int cf_release(struct gendisk *gd, fmode_t unused)
+{
+	struct cf_mips_dev *dev = gd->private_data;
+	spin_lock(&dev->lock);
+	dev->users--;
+	spin_unlock(&dev->lock);
+	return 0;
+}
+
+static int cf_ioctl(struct block_device *bdev, fmode_t fmode,
+		    unsigned cmd, unsigned long arg)
+{
+	unsigned minor = bdev->bd_part->partno;
+	struct cf_mips_dev *dev = bdev->bd_disk->private_data;
+
+	DEBUGP(KERN_INFO "cf_ioctl cmd %u\n", cmd);
+	switch (cmd) {
+	case BLKRRPART:	/* re-read partition table */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+		printk(KERN_INFO "cf-mips partition check: \n");
+		register_disk(dev->gd);
+		return 0;
+
+	case HDIO_GETGEO:
+		{
+			struct hd_geometry geo;
+			geo.cylinders = dev->cyl;
+			geo.heads = dev->head;
+			geo.sectors = dev->spt;
+			geo.start = (*dev->gd->part_tbl->part)[minor].start_sect;
+			if (copy_to_user((void *) arg, &geo, sizeof(geo)))
+				return -EFAULT;
+		}
+		return 0;
+	}
+
+	return -EINVAL;		/* unknown command */
+}
+
+static void cf_request(struct request_queue * q)
+{
+	struct cf_mips_dev *dev;
+
+	struct request *req;
+	int status;
+
+	/* We could have q->queuedata = dev , but haven't yet. */
+	if (active_req)
+		return;
+
+	while ((req = elv_next_request(q)) != NULL) {
+		dev = req->rq_disk->private_data;
+		status = cf_transfer(req);
+		if (status == CF_TRANS_IN_PROGRESS) {
+			active_req = req;
+			return;
+		}
+		end_request(req, status);
+	}
+}
+
+static int cf_transfer(const struct request *req)
+{
+	struct cf_mips_dev *dev = req->rq_disk->private_data;
+
+	if (!blk_fs_request(req)) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING
+			       "cf-mips: skipping non-fs request 0x%x\n",
+			       req->cmd[0]);
+		return CF_TRANS_FAILED;
+	}
+
+	return cf_do_transfer(dev, req->sector, req->current_nr_sectors,
+			      req->buffer, rq_data_dir(req));
+}
+
+void cf_async_trans_done(struct cf_mips_dev *dev, int result)
+{
+	struct request *req;
+
+	spin_lock(&dev->lock);
+	req = active_req;
+	active_req = NULL;
+	end_request(req, result);
+	spin_unlock(&dev->lock);
+
+	spin_lock(&dev->lock);
+	cf_request(dev->queue);
+	spin_unlock(&dev->lock);
+}
-- 
1.5.6.4

