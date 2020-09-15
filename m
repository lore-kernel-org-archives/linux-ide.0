Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84141C43461
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5507A20738
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 01:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIOB2k (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:28:40 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52362 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOB2e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2020 21:28:34 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 653D22A027; Mon, 14 Sep 2020 21:28:30 -0400 (EDT)
To:     "David S. Miller" <davem@davemloft.net>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Joshua Thompson" <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Message-Id: <52189e8ee3f8b578e8477f4f05a2c880629209c2.1600132677.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3] ide/macide: Convert Mac IDE driver to platform driver
Date:   Tue, 15 Sep 2020 11:17:57 +1000
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add platform devices for the Mac IDE controller variants. Convert the
macide module into a platform driver to support two of those variants.
For the third, use a generic "pata_platform" driver instead.
This enables automatic loading of the appropriate module and begins
the process of replacing the driver with libata alternatives.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>
References: commit 5ed0794cde593 ("m68k/atari: Convert Falcon IDE drivers to platform drivers")
References: commit 7ad19a99ad431 ("ide: officially deprecated the legacy IDE driver")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
This patch was tested successfully on a Powerbook 190 (MAC_IDE_BABOON)
using both pata_platform and ide_platform drivers.
The next step will be to try using these generic drivers with the other
IDE controller variants (MAC_IDE_QUADRA or MAC_IDE_PB) so that the macide
driver can be entirely replaced with libata drivers.

Changed since v2:
 - Enabled CONFIG_BLK_DEV_PLATFORM in multi_defconfig.
 - Replaced dev_get_drvdata() with platform_get_drvdata().

Changed since v1:
 - Adopted DEFINE_RES_MEM and DEFINE_RES_IRQ macros.
 - Dropped IORESOURCE_IRQ_SHAREABLE flag as it is ignored by pata_platform.c
   and IRQF_SHARED makes no difference in this case.
 - Removed redundant release_mem_region() call.
 - Enabled CONFIG_BLK_DEV_PLATFORM in mac_defconfig. We might also enable
   CONFIG_PATA_PLATFORM but IMO migration to libata should be a separate
   patch (as this patch has some unrelated benefits).
---
 arch/m68k/configs/mac_defconfig   |  1 +
 arch/m68k/configs/multi_defconfig |  1 +
 arch/m68k/mac/config.c            | 41 +++++++++++++++++++
 drivers/ide/macide.c              | 66 ++++++++++++++++++++-----------
 4 files changed, 86 insertions(+), 23 deletions(-)

diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 6087798662601..f770970fe4e99 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -317,6 +317,7 @@ CONFIG_DUMMY_IRQ=m
 CONFIG_IDE=y
 CONFIG_IDE_GD_ATAPI=y
 CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_PLATFORM=y
 CONFIG_BLK_DEV_MAC_IDE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 0abb53c38c20d..f93c3021f20d4 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -346,6 +346,7 @@ CONFIG_DUMMY_IRQ=m
 CONFIG_IDE=y
 CONFIG_IDE_GD_ATAPI=y
 CONFIG_BLK_DEV_IDECD=y
+CONFIG_BLK_DEV_PLATFORM=y
 CONFIG_BLK_DEV_GAYLE=y
 CONFIG_BLK_DEV_BUDDHA=y
 CONFIG_BLK_DEV_FALCON_IDE=y
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 5c9f3a2d65388..43fc29180cb58 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/vt_kern.h>
 #include <linux/platform_device.h>
+#include <linux/ata_platform.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
@@ -940,6 +941,26 @@ static const struct resource mac_scsi_ccl_rsrc[] __initconst = {
 	},
 };
 
