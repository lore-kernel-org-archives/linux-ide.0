From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.19-rc6-mm2) pdc202xx_new: remove useless code
Date: Sun, 10 Dec 2006 20:46:51 +0300
Message-ID: <200612102046.51604.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52116 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762286AbWLJRpU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Dec 2006 12:45:20 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Remove the following useless fragments from the driver:

- the ide_dma_lostirq() and ide_dma_timeout() handlers which boil down to just
  printing the incoherent reset message and calling their default counterparts;

- check for non-NULL drive->id in the ide_dma_check() handler -- this is assumed
  to be true by all other handlers (also, get rid of unnecessary nesting of the
  conditional statements there);

- the comment before pdcnew_tune_drive() which has nothing to do with the code.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/pdc202xx_new.c |   31 +++----------------------------
 1 files changed, 3 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
@@ -249,13 +249,6 @@ static int pdcnew_tune_chipset(ide_drive
 	return err;
 }
 
-/*   0    1    2    3    4    5    6   7   8
- * 960, 480, 390, 300, 240, 180, 120, 90, 60
- *           180, 150, 120,  90,  60
- * DMA_Speed
- * 180, 120,  90,  90,  90,  60,  30
- *  11,   5,   4,   3,   2,   1,   0
- */
 static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
 {
 	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
@@ -313,12 +306,10 @@ static int pdcnew_config_drive_xfer_rate
 
 	drive->init_speed = 0;
 
-	if (id && (id->capability & 1) && drive->autodma) {
+	if ((id->capability & 1) && drive->autodma) {
 
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 
@@ -336,20 +327,6 @@ static int pdcnew_quirkproc(ide_drive_t 
 	return check_in_drive_lists(drive, pdc_quirk_drives);
 }
 
-static int pdcnew_ide_dma_lostirq(ide_drive_t *drive)
-{
-	if (HWIF(drive)->resetproc != NULL)
-		HWIF(drive)->resetproc(drive);
-	return __ide_dma_lostirq(drive);
-}
-
-static int pdcnew_ide_dma_timeout(ide_drive_t *drive)
-{
-	if (HWIF(drive)->resetproc != NULL)
-		HWIF(drive)->resetproc(drive);
-	return __ide_dma_timeout(drive);
-}
-
 static void pdcnew_reset(ide_drive_t *drive)
 {
 	/*
@@ -599,8 +576,6 @@ static void __devinit init_hwif_pdc202ne
 	hwif->err_stops_fifo = 1;
 
 	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq = &pdcnew_ide_dma_lostirq;
-	hwif->ide_dma_timeout = &pdcnew_ide_dma_timeout;
 
 	if (!hwif->udma_four)
 		hwif->udma_four = pdcnew_cable_detect(hwif) ? 0 : 1;

