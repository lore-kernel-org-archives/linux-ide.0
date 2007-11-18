From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/21] ide: fix probing for hosts with serialized or IRQ sharing interfaces
Date: Sun, 18 Nov 2007 23:22:13 +0100
Message-ID: <200711182322.13666.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbXKRWgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


After hwif_register_devices() IDE devices are ready to be used so
the way in which ide_device_add() works currently is racy for hosts
with serialized / IRQ sharing interfaces.

Fix ide_device_add() by looping over interfaces for probe_hwif(),
hwif_init() and hwif_register_devices() operations.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1389,9 +1389,14 @@ int ide_device_add(u8 idx[4])
 		if (idx[i] == 0xff)
 			continue;
 
-		hwif = &ide_hwifs[idx[i]];
+		probe_hwif(&ide_hwifs[idx[i]]);
+	}
 
-		probe_hwif(hwif);
+	for (i = 0; i < 4; i++) {
+		if (idx[i] == 0xff)
+			continue;
+
+		hwif = &ide_hwifs[idx[i]];
 
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
@@ -1399,6 +1404,13 @@ int ide_device_add(u8 idx[4])
 			rc = -1;
 			continue;
 		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (idx[i] == 0xff)
+			continue;
+
+		hwif = &ide_hwifs[idx[i]];
 
 		if (hwif->present)
 			hwif_register_devices(hwif);
