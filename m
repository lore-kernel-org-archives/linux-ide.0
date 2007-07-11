From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] amd74xx/via82cxxx: use ide_tune_dma()
Date: Wed, 11 Jul 2007 02:04:42 +0200
Message-ID: <200707110204.42227.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:5174 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbXGJXw3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:29 -0400
Received: by wr-out-0506.google.com with SMTP id i30so694381wra
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Use ide_tune_dma() in amd74xx/via82cxxx driver, this fixes following bugs:
  - DMA capability bit not being checked on the device
  - DMA blacklist not being checked
  - DMA mode being programmed even if drive->autodma == 0
    (thus possibly destroying PIO timings)

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c   |   15 ++++-----------
 drivers/ide/pci/via82cxxx.c |   15 ++++-----------
 2 files changed, 8 insertions(+), 22 deletions(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,5 +1,5 @@
 /*
- * Version 2.21
+ * Version 2.22
  *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
@@ -277,18 +277,11 @@ static void amd_set_pio_mode(ide_drive_t
 
 static int amd74xx_ide_dma_check(ide_drive_t *drive)
 {
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (speed == 0) {
-		ide_set_max_pio(drive);
-		return -1;
-	}
-
-	amd_set_drive(drive, speed);
-
-	if (drive->autodma)
+	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.46
+ * Version 3.47
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -217,18 +217,11 @@ static void via_set_pio_mode(ide_drive_t
  
 static int via82cxxx_ide_dma_check (ide_drive_t *drive)
 {
-	u8 speed = ide_max_dma_mode(drive);
-
-	if (speed == 0) {
-		ide_set_max_pio(drive);
-		return -1;
-	}
-
-	via_set_drive(drive, speed);
-
-	if (drive->autodma)
+	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
