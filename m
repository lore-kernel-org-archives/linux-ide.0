From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [patch 8/8] ide-scsi: add basic refcounting
Date: Sat, 22 Jan 2005 00:38:42 +0100 (CET)
Message-ID: <Pine.GSO.4.58.0501220022460.28844@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262589AbVAUXpE@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58069 "EHLO
	mion.elka.pw.edu.pl") by higgs.elka.pw.edu.pl with ESMTP
	id S30881AbVAUXin (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sat, 22 Jan 2005 00:38:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


* pointers to a SCSI host and a drive are added to idescsi_scsi_t
* pointer to the SCSI host is stored in disk->private_data
* ide_scsi_{get,put}() is used to {get,put} reference to the SCSI host

Unfortunately this is not complete fix for ->open() vs ->cleanup()
race, there are two TODO items left (as stated by FIXMEs):

* don't use drive->driver_data
* add driver's private struct gendisk [already DONE]

Last minute note: it seems we can't get rid of drive->driver_data
because of interactions between ide-scsi and IDE core (no surprise),
drive->driver_data should be set to NULL when SCSI host object is
being destroyed - callback from scsi_host_dev_release() is needed.

This will help in fixing another problem - for IDE we need to wait
until driver is really no longer using the device because we have more
than 1 driver for the same class of devices (ide-{cd,floppy,tape} vs
ide-scsi, also there is ide-default hack but it will die soon).

diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-21 23:41:42 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-21 23:41:42 +01:00
@@ -96,14 +96,39 @@
  */
 #define IDESCSI_LOG_CMD			0	/* Log SCSI commands */

-typedef struct {
-	ide_drive_t *drive;
+typedef struct ide_scsi_obj {
+	ide_drive_t		*drive;
+	struct Scsi_Host	*host;
+
 	idescsi_pc_t *pc;			/* Current packet command */
 	unsigned long flags;			/* Status/Action flags */
 	unsigned long transform;		/* SCSI cmd translation layer */
 	unsigned long log;			/* log flags */
 } idescsi_scsi_t;

+static DECLARE_MUTEX(idescsi_ref_sem);
+
+#define ide_scsi_g(disk)	((disk)->private_data)
+
+static struct ide_scsi_obj *ide_scsi_get(struct gendisk *disk)
+{
+	struct ide_scsi_obj *scsi = NULL;
+
+	down(&idescsi_ref_sem);
+	scsi = ide_scsi_g(disk);
+	if (scsi)
+		scsi_host_get(scsi->host);
+	up(&idescsi_ref_sem);
+	return scsi;
+}
+
+static void ide_scsi_put(struct ide_scsi_obj *scsi)
+{
+	down(&idescsi_ref_sem);
+	scsi_host_put(scsi->host);
+	up(&idescsi_ref_sem);
+}
+
 static inline idescsi_scsi_t *scsihost_to_idescsi(struct Scsi_Host *host)
 {
 	return (idescsi_scsi_t*) (&host[1]);
@@ -693,16 +718,20 @@
 static int idescsi_cleanup (ide_drive_t *drive)
 {
 	struct Scsi_Host *scsihost = drive->driver_data;
+	struct gendisk *g = drive->disk;

 	if (ide_unregister_subdriver(drive))
 		return 1;
-
-	/* FIXME?: Are these two statements necessary? */
+
+	/* FIXME: drive->driver_data shouldn't be used */
 	drive->driver_data = NULL;
-	drive->disk->fops = ide_fops;
+	/* FIXME: add driver's private struct gendisk */
+	g->private_data = NULL;
+	g->fops = ide_fops;

 	scsi_remove_host(scsihost);
-	scsi_host_put(scsihost);
+	ide_scsi_put(scsihost_to_idescsi(scsihost));
+
 	return 0;
 }

@@ -739,15 +768,30 @@

 static int idescsi_ide_open(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_scsi_obj *scsi;
+	ide_drive_t *drive;
+
+	if (!(scsi = ide_scsi_get(disk)))
+		return -ENXIO;
+
+	drive = scsi->drive;
+
 	drive->usage++;
+
 	return 0;
 }

 static int idescsi_ide_release(struct inode *inode, struct file *filp)
 {
-	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct ide_scsi_obj *scsi = ide_scsi_g(disk);
+	ide_drive_t *drive = scsi->drive;
+
 	drive->usage--;
+
+	ide_scsi_put(scsi);
+
 	return 0;
 }

@@ -755,8 +799,8 @@
 			unsigned int cmd, unsigned long arg)
 {
 	struct block_device *bdev = inode->i_bdev;
-	ide_drive_t *drive = bdev->bd_disk->private_data;
-	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	struct ide_scsi_obj *scsi = ide_scsi_g(bdev->bd_disk);
+	return generic_ide_ioctl(scsi->drive, file, bdev, cmd, arg);
 }

 static struct block_device_operations idescsi_ops = {
@@ -1043,6 +1087,7 @@
 {
 	idescsi_scsi_t *idescsi;
 	struct Scsi_Host *host;
+	struct gendisk *g = drive->disk;
 	static int warned;
 	int err;

@@ -1071,10 +1116,12 @@
 	drive->driver_data = host;
 	idescsi = scsihost_to_idescsi(host);
 	idescsi->drive = drive;
+	idescsi->host = host;
 	err = ide_register_subdriver(drive, &idescsi_driver);
 	if (!err) {
 		idescsi_setup (drive, idescsi);
-		drive->disk->fops = &idescsi_ops;
+		g->fops = &idescsi_ops;
+		g->private_data = idescsi;
 		err = scsi_add_host(host, &drive->gendev);
 		if (!err) {
 			scsi_scan_host(host);
