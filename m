From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 11/19] ide: remove deprecated opti621 host driver
Date: Thu, 04 Feb 2016 14:44:08 +0100
Message-ID: <1454593456-3162-12-git-send-email-b.zolnierkie@samsung.com>
References: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.

The replacement driver (pata_opti) has been available since
2006 and it supports all the hardware supported by the old
opti621 host driver.

Remove the deprecated opti621 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig   |   7 --
 drivers/ide/Makefile  |   1 -
 drivers/ide/opti621.c | 178 --------------------------------------------------
 3 files changed, 186 deletions(-)
 delete mode 100644 drivers/ide/opti621.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 2458a1f..2341097 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -314,13 +314,6 @@ config BLK_DEV_GENERIC
           This option provides generic support for various PCI IDE Chipsets
           which otherwise might not be supported.
 
-config BLK_DEV_OPTI621
-	tristate "OPTi 82C621 chipset enhanced support"
-	select BLK_DEV_IDEPCI
-	help
-	  This is a driver for the OPTi 82C621 EIDE controller.
-	  Please read the comments at the top of <file:drivers/ide/opti621.c>.
-
 config BLK_DEV_RZ1000
 	tristate "RZ1000 chipset bugfix/support"
 	depends on X86
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 90b64de..9a69b97 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
-obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_OLD)	+= pdc202xx_old.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_NEW)	+= pdc202xx_new.o
 obj-$(CONFIG_BLK_DEV_PIIX)		+= piix.o
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
deleted file mode 100644
index 26a4500..0000000
--- a/drivers/ide/opti621.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- *  Copyright (C) 1996-1998  Linus Torvalds & authors (see below)
- */
-
-/*
- * Authors:
- * Jaromir Koutek <miri@punknet.cz>,
- * Jan Harkes <jaharkes@cwi.nl>,
- * Mark Lord <mlord@pobox.com>
- * Some parts of code are from ali14xx.c and from rz1000.c.
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-
-#define DRV_NAME "opti621"
-
-#define READ_REG 0	/* index of Read cycle timing register */
-#define WRITE_REG 1	/* index of Write cycle timing register */
-#define CNTRL_REG 3	/* index of Control register */
-#define STRAP_REG 5	/* index of Strap register */
-#define MISC_REG 6	/* index of Miscellaneous register */
-
-static int reg_base;
-
-static DEFINE_SPINLOCK(opti621_lock);
-
-/* Write value to register reg, base of register
- * is at reg_base (0x1f0 primary, 0x170 secondary,
- * if not changed by PCI configuration).
- * This is from setupvic.exe program.
- */
-static void write_reg(u8 value, int reg)
-{
-	inw(reg_base + 1);
-	inw(reg_base + 1);
-	outb(3, reg_base + 2);
-	outb(value, reg_base + reg);
-	outb(0x83, reg_base + 2);
-}
-
-/* Read value from register reg, base of register
- * is at reg_base (0x1f0 primary, 0x170 secondary,
- * if not changed by PCI configuration).
- * This is from setupvic.exe program.
- */
-static u8 read_reg(int reg)
-{
-	u8 ret = 0;
-
-	inw(reg_base + 1);
-	inw(reg_base + 1);
-	outb(3, reg_base + 2);
-	ret = inb(reg_base + reg);
-	outb(0x83, reg_base + 2);
-
-	return ret;
-}
-
-static void opti621_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	ide_drive_t *pair = ide_get_pair_dev(drive);
-	unsigned long flags;
-	unsigned long mode = drive->pio_mode, pair_mode;
-	const u8 pio = mode - XFER_PIO_0;
-	u8 tim, misc, addr_pio = pio, clk;
-
-	/* DRDY is default 2 (by OPTi Databook) */
-	static const u8 addr_timings[2][5] = {
-		{ 0x20, 0x10, 0x00, 0x00, 0x00 },	/* 33 MHz */
-		{ 0x10, 0x10, 0x00, 0x00, 0x00 },	/* 25 MHz */
-	};
-	static const u8 data_rec_timings[2][5] = {
-		{ 0x5b, 0x45, 0x32, 0x21, 0x20 },	/* 33 MHz */
-		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
-	};
-
-	ide_set_drivedata(drive, (void *)mode);
-
-	if (pair) {
-		pair_mode = (unsigned long)ide_get_drivedata(pair);
-		if (pair_mode && pair_mode < mode)
-			addr_pio = pair_mode - XFER_PIO_0;
-	}
-
-	spin_lock_irqsave(&opti621_lock, flags);
-
-	reg_base = hwif->io_ports.data_addr;
-
-	/* allow Register-B */
-	outb(0xc0, reg_base + CNTRL_REG);
-	/* hmm, setupvic.exe does this ;-) */
-	outb(0xff, reg_base + 5);
-	/* if reads 0xff, adapter not exist? */
-	(void)inb(reg_base + CNTRL_REG);
-	/* if reads 0xc0, no interface exist? */
-	read_reg(CNTRL_REG);
-
-	/* check CLK speed */
-	clk = read_reg(STRAP_REG) & 1;
-
-	printk(KERN_INFO "%s: CLK = %d MHz\n", hwif->name, clk ? 25 : 33);
-
-	tim  = data_rec_timings[clk][pio];
-	misc = addr_timings[clk][addr_pio];
-
-	/* select Index-0/1 for Register-A/B */
-	write_reg(drive->dn & 1, MISC_REG);
-	/* set read cycle timings */
-	write_reg(tim, READ_REG);
-	/* set write cycle timings */
-	write_reg(tim, WRITE_REG);
-
-	/* use Register-A for drive 0 */
-	/* use Register-B for drive 1 */
-	write_reg(0x85, CNTRL_REG);
-
-	/* set address setup, DRDY timings,   */
-	/*  and read prefetch for both drives */
-	write_reg(misc, MISC_REG);
-
-	spin_unlock_irqrestore(&opti621_lock, flags);
-}
-
-static const struct ide_port_ops opti621_port_ops = {
-	.set_pio_mode		= opti621_set_pio_mode,
-};
-
-static const struct ide_port_info opti621_chipset = {
-	.name		= DRV_NAME,
-	.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
-	.port_ops	= &opti621_port_ops,
-	.host_flags	= IDE_HFLAG_NO_DMA,
-	.pio_mask	= ATA_PIO4,
-};
-
-static int opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &opti621_chipset, NULL);
-}
-
-static const struct pci_device_id opti621_pci_tbl[] = {
-	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), 0 },
-	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 0 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
-
-static struct pci_driver opti621_pci_driver = {
-	.name		= "Opti621_IDE",
-	.id_table	= opti621_pci_tbl,
-	.probe		= opti621_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init opti621_ide_init(void)
-{
-	return ide_pci_register_driver(&opti621_pci_driver);
-}
-
-static void __exit opti621_ide_exit(void)
-{
-	pci_unregister_driver(&opti621_pci_driver);
-}
-
-module_init(opti621_ide_init);
-module_exit(opti621_ide_exit);
-
-MODULE_AUTHOR("Jaromir Koutek, Jan Harkes, Mark Lord");
-MODULE_DESCRIPTION("PCI driver module for Opti621 IDE");
-MODULE_LICENSE("GPL");
-- 
1.9.1
