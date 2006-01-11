From: Arjan van de Ven <arjan@infradead.org>
Subject: convert some IDE semaphores to mutexes
Date: Wed, 11 Jan 2006 10:56:41 +0100
Message-ID: <1136973401.2929.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:21651 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751429AbWAKJ4p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jan 2006 04:56:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: mingo@elte.hu

IDE uses some semaphores only in a mutex way; use the new
mutexes for this

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.15-rc6-mut/drivers/ide/ide-cd.c linux-2.6.15-rc6-mut-new/drivers/ide/ide-cd.c
--- linux-2.6.15-rc6-mut/drivers/ide/ide-cd.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6-mut-new/drivers/ide/ide-cd.c	2005-12-23 10:17:59.000000000 +0100
@@ -313,6 +313,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
 
@@ -324,7 +325,7 @@
 
 #include "ide-cd.h"
 
-static DECLARE_MUTEX(idecd_ref_sem);
+static DEFINE_MUTEX(idecd_ref_mutex);
 
 #define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref) 
 
@@ -335,11 +336,11 @@ static struct cdrom_info *ide_cd_get(str
 {
 	struct cdrom_info *cd = NULL;
 
-	down(&idecd_ref_sem);
+	mutex_lock(&idecd_ref_mutex);
 	cd = ide_cd_g(disk);
 	if (cd)
 		kref_get(&cd->kref);
-	up(&idecd_ref_sem);
+	mutex_unlock(&idecd_ref_mutex);
 	return cd;
 }
 
@@ -347,9 +348,9 @@ static void ide_cd_release(struct kref *
 
 static void ide_cd_put(struct cdrom_info *cd)
 {
-	down(&idecd_ref_sem);
+	mutex_lock(&idecd_ref_mutex);
 	kref_put(&cd->kref, ide_cd_release);
-	up(&idecd_ref_sem);
+	mutex_unlock(&idecd_ref_mutex);
 }
 
 /****************************************************************************
diff -purN linux-2.6.15-rc6-mut/drivers/ide/ide-disk.c linux-2.6.15-rc6-mut-new/drivers/ide/ide-disk.c
--- linux-2.6.15-rc6-mut/drivers/ide/ide-disk.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6-mut-new/drivers/ide/ide-disk.c	2005-12-23 10:17:59.000000000 +0100
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #define _IDE_DISK
 
@@ -78,7 +79,7 @@ struct ide_disk_obj {
 	struct kref	kref;
 };
 
-static DECLARE_MUTEX(idedisk_ref_sem);
+static DEFINE_MUTEX(idedisk_ref_mutex);
 
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
 
@@ -89,11 +90,11 @@ static struct ide_disk_obj *ide_disk_get
 {
 	struct ide_disk_obj *idkp = NULL;
 
-	down(&idedisk_ref_sem);
+	mutex_lock(&idedisk_ref_mutex);
 	idkp = ide_disk_g(disk);
 	if (idkp)
 		kref_get(&idkp->kref);
-	up(&idedisk_ref_sem);
+	mutex_unlock(&idedisk_ref_mutex);
 	return idkp;
 }
 
@@ -101,9 +102,9 @@ static void ide_disk_release(struct kref
 
 static void ide_disk_put(struct ide_disk_obj *idkp)
 {
-	down(&idedisk_ref_sem);
+	mutex_lock(&idedisk_ref_mutex);
 	kref_put(&idkp->kref, ide_disk_release);
-	up(&idedisk_ref_sem);
+	mutex_unlock(&idedisk_ref_mutex);
 }
 
 /*
diff -purN linux-2.6.15-rc6-mut/drivers/ide/ide-floppy.c linux-2.6.15-rc6-mut-new/drivers/ide/ide-floppy.c
--- linux-2.6.15-rc6-mut/drivers/ide/ide-floppy.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6-mut-new/drivers/ide/ide-floppy.c	2005-12-23 10:17:59.000000000 +0100
@@ -98,6 +98,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -517,7 +518,7 @@ typedef struct {
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;
 
-static DECLARE_MUTEX(idefloppy_ref_sem);
+static DEFINE_MUTEX(idefloppy_ref_mutex);
 
 #define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)
 
@@ -528,11 +529,11 @@ static struct ide_floppy_obj *ide_floppy
 {
 	struct ide_floppy_obj *floppy = NULL;
 
-	down(&idefloppy_ref_sem);
+	mutex_lock(&idefloppy_ref_mutex);
 	floppy = ide_floppy_g(disk);
 	if (floppy)
 		kref_get(&floppy->kref);
-	up(&idefloppy_ref_sem);
+	mutex_unlock(&idefloppy_ref_mutex);
 	return floppy;
 }
 
@@ -540,9 +541,9 @@ static void ide_floppy_release(struct kr
 
 static void ide_floppy_put(struct ide_floppy_obj *floppy)
 {
-	down(&idefloppy_ref_sem);
+	mutex_lock(&idefloppy_ref_mutex);
 	kref_put(&floppy->kref, ide_floppy_release);
-	up(&idefloppy_ref_sem);
+	mutex_unlock(&idefloppy_ref_mutex);
 }
 
 /*
diff -purN linux-2.6.15-rc6-mut/drivers/ide/ide-tape.c linux-2.6.15-rc6-mut-new/drivers/ide/ide-tape.c
--- linux-2.6.15-rc6-mut/drivers/ide/ide-tape.c	2005-12-22 19:54:33.000000000 +0100
+++ linux-2.6.15-rc6-mut-new/drivers/ide/ide-tape.c	2005-12-23 10:17:59.000000000 +0100
@@ -443,6 +443,7 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1011,7 +1012,7 @@ typedef struct ide_tape_obj {
          int debug_level; 
 } idetape_tape_t;
 
-static DECLARE_MUTEX(idetape_ref_sem);
+static DEFINE_MUTEX(idetape_ref_mutex);
 
 static struct class *idetape_sysfs_class;
 
@@ -1024,11 +1025,11 @@ static struct ide_tape_obj *ide_tape_get
 {
 	struct ide_tape_obj *tape = NULL;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	tape = ide_tape_g(disk);
 	if (tape)
 		kref_get(&tape->kref);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 	return tape;
 }
 
@@ -1036,9 +1037,9 @@ static void ide_tape_release(struct kref
 
 static void ide_tape_put(struct ide_tape_obj *tape)
 {
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	kref_put(&tape->kref, ide_tape_release);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 }
 
 /*
@@ -1290,11 +1291,11 @@ static struct ide_tape_obj *ide_tape_chr
 {
 	struct ide_tape_obj *tape = NULL;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	tape = idetape_devs[i];
 	if (tape)
 		kref_get(&tape->kref);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 	return tape;
 }
 
@@ -4874,11 +4875,11 @@ static int ide_tape_probe(struct device 
 
 	drive->driver_data = tape;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	for (minor = 0; idetape_devs[minor]; minor++)
 		;
 	idetape_devs[minor] = tape;
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 
 	idetape_setup(drive, tape, minor);
 


