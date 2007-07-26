From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx/via82cxxx: check ide_config_drive_speed() return value
Date: Thu, 26 Jul 2007 21:56:00 +0200
Message-ID: <200707262156.00679.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63978 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936241AbXGZT76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591345ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Check ide_config_drive_speed() return value.

* While at also call ide_config_drive_speed() if the transfer mode is
  XFER_PIO_SLOW (this case happens iff the transfer mode has already been
  set on the device by ide-proc.c::set_xfer_rate()) and remove redundant
  setting of ->{init,current}_speed.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c   |   10 +++-------
 drivers/ide/pci/via82cxxx.c |   10 +++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,5 +1,5 @@
 /*
- * Version 2.22
+ * Version 2.23
  *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
@@ -240,8 +240,8 @@ static int amd_set_drive(ide_drive_t *dr
 	struct ide_timing t, p;
 	int T, UT;
 
-	if (speed != XFER_PIO_SLOW)
-		ide_config_drive_speed(drive, speed);
+	if (ide_config_drive_speed(drive, speed))
+		return 1;
 
 	T = 1000000000 / amd_clock;
 	UT = (amd_config->udma_mask == ATA_UDMA2) ? T : (T / 2);
@@ -258,10 +258,6 @@ static int amd_set_drive(ide_drive_t *dr
 
 	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
 
-	if (!drive->init_speed)	
-		drive->init_speed = speed;
-	drive->current_speed = speed;
-
 	return 0;
 }
 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,6 +1,6 @@
 /*
  *
- * Version 3.47
+ * Version 3.48
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -164,8 +164,8 @@ static int via_set_drive(ide_drive_t *dr
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
-	if (speed != XFER_PIO_SLOW)
-		ide_config_drive_speed(drive, speed);
+	if (ide_config_drive_speed(drive, speed))
+		return 1;
 
 	T = 1000000000 / via_clock;
 
@@ -186,10 +186,6 @@ static int via_set_drive(ide_drive_t *dr
 
 	via_set_speed(HWIF(drive), drive->dn, &t);
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
-	drive->current_speed = speed;
-
 	return 0;
 }
 
