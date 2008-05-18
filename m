From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/40] ide-scsi: fix race in idescsi_transfer_pc()
Date: Sun, 18 May 2008 20:54:36 +0200
Message-ID: <20080518185436.5636.19817.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbYERShO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:37:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:37:10 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Start DMA engine before sending content of packet command (otherwise
it is possible that IRQ will happen before DMA engine is started).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -494,13 +494,14 @@ static ide_startstop_t idescsi_transfer_
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 
-	/* Send the actual packet */
-	hwif->output_data(drive, NULL, scsi->pc->c, 12);
-
 	if (pc->flags & PC_FLAG_DMA_OK) {
 		pc->flags |= PC_FLAG_DMA_IN_PROGRESS;
 		hwif->dma_ops->dma_start(drive);
 	}
+
+	/* Send the actual packet */
+	hwif->output_data(drive, NULL, scsi->pc->c, 12);
+
 	return ide_started;
 }
 
