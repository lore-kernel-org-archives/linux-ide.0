From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] unexport ide_dma_on
Date: Tue, 29 Jan 2008 00:08:44 +0200
Message-ID: <20080128220844.GG8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:52117 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492AbYA1WIS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 17:08:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

ide_dma_on can be unexported.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
38b0717b827649511b15fbef6f98c891eda835ff 
diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 5bf3203..15f8c6a 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -474,8 +474,6 @@ void ide_dma_on(ide_drive_t *drive)
 	drive->hwif->dma_host_set(drive, 1);
 }
 
-EXPORT_SYMBOL(ide_dma_on);
-
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_setup	-	begin a DMA phase

