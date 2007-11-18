From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/21] ide: add hwif->chipset fixup to ide_device_add()
Date: Sun, 18 Nov 2007 23:24:28 +0100
Message-ID: <200711182324.28429.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbXKRWgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add hwif->chipset fixup identical to the one in ideprobe_init()
to ide_device_add().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1412,8 +1412,12 @@ int ide_device_add(u8 idx[4])
 
 		hwif = &ide_hwifs[idx[i]];
 
-		if (hwif->present)
+		if (hwif->present) {
+			if (hwif->chipset == ide_unknown ||
+			    hwif->chipset == ide_forced)
+				hwif->chipset = ide_generic;
 			hwif_register_devices(hwif);
+		}
 	}
 
 	for (i = 0; i < 4; i++) {
