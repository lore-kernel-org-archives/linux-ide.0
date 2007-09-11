From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/10] ide: add hwif_register_devices() helper
Date: Tue, 11 Sep 2007 23:38:21 +0200
Message-ID: <200709112338.21389.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:27656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbXIKVkU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:20 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1156nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add hwif_register_devices() helper to fix code duplication between
probe_hwif_init_with_fixup() and ideprobe_init().  Also remove stale
comment while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   51 +++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -859,6 +859,7 @@ static void probe_hwif(ide_hwif_t *hwif,
 }
 
 static int hwif_init(ide_hwif_t *hwif);
+static void hwif_register_devices(ide_hwif_t *hwif);
 
 int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
 {
@@ -870,24 +871,9 @@ int probe_hwif_init_with_fixup(ide_hwif_
 		return -1;
 	}
 
-	if (hwif->present) {
-		u16 unit = 0;
-		int ret;
-
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			ide_drive_t *drive = &hwif->drives[unit];
-			/* For now don't attach absent drives, we may
-			   want them on default or a new "empty" class
-			   for hotplug reprobing ? */
-			if (drive->present) {
-				ret = device_register(&drive->gendev);
-				if (ret < 0)
-					printk(KERN_WARNING "IDE: %s: "
-						"device_register error: %d\n",
-						__FUNCTION__, ret);
-			}
-		}
-	}
+	if (hwif->present)
+		hwif_register_devices(hwif);
+
 	return 0;
 }
 
@@ -1379,6 +1365,24 @@ out:
 	return 0;
 }
 
+static void hwif_register_devices(ide_hwif_t *hwif)
+{
+	unsigned int i;
+
+	for (i = 0; i < MAX_DRIVES; i++) {
+		ide_drive_t *drive = &hwif->drives[i];
+
+		if (drive->present) {
+			int ret = device_register(&drive->gendev);
+
+			if (ret < 0)
+				printk(KERN_WARNING "IDE: %s: "
+					"device_register error: %d\n",
+					__FUNCTION__, ret);
+		}
+	}
+}
+
 int ideprobe_init (void)
 {
 	unsigned int index;
@@ -1397,20 +1401,11 @@ int ideprobe_init (void)
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		if (probe[index]) {
 			ide_hwif_t *hwif = &ide_hwifs[index];
-			int unit;
 			if (!hwif->present)
 				continue;
 			if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced)
 				hwif->chipset = ide_generic;
-			for (unit = 0; unit < MAX_DRIVES; ++unit)
-				if (hwif->drives[unit].present) {
-					int ret = device_register(
-						&hwif->drives[unit].gendev);
-					if (ret < 0)
-						printk(KERN_WARNING "IDE: %s: "
-							"device_register error: %d\n",
-							__FUNCTION__, ret);
-				}
+			hwif_register_devices(hwif);
 		}
 	}
 	for (index = 0; index < MAX_HWIFS; ++index)
