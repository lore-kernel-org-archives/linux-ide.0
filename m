From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 46/64] ide: add drive->pio_mode field
Date: Mon, 18 Jan 2010 18:20:28 +0100
Message-ID: <20100118172028.14623.55296.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755374Ab0ARRVt@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add drive->pio_mode field

Add pio_mode field to ide_drive_t matching pio_mode field used in
struct ata_device.

The validity of the field is restricted to ->set_pio_mode method
only currently in IDE subsystem.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-devsets.c   |    2 ++
 drivers/ide/ide-probe.c     |    2 ++
 drivers/ide/ide-xfer-mode.c |    3 +++
 include/linux/ide.h         |    1 +
 4 files changed, 8 insertions(+)

Index: b/drivers/ide/ide-devsets.c
===================================================================
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -105,6 +105,8 @@ static int set_pio_mode(ide_drive_t *dri
 		return -ENOSYS;
 
 	if (set_pio_mode_abuse(drive->hwif, arg)) {
+		drive->pio_mode = arg + XFER_PIO_0;
+
 		if (arg == 8 || arg == 9) {
 			unsigned long flags;
 
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1043,6 +1043,8 @@ static void ide_port_init_devices(ide_hw
 		if (hwif->host_flags & IDE_HFLAG_NO_UNMASK_IRQS)
 			drive->dev_flags |= IDE_DFLAG_NO_UNMASK;
 
+		drive->pio_mode = XFER_PIO_0;
+
 		if (port_ops && port_ops->init_dev)
 			port_ops->init_dev(drive);
 	}
Index: b/drivers/ide/ide-xfer-mode.c
===================================================================
--- a/drivers/ide/ide-xfer-mode.c
+++ b/drivers/ide/ide-xfer-mode.c
@@ -135,6 +135,7 @@ int ide_set_pio_mode(ide_drive_t *drive,
 	 * set transfer mode on the device in ->set_pio_mode method...
 	 */
 	if (port_ops->set_dma_mode == NULL) {
+		drive->pio_mode = mode;
 		port_ops->set_pio_mode(drive, mode - XFER_PIO_0);
 		return 0;
 	}
@@ -142,9 +143,11 @@ int ide_set_pio_mode(ide_drive_t *drive,
 	if (hwif->host_flags & IDE_HFLAG_POST_SET_MODE) {
 		if (ide_config_drive_speed(drive, mode))
 			return -1;
+		drive->pio_mode = mode;
 		port_ops->set_pio_mode(drive, mode - XFER_PIO_0);
 		return 0;
 	} else {
+		drive->pio_mode = mode;
 		port_ops->set_pio_mode(drive, mode - XFER_PIO_0);
 		return ide_config_drive_speed(drive, mode);
 	}
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -515,6 +515,7 @@ struct ide_drive_s {
         u8	init_speed;	/* transfer rate set at boot */
         u8	current_speed;	/* current transfer rate set */
 	u8	desired_speed;	/* desired transfer rate set */
+	u8	pio_mode;	/* for ->set_pio_mode _only_ */
         u8	dn;		/* now wide spread use */
 	u8	acoustic;	/* acoustic management */
 	u8	media;		/* disk, cdrom, tape, floppy, ... */
