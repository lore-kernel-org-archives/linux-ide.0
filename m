From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/15] ide: clear HOB bit for REQ_TYPE_ATA_TASK requests in ide_end_drive_cmd()
Date: Sat, 27 Oct 2007 19:45:50 +0200
Message-ID: <200710271945.50655.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48557 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbXJ0Rqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026724nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ide_dump_ata_status() may set HOB bit before ide_end_drive_cmd() is called.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -342,6 +342,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		if (args) {
 			args[0] = stat;
 			args[1] = err;
+			/* be sure we're looking at the low order bits */
+			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
 			args[2] = hwif->INB(IDE_NSECTOR_REG);
 			args[3] = hwif->INB(IDE_SECTOR_REG);
 			args[4] = hwif->INB(IDE_LCYL_REG);
