From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/22] ide: move blk_register_region() call out from init_gendisk()
Date: Thu, 17 Jan 2008 00:27:23 +0100
Message-ID: <20080116232723.9166.48965.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:10411 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567AbYAPXOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:14:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275985ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:14:42 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Move blk_register_region() call out from init_gendisk() to hwif_init().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1200,8 +1200,6 @@ static void init_gendisk (ide_hwif_t *hw
 		drive->gendev.driver_data = drive;
 		drive->gendev.release = drive_release_dev;
 	}
-	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
-			THIS_MODULE, ata_probe, ata_lock, hwif);
 }
 
 static int hwif_init(ide_hwif_t *hwif)
@@ -1261,6 +1259,8 @@ static int hwif_init(ide_hwif_t *hwif)
 
 done:
 	init_gendisk(hwif);
+	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
+			    THIS_MODULE, ata_probe, ata_lock, hwif);
 	ide_acpi_init(hwif);
 	return 1;
 
