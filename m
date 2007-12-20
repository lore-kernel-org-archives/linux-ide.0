From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/63] ide-cd: use ide_cd_release() in ide_cd_probe()
Date: Thu, 20 Dec 2007 01:52:28 +0100
Message-ID: <200712200152.28958.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbXLTBeF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389252ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Use ide_cd_release() to do the cleanup if ide_cdrom_setup() fails.

It fixes:
- the default drive->dsc_overlap value not being restored
- the default drive->queue's prep_rq_fn not being restored
- struct gendisk 'g' not being freed
- wrong function name being reported on unregister_cdrom() error

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-164 bytes
 drivers/ide/ide-cd.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3501,15 +3501,8 @@ static int ide_cd_probe(ide_drive_t *dri
 	g->driverfs_dev = &drive->gendev;
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
-		struct cdrom_device_info *devinfo = &info->devinfo;
 		ide_proc_unregister_driver(drive, &ide_cdrom_driver);
-		kfree(info->buffer);
-		kfree(info->toc);
-		kfree(info->changer_info);
-		if (devinfo->handle == drive && unregister_cdrom(devinfo))
-			printk (KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom 
driver.\n", drive->name);
-		kfree(info);
-		drive->driver_data = NULL;
+		ide_cd_release(&info->kref);
 		goto failed;
 	}
 
