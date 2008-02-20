From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide: remove IDE_HFLAG_CY82C693 host flag
Date: Wed, 20 Feb 2008 21:33:19 +0100
Message-ID: <200802202133.19126.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:46388 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209AbYBTUS5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 15:18:57 -0500
Received: by nf-out-0910.google.com with SMTP id g13so881963nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 12:18:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Sergei suggested that it shouldn't be necessary + it had no effect
anyway since ide_id_dma_bug() is called earlier in ide_tune_dma().

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
I went ahead since I urgently needed to re-cycle one host flag.

 drivers/ide/ide-dma.c      |   10 ++--------
 drivers/ide/pci/cy82c693.c |    2 +-
 include/linux/ide.h        |    2 --
 3 files changed, 3 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -747,14 +747,8 @@ static int ide_tune_dma(ide_drive_t *dri
 
 	speed = ide_max_dma_mode(drive);
 
-	if (!speed) {
-		 /* is this really correct/needed? */
-		if ((hwif->host_flags & IDE_HFLAG_CY82C693) &&
-		    ide_dma_good_drive(drive))
-			return 1;
-		else
-			return 0;
-	}
+	if (!speed)
+		return 0;
 
 	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
 		return 1;
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -410,7 +410,7 @@ static const struct ide_port_info cy82c6
 	.init_iops	= init_iops_cy82c693,
 	.init_hwif	= init_hwif_cy82c693,
 	.chipset	= ide_cy82c693,
-	.host_flags	= IDE_HFLAG_SINGLE | IDE_HFLAG_CY82C693,
+	.host_flags	= IDE_HFLAG_SINGLE,
 	.pio_mask	= ATA_PIO4,
 	.swdma_mask	= ATA_SWDMA2,
 	.mwdma_mask	= ATA_MWDMA2,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1089,8 +1089,6 @@ enum {
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
 	IDE_HFLAG_ABUSE_SET_DMA_MODE	= (1 << 26),
-	/* host is CY82C693 */
-	IDE_HFLAG_CY82C693		= (1 << 27),
 	/* force host out of "simplex" mode */
 	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
 	/* DSC overlap is unsupported */
