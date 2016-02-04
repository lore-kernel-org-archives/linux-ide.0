From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 17/19] ide: remove deprecated triflex host driver
Date: Thu, 04 Feb 2016 14:44:14 +0100
Message-ID: <1454593456-3162-18-git-send-email-b.zolnierkie@samsung.com>
References: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52826 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965233AbcBDNsR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 08:48:17 -0500
In-reply-to: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.

The replacement driver (pata_triflex) has been available since
2006 and it supports all the hardware supported by the old
triflex host driver.

Remove the deprecated triflex host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig   |   7 ---
 drivers/ide/Makefile  |   1 -
 drivers/ide/triflex.c | 155 --------------------------------------------------
 3 files changed, 163 deletions(-)
 delete mode 100644 drivers/ide/triflex.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index c92d5d1..486601c 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -360,13 +360,6 @@ config BLK_DEV_CMD64X
 	  Say Y here if you have an IDE controller which uses any of these
 	  chipsets: CMD643, CMD646, or CMD648.
 
-config BLK_DEV_TRIFLEX
-	tristate "Compaq Triflex IDE support"
-	select BLK_DEV_IDEDMA_PCI
-	help
-	  Say Y here if you have a Compaq Triflex IDE controller, such
-	  as those commonly found on Compaq Pentium-Pro systems
-
 config BLK_DEV_CY82C693
 	tristate "CY82C693 chipset support"
 	depends on ALPHA
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 1ff2f8a..0f3cc1a 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -48,7 +48,6 @@ obj-$(CONFIG_BLK_DEV_SGIIOC4)		+= sgiioc4.o
 obj-$(CONFIG_BLK_DEV_SIIMAGE)		+= siimage.o
 obj-$(CONFIG_BLK_DEV_SL82C105)		+= sl82c105.o
 obj-$(CONFIG_BLK_DEV_TC86C001)		+= tc86c001.o
-obj-$(CONFIG_BLK_DEV_TRIFLEX)		+= triflex.o
 obj-$(CONFIG_BLK_DEV_TRM290)		+= trm290.o
 obj-$(CONFIG_BLK_DEV_VIA82CXXX)		+= via82cxxx.o
 
diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
deleted file mode 100644
index 7f1af94..0000000
--- a/drivers/ide/triflex.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * IDE Chipset driver for the Compaq TriFlex IDE controller.
- * 
- * Known to work with the Compaq Workstation 5x00 series.
- *
- * Copyright (C) 2002 Hewlett-Packard Development Group, L.P.
- * Author: Torben Mathiasen <torben.mathiasen@hp.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- * 
- * Loosely based on the piix & svwks drivers.
- *
- * Documentation:
- *	Not publicly available.
- */
-
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#define DRV_NAME "triflex"
-
-static void triflex_set_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u32 triflex_timings = 0;
-	u16 timing = 0;
-	u8 channel_offset = hwif->channel ? 0x74 : 0x70, unit = drive->dn & 1;
-
-	pci_read_config_dword(dev, channel_offset, &triflex_timings);
-
-	switch (drive->dma_mode) {
-		case XFER_MW_DMA_2:
-			timing = 0x0103; 
-			break;
-		case XFER_MW_DMA_1:
-			timing = 0x0203;
-			break;
-		case XFER_MW_DMA_0:
-			timing = 0x0808;
-			break;
-		case XFER_SW_DMA_2:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-			timing = 0x0f0f;
-			break;
-		case XFER_PIO_4:
-			timing = 0x0202;
-			break;
-		case XFER_PIO_3:
-			timing = 0x0204;
-			break;
-		case XFER_PIO_2:
-			timing = 0x0404;
-			break;
-		case XFER_PIO_1:
-			timing = 0x0508;
-			break;
-		case XFER_PIO_0:
-			timing = 0x0808;
-			break;
-	}
-
-	triflex_timings &= ~(0xFFFF << (16 * unit));
-	triflex_timings |= (timing << (16 * unit));
-	
-	pci_write_config_dword(dev, channel_offset, triflex_timings);
-}
-
-static void triflex_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	drive->dma_mode = drive->pio_mode;
-	triflex_set_mode(hwif, drive);
-}
-
-static const struct ide_port_ops triflex_port_ops = {
-	.set_pio_mode		= triflex_set_pio_mode,
-	.set_dma_mode		= triflex_set_mode,
-};
-
-static const struct ide_port_info triflex_device = {
-	.name		= DRV_NAME,
-	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
-	.port_ops	= &triflex_port_ops,
-	.pio_mask	= ATA_PIO4,
-	.swdma_mask	= ATA_SWDMA2,
-	.mwdma_mask	= ATA_MWDMA2,
-};
-
-static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &triflex_device, NULL);
-}
-
-static const struct pci_device_id triflex_pci_tbl[] = {
-	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE), 0 },
-	{ 0, },
-};
-MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
-
-#ifdef CONFIG_PM
-static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	/*
-	 * We must not disable or powerdown the device.
-	 * APM bios refuses to suspend if IDE is not accessible.
-	 */
-	pci_save_state(dev);
-	return 0;
-}
-#else
-#define triflex_ide_pci_suspend NULL
-#endif
-
-static struct pci_driver triflex_pci_driver = {
-	.name		= "TRIFLEX_IDE",
-	.id_table	= triflex_pci_tbl,
-	.probe		= triflex_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= triflex_ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init triflex_ide_init(void)
-{
-	return ide_pci_register_driver(&triflex_pci_driver);
-}
-
-static void __exit triflex_ide_exit(void)
-{
-	pci_unregister_driver(&triflex_pci_driver);
-}
-
-module_init(triflex_ide_init);
-module_exit(triflex_ide_exit);
-
-MODULE_AUTHOR("Torben Mathiasen");
-MODULE_DESCRIPTION("PCI driver module for Compaq Triflex IDE");
-MODULE_LICENSE("GPL");
-
-
-- 
1.9.1

