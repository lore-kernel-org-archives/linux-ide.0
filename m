From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/4] ide-tape: remove tape->cache_stage
Date: Sun,  9 Mar 2008 18:10:29 +0100
Message-ID: <1205082632-3418-2-git-send-email-petkovbb@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:8938 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbYCIRKm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 13:10:42 -0400
Received: by py-out-1112.google.com with SMTP id u52so2193487pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 10:10:41 -0700 (PDT)
In-Reply-To: <1205082632-3418-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Prior to allocating a new pipeline stage, the code checked for the existence of
a cached pipeline stage to use. Do away with and stick to normal pipeline
stages only.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   28 ++++------------------------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 792c76e..32ba6c8 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -365,8 +365,6 @@ typedef struct ide_tape_obj {
 	idetape_stage_t *next_stage;
 	/* New requests will be added to the pipeline here */
 	idetape_stage_t *last_stage;
-	/* Optional free stage which we can use */
-	idetape_stage_t *cache_stage;
 	int pages_per_stage;
 	/* Wasted space in each stage */
 	int excess_bh_size;
@@ -1684,21 +1682,6 @@ abort:
 	return NULL;
 }
 
-static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
-{
-	idetape_stage_t *cache_stage = tape->cache_stage;
-
-	debug_log(DBG_PROCS, "Enter %s\n", __func__);
-
-	if (tape->nr_stages >= tape->max_stages)
-		return NULL;
-	if (cache_stage != NULL) {
-		tape->cache_stage = NULL;
-		return cache_stage;
-	}
-	return __idetape_kmalloc_stage(tape, 0, 0);
-}
-
 static int idetape_copy_stage_from_user(idetape_tape_t *tape,
 		idetape_stage_t *stage, const char __user *buf, int n)
 {
@@ -2231,7 +2214,7 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
 
 	/* Attempt to allocate a new stage. Beware possible race conditions. */
-	while ((new_stage = idetape_kmalloc_stage(tape)) == NULL) {
+	while ((new_stage = __idetape_kmalloc_stage(tape, 0, 0)) == NULL) {
 		spin_lock_irqsave(&tape->lock, flags);
 		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
 			idetape_wait_for_request(drive, tape->active_data_rq);
@@ -2448,13 +2431,13 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
 	rq.current_nr_sectors = blocks;
 	if (!test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags) &&
 	    tape->nr_stages < max_stages) {
-		new_stage = idetape_kmalloc_stage(tape);
+		new_stage = __idetape_kmalloc_stage(tape, 0, 0);
 		while (new_stage != NULL) {
 			new_stage->rq = rq;
 			idetape_add_stage_tail(drive, new_stage);
 			if (tape->nr_stages >= max_stages)
 				break;
-			new_stage = idetape_kmalloc_stage(tape);
+			new_stage = __idetape_kmalloc_stage(tape, 0, 0);
 		}
 	}
 	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
@@ -3245,10 +3228,7 @@ static int idetape_chrdev_release(struct inode *inode, struct file *filp)
 		else
 			idetape_wait_for_pipeline(drive);
 	}
-	if (tape->cache_stage != NULL) {
-		__idetape_kfree_stage(tape->cache_stage);
-		tape->cache_stage = NULL;
-	}
+
 	if (minor < 128 && test_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_dir == IDETAPE_DIR_NONE) {
-- 
1.5.4.1

