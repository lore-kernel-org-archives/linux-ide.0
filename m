From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] ide: remove IDE PM hack from do_ide_request()
Date: Wed, 12 Nov 2008 22:17:51 +0100
Message-ID: <200811122217.52043.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:18390 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbYKLVdK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 16:33:10 -0500
Received: by ti-out-0910.google.com with SMTP id b6so351755tic.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Nov 2008 13:33:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

We now tell block layer that there is still work to do using
blk_plug_device() so hack for IDE Power Management can be removed
(it was buggy for hwgroups having more than 4 devices anyway).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -786,7 +786,6 @@ void do_ide_request(struct request_queue
 	ide_hwif_t	*hwif;
 	struct request	*rq;
 	ide_startstop_t	startstop;
-	int             loops = 0;
 
 	/* caller must own hwgroup->lock */
 	BUG_ON(!irqs_disabled());
@@ -844,7 +843,7 @@ void do_ide_request(struct request_queue
 
 		if (drive != orig_drive)
 			goto plug_device;
-again:
+
 		hwif = drive->hwif;
 
 		if (hwif != hwgroup->hwif) {
@@ -882,16 +881,10 @@ again:
 		 * though. I hope that doesn't happen too much, hopefully not
 		 * unless the subdriver triggers such a thing in its own PM
 		 * state machine.
-		 *
-		 * We count how many times we loop here to make sure we service
-		 * all drives in the hwgroup without looping for ever
 		 */
 		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) &&
 		    blk_pm_request(rq) == 0 &&
 		    (rq->cmd_flags & REQ_PREEMPT) == 0) {
-			drive = drive->next ? drive->next : hwgroup->drive;
-			if (loops++ < 4 && !blk_queue_plugged(drive->queue))
-				goto again;
 			/* We clear busy, there should be no pending ATA command at this point. */
 			hwgroup->busy = 0;
 			goto plug_device;
