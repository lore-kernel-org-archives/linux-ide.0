Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE52C4743F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500A561249
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHGGW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:06:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38448 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhFHGGV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 02:06:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 52C6E2AD56; Tue,  8 Jun 2021 02:04:25 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Message-Id: <8ec3037e69f5ec9f7dbbafc642638f03eff29927.1623131194.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1623131194.git.fthain@linux-m68k.org>
References: <cover.1623131194.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 1/2] m68k/mac: Replace macide driver with generic platform
 drivers
Date:   Tue, 08 Jun 2021 15:46:34 +1000
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This allows m68k mac systems to switch from the deprecated IDE subsystem
to libata.

This was tested on my Quadra 630. I haven't tested it on my PowerBook 150
because I don't have a RAM adapter board for it. It appears that the
hardware I tested doesn't need macide_clear_irq() or macide_test_irq().
If it did, the generic driver would not have worked. It's possible that
those routines are needed for the PowerBook 150 but we can cross that
bridge if and when we come to it.

BTW, macide_clear_irq() appears to suffer from a race condition. The write
to the interrupt flags register could have unintended side effects as it
may alter other flag bits. Fortunately, all of the other bits are unused
by Linux. When tested on my Quadra 630, the assignment *ide_ifr &= ~0x20
was observed to have no effect on bit 5, so it may be redundant anyway.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Joshua Thompson <funaho@jurai.org>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/configs/mac_defconfig   |   1 -
 arch/m68k/configs/multi_defconfig |   1 -
 arch/m68k/mac/config.c            |  24 +++--
 drivers/ide/Kconfig               |  14 ---
 drivers/ide/Makefile              |   1 -
 drivers/ide/macide.c              | 161 ------------------------------
 6 files changed, 14 insertions(+), 188 deletions(-)
 delete mode 100644 drivers/ide/macide.c

diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index bf15e6c1c939..c72a85a084cc 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -319,7 +319,6 @@ CONFIG_IDE=y
 CONFIG_IDE_GD_ATAPI=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_PLATFORM=y
-CONFIG_BLK_DEV_MAC_IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 5466d48fcd9d..9ee6d2b4d1f4 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -351,7 +351,6 @@ CONFIG_BLK_DEV_PLATFORM=y
 CONFIG_BLK_DEV_GAYLE=y
 CONFIG_BLK_DEV_BUDDHA=y
 CONFIG_BLK_DEV_FALCON_IDE=y
-CONFIG_BLK_DEV_MAC_IDE=y
 CONFIG_BLK_DEV_Q40IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 1cdac959bd91..5d16f9b47aa9 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -933,13 +933,15 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
 	},
 };
 
-static const struct resource mac_ide_quadra_rsrc[] __initconst = {
-	DEFINE_RES_MEM(0x50F1A000, 0x104),
+static const struct resource mac_pata_quadra_rsrc[] __initconst = {
+	DEFINE_RES_MEM(0x50F1A000, 0x38),
+	DEFINE_RES_MEM(0x50F1A038, 0x04),
 	DEFINE_RES_IRQ(IRQ_NUBUS_F),
 };
 
-static const struct resource mac_ide_pb_rsrc[] __initconst = {
-	DEFINE_RES_MEM(0x50F1A000, 0x104),
+static const struct resource mac_pata_pb_rsrc[] __initconst = {
+	DEFINE_RES_MEM(0x50F1A000, 0x38),
+	DEFINE_RES_MEM(0x50F1A038, 0x04),
 	DEFINE_RES_IRQ(IRQ_NUBUS_C),
 };
 
@@ -949,7 +951,7 @@ static const struct resource mac_pata_baboon_rsrc[] __initconst = {
 	DEFINE_RES_IRQ(IRQ_BABOON_1),
 };
 
-static const struct pata_platform_info mac_pata_baboon_data __initconst = {
+static const struct pata_platform_info mac_pata_data __initconst = {
 	.ioport_shift = 2,
 };
 
@@ -1067,17 +1069,19 @@ int __init mac_platform_init(void)
 
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
-		platform_device_register_simple("mac_ide", -1,
-			mac_ide_quadra_rsrc, ARRAY_SIZE(mac_ide_quadra_rsrc));
+		platform_device_register_resndata(NULL, "pata_platform", -1,
+			mac_pata_quadra_rsrc, ARRAY_SIZE(mac_pata_quadra_rsrc),
+			&mac_pata_data, sizeof(mac_pata_data));
 		break;
 	case MAC_IDE_PB:
-		platform_device_register_simple("mac_ide", -1,
-			mac_ide_pb_rsrc, ARRAY_SIZE(mac_ide_pb_rsrc));
+		platform_device_register_resndata(NULL, "pata_platform", -1,
+			mac_pata_pb_rsrc, ARRAY_SIZE(mac_pata_pb_rsrc),
+			&mac_pata_data, sizeof(mac_pata_data));
 		break;
 	case MAC_IDE_BABOON:
 		platform_device_register_resndata(NULL, "pata_platform", -1,
 			mac_pata_baboon_rsrc, ARRAY_SIZE(mac_pata_baboon_rsrc),
-			&mac_pata_baboon_data, sizeof(mac_pata_baboon_data));
+			&mac_pata_data, sizeof(mac_pata_data));
 		break;
 	}
 
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 19abf11c84c8..8ce4a5878d0c 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -739,20 +739,6 @@ config BLK_DEV_FALCON_IDE
 	  disks, CD-ROM drives, etc.) that are connected to the on-board IDE
 	  interface.
 
