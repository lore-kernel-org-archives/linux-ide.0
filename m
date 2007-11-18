From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/21] ide: kill probe_hwif_init()
Date: Sun, 18 Nov 2007 23:21:02 +0100
Message-ID: <200711182321.02732.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbXKRWgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -855,25 +855,6 @@ static void probe_hwif(ide_hwif_t *hwif)
 	}
 }
 
-static int hwif_init(ide_hwif_t *hwif);
-static void hwif_register_devices(ide_hwif_t *hwif);
-
-static int probe_hwif_init(ide_hwif_t *hwif)
-{
-	probe_hwif(hwif);
-
-	if (!hwif_init(hwif)) {
-		printk(KERN_INFO "%s: failed to initialize IDE interface\n",
-				 hwif->name);
-		return -1;
-	}
-
-	if (hwif->present)
-		hwif_register_devices(hwif);
-
-	return 0;
-}
-
 #if MAX_HWIFS > 1
 /*
  * save_match() is used to simplify logic in init_irq() below.
@@ -1401,11 +1382,26 @@ EXPORT_SYMBOL_GPL(ideprobe_init);
 
 int ide_device_add(u8 idx[4])
 {
+	ide_hwif_t *hwif;
 	int i, rc = 0;
 
 	for (i = 0; i < 4; i++) {
-		if (idx[i] != 0xff)
-			rc |= probe_hwif_init(&ide_hwifs[idx[i]]);
+		if (idx[i] == 0xff)
+			continue;
+
+		hwif = &ide_hwifs[idx[i]];
+
+		probe_hwif(hwif);
+
+		if (hwif_init(hwif) == 0) {
+			printk(KERN_INFO "%s: failed to initialize IDE "
+					 "interface\n", hwif->name);
+			rc = -1;
+			continue;
+		}
+
+		if (hwif->present)
+			hwif_register_devices(hwif);
 	}
 
 	for (i = 0; i < 4; i++) {
