From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/15] ide: remove QUIRK_LIST()
Date: Wed, 31 Oct 2007 00:31:05 +0100
Message-ID: <200710310031.06051.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:45663 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbXJ3Xu2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 19:50:28 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1788122nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 16:50:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c  |    6 ------
 drivers/ide/ide-probe.c |    5 ++++-
 include/linux/ide.h     |    1 -
 3 files changed, 4 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -189,12 +189,6 @@ void SELECT_MASK (ide_drive_t *drive, in
 		HWIF(drive)->maskproc(drive, mask);
 }
 
-void QUIRK_LIST (ide_drive_t *drive)
-{
-	if (HWIF(drive)->quirkproc)
-		drive->quirk_list = HWIF(drive)->quirkproc(drive);
-}
-
 /*
  * Some localbus EIDE interfaces require a special access sequence
  * when using 32-bit I/O instructions to transfer data.  We call this
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -247,7 +247,10 @@ static inline void do_identify (ide_driv
 
 	drive->media = ide_disk;
 	printk("%s DISK drive\n", (id->config == 0x848a) ? "CFA" : "ATA" );
-	QUIRK_LIST(drive);
+
+	if (hwif->quirkproc)
+		drive->quirk_list = hwif->quirkproc(drive);
+
 	return;
 
 err_misc:
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -971,7 +971,6 @@ extern u32 ide_read_24(ide_drive_t *);
 extern void SELECT_DRIVE(ide_drive_t *);
 extern void SELECT_INTERRUPT(ide_drive_t *);
 extern void SELECT_MASK(ide_drive_t *, int);
-extern void QUIRK_LIST(ide_drive_t *);
 
 extern int drive_is_ready(ide_drive_t *);
 
