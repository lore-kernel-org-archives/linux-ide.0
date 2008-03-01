From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/24] ide-tape: remove idetape_pipeline_active()
Date: Sat,  1 Mar 2008 09:58:25 +0100
Message-ID: <1204361928-30229-2-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:64846 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbYCAI7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626785nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:18 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This function was simply a wrapper for a test_bit() macro so remove it and
use the macro instead.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 3f9fbd8..792c76e 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1605,14 +1605,6 @@ out:
 }
 
 /* Pipeline related functions */
-static inline int idetape_pipeline_active(idetape_tape_t *tape)
-{
-	int rc1, rc2;
-
-	rc1 = test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
-	rc2 = (tape->active_data_rq != NULL);
-	return rc1;
-}
 
 /*
  * The function below uses __get_free_page to allocate a pipeline stage, along
@@ -2058,7 +2050,7 @@ static int __idetape_discard_read_pipeline(ide_drive_t *drive)
 
 	spin_lock_irqsave(&tape->lock, flags);
 	tape->next_stage = NULL;
-	if (idetape_pipeline_active(tape))
+	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags))
 		idetape_wait_for_request(drive, tape->active_data_rq);
 	spin_unlock_irqrestore(&tape->lock, flags);
 
@@ -2131,7 +2123,7 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
 
 	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
 
-	if (idetape_pipeline_active(tape)) {
+	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 		printk(KERN_ERR "ide-tape: bug: the pipeline is active in %s\n",
 				__func__);
 		return (0);
@@ -2162,8 +2154,7 @@ static void idetape_plug_pipeline(ide_drive_t *drive)
 
 	if (tape->next_stage == NULL)
 		return;
-	if (!idetape_pipeline_active(tape)) {
-		set_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
+	if (!test_and_set_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 		idetape_activate_next_stage(drive);
 		(void) ide_do_drive_cmd(drive, tape->active_data_rq, ide_end);
 	}
@@ -2242,13 +2233,14 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 	/* Attempt to allocate a new stage. Beware possible race conditions. */
 	while ((new_stage = idetape_kmalloc_stage(tape)) == NULL) {
 		spin_lock_irqsave(&tape->lock, flags);
-		if (idetape_pipeline_active(tape)) {
+		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 			idetape_wait_for_request(drive, tape->active_data_rq);
 			spin_unlock_irqrestore(&tape->lock, flags);
 		} else {
 			spin_unlock_irqrestore(&tape->lock, flags);
 			idetape_plug_pipeline(drive);
-			if (idetape_pipeline_active(tape))
+			if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
+					&tape->flags))
 				continue;
 			/*
 			 * The machine is short on memory. Fallback to non-
@@ -2277,7 +2269,7 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 	 * starting to service requests, so that we will be able to keep up with
 	 * the higher speeds of the tape.
 	 */
-	if (!idetape_pipeline_active(tape)) {
+	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 		if (tape->nr_stages >= tape->max_stages * 9 / 10 ||
 			tape->nr_stages >= tape->max_stages -
 			tape->uncontrolled_pipeline_head_speed * 3 * 1024 /
@@ -2304,10 +2296,11 @@ static void idetape_wait_for_pipeline(ide_drive_t *drive)
 	idetape_tape_t *tape = drive->driver_data;
 	unsigned long flags;
 
-	while (tape->next_stage || idetape_pipeline_active(tape)) {
+	while (tape->next_stage || test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
+						&tape->flags)) {
 		idetape_plug_pipeline(drive);
 		spin_lock_irqsave(&tape->lock, flags);
-		if (idetape_pipeline_active(tape))
+		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags))
 			idetape_wait_for_request(drive, tape->active_data_rq);
 		spin_unlock_irqrestore(&tape->lock, flags);
 	}
@@ -2464,7 +2457,7 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
 			new_stage = idetape_kmalloc_stage(tape);
 		}
 	}
-	if (!idetape_pipeline_active(tape)) {
+	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 		if (tape->nr_pending_stages >= 3 * max_stages / 4) {
 			tape->measure_insert_time = 1;
 			tape->insert_time = jiffies;
-- 
1.5.4.1

