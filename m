From: Doug Maxey <dwm@austin.ibm.com>
Subject: [RFC/PATCH 5/7] enable honoring write cache setting of IDE drive
Date: Fri, 28 Jan 2005 12:16:51 -0600
Message-ID: <200501281816.j0SIGpbW021117@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.133]:39578 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262729AbVA1SQz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:16:55 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j0SIGsZ7238852
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 13:16:54 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0SIGsqw322800
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:54 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j0SIGr44013150
	for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2005 11:16:53 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>


    - remove (now obsolete) write_cache() from ide-disk.c.  replace calls in
      ide-disk.c with calls to ide_write_cache().

 drivers/ide/ide-disk.c |   27 ++-------------------------
 1 files changed, 2 insertions(+), 25 deletions(-)

diff -X /home/dwm/lib/ide-excludes -Nwupar lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c
--- lk-2.6.11-rc2-bk5.a/drivers/ide/ide-disk.c	2005-01-28 11:27:46.000000000 -0600
+++ lk-2.6.11-rc2-bk5.b/drivers/ide/ide-disk.c	2005-01-28 11:36:52.000000000 -0600
@@ -765,29 +765,6 @@ static int set_nowerr(ide_drive_t *drive
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
@@ -849,7 +826,7 @@ static void idedisk_add_settings(ide_dri
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
-	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
+	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			ide_write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
@@ -1083,7 +1060,7 @@ static void idedisk_setup (ide_drive_t *
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
 
-	write_cache(drive, (BLK_DEV_HDWC ? drive->wcache : 1));
+	ide_write_cache(drive, (BLK_DEV_HDWC ? drive->wcache : 1));
 
 	/*
 	 * We must avoid issuing commands a drive does not understand


