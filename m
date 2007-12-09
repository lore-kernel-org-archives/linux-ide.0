From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/20] ide: fix ->io_32bit race in set_io_32bit()
Date: Sun, 9 Dec 2007 22:06:16 +0100
Message-ID: <200712092206.16225.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXLIVUx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


set_io_32bit() (ide_procset_t function) can race against running
PIO transfers.  Fix it by using ide_spin_wait_hwgroup().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -791,11 +791,17 @@ int set_io_32bit(ide_drive_t *drive, int
 	if (arg < 0 || arg > 1 + (SUPPORT_VLB_SYNC << 1))
 		return -EINVAL;
 
+	if (ide_spin_wait_hwgroup(drive))
+		return -EBUSY;
+
 	drive->io_32bit = arg;
 #ifdef CONFIG_BLK_DEV_DTC2278
 	if (HWIF(drive)->chipset == ide_dtc2278)
 		HWIF(drive)->drives[!drive->select.b.unit].io_32bit = arg;
 #endif /* CONFIG_BLK_DEV_DTC2278 */
+
+	spin_unlock_irq(&ide_lock);
+
 	return 0;
 }
 
