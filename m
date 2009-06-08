From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: unexport ide_find_dma_mode()
Date: Mon, 8 Jun 2009 22:24:03 +0200
Message-ID: <200906082224.03566.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58691 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZFHUdM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2009 16:33:12 -0400
Received: by ewy6 with SMTP id 6so4502475ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2009 13:33:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against ide-2.6.git/for-next

 drivers/ide/ide-dma.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -347,7 +347,6 @@ u8 ide_find_dma_mode(ide_drive_t *drive,
 
 	return mode;
 }
-EXPORT_SYMBOL_GPL(ide_find_dma_mode);
 
 static int ide_tune_dma(ide_drive_t *drive)
 {
