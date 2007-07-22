From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: fix drive->init_speed reporting
Date: Sun, 22 Jul 2007 20:19:03 +0200
Message-ID: <200707222019.03684.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:33765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbXGVSS5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:18:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001345ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:18:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


pmac_ide_tune_chipset() don't set drive->init_speed.

Fix it by setting drive->{current,init}_speed in pmac_ide_do_setfeature()
and clean up pmac_ide_{tune_chipset,mdma_enable,udma_enable}().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Goes before "[PATCH] ide-pmac: PIO mode setup fixes (take 2)" patch
in the IDE quilt tree.

 drivers/ide/ppc/pmac.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -602,6 +602,9 @@ out:
 				drive->id->dma_1word |= 0x0101; break;
 			default: break;
 		}
+		if (!drive->init_speed)
+			drive->init_speed = command;
+		drive->current_speed = command;
 	}
 	enable_irq(hwif->irq);
 	return result;
@@ -974,7 +977,6 @@ static int pmac_ide_tune_chipset(ide_dri
 		return ret;
 		
 	pmac_ide_do_update_timings(drive);	
-	drive->current_speed = speed;
 
 	return 0;
 }
@@ -1725,11 +1727,6 @@ pmac_ide_mdma_enable(ide_drive_t *drive,
 	/* Apply timings to controller */
 	*timings = timing_local[0];
 	*timings2 = timing_local[1];
-	
-	/* Set speed info in drive */
-	drive->current_speed = mode;	
-	if (!drive->init_speed)
-		drive->init_speed = mode;
 
 	return 1;
 }
@@ -1781,11 +1778,6 @@ pmac_ide_udma_enable(ide_drive_t *drive,
 	*timings = timing_local[0];
 	*timings2 = timing_local[1];
 
-	/* Set speed info in drive */
-	drive->current_speed = mode;	
-	if (!drive->init_speed)
-		drive->init_speed = mode;
-
 	return 1;
 }
 
