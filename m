From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/6] ide-tape: make __idetape_discard_read_pipeline() of type void
Date: Mon,  7 Apr 2008 06:44:59 +0200
Message-ID: <1207543504-27888-2-git-send-email-petkovbb@gmail.com>
References: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:36969 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYDGEot (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 00:44:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1273831fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 06 Apr 2008 21:44:46 -0700 (PDT)
In-Reply-To: <1207543504-27888-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

It always returns 0 which has no effect on tape positioning calculation so
simplify it by converting its type to void, bringing no functional change to the
driver.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 970f25f..0cd0684 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1641,12 +1641,12 @@ static int idetape_create_prevent_cmd(ide_drive_t *drive,
 	return 1;
 }
 
-static int __idetape_discard_read_pipeline(ide_drive_t *drive)
+static void __idetape_discard_read_pipeline(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 
 	if (tape->chrdev_dir != IDETAPE_DIR_READ)
-		return 0;
+		return;
 
 	clear_bit(IDETAPE_FLAG_FILEMARK, &tape->flags);
 	tape->merge_stage_size = 0;
@@ -1656,8 +1656,6 @@ static int __idetape_discard_read_pipeline(ide_drive_t *drive)
 	}
 
 	tape->chrdev_dir = IDETAPE_DIR_NONE;
-
-	return 0;
 }
 
 /*
@@ -1689,13 +1687,12 @@ static void idetape_discard_read_pipeline(ide_drive_t *drive,
 					  int restore_position)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	int cnt;
 	int seek, position;
 
-	cnt = __idetape_discard_read_pipeline(drive);
+	__idetape_discard_read_pipeline(drive);
 	if (restore_position) {
 		position = idetape_read_position(drive);
-		seek = position > cnt ? position - cnt : 0;
+		seek = position > 0 ? position : 0;
 		if (idetape_position_tape(drive, seek, 0, 0)) {
 			printk(KERN_INFO "ide-tape: %s: position_tape failed in"
 					 " discard_pipeline()\n", tape->name);
-- 
1.5.4.1

