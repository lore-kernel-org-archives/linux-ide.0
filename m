From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status
Date: Mon, 27 Apr 2009 18:03:49 +0200
Message-ID: <9ea470500904270903n720ab411o4a6c47945442bea4@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54495 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbZD0QDv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Apr 2009 12:03:51 -0400
Received: by fxm2 with SMTP id 2so2406168fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 09:03:49 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Helge Deller <deller@gmx.de>, Jens Axboe <jens.axboe@oracle.com>

From: Borislav Petkov <petkovbb@gmail.com>
Date: Mon, 27 Apr 2009 14:11:32 +0200
Subject: [PATCH] ide-cd: fix REQ_QUIET tests in cdrom_decode_status

Original patch (dfa4411cc3a690011cab90e9a536938795366cf9) was buggy.
This is a more proper fix which introduces blk_rq_quiet() macro
alleviating the need for dumb, too short caching variables.

Thanks to Helge Deller and Bart for debugging this.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c   |    9 ++++-----
 include/linux/blkdev.h |    1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 6736287..a75e4ee 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -283,7 +283,6 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
 	int err, sense_key, do_end_request = 0;
-	u8 quiet = rq->cmd_flags & REQ_QUIET;

 	/* get the IDE error register */
 	err = ide_read_error(drive);
@@ -318,7 +317,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		} else {
 			cdrom_saw_media_change(drive);

-			if (blk_fs_request(rq) && !quiet)
+			if (blk_fs_request(rq) && !blk_rq_quiet(rq))
 				printk(KERN_ERR PFX "%s: tray open\n",
 					drive->name);
 		}
@@ -353,7 +352,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * No point in retrying after an illegal request or data
 		 * protect error.
 		 */
-		if (!quiet)
+		if (!blk_rq_quiet(rq))
 			ide_dump_status(drive, "command error", stat);
 		do_end_request = 1;
 		break;
@@ -362,14 +361,14 @@ static int cdrom_decode_status(ide_drive_t
*drive, u8 stat)
 		 * No point in re-trying a zillion times on a bad sector.
 		 * If we got here the error is not correctable.
 		 */
-		if (!quiet)
+		if (!blk_rq_quiet(rq))
 			ide_dump_status(drive, "media error "
 					"(bad sector)", stat);
 		do_end_request = 1;
 		break;
 	case BLANK_CHECK:
 		/* disk appears blank? */
-		if (!quiet)
+		if (!blk_rq_quiet(rq))
 			ide_dump_status(drive, "media error (blank)",
 					stat);
 		do_end_request = 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba54c83..6f841fb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -598,6 +598,7 @@ enum {
 				 blk_failfast_transport(rq) ||	\
 				 blk_failfast_driver(rq))
 #define blk_rq_started(rq)	((rq)->cmd_flags & REQ_STARTED)
+#define blk_rq_quiet(rq)	((rq)->cmd_flags & REQ_QUIET)

 #define blk_account_rq(rq)	(blk_rq_started(rq) && (blk_fs_request(rq)
|| blk_discard_rq(rq)))

-- 
1.6.2.4


-- 
Regards/Gruss,
Boris
