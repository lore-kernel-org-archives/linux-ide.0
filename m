From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/15] ide: remove SELECT_INTERRUPT()
Date: Wed, 31 Oct 2007 00:32:00 +0100
Message-ID: <200710310032.00511.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:45723 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbXJ3Xu3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788117nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |    5 ++++-
 drivers/ide/ide-iops.c |    8 --------
 include/linux/ide.h    |    1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1199,7 +1199,10 @@ static void ide_do_request (ide_hwgroup_
 		    hwif != hwgroup->hwif &&
 		    hwif->io_ports[IDE_CONTROL_OFFSET]) {
 			/* set nIEN for previous hwif */
-			SELECT_INTERRUPT(drive);
+			if (hwif->intrproc)
+				hwif->intrproc(drive);
+			else
+				hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -175,14 +175,6 @@ void SELECT_DRIVE (ide_drive_t *drive)
 
 EXPORT_SYMBOL(SELECT_DRIVE);
 
-void SELECT_INTERRUPT (ide_drive_t *drive)
-{
-	if (HWIF(drive)->intrproc)
-		HWIF(drive)->intrproc(drive);
-	else
-		HWIF(drive)->OUTB(drive->ctl|2, IDE_CONTROL_REG);
-}
-
 void SELECT_MASK (ide_drive_t *drive, int mask)
 {
 	if (HWIF(drive)->maskproc)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -969,7 +969,6 @@ void ide_tf_load(ide_drive_t *, ide_task
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
-extern void SELECT_INTERRUPT(ide_drive_t *);
 extern void SELECT_MASK(ide_drive_t *, int);
 
 extern int drive_is_ready(ide_drive_t *);
