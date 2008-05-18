From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/40] ide-scsi: fix handling of DMA errors in idescsi_pc_intr()
Date: Sun, 18 May 2008 20:54:54 +0200
Message-ID: <20080518185454.5636.48014.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756037AbYERSh3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:37:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:37:28 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Check return value of ->dma_end method and if there was a DMA error
handle it accordingly (set PC_FLAG_DMA_ERROR pc flag, don't update
pc->xferred and increase rq->errors).

Also move debug message in the right place while at it.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -388,11 +388,13 @@ static ide_startstop_t idescsi_pc_intr (
 		return ide_stopped;
 	}
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
+		if (hwif->dma_ops->dma_end(drive))
+			pc->flags |= PC_FLAG_DMA_ERROR;
+		else
+			pc->xferred = pc->req_xfer;
 #if IDESCSI_DEBUG_LOG
 		printk ("ide-scsi: %s: DMA complete\n", drive->name);
 #endif /* IDESCSI_DEBUG_LOG */
-		pc->xferred = pc->req_xfer;
-		(void)hwif->dma_ops->dma_end(drive);
 	}
 
 	/* Clear the interrupt */
@@ -405,7 +407,7 @@ static ide_startstop_t idescsi_pc_intr (
 					" transferred\n", pc->xferred);
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		local_irq_enable_in_hardirq();
-		if (stat & ERR_STAT)
+		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR))
 			rq->errors++;
 		idescsi_end_request (drive, 1, 0);
 		return ide_stopped;
