From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/2] ide-{floppy,tape}: remove request stack
Date: Wed, 6 Aug 2008 19:14:06 +0200
Message-ID: <200808061914.06361.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:31371 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbYHFRR3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 13:17:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so9836fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 10:17:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

* Add 'struct request request_sense_rq' to struct ide_{floppy,tape}_obj
  and switch ide*_retry_pc() to use it (there can be only one REQUEST SENSE
  request active for a given device).

* Remove no longer needed ide*_next_rq_storage(), rq_stack[]
  and rq_stack_index.

* DBG_PCRQ_STACK -> DBG_PC_STACK

* Update comments for IDE*_PC_STACK and idetape_queue_pc_{head,tail}().

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
pc stack can also be removed with a bit of care, we just need sth like:

- add request_sense_pc (request_sense_rq alike)

- dynamically allocate pc-s for blk_{fs,pc}_request() in ide-floppy.c
  and for REQ_IDETAPE_{READ,WRITE} in ide-tape.c

- add PC_FLAG_DYN for dynamically allocated pc-s

- (the difficult part) figure out where to put freeing of dynamic pc-s

Borislav, AFAIR you had some patches doing dynamic pc/rq-s?
Maybe it would be possible to dust off just their rq-parts?

 drivers/ide/ide-floppy.c |   22 ++++-----------
 drivers/ide/ide-tape.c   |   68 ++++++++---------------------------------------
 2 files changed, 18 insertions(+), 72 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -76,8 +76,8 @@
 
 /*
  * In various places in the driver, we need to allocate storage for packet
- * commands and requests, which will remain valid while	we leave the driver to
- * wait for an interrupt or a timeout event.
+ * commands, which will remain valid while we leave the driver to wait for
+ * an interrupt or a timeout event.
  */
 #define IDEFLOPPY_PC_STACK		(10 + IDEFLOPPY_MAX_PC_RETRIES)
 
@@ -107,9 +107,8 @@ typedef struct ide_floppy_obj {
 	struct ide_atapi_pc pc_stack[IDEFLOPPY_PC_STACK];
 	/* Next free packet command storage space */
 	int pc_stack_index;
-	struct request rq_stack[IDEFLOPPY_PC_STACK];
-	/* We implement a circular array */
-	int rq_stack_index;
+
+	struct request request_sense_rq;
 
 	/* Last error information */
 	u8 sense_key, asc, ascq;
@@ -298,15 +297,6 @@ static struct ide_atapi_pc *idefloppy_ne
 	return (&floppy->pc_stack[floppy->pc_stack_index++]);
 }
 
