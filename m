From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-pmac: PIO mode setup fixes (take 3)
Date: Mon, 23 Jul 2007 23:20:58 +0200
Message-ID: <200707232320.58609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51030 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996AbXGWVZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40027ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Add { 0, 0 } entry to {kauai,shasta}_pio_timings[] so kauai_lookup_timing()
  always returns a valid PIO timing (fixes PIO timing not being set for devices
  with minimum PIO cycle <= 120ns).

* Add setting transfer mode on the device to pmac_ide_set_pio_mode().

* Fix pmac_ide_set_pio() to always program chipset for given PIO timing instead
  of only when the device we want to program PIO timing for is the currently
  selected one.

* Now that pmac_ide_set_pio() is fixed there is no need to set transfer mode
  on the device and program chipset for PIO in pmac_ide_tune_chipset()
  (returning 0 == success is not entirely correct but is OK for now since
  the upper layers are only checking ->speedproc return value for DMA modes).

v2:
* s/speed/XFER_PIO_0 + pio/ in pmac_ide_set_pio_mode() so it actually compiles.

* Removal of kauai_lookup_timing() return value checking went to separate patch.

v3:
* Use XFER_PIO_0 not XFER_PIO. (Noticed by Ben)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch

 drivers/ide/ppc/pmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -6,6 +6,7 @@
  * for doing DMA.
  *
  *  Copyright (C) 1998-2003 Paul Mackerras & Ben. Herrenschmidt
+ *  Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -311,7 +312,8 @@ static struct kauai_timing	kauai_pio_tim
 	{ 240	, 0x0800038b },
 	{ 239	, 0x0800030c },
 	{ 180	, 0x05000249 },
-	{ 120	, 0x04000148 }
+	{ 120	, 0x04000148 },
+	{ 0	, 0 },
 };
 
 static struct kauai_timing	kauai_mdma_timings[] =
@@ -351,7 +353,8 @@ static struct kauai_timing	shasta_pio_ti
 	{ 240	, 0x040003cd },
 	{ 239	, 0x040003cd },
 	{ 180	, 0x0400028b },
-	{ 120	, 0x0400010a }
+	{ 120	, 0x0400010a },
+	{ 0	, 0 },
 };
 
 static struct kauai_timing	shasta_mdma_timings[] =
@@ -695,8 +698,10 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 		drive->name, pio,  *timings);
 #endif	
 
-	if (drive->select.all == HWIF(drive)->INB(IDE_SELECT_REG))
-		pmac_ide_do_update_timings(drive);
+	if (pmac_ide_do_setfeature(drive, XFER_PIO_0 + pio))
+		return;
+
+	pmac_ide_do_update_timings(drive);
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
@@ -965,7 +970,7 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_PIO_1:
 		case XFER_PIO_0:
 			pmac_ide_set_pio_mode(drive, speed & 0x07);
-			break;
+			return 0;
 		default:
 			ret = 1;
 	}
