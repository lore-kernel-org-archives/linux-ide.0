From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/18] ide: remove redundant ->ide_dma_on call from set_using_dma()
Date: Mon, 5 Nov 2007 00:33:19 +0100
Message-ID: <200711050033.19699.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbXKDX3r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:47 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ide_set_dma() calls ->ide_dma_on method itself and returns zero
only if ->ide_dma_on call succeeded.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -846,7 +846,7 @@ int set_using_dma(ide_drive_t *drive, in
 
 	if (arg) {
 		hwif->dma_off_quietly(drive);
-		if (ide_set_dma(drive) || hwif->ide_dma_on(drive))
+		if (ide_set_dma(drive))
 			err = -EIO;
 	} else
 		ide_dma_off(drive);
