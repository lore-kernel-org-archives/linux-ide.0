From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/20] ide: don't enable local IRQs for PIO-in in driver_cmd_intr()
Date: Sun, 9 Dec 2007 22:18:30 +0100
Message-ID: <200712092218.30672.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbXLIVVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:21:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Don't enable local IRQs for PIO-in protocol in driver_cmd_intr().

While at it:

* Remove redundant rq->cmd_type check.

* Read status register after enabling local IRQs for no-data protocol.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -638,17 +638,18 @@ static ide_startstop_t drive_cmd_intr (i
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	ide_hwif_t *hwif = HWIF(drive);
-	u8 *args = (u8 *) rq->buffer;
-	u8 stat = hwif->INB(IDE_STATUS_REG);
+	u8 *args = (u8 *)rq->buffer, pio_in = (args && args[3]) ? 1 : 0, stat;
 
-	local_irq_enable_in_hardirq();
-	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
-	    (stat & DRQ_STAT) && args && args[3]) {
+	if (pio_in) {
 		u8 io_32bit = drive->io_32bit;
+		stat = hwif->INB(IDE_STATUS_REG);
 		drive->io_32bit = 0;
 		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
 		drive->io_32bit = io_32bit;
 		stat = wait_drive_not_busy(drive);
+	} else {
+		local_irq_enable_in_hardirq();
+		stat = hwif->INB(IDE_STATUS_REG);
 	}
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
