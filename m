From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] block: handle blk_pm_resume_request() requests in blk_execute_rq_nowait()
Date: Tue, 27 May 2008 22:02:01 +0200
Message-ID: <200805272202.01360.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:5459 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbYEZU17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 16:27:59 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1677751mue.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 13:27:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

For blk_pm_resume_request() requests (which are used only by IDE subsystem
currently) the queue is stopped so we need to call ->request_fn explicitly.

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
goes before "ide: convert ide_do_drive_cmd path to use blk_execute_rq" patch
in IDE tree

 block/blk-exec.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/block/blk-exec.c
===================================================================
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -58,6 +58,9 @@ void blk_execute_rq_nowait(struct reques
 	spin_lock_irq(q->queue_lock);
 	__elv_add_request(q, rq, where, 1);
 	__generic_unplug_device(q);
+	/* the queue is stopped so it won't be plugged+unplugged */
+	if (blk_pm_resume_request(rq))
+		q->request_fn(q);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
