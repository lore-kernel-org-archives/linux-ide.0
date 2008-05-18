From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/40] ide-tape: remove stale comments from idetape_pc_intr()
Date: Sun, 18 May 2008 20:56:16 +0200
Message-ID: <20080518185616.5636.22797.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbYERSiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:38:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:50 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   21 ---------------------
 1 file changed, 21 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -758,27 +758,6 @@ static ide_startstop_t idetape_pc_intr(i
 
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
 		if (hwif->dma_ops->dma_end(drive) || (stat & ERR_STAT)) {
-			/*
-			 * A DMA error is sometimes expected. For example,
-			 * if the tape is crossing a filemark during a
-			 * READ command, it will issue an irq and position
-			 * itself before the filemark, so that only a partial
-			 * data transfer will occur (which causes the DMA
-			 * error). In that case, we will later ask the tape
-			 * how much bytes of the original request were
-			 * actually transferred (we can't receive that
-			 * information from the DMA engine on most chipsets).
-			 */
-
-			/*
-			 * On the contrary, a DMA error is never expected;
-			 * it usually indicates a hardware error or abort.
-			 * If the tape crosses a filemark during a READ
-			 * command, it will issue an irq and position itself
-			 * after the filemark (not before). Only a partial
-			 * data transfer will occur, but no DMA error.
-			 * (AS, 19 Apr 2001)
-			 */
 			pc->flags |= PC_FLAG_DMA_ERROR;
 		} else {
 			pc->xferred = pc->req_xfer;
