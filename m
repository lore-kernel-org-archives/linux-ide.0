From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/63] ide-cd: remove dead code from cdrom_pc_intr()
Date: Thu, 20 Dec 2007 02:05:51 +0100
Message-ID: <200712200205.51585.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11733 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116AbXLTBeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389248ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    7 -------
 1 file changed, 7 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1201,13 +1201,6 @@ static ide_startstop_t cdrom_pc_intr (id
 		if (rq->data_len == 0)
 			cdrom_end_request(drive, 1);
 		else {
-			/* Comment this out, because this always happens 
-			   right after a reset occurs, and it is annoying to 
-			   always print expected stuff.  */
-			/*
-			printk ("%s: cdrom_pc_intr: data underrun %d\n",
-				drive->name, pc->buflen);
-			*/
 			rq->cmd_flags |= REQ_FAILED;
 			cdrom_end_request(drive, 0);
 		}
