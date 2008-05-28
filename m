From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/21] ide: use u8 for xfer modes in ide-timing.h
Date: Wed, 28 May 2008 23:40:10 +0200
Message-ID: <20080528214010.16327.75848.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:50110 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbYE1Vmg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:42:36 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2393895mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:42:35 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timing.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -29,7 +29,7 @@
 #include <linux/hdreg.h>
 
 struct ide_timing {
-	short mode;
+	u8    mode;
 	short setup;	/* t1 */
 	short act8b;	/* t2 for 8-bit io */
 	short rec8b;	/* t2i for 8-bit io */
@@ -76,7 +76,7 @@ static struct ide_timing ide_timing[] = 
 
 	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 },
 
-	{ -1 }
+	{ 0xff }
 };
 
 #define IDE_TIMING_SETUP	0x01
@@ -122,17 +122,18 @@ static void ide_timing_merge(struct ide_
 	if (what & IDE_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
 
-static struct ide_timing* ide_timing_find_mode(short speed)
+static struct ide_timing *ide_timing_find_mode(u8 speed)
 {
 	struct ide_timing *t;
 
 	for (t = ide_timing; t->mode != speed; t++)
-		if (t->mode < 0)
+		if (t->mode == 0xff)
 			return NULL;
 	return t; 
 }
 
-static int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
+static int ide_timing_compute(ide_drive_t *drive, u8 speed,
+			      struct ide_timing *t, int T, int UT)
 {
 	struct hd_driveid *id = drive->id;
 	struct ide_timing *s, p;
