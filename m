From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 14/18] ide-floppy: fold idefloppy_create_test_unit_ready_cmd into idefloppy_open
Date: Thu, 12 Jun 2008 08:41:06 +0200
Message-ID: <1213252870-20474-15-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:9950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYFLGlK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381789fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:09 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There's no need for this function since it is used only once.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index ffebf83..615d3a3 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -569,13 +569,6 @@ static void idefloppy_create_start_stop_cmd(struct ide_atapi_pc *pc, int start,
 	cmd[4] = start;
 }
 
-static void idefloppy_create_test_unit_ready_cmd(struct ide_atapi_pc *pc,
-						 unsigned char *cmd)
-{
-	idefloppy_init_pc(pc, cmd);
-	cmd[0] = GPCMD_TEST_UNIT_READY;
-}
-
 static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
 				    struct ide_atapi_pc *pc, struct request *rq,
 				    unsigned long sector)
@@ -1161,7 +1154,9 @@ static int idefloppy_open(struct inode *inode, struct file *filp)
 		floppy->flags &= ~IDEFLOPPY_FLAG_FORMAT_IN_PROGRESS;
 		/* Just in case */
 
-		idefloppy_create_test_unit_ready_cmd(&pc, cmd);
+		idefloppy_init_pc(&pc, cmd);
+		cmd[0] = GPCMD_TEST_UNIT_READY;
+
 		if (idefloppy_queue_pc_tail(drive, &pc, cmd)) {
 			idefloppy_create_start_stop_cmd(&pc, 1, cmd);
 			(void) idefloppy_queue_pc_tail(drive, &pc, cmd);
-- 
1.5.5.1

