From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: fix ->speedproc to return on unsupported modes (take 5)
Date: Thu, 26 Jul 2007 21:53:53 +0200
Message-ID: <200707262153.53635.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63978 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933942AbXGZT7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591345ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


* All other implementations of ->speedproc return zero on success
  and non-zero on failure.  Currently it doesn't matter for icside host
  driver and isn't a bug per se since:

  - ide_set_xfer_rate() return value is ignored by all IDE core users

  - icside doesn't (yet!) use ide_tune_dma() in icside_dma_check()

  but sooner or later we will need to fix anyway - so lets do it now.

* icside_set_speed() happily accepts unsupported transfer modes which
  results in drive->drive_data being set to the maximum value (480)
  and drive->current_speed being set to the unsupported transfer mode.

  Fix it.

v2:
* The initial version of the patch was broken because it didn't take into
  the account (the different from usual) return values of icside_set_speed()
  (Noticed by Russell).

v3:
* Remove no longer needed initialization/checking of cycle_time
  (Noticed by Sergei).

* No need to set drive->drive_data if DMA is not going to be used
  (Noticed by Sergei).

* Remove incorrect setting of drive->current_speed
  (Noticed by Sergei).

* Move ide_config_drive_speed() at the end of icside_set_speed().

v4:
* If DMA mode is not found in icside_dma_check() then just return "-1" and
  don't call icside_set_speed() (v3 got it wrong and "1" was returned instead).

v5:
* Return "-1"/"0" in icside_set_speed() instead of icside_dma_check() return
  value (just like it was before this patch).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
replacement patch for the one in IDE quilt tree

 drivers/ide/arm/icside.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -250,7 +250,7 @@ static void icside_build_sglist(ide_driv
  */
 static int icside_set_speed(ide_drive_t *drive, const u8 xfer_mode)
 {
-	int on = 0, cycle_time = 0, use_dma_info = 0;
+	int cycle_time, use_dma_info = 0;
 
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2:
@@ -272,6 +272,8 @@ static int icside_set_speed(ide_drive_t 
 	case XFER_SW_DMA_0:
 		cycle_time = 480;
 		break;
+	default:
+		return 1;
 	}
 
 	/*
@@ -283,17 +285,10 @@ static int icside_set_speed(ide_drive_t 
 
 	drive->drive_data = cycle_time;
 
-	if (cycle_time && ide_config_drive_speed(drive, xfer_mode) == 0)
-		on = 1;
-	else
-		drive->drive_data = 480;
-
 	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
 		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
 
-	drive->current_speed = xfer_mode;
-
-	return on;
+	return ide_config_drive_speed(drive, xfer_mode);
 }
 
 static void icside_dma_host_off(ide_drive_t *drive)
@@ -320,8 +315,7 @@ static int icside_dma_check(ide_drive_t 
 {
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
-	int xfer_mode = XFER_PIO_2;
-	int on;
+	int xfer_mode = 0;
 
 	if (!(id->capability & 1) || !hwif->autodma)
 		goto out;
@@ -350,9 +344,10 @@ static int icside_dma_check(ide_drive_t 
 	}
 
 out:
-	on = icside_set_speed(drive, xfer_mode);
+	if (xfer_mode == 0)
+		return -1;
 
-	return on ? 0 : -1;
+	return icside_set_speed(drive, xfer_mode) ? -1 : 0;
 }
 
 static int icside_dma_end(ide_drive_t *drive)
