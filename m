From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-disk: set non-rotational queue flag for SSD and CF devices
Date: Sat, 18 Oct 2008 22:23:54 +0200
Message-ID: <200810182223.54590.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:18816 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbYJRU0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Oct 2008 16:26:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so857539fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 18 Oct 2008 13:26:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -600,6 +600,7 @@ static int ide_disk_check(ide_drive_t *d
 static void ide_disk_setup(ide_drive_t *drive)
 {
 	struct ide_disk_obj *idkp = drive->driver_data;
+	struct request_queue *q = drive->queue;
 	ide_hwif_t *hwif = drive->hwif;
 	u16 *id = drive->id;
 	char *m = (char *)&id[ATA_ID_PROD];
@@ -626,11 +627,14 @@ static void ide_disk_setup(ide_drive_t *
 		if (max_s > hwif->rqsize)
 			max_s = hwif->rqsize;
 
-		blk_queue_max_sectors(drive->queue, max_s);
+		blk_queue_max_sectors(q, max_s);
 	}
 
 	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name,
-			 drive->queue->max_sectors / 2);
+		q->max_sectors / 2);
+
+	if (ata_id_is_ssd(id) || ata_id_is_cfa(id))
+		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
 
 	/* calculate drive capacity, and select LBA if possible */
 	ide_disk_get_capacity(drive);
