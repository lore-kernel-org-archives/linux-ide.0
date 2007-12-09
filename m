From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/20] ide-tape: fix handling of non-special requests in ->end_request method
Date: Sun, 9 Dec 2007 22:11:14 +0100
Message-ID: <200712092211.14899.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55848 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbXLIVU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381313ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:56 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1690,6 +1690,11 @@ static int idetape_end_request(ide_drive
 	if (error)
 		tape->failed_pc = NULL;
 
+	if (!blk_special_request(rq)) {
+		ide_end_request(drive, uptodate, nr_sects);
+		return 0;
+	}
+
 	spin_lock_irqsave(&tape->spinlock, flags);
 
 	/* The request was a pipelined data transfer request */
