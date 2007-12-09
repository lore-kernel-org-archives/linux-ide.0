From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/20] ide: fix final status check in task_in_intr()
Date: Sun, 9 Dec 2007 22:10:35 +0100
Message-ID: <200712092210.35728.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXLIVU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381310ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Check for DRQ bit being cleared on the final status check.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -454,7 +454,7 @@ static ide_startstop_t task_in_intr(ide_
 	/* If it was the last datablock check status and finish transfer. */
 	if (!hwif->nleft) {
 		stat = wait_drive_not_busy(drive);
-		if (!OK_STAT(stat, 0, BAD_R_STAT))
+		if (!OK_STAT(stat, 0, BAD_STAT))
 			return task_error(drive, rq, __FUNCTION__, stat);
 		task_end_request(drive, rq, stat);
 		return ide_stopped;
