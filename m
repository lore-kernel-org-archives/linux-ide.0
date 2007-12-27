From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/9] icside: use hwif->dev
Date: Thu, 27 Dec 2007 20:12:45 +0100
Message-ID: <20071227191245.1357.38374.sendpatchset@localhost.localdomain>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:6066 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbXL0TBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 14:01:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1692942ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 11:01:51 -0800 (PST)
In-Reply-To: <20071227191153.1357.63211.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

* Setup hwif->dev in icside_setup().

* Use hwif->dev instead of state->dev in icside_build_sglist(),
  icside_dma_end(), icside_dma_start() and icside_dma_setup().

* Remove no longer needed 'dev' field from struct icside_state.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |   31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -71,8 +71,6 @@ struct icside_state {
 	void __iomem *irq_port;
 	void __iomem *ioc_base;
 	unsigned int type;
-	/* parent device... until the IDE core gets one of its own */
-	struct device *dev;
 	ide_hwif_t *hwif[2];
 };
 
@@ -209,7 +207,6 @@ static void icside_maskproc(ide_drive_t 
 static void icside_build_sglist(ide_drive_t *drive, struct request *rq)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	struct icside_state *state = hwif->hwif_data;
 	struct scatterlist *sg = hwif->sg_table;
 
 	ide_map_sg(drive, rq);
@@ -219,7 +216,7 @@ static void icside_build_sglist(ide_driv
 	else
 		hwif->sg_dma_direction = DMA_TO_DEVICE;
 
-	hwif->sg_nents = dma_map_sg(state->dev, sg, hwif->sg_nents,
+	hwif->sg_nents = dma_map_sg(hwif->dev, sg, hwif->sg_nents,
 				    hwif->sg_dma_direction);
 }
 
@@ -294,33 +291,33 @@ static void icside_dma_host_set(ide_driv
 static int icside_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	struct icside_state *state = hwif->hwif_data;
+	struct expansion_card *ec = ECARD_DEV(hwif->dev);
 
 	drive->waiting_for_dma = 0;
 
-	disable_dma(ECARD_DEV(state->dev)->dma);
+	disable_dma(ec->dma);
 
 	/* Teardown mappings after DMA has completed. */
-	dma_unmap_sg(state->dev, hwif->sg_table, hwif->sg_nents,
+	dma_unmap_sg(hwif->dev, hwif->sg_table, hwif->sg_nents,
 		     hwif->sg_dma_direction);
 
-	return get_dma_residue(ECARD_DEV(state->dev)->dma) != 0;
+	return get_dma_residue(ec->dma) != 0;
 }
 
 static void icside_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	struct icside_state *state = hwif->hwif_data;
+	struct expansion_card *ec = ECARD_DEV(hwif->dev);
 
 	/* We can not enable DMA on both channels simultaneously. */
-	BUG_ON(dma_channel_active(ECARD_DEV(state->dev)->dma));
-	enable_dma(ECARD_DEV(state->dev)->dma);
+	BUG_ON(dma_channel_active(ec->dma));
+	enable_dma(ec->dma);
 }
 
 static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	struct icside_state *state = hwif->hwif_data;
+	struct expansion_card *ec = ECARD_DEV(hwif->dev);
 	struct request *rq = hwif->hwgroup->rq;
 	unsigned int dma_mode;
 
@@ -332,7 +329,7 @@ static int icside_dma_setup(ide_drive_t 
 	/*
 	 * We can not enable DMA on both channels.
 	 */
-	BUG_ON(dma_channel_active(ECARD_DEV(state->dev)->dma));
+	BUG_ON(dma_channel_active(ec->dma));
 
 	icside_build_sglist(drive, rq);
 
@@ -349,14 +346,14 @@ static int icside_dma_setup(ide_drive_t 
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(ECARD_DEV(state->dev)->dma, drive->drive_data);
+	set_dma_speed(ec->dma, drive->drive_data);
 
 	/*
 	 * Tell the DMA engine about the SG table and
 	 * data direction.
 	 */
-	set_dma_sg(ECARD_DEV(state->dev)->dma, hwif->sg_table, hwif->sg_nents);
-	set_dma_mode(ECARD_DEV(state->dev)->dma, dma_mode);
+	set_dma_sg(ec->dma, hwif->sg_table, hwif->sg_nents);
+	set_dma_mode(ec->dma, dma_mode);
 
 	drive->waiting_for_dma = 1;
 
@@ -444,6 +441,7 @@ icside_setup(void __iomem *base, struct 
 		hwif->noprobe = 0;
 		hwif->chipset = ide_acorn;
 		hwif->gendev.parent = &ec->dev;
+		hwif->dev = &ec->dev;
 	}
 
 	return hwif;
@@ -591,7 +589,6 @@ icside_probe(struct expansion_card *ec, 
 	}
 
 	state->type	= ICS_TYPE_NOTYPE;
-	state->dev	= &ec->dev;
 
 	idmem = ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
 	if (idmem) {
