From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] umc8672: don't use ide_hwifs[] in umc_set_pio_mode()
Date: Sat, 16 Feb 2008 21:27:08 +0100
Message-ID: <20080216202708.25536.95262.sendpatchset@localhost.localdomain>
References: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:14715 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759365AbYBPUMf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 15:12:35 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1181336fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 12:12:34 -0800 (PST)
In-Reply-To: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/umc8672.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -105,13 +105,13 @@ static void umc_set_speeds (u8 speeds[])
 
 static void umc_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
+	ide_hwif_t *hwif = drive->hwif;
 	unsigned long flags;
-	ide_hwgroup_t *hwgroup = ide_hwifs[HWIF(drive)->index^1].hwgroup;
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
 		drive->name, pio, pio_to_umc[pio]);
 	spin_lock_irqsave(&ide_lock, flags);
-	if (hwgroup && hwgroup->handler != NULL) {
+	if (hwif->mate && hwif->mate->hwgroup->handler) {
 		printk(KERN_ERR "umc8672: other interface is busy: exiting tune_umc()\n");
 	} else {
 		current_speeds[drive->name[2] - 'a'] = pio_to_umc[pio];
