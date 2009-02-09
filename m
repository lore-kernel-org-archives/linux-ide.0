From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide: use ide_end_rq() in ide_complete_rq()
Date: Mon, 09 Feb 2009 21:01:43 +0100
Message-ID: <20090209200143.7985.44232.sendpatchset@localhost.localdomain>
References: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbZBIUAc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 15:00:32 -0500
In-Reply-To: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use ide_end_rq() in ide_complete_rq()

This results in PIO->DMA retry being triggered also on completion
of requests using ide_complete_rq() instead of ide_end_request().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -143,7 +143,7 @@ int ide_complete_rq(ide_drive_t *drive, 
 	struct request *rq = hwif->rq;
 	int rc;
 
-	rc = blk_end_request(rq, error, nr_bytes);
+	rc = ide_end_rq(drive, rq, error, nr_bytes);
 	if (rc == 0)
 		hwif->rq = NULL;
 
