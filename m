From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/18] ide: fix registers loading order in ide_dump_ata_status()
Date: Mon, 5 Nov 2007 00:20:57 +0100
Message-ID: <200711050020.57782.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbXKDX3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219894nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:36 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Fix registers loading order in ide_dump_ata_status()/ide_read_24().

Load registers in this order:
* IDE_SECTOR_REG
* IDE_LCYL_REG
* IDE_HCYL_REG
* IDE_SELECT_REG

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    4 ++--
 drivers/ide/ide-lib.c  |   23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -160,9 +160,9 @@ EXPORT_SYMBOL(default_hwif_mmiops);
 
 u32 ide_read_24 (ide_drive_t *drive)
 {
-	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
-	u8 lcyl = HWIF(drive)->INB(IDE_LCYL_REG);
 	u8 sect = HWIF(drive)->INB(IDE_SECTOR_REG);
+	u8 lcyl = HWIF(drive)->INB(IDE_LCYL_REG);
+	u8 hcyl = HWIF(drive)->INB(IDE_HCYL_REG);
 	return (hcyl<<16)|(lcyl<<8)|sect;
 }
 
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -521,19 +521,24 @@ static u8 ide_dump_ata_status(ide_drive_
 				       (unsigned long long) sectors,
 				       high, low);
 			} else {
-				u8 cur = hwif->INB(IDE_SELECT_REG);
+				u8 sector, lcyl, hcyl, cur;
+
+				sector = hwif->INB(IDE_SECTOR_REG);
+				lcyl   = hwif->INB(IDE_LCYL_REG);
+				hcyl   = hwif->INB(IDE_HCYL_REG);
+				cur    = hwif->INB(IDE_SELECT_REG);
+
 				if (cur & 0x40) {	/* using LBA? */
 					printk(", LBAsect=%ld", (unsigned long)
-					 ((cur&0xf)<<24)
-					 |(hwif->INB(IDE_HCYL_REG)<<16)
-					 |(hwif->INB(IDE_LCYL_REG)<<8)
-					 | hwif->INB(IDE_SECTOR_REG));
+						((cur & 0xf) << 24) |
+						(hcyl << 16) |
+						(lcyl <<  8) |
+						sector);
 				} else {
 					printk(", CHS=%d/%d/%d",
-					 (hwif->INB(IDE_HCYL_REG)<<8) +
-					  hwif->INB(IDE_LCYL_REG),
-					  cur & 0xf,
-					  hwif->INB(IDE_SECTOR_REG));
+						(hcyl << 8) + lcyl,
+						cur & 0xf,
+						sector);
 				}
 			}
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
