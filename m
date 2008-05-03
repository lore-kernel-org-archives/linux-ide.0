From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: use __generic_unplug_device() in ide_do_drive_cmd()
Date: Sat, 3 May 2008 15:27:02 +0200
Message-ID: <200805031527.02400.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:31365 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbYECNLc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 May 2008 09:11:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1306649fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 03 May 2008 06:11:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

Call __elv_add_request() with 'plug' == 1 (so the device will be
plugged) and then use __generic_unplug_device() instead of calling
ide_do_request() directly.

This is a preparation for converting IDE to use blk_execute_rq().

Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
while the change should be OK it is really better to handle it before
the real conversion

 drivers/ide/ide-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1608,8 +1608,8 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	spin_lock_irqsave(&ide_lock, flags);
 	if (action == ide_preempt)
 		hwgroup->rq = NULL;
-	__elv_add_request(drive->queue, rq, where, 0);
-	ide_do_request(hwgroup, IDE_NO_IRQ);
+	__elv_add_request(drive->queue, rq, where, 1);
+	__generic_unplug_device(drive->queue);
 	spin_unlock_irqrestore(&ide_lock, flags);
 
 	err = 0;
