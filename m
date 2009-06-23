From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch 2/6] ide: fix ide_kill_rq() for special ide-{floppy,tape} driver requests
Date: Tue, 23 Jun 2009 23:26:06 +0200
Message-ID: <200906232326.06830.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:38080 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZFWVca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 17:32:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix ide_kill_rq() for special ide-{floppy,tape} driver requests

Such requests should be failed with -EIO (like all other requests
in this function) instead of being completed successfully.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Untested, you may try pinging Borislav and/or Tejun about possible
testing if you would like to verify the patch before applying.

 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -152,7 +152,7 @@ void ide_kill_rq(ide_drive_t *drive, str
 
 	if ((media == ide_floppy || media == ide_tape) && drv_req) {
 		rq->errors = 0;
-		ide_complete_rq(drive, 0, blk_rq_bytes(rq));
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
 	} else {
 		if (media == ide_tape)
 			rq->errors = IDE_DRV_ERROR_GENERAL;
