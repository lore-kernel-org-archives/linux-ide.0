From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/11] ide-pmac: fix set_timings_mdma()
Date: Sun, 22 Jul 2007 20:22:41 +0200
Message-ID: <200707222022.41386.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:33765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108AbXGVSTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001345ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Move adjusting of cycle time for devices providing explicit DMA cycle time
  from pmac_ide_mdma_enable() to set_timings_mdma().

* Remove no longer needed drive_cycle_time argument.

* BUG() if unsupported speed argument value is passed (shouldn't happen).

* Matching access/recovery timings always exist so remove redundant check.

* Make set_timings_mdma() void.

* Update pmac_ide_tune_chipset()'s comment.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -769,12 +769,13 @@ set_timings_udma_shasta(u32 *pio_timings
 /*
  * Calculate MDMA timings for all cells
  */
-static int
+static void
 set_timings_mdma(ide_drive_t *drive, int intf_type, u32 *timings, u32 *timings2,
-			u8 speed, int drive_cycle_time)
+		 	u8 speed)
 {
 	int cycleTime, accessTime = 0, recTime = 0;
 	unsigned accessTicks, recTicks;
+	struct hd_driveid *id = drive->id;
 	struct mdma_timings_t* tm = NULL;
 	int i;
 
@@ -784,11 +785,14 @@ set_timings_mdma(ide_drive_t *drive, int
 		case 1: cycleTime = 150; break;
 		case 2: cycleTime = 120; break;
 		default:
-			return 1;
+			BUG();
+			break;
 	}
-	/* Adjust for drive */
-	if (drive_cycle_time && drive_cycle_time > cycleTime)
-		cycleTime = drive_cycle_time;
+
+	/* Check if drive provides explicit DMA cycle time */
+	if ((id->field_valid & 2) && id->eide_dma_time)
+		cycleTime = max_t(int, id->eide_dma_time, cycleTime);
+
 	/* OHare limits according to some old Apple sources */	
 	if ((intf_type == controller_ohare) && (cycleTime < 150))
 		cycleTime = 150;
@@ -816,8 +820,6 @@ set_timings_mdma(ide_drive_t *drive, int
 				break;
 			i++;
 		}
-		if (i < 0)
-			return 1;
 		cycleTime = tm[i].cycleTime;
 		accessTime = tm[i].accessTime;
 		recTime = tm[i].recoveryTime;
@@ -899,16 +901,12 @@ set_timings_mdma(ide_drive_t *drive, int
 	printk(KERN_ERR "%s: Set MDMA timing for mode %d, reg: 0x%08x\n",
 		drive->name, speed & 0xf,  *timings);
 #endif	
-	return 0;
 }
 #endif /* #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC */
 
 /* 
  * Speedproc. This function is called by the core to set any of the standard
  * timing (PIO, MDMA or UDMA) to both the drive and the controller.
- * You may notice we don't use this function on normal "dma check" operation,
- * our dedicated function is more precise as it uses the drive provided
- * cycle time value. We should probably fix this one to deal with that too...
  */
 static int pmac_ide_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
@@ -946,7 +944,7 @@ static int pmac_ide_tune_chipset(ide_dri
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
-			ret = set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed, 0);
+			set_timings_mdma(drive, pmif->kind, &tl[0], &tl[1], speed);
 			break;
 		case XFER_SW_DMA_2:
 		case XFER_SW_DMA_1:
@@ -1678,8 +1676,6 @@ pmac_ide_mdma_enable(ide_drive_t *drive,
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
-	int drive_cycle_time;
-	struct hd_driveid *id = drive->id;
 	u32 *timings, *timings2;
 	u32 timing_local[2];
 	int ret;
@@ -1688,24 +1684,12 @@ pmac_ide_mdma_enable(ide_drive_t *drive,
 	timings = &pmif->timings[drive->select.b.unit & 0x01];
 	timings2 = &pmif->timings[(drive->select.b.unit & 0x01) + 2];
 
-	/* Check if drive provide explicit cycle time */
-	if ((id->field_valid & 2) && (id->eide_dma_time))
-		drive_cycle_time = id->eide_dma_time;
-	else
-		drive_cycle_time = 0;
-
 	/* Copy timings to local image */
 	timing_local[0] = *timings;
 	timing_local[1] = *timings2;
 
 	/* Calculate controller timings */
-	ret = set_timings_mdma(	drive, pmif->kind,
-				&timing_local[0],
-				&timing_local[1],
-				mode,
-				drive_cycle_time);
-	if (ret)
-		return 0;
+	set_timings_mdma(drive, pmif->kind, &timing_local[0], &timing_local[1], mode);
 
 	/* Set feature on drive */
     	printk(KERN_INFO "%s: Enabling MultiWord DMA %d\n", drive->name, mode & 0xf);
