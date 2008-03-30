From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] ide: use ->ata_input_data in ide_driveid_update()
Date: Sun, 30 Mar 2008 17:11:19 +0200
Message-ID: <200803301711.19315.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:12792 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYC3Pcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 11:32:31 -0400
Received: by py-out-1112.google.com with SMTP id u52so1684012pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 08:32:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Use ->ata_input_data method instead of calling ata_input_data() directly.

Currently it matters only for (broken) ide-cris host driver but it may
change in the future.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -674,7 +674,7 @@ int ide_driveid_update(ide_drive_t *driv
 		local_irq_restore(flags);
 		return 0;
 	}
-	ata_input_data(drive, id, SECTOR_WORDS);
+	hwif->ata_input_data(drive, id, SECTOR_WORDS);
 	(void)ide_read_status(drive);	/* clear drive IRQ */
 	local_irq_enable();
 	local_irq_restore(flags);
