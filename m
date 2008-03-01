From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 17/24] ide-tape: remove pipeline-specific code from idetape_chrdev_open
Date: Sat,  1 Mar 2008 09:58:41 +0100
Message-ID: <1204361928-30229-18-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:64772 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627AbYCAI7d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626781nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:32 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

As a result, remove orphaned idetape_restart_speed_control. Also, unnest
if-condition in idetape_chrdev_open.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   38 ++++++--------------------------------
 1 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index cfc11bb..5f57bdb 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -424,7 +424,6 @@ typedef struct ide_tape_obj {
 	int uncontrolled_previous_pipeline_head;
 	unsigned long controlled_previous_head_time;
 	unsigned long uncontrolled_previous_head_time;
-	int restart_speed_control_req;
 
 	u32 debug_mask;
 } idetape_tape_t;
@@ -1838,24 +1837,6 @@ static int idetape_add_chrdev_write_request(ide_drive_t *drive, int blocks)
 					tape->merge_stage->bh);
 }
 
-static void idetape_restart_speed_control(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	tape->restart_speed_control_req = 0;
-	tape->pipeline_head = 0;
-	tape->controlled_last_pipeline_head = 0;
-	tape->controlled_previous_pipeline_head = 0;
-	tape->uncontrolled_previous_pipeline_head = 0;
-	tape->controlled_pipeline_head_speed = 5000;
-	tape->pipeline_head_speed = 5000;
-	tape->uncontrolled_pipeline_head_speed = 0;
-	tape->controlled_pipeline_head_time =
-		tape->uncontrolled_pipeline_head_time = jiffies;
-	tape->controlled_previous_head_time =
-		tape->uncontrolled_previous_head_time = jiffies;
-}
-
 static int idetape_init_read(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
@@ -2470,9 +2451,6 @@ static int idetape_chrdev_open(struct inode *inode, struct file *filp)
 	if (!test_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags))
 		(void)idetape_rewind_tape(drive);
 
-	if (tape->chrdev_dir != IDETAPE_DIR_READ)
-		clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
-
 	/* Read block size and write protect status from drive. */
 	ide_tape_get_bsize_from_bdesc(drive);
 
@@ -2493,16 +2471,12 @@ static int idetape_chrdev_open(struct inode *inode, struct file *filp)
 	}
 
 	/* Lock the tape drive door so user can't eject. */
-	if (tape->chrdev_dir == IDETAPE_DIR_NONE) {
-		if (idetape_create_prevent_cmd(drive, &pc, 1)) {
-			if (!idetape_queue_pc_tail(drive, &pc)) {
-				if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
-					tape->door_locked = DOOR_LOCKED;
-			}
-		}
-	}
-	idetape_restart_speed_control(drive);
-	tape->restart_speed_control_req = 0;
+	if (tape->chrdev_dir == IDETAPE_DIR_NONE &&
+	    idetape_create_prevent_cmd(drive, &pc, 1) &&
+	    !idetape_queue_pc_tail(drive, &pc) &&
+	    tape->door_locked != DOOR_EXPLICITLY_LOCKED)
+		tape->door_locked = DOOR_LOCKED;
+
 	return 0;
 
 out_put_tape:
-- 
1.5.4.1

