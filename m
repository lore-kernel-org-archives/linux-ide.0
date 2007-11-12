From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/13] ide-cris: fix DMA methods
Date: Tue, 13 Nov 2007 00:02:06 +0100
Message-ID: <200711130002.06806.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:11054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758201AbXKLW6a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:30 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1634397fkz
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>


* Rename cris_dma_{on,off}() to cris_dma_host_{on,off}().

* Remove no longer needed ->dma_off_quietly
  (IDE core has the needed code now).

* Make cris_dma_host_on() void.

Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -673,9 +673,12 @@ static void cris_ide_input_data (ide_dri
 static void cris_ide_output_data (ide_drive_t *drive, void *, unsigned int);
 static void cris_atapi_input_bytes(ide_drive_t *drive, void *, unsigned int);
 static void cris_atapi_output_bytes(ide_drive_t *drive, void *, unsigned int);
-static int cris_dma_on (ide_drive_t *drive);
 
-static void cris_dma_off(ide_drive_t *drive)
+static void cris_dma_host_off(ide_drive_t *drive)
+{
+}
+
+static void cris_dma_host_on(ide_drive_t *drive)
 {
 }
 
@@ -798,9 +801,8 @@ init_e100_ide (void)
 		hwif->OUTBSYNC = &cris_ide_outbsync;
 		hwif->INB = &cris_ide_inb;
 		hwif->INW = &cris_ide_inw;
-		hwif->dma_host_off = &cris_dma_off;
-		hwif->dma_host_on = &cris_dma_on;
-		hwif->dma_off_quietly = &cris_dma_off;
+		hwif->dma_host_off = &cris_dma_host_off;
+		hwif->dma_host_on = &cris_dma_host_on;
 		hwif->cbl = ATA_CBL_PATA40;
 		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
 		hwif->pio_mask = ATA_PIO4,
@@ -822,12 +824,6 @@ init_e100_ide (void)
 	cris_ide_set_speed(TYPE_UDMA, ATA_UDMA2_CYC, ATA_UDMA2_DVS, 0);
 }
 
-static int cris_dma_on (ide_drive_t *drive)
-{
-	return 0;
-}
-
-
 static cris_dma_descr_type mydescr __attribute__ ((__aligned__(16)));
 
 /*
