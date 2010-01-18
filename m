From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 30/64] amd74xx: don't change UDMA settings when programming PIO timings
Date: Mon, 18 Jan 2010 18:18:17 +0100
Message-ID: <20100118171817.14623.7796.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755114Ab0ARRTg@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: don't change UDMA settings when programming PIO timings

Based on libata pata_amd host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/amd74xx.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/amd74xx.c
===================================================================
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -3,7 +3,7 @@
  * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
- * Copyright (c) 2007-2008 Bartlomiej Zolnierkiewicz
+ * Copyright (c) 2007-2010 Bartlomiej Zolnierkiewicz
  *
  * Based on the work of:
  *      Andre Hedrick
@@ -70,7 +70,8 @@ static void amd_set_speed(struct pci_dev
 	default: return;
 	}
 
-	pci_write_config_byte(dev, AMD_UDMA_TIMING + offset + (3 - dn), t);
+	if (timing->udma)
+		pci_write_config_byte(dev, AMD_UDMA_TIMING + offset + 3 - dn, t);
 }
 
 /*
@@ -340,6 +341,6 @@ static void __exit amd74xx_ide_exit(void
 module_init(amd74xx_ide_init);
 module_exit(amd74xx_ide_exit);
 
-MODULE_AUTHOR("Vojtech Pavlik");
+MODULE_AUTHOR("Vojtech Pavlik, Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("AMD PCI IDE driver");
 MODULE_LICENSE("GPL");
