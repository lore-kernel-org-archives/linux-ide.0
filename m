From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/40] ide-tape: make idetape_retry_pc() void
Date: Sun, 18 May 2008 20:56:52 +0200
Message-ID: <20080518185652.5636.43332.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:17569 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209AbYERSj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:39:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473279fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:39:26 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

idetape_retry_pc() always returns ide_stopped so make it void.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -696,7 +696,7 @@ static void idetape_queue_pc_head(ide_dr
  *	last packet command. We queue a request sense packet command in
  *	the head of the request list.
  */
-static ide_startstop_t idetape_retry_pc (ide_drive_t *drive)
+static void idetape_retry_pc(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct ide_atapi_pc *pc;
@@ -708,7 +708,6 @@ static ide_startstop_t idetape_retry_pc 
 	idetape_create_request_sense_cmd(pc);
 	set_bit(IDETAPE_FLAG_IGNORE_DSC, &tape->flags);
 	idetape_queue_pc_head(drive, pc, rq);
-	return ide_stopped;
 }
 
 /*
@@ -784,7 +783,8 @@ static ide_startstop_t idetape_pc_intr(i
 					pc->c[0]);
 
 			/* Retry operation */
-			return idetape_retry_pc(drive);
+			idetape_retry_pc(drive);
+			return ide_stopped;
 		}
 		pc->error = 0;
 		if ((pc->flags & PC_FLAG_WAIT_FOR_DSC) &&
@@ -1078,7 +1078,8 @@ static ide_startstop_t idetape_media_acc
 				printk(KERN_ERR "ide-tape: %s: I/O error, ",
 						tape->name);
 			/* Retry operation */
-			return idetape_retry_pc(drive);
+			idetape_retry_pc(drive);
+			return ide_stopped;
 		}
 		pc->error = 0;
 		if (tape->failed_pc == pc)
