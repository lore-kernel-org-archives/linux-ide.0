From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] au1xxx-ide: auide_dma_end() cleanup
Date: Sun, 1 Feb 2009 20:15:29 +0100
Message-ID: <200902012015.29284.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f12.google.com ([209.85.218.12]:60208 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZBATPF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 14:15:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

No need to check / clear hwif->sg_nents.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/au1xxx-ide.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: b/drivers/ide/au1xxx-ide.c
===================================================================
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -286,12 +286,7 @@ static int auide_build_dmatable(ide_driv
 
 static int auide_dma_end(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
-
-	if (hwif->sg_nents) {
-		ide_destroy_dmatable(drive);
-		hwif->sg_nents = 0;
-	}
+	ide_destroy_dmatable(drive);
 
 	return 0;
 }
