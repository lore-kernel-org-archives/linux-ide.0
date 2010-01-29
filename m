From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 22/68] ide: add drive->devno field
Date: Fri, 29 Jan 2010 17:05:31 +0100
Message-ID: <20100129160531.21495.79268.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53041 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0A2QFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:05:43 -0500
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add drive->devno field

Add devno field to ide_drive_t matching devno field used in
struct ata_device.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    1 +
 include/linux/ide.h     |    1 +
 2 files changed, 2 insertions(+)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1033,6 +1033,7 @@ static void ide_port_init_devices(ide_hw
 
 	ide_port_for_each_dev(i, drive, hwif) {
 		drive->dn = i + hwif->channel * 2;
+		drive->devno = i;
 
 		if (hwif->host_flags & IDE_HFLAG_IO_32BIT)
 			drive->io_32bit = 1;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -518,6 +518,7 @@ struct ide_drive_s {
 	u8	pio_mode;	/* for ->set_pio_mode _only_ */
 	u8	dma_mode;	/* for ->dma_pio_mode _only_ */
         u8	dn;		/* now wide spread use */
+	u8	devno;		/* 0 or 1 */
 	u8	acoustic;	/* acoustic management */
 	u8	media;		/* disk, cdrom, tape, floppy, ... */
 	u8	ready_stat;	/* min status value for drive ready */
