From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/13] cy82c693: correct DMA modes clipping
Date: Tue, 13 Nov 2007 00:01:33 +0100
Message-ID: <200711130001.33628.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbXKLW6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:17 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250510nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Mask device DMA masks by ATA_{S,M}WDMA2 in cy82c693_ide_dma_on().

* Remove clipping of DMA modes by id->tDMA in cy82c693_dma_enable():
  - id->tDMA may not be defined on newer devices
  - id->vendor6/id->tDMA word is in LE endianness
    (cy82c693 seems to be Alpha specific though)

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cy82c693.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cy82c693.c		Version 0.42	Oct 23, 2007
+ * linux/drivers/ide/pci/cy82c693.c		Version 0.43	Nov 7, 2007
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
@@ -182,10 +182,7 @@ static void cy82c693_dma_enable (ide_dri
 
 	if (mode>2)	/* make sure we set a valid mode */
 		mode = 2;
-			   
-	if (mode > drive->id->tDMA)  /* to be absolutly sure we have a valid mode */
-		mode = drive->id->tDMA;
-	
+
 	index = (HWIF(drive)->channel==0) ? CY82_INDEX_CHANNEL0 : CY82_INDEX_CHANNEL1;
 
 #if CY82C693_DEBUG_LOGS
@@ -250,7 +247,10 @@ static int cy82c693_ide_dma_on (ide_driv
 
 			mmode = id->dma_mword & (id->dma_mword >> 8);
 			smode = id->dma_1word & (id->dma_1word >> 8);
-			       		      
+
+			mmode &= ATA_MWDMA2;
+			smode &= ATA_SWDMA2;
+
 			if (mmode != 0) {
 				/* enable multi */
 				cy82c693_dma_enable(drive, (mmode >> 1), 0);
