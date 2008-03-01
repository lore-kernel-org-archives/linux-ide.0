From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] ide-4drives: manage I/O resources in driver
Date: Sat, 1 Mar 2008 19:47:43 +0100
Message-ID: <200803011947.43296.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:27483 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYCAUng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 15:43:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1035349ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 12:43:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Tell IDE layer to not manage resources by setting hwif->mmio flag.

* Use {request,release}_region() for resources management.

* Use driver name for resources management.

* Remove no longer needed 'hwif->chipset == ide_4drives' handling
  from ide_device_add_all().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c          |    3 +--
 drivers/ide/legacy/ide-4drives.c |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1526,8 +1526,7 @@ int ide_device_add_all(u8 *idx, const st
 
 		hwif = &ide_hwifs[idx[i]];
 
-		if ((hwif->chipset != ide_4drives || !hwif->mate ||
-		     !hwif->mate->present) && ide_hwif_request_regions(hwif)) {
+		if (ide_hwif_request_regions(hwif)) {
 			printk(KERN_ERR "%s: ports already in use, "
 					"skipping probe\n", hwif->name);
 			continue;
Index: b/drivers/ide/legacy/ide-4drives.c
===================================================================
--- a/drivers/ide/legacy/ide-4drives.c
+++ b/drivers/ide/legacy/ide-4drives.c
@@ -4,6 +4,8 @@
 #include <linux/module.h>
 #include <linux/ide.h>
 
+#define DRV_NAME "ide-4drives"
+
 int probe_4drives;
 
 module_param_named(probe, probe_4drives, bool, 0);
@@ -12,21 +14,36 @@ MODULE_PARM_DESC(probe, "probe for gener
 static int __init ide_4drives_init(void)
 {
 	ide_hwif_t *hwif, *mate;
+	unsigned long base = 0x1f0, ctl = 0x3f6;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	hw_regs_t hw;
 
 	if (probe_4drives == 0)
 		return -ENODEV;
 
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
 
-	ide_std_init_ports(&hw, 0x1f0, 0x3f6);
+	ide_std_init_ports(&hw, base, ctl);
 	hw.irq = 14;
 	hw.chipset = ide_4drives;
 
 	hwif = ide_find_port();
 	if (hwif) {
 		ide_init_port_hw(hwif, &hw);
+		hwif->mmio = 1;
 		idx[0] = hwif->index;
 	}
 
@@ -35,6 +52,7 @@ static int __init ide_4drives_init(void)
 		ide_init_port_hw(mate, &hw);
 		mate->drives[0].select.all ^= 0x20;
 		mate->drives[1].select.all ^= 0x20;
+		mate->mmio = 1;
 		idx[1] = mate->index;
 
 		if (hwif) {
