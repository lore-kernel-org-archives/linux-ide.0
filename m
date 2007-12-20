From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/63] ide-cd: fix DMA error handling in cdrom_newpc_intr()
Date: Thu, 20 Dec 2007 02:02:06 +0100
Message-ID: <200712200202.06988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12071 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508AbXLTBeO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389250ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Make cdrom_newpc_intr() match cdrom_{read,write}_intr() w.r.t.
handling DMA errors:

* disable DMA before cdrom_decode_status() call

* log the device name and the type of the request (read/write)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1663,6 +1663,11 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (dma) {
 		info->dma = 0;
 		dma_error = HWIF(drive)->ide_dma_end(drive);
+		if (dma_error) {
+			printk(KERN_ERR "%s: DMA %s error\n", drive->name,
+					rq_data_dir(rq) ? "write" : "read");
+			ide_dma_off(drive);
+		}
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat))
@@ -1672,11 +1677,8 @@ static ide_startstop_t cdrom_newpc_intr(
 	 * using dma, transfer is complete now
 	 */
 	if (dma) {
-		if (dma_error) {
-			printk(KERN_ERR "ide-cd: dma error\n");
-			ide_dma_off(drive);
+		if (dma_error)
 			return ide_error(drive, "dma error", stat);
-		}
 
 		end_that_request_chunk(rq, 1, rq->data_len);
 		rq->data_len = 0;
