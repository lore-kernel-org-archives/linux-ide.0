From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/13] ide: fix PIO setup on resume for ATAPI devices
Date: Sat, 10 Mar 2007 22:12:24 +0100
Message-ID: <200703102212.24463.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbXCJVJW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749117uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: fix PIO setup on resume for ATAPI devices

PIO should be restored also for ATAPI devices during resume, fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-io.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -172,15 +172,6 @@ static ide_startstop_t ide_start_power_s
 
 	memset(args, 0, sizeof(*args));
 
-	if (drive->media != ide_disk) {
-		/*
-		 * skip idedisk_pm_restore_pio and idedisk_pm_idle for ATAPI
-		 * devices
-		 */
-		if (pm->pm_step == idedisk_pm_restore_pio)
-			pm->pm_step = ide_pm_restore_dma;
-	}
-
 	switch (pm->pm_step) {
 	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) */
 		if (drive->media != ide_disk)
@@ -207,7 +198,13 @@ static ide_startstop_t ide_start_power_s
 	case idedisk_pm_restore_pio:	/* Resume step 1 (restore PIO) */
 		if (drive->hwif->tuneproc != NULL)
 			drive->hwif->tuneproc(drive, 255);
-		ide_complete_power_step(drive, rq, 0, 0);
+		/*
+		 * skip idedisk_pm_idle for ATAPI devices
+		 */
+		if (drive->media != ide_disk)
+			pm->pm_step = ide_pm_restore_dma;
+		else
+			ide_complete_power_step(drive, rq, 0, 0);
 		return ide_stopped;
 
 	case idedisk_pm_idle:		/* Resume step 2 (idle) */
