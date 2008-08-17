From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] ide-disk: remove stale init_idedisk_capacity() documentation
Date: Sun, 17 Aug 2008 19:15:08 +0200
Message-ID: <20080817171508.27943.34869.sendpatchset@localhost.localdomain>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:30252 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbYHQRR2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:17:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2799973mue.1
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:17:27 -0700 (PDT)
In-Reply-To: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   14 --------------
 1 file changed, 14 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -375,20 +375,6 @@ static void idedisk_check_hpa(ide_drive_
 	}
 }
 
-/*
- * Compute drive->capacity, the full capacity of the drive
- * Called with drive->id != NULL.
- *
- * To compute capacity, this uses either of
- *
- *    1. CHS value set by user       (whatever user sets will be trusted)
- *    2. LBA value from target drive (require new ATA feature)
- *    3. LBA value from system BIOS  (new one is OK, old one may break)
- *    4. CHS value from system BIOS  (traditional style)
- *
- * in above order (i.e., if value of higher priority is available,
- * reset will be ignored).
- */
 static void init_idedisk_capacity(ide_drive_t *drive)
 {
 	u16 *id = drive->id;
