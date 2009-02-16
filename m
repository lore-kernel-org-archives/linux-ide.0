From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/20] ide-cd: move setting REQ_FAILED flag out from 'end_request' exit path
Date: Mon, 16 Feb 2009 01:14:15 +0100
Message-ID: <20090216001415.27491.73711.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:51372 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbZBPAMt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:12:49 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: move setting REQ_FAILED flag out from 'end_request' exit path

Move setting REQ_FAILED flag out from 'end_request' exit path in
cdrom_newpc_intr() and also rename 'end_request' to 'out_end'.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -771,7 +771,9 @@ static ide_startstop_t cdrom_newpc_intr(
 			ide_complete_rq(drive, 0, 512);
 			return ide_stopped;
 		}
-		goto end_request;
+		if (blk_pc_request(rq) == 0 && uptodate == 0)
+			rq->cmd_flags |= REQ_FAILED;
+		goto out_end;
 	}
 
 	ide_read_bcount_and_ireason(drive, &len, &ireason);
@@ -806,8 +808,10 @@ static ide_startstop_t cdrom_newpc_intr(
 			ide_cd_request_sense_fixup(drive, rq);
 			/* complain if we still have data left to transfer */
 			uptodate = rq->data_len ? 0 : 1;
+			if (uptodate == 0)
+				rq->cmd_flags |= REQ_FAILED;
 		}
-		goto end_request;
+		goto out_end;
 	}
 
 	/* check which way to transfer data */
@@ -934,7 +938,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	ide_set_handler(drive, cdrom_newpc_intr, timeout);
 	return ide_started;
 
-end_request:
+out_end:
 	if (blk_pc_request(rq)) {
 		unsigned int dlen = rq->data_len;
 
@@ -946,8 +950,6 @@ end_request:
 
 		hwif->rq = NULL;
 	} else {
-		if (!uptodate)
-			rq->cmd_flags |= REQ_FAILED;
 		cdrom_end_request(drive, uptodate);
 	}
 	return ide_stopped;
