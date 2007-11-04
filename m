From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/18] ide: remove redundant DMA blacklist check from __ide_dma_on()
Date: Mon, 5 Nov 2007 00:34:44 +0100
Message-ID: <200711050034.44342.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbXKDX3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:49 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


->ide_dma_on method is called only after successful ide_dma_check() call
(ide_dma_check()->ide_tune_dma() checks DMA blacklist) or if drive->using_dma
has been previously enabled for a given device (->ide_dma_on is the only place
which sets drive->using_dma to '1').

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -490,10 +490,6 @@ EXPORT_SYMBOL(ide_dma_host_on);
  
 int __ide_dma_on (ide_drive_t *drive)
 {
-	/* consult the list of known "bad" drives */
-	if (__ide_dma_bad_drive(drive))
-		return 1;
-
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 
