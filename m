From: akpm@linux-foundation.org
Subject: [patch 16/20] scsi: expose AN to user space
Date: Thu, 10 May 2007 22:48:56 -0700
Message-ID: <200705110548.l4B5mu8c007663@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:54650 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758039AbXEKFtM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Get media change notification capability from disk and pass this information
to genhd by setting appropriate flag.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/scsi/sd.c          |    3 +++
 drivers/scsi/sr.c          |    2 ++
 include/scsi/scsi_device.h |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/scsi/sd.c~scsi-expose-an-to-user-space drivers/scsi/sd.c
--- a/drivers/scsi/sd.c~scsi-expose-an-to-user-space
+++ a/drivers/scsi/sd.c
@@ -1668,6 +1668,9 @@ static int sd_probe(struct device *dev)
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
 
+	if (sdp->media_change_notify)
+		gd->flags |= GENHD_FL_MEDIA_CHANGE_NOTIFY;
+
 	dev_set_drvdata(dev, sdkp);
 	add_disk(gd);
 
diff -puN drivers/scsi/sr.c~scsi-expose-an-to-user-space drivers/scsi/sr.c
--- a/drivers/scsi/sr.c~scsi-expose-an-to-user-space
+++ a/drivers/scsi/sr.c
@@ -603,6 +603,8 @@ static int sr_probe(struct device *dev)
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
+	if (sdev->media_change_notify)
+		disk->flags |= GENHD_FL_MEDIA_CHANGE_NOTIFY;
 	add_disk(disk);
 
 	sdev_printk(KERN_DEBUG, sdev,
diff -puN include/scsi/scsi_device.h~scsi-expose-an-to-user-space include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h~scsi-expose-an-to-user-space
+++ a/include/scsi/scsi_device.h
@@ -126,7 +126,7 @@ struct scsi_device {
 	unsigned fix_capacity:1;	/* READ_CAPACITY is too high by 1 */
 	unsigned guess_capacity:1;	/* READ_CAPACITY might be too high by 1 */
 	unsigned retry_hwerror:1;	/* Retry HARDWARE_ERROR */
-
+	unsigned media_change_notify:1; /* dev supports async media notify */
 	unsigned int device_blocked;	/* Device returned QUEUE_FULL. */
 
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
_
