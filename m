From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 6/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:17:03 -0600
Message-ID: <200501281817.j0SIH3lO021130@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.129]:57800 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262730AbVA1SRG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:17:06 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIH5m4328204
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:17:05 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIH5qw318718
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:17:05 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIH4g4013471
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:17:05 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - change the way that ide_write_cache controls the use of flushing
      via blk_queue_ordered() to match the setting of the drive's
      write cache setting.  This patch leaves the idedisk_issue_flush
      in ide-disk.c, but the func could be moved to ide-io to complete
      the break of the dependency between ide-io and ide-disk.

 include/linux/ide.h    |   13 +++++++++++++
 drivers/ide/ide-disk.c |   29 +++++++----------------------
 drivers/ide/ide-io.c   |   32 ++++++++++++++++++++++++++++----
 3 files changed, 48 insertions(+), 26 deletions(-)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/include/linux/ide.h lk-2.6.11-rc2-bk5.b/include/linux/ide.h
--- lk-2.6.11-rc2-bk5.a/include/linux/ide.h	2005-01-28 11:31:50.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/include/linux/ide.h	2005-01-28 11:39:37.486733952 -0600
@@ -1554,4 +1554,17 @@ int ide_write_cache(ide_drive_t *, int);
 #define BLK_DEV_HDWC 0
 #endif /* CONFIG_BLK_DEV_HDWC */
 
+static inline sector_t idedisk_capacity (ide_drive_t *drive)
+{
+	return drive->capacity64 - drive->sect0;
+}
+
+/* combine the tests above */
+static inline int ide_drive_has_flush_cache (ide_drive_t *drive)
+{
+	return ((drive->addressing && (idedisk_capacity (drive) > (1ULL << 28)) &&
+		    (ide_id_has_flush_cache_ext(drive->id))) ||
+		(ide_id_has_flush_cache(drive->id)));
+}
+int idedisk_issue_flush(request_queue_t *, struct gendisk *, sector_t *);
 #endif /* _IDE_H */
diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c	2005-01-28 11:36:52.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c	2005-01-28 11:39:37.493732888 -0600
@@ -512,10 +512,6 @@ static void init_idedisk_capacity (ide_d
 	}
 }
 
-static sector_t idedisk_capacity (ide_drive_t *drive)
-{
-	return drive->capacity64 - drive->sect0;
-}
 
 #define IS_PDC4030_DRIVE	0
 
@@ -701,7 +697,7 @@ static ide_proc_entry_t idedisk_proc[] =
 
 #endif	/* CONFIG_PROC_FS */
 
-static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
+int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
 			       sector_t *error_sector)
 {
 	ide_drive_t *drive = q->queuedata;
@@ -737,6 +733,8 @@ static int idedisk_issue_flush(request_q
 	return ret;
 }
 
+EXPORT_SYMBOL_GPL(idedisk_issue_flush);
+
 /*
  * This is tightly woven into the driver->do_special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
@@ -920,7 +918,6 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
-	int barrier;
 
 	idedisk_add_settings(drive);
 
@@ -1060,8 +1057,6 @@ static void idedisk_setup (ide_drive_t *
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	ide_write_cache(drive, (BLK_DEV_HDWC ? drive->wcache : 1));
-
 	/*
 	 * We must avoid issuing commands a drive does not understand
 	 * or we may crash it. We check flush cache is supported. We also
@@ -1069,26 +1064,16 @@ static void idedisk_setup (ide_drive_t *
 	 * too large. By this time we have trimmed the drive capacity if
 	 * LBA48 is not available so we don't need to recheck that.
 	 */
-	barrier = 0;
-	if (ide_id_has_flush_cache(id) && drive->wcache)
-		barrier = 1;
-	if (drive->addressing == 1) {
-		/* Can't issue the correct flush ? */
-		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
-			barrier = 0;
-	}
 
 	printk(KERN_DEBUG "%s: cache flushes %ssupported\n",
-		drive->name, barrier ? "" : "not ");
-	if (barrier) {
-		blk_queue_ordered(drive->queue, 1);
-		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
-	}
+		drive->name, ide_drive_has_flush_cache (drive) ? "" : "not ");
+	ide_write_cache(drive, (BLK_DEV_HDWC ? drive->wcache : 1));
+
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
 {
-	if (!drive->wcache || !ide_id_has_flush_cache(drive->id))
+	if (!drive->wcache || !ide_drive_has_flush_cache(drive))
 		return;
 
 	if (do_idedisk_flushcache(drive))
diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-io.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-io.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-io.c	2005-01-28 09:47:00.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-io.c	2005-01-28 11:39:37.518729088 -0600
@@ -1632,19 +1632,31 @@ int ide_do_drive_cmd (ide_drive_t *drive
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
 
+/**
+ * ide_write_cache - sets the write cache of the drive
+ * @drive: target_drive
+ * @arg: non-zero to enable write cache, 0 to disable.
+ *
+ * keeps the barrier settings in sync with the write cache settings.
+ *
+ * This implementation moves the barrier setting done once previously in
+ * idedisk_setup() to this location to allow the external caller to correctly
+ * set the drive barrier, which must be off if the write cache is not enabled.
+ *
+ */
 
 int ide_write_cache(ide_drive_t *drive, int arg)
 {
+#ifdef CONFIG_BLK_DEV_IDEDISK
 	ide_task_t args;
-	int err;
+	int err, barrier;
 
 	/*
 	 * If we have a drive that does not support flush, do not
 	 * attempt to change the write cache setting.
 	 */
-	if ((!ide_id_has_flush_cache(drive->id)) ||
-	    (drive->addressing && (!ide_id_has_flush_cache_ext(drive->id))))
- 		return 1;
+	if (!(barrier = ide_drive_has_flush_cache (drive)))
+ 		return -ENXIO;
 
 	memset(&args, 0, sizeof(ide_task_t));
 	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
@@ -1657,7 +1669,19 @@ int ide_write_cache(ide_drive_t *drive, 
 	if (err)
 		return err;
 
+	if (arg && barrier) {
+		blk_queue_ordered(drive->queue, 1);
+		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	}
+	else {
+		blk_queue_ordered(drive->queue, 0);
+		blk_queue_issue_flush_fn(drive->queue, NULL);
+	}
+
+	printk (KERN_INFO "%s: cache=%d barrier=%d\n", __FUNCTION__, arg, barrier);
+
 	drive->wcache = arg;
+#endif /* CONFIG_BLK_DEV_IDEDISK */
 	return 0;
 }
 


