From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/21] ide: move ide_arm_init() call from init_ide_data() to ide_init()
Date: Sun, 18 Nov 2007 23:32:25 +0100
Message-ID: <200711182332.25906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbXKRWgu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remove ide_init_port_data() call from ide_arm_init() and move
  ide_arm_init() call from init_ide_data() to ide_init().

This patch is a preparation for the future changes (and as a side-effect
makes obsolete "idex=io[,ctl[,irq]]" kernel parameters work for ide_arm).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/ide_arm.c |    1 -
 drivers/ide/ide.c         |    6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: b/drivers/ide/arm/ide_arm.c
===================================================================
--- a/drivers/ide/arm/ide_arm.c
+++ b/drivers/ide/arm/ide_arm.c
@@ -35,7 +35,6 @@ void __init ide_arm_init(void)
 
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
-		ide_init_port_data(hwif, hwif->index);
 		ide_init_port_hw(hwif, &hw);
 	}
 }
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -218,9 +218,6 @@ static void __init init_ide_data (void)
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 #endif
 	}
-#ifdef CONFIG_IDE_ARM
-	ide_arm_init();
-#endif
 }
 
 /**
@@ -1744,6 +1741,9 @@ static int __init ide_init(void)
 
 	proc_ide_create();
 
+#ifdef CONFIG_IDE_ARM
+	ide_arm_init();
+#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
 		(void)ali14xx_init();
