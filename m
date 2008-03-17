From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/17] ide-tape: remove unused parameter from idetape_copy_stage_to_user
Date: Mon, 17 Mar 2008 07:41:14 +0100
Message-ID: <1205736090-4435-2-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754582AbYCQGlr@vger.kernel.org>
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 86be926..b931547 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1619,7 +1619,7 @@ static int idetape_copy_stage_from_user(idetape_tape_t *tape,
 }
 
 static int idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf,
-		idetape_stage_t *stage, int n)
+				      int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2493,8 +2493,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size),
 				    (unsigned int)count);
-		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage,
-					       actually_read))
+		if (idetape_copy_stage_to_user(tape, buf, actually_read))
 			ret = -EFAULT;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
@@ -2504,8 +2503,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 		bytes_read = idetape_add_chrdev_read_request(drive, ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage,
-					       bytes_read))
+		if (idetape_copy_stage_to_user(tape, buf, bytes_read))
 			ret = -EFAULT;
 		buf += bytes_read;
 		count -= bytes_read;
@@ -2516,8 +2514,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 		if (bytes_read <= 0)
 			goto finish;
 		temp = min((unsigned long)count, (unsigned long)bytes_read);
-		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage,
-					       temp))
+		if (idetape_copy_stage_to_user(tape, buf, temp))
 			ret = -EFAULT;
 		actually_read += temp;
 		tape->merge_stage_size = bytes_read-temp;
-- 
1.5.4.1
