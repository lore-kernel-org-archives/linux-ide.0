From: "stuart hayes" <stuart_hayes@lycos.com>
Subject: Re: [PATCH] (for ide-tape.c in 2.4.22-ac4) ide-tape.c doesn't work with Seagate
Date: Mon, 27 Oct 2003 17:14:15 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <IENNNAGNACABNDAA@mailcity.com>
Reply-To: stuart_hayes@lycos.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www5.mail.lycos.com ([209.202.220.85]:29437 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263760AbTJ0VOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2003 16:14:36 -0500
Content-Language: en
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, stuart_hayes@dell.com
Cc: linux-ide@vger.kernel.org

Bart--

OK, I've updated the patch with the changes you suggested.  To summarize what is changed in ide-tape.c with this patch:
---
Check drive's write protect bit, try to return appropriate errors when attempting to write a write-protected tape

Moved "idetape_read_position" call in idetape_chrdev_open after the "wait_ready" call

Added IDETAPE_MEDIUM_PRESENT flag so driver would know not to rewind tape after ejecting it

Fixed bug with ide_abort_pipeline (it was deleting stages from tape->next_stage to end, instead of from new_last_stage->next (tape->next_stage was set to NULL by idetape_discard_read_pipeline before calling!)

Deleted "idetape_do_end_request"--this was just a copy of ide_end_request

Made improvements to idetape_wait_ready

Added a few comments here and there

Made MTOFFL unlock tape drive door before attempting to eject

Added fixes to get Seagate STT3401A Travan working:
  handle drives that don't support 0-length reads/writes
  increased timeout (retension takes ~10 minutes before irq is returned)
  fixed request mode page packet command byte 3
---

Thanks,
Stuart



--- ide-tape.c.orig	2003-10-24 13:55:48.000000000 -0500
+++ ide-tape.c	2003-10-27 14:21:28.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.17c	Sep, 2003
+ * linux/drivers/ide/ide-tape.c		Version 1.18	Sep, 2003
  *
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
  *
@@ -316,6 +316,27 @@
  * Ver 1.17c Sep 2003	Stuart Hayes <stuart_hayes@dell.com>
  *			Initialized "feature" in idetape_issue_packet_command
  *			 (this was causing lockups on certain systems)
+ * Ver 1.18a Sep 2003	Stuart Hayes <stuart_hayes@dell.com>
+ *			Check drive's write protect bit, try to return appropriate
+ *			  errors when attempting to write a write-protected tape
+ *			Moved "idetape_read_position" call in idetape_chrdev_open
+ *			  after the "wait_ready" call
+ *			Added IDETAPE_MEDIUM_PRESENT flag so driver would know
+ *			  not to rewind tape after ejecting it 
+ *			Fixed bug with ide_abort_pipeline (it was deleting stages
+ *			  from tape->next_stage to end, instead of from
+ *			  new_last_stage->next (tape->next_stage was set to NULL
+ *			  by idetape_discard_read_pipeline before calling!)
+ *			Deleted "idetape_do_end_request"--this was just a copy of
+ *			  ide_end_request
+ *			Made improvements to idetape_wait_ready
+ *			Added a few comments here and there
+ *			Made MTOFFL unlock tape drive door before attempting to eject
+ *			Added fixes to get Seagate STT3401A Travan working:
+ *			  handle drives that don't support 0-length reads/writes
+ *			  increased timeout (retension takes ~10 minutes before
+ *			    irq is returned)
+ *			  fixed request mode page packet command byte 3
  *
  * Here are some words from the first releases of hd.c, which are quoted
  * in ide.c and apply here as well:
@@ -425,7 +446,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
  */
 
-#define IDETAPE_VERSION "1.17c"
+#define IDETAPE_VERSION "1.18"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -653,8 +674,13 @@
 
 /*
  *	Some tape drives require a long irq timeout
+ *
+ *      Some drives (for example, the Seagate STT3401A Travan)
+ *      require a very long timeout, because they don't
+ *      return an interrupt or clear their busy bit until after the
+ *      command completes--even retension commands.
  */
-#define IDETAPE_WAIT_CMD		(60*HZ)
+#define IDETAPE_WAIT_CMD		(900*HZ)
 
 /*
  *	The following parameter is used to select the point in the internal
@@ -1040,6 +1066,8 @@
 
 	/* the door is currently locked */
 	int door_locked;
+	/* the tape is write protected */
+	int drv_write_prot;
 
 	/*
 	 * OnStream flags
@@ -1172,7 +1200,7 @@
 #define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
 #define IDETAPE_READ_ERROR		7
 #define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
-
+#define IDETAPE_MEDIUM_PRESENT		9	/* 0=no tape loaded, so we don't rewind after ejecting */
 /*
  *	Supported ATAPI tape drives packet commands
  */
@@ -1701,6 +1729,21 @@
 		idetape_update_buffers(pc);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
+
+	/*	If error was the result of a zero-length read or write
+	 *	command, with sense key=5, let it slide...
+	 *	some drives (Seagate STT3401A Travan) don't
+	 *	support 0-length read/writes
+	 */
+
+	if ((pc->c[0] == IDETAPE_READ_CMD || pc->c[0] == IDETAPE_WRITE_CMD)
+	    && pc->c[4] == 0 && pc->c[3] == 0 && pc->c[2] == 0) {  /* length==0 */
+		if (result->sense_key == 5) {
+			pc->error = 0;  /* don't report an error, everything's ok */
+			set_bit(PC_ABORT, &pc->flags);  /* don't retry read/write */
+		}
+	}
+
 	if (pc->c[0] == IDETAPE_READ_CMD && result->filemark) {
 		pc->error = IDETAPE_ERROR_FILEMARK;
 		set_bit(PC_ABORT, &pc->flags);
@@ -1844,10 +1887,18 @@
 	}
 }
 
-static void idetape_abort_pipeline (ide_drive_t *drive, idetape_stage_t *last_stage)
+/*
+ * idetape_abort_pipeline
+ * ----------------------
+ *   This will free all the pipeline stages starting from  
+ *     new_last_stage->next to the end of the list, and point 
+ *     tape->last_stage to new_last_stage.
+ */
+
+static void idetape_abort_pipeline (ide_drive_t *drive, idetape_stage_t *new_last_stage)
 {
 	idetape_tape_t *tape = drive->driver_data;
-	idetape_stage_t *stage = tape->next_stage;
+	idetape_stage_t *stage = new_last_stage->next;
 	idetape_stage_t *nstage;
 
 #if IDETAPE_DEBUG_LOG
@@ -1862,9 +1913,9 @@
 		--tape->nr_pending_stages;
 		stage = nstage;
 	}
-	tape->last_stage = last_stage;
-	if (last_stage)
-		last_stage->next = NULL;
+	if (new_last_stage)
+		new_last_stage->next = NULL;
+	tape->last_stage = new_last_stage;
 	tape->next_stage = NULL;
 }
 
@@ -2492,7 +2543,11 @@
 	if (page_code != IDETAPE_BLOCK_DESCRIPTOR)
 		pc->c[1] = 8;	/* DBD = 1 - Don't return block descriptors */
 	pc->c[2] = page_code;
-	pc->c[3] = 255;		/* Don't limit the returned information */
+        /*  Changed pc->c[3] (subpages) to 0... 255 will at best return  *
+         *    unused info... for SCSI, this byte is defined as subpage   *
+         *    instead of high byte of length, and some IDE drives        *
+	 *    seem to interpret it this way and return an error.         */
+	pc->c[3] = 0;		/* Don't limit the returned information */
 	pc->c[4] = 255;		/* (We will just discard data in that case) */
 	if (page_code == IDETAPE_BLOCK_DESCRIPTOR)
 		pc->request_transfer = 12;
@@ -2609,11 +2664,11 @@
 	if (status.b.dsc) {
 		if (status.b.check) {
 			/* Error detected */
-			printk(KERN_ERR "ide-tape: %s: I/O error: "
-			    "pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
-			    tape->name, pc->c[0],
-			    tape->sense_key, tape->asc, tape->ascq);
-
+			if (pc->c[0] != IDETAPE_TEST_UNIT_READY_CMD) 
+				printk(KERN_ERR "ide-tape: %s: I/O error: "
+				    "pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
+				    tape->name, pc->c[0],
+				    tape->sense_key, tape->asc, tape->ascq);
 			/* Retry operation */
 			return idetape_retry_pc(drive);
 		}
@@ -2749,38 +2804,6 @@
 }
 
 /*
- * This is our end_request replacement function.
- */
-static int idetape_do_end_request (ide_drive_t *drive, int uptodate)
-{
-	struct request *rq;
-	unsigned long flags;
-	int ret = 1;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-	rq = HWGROUP(drive)->rq;
-
-	/*
-	 * decide whether to reenable DMA -- 3 is a random magic for now,
-	 * if we DMA timeout more than 3 times, just stay in PIO
-	 */
-	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
-		drive->state = 0;
-		HWGROUP(drive)->hwif->ide_dma_on(drive);
-	}
-
-	if (!end_that_request_first(rq, uptodate, drive->name)) {
-		add_blkdev_randomness(MAJOR(rq->rq_dev));
-		blkdev_dequeue_request(rq);
-		HWGROUP(drive)->rq = NULL;
-		end_that_request_last(rq);
-		ret = 0;
-	}
-	spin_unlock_irqrestore(&io_request_lock, flags);
-	return ret;
-}
-
-/*
  *	idetape_do_request is our request handling function.	
  */
 static ide_startstop_t idetape_do_request (ide_drive_t *drive, struct request *rq, unsigned long block)
