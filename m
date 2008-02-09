From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide-tape: remove never executed code
Date: Sat, 9 Feb 2008 16:23:46 +0100
Message-ID: <200802091623.46896.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:43343 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYBIQSI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 11:18:08 -0500
Received: by py-out-1112.google.com with SMTP id u52so5966991pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 08:18:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


rq->cmd[0] is never set to REQ_IDETAPE_READ_BUFFER so remove
REQ_IDETAPE_READ_BUFFER handling from idetape_create_write_cmd()
and the define itself.

Then remove no longer used idetape_create_read_buffer_cmd()
and IDETAPE_RETRIEVE_FAULTY_BLOCK define.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   34 ----------------------------------
 1 file changed, 34 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -466,9 +466,6 @@ static void ide_tape_put(struct ide_tape
 /* 0 = no tape is loaded, so we don't rewind after ejecting */
 #define IDETAPE_MEDIUM_PRESENT		9
 
-/* A define for the READ BUFFER command */
-#define IDETAPE_RETRIEVE_FAULTY_BLOCK	6
-
 /* Some defines for the SPACE command */
 #define IDETAPE_SPACE_OVER_FILEMARK	1
 #define IDETAPE_SPACE_TO_EOD		3
@@ -490,7 +487,6 @@ enum {
 	REQ_IDETAPE_PC2		= (1 << 1), /* packet command (second stage) */
 	REQ_IDETAPE_READ	= (1 << 2),
 	REQ_IDETAPE_WRITE	= (1 << 3),
-	REQ_IDETAPE_READ_BUFFER	= (1 << 4),
 };
 
 /* Error codes returned in rq->errors to the higher part of the driver. */
@@ -1523,29 +1519,6 @@ static void idetape_create_read_cmd(idet
 		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
 }
 
-static void idetape_create_read_buffer_cmd(idetape_tape_t *tape,
-		idetape_pc_t *pc, struct idetape_bh *bh)
-{
-	int size = 32768;
-	struct idetape_bh *p = bh;
-
-	idetape_init_pc(pc);
-	pc->c[0] = READ_BUFFER;
-	pc->c[1] = IDETAPE_RETRIEVE_FAULTY_BLOCK;
-	pc->c[7] = size >> 8;
-	pc->c[8] = size & 0xff;
-	pc->callback = &idetape_pc_callback;
-	pc->bh = bh;
-	atomic_set(&bh->b_count, 0);
-	pc->buffer = NULL;
-	while (p) {
-		atomic_set(&p->b_count, 0);
-		p = p->b_reqnext;
-	}
-	pc->request_transfer = size;
-	pc->buffer_size = size;
-}
-
 static void idetape_create_write_cmd(idetape_tape_t *tape, idetape_pc_t *pc,
 		unsigned int length, struct idetape_bh *bh)
 {
@@ -1655,13 +1628,6 @@ static ide_startstop_t idetape_do_reques
 					 (struct idetape_bh *)rq->special);
 		goto out;
 	}
-	if (rq->cmd[0] & REQ_IDETAPE_READ_BUFFER) {
-		tape->postpone_cnt = 0;
-		pc = idetape_next_pc_storage(drive);
-		idetape_create_read_buffer_cmd(tape, pc,
-				(struct idetape_bh *)rq->special);
-		goto out;
-	}
 	if (rq->cmd[0] & REQ_IDETAPE_PC1) {
 		pc = (idetape_pc_t *) rq->buffer;
 		rq->cmd[0] &= ~(REQ_IDETAPE_PC1);
