From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 08/17] ide-tape: remove pipeline-specific code from idetape_end_request()
Date: Mon, 17 Mar 2008 07:41:21 +0100
Message-ID: <1205736090-4435-9-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.239]:30077 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYCQGli (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:38 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301618hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:36 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

As a side effect, remove unused idetape_kfree_stage() and
idetape_abort_pipeline()

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   83 ------------------------------------------------
 1 files changed, 0 insertions(+), 83 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 7e0f4fa..3eeb5c0 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -686,37 +686,6 @@ static void __idetape_kfree_stage(idetape_stage_t *stage)
 	kfree(stage);
 }
 
-static void idetape_kfree_stage(idetape_tape_t *tape, idetape_stage_t *stage)
-{
-	__idetape_kfree_stage(stage);
-}
-
-/*
- * This will free all the pipeline stages starting from new_last_stage->next
- * to the end of the list, and point tape->last_stage to new_last_stage.
- */
-static void idetape_abort_pipeline(ide_drive_t *drive,
-				   idetape_stage_t *new_last_stage)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage = new_last_stage->next;
-	idetape_stage_t *nstage;
-
-	debug_log(DBG_PROCS, "%s: Enter %s\n", tape->name, __func__);
-
-	while (stage) {
-		nstage = stage->next;
-		idetape_kfree_stage(tape, stage);
-		--tape->nr_stages;
-		--tape->nr_pending_stages;
-		stage = nstage;
-	}
-	if (new_last_stage)
-		new_last_stage->next = NULL;
-	tape->last_stage = new_last_stage;
-	tape->next_stage = NULL;
-}
-
 /*
  * Finish servicing a request and insert a pending pipeline request into the
  * main device queue.
@@ -725,9 +694,7 @@ static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
 	int error;
-	idetape_stage_t *active_stage;
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
@@ -745,58 +712,8 @@ static int idetape_end_request(ide_drive_t *drive, int uptodate, int nr_sects)
 		return 0;
 	}
 
-	spin_lock_irqsave(&tape->lock, flags);
-
-	/* The request was a pipelined data transfer request */
-	if (tape->active_data_rq == rq) {
-		active_stage = tape->active_stage;
-		tape->active_stage = NULL;
-		tape->active_data_rq = NULL;
-		tape->nr_pending_stages--;
-		if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
-			if (error) {
-				set_bit(IDETAPE_FLAG_PIPELINE_ERR,
-					&tape->flags);
-				if (error == IDETAPE_ERROR_EOD)
-					idetape_abort_pipeline(drive,
-								active_stage);
-			}
-		} else if (rq->cmd[0] & REQ_IDETAPE_READ) {
-			if (error == IDETAPE_ERROR_EOD) {
-				set_bit(IDETAPE_FLAG_PIPELINE_ERR,
-					&tape->flags);
-				idetape_abort_pipeline(drive, active_stage);
-			}
-		}
-		if (tape->next_stage != NULL) {
-			idetape_activate_next_stage(drive);
-
-			/* Insert the next request into the request queue. */
-			(void)ide_do_drive_cmd(drive, tape->active_data_rq,
-						ide_end);
-		} else if (!error) {
-			/*
-			 * This is a part of the feedback loop which tries to
-			 * find the optimum number of stages. We are starting
-			 * from a minimum maximum number of stages, and if we
-			 * sense that the pipeline is empty, we try to increase
-			 * it, until we reach the user compile time memory
-			 * limit.
-			 */
-			int i = (tape->max_pipeline - tape->min_pipeline) / 10;
-
-			tape->max_stages += max(i, 1);
-			tape->max_stages = max(tape->max_stages,
-						tape->min_pipeline);
-			tape->max_stages = min(tape->max_stages,
-						tape->max_pipeline);
-		}
-	}
 	ide_end_drive_cmd(drive, 0, 0);
 
-	if (tape->active_data_rq == NULL)
-		clear_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
-	spin_unlock_irqrestore(&tape->lock, flags);
 	return 0;
 }
 
-- 
1.5.4.1