@@ -2807,7 +2830,7 @@
 		 */
 		printk(KERN_NOTICE "ide-tape: %s: Unsupported command in "
 			"request queue (%d)\n", drive->name, rq->cmd);
-		idetape_do_end_request(drive, 0);
+		ide_end_request(drive, 0);
 		return ide_stopped;
 	}
 
@@ -3406,29 +3429,31 @@
 	pc->callback = &idetape_pc_callback;
 }
 
-static int idetape_wait_ready (ide_drive_t *drive, unsigned long long timeout)
+static int idetape_wait_ready (ide_drive_t *drive, unsigned long timeout)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_pc_t pc;
-
+	int load_attempted = 0;
 	/*
 	 * Wait for the tape to become ready
 	 */
+	set_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);
 	timeout += jiffies;
 	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
-		if (!__idetape_queue_pc_tail(drive, &pc))
+		if (!__idetape_queue_pc_tail(drive, &pc)) {
 			return 0;
-		if (tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2) {
-			idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
-			__idetape_queue_pc_tail(drive, &pc);
-			idetape_create_test_unit_ready_cmd(&pc);
-			if (!__idetape_queue_pc_tail(drive, &pc))
-				return 0;
 		}
-		if (!(tape->sense_key == 2 && tape->asc == 4 &&
-		    (tape->ascq == 1 || tape->ascq == 8)))
-			break;
+		if ((tape->sense_key == 2 && tape->asc == 4 && tape->ascq == 2)
+	       	    || (tape->asc == 0x3A)) {  /* no media... */
+			if (!load_attempted) {
+				idetape_create_load_unload_cmd(drive, &pc, IDETAPE_LU_LOAD_MASK);
+				__idetape_queue_pc_tail(drive, &pc);
+				load_attempted = 1;
+			} else return -ENOMEDIUM;
+		} else if (!(tape->sense_key == 2 && tape->asc == 4 &&
+		          (tape->ascq == 1 || tape->ascq == 8)))  /* not about to be ready... */
+			return -EIO;
 		current->state = TASK_INTERRUPTIBLE;
   		schedule_timeout(HZ / 10);
 	}
