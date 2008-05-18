From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/40] ide-tape: remove unneeded CONFIG_BLK_DEV_IDEDMA ifdef
Date: Sun, 18 May 2008 20:56:07 +0200
Message-ID: <20080518185607.5636.91889.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:17569 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbYERSim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:38:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473279fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:38:41 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

PC_FLAG_DMA_IN_PROGRESS flag is never set if DMA support is disabled.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -973,11 +973,11 @@ static ide_startstop_t idetape_transfer_
 	}
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
-#ifdef CONFIG_BLK_DEV_IDEDMA
+
 	/* Begin DMA, if necessary */
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS)
 		hwif->dma_ops->dma_start(drive);
-#endif
+
 	/* Send the actual packet */
 	hwif->output_data(drive, NULL, pc->c, 12);
 
