From: Arnaud Cornet <arnaud.cornet@gmail.com>
Subject: Quick patch fixes resume with host protected area
Date: Sat, 18 Mar 2006 23:26:55 +0100
Message-ID: <20060318222653.GA4915@t1r.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from je.suis.t1r.net ([82.225.75.189]:55051 "EHLO nucleus.t1r.net")
	by vger.kernel.org with ESMTP id S1751083AbWCRW1D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Mar 2006 17:27:03 -0500
Received: from xiaoxiao (xiaoxiao.t1r.net [192.168.1.3])
	by nucleus.t1r.net (Postfix) with ESMTP id 1EAEC42CEC
	for <linux-ide@vger.kernel.org>; Sat, 18 Mar 2006 23:26:46 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

On resume after a suspend to ram, the kernel cannot access the drive in
it's host protected area. The problem has already been discussed here
http://marc.theaimsgroup.com/?l=linux-ide&m=112116787306723&w=2
My up to date bios does not let me disable hpa completly.

Here is a (very naive) patch for 2.6.15.6 that disables HPA on resume.
This is a terrible hack but it works for me.

Using this patch, doing a hdparm -I /dev/hda before and after the
supend/resume still shows the differences:

-       R/W multiple sector transfer: Max = 16  Current = ?
+       R/W multiple sector transfer: Max = 16  Current = 16
...
-               frozen
+       not     frozen

I don't know if I should bother exploring further.

Regards,
-- 
Arnaud Cornet

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="resume-hpa.diff"

diff -urp linux-2.6.15.6/drivers/ide/ide.c linux-2.6.15.6-hpa/drivers/ide/ide.c
--- linux-2.6.15.6/drivers/ide/ide.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.6-hpa/drivers/ide/ide.c	2006-03-18 21:26:27.000000000 +0100
@@ -1239,6 +1239,7 @@ static int generic_ide_resume(struct dev
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int ret;
 
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
@@ -1249,7 +1250,11 @@ static int generic_ide_resume(struct dev
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	ret = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+
+	if (drive->has_hpa)
+		idedisk_disable_hpa(drive);
+	return ret;
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
diff -urp linux-2.6.15.6/drivers/ide/ide-disk.c linux-2.6.15.6-hpa/drivers/ide/ide-disk.c
--- linux-2.6.15.6/drivers/ide/ide-disk.c	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.6-hpa/drivers/ide/ide-disk.c	2006-03-18 22:04:30.000000000 +0100
@@ -504,11 +504,29 @@ static inline void idedisk_check_hpa(ide
 		set_max = idedisk_set_max_address(drive, set_max);
 	if (set_max) {
 		drive->capacity64 = set_max;
+		drive->has_hpa = 1;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
 				 drive->name);
 	}
 }
 
+void idedisk_disable_hpa(ide_drive_t *drive)
+{
+	int lba48 = idedisk_supports_lba48(drive->id);
+
+	/* On my machine idedisk_set_max_address has no efect if
+	 * idedisk_read_native_max_address is not called before */
+	if (lba48) {
+		idedisk_read_native_max_address_ext(drive);
+		idedisk_set_max_address_ext(drive, drive->capacity64);
+	} else {
+		idedisk_read_native_max_address(drive);
+		idedisk_set_max_address(drive, drive->capacity64);
+	}
+	printk(KERN_INFO "%s: Host Protected Area disabled.\n",
+				 drive->name);
+}
+
 /*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
diff -urp linux-2.6.15.6/include/linux/ide.h linux-2.6.15.6-hpa/include/linux/ide.h
--- linux-2.6.15.6/include/linux/ide.h	2006-02-10 08:22:48.000000000 +0100
+++ linux-2.6.15.6-hpa/include/linux/ide.h	2006-03-18 22:00:18.000000000 +0100
@@ -602,6 +602,7 @@ typedef struct ide_drive_s {
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
 	unsigned post_reset	: 1;
+	unsigned has_hpa	: 1;	/* host protected area detected */
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */

--IS0zKkzwUGydFO0o--
