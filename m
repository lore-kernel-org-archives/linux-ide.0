From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] ide_arm: manage I/O resources in driver
Date: Sat, 1 Mar 2008 19:47:49 +0100
Message-ID: <200803011947.49203.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:27917 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759772AbYCAUni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 15:43:38 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1035380ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 12:43:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Tell IDE layer to not manage resources by setting hwif->mmio flag.

* Use {request,release}_region() for resources management.

* Use driver name for resources management.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/ide_arm.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -14,6 +14,8 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 
+#define DRV_NAME "ide_arm"
+
 #ifdef CONFIG_ARCH_CLPS7500
 # include <asm/arch/hardware.h>
 #
@@ -28,15 +30,30 @@ static int __init ide_arm_init(void)
 {
 	ide_hwif_t *hwif;
 	hw_regs_t hw;
+	unsigned long base = IDE_ARM_IO, ctl = IDE_ARM_IO + 0x206;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
+	if (!request_region(base, 8, DRV_NAME)) {
+		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
+				DRV_NAME, base, base + 7);
+		return -EBUSY;
+	}
+
+	if (!request_region(ctl, 1, DRV_NAME)) {
+		printk(KERN_ERR "%s: I/O resource 0x%lX not free.\n",
+				DRV_NAME, ctl);
+		release_region(base, 8);
+		return -EBUSY;
+	}
+
 	memset(&hw, 0, sizeof(hw));
-	ide_std_init_ports(&hw, IDE_ARM_IO, IDE_ARM_IO + 0x206);
+	ide_std_init_ports(&hw, base, ctl);
 	hw.irq = IDE_ARM_IRQ;
 
 	hwif = ide_find_port();
 	if (hwif) {
 		ide_init_port_hw(hwif, &hw);
+		hwif->mmio = 1;
 		idx[0] = hwif->index;
 
 		ide_device_add(idx, NULL);
