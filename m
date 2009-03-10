From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide-iops: only clear DMA words on setting DMA mode
Date: Tue, 10 Mar 2009 23:38:15 +0400
Message-ID: <200903102238.15619.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54692 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754801AbZCJThg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 15:37:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The bytes indicating current DMA mode in the identify data words 62, 63, and 88
should only change on setting a DMA mode, so stop clearing them  on setting PIO
mode in ide_config_drive_speed().  While at it, correct SW/MW DMA mode masks...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree...

 drivers/ide/ide-iops.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -774,9 +774,11 @@ int ide_config_drive_speed(ide_drive_t *
 		return error;
 	}
 
-	id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
-	id[ATA_ID_MWDMA_MODES] &= ~0x0F00;
-	id[ATA_ID_SWDMA_MODES] &= ~0x0F00;
+	if (speed >= XFER_SW_DMA_0) {
+		id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
+		id[ATA_ID_MWDMA_MODES] &= ~0x0700;
+		id[ATA_ID_SWDMA_MODES] &= ~0x0700;
+	}
 
  skip:
 #ifdef CONFIG_BLK_DEV_IDEDMA

