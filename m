From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/11] ide-pmac: remove pmac_ide_do_setfeature() (take 2)
Date: Tue, 24 Jul 2007 00:29:02 +0200
Message-ID: <200707240029.02584.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:59906 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417AbXGWWdH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 18:33:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so50078ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 15:33:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Use ide_config_drive_speed() instead of pmac_ide_do_setfeature() and remove
the latter, also  ide-iops.c::__ide_wait_stat() could be static again.

Since for IDE PMAC host driver IDE_CONTROL_REG is always true, device's
->quirk_list is always zero and ->ide_dma_host_{on,off} are nops than
the only changes in behavior are:

* if PIO mode is set then ->dma_off_queitly is called to disable DMA

* if setting transfer mode fails ide_dump_status() is called to dump status

v2:
* IDE PMAC controllers allow separate PIO and DMA timings and PPC userland
  depends on this fact, and calls "hdparm -p" without calling "hdparm -d".

  Therefore to compensate for DMA being disabled by ide_config_drive_speed()
  for PIO modes:

  - add IDE_HFLAG_SET_PIO_MODE_KEEP_DMA flag and set it in PMAC host driver

  - add handling of the new flag to ide-io.c::do_special()

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |   10 +++++-
 drivers/ide/ide-iops.c |    2 -
 drivers/ide/ppc/pmac.c |   80 +------------------------------------------------
 include/linux/ide.h    |    6 +++
 4 files changed, 18 insertions(+), 80 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -836,9 +836,17 @@ static ide_startstop_t do_special (ide_d
 		if (set_pio_mode_abuse(drive->hwif, req_pio)) {
 			if (hwif->set_pio_mode)
 				hwif->set_pio_mode(drive, req_pio);
-		} else
+		} else {
+			int keep_dma = drive->using_dma;
+
 			ide_set_pio(drive, req_pio);
 
+			if (hwif->host_flags & IDE_HFLAG_SET_PIO_MODE_KEEP_DMA) {
+				if (keep_dma)
+					hwif->ide_dma_on(drive);
+			}
+		}
+
 		return ide_stopped;
 	} else {
 		if (drive->media == ide_disk)
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -483,7 +483,7 @@ EXPORT_SYMBOL(drive_is_ready);
  * setting a timer to wake up at half second intervals thereafter,
  * until timeout is achieved, before timing out.
  */
-int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
+static int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned long flags;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -530,81 +530,6 @@ pmac_outbsync(ide_drive_t *drive, u8 val
 }
 
 /*
- * Send the SET_FEATURE IDE command to the drive and update drive->id with
- * the new state. We currently don't use the generic routine as it used to
- * cause various trouble, especially with older mediabays.
- * This code is sometimes triggering a spurrious interrupt though, I need
- * to sort that out sooner or later and see if I can finally get the
- * common version to work properly in all cases
- */
-static int
-pmac_ide_do_setfeature(ide_drive_t *drive, u8 command)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-	int result;
-	u8 stat;
-	
-	disable_irq_nosync(hwif->irq);
-	udelay(1);
-	SELECT_DRIVE(drive);
-	SELECT_MASK(drive, 0);
-	udelay(1);
-	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
-	hwif->OUTB(command, IDE_NSECTOR_REG);
-	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
-	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
-	result = __ide_wait_stat(drive, drive->ready_stat,
-				 BUSY_STAT|DRQ_STAT|ERR_STAT,
-				 WAIT_CMD, &stat);
-	if (result)
-		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
-			"after SET_FEATURE !\n", drive->name);
-
-	SELECT_MASK(drive, 0);
-	if (result == 0) {
-		drive->id->dma_ultra &= ~0xFF00;
-		drive->id->dma_mword &= ~0x0F00;
-		drive->id->dma_1word &= ~0x0F00;
-		switch(command) {
-			case XFER_UDMA_7:
-				drive->id->dma_ultra |= 0x8080; break;
-			case XFER_UDMA_6:
-				drive->id->dma_ultra |= 0x4040; break;
-			case XFER_UDMA_5:
-				drive->id->dma_ultra |= 0x2020; break;
-			case XFER_UDMA_4:
-				drive->id->dma_ultra |= 0x1010; break;
-			case XFER_UDMA_3:
-				drive->id->dma_ultra |= 0x0808; break;
-			case XFER_UDMA_2:
-				drive->id->dma_ultra |= 0x0404; break;
-			case XFER_UDMA_1:
-				drive->id->dma_ultra |= 0x0202; break;
-			case XFER_UDMA_0:
-				drive->id->dma_ultra |= 0x0101; break;
-			case XFER_MW_DMA_2:
-				drive->id->dma_mword |= 0x0404; break;
-			case XFER_MW_DMA_1:
-				drive->id->dma_mword |= 0x0202; break;
-			case XFER_MW_DMA_0:
-				drive->id->dma_mword |= 0x0101; break;
-			case XFER_SW_DMA_2:
-				drive->id->dma_1word |= 0x0404; break;
-			case XFER_SW_DMA_1:
-				drive->id->dma_1word |= 0x0202; break;
-			case XFER_SW_DMA_0:
-				drive->id->dma_1word |= 0x0101; break;
-			default: break;
-		}
-		if (!drive->init_speed)
-			drive->init_speed = command;
-		drive->current_speed = command;
-	}
-	enable_irq(hwif->irq);
-	return result;
-}
-
-/*
  * Old tuning functions (called on hdparm -p), sets up drive PIO timings
  */
 static void
@@ -685,7 +610,7 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
 		drive->name, pio,  *timings);
 #endif	
 
-	if (pmac_ide_do_setfeature(drive, XFER_PIO_0 + pio))
+	if (ide_config_drive_speed(drive, XFER_PIO_0 + pio))
 		return;
 
 	pmac_ide_do_update_timings(drive);
@@ -948,7 +873,7 @@ static int pmac_ide_tune_chipset(ide_dri
 	if (ret)
 		return ret;
 
-	ret = pmac_ide_do_setfeature(drive, speed);
+	ret = ide_config_drive_speed(drive, speed);
 	if (ret)
 		return ret;
 
@@ -1218,6 +1143,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->drives[0].unmask = 1;
 	hwif->drives[1].unmask = 1;
+	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA;
 	hwif->pio_mask = ATA_PIO4;
 	hwif->set_pio_mode = pmac_ide_set_pio_mode;
 	if (pmif->kind == controller_un_ata6
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1152,7 +1152,6 @@ extern void SELECT_MASK(ide_drive_t *, i
 extern void QUIRK_LIST(ide_drive_t *);
 
 extern int drive_is_ready(ide_drive_t *);
-int __ide_wait_stat(ide_drive_t *, u8, u8, unsigned long);
 
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
@@ -1252,6 +1251,11 @@ enum {
 	IDE_HFLAG_ABUSE_FAST_DEVSEL	= (1 << 5),
 	/* use 100-102 and 200-202 PIO values to set DMA modes */
 	IDE_HFLAG_ABUSE_DMA_MODES	= (1 << 6),
+	/*
+	 * keep DMA setting when programming PIO mode, may be used only
+	 * for hosts which have separate PIO and DMA timings (ie. PMAC)
+	 */
+	IDE_HFLAG_SET_PIO_MODE_KEEP_DMA	= (1 << 7),
 };
 
 typedef struct ide_pci_device_s {
