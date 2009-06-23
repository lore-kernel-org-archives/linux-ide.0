From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch 3/6] ide: always kill the whole request on error
Date: Tue, 23 Jun 2009 23:27:27 +0200
Message-ID: <200906232327.27610.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:39092 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbZFWVcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 17:32:31 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: always kill the whole request on error

* Use blk_rq_bytes() instead of obsolete ide_rq_bytes() in ide_kill_rq()
  and ide_floppy_do_request() for failed requests.
  [ bugfix part ]

* Use blk_rq_bytes() instead of obsolete ide_rq_bytes() in ide_do_devset()
  and ide_complete_drive_reset().  Then remove ide_rq_bytes().
  [ cleanup part ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
'cleanup part' tested, limited testing with 'bugfix part'
(using simulated failures of disk fs requests)

 drivers/ide/ide-devsets.c |    2 +-
 drivers/ide/ide-eh.c      |    2 +-
 drivers/ide/ide-floppy.c  |    2 +-
 drivers/ide/ide-io.c      |   14 ++------------
 include/linux/ide.h       |    1 -
 5 files changed, 5 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide-devsets.c
===================================================================
--- a/drivers/ide/ide-devsets.c
+++ b/drivers/ide/ide-devsets.c
@@ -183,6 +183,6 @@ ide_startstop_t ide_do_devset(ide_drive_
 	err = setfunc(drive, *(int *)&rq->cmd[1]);
 	if (err)
 		rq->errors = err;
-	ide_complete_rq(drive, err, ide_rq_bytes(rq));
+	ide_complete_rq(drive, err, blk_rq_bytes(rq));
 	return ide_stopped;
 }
Index: b/drivers/ide/ide-eh.c
===================================================================
--- a/drivers/ide/ide-eh.c
+++ b/drivers/ide/ide-eh.c
@@ -149,7 +149,7 @@ static inline void ide_complete_drive_re
 	if (rq && blk_special_request(rq) && rq->cmd[0] == REQ_DRIVE_RESET) {
 		if (err <= 0 && rq->errors == 0)
 			rq->errors = -EIO;
-		ide_complete_rq(drive, err ? err : 0, ide_rq_bytes(rq));
+		ide_complete_rq(drive, err ? err : 0, blk_rq_bytes(rq));
 	}
 }
 
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -293,7 +293,7 @@ out_end:
 	drive->failed_pc = NULL;
 	if (blk_fs_request(rq) == 0 && rq->errors == 0)
 		rq->errors = -EIO;
-	ide_complete_rq(drive, -EIO, ide_rq_bytes(rq));
+	ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
 	return ide_stopped;
 }
 
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -112,16 +112,6 @@ void ide_complete_cmd(ide_drive_t *drive
 	}
 }
 
-/* obsolete, blk_rq_bytes() should be used instead */
-unsigned int ide_rq_bytes(struct request *rq)
-{
-	if (blk_pc_request(rq))
-		return blk_rq_bytes(rq);
-	else
-		return blk_rq_cur_sectors(rq) << 9;
-}
-EXPORT_SYMBOL_GPL(ide_rq_bytes);
-
 int ide_complete_rq(ide_drive_t *drive, int error, unsigned int nr_bytes)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -152,14 +142,14 @@ void ide_kill_rq(ide_drive_t *drive, str
 
 	if ((media == ide_floppy || media == ide_tape) && drv_req) {
 		rq->errors = 0;
-		ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
 	} else {
 		if (media == ide_tape)
 			rq->errors = IDE_DRV_ERROR_GENERAL;
 		else if (blk_fs_request(rq) == 0 && rq->errors == 0)
 			rq->errors = -EIO;
-		ide_complete_rq(drive, -EIO, ide_rq_bytes(rq));
 	}
+
+	ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
 }
 
 static void ide_tf_set_specify_cmd(ide_drive_t *drive, struct ide_taskfile *tf)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1062,7 +1062,6 @@ int generic_ide_ioctl(ide_drive_t *, str
 extern int ide_vlb_clk;
 extern int ide_pci_clk;
 
-unsigned int ide_rq_bytes(struct request *);
 int ide_end_rq(ide_drive_t *, struct request *, int, unsigned int);
 void ide_kill_rq(ide_drive_t *, struct request *);
 