-static struct request *idefloppy_next_rq_storage(ide_drive_t *drive)
-{
-	idefloppy_floppy_t *floppy = drive->driver_data;
-
-	if (floppy->rq_stack_index == IDEFLOPPY_PC_STACK)
-		floppy->rq_stack_index = 0;
-	return (&floppy->rq_stack[floppy->rq_stack_index++]);
-}
-
 static void ide_floppy_callback(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
@@ -365,12 +355,12 @@ static void idefloppy_create_request_sen
  */
 static void idefloppy_retry_pc(ide_drive_t *drive)
 {
+	struct ide_floppy_obj *floppy = drive->driver_data;
+	struct request *rq = &floppy->request_sense_rq;
 	struct ide_atapi_pc *pc;
-	struct request *rq;
 
 	(void)ide_read_error(drive);
 	pc = idefloppy_next_pc_storage(drive);
-	rq = idefloppy_next_rq_storage(drive);
 	idefloppy_create_request_sense_cmd(pc);
 	idefloppy_queue_pc_head(drive, pc, rq);
 }
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -56,8 +56,8 @@ enum {
 	DBG_CHRDEV =		(1 << 2),
 	/* all remaining procedures */
 	DBG_PROCS =		(1 << 3),
-	/* buffer alloc info (pc_stack & rq_stack) */
-	DBG_PCRQ_STACK =	(1 << 4),
+	/* buffer alloc info (pc_stack) */
+	DBG_PC_STACK =	(1 << 4),
 };
 
 /* define to see debug info */
@@ -89,9 +89,9 @@ enum {
 #define IDETAPE_PC_BUFFER_SIZE		256
 
 /*
- *	In various places in the driver, we need to allocate storage
- *	for packet commands and requests, which will remain valid while
- *	we leave the driver to wait for an interrupt or a timeout event.
+ * In various places in the driver, we need to allocate storage for packet
+ * commands, which will remain valid while we leave the driver to wait for
+ * an interrupt or a timeout event.
  */
 #define IDETAPE_PC_STACK		(10 + IDETAPE_MAX_PC_RETRIES)
 
@@ -230,9 +230,8 @@ typedef struct ide_tape_obj {
 	struct ide_atapi_pc pc_stack[IDETAPE_PC_STACK];
 	/* Next free packet command storage space */
 	int pc_stack_index;
-	struct request rq_stack[IDETAPE_PC_STACK];
-	/* We implement a circular array */
-	int rq_stack_index;
+
+	struct request request_sense_rq;
 
 	/*
 	 * DSC polling variables.
@@ -462,7 +461,7 @@ static struct ide_atapi_pc *idetape_next
 {
 	idetape_tape_t *tape = drive->driver_data;
 
-	debug_log(DBG_PCRQ_STACK, "pc_stack_index=%d\n", tape->pc_stack_index);
+	debug_log(DBG_PC_STACK, "pc_stack_index=%d\n", tape->pc_stack_index);
 
 	if (tape->pc_stack_index == IDETAPE_PC_STACK)
 		tape->pc_stack_index = 0;
@@ -470,30 +469,6 @@ static struct ide_atapi_pc *idetape_next
 }
 
 /*
- *	idetape_next_rq_storage is used along with idetape_next_pc_storage.
- *	Since we queue packet commands in the request queue, we need to
- *	allocate a request, along with the allocation of a packet command.
- */
-
-/**************************************************************
- *                                                            *
- *  This should get fixed to use kmalloc(.., GFP_ATOMIC)      *
- *  followed later on by kfree().   -ml                       *
- *                                                            *
- **************************************************************/
-
-static struct request *idetape_next_rq_storage(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	debug_log(DBG_PCRQ_STACK, "rq_stack_index=%d\n", tape->rq_stack_index);
-
-	if (tape->rq_stack_index == IDETAPE_PC_STACK)
-		tape->rq_stack_index = 0;
-	return (&tape->rq_stack[tape->rq_stack_index++]);
-}
-
-/*
  * called on each failed packet command retry to analyze the request sense. We
  * currently do not utilize this information.
  */
@@ -692,17 +667,7 @@ static void idetape_create_request_sense
 /*
  * Generate a new packet command request in front of the request queue, before
  * the current request, so that it will be processed immediately, on the next
- * pass through the driver. The function below is called from the request
- * handling part of the driver (the "bottom" part). Safe storage for the request
- * should be allocated with ide_tape_next_{pc,rq}_storage() prior to that.
- *
- * Memory for those requests is pre-allocated at initialization time, and is
- * limited to IDETAPE_PC_STACK requests. We assume that we have enough space for
- * the maximum possible number of inter-dependent packet commands.
- *
- * The higher level of the driver - The ioctl handler and the character device
- * handling functions should queue request to the lower level part and wait for
- * their completion using idetape_queue_pc_tail or idetape_queue_rw_tail.
+ * pass through the driver.
  */
 static void idetape_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
 				  struct request *rq)
@@ -726,12 +691,12 @@ static void idetape_queue_pc_head(ide_dr
  */
 static void idetape_retry_pc(ide_drive_t *drive)
 {
+	struct ide_tape_obj *tape = drive->driver_data;
+	struct request *rq = &tape->request_sense_rq;
 	struct ide_atapi_pc *pc;
-	struct request *rq;
 
 	(void)ide_read_error(drive);
 	pc = idetape_next_pc_storage(drive);
-	rq = idetape_next_rq_storage(drive);
 	idetape_create_request_sense_cmd(pc);
 	set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
 	idetape_queue_pc_head(drive, pc, rq);
@@ -1246,16 +1211,7 @@ static void idetape_create_test_unit_rea
 
 /*
  * We add a special packet command request to the tail of the request queue, and
- * wait for it to be serviced. This is not to be called from within the request
- * handling part of the driver! We allocate here data on the stack and it is
- * valid until the request is finished. This is not the case for the bottom part
- * of the driver, where we are always leaving the functions to wait for an
- * interrupt or a timer event.
- *
- * From the bottom part of the driver, we should allocate safe memory using
- * idetape_next_pc_storage() and ide_tape_next_rq_storage(), and add the request
- * to the request list without waiting for it to be serviced! In that case, we
- * usually use idetape_queue_pc_head().
+ * wait for it to be serviced.
  */
 static int idetape_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
