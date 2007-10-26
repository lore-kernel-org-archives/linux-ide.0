From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-tape: remove dead USE_IOTRACE code
Date: Fri, 26 Oct 2007 23:29:21 +0200
Message-ID: <200710262329.21165.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:8493 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbXJZVXo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 17:23:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so893626nfb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 14:23:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   22 ----------------------
 1 file changed, 22 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -615,16 +615,6 @@ typedef struct os_dat_s {
 /*************************** End of tunable parameters ***********************/
 
 /*
- *	Debugging/Performance analysis
- *
- *	I/O trace support
- */
-#define USE_IOTRACE	0
-#if USE_IOTRACE
-#define IO_IDETAPE_FIFO	500
-#endif
-
-/*
  *	Read/Write error simulation
  */
 #define SIMULATE_ERRORS			0
@@ -2502,9 +2492,6 @@ static ide_startstop_t idetape_do_reques
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_READ) {
 		tape->buffer_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
-#endif
 		tape->postpone_cnt = 0;
 		pc = idetape_next_pc_storage(drive);
 		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
@@ -2512,9 +2499,6 @@ static ide_startstop_t idetape_do_reques
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 		tape->buffer_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
-#endif
 		tape->postpone_cnt = 0;
 		pc = idetape_next_pc_storage(drive);
 		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors, (struct idetape_bh *)rq->special);
@@ -3241,9 +3225,6 @@ static int idetape_add_chrdev_write_requ
 	idetape_switch_buffers(tape, new_stage);
 	idetape_add_stage_tail(drive, new_stage);
 	tape->pipeline_head++;
-#if USE_IOTRACE
-	IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
-#endif
 	calculate_speeds(drive);
 
 	/*
@@ -3493,9 +3474,6 @@ static int idetape_add_chrdev_read_reque
 		idetape_remove_stage_head(drive);
 		spin_unlock_irqrestore(&tape->spinlock, flags);
 		tape->pipeline_head++;
-#if USE_IOTRACE
-		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
-#endif
 		calculate_speeds(drive);
 	}
 #if IDETAPE_DEBUG_BUGS
