From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 7/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:17:11 -0600
Message-ID: <200501281817.j0SIHBnR021139@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.130]:27530 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262726AbVA1SRR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:17:17 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIHGul730278
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:17:16 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIHG58444738
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:17:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIHFJL013870
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:17:15 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - move idedisk_issue_flush to ide-io.c supporting
      ide_write_cache()

 include/linux/ide.h    |    1 -
 drivers/ide/ide-disk.c |   38 --------------------------------------
 drivers/ide/ide-io.c   |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 39 deletions(-)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/include/linux/ide.h lk-2.6.11-rc2-bk5.b/include/linux/ide.h
--- lk-2.6.11-rc2-bk5.a/include/linux/ide.h	2005-01-28 11:39:37.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/include/linux/ide.h	2005-01-28 11:41:48.361837912 -0600
@@ -1566,5 +1566,4 @@ static inline int ide_drive_has_flush_ca
 		    (ide_id_has_flush_cache_ext(drive->id))) ||
 		(ide_id_has_flush_cache(drive->id)));
 }
-int idedisk_issue_flush(request_queue_t *, struct gendisk *, sector_t *);
 #endif /* _IDE_H */
diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c	2005-01-28 11:39:37.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c	2005-01-28 11:41:48.363837608 -0600
@@ -697,44 +697,6 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #endif	/* CONFIG_PROC_FS */
 
-int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
-			       sector_t *error_sector)
-{
-	ide_drive_t *drive = q->queuedata;
-	struct request *rq;
-	int ret;
-
-	if (!drive->wcache)
-		return 0;
-
-	rq = blk_get_request(q, WRITE, __GFP_WAIT);
-
-	memset(rq->cmd, 0, sizeof(rq->cmd));
-
-	if (ide_id_has_flush_cache_ext(drive->id) &&
-	    (drive->capacity64 >= (1UL << 28)))
-		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
-	else
-		rq->cmd[0] = WIN_FLUSH_CACHE;
-
-
-	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
-	rq->buffer = rq->cmd;
-
-	ret = blk_execute_rq(q, disk, rq);
-
-	/*
-	 * if we failed and caller wants error offset, get it
-	 */
-	if (ret && error_sector)
-		*error_sector = ide_get_error_location(drive, rq->cmd);
-
-	blk_put_request(rq);
-	return ret;
-}
-
-EXPORT_SYMBOL_GPL(idedisk_issue_flush);
-
 /*
  * This is tightly woven into the driver->do_special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-io.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-io.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-io.c	2005-01-28 11:39:37.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-io.c	2005-01-28 11:41:48.000000000 -0600
@@ -1632,6 +1632,42 @@ int ide_do_drive_cmd (ide_drive_t *drive
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
 
+int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
+			       sector_t *error_sector)
+{
+	ide_drive_t *drive = q->queuedata;
+	struct request *rq;
+	int ret;
+
+	if (!drive->wcache)
+		return 0;
+
+	rq = blk_get_request(q, WRITE, __GFP_WAIT);
+
+	memset(rq->cmd, 0, sizeof(rq->cmd));
+
+	if (ide_id_has_flush_cache_ext(drive->id) &&
+	    (drive->capacity64 >= (1UL << 28)))
+		rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
+	else
+		rq->cmd[0] = WIN_FLUSH_CACHE;
+
+
+	rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
+	rq->buffer = rq->cmd;
+
+	ret = blk_execute_rq(q, disk, rq);
+
+	/*
+	 * if we failed and caller wants error offset, get it
+	 */
+	if (ret && error_sector)
+		*error_sector = ide_get_error_location(drive, rq->cmd);
+
+	blk_put_request(rq);
+	return ret;
+}
+
 /**
  * ide_write_cache - sets the write cache of the drive
  * @drive: target_drive


