From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 21/40] ide-{floppy,tape}: PC_FLAG_DMA_RECOMMENDED -> PC_FLAG_DMA_OK
Date: Sun, 18 May 2008 20:57:36 +0200
Message-ID: <20080518185736.5636.47960.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:28172 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087AbYERSkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:40:11 -0400
Received: by mu-out-0910.google.com with SMTP id w8so773343mue.1
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:40:10 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Use PC_FLAG_DMA_OK flag instead of PC_FLAG_DMA_RECOMMENDED one.

* Remove no longer used PC_FLAG_DMA_RECOMMENDED flag.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    6 +++---
 drivers/ide/ide-tape.c   |    6 +++---
 include/linux/ide.h      |    9 ++++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -630,7 +630,7 @@ static ide_startstop_t idefloppy_issue_p
 	}
 	dma = 0;
 
-	if ((pc->flags & PC_FLAG_DMA_RECOMMENDED) && drive->using_dma)
+	if ((pc->flags & PC_FLAG_DMA_OK) && drive->using_dma)
 		dma = !hwif->dma_ops->dma_setup(drive);
 
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_DEVICE, bcount, dma);
@@ -755,7 +755,7 @@ static void idefloppy_create_rw_cmd(idef
 		pc->flags |= PC_FLAG_WRITING;
 	pc->buf = NULL;
 	pc->req_xfer = pc->buf_size = blocks * floppy->block_size;
-	pc->flags |= PC_FLAG_DMA_RECOMMENDED;
+	pc->flags |= PC_FLAG_DMA_OK;
 }
 
 static void idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy,
@@ -769,7 +769,7 @@ static void idefloppy_blockpc_cmd(ideflo
 		pc->flags |= PC_FLAG_WRITING;
 	pc->buf = rq->data;
 	if (rq->bio)
-		pc->flags |= PC_FLAG_DMA_RECOMMENDED;
+		pc->flags |= PC_FLAG_DMA_OK;
 	/*
 	 * possibly problematic, doesn't look like ide-floppy correctly
 	 * handled scattered requests if dma fails...
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1050,7 +1050,7 @@ static ide_startstop_t idetape_issue_pc(
 		pc->flags &= ~PC_FLAG_DMA_ERROR;
 		ide_dma_off(drive);
 	}
-	if ((pc->flags & PC_FLAG_DMA_RECOMMENDED) && drive->using_dma)
+	if ((pc->flags & PC_FLAG_DMA_OK) && drive->using_dma)
 		dma_ok = !hwif->dma_ops->dma_setup(drive);
 
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_DEVICE, bcount, dma_ok);
@@ -1138,7 +1138,7 @@ static void idetape_create_read_cmd(idet
 	pc->buf_size = length * tape->blk_size;
 	pc->req_xfer = pc->buf_size;
 	if (pc->req_xfer == tape->buffer_size)
-		pc->flags |= PC_FLAG_DMA_RECOMMENDED;
+		pc->flags |= PC_FLAG_DMA_OK;
 }
 
 static void idetape_create_write_cmd(idetape_tape_t *tape,
@@ -1157,7 +1157,7 @@ static void idetape_create_write_cmd(ide
 	pc->buf_size = length * tape->blk_size;
 	pc->req_xfer = pc->buf_size;
 	if (pc->req_xfer == tape->buffer_size)
-		pc->flags |= PC_FLAG_DMA_RECOMMENDED;
+		pc->flags |= PC_FLAG_DMA_OK;
 }
 
 static ide_startstop_t idetape_do_request(ide_drive_t *drive,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -587,12 +587,11 @@ enum {
 	PC_FLAG_SUPPRESS_ERROR		= (1 << 1),
 	PC_FLAG_WAIT_FOR_DSC		= (1 << 2),
 	PC_FLAG_DMA_OK			= (1 << 3),
-	PC_FLAG_DMA_RECOMMENDED		= (1 << 4),
-	PC_FLAG_DMA_IN_PROGRESS		= (1 << 5),
-	PC_FLAG_DMA_ERROR		= (1 << 6),
-	PC_FLAG_WRITING			= (1 << 7),
+	PC_FLAG_DMA_IN_PROGRESS		= (1 << 4),
+	PC_FLAG_DMA_ERROR		= (1 << 5),
+	PC_FLAG_WRITING			= (1 << 6),
 	/* command timed out */
-	PC_FLAG_TIMEDOUT		= (1 << 8),
+	PC_FLAG_TIMEDOUT		= (1 << 7),
 };
 
 struct ide_atapi_pc {
