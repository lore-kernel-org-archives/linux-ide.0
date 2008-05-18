From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 30/40] ide: add PC_FLAG_DRQ_INTERRUPT pc flag
Date: Sun, 18 May 2008 20:58:57 +0200
Message-ID: <20080518185857.5636.65477.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:17984 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990AbYERSld (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:41:33 -0400
Received: by ik-out-1112.google.com with SMTP id c28so400939ika.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:41:32 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add PC_FLAG_DRQ_INTERRUPT pc flag, set it in ide*_do_request()
and check for it (instead of checking for IDE*_FLAG_DRQ_INTERRUPT)
in ide*_issue_pc().  This is a preparation for adding generic
ide_issue_pc() helper.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    5 ++++-
 drivers/ide/ide-tape.c   |   11 ++++++++---
 drivers/scsi/ide-scsi.c  |    6 +++++-
 include/linux/ide.h      |    1 +
 4 files changed, 18 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -619,7 +619,7 @@ static ide_startstop_t idefloppy_issue_p
 
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_DEVICE, bcount, dma);
 
-	if (floppy->flags & IDEFLOPPY_FLAG_DRQ_INTERRUPT) {
+	if (pc->flags & PC_FLAG_DRQ_INTERRUPT) {
 		/* Issue the packet command */
 		ide_execute_command(drive, WIN_PACKETCMD,
 				&idefloppy_transfer_pc1,
@@ -800,6 +800,9 @@ static ide_startstop_t idefloppy_do_requ
 		return ide_stopped;
 	}
 
+	if (floppy->flags & IDEFLOPPY_FLAG_DRQ_INTERRUPT)
+		pc->flags |= PC_FLAG_DRQ_INTERRUPT;
+
 	if (floppy->flags & IDEFLOPPY_FLAG_ZIP_DRIVE)
 		pc->flags |= PC_FLAG_ZIP_DRIVE;
 
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1020,7 +1020,7 @@ static ide_startstop_t idetape_issue_pc(
 
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_DEVICE, bcount, dma_ok);
 
-	if (test_bit(IDETAPE_FLAG_DRQ_INTERRUPT, &tape->flags)) {
+	if (pc->flags & PC_FLAG_DRQ_INTERRUPT) {
 		ide_execute_command(drive, WIN_PACKETCMD, &idetape_transfer_pc,
 				    IDETAPE_WAIT_CMD, NULL);
 		return ide_started;
@@ -1143,8 +1143,10 @@ static ide_startstop_t idetape_do_reques
 	}
 
 	/* Retry a failed packet command */
-	if (tape->failed_pc && tape->pc->c[0] == REQUEST_SENSE)
-		return idetape_issue_pc(drive, tape->failed_pc);
+	if (tape->failed_pc && tape->pc->c[0] == REQUEST_SENSE) {
+		pc = tape->failed_pc;
+		goto out;
+	}
 
 	if (postponed_rq != NULL)
 		if (rq != postponed_rq) {
@@ -1216,6 +1218,9 @@ static ide_startstop_t idetape_do_reques
 	}
 	BUG();
 out:
+	if (test_bit(IDETAPE_FLAG_DRQ_INTERRUPT, &tape->flags))
+		pc->flags |= PC_FLAG_DRQ_INTERRUPT;
+
 	return idetape_issue_pc(drive, pc);
 }
 
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -525,7 +525,7 @@ static ide_startstop_t idescsi_issue_pc(
 
 	ide_pktcmd_tf_load(drive, 0, bcount, dma);
 
-	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
+	if (pc->flags & PC_FLAG_DRQ_INTERRUPT) {
 		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc,
 				    get_timeout(pc), idescsi_expiry);
 		return ide_started;
@@ -548,6 +548,10 @@ static ide_startstop_t idescsi_do_reques
 
 	if (blk_sense_request(rq) || blk_special_request(rq)) {
 		struct ide_atapi_pc *pc = (struct ide_atapi_pc *)rq->special;
+		idescsi_scsi_t *scsi = drive_to_idescsi(drive);
+
+		if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags))
+			pc->flags |= PC_FLAG_DRQ_INTERRUPT;
 
 		if (drive->using_dma && !idescsi_map_sg(drive, pc))
 			pc->flags |= PC_FLAG_DMA_OK;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -593,6 +593,7 @@ enum {
 	/* command timed out */
 	PC_FLAG_TIMEDOUT		= (1 << 7),
 	PC_FLAG_ZIP_DRIVE		= (1 << 8),
+	PC_FLAG_DRQ_INTERRUPT		= (1 << 9),
 };
 
 struct ide_atapi_pc {
