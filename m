From: akpm@linux-foundation.org
Subject: [patch 18/20] genhd: send async notification on media change
Date: Thu, 10 May 2007 22:48:58 -0700
Message-ID: <200705110548.l4B5mwuQ007669@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:48705 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758460AbXEKGJM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 02:09:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Send an uevent to user space to indicate that a media change event has
occurred.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 block/genhd.c         |   23 +++++++++++++++++++++++
 include/linux/genhd.h |    4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff -puN block/genhd.c~genhd-send-async-notification-on-media-change block/genhd.c
--- a/block/genhd.c~genhd-send-async-notification-on-media-change
+++ a/block/genhd.c
@@ -696,6 +696,27 @@ struct seq_operations diskstats_op = {
 	.show	= diskstats_show
 };
 
+static void media_change_notify_thread(struct work_struct *work)
+{
+	struct gendisk *gd = container_of(work, struct gendisk, async_notify);
+	char event[] = "MEDIA_CHANGE=1";
+	char *envp[] = { event, NULL };
+
+	/*
+	 * set enviroment vars to indicate which event this is for
+	 * so that user space will know to go check the media status.
+	 */
+	kobject_uevent_env(&gd->kobj, KOBJ_CHANGE, envp);
+	put_device(gd->driverfs_dev);
+}
+
+void genhd_media_change_notify(struct gendisk *disk)
+{
+	get_device(disk->driverfs_dev);
+	schedule_work(&disk->async_notify);
+}
+EXPORT_SYMBOL_GPL(genhd_media_change_notify);
+
 struct gendisk *alloc_disk(int minors)
 {
 	return alloc_disk_node(minors, -1);
@@ -725,6 +746,8 @@ struct gendisk *alloc_disk_node(int mino
 		kobj_set_kset_s(disk,block_subsys);
 		kobject_init(&disk->kobj);
 		rand_initialize_disk(disk);
+		INIT_WORK(&disk->async_notify,
+			media_change_notify_thread);
 	}
 	return disk;
 }
diff -puN include/linux/genhd.h~genhd-send-async-notification-on-media-change include/linux/genhd.h
--- a/include/linux/genhd.h~genhd-send-async-notification-on-media-change
+++ a/include/linux/genhd.h
@@ -66,6 +66,7 @@ struct partition {
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/workqueue.h>
 
 struct partition {
 	unsigned char boot_ind;		/* 0x80 - active */
@@ -139,6 +140,7 @@ struct gendisk {
 #else
 	struct disk_stats dkstats;
 #endif
+	struct work_struct async_notify;
 };
 
 /* Structure for sysfs attributes on block devices */
@@ -420,7 +422,7 @@ extern struct gendisk *alloc_disk_node(i
 extern struct gendisk *alloc_disk(int minors);
 extern struct kobject *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
-
+extern void genhd_media_change_notify(struct gendisk *disk);
 extern void blk_register_region(dev_t dev, unsigned long range,
 			struct module *module,
 			struct kobject *(*probe)(dev_t, int *, void *),
_
