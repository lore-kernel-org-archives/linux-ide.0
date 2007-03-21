From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 2/3] libata: expose AN support to user space via sysfs
Date: Tue, 20 Mar 2007 17:52:37 -0700
Message-ID: <20070320175237.68b040fd.kristen.c.accardi@intel.com>
References: <20070321004740.939006166@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__20_Mar_2007_17_52_37_-0700_1KXPkvw_8x1pX7v0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45885 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933674AbXCUAzG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Mar 2007 20:55:06 -0400
In-Reply-To: <20070321004740.939006166@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__20_Mar_2007_17_52_37_-0700_1KXPkvw_8x1pX7v0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Allow user space to determine if an ATAPI device supports
async notification (AN) of media changes.  This is done by
adding a new sysfs file "async_notification" to genhd.
If the file reads 1, then the device supports async 
notification.  If the file reads 0, it does not.  

A flag is set in the generic disk to indicate whether
or not AN is supported.  This flag is set by the SCSI
subsystem when it registers with add_disk.  The SCSI
system gets information from libata on whether the
device supports AN during dev_configure. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/block/genhd.c
===================================================================
--- 2.6-git.orig/block/genhd.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/block/genhd.c	2007-03-21 01:23:46.000000000 -0700
@@ -369,6 +369,11 @@
 {
 	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
 }
+static ssize_t disk_an_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%d\n",
+		(disk->flags & GENHD_FL_ASYNC_NOTIFICATION ? 1 : 0));
+}
 
 static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
@@ -416,6 +421,10 @@
 	.attr = {.name = "stat", .mode = S_IRUGO },
 	.show	= disk_stats_read
 };
+static struct disk_attribute disk_attr_an = {
+	.attr = {.name = "async_notification", .mode = S_IRUGO },
+	.show	= disk_an_read
+};
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 
@@ -452,6 +461,7 @@
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+	&disk_attr_an.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&disk_attr_fail.attr,
 #endif
Index: 2.6-git/include/linux/genhd.h
===================================================================
--- 2.6-git.orig/include/linux/genhd.h	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/include/linux/genhd.h	2007-03-21 01:23:46.000000000 -0700
@@ -90,6 +90,7 @@
 
 #define GENHD_FL_REMOVABLE			1
 #define GENHD_FL_DRIVERFS			2
+#define GENHD_FL_ASYNC_NOTIFICATION		4
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
Index: 2.6-git/include/scsi/scsi_device.h
===================================================================
--- 2.6-git.orig/include/scsi/scsi_device.h	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/include/scsi/scsi_device.h	2007-03-21 01:23:46.000000000 -0700
@@ -123,7 +123,7 @@
 	unsigned select_no_atn:1;
 	unsigned fix_capacity:1;	/* READ_CAPACITY is too high by 1 */
 	unsigned retry_hwerror:1;	/* Retry HARDWARE_ERROR */
-
+	unsigned async_notification:1;	/* device supports async notification */
 	unsigned int device_blocked;	/* Device returned QUEUE_FULL. */
 
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
Index: 2.6-git/drivers/ata/libata-scsi.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-scsi.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/drivers/ata/libata-scsi.c	2007-03-21 01:23:46.000000000 -0700
@@ -855,6 +855,9 @@
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
 
