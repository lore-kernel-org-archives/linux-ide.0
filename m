From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 02/19] ide: remove deprecated cs5520 host driver
Date: Thu, 04 Feb 2016 14:43:59 +0100
Message-ID: <1454593456-3162-3-git-send-email-b.zolnierkie@samsung.com>
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

The replacement driver (pata_cs5520) has been available since
2006 and it supports all the hardware supported by the old
cs5520 host driver.  Also x86 defconfigs have switched to use
libata PATA exclusively in 2008.

Remove the deprecated cs5520 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig  |  11 ----
 drivers/ide/Makefile |   1 -
 drivers/ide/cs5520.c | 168 ---------------------------------------------------
 3 files changed, 180 deletions(-)
 delete mode 100644 drivers/ide/cs5520.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 8c30be9..f340763 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -403,17 +403,6 @@ config BLK_DEV_CY82C693
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
 
-config BLK_DEV_CS5520
-	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
-	depends on X86_32 || COMPILE_TEST
-	select BLK_DEV_IDEDMA_PCI
-	help
-	  Include support for PIO tuning and virtual DMA on the Cyrix MediaGX
-	  5510/5520 chipset. This will automatically be detected and
-	  configured if found.
-
-	  It is safe to say Y to this question.
-
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
 	depends on X86_32 || COMPILE_TEST
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index cabab02..a1d2257 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
-obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
 obj-$(CONFIG_BLK_DEV_CS5536)		+= cs5536.o
diff --git a/drivers/ide/cs5520.c b/drivers/ide/cs5520.c
deleted file mode 100644
index 89a4ff10..0000000
--- a/drivers/ide/cs5520.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
- *	IDE tuning and bus mastering support for the CS5510/CS5520
- *	chipsets
- *
- *	The CS5510/CS5520 are slightly unusual devices. Unlike the 
- *	typical IDE controllers they do bus mastering with the drive in
- *	PIO mode and smarter silicon.
- *
- *	The practical upshot of this is that we must always tune the
- *	drive for the right PIO mode. We must also ignore all the blacklists
- *	and the drive bus mastering DMA information.
- *
- *	*** This driver is strictly experimental ***
- *
- *	(c) Copyright Red Hat Inc 2002
- * 
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * For the avoidance of doubt the "preferred form" of this code is one which
- * is in an open non patent encumbered format. Where cryptographic key signing
- * forms part of the process of creating an executable the information
- * including keys needed to generate an equivalently functional executable
- * are deemed to be part of the source code.
- *
- */
- 
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/dma-mapping.h>
-
-#define DRV_NAME "cs5520"
-
-struct pio_clocks
-{
-	int address;
-	int assert;
-	int recovery;
-};
-
-static struct pio_clocks cs5520_pio_clocks[]={
-	{3, 6, 11},
-	{2, 5, 6},
-	{1, 4, 3},
-	{1, 3, 2},
-	{1, 2, 1}
-};
-
-static void cs5520_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *pdev = to_pci_dev(hwif->dev);
-	int controller = drive->dn > 1 ? 1 : 0;
-	const u8 pio = drive->pio_mode - XFER_PIO_0;
-
-	/* 8bit CAT/CRT - 8bit command timing for channel */
-	pci_write_config_byte(pdev, 0x62 + controller, 
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-
-	/* 0x64 - 16bit Primary, 0x68 - 16bit Secondary */
-
-	/* FIXME: should these use address ? */
-	/* Data read timing */
-	pci_write_config_byte(pdev, 0x64 + 4*controller + (drive->dn&1),
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-	/* Write command timing */
-	pci_write_config_byte(pdev, 0x66 + 4*controller + (drive->dn&1),
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-}
-
-static void cs5520_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	printk(KERN_ERR "cs55x0: bad ide timing.\n");
-
-	drive->pio_mode = XFER_PIO_0 + 0;
-	cs5520_set_pio_mode(hwif, drive);
-}
-
-static const struct ide_port_ops cs5520_port_ops = {
-	.set_pio_mode		= cs5520_set_pio_mode,
-	.set_dma_mode		= cs5520_set_dma_mode,
-};
-
-static const struct ide_port_info cyrix_chipset = {
-	.name		= DRV_NAME,
-	.enablebits	= { { 0x60, 0x01, 0x01 }, { 0x60, 0x02, 0x02 } },
-	.port_ops	= &cs5520_port_ops,
-	.host_flags	= IDE_HFLAG_ISA_PORTS | IDE_HFLAG_CS5520,
-	.pio_mask	= ATA_PIO4,
-};
-
-/*
- *	The 5510/5520 are a bit weird. They don't quite set up the way
- *	the PCI helper layer expects so we must do much of the set up 
- *	work longhand.
- */
- 
-static int cs5520_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	const struct ide_port_info *d = &cyrix_chipset;
-	struct ide_hw hw[2], *hws[] = { NULL, NULL };
-
-	ide_setup_pci_noise(dev, d);
-
-	/* We must not grab the entire device, it has 'ISA' space in its
-	 * BARS too and we will freak out other bits of the kernel
-	 */
-	if (pci_enable_device_io(dev)) {
-		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
-		return -ENODEV;
-	}
-	pci_set_master(dev);
-	if (dma_set_mask(&dev->dev, DMA_BIT_MASK(32))) {
-		printk(KERN_WARNING "%s: No suitable DMA available.\n",
-			d->name);
-		return -ENODEV;
-	}
-
-	/*
-	 *	Now the chipset is configured we can let the core
-	 *	do all the device setup for us
-	 */
-
-	ide_pci_setup_ports(dev, d, &hw[0], &hws[0]);
-	hw[0].irq = 14;
-	hw[1].irq = 15;
-
-	return ide_host_add(d, hws, 2, NULL);
-}
-
-static const struct pci_device_id cs5520_pci_tbl[] = {
-	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5510), 0 },
-	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5520), 1 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, cs5520_pci_tbl);
-
-static struct pci_driver cs5520_pci_driver = {
-	.name		= "Cyrix_IDE",
-	.id_table	= cs5520_pci_tbl,
-	.probe		= cs5520_init_one,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init cs5520_ide_init(void)
-{
-	return ide_pci_register_driver(&cs5520_pci_driver);
-}
-
-module_init(cs5520_ide_init);
-
-MODULE_AUTHOR("Alan Cox");
-MODULE_DESCRIPTION("PCI driver module for Cyrix 5510/5520 IDE");
-MODULE_LICENSE("GPL");
-- 
1.9.1
