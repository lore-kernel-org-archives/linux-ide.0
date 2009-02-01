From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/8] ide-tape: remove superfluous tape->lock
Date: Sun, 01 Feb 2009 20:27:53 +0100
Message-ID: <20090201192753.1592.73894.sendpatchset@localhost.localdomain>
References: <20090201192732.1592.76435.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:21944 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbZBAT1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 14:27:01 -0500
In-Reply-To: <20090201192732.1592.76435.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-tape: remove superfluous tape->lock

tape->lock is not needed (->queue_lock protects queue).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -245,9 +245,6 @@ typedef struct ide_tape_obj {
 	/* Wasted space in each stage */
 	int excess_bh_size;
 
-	/* protects the ide-tape queue */
-	spinlock_t lock;
-
 	/* Measures average tape speed */
 	unsigned long avg_time;
 	int avg_size;
@@ -481,7 +478,6 @@ static int idetape_end_request(ide_drive
 {
 	struct request *rq = drive->hwif->rq;
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
 	int error;
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
@@ -500,11 +496,8 @@ static int idetape_end_request(ide_drive
 		return 0;
 	}
 
-	spin_lock_irqsave(&tape->lock, flags);
-
 	ide_complete_rq(drive, 0);
 
-	spin_unlock_irqrestore(&tape->lock, flags);
 	return 0;
 }
 
@@ -2192,8 +2185,6 @@ static void idetape_setup(ide_drive_t *d
 	drive->pc_update_buffers = idetape_update_buffers;
 	drive->pc_io_buffers	 = ide_tape_io_buffers;
 
-	spin_lock_init(&tape->lock);
-
 	drive->dev_flags |= IDE_DFLAG_DSC_OVERLAP;
 
 	if (drive->hwif->host_flags & IDE_HFLAG_NO_DSC) {