+	if (dev->flags & ATA_DFLAG_AN)
+		sdev->async_notification = 1;
+
 	if (dev->flags & ATA_DFLAG_NCQ) {
 		int depth;
 
Index: 2.6-git/drivers/scsi/sr.c
===================================================================
--- 2.6-git.orig/drivers/scsi/sr.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/drivers/scsi/sr.c	2007-03-21 01:23:46.000000000 -0700
@@ -602,6 +602,8 @@
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
+	if (sdev->async_notification)
+		disk->flags |= GENHD_FL_ASYNC_NOTIFICATION;
 	add_disk(disk);
 
 	sdev_printk(KERN_DEBUG, sdev,

-- 

--Multipart=_Tue__20_Mar_2007_17_52_37_-0700_1KXPkvw_8x1pX7v0
Content-Type: text/plain;
 name="libata-expose-an-to-users"
Content-Disposition: attachment;
 filename="libata-expose-an-to-users"
Content-Transfer-Encoding: 7bit

Allow user space to determine if an ATAPI device supports
async notification (AN) of media changes.  This is done by
adding a new sysfs file "async_notification" to genhd.
If the file reads 1, then the device supports async 
notification.  If the file reads 0, it does not.  

A flag is set in the generic disk to indicate whether
or not AN is supported.  This flag is set by the SCSI
subsystem when it registers with add_disk.  The SCSI
system gets information from libata on whether the
device supports AN during dev_configure. 

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/block/genhd.c
===================================================================
--- 2.6-git.orig/block/genhd.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/block/genhd.c	2007-03-21 01:23:46.000000000 -0700
@@ -369,6 +369,11 @@
 {
 	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
 }
+static ssize_t disk_an_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%d\n",
+		(disk->flags & GENHD_FL_ASYNC_NOTIFICATION ? 1 : 0));
+}
 
 static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
@@ -416,6 +421,10 @@
 	.attr = {.name = "stat", .mode = S_IRUGO },
 	.show	= disk_stats_read
 };
+static struct disk_attribute disk_attr_an = {
+	.attr = {.name = "async_notification", .mode = S_IRUGO },
+	.show	= disk_an_read
+};
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 
@@ -452,6 +461,7 @@
 	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
+	&disk_attr_an.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&disk_attr_fail.attr,
 #endif
Index: 2.6-git/include/linux/genhd.h
===================================================================
--- 2.6-git.orig/include/linux/genhd.h	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/include/linux/genhd.h	2007-03-21 01:23:46.000000000 -0700
@@ -90,6 +90,7 @@
 
 #define GENHD_FL_REMOVABLE			1
 #define GENHD_FL_DRIVERFS			2
+#define GENHD_FL_ASYNC_NOTIFICATION		4
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
Index: 2.6-git/include/scsi/scsi_device.h
===================================================================
--- 2.6-git.orig/include/scsi/scsi_device.h	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/include/scsi/scsi_device.h	2007-03-21 01:23:46.000000000 -0700
@@ -123,7 +123,7 @@
 	unsigned select_no_atn:1;
 	unsigned fix_capacity:1;	/* READ_CAPACITY is too high by 1 */
 	unsigned retry_hwerror:1;	/* Retry HARDWARE_ERROR */
-
+	unsigned async_notification:1;	/* device supports async notification */
 	unsigned int device_blocked;	/* Device returned QUEUE_FULL. */
 
 	unsigned int max_device_blocked; /* what device_blocked counts down from  */
Index: 2.6-git/drivers/ata/libata-scsi.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-scsi.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/drivers/ata/libata-scsi.c	2007-03-21 01:23:46.000000000 -0700
@@ -855,6 +855,9 @@
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
 
+	if (dev->flags & ATA_DFLAG_AN)
+		sdev->async_notification = 1;
+
 	if (dev->flags & ATA_DFLAG_NCQ) {
 		int depth;
 
Index: 2.6-git/drivers/scsi/sr.c
===================================================================
--- 2.6-git.orig/drivers/scsi/sr.c	2007-03-21 01:22:04.000000000 -0700
+++ 2.6-git/drivers/scsi/sr.c	2007-03-21 01:23:46.000000000 -0700
@@ -602,6 +602,8 @@
 
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
+	if (sdev->async_notification)
+		disk->flags |= GENHD_FL_ASYNC_NOTIFICATION;
 	add_disk(disk);
 
 	sdev_printk(KERN_DEBUG, sdev,

-- 

--Multipart=_Tue__20_Mar_2007_17_52_37_-0700_1KXPkvw_8x1pX7v0--
