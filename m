From: Doug Maxey <dwm@austin.ibm.com>
Subject: [PATCH] honor IDE drive write cache settings
Date: Tue, 19 Oct 2004 11:15:14 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410191615.i9JGFEXI010445@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-817370000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:59616 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S269503AbUJSQPU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Oct 2004 12:15:20 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>, dwm@maxeymade.com

This is a multipart MIME message.

--==_Exmh_-817370000
Content-Type: text/plain; charset=us-ascii


Bart,

here is a patch that handles drives that come with write cache disabled, 
both as modular and builtin drivers.

++doug


--==_Exmh_-817370000
Content-Type: text/x-patch ; name="honor-write-cache-setting-4.patch"; charset=us-ascii
Content-Description: honor-write-cache-setting-4.patch
Content-Disposition: attachment; filename="honor-write-cache-setting-4.patch"

Name: honor ide drive write cache settings

Description:
	Allows the drive settings of the write cache value to be used
	as the default setting for the drive.  Also, this enables the
	hdparm command HDIO_DRIVE_CMD to be intercepted to call
	ide_write_cache().

	write_cache() has been moved from ide-disk.c, renamed to
	ide_write_cache() which now lives in ide-io.c.

Rationale:
	Some new drives come with write cache off.
	The current driver ignores the default setting, and always
	enabled write cache. In addition, the toggling of the write
	cache did not correctly match the barrier operations when
	changed from command line tools.

Status:
	Tested on power3 and JS20 ppc64, starting with the default
	drive settings, then enabling and disabling cache settings via
	hdparm and blktool, both as modular and builtin driver.


Signed-off-by: Doug Maxey <dwm@austin.ibm.com>

 drivers/ide/ide-disk.c     |   46 +++++----------------------------------------
 drivers/ide/ide-io.c       |   44 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide-taskfile.c |    9 ++++++++
 include/linux/ide.h        |   11 ++++++++++

===== include/linux/ide.h 1.137 vs edited =====
--- 1.137/include/linux/ide.h	2004-10-01 12:55:47 -05:00
+++ edited/include/linux/ide.h	2004-10-18 16:59:24 -05:00
@@ -1638,4 +1638,15 @@ extern struct bus_type ide_bus_type;
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
 
+int ide_write_cache(ide_drive_t *drive, int arg);
+
+static inline sector_t idedisk_capacity (ide_drive_t *drive) {
+	return drive->capacity64 - drive->sect0;
+}
+
+static inline int ide_drive_has_flush_cache (ide_drive_t *drive) {
+	return ((drive->addressing && (idedisk_capacity (drive) > (1ULL << 28)) &&
+		    (ide_id_has_flush_cache_ext(drive->id))) ||
+		(ide_id_has_flush_cache(drive->id)));
+}
 #endif /* _IDE_H */
===== drivers/ide/ide-disk.c 1.96 vs edited =====
--- 1.96/drivers/ide/ide-disk.c	2004-09-10 10:31:30 -05:00
+++ edited/drivers/ide/ide-disk.c	2004-10-18 18:08:42 -05:00
@@ -1061,11 +1061,6 @@ static void init_idedisk_capacity (ide_d
 	}
 }
 
