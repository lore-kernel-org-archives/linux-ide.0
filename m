From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide-pmac: PIO fixes
Date: Wed, 11 Jul 2007 02:04:07 +0200
Message-ID: <200707110204.07540.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:52674 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbXGJXw1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:27 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1038258ika
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>


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

This patch should have no effect on the default kernel behavior because
IDE pmac driver doesn't enable ->autotune (this would also explain why some
of the above bugs remained unfixed for so long).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
---
 drivers/ide/ppc/pmac.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -311,7 +311,8 @@ static struct kauai_timing	kauai_pio_tim
 	{ 240	, 0x0800038b },
 	{ 239	, 0x0800030c },
 	{ 180	, 0x05000249 },
-	{ 120	, 0x04000148 }
+	{ 120	, 0x04000148 },
+	{ 0	, 0 },
 };
 
 static struct kauai_timing	kauai_mdma_timings[] =
@@ -351,7 +352,8 @@ static struct kauai_timing	shasta_pio_ti
 	{ 240	, 0x040003cd },
 	{ 239	, 0x040003cd },
 	{ 180	, 0x0400028b },
-	{ 120	, 0x0400010a }
+	{ 120	, 0x0400010a },
+	{ 0	, 0 },
 };
 
 static struct kauai_timing	shasta_mdma_timings[] =
@@ -631,8 +633,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 	case controller_sh_ata6: {
 		/* 133Mhz cell */
 		u32 tr = kauai_lookup_timing(shasta_pio_timings, cycle_time);
-		if (tr == 0)
-			return;
 		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
 		break;
 		}
@@ -640,8 +640,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
 		u32 tr = kauai_lookup_timing(kauai_pio_timings, cycle_time);
-		if (tr == 0)
-			return;
 		*timings = ((*timings) & ~TR_100_PIOREG_PIO_MASK) | tr;
 		break;
 		}
@@ -692,8 +690,11 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 		drive->name, pio,  *timings);
 #endif	
 
-	if (drive->select.all == HWIF(drive)->INB(IDE_SELECT_REG))
-		pmac_ide_do_update_timings(drive);
+	if (pmac_ide_do_setfeature(drive, speed))
+		return;
+
+	pmac_ide_do_update_timings(drive);
+	drive->current_speed = speed;
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
@@ -962,7 +963,7 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_PIO_1:
 		case XFER_PIO_0:
 			pmac_ide_set_pio_mode(drive, speed & 0x07);
-			break;
+			return 0;
 		default:
 			ret = 1;
 	}
