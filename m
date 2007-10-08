From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/12] ide-disk: fix taskfile registers loading order in __ide_do_rw_disk()
Date: Mon, 8 Oct 2007 23:14:31 +0200
Message-ID: <200710082314.31464.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:59008 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbXJHVjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:55 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370235nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Load IDE_SECTOR_REG after IDE_FEATURE_REG and IDE_NSECTOR_REG when using CHS.

This patch is basically a preparation for the next one which converts
__ide_do_rw_disk() to use struct ide_taskfile.

It shouldn't affect anything (just a usual paranoia to separate changes
which change the way in which hardware is accessed from code cleanups).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -238,7 +238,6 @@ static ide_startstop_t __ide_do_rw_disk(
 		unsigned int sect,head,cyl,track;
 		track = (int)block / drive->sect;
 		sect  = (int)block % drive->sect + 1;
-		hwif->OUTB(sect, IDE_SECTOR_REG);
 		head  = track % drive->head;
 		cyl   = track / drive->head;
 
@@ -246,6 +245,7 @@ static ide_startstop_t __ide_do_rw_disk(
 
 		hwif->OUTB(0x00, IDE_FEATURE_REG);
 		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+		hwif->OUTB(sect, IDE_SECTOR_REG);
 		hwif->OUTB(cyl, IDE_LCYL_REG);
 		hwif->OUTB(cyl>>8, IDE_HCYL_REG);
 		hwif->OUTB(head|drive->select.all,IDE_SELECT_REG);
