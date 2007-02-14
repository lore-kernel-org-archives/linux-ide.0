From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/8] pdc202xx_new: use ide_tune_dma()
Date: Wed, 14 Feb 2007 02:56:16 +0100
Message-ID: <20070214015616.4619.66530.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbXBNBvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:04 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] pdc202xx_new: use ide_tune_dma()

* remove code enabling IORDY and prefetch from config_chipset_for_dma(),
  as the comment states it has no real effect because these settings are
  overriden when the PIO mode is set (and for this driver ->autotune == 1
  so PIO mode is always programmed)

* remove the check for drive->media != ide_disk from config_chipset_for_dma(),
  it is not needed because ide_max_dma_mode() returns 0 when ->atapi_dma == 0

* use ide_tune_dma() in pdcnew_config_drive_xfer_rate() and remove no longer
  needed config_chipset_for_dma()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/pdc202xx_new.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -228,41 +228,11 @@ static u8 pdcnew_cable_detect(ide_hwif_t
 	return get_indexed_reg(hwif, 0x0b) & 0x04;
 }
 
-static int config_chipset_for_dma(ide_drive_t *drive)
-{
-	struct hd_driveid *id	= drive->id;
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 speed;
-
-	if (drive->media != ide_disk)
-		return 0;
-
-	if (id->capability & 4) {
-		/*
-		 * Set IORDY_EN & PREFETCH_EN (this seems to have
-		 * NO real effect since this register is reloaded
-		 * by hardware when the transfer mode is selected)
-		 */
-		u8 tmp, adj = (drive->dn & 1) ? 0x08 : 0x00;
-
-		tmp = get_indexed_reg(hwif, 0x13 + adj);
-		set_indexed_reg(hwif, 0x13 + adj, tmp | 0x03);
-	}
-
-	speed = ide_max_dma_mode(drive);
-
-	if (!speed)
-		return 0;
-
-	(void) hwif->speedproc(drive, speed);
-	return ide_dma_enable(drive);
-}
-
 static int pdcnew_config_drive_xfer_rate(ide_drive_t *drive)
 {
 	drive->init_speed = 0;
 
-	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+	if (ide_tune_dma(drive))
 		return 0;
 
 	if (ide_use_fast_pio(drive))
