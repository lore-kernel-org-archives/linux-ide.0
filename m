From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/22] ide: add ide_do_test_unit_ready() helper
Date: Sun, 10 Aug 2008 17:37:00 +0200
Message-ID: <20080810153700.16255.79527.sendpatchset@localhost.localdomain>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:13064 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbYHJPjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:39:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1414994fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:39:12 -0700 (PDT)
In-Reply-To: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Add ide_do_test_unit_ready() helper and convert ide-{floppy,tape}.c
  to use it.

* Remove no longer used idetape_create_test_unit_ready_cmd().

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-atapi.c  |   11 +++++++++++
 drivers/ide/ide-floppy.c |    6 +-----
 drivers/ide/ide-tape.c   |   10 +---------
 include/linux/ide.h      |    1 +
 4 files changed, 14 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-atapi.c
===================================================================
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -162,6 +162,17 @@ int ide_queue_pc_tail(ide_drive_t *drive
 }
 EXPORT_SYMBOL_GPL(ide_queue_pc_tail);
 
+int ide_do_test_unit_ready(ide_drive_t *drive, struct gendisk *disk)
+{
+	struct ide_atapi_pc pc;
+
+	ide_init_pc(&pc);
+	pc.c[0] = TEST_UNIT_READY;
+
+	return ide_queue_pc_tail(drive, disk, &pc);
+}
+EXPORT_SYMBOL_GPL(ide_do_test_unit_ready);
+
 int ide_do_start_stop(ide_drive_t *drive, struct gendisk *disk, int start)
 {
 	struct ide_atapi_pc pc;
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -772,7 +772,6 @@ static int idefloppy_open(struct inode *
 	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct ide_floppy_obj *floppy;
 	ide_drive_t *drive;
-	struct ide_atapi_pc pc;
 	int ret = 0;
 
 	debug_log("Reached %s\n", __func__);
@@ -789,10 +788,7 @@ static int idefloppy_open(struct inode *
 		drive->atapi_flags &= ~IDE_AFLAG_FORMAT_IN_PROGRESS;
 		/* Just in case */
 
-		ide_init_pc(&pc);
-		pc.c[0] = GPCMD_TEST_UNIT_READY;
-
-		if (ide_queue_pc_tail(drive, disk, &pc))
+		if (ide_do_test_unit_ready(drive, disk))
 			ide_do_start_stop(drive, disk, 1);
 
 		if (ide_floppy_get_capacity(drive)
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1118,25 +1118,17 @@ static void idetape_create_write_filemar
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
 }
 
-static void idetape_create_test_unit_ready_cmd(struct ide_atapi_pc *pc)
-{
-	ide_init_pc(pc);
-	pc->c[0] = TEST_UNIT_READY;
-}
-
 static int idetape_wait_ready(ide_drive_t *drive, unsigned long timeout)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct gendisk *disk = tape->disk;
-	struct ide_atapi_pc pc;
 	int load_attempted = 0;
 
 	/* Wait for the tape to become ready */
 	set_bit(IDE_AFLAG_MEDIUM_PRESENT, &drive->atapi_flags);
 	timeout += jiffies;
 	while (time_before(jiffies, timeout)) {
-		idetape_create_test_unit_ready_cmd(&pc);
-		if (!ide_queue_pc_tail(drive, disk, &pc))
+		if (ide_do_test_unit_ready(drive, disk) == 0)
 			return 0;
 		if ((tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2)
 		    || (tape->asc == 0x3A)) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1140,6 +1140,7 @@ void ide_queue_pc_head(ide_drive_t *, st
 		       struct request *);
 int ide_queue_pc_tail(ide_drive_t *, struct gendisk *, struct ide_atapi_pc *);
 
+int ide_do_test_unit_ready(ide_drive_t *, struct gendisk *);
 int ide_do_start_stop(ide_drive_t *, struct gendisk *, int);
 int ide_set_media_lock(ide_drive_t *, struct gendisk *, int);
 
