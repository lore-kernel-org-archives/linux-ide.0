From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] trm290: trm290_dma_setup() fix
Date: Sun, 1 Feb 2009 20:14:32 +0100
Message-ID: <200902012014.33037.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:63098 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZBATPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 14:15:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Re-map sg table if necessary (not that it really matters since
DMA support is disabled currently).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
we should consider removing the driver (or at least DMA support)...

 drivers/ide/trm290.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/trm290.c
===================================================================
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -198,6 +198,7 @@ static int trm290_dma_setup(ide_drive_t 
 		rw = 2;
 
 	if (!(count = ide_build_dmatable(drive, rq))) {
+		ide_map_sg(drive, rq);
 		/* try PIO instead of DMA */
 		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;
