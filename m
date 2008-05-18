From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 39/40] ide-{floppy,scsi}: read Status Register before stopping DMA engine
Date: Sun, 18 May 2008 21:00:18 +0200
Message-ID: <20080518190018.5636.29447.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677AbYERSmy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:42:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:42:53 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Read Status Register before stopping DMA engine to match ide-tape
device driver - it should be safe and shouldn't affect anything.

This is a preparation for adding generic ide_pc_intr() helper.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    6 +++---
 drivers/scsi/ide-scsi.c  |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -399,6 +399,9 @@ static ide_startstop_t idefloppy_pc_intr
 
 	debug_log("Enter %s - interrupt handler\n", __func__);
 
+	/* Clear the interrupt */
+	stat = ide_read_status(drive);
+
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
 		dma_error = hwif->dma_ops->dma_end(drive);
 		if (dma_error) {
@@ -412,9 +415,6 @@ static ide_startstop_t idefloppy_pc_intr
 		debug_log("%s: DMA finished\n", drive->name);
 	}
 
-	/* Clear the interrupt */
-	stat = ide_read_status(drive);
-
 	/* No more interrupts */
 	if ((stat & DRQ_STAT) == 0) {
 		debug_log("Packet command completed, %d bytes transferred\n",
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -370,6 +370,10 @@ static ide_startstop_t idescsi_pc_intr (
 		pc->callback(drive);
 		return ide_stopped;
 	}
+
+	/* Clear the interrupt */
+	stat = ide_read_status(drive);
+
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
 		if (hwif->dma_ops->dma_end(drive))
 			pc->flags |= PC_FLAG_DMA_ERROR;
@@ -378,9 +382,6 @@ static ide_startstop_t idescsi_pc_intr (
 		debug_log("%s: DMA finished\n", drive->name);
 	}
 
-	/* Clear the interrupt */
-	stat = ide_read_status(drive);
-
 	if ((stat & DRQ_STAT) == 0) {
 		/* No more interrupts */
 		debug_log("Packet command completed, %d bytes transferred\n",
