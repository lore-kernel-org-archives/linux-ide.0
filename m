From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/10] ide: use ata_id_current_chs_valid()
Date: Tue, 22 Jul 2008 23:12:57 +0200
Message-ID: <20080722211257.20478.36786.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbYGVVPJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:15:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963175fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:15:06 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Replace open-coded checks by ata_id_current_chs_valid().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -69,9 +69,7 @@ static void ide_disk_init_chs(ide_drive_
 	}
 
 	/* Handle logical geometry translation by the drive */
-	if ((id[ATA_ID_FIELD_VALID] & 1) && id[ATA_ID_CUR_CYLS] &&
-	    id[ATA_ID_CUR_HEADS] && id[ATA_ID_CUR_HEADS] <= 16 &&
-	    id[ATA_ID_CUR_SECTORS]) {
+	if (ata_id_current_chs_valid(id)) {
 		drive->cyl  = id[ATA_ID_CUR_CYLS];
 		drive->head = id[ATA_ID_CUR_HEADS];
 		drive->sect = id[ATA_ID_CUR_SECTORS];
