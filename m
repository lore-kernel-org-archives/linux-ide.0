From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/21] ide: move ide_pio_cycle_time() to ide-timings.c
Date: Wed, 28 May 2008 23:43:20 +0200
Message-ID: <20080528214320.16327.69738.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:51223 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbYE1Vq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:46:27 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2394621mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:45:46 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

All ide_pio_cycle_time() users already select CONFIG_IDE_TIMINGS
so move the function from ide-lib.c to ide-timings.c.

While at it:

- convert ide_pio_cycle_time() to use ide_timing_find_mode()

- cleanup ide_pio_cycle_time() a bit

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c     |   23 -----------------------
 drivers/ide/ide-timings.c |   22 ++++++++++++++++++++++
 include/linux/ide.h       |    2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -188,29 +188,6 @@ static int ide_scan_pio_blacklist (char 
 	return -1;
 }
 
-unsigned int ide_pio_cycle_time(ide_drive_t *drive, u8 pio)
-{
-	struct hd_driveid *id = drive->id;
-	int cycle_time = 0;
-
-	if (id->field_valid & 2) {
-		if (id->capability & 8)
-			cycle_time = id->eide_pio_iordy;
-		else
-			cycle_time = id->eide_pio;
-	}
-
-	/* conservative "downgrade" for all pre-ATA2 drives */
-	if (pio < 3) {
-		if (cycle_time && cycle_time < ide_pio_timings[pio].cycle_time)
-			cycle_time = 0; /* use standard timing */
-	}
-
-	return cycle_time ? cycle_time : ide_pio_timings[pio].cycle_time;
-}
-
-EXPORT_SYMBOL_GPL(ide_pio_cycle_time);
-
 /**
  *	ide_get_best_pio_mode	-	get PIO mode from drive
  *	@drive: drive to consider
Index: b/drivers/ide/ide-timings.c
===================================================================
--- a/drivers/ide/ide-timings.c
+++ b/drivers/ide/ide-timings.c
@@ -1,5 +1,6 @@
 /*
  *  Copyright (c) 1999-2001 Vojtech Pavlik
+ *  Copyright (c) 2007-2008 Bartlomiej Zolnierkiewicz
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -73,6 +74,27 @@ struct ide_timing *ide_timing_find_mode(
 	return t;
 }
 
+u16 ide_pio_cycle_time(ide_drive_t *drive, u8 pio)
+{
+	struct hd_driveid *id = drive->id;
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
+	u16 cycle = 0;
+
+	if (id->field_valid & 2) {
+		if (id->capability & 8)
+			cycle = id->eide_pio_iordy;
+		else
+			cycle = id->eide_pio;
+
+		/* conservative "downgrade" for all pre-ATA2 drives */
+		if (pio < 3 && cycle < t->cycle)
+			cycle = 0; /* use standard timing */
+	}
+
+	return cycle ? cycle : t->cycle;
+}
+EXPORT_SYMBOL_GPL(ide_pio_cycle_time);
+
 #define ENOUGH(v, unit)		(((v) - 1) / (unit) + 1)
 #define EZ(v, unit)		((v) ? ENOUGH(v, unit) : 0)
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1285,6 +1285,7 @@ enum {
 };
 
 struct ide_timing *ide_timing_find_mode(u8);
+u16 ide_pio_cycle_time(ide_drive_t *, u8);
 void ide_timing_merge(struct ide_timing *, struct ide_timing *,
 		      struct ide_timing *, unsigned int);
 int ide_timing_compute(ide_drive_t *, u8, struct ide_timing *, int, int);
@@ -1296,7 +1297,6 @@ typedef struct ide_pio_timings_s {
 				/* active + recovery (+ setup for some chips) */
 } ide_pio_timings_t;
 
-unsigned int ide_pio_cycle_time(ide_drive_t *, u8);
 u8 ide_get_best_pio_mode(ide_drive_t *, u8, u8);
 extern const ide_pio_timings_t ide_pio_timings[6];
 
