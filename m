From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/11] ide: ide_config_drive_speed() bugfixes
Date: Sun, 22 Jul 2007 20:30:42 +0200
Message-ID: <200707222030.42305.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:33765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758095AbXGVSTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001345ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Gouache <akira2.iguchi@toshiba.co.jp>


* Use ->OUTBSYNC instead of ->OUTB when writing command register
  (needed for scc_pata and pmac host drivers).

* Don't check DRDY bit of the status register on ATAPI devices
  (ATAPI devices are free to ignore DRDY bit).

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Cc: Akira Gouache <akira2.iguchi@toshiba.co.jp>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
this patch is independent from the previous five ide-pmac patches

 drivers/ide/ide-iops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -822,7 +822,7 @@ int ide_config_drive_speed (ide_drive_t 
 		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 	hwif->OUTB(speed, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
-	hwif->OUTB(WIN_SETFEATURES, IDE_COMMAND_REG);
+	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
 	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	udelay(1);
@@ -849,7 +849,7 @@ int ide_config_drive_speed (ide_drive_t 
 	 */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
-		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), DRIVE_READY, BUSY_STAT|DRQ_STAT|ERR_STAT)) {
+		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), drive->ready_stat, BUSY_STAT|DRQ_STAT|ERR_STAT)) {
 			error = 0;
 			break;
 		}
