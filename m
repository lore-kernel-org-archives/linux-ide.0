From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] atiixp: ->speedproc, filter out invalid modes passed from user-space
Date: Sat, 30 Jun 2007 21:09:46 +0200
Message-ID: <200706302109.46258.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:9948 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbXF3TAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:18 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014824ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/atiixp.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.02	Jun 16 2007
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.03	Jun 30 2007
  *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
@@ -186,6 +186,17 @@ static int atiixp_speedproc(ide_drive_t 
 		return ide_config_drive_speed(drive, speed);
 	}
 
+	/*
+	 * Paranoia, filter out invalid modes passed from user-space
+	 * (UDMA > 5 modes are already dealt by ide_rate_filter() call).
+	 *
+	 * This will go away once ide_set_xfer() is fixed.
+	 */
+	if ((speed > XFER_PIO_4 && speed < XFER_SW_DMA_2) ||
+	    (speed > XFER_SW_DMA_2 && speed < XFER_MW_DMA_0) ||
+	    (speed > XFER_MW_DMA_2 && speed < XFER_UDMA_0));
+		return -1;
+
 	spin_lock_irqsave(&atiixp_lock, flags);
 
 	save_mdma_mode[drive->dn] = 0;