-static sector_t idedisk_capacity (ide_drive_t *drive)
-{
-	return drive->capacity64 - drive->sect0;
-}
-
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
 {
 	special_t *s = &drive->special;
@@ -1311,29 +1306,6 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
-static int write_cache(ide_drive_t *drive, int arg)
-{
-	ide_task_t args;
-	int err;
-
-	if (!ide_id_has_flush_cache(drive->id))
-		return 1;
-
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
-			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
-	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
-	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
-	args.handler				= &task_no_data_intr;
-
-	err = ide_raw_taskfile(drive, &args, NULL);
-	if (err)
-		return err;
-
-	drive->wcache = arg;
-	return 0;
-}
-
 static int do_idedisk_flushcache (ide_drive_t *drive)
 {
 	ide_task_t args;
@@ -1395,7 +1367,7 @@ static void idedisk_add_settings(ide_dri
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
-	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
+	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			ide_write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
@@ -1625,12 +1597,10 @@ static void idedisk_setup (ide_drive_t *
 	}
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 
-	/* write cache enabled? */
+	/* Is write cache enabled on the drive? */
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, 1);
-
 	/*
 	 * We must avoid issuing commands a drive does not understand
 	 * or we may crash it. We check flush cache is supported. We also
@@ -1638,14 +1608,7 @@ static void idedisk_setup (ide_drive_t *
 	 * too large. By this time we have trimmed the drive capacity if
 	 * LBA48 is not available so we don't need to recheck that.
 	 */
-	barrier = 0;
-	if (ide_id_has_flush_cache(id))
-		barrier = 1;
-	if (drive->addressing == 1) {
-		/* Can't issue the correct flush ? */
-		if (capacity > (1ULL << 28) && !ide_id_has_flush_cache_ext(id))
-			barrier = 0;
-	}
+	barrier = ide_drive_has_flush_cache (drive);
 
 	printk(KERN_DEBUG "%s: cache flushes %ssupported\n",
 		drive->name, barrier ? "" : "not ");
@@ -1653,6 +1616,9 @@ static void idedisk_setup (ide_drive_t *
 		blk_queue_ordered(drive->queue, 1);
 		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
 	}
+
+	/* honor the write cache setting of the drive. */
+	ide_write_cache(drive, drive->wcache);
 }
 
 static void ide_cacheflush_p(ide_drive_t *drive)
===== drivers/ide/ide-io.c 1.30 vs edited =====
--- 1.30/drivers/ide/ide-io.c	2004-09-23 14:29:34 -05:00
+++ edited/drivers/ide/ide-io.c	2004-10-18 18:11:54 -05:00
@@ -251,6 +251,50 @@ u64 ide_get_error_location(ide_drive_t *
 }
 EXPORT_SYMBOL(ide_get_error_location);
 
+/**
+ * ide_write_cache - sets the write cache of the drive
+ * @drive: target_drive
+ * @arg: 1 to enable write cache, 0 to disable.
+ *
+ * keeps the barrier settings in sync with the write cache settings.
+ *
+ */
+int ide_write_cache(ide_drive_t *drive, int arg)
+{
+	ide_task_t args;
+	int err, barrier;
+
+	/*
+	 * If we have a drive that does not support write cache, do not
+	 * attempt to change the write cache setting.
+	 */
+
+	if (!(drive->id->command_set_1 & (1 << 5)))
+		return -EIO;	/* Would prefer ENXIO for command not supported... */
+
+	barrier = ide_drive_has_flush_cache (drive);
+
+	memset(&args, 0, sizeof(ide_task_t));
+	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
+			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
+	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= &task_no_data_intr;
+
+	err = ide_raw_taskfile(drive, &args, NULL);
+	if (err)
+		return err;
+
+	blk_queue_ordered(drive->queue, (arg && barrier));
+
+	printk (KERN_INFO "%s: cache=%d barrier=%d\n", __FUNCTION__, arg, barrier);
+
+	drive->wcache = arg;
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ide_write_cache);
+
 static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
 				 int error)
 {
===== drivers/ide/ide-taskfile.c 1.63 vs edited =====
--- 1.63/drivers/ide/ide-taskfile.c	2004-10-10 10:47:04 -05:00
+++ edited/drivers/ide/ide-taskfile.c	2004-10-18 16:45:55 -05:00
@@ -727,6 +727,15 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	if (copy_from_user(args, (void __user *)arg, 4))
 		return -EFAULT;
 
+	if ((args[2] == SETFEATURES_EN_WCACHE) ||
+	    (args[2] == SETFEATURES_DIS_WCACHE)) {
+		/*
+		 * Call the handler to support settings in the block layer.
+		 */
+		err = ide_write_cache (drive, (args[2] == SETFEATURES_EN_WCACHE));
+		return err;
+	}
+
 	memset(&tfargs, 0, sizeof(ide_task_t));
 	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
 	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];

--==_Exmh_-817370000--


