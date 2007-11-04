From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/18] ide: add missing HOB bit clearing to ide_dump_ata_status()
Date: Mon, 5 Nov 2007 00:20:05 +0100
Message-ID: <200711050020.05530.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbXKDX3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -512,6 +512,7 @@ static u8 ide_dump_ata_status(ide_drive_
 			if (drive->addressing == 1) {
 				__u64 sectors = 0;
 				u32 low = 0, high = 0;
+				hwif->OUTB(drive->ctl&~0x80, IDE_CONTROL_REG);
 				low = ide_read_24(drive);
 				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 				high = ide_read_24(drive);
