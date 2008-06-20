From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/18] ide: use ->tf_load in SELECT_DRIVE()
Date: Fri, 20 Jun 2008 23:34:51 +0200
Message-ID: <20080620213451.13202.12671.sendpatchset@localhost.localdomain>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:5898 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761659AbYFTVcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 17:32:55 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1410729fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 14:32:55 -0700 (PDT)
In-Reply-To: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert SELECT_DRIVE() to use ->tf_load instead of ->OUTB.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -88,11 +88,15 @@ void SELECT_DRIVE (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_port_ops *port_ops = hwif->port_ops;
+	ide_task_t task;
 
 	if (port_ops && port_ops->selectproc)
 		port_ops->selectproc(drive);
 
-	hwif->OUTB(drive->select.all, hwif->io_ports.device_addr);
+	memset(&task, 0, sizeof(task));
+	task.tf_flags = IDE_TFLAG_OUT_DEVICE;
+
+	drive->hwif->tf_load(drive, &task);
 }
 
 void SELECT_MASK(ide_drive_t *drive, int mask)
