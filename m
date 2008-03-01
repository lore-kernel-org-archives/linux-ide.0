From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 06/24] ide-tape: remove unused stage-parameter from idetape_copy_stage_to_user
Date: Sat,  1 Mar 2008 09:58:30 +0100
Message-ID: <1204361928-30229-7-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:64814 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbYCAI72 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:28 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626786nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:27 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6bca29b..a54c1cb 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1717,7 +1717,7 @@ static int idetape_copy_stage_from_user(idetape_tape_t *tape,
 }
 
 static int idetape_copy_stage_to_user(idetape_tape_t *tape, char __user *buf,
-		idetape_stage_t *stage, int n)
+				      int n)
 {
 	struct idetape_bh *bh = tape->bh;
 	int count;
@@ -2576,8 +2576,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 	if (tape->merge_stage_size) {
 		actually_read = min((unsigned int)(tape->merge_stage_size),
 				    (unsigned int)count);
-		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage,
-					       actually_read))
+		if (idetape_copy_stage_to_user(tape, buf, actually_read))
 			ret = -EFAULT;
 		buf += actually_read;
 		tape->merge_stage_size -= actually_read;
@@ -2587,8 +2586,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
 		bytes_read = idetape_add_chrdev_read_request(drive, ctl);
 		if (bytes_read <= 0)
 			goto finish;
-		if (idetape_copy_stage_to_user(tape, buf, tape->merge_stage,
-					       bytes_read))
+		if (idetape_copy_stage_to_user(tape, buf, bytes_read))
 			ret = -EFAULT;
 		buf += bytes_read;
 		count -= bytes_read;
@@ -2599,8 +2597,7 @@ static ssize_t idetape_chrdev_read(struct file *file, char __user *buf,
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

