From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/10] ide-disk: use ata_id_wcache_enabled()
Date: Tue, 22 Jul 2008 23:13:04 +0200
Message-ID: <20080722211304.20478.1192.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50809 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbYGVVPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:15:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963151fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:15:13 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Replace open-coded check by ata_id_wcache_enabled()
(which also checks validity of word 85).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -896,7 +896,7 @@ static void idedisk_setup(ide_drive_t *d
 			 drive->bios_cyl, drive->bios_head, drive->bios_sect);
 
 	/* write cache enabled? */
-	if ((id[ATA_ID_CSFO] & 1) || (id[ATA_ID_CFS_ENABLE_1] & (1 << 5)))
+	if ((id[ATA_ID_CSFO] & 1) || ata_id_wcache_enabled(id))
 		drive->wcache = 1;
 
 	write_cache(drive, 1);
