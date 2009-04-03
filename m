From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] ide-cd: update debugging support
Date: Fri, 03 Apr 2009 21:58:04 +0200
Message-ID: <20090403195804.31438.26967.sendpatchset@localhost.localdomain>
References: <20090403195757.31438.16866.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:37371 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761519AbZDCTyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Apr 2009 15:54:22 -0400
In-Reply-To: <20090403195757.31438.16866.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Borislav Petkov <petkovbb@gmail.com>
Subject: [PATCH] ide-cd: update debugging support

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
[bart: extracted from "ide-cd: cleanup cdrom_decode_status" patch]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -317,8 +317,9 @@ static int cdrom_decode_status(ide_drive
 	err = ide_read_error(drive);
 	sense_key = err >> 4;
 
-	ide_debug_log(IDE_DBG_RQ, "cmd[0]: 0x%x, rq->cmd_type: 0x%x, err: 0x%x",
-				  rq->cmd[0], rq->cmd_type, err);
+	ide_debug_log(IDE_DBG_RQ, "cmd: 0x%x, rq->cmd_type: 0x%x, err: 0x%x, "
+				  "stat 0x%x",
+				  rq->cmd[0], rq->cmd_type, err, stat);
 
 	if (blk_sense_request(rq)) {
 		/*
@@ -636,8 +637,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	u16 len;
 	u8 ireason, stat;
 
-	ide_debug_log(IDE_DBG_PC, "cmd[0]: 0x%x, write: 0x%x",
-				  rq->cmd[0], write);
+	ide_debug_log(IDE_DBG_PC, "cmd: 0x%x, write: 0x%x", rq->cmd[0], write);
 
 	/* check for errors */
 	dma = drive->dma;
