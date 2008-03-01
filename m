From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 07/24] ide-tape: remove pipeline-specific code bits from idetape_chrdev_read
Date: Sat,  1 Mar 2008 09:58:31 +0100
Message-ID: <1204361928-30229-8-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:6285 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668AbYCAI7Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so760736ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:25 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Also, simplify multiple-nested if construct.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index a54c1cb..99d6b29 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2278,7 +2278,7 @@ static void idetape_restart_speed_control(ide_drive_t *drive)
 		tape->uncontrolled_previous_head_time = jiffies;
 }
 
-static int idetape_init_read(ide_drive_t *drive, int max_stages)
+static int idetape_init_read(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct request rq;
@@ -2562,13 +2562,13 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 
 	debug_log(DBG_CHRDEV, "Enter %s, count %Zd\n", __func__, count);
 
-	if (tape->chrdev_dir != IDETAPE_DIR_READ) {
-		if (test_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags))
-			if (count > tape->blk_size &&
-			    (count % tape->blk_size) == 0)
-				tape->user_bs_factor = count / tape->blk_size;
-	}
-	rc = idetape_init_read(drive, tape->max_stages);
+	if (tape->chrdev_dir != IDETAPE_DIR_READ &&
+	    test_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags) &&
+	    count > tape->blk_size &&
+	    (count % tape->blk_size) == 0)
+		tape->user_bs_factor = count / tape->blk_size;
+
+	rc = idetape_init_read(drive);
 	if (rc < 0)
 		return rc;
 	if (count == 0)
-- 
1.5.4.1

