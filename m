From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/15] ide: use drive->select.all for REQ_TYPE_ATA_TASK in execute_drive_cmd()
Date: Sat, 27 Oct 2007 19:46:01 +0200
Message-ID: <200710271946.01213.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48557 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbXJ0Rqk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1026724nfb
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Use drive->select.all for REQ_TYPE_ATA_TASK requests in execute_drive_cmd()
(the obsolete bits 7 and 5 of the Device register need to be set).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -899,7 +899,6 @@ static ide_startstop_t execute_drive_cmd
 		return do_rw_taskfile(drive, args);
 	} else if (rq->cmd_type == REQ_TYPE_ATA_TASK) {
 		u8 *args = rq->buffer;
-		u8 sel;
  
 		if (!args)
 			goto done;
@@ -917,10 +916,7 @@ static ide_startstop_t execute_drive_cmd
  		hwif->OUTB(args[3], IDE_SECTOR_REG);
  		hwif->OUTB(args[4], IDE_LCYL_REG);
  		hwif->OUTB(args[5], IDE_HCYL_REG);
- 		sel = (args[6] & ~0x10);
- 		if (drive->select.b.unit)
- 			sel |= 0x10;
- 		hwif->OUTB(sel, IDE_SELECT_REG);
+ 		hwif->OUTB((args[6] & 0xEF)|drive->select.all, IDE_SELECT_REG);
  		ide_cmd(drive, args[0], args[2], &drive_cmd_intr);
  		return ide_started;
  	} else if (rq->cmd_type == REQ_TYPE_ATA_CMD) {
