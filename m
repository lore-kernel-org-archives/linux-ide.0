From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 04/24] ide-tape: remove pipeline-specific code from idetape_chrdev_write
Date: Sat,  1 Mar 2008 09:58:28 +0100
Message-ID: <1204361928-30229-5-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:65331 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbYCAI7U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:20 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626833nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:18 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Also, remove unused stage-parameter from idetape_copy_stage_from_user()

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index e919d41..4a064c1 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1700,7 +1700,7 @@ static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
 }
 
 static int idetape_copy_stage_from_user(idetape_tape_t *tape,
-		idetape_stage_t *stage, const char __user *buf, int n)
+					const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2696,8 +2696,6 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 
 	/* Initialize write operation */
 	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
-		if (tape->chrdev_dir == IDETAPE_DIR_READ)
-			idetape_discard_read_pipeline(drive, 1);
 		if (tape->merge_stage || tape->merge_stage_size) {
 			printk(KERN_ERR "ide-tape: merge_stage_size "
 				"should be 0 now\n");
@@ -2729,8 +2727,6 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	}
 	if (count == 0)
 		return (0);
-	if (tape->restart_speed_control_req)
-		idetape_restart_speed_control(drive);
 	if (tape->merge_stage_size) {
 		if (tape->merge_stage_size >= tape->stage_size) {
 			printk(KERN_ERR "ide-tape: bug: merge buf too big\n");
@@ -2739,8 +2735,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 		actually_written = min((unsigned int)
 				(tape->stage_size - tape->merge_stage_size),
 				(unsigned int)count);
-		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf,
-						 actually_written))
+		if (idetape_copy_stage_from_user(tape, buf, actually_written))
 				ret = -EFAULT;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
@@ -2756,8 +2751,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	}
 	while (count >= tape->stage_size) {
 		ssize_t retval;
-		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf,
-						 tape->stage_size))
+		if (idetape_copy_stage_from_user(tape, buf, tape->stage_size))
 			ret = -EFAULT;
 		buf += tape->stage_size;
 		count -= tape->stage_size;
@@ -2768,8 +2762,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	}
 	if (count) {
 		actually_written += count;
-		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf,
-						 count))
+		if (idetape_copy_stage_from_user(tape, buf, count))
 			ret = -EFAULT;
 		tape->merge_stage_size += count;
 	}
-- 
1.5.4.1

