From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] ide: remove BUG_ON() from ide_build_sglist()
Date: Thu, 27 Dec 2007 20:12:15 +0100
Message-ID: <20071227191215.1357.35247.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:6066 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbXL0TBX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692942ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:22 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

do_rw_taskfile() has been fixed to check the return value
of ->dma_setup method so this BUG_ON() is no longer needed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -186,8 +186,6 @@ int ide_build_sglist(ide_drive_t *drive,
 	ide_hwif_t *hwif = HWIF(drive);
 	struct scatterlist *sg = hwif->sg_table;
 
-	BUG_ON((rq->cmd_type == REQ_TYPE_ATA_TASKFILE) && rq->nr_sectors > 256);
-
 	ide_map_sg(drive, rq);
 
 	if (rq_data_dir(rq) == READ)
