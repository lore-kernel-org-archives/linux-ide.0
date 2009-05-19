From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix printk() levels in ide_dump_ata[pi]_error()
Date: Tue, 19 May 2009 23:17:23 +0200
Message-ID: <200905192317.24120.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:48523 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZESVOl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:14:41 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin Lottermoser <Martin.Lottermoser@t-online.de>

Fixes "<3>" in error messages like this one:

hdc: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }

Reported-by: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -91,7 +91,7 @@ static void ide_dump_sector(ide_drive_t 
 
 static void ide_dump_ata_error(ide_drive_t *drive, u8 err)
 {
-	printk(KERN_ERR "{ ");
+	printk(KERN_CONT "{ ");
 	if (err & ATA_ABORTED)
 		printk(KERN_CONT "DriveStatusError ");
 	if (err & ATA_ICRC)
@@ -121,7 +121,7 @@ static void ide_dump_ata_error(ide_drive
 
 static void ide_dump_atapi_error(ide_drive_t *drive, u8 err)
 {
-	printk(KERN_ERR "{ ");
+	printk(KERN_CONT "{ ");
 	if (err & ATAPI_ILI)
 		printk(KERN_CONT "IllegalLengthIndication ");
 	if (err & ATAPI_EOM)
