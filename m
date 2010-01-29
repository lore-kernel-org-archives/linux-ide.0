From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 23/68] ide: add drive->class field
Date: Fri, 29 Jan 2010 17:05:38 +0100
Message-ID: <20100129160538.21495.73166.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754481Ab0A2QFz@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add drive->class field

Add class field to ide_drive_t matching class field used in
struct ata_device.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -520,7 +520,13 @@ struct ide_drive_s {
         u8	dn;		/* now wide spread use */
 	u8	devno;		/* 0 or 1 */
 	u8	acoustic;	/* acoustic management */
-	u8	media;		/* disk, cdrom, tape, floppy, ... */
+
+	/* disk, cdrom, tape, floppy, ... */
+	union {
+		u8	media;
+		u8	class;
+	};
+
 	u8	ready_stat;	/* min status value for drive ready */
 	u8	mult_count;	/* current multiple sector setting */
 	u8	mult_req;	/* requested multiple sector setting */
