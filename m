From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 7/9] ide-atapi: use rq pointer directly instead of pc->rq deref
Date: Tue, 16 Dec 2008 08:36:07 +0100
Message-ID: <1229412969-3552-8-git-send-email-petkovbb@gmail.com>
References: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:33630 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYLPHgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 02:36:18 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so3324991bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2008 23:36:17 -0800 (PST)
In-Reply-To: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 89ce8f0..e514b47 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -332,7 +332,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		    (drive->media == ide_tape && (stat & ATA_ERR))) {
 			if (drive->media == ide_floppy)
 				printk(KERN_ERR "%s: DMA %s error\n",
-					drive->name, rq_data_dir(pc->rq)
+					drive->name, rq_data_dir(rq)
 						     ? "write" : "read");
 			drive->pc_flags |= PC_FLAG_DMA_ERROR;
 		} else {
@@ -361,7 +361,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 			debug_log("%s: I/O error\n", drive->name);
 
 			if (drive->media != ide_tape)
-				pc->rq->errors++;
+				rq->errors++;
 
 			if (rq->cmd[0] == REQUEST_SENSE) {
 				printk(KERN_ERR "%s: I/O error in request sense"
-- 
1.6.0.4

