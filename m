From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 04/19] ide: remove deprecated cs5535 host driver
Date: Thu, 04 Feb 2016 14:44:01 +0100
Message-ID: <1454593456-3162-5-git-send-email-b.zolnierkie@samsung.com>
References: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56906 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934070AbcBDNpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 08:45:51 -0500
In-reply-to: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.

The replacement driver (pata_cs5535) has been available since
2006 and it supports all the hardware supported by the old
cs5535 host driver.  Also x86 defconfigs have switched to use
libata PATA exclusively in 2008.

Remove the deprecated cs5535 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ide/Kconfig  |  10 ---
 drivers/ide/Makefile |   1 -
 drivers/ide/cs5535.c | 219 ---------------------------------------------------
 3 files changed, 230 deletions(-)
 delete mode 100644 drivers/ide/cs5535.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 5cd7675..d056aa5 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -403,16 +403,6 @@ config BLK_DEV_CY82C693
 	  This driver adds detection and support for the CY82C693 chipset
 	  used on Digital's PC-Alpha 164SX boards.
 
-config BLK_DEV_CS5535
-	tristate "AMD CS5535 chipset support"
-	depends on X86_32
-	select BLK_DEV_IDEDMA_PCI
-	help
-	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.
-	  This will automatically be detected and configured if found.
-
-	  It is safe to say Y to this question.
-
 config BLK_DEV_CS5536
 	tristate "CS5536 chipset support"
 	depends on X86_32
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 719879f..a0b8ade0 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
-obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
 obj-$(CONFIG_BLK_DEV_CS5536)		+= cs5536.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
