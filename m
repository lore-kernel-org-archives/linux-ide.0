From: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: [PATCH] honor IDE drive write cache settings (respin#1)
Date: Tue, 19 Oct 2004 13:21:16 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410191821.i9JILGLl011765@falcon10.austin.ibm.com>
References: <58cb370e04101910153f179edc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pixpat.austin.ibm.com ([192.35.232.241]:49231 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S269582AbUJSSVW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Oct 2004 14:21:22 -0400
In-reply-to: <58cb370e04101910153f179edc@mail.gmail.com> 
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Respin at the bottom...

On Tue, 19 Oct 2004 19:15:27 +0200, Bartlomiej Zolnierkiewicz wrote:
>Hi Doug,
>
>On Tue, 19 Oct 2004 11:15:14 -0500, Doug Maxey <dwm@austin.ibm.com> wrote:
>> 
>> Bart,
>> 
>> here is a patch that handles drives that come with write cache disabled,
>> both as modular and builtin drivers.
>
>This patch seems to be trying to do too much in one go and we've learned
>(by experience :) that write cache related changes should be done in small
>steps.  Please split your patch to:
>
>* HDIO_DRIVE_CMD fix
>* honor disk write cache fix
>* "barrier" fix (this one needs some more thinking)
>
>Do you care to also make "disable write cache by default" patch?

This patch neither enables or disables write cache, it simply honors what
the drive is set for, and ensure the correct barrier handling.  The code
as it exists is broken when attempting to change the write cache from
hdparm, and is broken when attaching the drive.  There is no reason that I
can see to enable any of it without all of it.  Other than to break it up.

Bottom line is that none of this is standalone.

>
>+static inline sector_t idedisk_capacity (ide_drive_t *drive) {
>+	return drive->capacity64 - drive->sect0;
>+}
>+
>+static inline int ide_drive_has_flush_cache (ide_drive_t *drive) {
>+	return ((drive->addressing && (idedisk_capacity (drive) > (1ULL << 28)) &&
>+		    (ide_id_has_flush_cache_ext(drive->id))) ||
>+		(ide_id_has_flush_cache(drive->id)));
>+}
>
>please fix it to be more readable
>(see Documentation/CodingStyle)

I believe inlines are more readable when the open brace is trailing,
a clear visual indication.  I do agree that is the appropriate style
for .c files

>
>foo()
>{
>}
>
>+	 * If we have a drive that does not support write cache, do not
>+	 * attempt to change the write cache setting.
>+	 */
>+
>+	if (!(drive->id->command_set_1 & (1 << 5)))
>+		return -EIO;	/* Would prefer ENXIO for command not supported... */
>
>Is this enough?  IMO it is the best to leave it alone for now...

The previous test was for FLUSH incarnations, which I believe was
an error.  Barrier tests are done later.  The kernel barrier=off is
a kludge at best, and if the drive DOES have write cache enabled,
is a window for data loss.  Not much of an issue on a workstation,
but really a concern for server class machines.

>
>+	if ((args[2] == SETFEATURES_EN_WCACHE) ||
>+	    (args[2] == SETFEATURES_DIS_WCACHE)) {
>+		/*
>+		 * Call the handler to support settings in the block layer.
>+		 */
>+		err = ide_write_cache (drive, (args[2] == SETFEATURES_EN_WCACHE));
>+		return err;
>+	}
>
>This check is only valid for XFER_SETFEATURES command...
>

That is the only part that should be looked at in reference to
enable/disable the write cache.  No tool currently (that I could find :)
uses the HDIO_{G,S}_WCACHE.  Ah, Ok, good catch, (cmd && (args)).

>The rest of the patch looks OK.
>
>Oh, and please inline patches instead of attaching them.
>
>Thanks,
>Bartlomiej
>

 ide-disk.c     |   46 ++++++----------------------------------------
 ide-io.c       |   44 ++++++++++++++++++++++++++++++++++++++++++++
 ide-taskfile.c |   10 ++++++++++
 3 files changed, 60 insertions(+), 40 deletions(-)
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
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			
HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 
0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	
HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,	
			1,	1,	&drive->lun,			NULL);
-	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	
HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
+	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	
HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			ide_write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	
HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		
set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	
0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			
TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
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
+++ edited/drivers/ide/ide-taskfile.c	2004-10-19 12:50:03 -05:00
@@ -727,6 +727,16 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	if (copy_from_user(args, (void __user *)arg, 4))
 		return -EFAULT;
 
+	if ((args[0] == WIN_SETFEATURES) &&
+	    ((args[2] == SETFEATURES_EN_WCACHE) ||
+	     (args[2] == SETFEATURES_DIS_WCACHE))) {
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


