From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 1/4] fix drive->ready_stat for ATAPI
Date: Sun, 16 Jan 2005 02:11:41 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0501160207290.29887@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37521 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262375AbVAPBVC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jan 2005 20:21:02 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:35851 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S198704AbVAPBRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jan 2005 02:17:20 +0100
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33140 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S198721AbVAPBLr (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sun, 16 Jan 2005 02:11:47 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Hi,

ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
It is currently done by device drivers (including ide-default fake driver)
but for PMAC driver it is too late as wait_for_ready() may be called during
probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
->pmac_ide_do_setfeature()->wait_for_ready().  Set correct drive->ready_stat
just after detecting ATAPI device.

Bartlomiej

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-15 14:02:36 +01:00
@@ -3088,7 +3088,6 @@
 		drive->queue->unplug_delay = 1;

 	drive->special.all	= 0;
-	drive->ready_stat	= 0;

 	CDROM_STATE_FLAGS(drive)->media_changed = 1;
 	CDROM_STATE_FLAGS(drive)->toc_valid     = 0;
diff -Nru a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide-default.c	2005-01-15 14:02:36 +01:00
@@ -57,13 +57,6 @@
 			"driver with ide.c\n", drive->name);
 		return 1;
 	}
-
-	/* For the sake of the request layer, we must make sure we have a
-	 * correct ready_stat value, that is 0 for ATAPI devices or we will
-	 * fail any request like Power Management
-	 */
-	if (drive->media != ide_disk)
-		drive->ready_stat = 0;

 	return 0;
 }
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-15 14:02:36 +01:00
@@ -1793,7 +1793,6 @@

 	*((u16 *) &gcw) = drive->id->config;
 	drive->driver_data = floppy;
-	drive->ready_stat = 0;
 	memset(floppy, 0, sizeof(idefloppy_floppy_t));
 	floppy->drive = drive;
 	floppy->pc = floppy->pc_stack;
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide-probe.c	2005-01-15 14:02:36 +01:00
@@ -221,6 +221,8 @@
 		}
 		printk (" drive\n");
 		drive->media = type;
+		/* an ATAPI device ignores DRDY */
+		drive->ready_stat = 0;
 		return;
 	}

diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-15 14:02:36 +01:00
@@ -4530,8 +4530,6 @@
 	memset(tape, 0, sizeof (idetape_tape_t));
 	spin_lock_init(&tape->spinlock);
 	drive->driver_data = tape;
-	/* An ATAPI device ignores DRDY */
-	drive->ready_stat = 0;
 	drive->dsc_overlap = 1;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	if (HWIF(drive)->pci_dev != NULL) {
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/ide/ide.c	2005-01-15 14:02:36 +01:00
@@ -1747,6 +1747,8 @@
 			case -4: /* "cdrom" */
 				drive->present = 1;
 				drive->media = ide_cdrom;
+				/* an ATAPI device ignores DRDY */
+				drive->ready_stat = 0;
 				hwif->noprobe = 0;
 				goto done;
 			case -5: /* "serialize" */
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-15 14:02:36 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-15 14:02:36 +01:00
@@ -679,7 +679,6 @@
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 {
 	DRIVER(drive)->busy++;
-	drive->ready_stat = 0;
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
 		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