diff --git a/drivers/ide/cs5535.c b/drivers/ide/cs5535.c
deleted file mode 100644
index 3bc5b9a..0000000
--- a/drivers/ide/cs5535.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * Copyright (C) 2004-2005 Advanced Micro Devices, Inc.
- * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
- *
- * History:
- * 09/20/2005 - Jaya Kumar <jayakumar.ide@gmail.com>
- * - Reworked tuneproc, set_drive, misc mods to prep for mainline
- * - Work was sponsored by CIS (M) Sdn Bhd.
- * Ported to Kernel 2.6.11 on June 26, 2005 by
- *   Wolfgang Zuleger <wolfgang.zuleger@gmx.de>
- *   Alexander Kiausch <alex.kiausch@t-online.de>
- * Originally developed by AMD for 2.4/2.6
- *
- * Development of this chipset driver was funded
- * by the nice folks at National Semiconductor/AMD.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * Documentation:
- *  CS5535 documentation available from AMD
- */
-
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define DRV_NAME "cs5535"
-
-#define MSR_ATAC_BASE		0x51300000
-#define ATAC_GLD_MSR_CAP	(MSR_ATAC_BASE+0)
-#define ATAC_GLD_MSR_CONFIG	(MSR_ATAC_BASE+0x01)
-#define ATAC_GLD_MSR_SMI	(MSR_ATAC_BASE+0x02)
-#define ATAC_GLD_MSR_ERROR	(MSR_ATAC_BASE+0x03)
-#define ATAC_GLD_MSR_PM		(MSR_ATAC_BASE+0x04)
-#define ATAC_GLD_MSR_DIAG	(MSR_ATAC_BASE+0x05)
-#define ATAC_IO_BAR		(MSR_ATAC_BASE+0x08)
-#define ATAC_RESET		(MSR_ATAC_BASE+0x10)
-#define ATAC_CH0D0_PIO		(MSR_ATAC_BASE+0x20)
-#define ATAC_CH0D0_DMA		(MSR_ATAC_BASE+0x21)
-#define ATAC_CH0D1_PIO		(MSR_ATAC_BASE+0x22)
-#define ATAC_CH0D1_DMA		(MSR_ATAC_BASE+0x23)
-#define ATAC_PCI_ABRTERR	(MSR_ATAC_BASE+0x24)
-#define ATAC_BM0_CMD_PRIM	0x00
-#define ATAC_BM0_STS_PRIM	0x02
-#define ATAC_BM0_PRD		0x04
-#define CS5535_CABLE_DETECT	0x48
-
-/* Format I PIO settings. We separate out cmd and data for safer timings */
-
-static unsigned int cs5535_pio_cmd_timings[5] =
-{ 0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131 };
-static unsigned int cs5535_pio_dta_timings[5] =
-{ 0xF7F4, 0xF173, 0x8141, 0x5131, 0x1131 };
-
-static unsigned int cs5535_mwdma_timings[3] =
-{ 0x7F0FFFF3, 0x7F035352, 0x7f024241 };
-
-static unsigned int cs5535_udma_timings[5] =
-{ 0x7F7436A1, 0x7F733481, 0x7F723261, 0x7F713161, 0x7F703061 };
-
-/* Macros to check if the register is the reset value -  reset value is an
-   invalid timing and indicates the register has not been set previously */
-
-#define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL) == 0x00009172 )
-#define CS5535_BAD_DMA(timings) ( (timings & 0x000FFFFF) == 0x00077771 )
-
-/****
- *	cs5535_set_speed         -     Configure the chipset to the new speed
- *	@drive: Drive to set up
- *	@speed: desired speed
- *
- *	cs5535_set_speed() configures the chipset to a new speed.
- */
-static void cs5535_set_speed(ide_drive_t *drive, const u8 speed)
-{
-	u32 reg = 0, dummy;
-	u8 unit = drive->dn & 1;
-
-	/* Set the PIO timings */
-	if (speed < XFER_SW_DMA_0) {
-		ide_drive_t *pair = ide_get_pair_dev(drive);
-		u8 cmd, pioa;
-
-		cmd = pioa = speed - XFER_PIO_0;
-
-		if (pair) {
-			u8 piob = pair->pio_mode - XFER_PIO_0;
-
-			if (piob < cmd)
-				cmd = piob;
-		}
-
-		/* Write the speed of the current drive */
-		reg = (cs5535_pio_cmd_timings[cmd] << 16) |
-			cs5535_pio_dta_timings[pioa];
-		wrmsr(unit ? ATAC_CH0D1_PIO : ATAC_CH0D0_PIO, reg, 0);
-
-		/* And if nessesary - change the speed of the other drive */
-		rdmsr(unit ?  ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, dummy);
-
-		if (((reg >> 16) & cs5535_pio_cmd_timings[cmd]) !=
-			cs5535_pio_cmd_timings[cmd]) {
-			reg &= 0x0000FFFF;
-			reg |= cs5535_pio_cmd_timings[cmd] << 16;
-			wrmsr(unit ? ATAC_CH0D0_PIO : ATAC_CH0D1_PIO, reg, 0);
-		}
-
-		/* Set bit 31 of the DMA register for PIO format 1 timings */
-		rdmsr(unit ?  ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
-		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA,
-					reg | 0x80000000UL, 0);
-	} else {
-		rdmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, dummy);
-
-		reg &= 0x80000000UL;  /* Preserve the PIO format bit */
-
-		if (speed >= XFER_UDMA_0 && speed <= XFER_UDMA_4)
-			reg |= cs5535_udma_timings[speed - XFER_UDMA_0];
-		else if (speed >= XFER_MW_DMA_0 && speed <= XFER_MW_DMA_2)
-			reg |= cs5535_mwdma_timings[speed - XFER_MW_DMA_0];
-		else
-			return;
-
-		wrmsr(unit ? ATAC_CH0D1_DMA : ATAC_CH0D0_DMA, reg, 0);
-	}
-}
-
-/**
- *	cs5535_set_dma_mode	-	set host controller for DMA mode
- *	@hwif: port
- *	@drive: drive
- *
- *	Programs the chipset for DMA mode.
- */
-
-static void cs5535_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	cs5535_set_speed(drive, drive->dma_mode);
-}
-
-/**
- *	cs5535_set_pio_mode	-	set host controller for PIO mode
- *	@hwif: port
- *	@drive: drive
- *
- *	A callback from the upper layers for PIO-only tuning.
- */
-
-static void cs5535_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	cs5535_set_speed(drive, drive->pio_mode);
-}
-
-static u8 cs5535_cable_detect(ide_hwif_t *hwif)
-{
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u8 bit;
-
-	/* if a 80 wire cable was detected */
-	pci_read_config_byte(dev, CS5535_CABLE_DETECT, &bit);
-
-	return (bit & 1) ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
-}
-
-static const struct ide_port_ops cs5535_port_ops = {
-	.set_pio_mode		= cs5535_set_pio_mode,
-	.set_dma_mode		= cs5535_set_dma_mode,
-	.cable_detect		= cs5535_cable_detect,
-};
-
-static const struct ide_port_info cs5535_chipset = {
-	.name		= DRV_NAME,
-	.port_ops	= &cs5535_port_ops,
-	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE,
-	.pio_mask	= ATA_PIO4,
-	.mwdma_mask	= ATA_MWDMA2,
-	.udma_mask	= ATA_UDMA4,
-};
-
-static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	return ide_pci_init_one(dev, &cs5535_chipset, NULL);
-}
-
-static const struct pci_device_id cs5535_pci_tbl[] = {
-	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_CS5535_IDE), 0 },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5535_IDE), },
-	{ 0, },
-};
-
-MODULE_DEVICE_TABLE(pci, cs5535_pci_tbl);
-
-static struct pci_driver cs5535_pci_driver = {
-	.name		= "CS5535_IDE",
-	.id_table	= cs5535_pci_tbl,
-	.probe		= cs5535_init_one,
-	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
-};
-
-static int __init cs5535_ide_init(void)
-{
-	return ide_pci_register_driver(&cs5535_pci_driver);
-}
-
-static void __exit cs5535_ide_exit(void)
-{
-	pci_unregister_driver(&cs5535_pci_driver);
-}
-
-module_init(cs5535_ide_init);
-module_exit(cs5535_ide_exit);
-
-MODULE_AUTHOR("AMD");
-MODULE_DESCRIPTION("PCI driver module for AMD/NS CS5535 IDE");
-MODULE_LICENSE("GPL");
-- 
1.9.1

