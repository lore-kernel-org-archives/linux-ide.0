From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/15] ide: move handling of I/O resources out of ide_probe_port()
Date: Fri, 04 Jan 2008 22:26:04 +0100
Message-ID: <20080104212604.6978.5744.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbYADVOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:14:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833654ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:14:29 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Reserve/release I/O resources in ide_device_add_all() instead of
ide_probe_port().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -747,13 +747,6 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (hwif->noprobe)
 		return -EACCES;
 
-	if ((hwif->chipset != ide_4drives || !hwif->mate || !hwif->mate->present) &&
-	    (ide_hwif_request_regions(hwif))) {
-		printk(KERN_ERR "%s: ports already in use, skipping probe\n",
-				hwif->name);
-		return -EBUSY;
-	}
-
 	/*
 	 * We must always disable IRQ, as probe_for_drive will assert IRQ, but
 	 * we'll install our IRQ driver much later...
@@ -798,10 +791,8 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (irqd)
 		enable_irq(irqd);
 
-	if (!hwif->present) {
-		ide_hwif_release_regions(hwif);
+	if (!hwif->present)
 		return -ENODEV;
-	}
 
 	for (unit = 0; unit < MAX_DRIVES; unit++) {
 		ide_drive_t *drive = &hwif->drives[unit];
@@ -1309,7 +1300,17 @@ int ide_device_add_all(u8 *idx)
 		if (idx[i] == 0xff)
 			continue;
 
-		(void)ide_probe_port(&ide_hwifs[idx[i]]);
+		hwif = &ide_hwifs[idx[i]];
+
+		if ((hwif->chipset != ide_4drives || !hwif->mate ||
+		     !hwif->mate->present) && ide_hwif_request_regions(hwif)) {
+			printk(KERN_ERR "%s: ports already in use, "
+					"skipping probe\n", hwif->name);
+			continue;
+		}
+
+		if (ide_probe_port(hwif) < 0)
+			ide_hwif_release_regions(hwif);
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