@@ -3536,6 +3561,8 @@
 
 	if (tape->chrdev_direction != idetape_direction_read)
 		return 0;
+
+	/* Remove merge_stage */
 	cnt = tape->merge_stage_size / tape->tape_block_size;
 	if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))
 		++cnt;		/* Filemarks count as 1 sector */
@@ -3544,12 +3571,14 @@
 		__idetape_kfree_stage(tape->merge_stage);
 		tape->merge_stage = NULL;
 	}
+
+	/* Clear pipeline flags */
 	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 	tape->chrdev_direction = idetape_direction_none;
 	
+	/* Remove pipeline stages */
 	if (tape->first_stage == NULL)
 		return 0;
-
 	spin_lock_irqsave(&tape->spinlock, flags);
 	tape->next_stage = NULL;
 	if (idetape_pipeline_active(tape))
@@ -4183,13 +4212,17 @@
 		 *	Issue a read 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if dsc_overlap isn't supported
+		 *	(some drives will return an error).
 		 */
-		bytes_read = idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, 0, tape->merge_stage->bh);
-		if (bytes_read < 0) {
-			__idetape_kfree_stage(tape->merge_stage);
-			tape->merge_stage = NULL;
-			tape->chrdev_direction = idetape_direction_none;
-			return bytes_read;
+		if (drive->dsc_overlap) {
+			bytes_read = idetape_queue_rw_tail(drive, IDETAPE_READ_RQ, 0, tape->merge_stage->bh);
+			if (bytes_read < 0) {
+				__idetape_kfree_stage(tape->merge_stage);
+				tape->merge_stage = NULL;
+				tape->chrdev_direction = idetape_direction_none;
+				return bytes_read;
+			}
 		}
 	}
 	if (tape->restart_speed_control_req)
