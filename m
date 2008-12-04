From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 4/6] ide-atapi: setup dma for ide-cd
Date: Thu,  4 Dec 2008 07:43:27 +0100
Message-ID: <1228373010-20249-5-git-send-email-petkovbb@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:46550 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbYLDGni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 01:43:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2725977fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 22:43:36 -0800 (PST)
In-Reply-To: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 7162317..8884877 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -588,8 +588,9 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 		ide_dma_off(drive);
 	}
 
-	if ((pc->flags & PC_FLAG_DMA_OK) &&
-	    (drive->dev_flags & IDE_DFLAG_USING_DMA)) {
+	if (((pc->flags & PC_FLAG_DMA_OK) &&
+		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
+	    drive->dma) {
 		if (scsi)
 			hwif->sg_mapped = 1;
 		drive->dma = !hwif->dma_ops->dma_setup(drive);
-- 
1.6.0.4

