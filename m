From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix locking for manual DMA enable/disable ("hdparm -d")
Date: Wed, 21 Mar 2007 11:09:48 +0100
Message-ID: <200703211109.48414.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:42763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbXCUKCS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 06:02:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so239876uga
        for <linux-ide@vger.kernel.org>; Wed, 21 Mar 2007 03:02:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>


I would like to merge it for 2.6.21-final because this issue become quite
urgent thanks to /etc/udev/scripts/hdparm.conf (the race is triggered
by udev/hdparm tuning master device while the slave device is still being
probed by the driver).  Reviews/comments are greatly appreciated.

[PATCH] ide: fix locking for manual DMA enable/disable ("hdparm -d")

Since hwif->ide_dma_check and hwif->ide_dma_on never queue any commands
(ide_config_drive_speed() sets transfer mode using polling and has no error
recovery) we are safe with setting hwgroup->busy for the time while DMA
setting for a drive is changed (so it won't race against I/O commands in fly).

I audited briefly all ->ide_dma_check/->ide_dma_on/->tuneproc/->speedproc
implementations and they all look OK wrt to this change.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide.c |   37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1124,17 +1124,40 @@ static int set_io_32bit(ide_drive_t *dri
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
+	ide_hwif_t *hwif = drive->hwif;
+	int err = -EPERM;
+
 	if (!drive->id || !(drive->id->capability & 1))
-		return -EPERM;
-	if (HWIF(drive)->ide_dma_check == NULL)
-		return -EPERM;
+		goto out;
+
+	if (hwif->ide_dma_check == NULL)
+		goto out;
+
+	err = -EBUSY;
+	if (ide_spin_wait_hwgroup(drive))
+		goto out;
+	/*
+	 * set ->busy flag, unlock and let it ride
+	 */
+	hwif->hwgroup->busy = 1;
+	spin_unlock_irq(&ide_lock);
+
+	err = 0;
+
 	if (arg) {
-		if (ide_set_dma(drive))
-			return -EIO;
-		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
+		if (ide_set_dma(drive) || hwif->ide_dma_on(drive))
+			err = -EIO;
 	} else
 		ide_dma_off(drive);
-	return 0;
+
+	/*
+	 * lock, clear ->busy flag and unlock before leaving
+	 */
+	spin_lock_irq(&ide_lock);
+	hwif->hwgroup->busy = 0;
+	spin_unlock_irq(&ide_lock);
+out:
+	return err;
 #else
 	return -EPERM;
 #endif
