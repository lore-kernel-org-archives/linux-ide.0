From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: cleanup ide_do_request()
Date: Wed, 15 Oct 2008 21:35:40 +0200
Message-ID: <200810152135.41022.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:59673 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbYJOTu2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:28 -0400
Received: by gv-out-0910.google.com with SMTP id e6so701047gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Elias Oltmanns <eo@nebensachen.de>

Both choose_drive() and PM handling code make sure that the queue
is unplugged so no need to check it again.

Cc: Elias Oltmanns <eo@nebensachen.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes before "ide: don't execute the next queued command from the
hard-IRQ context" but is independent from it

 drivers/ide/ide-io.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1016,11 +1016,6 @@ static void ide_do_request (ide_hwgroup_
 		drive->dev_flags &= ~(IDE_DFLAG_SLEEPING | IDE_DFLAG_PARKED);
 		drive->service_start = jiffies;
 
-		if (blk_queue_plugged(drive->queue)) {
-			printk(KERN_ERR "ide: huh? queue was plugged!\n");
-			break;
-		}
-
 		/*
 		 * we know that the queue isn't empty, but this can happen
 		 * if the q->prep_rq_fn() decides to kill a request
