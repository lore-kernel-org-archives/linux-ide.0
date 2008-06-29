From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 15/16] ide: remove unused PC_FLAG_DRQ_INTERRUPT
Date: Sun, 29 Jun 2008 12:59:18 +0200
Message-ID: <1214737159-1078-16-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:56736 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbYF2K7Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564672fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:15 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    3 +--
 include/linux/ide.h     |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 951768a..1136247 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -292,8 +292,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, struct ide_atapi_pc *pc,
 			   bcount, dma);
 
 	/* Issue the packet command */
-	if ((pc->flags & PC_FLAG_DRQ_INTERRUPT) ||
-	    (drive->dev_flags & IDE_FLAG_DRQ_INTERRUPT)) {
+	if (drive->dev_flags & IDE_FLAG_DRQ_INTERRUPT) {
 		ide_execute_command(drive, WIN_PACKETCMD, handler,
 				    timeout, NULL);
 		return ide_started;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 9ab55c5..70bfa8b 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -657,7 +657,6 @@ enum {
 	PC_FLAG_WRITING			= (1 << 6),
 	/* command timed out */
 	PC_FLAG_TIMEDOUT		= (1 << 7),
-	PC_FLAG_DRQ_INTERRUPT		= (1 << 8),
 };
 
 struct ide_atapi_pc {
-- 
1.5.5.4

