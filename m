From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide-disk: add ide_do_setfeature() helper
Date: Sun, 17 Aug 2008 19:15:14 +0200
Message-ID: <20080817171514.27943.66688.sendpatchset@localhost.localdomain>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:31381 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbYHQRRf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:17:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1455276fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:17:34 -0700 (PDT)
In-Reply-To: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add ide_do_setfeature() helper and convert set_{wcache,acoustic}()
to use it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -574,6 +574,19 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
+static int ide_do_setfeature(ide_drive_t *drive, u8 feature, u8 nsect)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf.feature = feature;
+	task.tf.nsect   = nsect;
+	task.tf.command = ATA_CMD_SET_FEATURES;
+	task.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
+
+	return ide_no_data_taskfile(drive, &task);
+}
+
 static void update_ordered(ide_drive_t *drive)
 {
 	u16 *id = drive->id;
@@ -613,19 +626,14 @@ ide_devset_get(wcache, wcache);
 
 static int set_wcache(ide_drive_t *drive, int arg)
 {
-	ide_task_t args;
 	int err = 1;
 
 	if (arg < 0 || arg > 1)
 		return -EINVAL;
 
 	if (ata_id_flush_enabled(drive->id)) {
-		memset(&args, 0, sizeof(ide_task_t));
-		args.tf.feature = arg ?
-			SETFEATURES_WC_ON : SETFEATURES_WC_OFF;
-		args.tf.command = ATA_CMD_SET_FEATURES;
-		args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
-		err = ide_no_data_taskfile(drive, &args);
+		err = ide_do_setfeature(drive,
+			arg ? SETFEATURES_WC_ON : SETFEATURES_WC_OFF, 0);
 		if (err == 0)
 			drive->wcache = arg;
 	}
@@ -652,18 +660,14 @@ ide_devset_get(acoustic, acoustic);
 
 static int set_acoustic(ide_drive_t *drive, int arg)
 {
-	ide_task_t args;
-
 	if (arg < 0 || arg > 254)
 		return -EINVAL;
 
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tf.feature = arg ? SETFEATURES_AAM_ON : SETFEATURES_AAM_OFF;
-	args.tf.nsect   = arg;
-	args.tf.command = ATA_CMD_SET_FEATURES;
-	args.tf_flags = IDE_TFLAG_TF | IDE_TFLAG_DEVICE;
-	ide_no_data_taskfile(drive, &args);
+	ide_do_setfeature(drive,
+		arg ? SETFEATURES_AAM_ON : SETFEATURES_AAM_OFF, arg);
+
 	drive->acoustic = arg;
+
 	return 0;
 }
 
