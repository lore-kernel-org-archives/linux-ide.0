From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/20] ide: clear HOB bit for REQ_TYPE_ATA_CMD requests in ide_end_drive_cmd()
Date: Sun, 9 Dec 2007 22:09:40 +0100
Message-ID: <200712092209.40545.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:55432 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXLIVUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381308ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ide_dump_status() may set HOB bit before ide_end_drive_cmd() is called.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -370,6 +370,8 @@ void ide_end_drive_cmd (ide_drive_t *dri
 		if (args) {
 			args[0] = stat;
 			args[1] = err;
+			/* be sure we're looking at the low order bits */
+			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
 			args[2] = hwif->INB(IDE_NSECTOR_REG);
 		}
 	} else if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