@@ -5083,6 +5116,11 @@
 		return -ENXIO;
 	}
 
+	if (tape->drv_write_prot) {
+		/* The drive is write protected. */
+		return -EACCES;
+	}
+
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
 		printk (KERN_INFO "ide-tape: Reached idetape_chrdev_write, count %Zd\n", count);
@@ -5157,13 +5195,17 @@
 		 *	Issue a write 0 command to ensure that DSC handshake
 		 *	is switched from completion mode to buffer available
 		 *	mode.
+		 *	No point in issuing this if dsc_overlap isn't supported
+		 *	(some drives will return an error).
 		 */
-		retval = idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 0, tape->merge_stage->bh);
-		if (retval < 0) {
-			__idetape_kfree_stage(tape->merge_stage);
-			tape->merge_stage = NULL;
-			tape->chrdev_direction = idetape_direction_none;
-			return retval;
+		if (drive->dsc_overlap) {
+			retval = idetape_queue_rw_tail(drive, IDETAPE_WRITE_RQ, 0, tape->merge_stage->bh);
+			if (retval < 0) {
+				__idetape_kfree_stage(tape->merge_stage);
+				tape->merge_stage = NULL;
+				tape->chrdev_direction = idetape_direction_none;
+				return retval;
+			}
 		}
 #if ONSTREAM_DEBUG
 		if (tape->debug_level >= 2)
@@ -5318,7 +5360,7 @@
  *	Note:
  *
  *		MTBSF and MTBSFM are not supported when the tape doesn't
- *		supports spacing over filemarks in the reverse direction.
+ *		support spacing over filemarks in the reverse direction.
  *		In this case, MTFSFM is also usually not supported (it is
  *		supported in the rare case in which we crossed the filemark
  *		during our read-ahead pipelined operation mode).
@@ -5388,6 +5430,8 @@
 	}
 	switch (mt_op) {
 		case MTWEOF:
+			if (tape->drv_write_prot)
+				return -EACCES;
 			idetape_discard_read_pipeline(drive, 1);
 			for (i = 0; i < mt_count; i++) {
 				retval = idetape_write_filemark(drive);
@@ -5408,8 +5452,16 @@
 		case MTUNLOAD:
 		case MTOFFL:
 			idetape_discard_read_pipeline(drive, 0);
+			/* if door is locked, attempt to unlock  */
+			/* before attempting to eject            */
+			if (tape->door_locked) 
+				if (idetape_create_prevent_cmd(drive, &pc, 0)) 
+					if (!idetape_queue_pc_tail(drive, &pc))
+						tape->door_locked = DOOR_UNLOCKED;
 			idetape_create_load_unload_cmd(drive, &pc,!IDETAPE_LU_LOAD_MASK);
-			return (idetape_queue_pc_tail(drive, &pc));
+			if (!(retval= idetape_queue_pc_tail(drive, &pc)))
+				clear_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags);
+			return retval;
 		case MTNOP:
 			idetape_discard_read_pipeline(drive, 0);
 			return (idetape_flush_tape_buffers(drive));
@@ -5577,12 +5629,15 @@
 					mtget.mt_blkno = tape->logical_blk_num;
 			}
 			mtget.mt_dsreg = ((tape->tape_block_size * tape->user_bs_factor) << MT_ST_BLKSIZE_SHIFT) & MT_ST_BLKSIZE_MASK;
+			mtget.mt_gstat = 0;
 			if (tape->onstream) {
 				mtget.mt_gstat |= GMT_ONLINE(0xffffffff);
 				if (tape->first_stage && tape->first_stage->aux->frame_type == OS_FRAME_TYPE_EOD)
 					mtget.mt_gstat |= GMT_EOD(0xffffffff);
 				if (position <= OS_DATA_STARTFRAME1)
 					mtget.mt_gstat |= GMT_BOT(0xffffffff);
+			} else {
+				if (tape->drv_write_prot) mtget.mt_gstat |= GMT_WR_PROT(0xffffffff);
 			}
 			if (copy_to_user ((char *) arg,(char *) &mtget, sizeof (struct mtget)))
 				return -EFAULT;
@@ -5703,6 +5758,8 @@
 	return 1;
 }
 
+static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive);
+
 /*
  *	Our character device open function.
  */
