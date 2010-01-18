From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 47/64] ide: add drive->dma_mode field
Date: Mon, 18 Jan 2010 18:20:35 +0100
Message-ID: <20100118172035.14623.50000.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:51627 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab0ARRVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:21:46 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add drive->dma_mode field

Add dma_mode field to ide_drive_t matching dma_mode field used in
struct ata_device.

The validity of the field is restricted to ->dma_pio_mode method
only currently in IDE subsystem.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/aec62xx.c       |    1 +
 drivers/ide/ide-xfer-mode.c |    2 ++
 include/linux/ide.h         |    1 +
 3 files changed, 4 insertions(+)

Index: b/drivers/ide/aec62xx.c
===================================================================
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -136,6 +136,7 @@ static void aec6260_set_mode(ide_drive_t
 
 static void aec_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
+	drive->dma_mode = pio + XFER_PIO_0;
 	drive->hwif->port_ops->set_dma_mode(drive, pio + XFER_PIO_0);
 }
 
Index: b/drivers/ide/ide-xfer-mode.c
===================================================================
--- a/drivers/ide/ide-xfer-mode.c
+++ b/drivers/ide/ide-xfer-mode.c
@@ -167,9 +167,11 @@ int ide_set_dma_mode(ide_drive_t *drive,
 	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
 		if (ide_config_drive_speed(drive, mode))
 			return -1;
+		drive->dma_mode = mode;
 		port_ops->set_dma_mode(drive, mode);
 		return 0;
 	} else {
+		drive->dma_mode = mode;
 		port_ops->set_dma_mode(drive, mode);
 		return ide_config_drive_speed(drive, mode);
 	}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -516,6 +516,7 @@ struct ide_drive_s {
         u8	current_speed;	/* current transfer rate set */
 	u8	desired_speed;	/* desired transfer rate set */
 	u8	pio_mode;	/* for ->set_pio_mode _only_ */
+	u8	dma_mode;	/* for ->dma_pio_mode _only_ */
         u8	dn;		/* now wide spread use */
 	u8	acoustic;	/* acoustic management */
 	u8	media;		/* disk, cdrom, tape, floppy, ... */
