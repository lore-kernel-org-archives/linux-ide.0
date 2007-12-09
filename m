From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/20] ide: use rq->nr_sectors in task_end_request()
Date: Sun, 9 Dec 2007 22:13:46 +0100
Message-ID: <200712092213.46144.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55848 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXLIVVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:21:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381313ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:59 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -424,9 +424,9 @@ static void task_end_request(ide_drive_t
 		ide_driver_t *drv;
 
 		drv = *(ide_driver_t **)rq->rq_disk->private_data;;
-		drv->end_request(drive, 1, rq->hard_nr_sectors);
+		drv->end_request(drive, 1, rq->nr_sectors);
 	} else
-		ide_end_request(drive, 1, rq->hard_nr_sectors);
+		ide_end_request(drive, 1, rq->nr_sectors);
 }
 
 /*
