From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add ide_dev_has_iordy() helper (take 4)
Date: Sun, 1 Jul 2007 00:44:54 +0200
Message-ID: <200707010044.55052.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:31210 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbXF3WdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 18:33:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1034306ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 15:33:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>


* Add ide_dev_has_iordy() helper and use it sl82c105 host driver.

* Remove no longer needed ide_pio_data_t.use_iordy field.

v2/v3:
* Fix issues noticed by Sergei:
  - correct patch description
  - fix comment in ide_get_best_pio_mode()

v4:
* Fix "ata_" prefix (Noticed by Jeff).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>
---
 drivers/ide/ide-lib.c      |    7 +------
 drivers/ide/pci/sl82c105.c |   10 +++++++---
 include/linux/ide.h        |    6 +++++-
 3 files changed, 13 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -267,18 +267,15 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 {
 	int pio_mode;
 	int cycle_time = 0;
-	int use_iordy = 0;
 	struct hd_driveid* id = drive->id;
 	int overridden  = 0;
 
 	if (mode_wanted != 255) {
 		pio_mode = mode_wanted;
-		use_iordy = (pio_mode > 2);
 	} else if (!drive->id) {
 		pio_mode = 0;
 	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
 		printk(KERN_INFO "%s: is on PIO blacklist\n", drive->name);
-		use_iordy = (pio_mode > 2);
 	} else {
 		pio_mode = id->tPIO;
 		if (pio_mode > 2) {	/* 2 is maximum allowed tPIO value */
@@ -286,8 +283,7 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 			overridden = 1;
 		}
 		if (id->field_valid & 2) {	  /* drive implements ATA2? */
-			if (id->capability & 8) { /* drive supports use_iordy? */
-				use_iordy = 1;
+			if (id->capability & 8) { /* IORDY supported? */
 				cycle_time = id->eide_pio_iordy;
 				if (id->eide_pio_modes & 7) {
 					overridden = 0;
@@ -325,7 +321,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 	if (d) {
 		d->pio_mode = pio_mode;
 		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
-		d->use_iordy = use_iordy;
 	}
 	return pio_mode;
 }
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -52,9 +52,10 @@
  * Convert a PIO mode and cycle time to the required on/off times
  * for the interface.  This has protection against runaway timings.
  */
-static unsigned int get_pio_timings(ide_pio_data_t *p)
+static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
 {
 	unsigned int cmd_on, cmd_off;
+	u8 iordy = 0;
 
 	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
 	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
@@ -65,7 +66,10 @@ static unsigned int get_pio_timings(ide_
 	if (cmd_off == 0)
 		cmd_off = 1;
 
-	return (cmd_on - 1) << 8 | (cmd_off - 1) | (p->use_iordy ? 0x40 : 0x00);
+	if (p->pio_mode > 2 || ide_dev_has_iordy(drive->id))
+		iordy = 0x40;
+
+	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
 }
 
 /*
@@ -82,7 +86,7 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
 
-	drv_ctrl = get_pio_timings(&p);
+	drv_ctrl = get_pio_timings(drive, &p);
 
 	/*
 	 * Store the PIO timings so that we can restore them
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1363,6 +1363,11 @@ extern void ide_toggle_bounce(ide_drive_
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 int ide_use_fast_pio(ide_drive_t *);
 
+static inline int ide_dev_has_iordy(struct hd_driveid *id)
+{
+	return ((id->field_valid & 2) && (id->capability & 8)) ? 1 : 0;
+}
+
 u8 ide_dump_status(ide_drive_t *, const char *, u8);
 
 typedef struct ide_pio_timings_s {
@@ -1374,7 +1379,6 @@ typedef struct ide_pio_timings_s {
 
 typedef struct ide_pio_data_s {
 	u8 pio_mode;
-	u8 use_iordy;
 	unsigned int cycle_time;
 } ide_pio_data_t;
 
