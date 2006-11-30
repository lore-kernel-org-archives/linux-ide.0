From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Fwd: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new: fix PIO mode setup
Date: Thu, 30 Nov 2006 20:59:49 +0300
Message-ID: <200611302059.49646.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55233 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1030904AbWK3R6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 12:58:19 -0500
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP id 8CCA73ECA
	for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 09:58:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Shoot! CCed Alan Cox twice, instead of CCing linux-ide...

----------  Forwarded Message  ----------

Subject: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new: fix PIO mode setup
Date: Thursday 30 November 2006 20:54
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: akpm@osdl.org, bzolnier@gmail.com
Cc: alan@lxorguk.ukuu.org.uk, alan@lxorguk.ukuu.org.uk

Fix pdcnew_tune_drive() to always set the PIO mode requested, not pick the
 best possible one, change pdcnew_config_drive_xfer_rate() accordingly, and
 get rid of the duplicate tuneproc() call in config_chipset_for_dma().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/pdc202xx_new.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
@@ -9,6 +9,7 @@
  *  Split from:
  *  linux/drivers/ide/pdc202xx.c	Version 0.35	Mar. 30, 2002
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2005-2006		MontaVista Software, Inc.
  *  Portions Copyright (C) 1999 Promise Technology, Inc.
  *  Author: Frank Tiernan (frankt@promise.com)
  *  Released under terms of General Public License
@@ -168,12 +169,8 @@ static int pdcnew_new_tune_chipset (ide_
  */
 static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	u8 speed;
-
-	if (pio == 5) pio = 4;
-	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
-
-	(void)pdcnew_new_tune_chipset(drive, speed);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	(void)pdcnew_new_tune_chipset(drive, XFER_PIO_0 + pio);
 }

 static u8 pdcnew_new_cable_detect (ide_hwif_t *hwif)
@@ -207,10 +204,8 @@ static int config_chipset_for_dma (ide_d

 	speed = ide_dma_speed(drive, pdcnew_ratemask(drive));

-	if (!(speed)) {
-		hwif->tuneproc(drive, 5);
+	if (!speed)
 		return 0;
-	}

 	(void) hwif->speedproc(drive, speed);
 	return ide_dma_enable(drive);
@@ -234,7 +229,7 @@ static int pdcnew_config_drive_xfer_rate

 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		hwif->tuneproc(drive, 5);
+		hwif->tuneproc(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */

-------------------------------------------------------