@@ -5712,6 +5769,7 @@
 	idetape_tape_t *tape;
 	idetape_pc_t pc;
 	unsigned int minor = MINOR(inode->i_rdev);
+	int retval;
 			
 #if IDETAPE_DEBUG_LOG
 	printk (KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
@@ -5724,11 +5782,9 @@
 	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags))
 		return -EBUSY;
 	MOD_INC_USE_COUNT;
-	if (!tape->onstream) {	
-		idetape_read_position(drive);
-		if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
-			(void) idetape_rewind_tape(drive);
-	} else {
+
+	/* Initialize some onstream stuff */
+	if (tape->onstream) {	
 		if (minor & 64) {
 			tape->tape_block_size = tape->stage_size = 32768 + 512;
 			tape->raw = 1;
@@ -5738,18 +5794,42 @@
 		}
                 idetape_onstream_mode_sense_tape_parameter_page(drive, tape->debug_level);
 	}
-	if (idetape_wait_ready(drive, 60 * HZ)) {
+
+	/* See if the drive is ready to go */
+	if ((retval = idetape_wait_ready(drive, 60 * HZ))) {
 		clear_bit(IDETAPE_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
 		MOD_DEC_USE_COUNT;
-		return -EBUSY;
+		return retval;
 	}
-	if (tape->onstream)
-		idetape_read_position(drive);
-	MOD_DEC_USE_COUNT;
+
+	/* Read the tape position */
+	idetape_read_position(drive);
+	if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
+		(void) idetape_rewind_tape(drive);
+
+	MOD_DEC_USE_COUNT; 
+
 	if (tape->chrdev_direction != idetape_direction_read)
 		clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
 
+	/* Read block size and write protect status from drive */
+	idetape_get_blocksize_from_block_descriptor(drive);
+
+	/* Make sure drive isn't write protected if user wants to write */
+	if (tape->drv_write_prot)
+		if ( (filp->f_flags & O_ACCMODE)==O_WRONLY ||
+	             (filp->f_flags & O_ACCMODE)==O_RDWR) {
+			clear_bit(IDETAPE_BUSY, &tape->flags);
+			return -EROFS;
+	}
+
+	/* Set write protect flag if device is opened as read-only */
+	if ( (filp->f_flags & O_ACCMODE)==O_RDONLY)
+		tape->drv_write_prot == 1;		
+
+	/* Lock the tape drive door so user can't eject */
+	/* (and analyze headers for Onstream drives)    */
 	if (tape->chrdev_direction == idetape_direction_none) {
 		MOD_INC_USE_COUNT;
 		if (idetape_create_prevent_cmd(drive, &pc, 1)) {
@@ -5818,7 +5898,7 @@
 		__idetape_kfree_stage(tape->cache_stage);
 		tape->cache_stage = NULL;
 	}
-	if (minor < 128)
+	if ((minor < 128) && (test_bit(IDETAPE_MEDIUM_PRESENT,&tape->flags)))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_direction == idetape_direction_none) {
 		if (tape->door_locked == DOOR_LOCKED) {
@@ -6239,6 +6319,8 @@
 	header = (idetape_mode_parameter_header_t *) pc.buffer;
 	block_descrp = (idetape_parameter_block_descriptor_t *) (pc.buffer + sizeof(idetape_mode_parameter_header_t));
 	tape->tape_block_size =( block_descrp->length[0]<<16) + (block_descrp->length[1]<<8) + block_descrp->length[2];
+	tape->drv_write_prot = (header->dsp & 0x80) >> 7;
+	
 #if IDETAPE_DEBUG_INFO
 	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
 #endif /* IDETAPE_DEBUG_INFO */
@@ -6307,6 +6389,9 @@
 	if (strstr(drive->id->model, "OnStream DI-"))
 		tape->onstream = 1;
 	drive->dsc_overlap = (HWIF(drive)->no_dsc) ? 0 : 1;
+	/* Seagate Travan drives do not support DSC overlap */
+	if (strstr(drive->id->model, "Seagate STT3401"))
+		drive->dsc_overlap = 0;
 	if (HWIF(drive)->no_dsc) {
 		printk(KERN_INFO "ide-tape: %s: disabling DSC overlap\n",
 			tape->name);



____________________________________________________________
Enter for a chance to win one year's supply of allergy relief!
http://ad.doubleclick.net/clk;6413623;3807821;f?http://mocda3.com/1/c/563632/125699/307982/307982
This offer applies to U.S. Residents Only