-config BLK_DEV_MAC_IDE
-	tristate "Macintosh Quadra/Powerbook IDE interface support"
-	depends on MAC
-	help
-	  This is the IDE driver for the on-board IDE interface on some m68k
-	  Macintosh models, namely Quadra/Centris 630, Performa 588 and
-	  Powerbook 150. The IDE interface on the Powerbook 190 is not
-	  supported by this driver and requires BLK_DEV_PLATFORM or
-	  PATA_PLATFORM.
-
-	  Say Y if you have such an Macintosh model and want to use IDE
-	  devices (hard disks, CD-ROM drives, etc.) that are connected to the
-	  on-board IDE interface.
-
 config BLK_DEV_Q40IDE
 	tristate "Q40/Q60 IDE interface support"
 	depends on Q40
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 2605b3cdaf47..45a1c0463bed 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_BLK_DEV_4DRIVES)		+= ide-4drives.o
 
 obj-$(CONFIG_BLK_DEV_GAYLE)		+= gayle.o
 obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
-obj-$(CONFIG_BLK_DEV_MAC_IDE)		+= macide.o
 obj-$(CONFIG_BLK_DEV_Q40IDE)		+= q40ide.o
 obj-$(CONFIG_BLK_DEV_BUDDHA)		+= buddha.o
 
diff --git a/drivers/ide/macide.c b/drivers/ide/macide.c
deleted file mode 100644
index 8d2bf73bc548..000000000000
--- a/drivers/ide/macide.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- *  Macintosh IDE Driver
- *
- *     Copyright (C) 1998 by Michael Schmitz
- *
- *  This driver was written based on information obtained from the MacOS IDE
- *  driver binary by Mikael Forselius
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive for
- *  more details.
- */
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/blkdev.h>
-#include <linux/delay.h>
-#include <linux/ide.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include <asm/macintosh.h>
-
-#define DRV_NAME "mac_ide"
-
-#define IDE_BASE 0x50F1A000	/* Base address of IDE controller */
-
-/*
- * Generic IDE registers as offsets from the base
- * These match MkLinux so they should be correct.
- */
-
-#define IDE_CONTROL	0x38	/* control/altstatus */
-
-/*
- * Mac-specific registers
- */
-
-/*
- * this register is odd; it doesn't seem to do much and it's
- * not word-aligned like virtually every other hardware register
- * on the Mac...
- */
-
-#define IDE_IFR		0x101	/* (0x101) IDE interrupt flags on Quadra:
-				 *
-				 * Bit 0+1: some interrupt flags
-				 * Bit 2+3: some interrupt enable
-				 * Bit 4:   ??
-				 * Bit 5:   IDE interrupt flag (any hwif)
-				 * Bit 6:   maybe IDE interrupt enable (any hwif) ??
-				 * Bit 7:   Any interrupt condition
-				 */
-
-volatile unsigned char *ide_ifr = (unsigned char *) (IDE_BASE + IDE_IFR);
-
-int macide_test_irq(ide_hwif_t *hwif)
-{
-	if (*ide_ifr & 0x20)
-		return 1;
-	return 0;
-}
-
-static void macide_clear_irq(ide_drive_t *drive)
-{
-	*ide_ifr &= ~0x20;
-}
-
-static void __init macide_setup_ports(struct ide_hw *hw, unsigned long base,
-				      int irq)
-{
-	int i;
-
-	memset(hw, 0, sizeof(*hw));
-
-	for (i = 0; i < 8; i++)
-		hw->io_ports_array[i] = base + i * 4;
-
-	hw->io_ports.ctl_addr = base + IDE_CONTROL;
-
-	hw->irq = irq;
-}
-
-static const struct ide_port_ops macide_port_ops = {
-	.clear_irq		= macide_clear_irq,
-	.test_irq		= macide_test_irq,
-};
-
-static const struct ide_port_info macide_port_info = {
-	.port_ops		= &macide_port_ops,
-	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
-	.irq_flags		= IRQF_SHARED,
-	.chipset		= ide_generic,
-};
-
-static const char *mac_ide_name[] =
-	{ "Quadra", "Powerbook", "Powerbook Baboon" };
-
-/*
- * Probe for a Macintosh IDE interface
- */
-
-static int mac_ide_probe(struct platform_device *pdev)
-{
-	struct resource *mem, *irq;
-	struct ide_hw hw, *hws[] = { &hw };
-	struct ide_port_info d = macide_port_info;
-	struct ide_host *host;
-	int rc;
-
-	if (!MACH_IS_MAC)
-		return -ENODEV;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -ENODEV;
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq)
-		return -ENODEV;
-
-	if (!devm_request_mem_region(&pdev->dev, mem->start,
-				     resource_size(mem), DRV_NAME)) {
-		dev_err(&pdev->dev, "resources busy\n");
-		return -EBUSY;
-	}
-
-	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
-			 mac_ide_name[macintosh_config->ide_type - 1]);
-
-	macide_setup_ports(&hw, mem->start, irq->start);
-
-	rc = ide_host_add(&d, hws, 1, &host);
-	if (rc)
-		return rc;
-
-	platform_set_drvdata(pdev, host);
-	return 0;
-}
-
-static int mac_ide_remove(struct platform_device *pdev)
-{
-	struct ide_host *host = platform_get_drvdata(pdev);
-
-	ide_host_remove(host);
-	return 0;
-}
-
-static struct platform_driver mac_ide_driver = {
-	.driver = {
-		.name = DRV_NAME,
-	},
-	.probe  = mac_ide_probe,
-	.remove = mac_ide_remove,
-};
-
-module_platform_driver(mac_ide_driver);
-
-MODULE_ALIAS("platform:" DRV_NAME);
-MODULE_LICENSE("GPL");
-- 
2.26.3

