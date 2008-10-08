From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] ide: IDE settings don't need an ide_lock held
Date: Wed, 08 Oct 2008 22:29:45 +0200
Message-ID: <20081008202945.19112.66822.sendpatchset@localhost.localdomain>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:25367 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbYJHUbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 16:31:21 -0400
Received: by gv-out-0910.google.com with SMTP id e6so694837gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 13:31:20 -0700 (PDT)
In-Reply-To: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: IDE settings don't need an ide_lock held

IDE settings are protected by ide_setting_mtx mutex so there is
no need to hold ide_lock in ide_setting_ioctl(), ide_read_setting()
and ide_proc_unregister_driver().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-ioctls.c |    3 ---
 drivers/ide/ide-proc.c   |   25 ++++---------------------
 2 files changed, 4 insertions(+), 24 deletions(-)

Index: b/drivers/ide/ide-ioctls.c
===================================================================
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -19,7 +19,6 @@ int ide_setting_ioctl(ide_drive_t *drive
 		      const struct ide_ioctl_devset *s)
 {
 	const struct ide_devset *ds;
-	unsigned long flags;
 	int err = -EOPNOTSUPP;
 
 	for (; (ds = s->setting); s++) {
@@ -33,9 +32,7 @@ int ide_setting_ioctl(ide_drive_t *drive
 
 read_val:
 	mutex_lock(&ide_setting_mtx);
-	spin_lock_irqsave(&ide_lock, flags);
 	err = ds->get(drive);
-	spin_unlock_irqrestore(&ide_lock, flags);
 	mutex_unlock(&ide_setting_mtx);
 	return err >= 0 ? put_user(err, (long __user *)arg) : err;
 
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -155,13 +155,8 @@ static int ide_read_setting(ide_drive_t 
 	const struct ide_devset *ds = setting->setting;
 	int val = -EINVAL;
 
-	if (ds->get) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&ide_lock, flags);
+	if (ds->get)
 		val = ds->get(drive);
-		spin_unlock_irqrestore(&ide_lock, flags);
-	}
 
 	return val;
 }
@@ -583,31 +578,19 @@ EXPORT_SYMBOL(ide_proc_register_driver);
  *	Clean up the driver specific /proc files and IDE settings
  *	for a given drive.
  *
- *	Takes ide_setting_mtx and ide_lock.
- *	Caller must hold none of the locks.
+ *	Takes ide_setting_mtx.
  */
 
 void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver)
 {
-	unsigned long flags;
-
 	ide_remove_proc_entries(drive->proc, driver->proc_entries(drive));
 
 	mutex_lock(&ide_setting_mtx);
-	spin_lock_irqsave(&ide_lock, flags);
 	/*
-	 * ide_setting_mtx protects the settings list
-	 * ide_lock protects the use of settings
-	 *
-	 * so we need to hold both, ide_settings_sem because we want to
-	 * modify the settings list, and ide_lock because we cannot take
-	 * a setting out that is being used.
-	 *
-	 * OTOH both ide_{read,write}_setting are only ever used under
-	 * ide_setting_mtx.
+	 * ide_setting_mtx protects both the settings list and the use
+	 * of settings (we cannot take a setting out that is being used).
 	 */
 	drive->settings = NULL;
-	spin_unlock_irqrestore(&ide_lock, flags);
 	mutex_unlock(&ide_setting_mtx);
 }
 EXPORT_SYMBOL(ide_proc_unregister_driver);
