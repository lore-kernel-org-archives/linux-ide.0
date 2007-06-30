From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/15] sc1200: remove stale Power Management code
Date: Sat, 30 Jun 2007 21:03:31 +0200
Message-ID: <200706302103.31835.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:9971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXF3TAK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014814ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <mlord@pobox.com>


* Nowadays core IDE code handles restoring of PIO and DMA modes
  (ide-io.c:ide_start_power_step() etc) so remove open-coded version
  from sc1200_resume().

  There should be no change in behavior because settings done by
  sc1200_resume() were always overridden by generic_ide_resume()
  and ide_{start,stop}_power_step().

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <mlord@pobox.com>
---
 drivers/ide/pci/sc1200.c |   39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.94	Mar 10 2007
+ * linux/drivers/ide/pci/sc1200.c		Version 0.95	Jun 16 2007
  *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
@@ -390,7 +390,7 @@ static int sc1200_resume (struct pci_dev
 	// loop over all interfaces that are part of this pci device:
 	//
 	while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
-		unsigned int		basereg, r, d, format;
+		unsigned int		basereg, r;
 		sc1200_saved_state_t	*ss = (sc1200_saved_state_t *)hwif->config_data;
 
 		//
@@ -402,41 +402,6 @@ static int sc1200_resume (struct pci_dev
 				pci_write_config_dword(hwif->pci_dev, basereg + (r<<2), ss->regs[r]);
 			}
 		}
-		//
-		// Re-program drive PIO modes
-		//
-		pci_read_config_dword(hwif->pci_dev, basereg+4, &format);
-		format = (format >> 31) & 1;
-		if (format)
-			format += sc1200_get_pci_clock();
-		for (d = 0; d < 2; ++d) {
-			ide_drive_t *drive = &(hwif->drives[d]);
-			if (drive->present) {
-				unsigned int pio, timings;
-				pci_read_config_dword(hwif->pci_dev, basereg+(drive->select.b.unit << 3), &timings);
-				for (pio = 0; pio <= 4; ++pio) {
-					if (sc1200_pio_timings[format][pio] == timings)
-						break;
-				}
-				if (pio > 4)
-					pio = 255; /* autotune */
-				(void)sc1200_tuneproc(drive, pio);
-			}
-		}
-		//
-		// Re-program drive DMA modes
-		//
-		for (d = 0; d < MAX_DRIVES; ++d) {
-			ide_drive_t *drive = &(hwif->drives[d]);
-			if (drive->present && !__ide_dma_bad_drive(drive)) {
-				int enable_dma = drive->using_dma;
-				hwif->dma_off_quietly(drive);
-				if (sc1200_config_dma(drive))
-					enable_dma = 0;
-				if (enable_dma)
-					hwif->dma_host_on(drive);
-			}
-		}
 	}
 	return 0;
 }
