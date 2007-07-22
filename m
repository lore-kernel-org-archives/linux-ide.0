From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/11] ide-pmac: don't check kauai_lookup_timing() return value
Date: Sun, 22 Jul 2007 20:20:55 +0200
Message-ID: <200707222020.55609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:33765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736AbXGVSTA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001345ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


kauai_lookup_timing() should always return non-zero return value:

* BUG() in kauai_lookup_timing() if the timing info cannot be found.

* Remove code checking for zero return value from all callers.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
patch series on top of the current IDE quilt tree

 drivers/ide/ppc/pmac.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -391,6 +391,7 @@ kauai_lookup_timing(struct kauai_timing*
 	for (i=0; table[i].cycle_time; i++)
 		if (cycle_time > table[i+1].cycle_time)
 			return table[i].timing_reg;
+	BUG();
 	return 0;
 }
 
@@ -636,8 +637,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 	case controller_sh_ata6: {
 		/* 133Mhz cell */
 		u32 tr = kauai_lookup_timing(shasta_pio_timings, cycle_time);
-		if (tr == 0)
-			return;
 		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
 		break;
 		}
@@ -645,8 +644,6 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
 		u32 tr = kauai_lookup_timing(kauai_pio_timings, cycle_time);
-		if (tr == 0)
-			return;
 		*timings = ((*timings) & ~TR_100_PIOREG_PIO_MASK) | tr;
 		break;
 		}
@@ -745,8 +742,6 @@ set_timings_udma_ata6(u32 *pio_timings, 
 	if (speed > XFER_UDMA_5 || t == NULL)
 		return 1;
 	tr = kauai_lookup_timing(kauai_udma_timings, (int)t->udma);
-	if (tr == 0)
-		return 1;
 	*ultra_timings = ((*ultra_timings) & ~TR_100_UDMAREG_UDMA_MASK) | tr;
 	*ultra_timings = (*ultra_timings) | TR_100_UDMAREG_UDMA_EN;
 
@@ -765,8 +760,6 @@ set_timings_udma_shasta(u32 *pio_timings
 	if (speed > XFER_UDMA_6 || t == NULL)
 		return 1;
 	tr = kauai_lookup_timing(shasta_udma133_timings, (int)t->udma);
-	if (tr == 0)
-		return 1;
 	*ultra_timings = ((*ultra_timings) & ~TR_133_UDMAREG_UDMA_MASK) | tr;
 	*ultra_timings = (*ultra_timings) | TR_133_UDMAREG_UDMA_EN;
 
@@ -838,8 +831,6 @@ set_timings_mdma(ide_drive_t *drive, int
 	case controller_sh_ata6: {
 		/* 133Mhz cell */
 		u32 tr = kauai_lookup_timing(shasta_mdma_timings, cycleTime);
-		if (tr == 0)
-			return 1;
 		*timings = ((*timings) & ~TR_133_PIOREG_MDMA_MASK) | tr;
 		*timings2 = (*timings2) & ~TR_133_UDMAREG_UDMA_EN;
 		}
@@ -847,8 +838,6 @@ set_timings_mdma(ide_drive_t *drive, int
 	case controller_k2_ata6: {
 		/* 100Mhz cell */
 		u32 tr = kauai_lookup_timing(kauai_mdma_timings, cycleTime);
-		if (tr == 0)
-			return 1;
 		*timings = ((*timings) & ~TR_100_PIOREG_MDMA_MASK) | tr;
 		*timings2 = (*timings2) & ~TR_100_UDMAREG_UDMA_EN;
 		}
