From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Parking hard disk head from drivers
Date: Sat, 1 Jul 2006 12:01:16 +0200
Message-ID: <20060701100116.GA1752@hansmi.ch>
References: <20060622195904.GA30646@hansmi.ch> <449AF804.4080205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:27165 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S964853AbWGAKBS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Jul 2006 06:01:18 -0400
Content-Disposition: inline
In-Reply-To: <449AF804.4080205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, linux-kernel@killerfox.forkbomb.ch

On Thu, Jun 22, 2006 at 04:05:24PM -0400, Jeff Garzik wrote:
> If I had to guess, I would say use a notifier...

Thanks, that way I finally came up with something.

Below you find the HD parking part of my driver. I'll be really thankful
for any comments, suggestions and (constructive) critics on it. It's not
like I fully understood what the IDE layer does, but I looked at the
power management code and implemented something like it.

It does what it should on my PowerBook, but maybe it's totally wrong.

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/block/hdpark.c linux-2.6.17/block/hdpark.c
--- linux-2.6.17.orig/block/hdpark.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17/block/hdpark.c	2006-07-01 01:23:39.000000000 +0200
@@ -0,0 +1,60 @@
+/*
+ * Generic code for hard disk head parking
+ *
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/hdpark.h>
+#include <asm/atomic.h>
+
+static BLOCKING_NOTIFIER_HEAD(hdpark_notifier_list);
+static atomic_t hdpark_nested = ATOMIC_INIT(0);
+
+int register_hdpark_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hdpark_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_hdpark_notifier);
+
+int unregister_hdpark_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hdpark_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_hdpark_notifier);
+
+/* Parks the head of all registered hard disks */
+int hdpark_start()
+{
+	if (atomic_inc_return(&hdpark_nested) == 1) {
+		int err = blocking_notifier_call_chain(&hdpark_notifier_list,
+				HDPARK_ACTION_START, NULL);
+		if (err == NOTIFY_BAD)
+			return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdpark_start);
+
+/* Reactivates the registered hard disks */
+int hdpark_end()
+{
+	if (atomic_dec_and_test(&hdpark_nested)) {
+		int err = blocking_notifier_call_chain(&hdpark_notifier_list,
+				HDPARK_ACTION_END, NULL);
+		if (err == NOTIFY_BAD)
+			return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdpark_end);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/block/Kconfig linux-2.6.17/block/Kconfig
--- linux-2.6.17.orig/block/Kconfig	2006-06-19 21:47:12.000000000 +0200
+++ linux-2.6.17/block/Kconfig	2006-06-27 00:19:53.000000000 +0200
@@ -33,4 +33,7 @@ config LSF
 
 	  If unsure, say Y.
 
+config HDPARK
+	bool ""
+
 source block/Kconfig.iosched
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/block/Makefile linux-2.6.17/block/Makefile
--- linux-2.6.17.orig/block/Makefile	2006-06-19 21:47:12.000000000 +0200
+++ linux-2.6.17/block/Makefile	2006-06-27 00:18:29.000000000 +0200
@@ -10,3 +10,4 @@ obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadli
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 
 obj-$(CONFIG_BLK_DEV_IO_TRACE)	+= blktrace.o
+obj-$(CONFIG_HDPARK)		+= hdpark.o
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/drivers/ide/ide-disk.c linux-2.6.17/drivers/ide/ide-disk.c
--- linux-2.6.17.orig/drivers/ide/ide-disk.c	2006-06-19 21:47:08.000000000 +0200
+++ linux-2.6.17/drivers/ide/ide-disk.c	2006-07-01 00:56:37.000000000 +0200
@@ -62,6 +62,7 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/leds.h>
+#include <linux/hdpark.h>
 
 #define _IDE_DISK
 
@@ -108,6 +109,85 @@ static void ide_disk_put(struct ide_disk
 	mutex_unlock(&idedisk_ref_mutex);
 }
 
+#ifdef CONFIG_HDPARK
+/* This function is called when something should be done in regard to head
+ * parking.
+ */
+static int ide_disk_park_callback(struct notifier_block *nb,
+	unsigned long action, void *data)
+{
+	ide_drive_t *drive = nb->private_data;
+	ide_task_t args;
+	unsigned long flags;
+
+	switch (action) {
+	case HDPARK_ACTION_START:
+		memset(&args, 0, sizeof(ide_task_t));
+
+		/* Command to put HD into idle mode */
+		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.handler = &task_no_data_intr;
+
+		/* Ignore return value. If the HD fails to park that's bad, but
+		 * we can't do anything about it.
+		 */
+		ide_raw_taskfile(drive, &args, NULL);
+
+		/* At least block the queue */
+		spin_lock_irqsave(&ide_lock, flags);
+		drive->blocked = 1;
+		blk_stop_queue(drive->queue);
+		spin_unlock_irqrestore(&ide_lock, flags);
+
+		break;
+
+	case HDPARK_ACTION_END:
+		/* Unlock the queue */
+		spin_lock_irqsave(&ide_lock, flags);
+		drive->blocked = 0;
+		blk_start_queue(drive->queue);
+		spin_unlock_irqrestore(&ide_lock, flags);
+
+		break;
+	}
+
+	/* We don't care wether the park command actually succeeded */
+	return NOTIFY_DONE;
+}
+
+/* Registers a drive on the global hd parking notifier list */
+static void ide_disk_park_init(ide_drive_t *drive)
+{
+	struct notifier_block *nb;
+
+	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
+	if (likely(nb)) {
+		nb->notifier_call = ide_disk_park_callback;
+		nb->private_data = drive;
+
+		register_hdpark_notifier(nb);
+	} else
+		printk(KERN_ERR "ide-disk: hdpark notifier registration failed.\n");
+
+	drive->park_notifier = nb;
+}
+
+/* Unregisters a drive from the global hd parking notifier list */
+static void ide_disk_park_exit(ide_drive_t *drive)
+{
+	if (likely(drive->park_notifier)) {
+		unregister_hdpark_notifier(drive->park_notifier);
+
+		kfree(drive->park_notifier);
+		drive->park_notifier = NULL;
+	}
+}
+#else
+static inline void ide_disk_park_init(ide_drive_t *drive) {}
+static inline void ide_disk_park_exit(ide_drive_t *drive) {}
+#endif
+
 /*
  * lba_capacity_is_ok() performs a sanity check on the claimed "lba_capacity"
  * value for this drive (from its reported identification information).
@@ -1002,6 +1082,8 @@ static void ide_disk_remove(ide_drive_t 
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
+	ide_disk_park_exit(drive);
+
 	ide_unregister_subdriver(drive, idkp->driver);
 
 	del_gendisk(g);
@@ -1228,6 +1310,9 @@ static int ide_disk_probe(ide_drive_t *d
 	set_capacity(g, idedisk_capacity(drive));
 	g->fops = &idedisk_ops;
 	add_disk(g);
+
+	ide_disk_park_init(drive);
+
 	return 0;
 
 out_free_idkp:
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/include/linux/hdpark.h linux-2.6.17/include/linux/hdpark.h
--- linux-2.6.17.orig/include/linux/hdpark.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17/include/linux/hdpark.h	2006-06-30 23:07:22.000000000 +0200
@@ -0,0 +1,22 @@
+/*
+ * Header for block/hdpark.c -- generic code for hard disk head parking
+ *
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ */
+
+#ifndef _LINUX_HDPARK_H
+#define _LINUX_HDPAKR_H
+
+#include <linux/notifier.h>
+
+enum hdpark_action {
+	HDPARK_ACTION_START = 1,
+	HDPARK_ACTION_END = 2,
+};
+
+extern int register_hdpark_notifier(struct notifier_block *nb);
+extern int unregister_hdpark_notifier(struct notifier_block *nb);
+extern int hdpark_start(void);
+extern int hdpark_end(void);
+
+#endif
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/include/linux/ide.h linux-2.6.17/include/linux/ide.h
--- linux-2.6.17.orig/include/linux/ide.h	2006-06-19 21:47:13.000000000 +0200
+++ linux-2.6.17/include/linux/ide.h	2006-06-27 00:32:08.000000000 +0200
@@ -639,6 +639,10 @@ typedef struct ide_drive_s {
 	struct list_head list;
 	struct device	gendev;
 	struct completion gendev_rel_comp;	/* to deal with device release() */
+
+#ifdef CONFIG_HDPARK
+	void *park_notifier;
+#endif
 } ide_drive_t;
 
 #define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17.orig/include/linux/notifier.h linux-2.6.17/include/linux/notifier.h
--- linux-2.6.17.orig/include/linux/notifier.h	2006-06-19 21:47:13.000000000 +0200
+++ linux-2.6.17/include/linux/notifier.h	2006-06-27 00:38:10.000000000 +0200
@@ -36,6 +36,7 @@ struct notifier_block {
 	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
 	struct notifier_block *next;
 	int priority;
+	void *private_data;
 };
 
 struct atomic_notifier_head {
