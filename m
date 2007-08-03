From: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: RE: [PATCH] ide-cris: always tune PIO
Date: Fri, 3 Aug 2007 09:43:46 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66804C3FE3C@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66804C43F82@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:41673 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbXHCIOu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 04:14:50 -0400
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66804C43F82@exmail1.se.axis.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, linux-ide@vger.kernel.org
Cc: Mikael Starvik <mikael.starvik@axis.com>

Yes, thanks!

Acked-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
Sent: Friday, August 03, 2007 12:46 AM
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik
Subject: [PATCH] ide-cris: always tune PIO



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