+static const struct resource mac_ide_quadra_rsrc[] __initconst = {
+	DEFINE_RES_MEM(0x50F1A000, 0x104),
+	DEFINE_RES_IRQ(IRQ_NUBUS_F),
+};
+
+static const struct resource mac_ide_pb_rsrc[] __initconst = {
+	DEFINE_RES_MEM(0x50F1A000, 0x104),
+	DEFINE_RES_IRQ(IRQ_NUBUS_C),
+};
+
+static const struct resource mac_pata_baboon_rsrc[] __initconst = {
+	DEFINE_RES_MEM(0x50F1A000, 0x38),
+	DEFINE_RES_MEM(0x50F1A038, 0x04),
+	DEFINE_RES_IRQ(IRQ_BABOON_1),
+};
+
+static const struct pata_platform_info mac_pata_baboon_data __initconst = {
+	.ioport_shift = 2,
+};
+
 int __init mac_platform_init(void)
 {
 	phys_addr_t swim_base = 0;
@@ -1048,6 +1069,26 @@ int __init mac_platform_init(void)
 		break;
 	}
 
+	/*
+	 * IDE device
+	 */
+
+	switch (macintosh_config->ide_type) {
+	case MAC_IDE_QUADRA:
+		platform_device_register_simple("mac_ide", -1,
+			mac_ide_quadra_rsrc, ARRAY_SIZE(mac_ide_quadra_rsrc));
+		break;
+	case MAC_IDE_PB:
+		platform_device_register_simple("mac_ide", -1,
+			mac_ide_pb_rsrc, ARRAY_SIZE(mac_ide_pb_rsrc));
+		break;
+	case MAC_IDE_BABOON:
+		platform_device_register_resndata(NULL, "pata_platform", -1,
+			mac_pata_baboon_rsrc, ARRAY_SIZE(mac_pata_baboon_rsrc),
+			&mac_pata_baboon_data, sizeof(mac_pata_baboon_data));
+		break;
+	}
+
 	/*
 	 * Ethernet device
 	 */
diff --git a/drivers/ide/macide.c b/drivers/ide/macide.c
index 3c6bb8599303b..8a201a467886b 100644
--- a/drivers/ide/macide.c
+++ b/drivers/ide/macide.c
@@ -18,10 +18,11 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/macintosh.h>
-#include <asm/macints.h>
-#include <asm/mac_baboon.h>
+
+#define DRV_NAME "mac_ide"
 
 #define IDE_BASE 0x50F1A000	/* Base address of IDE controller */
 
@@ -109,42 +110,61 @@ static const char *mac_ide_name[] =
  * Probe for a Macintosh IDE interface
  */
 
-static int __init macide_init(void)
+static int mac_ide_probe(struct platform_device *pdev)
 {
-	unsigned long base;
-	int irq;
+	struct resource *mem, *irq;
 	struct ide_hw hw, *hws[] = { &hw };
 	struct ide_port_info d = macide_port_info;
+	struct ide_host *host;
+	int rc;
 
 	if (!MACH_IS_MAC)
 		return -ENODEV;
 
-	switch (macintosh_config->ide_type) {
-	case MAC_IDE_QUADRA:
-		base = IDE_BASE;
-		irq = IRQ_NUBUS_F;
-		break;
-	case MAC_IDE_PB:
-		base = IDE_BASE;
-		irq = IRQ_NUBUS_C;
-		break;
-	case MAC_IDE_BABOON:
-		base = BABOON_BASE;
-		d.port_ops = NULL;
-		irq = IRQ_BABOON_1;
-		break;
-	default:
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq)
 		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, mem->start,
+				     resource_size(mem), DRV_NAME)) {
+		dev_err(&pdev->dev, "resources busy\n");
+		return -EBUSY;
 	}
 
 	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
 			 mac_ide_name[macintosh_config->ide_type - 1]);
 
-	macide_setup_ports(&hw, base, irq);
+	macide_setup_ports(&hw, mem->start, irq->start);
 
-	return ide_host_add(&d, hws, 1, NULL);
+	rc = ide_host_add(&d, hws, 1, &host);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, host);
+	return 0;
 }
 
-module_init(macide_init);
+static int mac_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+
+	ide_host_remove(host);
+	return 0;
+}
+
+static struct platform_driver mac_ide_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe  = mac_ide_probe,
+	.remove = mac_ide_remove,
+};
+
+module_platform_driver(mac_ide_driver);
 
+MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_LICENSE("GPL");
-- 
2.26.2

