From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 25/29] ide: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
Date: Wed, 2 Feb 2005 12:15:59 +0900
Message-ID: <20050202031559.GP1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from [211.58.254.17] ([211.58.254.17]:35467 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262274AbVBBDQB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2005 22:16:01 -0500
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> 25_ide_taskfile_cmd.patch
> 
> 	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
> 	converted to use REQ_DRIVE_TASKFILE.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:06.527986413 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:07.204876587 +0900
@@ -750,7 +750,7 @@ static int set_multcount(ide_drive_t *dr
 	if (drive->special.b.set_multmode)
 		return -EBUSY;
 	ide_init_drive_cmd (&rq);
-	rq.flags = REQ_DRIVE_CMD;
+	rq.flags = REQ_DRIVE_TASKFILE;
 	drive->mult_req = arg;
 	drive->special.b.set_multmode = 1;
 	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
Index: linux-ide-export/drivers/ide/ide.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide.c	2005-02-02 10:27:14.652402828 +0900
+++ linux-ide-export/drivers/ide/ide.c	2005-02-02 10:28:07.205876425 +0900
@@ -1255,6 +1255,7 @@ static int set_pio_mode (ide_drive_t *dr
 	if (drive->special.b.set_tune)
 		return -EBUSY;
 	ide_init_drive_cmd(&rq);
+	rq.flags = REQ_DRIVE_TASKFILE;
 	drive->tune_req = (u8) arg;
 	drive->special.b.set_tune = 1;
 	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
@@ -1263,9 +1264,17 @@ static int set_pio_mode (ide_drive_t *dr
 
 static int set_xfer_rate (ide_drive_t *drive, int arg)
 {
-	int err = ide_wait_cmd(drive,
-			WIN_SETFEATURES, (u8) arg,
-			SETFEATURES_XFER, 0, NULL);
+	ide_task_t args;
+	int err;
+
+	memset(&args, 0, sizeof(args));
+	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
+	args.tfRegister[IDE_FEATURE_OFFSET]	= SETFEATURES_XFER;
+	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
+	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
+	args.handler				= task_no_data_intr;
+
+	err = ide_raw_taskfile(drive, &args, NULL);
 
 	if (!err && arg) {
 		ide_set_xfer_rate(drive, (u8) arg);
