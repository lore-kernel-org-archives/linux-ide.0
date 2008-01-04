From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/15] ide_platform: remove struct hwif_prop
Date: Fri, 04 Jan 2008 22:24:54 +0100
Message-ID: <20080104212454.6978.66772.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbYADVNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:17 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Remove 'if (hwif != hwif_prop.hwif)' check from plat_ide_remove()
  (pdev->dev.driver_data and hwif_prop.hwif are set at the same time
   in plat_ide_probe() and are identical).

* Use hwif->index for ide_unregister() in plat_ide_remove().

* Use local variables instead of hwif_prop.plat_ide[_alt]_mapbase in
  plat_ide_probe() and remove no longer needed struct hwif_prop.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-150 bytes
 drivers/ide/legacy/ide_platform.c |   34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -21,13 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-static struct {
-	void __iomem *plat_ide_mapbase;
-	void __iomem *plat_ide_alt_mapbase;
-	ide_hwif_t *hwif;
-	int index;
-} hwif_prop;
-
 static void __devinit plat_ide_setup_ports(hw_regs_t *hw,
 					   void __iomem *base,
 					   void __iomem *ctrl,
@@ -54,6 +47,7 @@ static void __devinit plat_ide_setup_por
 static int __devinit plat_ide_probe(struct platform_device *pdev)
 {
 	struct resource *res_base, *res_alt, *res_irq;
+	void __iomem *base, *alt_base;
 	ide_hwif_t *hwif;
 	struct pata_platform_info *pdata;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
@@ -84,27 +78,25 @@ static int __devinit plat_ide_probe(stru
 	}
 
 	if (mmio) {
-		hwif_prop.plat_ide_mapbase = devm_ioremap(&pdev->dev,
+		base = devm_ioremap(&pdev->dev,
 			res_base->start, res_base->end - res_base->start + 1);
-		hwif_prop.plat_ide_alt_mapbase = devm_ioremap(&pdev->dev,
+		alt_base = devm_ioremap(&pdev->dev,
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	} else {
-		hwif_prop.plat_ide_mapbase = devm_ioport_map(&pdev->dev,
+		base = devm_ioport_map(&pdev->dev,
 			res_base->start, res_base->end - res_base->start + 1);
-		hwif_prop.plat_ide_alt_mapbase = devm_ioport_map(&pdev->dev,
+		alt_base = devm_ioport_map(&pdev->dev,
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	}
 
-	hwif = ide_find_port((unsigned long)hwif_prop.plat_ide_mapbase);
+	hwif = ide_find_port((unsigned long)base);
 	if (!hwif) {
 		ret = -ENODEV;
 		goto out;
 	}
 
 	memset(&hw, 0, sizeof(hw));
-	plat_ide_setup_ports(&hw, hwif_prop.plat_ide_mapbase,
-			     hwif_prop.plat_ide_alt_mapbase,
-			     pdata, res_irq->start);
+	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);
 	hw.dev = &pdev->dev;
 
 	ide_init_port_hw(hwif, &hw);
@@ -114,9 +106,6 @@ static int __devinit plat_ide_probe(stru
 		default_hwif_mmiops(hwif);
 	}
 
-	hwif_prop.hwif = hwif;
-	hwif_prop.index = hwif->index;
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx);
@@ -133,14 +122,7 @@ static int __devexit plat_ide_remove(str
 {
 	ide_hwif_t *hwif = pdev->dev.driver_data;
 
-	if (hwif != hwif_prop.hwif) {
-		dev_printk(KERN_DEBUG, &pdev->dev, "%s: hwif value error",
-		           pdev->name);
-	} else {
-		ide_unregister(hwif_prop.index);
-		hwif_prop.index = 0;
-		hwif_prop.hwif = NULL;
-	}
+	ide_unregister(hwif->index);
 
 	return 0;
 }
