From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] sis5513: don't change UDMA settings when programming PIO
Date: Fri, 20 Jul 2007 12:25:30 +0200
Message-ID: <200707201225.30894.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:56363 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXGTKJG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 06:09:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so586019ugf
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 03:09:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.26	Jul 7, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.27	Jul 14, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -537,6 +537,9 @@ static int sis5513_tune_chipset(ide_driv
 	u32 regdw;
 	u8 drive_pci, reg;
 
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4)
+		return sis5513_tune_drive(drive, speed - XFER_PIO_0);
+
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
 	if (chipset_family >= ATA_133) {
@@ -601,12 +604,6 @@ static int sis5513_tune_chipset(ide_driv
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
 			break;
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			return sis5513_tune_drive(drive, speed - XFER_PIO_0);
 		default:
 			BUG();
 			break;
