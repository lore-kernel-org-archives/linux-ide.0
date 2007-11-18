From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/21] ide: dump taskfile HOB registers in ide_tf_load() (if DEBUG is defined)
Date: Sun, 18 Nov 2007 23:10:48 +0100
Message-ID: <200711182310.48607.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbXKRWg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Dump taskfile HOB registers in ide_tf_load() (if DEBUG is defined).

* Remove no longer needed DEBUG code from __ide_do_rw_disk().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c     |    7 +------
 drivers/ide/ide-taskfile.c |    4 ++++
 2 files changed, 5 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -245,12 +245,7 @@ static ide_startstop_t __ide_do_rw_disk(
 			tf->lbal   = (u8) block;
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
-#ifdef DEBUG
-			printk("%s: 0x%02x%02x 0x%02x%02x%02x%02x%02x%02x\n",
-				drive->name, tf->hob_nsect, tf->nsect,
-				tf->hob_lbah, tf->hob_lbam, tf->hob_lbal,
-				tf->lbah, tf->lbam, tf->lbal);
-#endif
+
 			task.tf_flags |= (IDE_TFLAG_LBA48 | IDE_TFLAG_OUT_HOB);
 		} else {
 			tf->nsect  = nsectors & 0xff;
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -77,6 +77,10 @@ void ide_tf_load(ide_drive_t *drive, ide
 		"lbam 0x%02x lbah 0x%02x dev 0x%02x cmd 0x%02x\n",
 		drive->name, tf->feature, tf->nsect, tf->lbal,
 		tf->lbam, tf->lbah, tf->device, tf->command);
+	printk("%s: hob: nsect 0x%02x lbal 0x%02x "
+		"lbam 0x%02x lbah 0x%02x\n",
+		drive->name, tf->hob_nsect, tf->hob_lbal,
+		tf->hob_lbam, tf->hob_lbah);
 #endif
 
 	if (IDE_CONTROL_REG)
