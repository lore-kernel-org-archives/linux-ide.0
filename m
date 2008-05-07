From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: remove commented out code from ide_config_drive_speed()
Date: Wed, 7 May 2008 19:40:46 +0200
Message-ID: <200805071940.46190.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:24614 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbYEGR3G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 13:29:06 -0400
Received: by nf-out-0910.google.com with SMTP id d3so225821nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 10:29:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -739,9 +739,6 @@ int ide_config_drive_speed(ide_drive_t *
 	int error = 0;
 	u8 stat;
 
-//	while (HWGROUP(drive)->busy)
-//		msleep(50);
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_ops)	/* check if host supports DMA */
 		hwif->dma_ops->dma_host_set(drive, 0);
