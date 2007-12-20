From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 57/63] ide-cd: unify moving to the next buffer in cdrom_rw_intr()
Date: Thu, 20 Dec 2007 02:35:59 +0100
Message-ID: <200712200235.59108.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237AbXLTBfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:35:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389244ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:35:01 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Use the fact that for the first loop rq->current_nr_sectors is always
set and unify moving to the next buffer for read/write requests.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-46 bytes
 drivers/ide/ide-cd.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1287,13 +1287,6 @@ static ide_startstop_t cdrom_rw_intr(ide
 	while (sectors_to_transfer > 0) {
 		int this_transfer;
 
-		/*
-		 * If we've filled the present buffer but there's another
-		 * chained buffer after it, move on.
-		 */
-		if (!write && rq->current_nr_sectors == 0 && rq->nr_sectors)
-			cdrom_end_request(drive, 1);
-
 		if (!rq->current_nr_sectors) {
 			if (!write)
 				/*
@@ -1327,7 +1320,7 @@ static ide_startstop_t cdrom_rw_intr(ide
 		/*
 		 * current buffer complete, move on
 		 */
-		if (write && rq->current_nr_sectors == 0 && rq->nr_sectors)
+		if (rq->current_nr_sectors == 0 && rq->nr_sectors)
 			cdrom_end_request(drive, 1);
 	}
 
