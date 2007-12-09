From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/20] ide: remove needless ->cursg clearing from task_end_request()
Date: Sun, 9 Dec 2007 22:13:13 +0100
Message-ID: <200712092213.13551.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXLIVU7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 16:20:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1381310ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 13:20:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -410,8 +410,6 @@ static ide_startstop_t task_error(ide_dr
 
 static void task_end_request(ide_drive_t *drive, struct request *rq, u8 stat)
 {
-	HWIF(drive)->cursg = NULL;
-
 	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *task = rq->special;
 
