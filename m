From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/21] ide: checkpatch.pl fixes for ide-timing.h
Date: Wed, 28 May 2008 23:40:35 +0200
Message-ID: <20080528214035.16327.47067.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:49842 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbYE1VnD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:43:03 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2393896mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:43:01 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Also fix placement of comments in ide_timing_compute() while at it.

There should be no functional changes caused by this patch
(md5sum was verified to be the same before/after the patch).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timing.h |   93 ++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 45 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -3,9 +3,7 @@
 
 /*
  *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -32,7 +30,7 @@
  * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
  * These were taken from ATA/ATAPI-6 standard, rev 0a, except
  * for PIO 5, which is a nonstandard extension and UDMA6, which
- * is currently supported only by Maxtor drives. 
+ * is currently supported only by Maxtor drives.
  */
 
 static struct ide_timing ide_timing[] = {
@@ -67,10 +65,11 @@ static struct ide_timing ide_timing[] = 
 	{ 0xff }
 };
 
-#define ENOUGH(v,unit)		(((v)-1)/(unit)+1)
-#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
+#define ENOUGH(v, unit)		(((v) - 1) / (unit) + 1)
+#define EZ(v, unit)		((v) ? ENOUGH(v, unit) : 0)
 
-static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
+static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q,
+				int T, int UT)
 {
 	q->setup   = EZ(t->setup   * 1000,  T);
 	q->act8b   = EZ(t->act8b   * 1000,  T);
@@ -82,16 +81,25 @@ static void ide_timing_quantize(struct i
 	q->udma    = EZ(t->udma    * 1000, UT);
 }
 
-static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
+static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b,
+			     struct ide_timing *m, unsigned int what)
 {
-	if (what & IDE_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
-	if (what & IDE_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
-	if (what & IDE_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
-	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
-	if (what & IDE_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
-	if (what & IDE_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
-	if (what & IDE_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
-	if (what & IDE_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
+	if (what & IDE_TIMING_SETUP)
+		m->setup   = max(a->setup,   b->setup);
+	if (what & IDE_TIMING_ACT8B)
+		m->act8b   = max(a->act8b,   b->act8b);
+	if (what & IDE_TIMING_REC8B)
+		m->rec8b   = max(a->rec8b,   b->rec8b);
+	if (what & IDE_TIMING_CYC8B)
+		m->cyc8b   = max(a->cyc8b,   b->cyc8b);
+	if (what & IDE_TIMING_ACTIVE)
+		m->active  = max(a->active,  b->active);
+	if (what & IDE_TIMING_RECOVER)
+		m->recover = max(a->recover, b->recover);
+	if (what & IDE_TIMING_CYCLE)
+		m->cycle   = max(a->cycle,   b->cycle);
+	if (what & IDE_TIMING_UDMA)
+		m->udma    = max(a->udma,    b->udma);
 }
 
 static struct ide_timing *ide_timing_find_mode(u8 speed)
@@ -101,7 +109,7 @@ static struct ide_timing *ide_timing_fin
 	for (t = ide_timing; t->mode != speed; t++)
 		if (t->mode == 0xff)
 			return NULL;
-	return t; 
+	return t;
 }
 
 static int ide_timing_compute(ide_drive_t *drive, u8 speed,
@@ -110,24 +118,22 @@ static int ide_timing_compute(ide_drive_
 	struct hd_driveid *id = drive->id;
 	struct ide_timing *s, p;
 
-/*
- * Find the mode.
- */
-
-	if (!(s = ide_timing_find_mode(speed)))
+	/*
+	 * Find the mode.
+	 */
+	s = ide_timing_find_mode(speed);
+	if (s == NULL)
 		return -EINVAL;
 
-/*
- * Copy the timing from the table.
- */
-
+	/*
+	 * Copy the timing from the table.
+	 */
 	*t = *s;
 
-/*
- * If the drive is an EIDE drive, it can tell us it needs extended
- * PIO/MWDMA cycle timing.
- */
-
+	/*
+	 * If the drive is an EIDE drive, it can tell us it needs extended
+	 * PIO/MWDMA cycle timing.
+	 */
 	if (id && id->field_valid & 2) {	/* EIDE drive */
 
 		memset(&p, 0, sizeof(p));
@@ -142,28 +148,25 @@ static int ide_timing_compute(ide_drive_
 		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
 	}
 
-/*
- * Convert the timing to bus clock counts.
- */
-
+	/*
+	 * Convert the timing to bus clock counts.
+	 */
 	ide_timing_quantize(t, t, T, UT);
 
-/*
- * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
- * and some other commands. We have to ensure that the DMA cycle timing is
- * slower/equal than the fastest PIO timing.
- */
-
+	/*
+	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
+	 */
 	if (speed >= XFER_SW_DMA_0) {
 		u8 pio = ide_get_best_pio_mode(drive, 255, 5);
 		ide_timing_compute(drive, XFER_PIO_0 + pio, &p, T, UT);
 		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
 	}
 
-/*
- * Lengthen active & recovery time so that cycle time is correct.
- */
-
+	/*
+	 * Lengthen active & recovery time so that cycle time is correct.
+	 */
 	if (t->act8b + t->rec8b < t->cyc8b) {
 		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
 		t->rec8b = t->cyc8b - t->act8b;
