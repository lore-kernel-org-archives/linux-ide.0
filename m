From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: set REQ_NOMERGE request flag in ide_do_drive_cmd()
Date: Sat, 3 May 2008 15:14:24 +0200
Message-ID: <200805031514.24727.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:31218 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYECNLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 May 2008 09:11:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1306629fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 03 May 2008 06:11:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

This is a preparation for converting IDE to use blk_execute_rq().

There should be no functional changes caused by this patch.

Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1603,6 +1603,8 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	if (action == ide_preempt || action == ide_head_wait)
 		where = ELEVATOR_INSERT_FRONT;
 
+	rq->cmd_flags |= REQ_NOMERGE;
+
 	spin_lock_irqsave(&ide_lock, flags);
 	if (action == ide_preempt)
 		hwgroup->rq = NULL;
