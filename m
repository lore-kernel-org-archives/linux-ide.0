From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/12] cs5520: fix PIO auto-tuning in ->ide_dma_check method
Date: Sun, 8 Jul 2007 15:34:22 +0200
Message-ID: <200707081534.22601.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:48887 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406AbXGHOAI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so991055ugf
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -133,7 +133,7 @@ static void cs5520_tune_drive(ide_drive_
 static int cs5520_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	/* Tune the drive for PIO modes up to PIO 4 */	
-	cs5520_tune_drive(drive, 4);
+	cs5520_tune_drive(drive, 255);
 
 	/* Then tell the core to use DMA operations */
 	return 0;
