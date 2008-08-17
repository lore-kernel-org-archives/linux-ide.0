From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] ide-disk: set_addressing() fixes
Date: Sun, 17 Aug 2008 19:15:01 +0200
Message-ID: <20080817171501.27943.57473.sendpatchset@localhost.localdomain>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:31381 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbYHQRRW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:17:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1455276fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:17:20 -0700 (PDT)
In-Reply-To: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Return -EIO if arg > 0 and LBA48 is unsupported.

* No need to reset ->addressing.

* Make ->addressing a single bit flag.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |   11 +++++------
 include/linux/ide.h    |    2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -694,14 +694,13 @@ static int set_addressing(ide_drive_t *d
 	if (arg < 0 || arg > 2)
 		return -EINVAL;
 
-	drive->addressing =  0;
-
-	if (drive->hwif->host_flags & IDE_HFLAG_NO_LBA48)
-		return 0;
-
-	if (ata_id_lba48_enabled(drive->id) == 0)
+	if (arg && ((drive->hwif->host_flags & IDE_HFLAG_NO_LBA48) ||
+	    ata_id_lba48_enabled(drive->id) == 0))
 		return -EIO;
 
+	if (arg == 2)
+		arg = 0;
+
 	drive->addressing = arg;
 
 	return 0;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -507,7 +507,7 @@ struct ide_drive_s {
 	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
 	unsigned post_reset	: 1;
 	unsigned udma33_warned	: 1;
-	unsigned addressing	: 2;	/* 0=28-bit, 1=48-bit, 2=48-bit doing 28-bit */
+	unsigned addressing	: 1;	/* 0=28-bit, 1=48-bit */
 	unsigned wcache		: 1;	/* status of write cache */
 	unsigned nowerr		: 1;	/* used for ignoring ATA_DF */
 
