From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] serverworks: fix CSB6 tuning logic
Date: Sat, 2 Jun 2007 21:05:01 +0200
Message-ID: <200706022105.01965.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:5906 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbXFBS7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 14:59:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so450194ugf
        for <linux-ide@vger.kernel.org>; Sat, 02 Jun 2007 11:59:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


Problem noticed by Joe Zbiciak, see

	http://kerneltrap.org/node/8252

for details.

On CSB6 the driver is using BIOS settings and not programming DMA/PIO timings
itself.  However the logic was completely broken and resulted in wrong timings
being silently allowed (instead of being corrected by the driver).

This bug would explain some data corruption/timeout issues with Serverworks
MegaIDE in RAID mode that Alan Cox has fixed recently with:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2074a106f52b6371885afbd714e929d60d0e3f64

For 2.6.23 we may be better off with completely switching the driver to always
programming timings (libata pata_serverworks.c driver is doing things this way
and there were no problems reported so far) but for 2.6.22 lets fix the bug
in the simplest and the least intrusive way.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/serverworks.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/serverworks.c		Version 0.10	Jun 2 2007
+ * linux/drivers/ide/pci/serverworks.c		Version 0.11	Jun 2 2007
  *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
@@ -176,35 +176,49 @@ static int svwks_tune_chipset (ide_drive
 				return 0;
 			} else if ((dma_timing) &&
 				   ((dma_stat&(1<<(5+unit)))==(1<<(5+unit)))) {
-				u8 dmaspeed = dma_timing;
+				u8 dmaspeed;
 
-				if ((dmaspeed & 0x20) == 0x20)
+				switch (dma_timing & 0x77) {
+				case 0x20:
 					dmaspeed = XFER_MW_DMA_2;
-				else if ((dmaspeed & 0x21) == 0x21)
+					break;
+				case 0x21:
 					dmaspeed = XFER_MW_DMA_1;
-				else if ((dmaspeed & 0x77) == 0x77)
+					break;
+				case 0x77:
 					dmaspeed = XFER_MW_DMA_0;
-				else
+					break;
+				default:
 					goto dma_pio;
+				}
+
 				drive->current_speed = drive->init_speed = dmaspeed;
 				return 0;
 			}
 dma_pio:
 			if (pio_timing) {
-				u8 piospeed = pio_timing;
+				u8 piospeed;
 
-				if ((piospeed & 0x20) == 0x20)
+				switch (pio_timing & 0x7f) {
+				case 0x20:
 					piospeed = XFER_PIO_4;
-				else if ((piospeed & 0x22) == 0x22)
+					break;
+				case 0x22:
 					piospeed = XFER_PIO_3;
-				else if ((piospeed & 0x34) == 0x34)
+					break;
+				case 0x34:
 					piospeed = XFER_PIO_2;
-				else if ((piospeed & 0x47) == 0x47)
+					break;
+				case 0x47:
 					piospeed = XFER_PIO_1;
-				else if ((piospeed & 0x5d) == 0x5d)
+					break;
+				case 0x5d:
 					piospeed = XFER_PIO_0;
-				else
+					break;
+				default:
 					goto oem_setup_failed;
+				}
+
 				drive->current_speed = drive->init_speed = piospeed;
 				return 0;
 			}
