From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 02/17] ide-tape: remove unused parameter from idetape_copy_stage_from_user
Date: Mon, 17 Mar 2008 07:41:15 +0100
Message-ID: <1205736090-4435-3-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.232]:29797 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYCQGlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:32 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301577hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:30 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b931547..241f596 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1587,7 +1587,7 @@ abort:
 }
 
 static int idetape_copy_stage_from_user(idetape_tape_t *tape,
-		idetape_stage_t *stage, const char __user *buf, int n)
+					const char __user *buf, int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2588,8 +2588,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 		actually_written = min((unsigned int)
 				(tape->stage_size - tape->merge_stage_size),
 				(unsigned int)count);
-		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf,
-						 actually_written))
+		if (idetape_copy_stage_from_user(tape, buf, actually_written))
 				ret = -EFAULT;
 		buf += actually_written;
 		tape->merge_stage_size += actually_written;
@@ -2605,8 +2604,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
 	}
 	while (count >= tape->stage_size) {
 		ssize_t retval;
-		if (idetape_copy_stage_from_user(tape, tape->merge_stage, buf,
-						 tape->stage_size))
+		if (idetape_copy_stage_from_user(tape, buf, tape->stage_size))
 			ret = -EFAULT;
 		buf += tape->stage_size;
 		count -= tape->stage_size;
@@ -2617,8 +2615,7 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
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

