From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/15] ide-cd: fix register loading order in cdrom_start_packet_command()
Date: Wed, 31 Oct 2007 00:29:09 +0100
Message-ID: <200710310029.09936.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbXJ3Xu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788146nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Load IDE_CONTROL_REG before other registers in cdrom_start_packet_command().

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

While at it move misplaced FIXME comment in the right place.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -917,19 +917,19 @@ static ide_startstop_t cdrom_start_packe
 	if (ide_wait_stat(&startstop, drive, 0, BUSY_STAT, WAIT_READY))
 		return startstop;
 
+	/* FIXME: for Virtual DMA we must check harder */
 	if (info->dma)
 		info->dma = !hwif->dma_setup(drive);
 
 	/* Set up the controller registers. */
-	/* FIXME: for Virtual DMA we must check harder */
+	if (IDE_CONTROL_REG)
+		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 	HWIF(drive)->OUTB(info->dma, IDE_FEATURE_REG);
 	HWIF(drive)->OUTB(0, IDE_IREASON_REG);
 	HWIF(drive)->OUTB(0, IDE_SECTOR_REG);
 
 	HWIF(drive)->OUTB(xferlen & 0xff, IDE_BCOUNTL_REG);
 	HWIF(drive)->OUTB(xferlen >> 8  , IDE_BCOUNTH_REG);
-	if (IDE_CONTROL_REG)
-		HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
  
 	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
 		/* waiting for CDB interrupt, not DMA yet. */
