From: Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH 12/12] Ensure ide-taskfile calls any driver specific
	end_request function
Date: Sun, 05 Feb 2006 15:55:15 +0000
Message-ID: <1139154916.14624.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:48797 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751782AbWBEPzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Feb 2006 10:55:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Ensure ide-taskfile.c calls any driver specific end_request function
if present.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.15.orig/drivers/ide/ide-taskfile.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.15/drivers/ide/ide-taskfile.c	2006-02-04 14:02:23.000000000 +0000
@@ -372,7 +372,13 @@
 		}
 	}
 
-	ide_end_request(drive, 1, rq->hard_nr_sectors);
+	if (rq->rq_disk) {
+		ide_driver_t *drv;
+
+		drv = *(ide_driver_t **)rq->rq_disk->private_data;;
+		drv->end_request(drive, 1, rq->hard_nr_sectors);
+	} else
+		ide_end_request(drive, 1, rq->hard_nr_sectors);
 }
 
 /*


