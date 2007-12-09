From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/20] dtc2278: ->io_32bit setting don't have to be identical for master/slave
Date: Sun, 9 Dec 2007 22:08:58 +0100
Message-ID: <200712092208.58494.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55848 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbXLIVUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381313ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


drive->io_32bit is used per PIO transfer so there is no reason to
require it to be identical for master/slave.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c            |    4 ----
 drivers/ide/legacy/dtc2278.c |    7 +------
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -795,10 +795,6 @@ int set_io_32bit(ide_drive_t *drive, int
 		return -EBUSY;
 
 	drive->io_32bit = arg;
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (HWIF(drive)->chipset == ide_dtc2278)
-		HWIF(drive)->drives[!drive->select.b.unit].io_32bit = arg;
-#endif /* CONFIG_BLK_DEV_DTC2278 */
 
 	spin_unlock_irq(&ide_lock);
 
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -34,8 +34,7 @@
  * filesystem  corrupted with -u1, but under heavy disk load only :-)
  *
  * This card is now forced to use the "serialize" feature,
- * and irq-unmasking is disallowed.  If io_32bit is enabled,
- * it must be done for BOTH drives on each interface.
+ * and irq-unmasking is disallowed.
  *
  * This code was written for the DTC2278E, but might work with any of these:
  *
@@ -87,11 +86,7 @@ static void dtc2278_set_pio_mode(ide_dri
 		   Winbond but does anyone actually care */
 	}
 
-	/*
-	 * 32bit I/O has to be enabled for *both* drives at the same time.
-	 */
 	drive->io_32bit = 1;
-	HWIF(drive)->drives[!drive->select.b.unit].io_32bit = 1;
 }
 
 static int __init dtc2278_probe(void)
