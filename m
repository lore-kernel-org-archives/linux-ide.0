From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/15] ide: check rq->cmd_type in drive_cmd_intr()
Date: Sat, 27 Oct 2007 19:45:44 +0200
Message-ID: <200710271945.45000.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:9451 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbXJ0Rqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 13:46:38 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1942010mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 10:46:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


drive_cmd_intr() is used by both REQ_TYPE_ATA_CMD and REQ_TYPE_ATA_TASK
but commands using PIO-in protocol are valid only for REQ_TYPE_ATA_CMD
(&args[4] in case of REQ_TYPE_ATA_TASK points to a value for IDE_LCYL_REG
register instead of the data buffer).  This fix allows REQ_TYPE_ATA_TASK
commands to use non-zero values for IDE_SECTOR_REG (args[3]).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -659,7 +659,8 @@ static ide_startstop_t drive_cmd_intr (i
 	int retries = 10;
 
 	local_irq_enable_in_hardirq();
-	if ((stat & DRQ_STAT) && args && args[3]) {
+	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
+	    (stat & DRQ_STAT) && args && args[3]) {
 		u8 io_32bit = drive->io_32bit;
 		drive->io_32bit = 0;
 		hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
