From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use __generic_unplug_device() in ide_do_drive_cmd() (take 2)
Date: Tue, 27 May 2008 22:01:57 +0200
Message-ID: <200805272201.58035.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5569 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbYEZU17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 16:27:59 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1677724mue.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 13:27:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

* Call __elv_add_request() with 'plug' == 1 (so the device will be
  plugged) and then use __generic_unplug_device() instead of calling
  ide_do_request() directly.

v2:
* For blk_pm_resume_request() requests the queue is stopped so we
  need to call ->request_fn explicitly.

  Thanks to:
  - Rafael for reporting/bisecting the bug
  - Borislav/Rafael for testing the fix

This is a preparation for converting IDE to use blk_execute_rq().

Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch

 drivers/ide/ide-io.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1606,8 +1606,11 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	spin_lock_irqsave(&ide_lock, flags);
 	if (action == ide_preempt)
 		hwgroup->rq = NULL;
-	__elv_add_request(drive->queue, rq, where, 0);
-	ide_do_request(hwgroup, IDE_NO_IRQ);
+	__elv_add_request(drive->queue, rq, where, 1);
+	__generic_unplug_device(drive->queue);
+	/* the queue is stopped so it won't be plugged+unplugged */
+	if (blk_pm_resume_request(rq))
+		do_ide_request(drive->queue);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	err = 0;
