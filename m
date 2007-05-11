From: akpm@linux-foundation.org
Subject: [patch 19/20] SCSI: save disk in scsi_device
Date: Thu, 10 May 2007 22:48:59 -0700
Message-ID: <200705110548.l4B5mxgP007672@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:33761 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758612AbXEKGJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 02:09:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Give anyone who has access to scsi_device access to the genhd struct as well.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/scsi/sd.c          |    1 +
 drivers/scsi/sr.c          |    1 +
 include/scsi/scsi_device.h |    2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/scsi/sd.c~scsi-save-disk-in-scsi_device drivers/scsi/sd.c
--- a/drivers/scsi/sd.c~scsi-save-disk-in-scsi_device
+++ a/drivers/scsi/sd.c
@@ -1673,6 +1673,7 @@ static int sd_probe(struct device *dev)
 
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
+	sdp->disk = gd;
 
 	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
 		  sdp->removable ? "removable " : "");
diff -puN drivers/scsi/sr.c~scsi-save-disk-in-scsi_device drivers/scsi/sr.c
--- a/drivers/scsi/sr.c~scsi-save-disk-in-scsi_device
+++ a/drivers/scsi/sr.c
@@ -606,6 +606,7 @@ static int sr_probe(struct device *dev)
 	if (sdev->media_change_notify)
 		disk->flags |= GENHD_FL_MEDIA_CHANGE_NOTIFY;
 	add_disk(disk);
+	sdev->disk = disk;
 
 	sdev_printk(KERN_DEBUG, sdev,
 		    "Attached scsi CD-ROM %s\n", cd->cdi.name);
diff -puN include/scsi/scsi_device.h~scsi-save-disk-in-scsi_device include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h~scsi-save-disk-in-scsi_device
+++ a/include/scsi/scsi_device.h
@@ -140,7 +140,7 @@ struct scsi_device {
 
 	struct device		sdev_gendev;
 	struct class_device	sdev_classdev;
-
+	struct gendisk 		*disk;
 	struct execute_work	ew; /* used to get process context on put */
 
 	enum scsi_device_state sdev_state;
_
