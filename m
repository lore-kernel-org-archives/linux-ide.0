From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cris: always tune PIO
Date: Fri, 3 Aug 2007 00:45:53 +0200
Message-ID: <200708030045.53230.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:16177 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbXHBWsn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 18:48:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so172603nfb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 15:48:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>


Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -808,6 +808,8 @@ init_e100_ide (void)
 		hwif->dma_off_quietly = &cris_dma_off;
 		hwif->cbl = ATA_CBL_PATA40;
 		hwif->pio_mask = ATA_PIO4,
+		hwif->drives[0].autotune = 1;
+		hwif->drives[1].autotune = 1;
 		hwif->ultra_mask = cris_ultra_mask;
 		hwif->mwdma_mask = 0x07; /* Multiword DMA 0-2 */
 		hwif->autodma = 1;
