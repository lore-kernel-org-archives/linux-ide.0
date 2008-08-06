From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/2] ide-tape: remove idetape_init_rq()
Date: Wed, 6 Aug 2008 19:13:20 +0200
Message-ID: <200808061913.21467.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:23883 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbYHFRR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 13:17:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so9830fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 10:17:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

idetape_init_rq() is only used in idetape_queue_pc_head()
so inline it there.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -689,13 +689,6 @@ static void idetape_create_request_sense
 	pc->req_xfer = 20;
 }
 
-static void idetape_init_rq(struct request *rq, u8 cmd)
-{
-	blk_rq_init(NULL, rq);
-	rq->cmd_type = REQ_TYPE_SPECIAL;
-	rq->cmd[13] = cmd;
-}
-
 /*
  * Generate a new packet command request in front of the request queue, before
  * the current request, so that it will be processed immediately, on the next
@@ -716,11 +709,13 @@ static void idetape_queue_pc_head(ide_dr
 {
 	struct ide_tape_obj *tape = drive->driver_data;
 
-	idetape_init_rq(rq, REQ_IDETAPE_PC1);
+	blk_rq_init(NULL, rq);
+	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_flags |= REQ_PREEMPT;
 	rq->buffer = (char *) pc;
 	rq->rq_disk = tape->disk;
 	memcpy(rq->cmd, pc->c, 12);
+	rq->cmd[13] = REQ_IDETAPE_PC1;
 	ide_do_drive_cmd(drive, rq);
 }
 
