From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/15] ide: fix handling of busy I/O resources in probe_hwif()
Date: Fri, 04 Jan 2008 22:24:31 +0100
Message-ID: <20080104212431.6978.35188.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbYADVMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:12:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:12:55 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

It could be that I/O resources are busy because some other host driver
has already claimed them so don't unregister the devices.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-94 bytes
 drivers/ide/ide-probe.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -727,18 +727,7 @@ static void probe_hwif(ide_hwif_t *hwif)
 
 	if ((hwif->chipset != ide_4drives || !hwif->mate || !hwif->mate->present) &&
 	    (ide_hwif_request_regions(hwif))) {
-		u16 msgout = 0;
-		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			ide_drive_t *drive = &hwif->drives[unit];
-			if (drive->present) {
-				drive->present = 0;
-				printk(KERN_ERR "%s: ERROR, PORTS ALREADY IN USE\n",
-					drive->name);
-				msgout = 1;
-			}
-		}
-		if (!msgout)
-			printk(KERN_ERR "%s: ports already in use, skipping probe\n",
+		printk(KERN_ERR "%s: ports already in use, skipping probe\n",
 				hwif->name);
 		return;	
 	}
