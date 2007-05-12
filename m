From: Lee Trager <lt73@cs.drexel.edu>
Subject: [PATCH] HPA Detect From Resume
Date: Sat, 12 May 2007 02:39:28 -0400
Message-ID: <46456120.6070401@cs.drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pm1.irt.drexel.edu ([144.118.29.81]:38471 "EHLO
	smtp.mail.drexel.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754655AbXELHJV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 03:09:21 -0400
Received: from smtp.mail.drexel.edu (localhost.localdomain [127.0.0.1])
	by smtp.mail.drexel.edu (Postfix) with SMTP id 4A9E1225E07
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2007 02:39:29 -0400 (EDT)
Received: from [144.118.213.40] (n2-213-40.resnet.drexel.edu [144.118.213.40])
	by smtp.mail.drexel.edu (Postfix) with ESMTP id 110CC225DAB
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2007 02:39:29 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Currently when system which have HPA require HPA to be detected and
disabled upon resume from RAM or disk. The current IDE drivers do not do
this nor does libata(obviously it since it doesn't support HPA yet). I
have implemented this into the current IDE drivers and it has been
tested by many others since 7/15/2006 in bug number
6840(http://bugzilla.kernel.org/show_bug.cgi?id=6840) and it has been
confirmed to work fine with no problems.

--- linux-2.6.21.1-old/include/linux/ide.h	2007-05-01 02:54:12.000000000 -0400
+++ linux-2.6.21.1/include/linux/ide.h	2007-04-28 01:06:20.000000000 -0400
@@ -1005,6 +1005,7 @@
 	int		(*probe)(ide_drive_t *);
 	void		(*remove)(ide_drive_t *);
 	void		(*shutdown)(ide_drive_t *);
+	void		(*resume)(ide_drive_t *);
 } ide_driver_t;
 
 #define to_ide_driver(drv) container_of(drv, ide_driver_t, gen_driver)
--- linux-2.6.21.1-old/drivers/ide/ide.c	2007-05-01 02:54:12.000000000 -0400
+++ linux-2.6.21.1/drivers/ide/ide.c	2007-04-28 03:41:24.000000000 -0400
@@ -1260,9 +1260,11 @@
 {
 	ide_drive_t *drive = dev->driver_data;
 	ide_hwif_t *hwif = HWIF(drive);
+	ide_driver_t *drv = to_ide_driver(dev->driver);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int err;
 
 	/* Call ACPI _STM only once */
 	if (!(drive->dn % 2))
@@ -1279,7 +1281,12 @@
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+
+	if (err == 0 && drv->resume)
+		drv->resume(drive);
+
+	return err;
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
--- linux-2.6.21.1-old/drivers/ide/ide-disk.c	2007-05-01 02:54:12.000000000 -0400
+++ linux-2.6.21.1/drivers/ide/ide-disk.c	2007-04-28 01:06:20.000000000 -0400
@@ -1024,6 +1024,17 @@
 
 static int ide_disk_probe(ide_drive_t *drive);
 
+/*
+ * On HPA drives the capacity needs to be
+ * reinitilized on resume otherwise the disk
+ * can not be used and a hard reset is required
+ */
+static void ide_disk_resume(ide_drive_t *drive)
+{
+	if (idedisk_supports_hpa(drive->id))
+		init_idedisk_capacity(drive);
+}
+
 static void ide_device_shutdown(ide_drive_t *drive)
 {
 #ifdef	CONFIG_ALPHA
@@ -1067,6 +1078,7 @@
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
+	.resume			= ide_disk_resume,
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)



