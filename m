From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 8/8] ide-atapi: start dma in a drive-specific way
Date: Thu, 18 Dec 2008 08:40:52 +0100
Message-ID: <1229586052-3542-9-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:51384 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYLRHlF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:05 -0500
Received: by bwz14 with SMTP id 14so1054101bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:41:03 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index f3dea66..5b92e0a 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -489,7 +489,7 @@ static int ide_delayed_transfer_pc(ide_drive_t *drive)
 
 static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 {
-	struct ide_atapi_pc *pc = drive->pc;
+	struct ide_atapi_pc *uninitialized_var(pc);
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->hwgroup->rq;
 	ide_expiry_t *expiry;
@@ -519,6 +519,8 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 		expiry  = ide_cd_expiry;
 
 	} else {
+		pc = drive->pc;
+
 		cmd_len = ATAPI_MIN_CDB_BYTES;
 
 		/*
@@ -551,9 +553,14 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 	ide_set_handler(drive, ide_pc_intr, timeout, expiry);
 
 	/* Begin DMA, if necessary */
-	if (pc->flags & PC_FLAG_DMA_OK) {
-		pc->flags |= PC_FLAG_DMA_IN_PROGRESS;
-		hwif->dma_ops->dma_start(drive);
+	if (dev_is_idecd(drive)) {
+		if (drive->dma)
+			hwif->dma_ops->dma_start(drive);
+	} else {
+		if (pc->flags & PC_FLAG_DMA_OK) {
+			pc->flags |= PC_FLAG_DMA_IN_PROGRESS;
+			hwif->dma_ops->dma_start(drive);
+		}
 	}
 
 	/* Send the actual packet */
-- 
1.6.0.4

