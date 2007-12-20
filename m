From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/63] ide-cd: fix error messages in cdrom_write_intr()
Date: Thu, 20 Dec 2007 01:56:13 +0100
Message-ID: <200712200156.13518.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759476AbXLTBg5@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1799,8 +1799,9 @@ static ide_startstop_t cdrom_write_intr(
 	/* Check for errors. */
 	if (dma) {
 		info->dma = 0;
-		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
-			printk(KERN_ERR "ide-cd: write dma error\n");
+		dma_error = HWIF(drive)->ide_dma_end(drive);
+		if (dma_error) {
+			printk(KERN_ERR "%s: DMA write error\n", drive->name);
 			ide_dma_off(drive);
 		}
 	}
@@ -1833,8 +1834,9 @@ static ide_startstop_t cdrom_write_intr(
 		 */
 		uptodate = 1;
 		if (rq->current_nr_sectors > 0) {
-			printk(KERN_ERR "%s: write_intr: data underrun (%d blocks)\n",
-			drive->name, rq->current_nr_sectors);
+			printk(KERN_ERR "%s: %s: data underrun (%d blocks)\n",
+					drive->name, __FUNCTION__,
+					rq->current_nr_sectors);
 			uptodate = 0;
 		}
 		cdrom_end_request(drive, uptodate);
@@ -1854,7 +1856,8 @@ static ide_startstop_t cdrom_write_intr(
 		int this_transfer;
 
 		if (!rq->current_nr_sectors) {
-			printk(KERN_ERR "ide-cd: write_intr: oops\n");
+			printk(KERN_ERR "%s: %s: confused, missing data\n",
+					drive->name, __FUNCTION__);
 			break;
 		}
 
