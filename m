From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] ide-{floppy,tape,scsi}: fix register loading order when issuing packet command
Date: Wed, 31 Oct 2007 00:29:43 +0100
Message-ID: <200710310029.43301.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:46854 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbXJ3Xu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:27 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788152nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Load IDE_BCOUNTL_REG before IDE_BCOUNTH_REG when issuing packet command.

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-tape.c   |    2 +-
 drivers/scsi/ide-scsi.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1071,8 +1071,8 @@ static ide_startstop_t idefloppy_issue_p
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 	/* Use PIO/DMA */
 	hwif->OUTB(dma, IDE_FEATURE_REG);
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
 
 	if (dma) {	/* Begin DMA, if necessary */
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2174,8 +2174,8 @@ static ide_startstop_t idetape_issue_pac
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	hwif->OUTB(dma_ok ? 1 : 0, IDE_FEATURE_REG);	/* Use PIO/DMA */
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 	if (dma_ok)			/* Will begin DMA later */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -599,8 +599,8 @@ static ide_startstop_t idescsi_issue_pc 
 		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 
 	hwif->OUTB(dma, IDE_FEATURE_REG);
-	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 	hwif->OUTB(bcount & 0xff, IDE_BCOUNTL_REG);
+	hwif->OUTB((bcount >> 8) & 0xff, IDE_BCOUNTH_REG);
 
 	if (dma)
 		set_bit(PC_DMA_OK, &pc->flags);
