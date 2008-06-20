From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/18] ide: add ide_read_device() helper
Date: Fri, 20 Jun 2008 23:35:05 +0200
Message-ID: <20080620213505.13202.27589.sendpatchset@localhost.localdomain>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:5898 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761818AbYFTVdJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 17:33:09 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1410729fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 14:33:08 -0700 (PDT)
In-Reply-To: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add ide_read_device() helper and convert do_probe() to use it
instead of ->INB.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -410,6 +410,18 @@ static int ide_busy_sleep(ide_hwif_t *hw
 	return 1;
 }
 
+static u8 ide_read_device(ide_drive_t *drive)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf_flags = IDE_TFLAG_IN_DEVICE;
+
+	drive->hwif->tf_read(drive, &task);
+
+	return task.tf.device;
+}
+
 /**
  *	do_probe		-	probe an IDE device
  *	@drive: drive to probe
@@ -434,7 +446,6 @@ static int ide_busy_sleep(ide_hwif_t *hw
 static int do_probe (ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	struct ide_io_ports *io_ports = &hwif->io_ports;
 	int rc;
 	u8 stat;
 
@@ -455,8 +466,8 @@ static int do_probe (ide_drive_t *drive,
 	msleep(50);
 	SELECT_DRIVE(drive);
 	msleep(50);
-	if (hwif->INB(io_ports->device_addr) != drive->select.all &&
-	    !drive->present) {
+
+	if (ide_read_device(drive) != drive->select.all && !drive->present) {
 		if (drive->select.b.unit != 0) {
 			/* exit with drive0 selected */
 			SELECT_DRIVE(&hwif->drives[0]);
