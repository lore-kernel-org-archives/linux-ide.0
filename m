From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/15] ide: ide_start_power_step() fix WRT disabling DMA
Date: Sat, 30 Jun 2007 21:02:19 +0200
Message-ID: <200706302102.19442.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51198 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbXF3TAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759202mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Do the same thing as probe_hwif() and always disable DMA so chipset DMA
  enabled bit gets cleared (if the drive doesn't support DMA ide_set_dma()
  won't try to tune it anyway).

* Add TODO comment about respecting ->using_dma setting.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -219,11 +219,12 @@ static ide_startstop_t ide_start_power_s
 		 * we could be smarter and check for current xfer_speed
 		 * in struct drive etc...
 		 */
-		if ((drive->id->capability & 1) == 0)
-			break;
 		if (drive->hwif->ide_dma_check == NULL)
 			break;
 		drive->hwif->dma_off_quietly(drive);
+		/*
+		 * TODO: respect ->using_dma setting
+		 */
 		ide_set_dma(drive);
 		break;
 	}
