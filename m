From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/2] ide-tape: remove atomic test/set macros for packet
	commands
Date: Sat, 9 Feb 2008 20:43:45 +0100
Message-ID: <20080209194345.GF23177@gollum.tnic>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <200802050220.22637.bzolnier@gmail.com> <20080206052343.GA14349@gollum.tnic> <200802091725.23372.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:48130 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbYBIToL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 14:44:11 -0500
Received: by py-out-1112.google.com with SMTP id u52so6029465pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 11:44:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802091725.23372.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

=46rom 92dd5c1cfb27c0945894a3a055098290047d1ff0 Mon Sep 17 00:00:00 200=
1
=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Sat, 9 Feb 2008 20:33:48 +0100
Subject: [PATCH 2/2] ide-tape: remove atomic test/set macros for packet=
 commands

Removing the atomic tests for pc's is unobjectionable. Since this drive=
r will
probably go to /dev/null soon, the atomic tests for tape->flags are lef=
t in
place for there are some situations where they're needed (chrdev DSC ha=
ndling,
low level pipeline operation and so on). While at it, rename all test/s=
et flag
bit defines explicitly to *_FLAG_* for clarity.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |  208 +++++++++++++++++++++++++---------------=
--------
 1 files changed, 109 insertions(+), 99 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1fff560..09ff9b0 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -209,44 +209,47 @@ typedef struct idetape_packet_command_s {
 	unsigned long flags;
 } idetape_pc_t;
=20
-/*
- *	Packet command flag bits.
- */
-/* Set when an error is considered normal - We won't retry */
-#define	PC_ABORT			0
-/* 1 When polling for DSC on a media access command */
-#define PC_WAIT_FOR_DSC			1
-/* 1 when we prefer to use DMA if possible */
-#define PC_DMA_RECOMMENDED		2
-/* 1 while DMA in progress */
-#define	PC_DMA_IN_PROGRESS		3
-/* 1 when encountered problem during DMA */
-#define	PC_DMA_ERROR			4
-/* Data direction */
-#define	PC_WRITING			5
+/* Packet command flag bits. */
+enum {
+	/* Set when an error is considered normal - We won't retry */
+	PC_FLAG_ABORT		=3D (1 << 0),
+	/* 1 When polling for DSC on a media access command */
+	PC_FLAG_WAIT_FOR_DSC	=3D (1 << 1),
+	/* 1 when we prefer to use DMA if possible */
+	PC_FLAG_DMA_RECOMMENDED	=3D (1 << 2),
+	/* 1 while DMA in progress */
+	PC_FLAG_DMA_IN_PROGRESS	=3D (1 << 3),
+	/* 1 when encountered problem during DMA */
+	PC_FLAG_DMA_ERROR		=3D (1 << 4),
+	/* Data direction */
+	PC_FLAG_WRITING		=3D (1 <<	5),
+};
=20
 /* Tape door status */
 #define DOOR_UNLOCKED			0
 #define DOOR_LOCKED			1
 #define DOOR_EXPLICITLY_LOCKED		2
=20
-/*
- *	Tape flag bits values.
- */
-#define IDETAPE_IGNORE_DSC		0
-/* 0 When the tape position is unknown */
-#define IDETAPE_ADDRESS_VALID		1
-#define IDETAPE_BUSY			2	/* Device already opened */
-/* Error detected in a pipeline stage */
-#define IDETAPE_PIPELINE_ERROR		3
-/* Attempt to auto-detect the current user block size */
-#define IDETAPE_DETECT_BS		4
-#define IDETAPE_FILEMARK		5	/* Currently on a filemark */
-#define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
-#define IDETAPE_READ_ERROR		7
-#define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
-/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
-#define IDETAPE_MEDIUM_PRESENT		9
+/* Tape flag bits values. */
+enum {
+	IDETAPE_FLAG_IGNORE_DSC		=3D (1 << 0),
+	/* 0 When the tape position is unknown */
+	IDETAPE_FLAG_ADDRESS_VALID	=3D (1 <<	1),
+	/* Device already opened */
+	IDETAPE_FLAG_BUSY			=3D (1 << 2),
+	/* Error detected in a pipeline stage */
+	IDETAPE_FLAG_PIPELINE_ERR	=3D (1 <<	3),
+	/* Attempt to auto-detect the current user block size */
+	IDETAPE_FLAG_DETECT_BS		=3D (1 << 4),
+	/* Currently on a filemark */
+	IDETAPE_FLAG_FILEMARK		=3D (1 << 5),
+	/* DRQ interrupt device */
+	IDETAPE_FLAG_DRQ_INTERRUPT	=3D (1 << 6),
+	/* pipeline active */
+	IDETAPE_FLAG_PIPELINE_ACTIVE	=3D (1 << 7),
+	/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
+	IDETAPE_FLAG_MEDIUM_PRESENT	=3D (1 << 8),
+};
=20
 /* Some defines for the SPACE command */
 #define IDETAPE_SPACE_OVER_FILEMARK	1
@@ -584,7 +587,7 @@ static void idetape_update_buffers(idetape_pc_t *pc=
)
 	int count;
 	unsigned int bcount =3D pc->actually_transferred;
=20
-	if (test_bit(PC_WRITING, &pc->flags))
+	if (pc->flags & PC_FLAG_WRITING)
 		return;
 	while (bcount) {
 		if (bh =3D=3D NULL) {
@@ -671,7 +674,7 @@ static void idetape_analyze_error(ide_drive_t *driv=
e, u8 *sense)
 		 pc->c[0], tape->sense_key, tape->asc, tape->ascq);
=20
 	/* Correct pc->actually_transferred by asking the tape.	 */
-	if (test_bit(PC_DMA_ERROR, &pc->flags)) {
+	if (pc->flags & PC_FLAG_DMA_ERROR) {
 		pc->actually_transferred =3D pc->request_transfer -
 			tape->blk_size *
 			be32_to_cpu(get_unaligned((u32 *)&sense[3]));
@@ -690,26 +693,26 @@ static void idetape_analyze_error(ide_drive_t *dr=
ive, u8 *sense)
 			/* don't report an error, everything's ok */
 			pc->error =3D 0;
 			/* don't retry read/write */
-			set_bit(PC_ABORT, &pc->flags);
+			pc->flags |=3D PC_FLAG_ABORT;
 		}
 	}
 	if (pc->c[0] =3D=3D READ_6 && (sense[2] & 0x80)) {
 		pc->error =3D IDETAPE_ERROR_FILEMARK;
-		set_bit(PC_ABORT, &pc->flags);
+		pc->flags |=3D PC_FLAG_ABORT;
 	}
 	if (pc->c[0] =3D=3D WRITE_6) {
 		if ((sense[2] & 0x40) || (tape->sense_key =3D=3D 0xd
 		     && tape->asc =3D=3D 0x0 && tape->ascq =3D=3D 0x2)) {
 			pc->error =3D IDETAPE_ERROR_EOD;
-			set_bit(PC_ABORT, &pc->flags);
+			pc->flags |=3D PC_FLAG_ABORT;
 		}
 	}
 	if (pc->c[0] =3D=3D READ_6 || pc->c[0] =3D=3D WRITE_6) {
 		if (tape->sense_key =3D=3D 8) {
 			pc->error =3D IDETAPE_ERROR_EOD;
-			set_bit(PC_ABORT, &pc->flags);
+			pc->flags |=3D PC_FLAG_ABORT;
 		}
-		if (!test_bit(PC_ABORT, &pc->flags) &&
+		if (!(pc->flags & PC_FLAG_ABORT) &&
 		    pc->actually_transferred)
 			pc->retries =3D IDETAPE_MAX_PC_RETRIES + 1;
 	}
@@ -865,14 +868,16 @@ static int idetape_end_request(ide_drive_t *drive=
, int uptodate, int nr_sects)
 		if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 			remove_stage =3D 1;
 			if (error) {
-				set_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
+				set_bit(IDETAPE_FLAG_PIPELINE_ERR,
+					&tape->flags);
 				if (error =3D=3D IDETAPE_ERROR_EOD)
 					idetape_abort_pipeline(drive,
 								active_stage);
 			}
 		} else if (rq->cmd[0] & REQ_IDETAPE_READ) {
 			if (error =3D=3D IDETAPE_ERROR_EOD) {
-				set_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
+				set_bit(IDETAPE_FLAG_PIPELINE_ERR,
+					&tape->flags);
 				idetape_abort_pipeline(drive, active_stage);
 			}
 		}
@@ -905,7 +910,7 @@ static int idetape_end_request(ide_drive_t *drive, =
int uptodate, int nr_sects)
 	if (remove_stage)
 		idetape_remove_stage_head(drive);
 	if (tape->active_data_rq =3D=3D NULL)
-		clear_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
+		clear_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
 	spin_unlock_irqrestore(&tape->lock, flags);
 	return 0;
 }
@@ -984,7 +989,7 @@ static ide_startstop_t idetape_retry_pc (ide_drive_=
t *drive)
 	pc =3D idetape_next_pc_storage(drive);
 	rq =3D idetape_next_rq_storage(drive);
 	idetape_create_request_sense_cmd(pc);
-	set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
+	set_bit(IDETAPE_FLAG_IGNORE_DSC, &tape->flags);
 	idetape_queue_pc_head(drive, pc, rq);
 	return ide_stopped;
 }
@@ -1031,7 +1036,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 	/* Clear the interrupt */
 	stat =3D ide_read_status(drive);
=20
-	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
+	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
 		if (hwif->ide_dma_end(drive) || (stat & ERR_STAT)) {
 			/*
 			 * A DMA error is sometimes expected. For example,
@@ -1054,7 +1059,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 			 * data transfer will occur, but no DMA error.
 			 * (AS, 19 Apr 2001)
 			 */
-			set_bit(PC_DMA_ERROR, &pc->flags);
+			pc->flags |=3D PC_FLAG_DMA_ERROR;
 		} else {
 			pc->actually_transferred =3D pc->request_transfer;
 			idetape_update_buffers(pc);
@@ -1068,7 +1073,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 		debug_log(DBG_SENSE, "Packet command completed, %d bytes"
 				" transferred\n", pc->actually_transferred);
=20
-		clear_bit(PC_DMA_IN_PROGRESS, &pc->flags);
+		pc->flags &=3D ~PC_FLAG_DMA_IN_PROGRESS;
 		local_irq_enable();
=20
 #if SIMULATE_ERRORS
@@ -1081,7 +1086,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 #endif
 		if ((stat & ERR_STAT) && pc->c[0] =3D=3D REQUEST_SENSE)
 			stat &=3D ~ERR_STAT;
-		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
+		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR)) {
 			/* Error detected */
 			debug_log(DBG_ERR, "%s: I/O error\n", tape->name);
=20
@@ -1097,7 +1102,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 			return idetape_retry_pc(drive);
 		}
 		pc->error =3D 0;
-		if (test_bit(PC_WAIT_FOR_DSC, &pc->flags) &&
+		if ((pc->flags & PC_FLAG_WAIT_FOR_DSC) &&
 		    (stat & SEEK_STAT) =3D=3D 0) {
 			/* Media access command */
 			tape->dsc_polling_start =3D jiffies;
@@ -1112,7 +1117,9 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 		/* Command finished - Call the callback function */
 		return pc->callback(drive);
 	}
-	if (test_and_clear_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
+
+	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
+		pc->flags &=3D ~PC_FLAG_DMA_IN_PROGRESS;
 		printk(KERN_ERR "ide-tape: The tape wants to issue more "
 				"interrupts in DMA mode\n");
 		printk(KERN_ERR "ide-tape: DMA disabled, reverting to PIO\n");
@@ -1129,7 +1136,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 		printk(KERN_ERR "ide-tape: CoD !=3D 0 in %s\n", __func__);
 		return ide_do_reset(drive);
 	}
-	if (((ireason & IO) =3D=3D IO) =3D=3D test_bit(PC_WRITING, &pc->flags=
)) {
+	if (((ireason & IO) =3D=3D IO) =3D=3D !!(pc->flags & PC_FLAG_WRITING)=
) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "ide-tape: We wanted to %s, ",
 				(ireason & IO) ? "Write" : "Read");
@@ -1137,7 +1144,7 @@ static ide_startstop_t idetape_pc_intr(ide_drive_=
t *drive)
 				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
-	if (!test_bit(PC_WRITING, &pc->flags)) {
+	if (!(pc->flags & PC_FLAG_WRITING)) {
 		/* Reading - Check that we have enough space */
 		temp =3D pc->actually_transferred + bcount;
 		if (temp > pc->request_transfer) {
@@ -1249,7 +1256,7 @@ static ide_startstop_t idetape_transfer_pc(ide_dr=
ive_t *drive)
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	/* Begin DMA, if necessary */
-	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags))
+	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS)
 		hwif->dma_start(drive);
 #endif
 	/* Send the actual packet */
@@ -1276,13 +1283,13 @@ static ide_startstop_t idetape_issue_pc(ide_dri=
ve_t *drive, idetape_pc_t *pc)
 	tape->pc =3D pc;
=20
 	if (pc->retries > IDETAPE_MAX_PC_RETRIES ||
-	    test_bit(PC_ABORT, &pc->flags)) {
+		(pc->flags & PC_FLAG_ABORT)) {
 		/*
 		 * We will "abort" retrying a packet command in case legitimate
 		 * error code was received (crossing a filemark, or end of the
 		 * media, for example).
 		 */
-		if (!test_bit(PC_ABORT, &pc->flags)) {
+		if (!(pc->flags & PC_FLAG_ABORT)) {
 			if (!(pc->c[0] =3D=3D TEST_UNIT_READY &&
 			      tape->sense_key =3D=3D 2 && tape->asc =3D=3D 4 &&
 			     (tape->ascq =3D=3D 1 || tape->ascq =3D=3D 8))) {
@@ -1308,20 +1315,22 @@ static ide_startstop_t idetape_issue_pc(ide_dri=
ve_t *drive, idetape_pc_t *pc)
 	/* Request to transfer the entire buffer at once */
 	bcount =3D pc->request_transfer;
=20
-	if (test_and_clear_bit(PC_DMA_ERROR, &pc->flags)) {
+	if (pc->flags & PC_FLAG_DMA_ERROR) {
+		pc->flags &=3D ~PC_FLAG_DMA_ERROR;
 		printk(KERN_WARNING "ide-tape: DMA disabled, "
 				"reverting to PIO\n");
 		ide_dma_off(drive);
 	}
-	if (test_bit(PC_DMA_RECOMMENDED, &pc->flags) && drive->using_dma)
+	if ((pc->flags & PC_FLAG_DMA_RECOMMENDED) && drive->using_dma)
 		dma_ok =3D !hwif->dma_setup(drive);
=20
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
 			   IDE_TFLAG_OUT_DEVICE, bcount, dma_ok);
=20
-	if (dma_ok)			/* Will begin DMA later */
-		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
-	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
+	if (dma_ok)
+		/* Will begin DMA later */
+		pc->flags |=3D PC_FLAG_DMA_IN_PROGRESS;
+	if (test_bit(IDETAPE_FLAG_DRQ_INTERRUPT, &tape->flags)) {
 		ide_execute_command(drive, WIN_PACKETCMD, &idetape_transfer_pc,
 				    IDETAPE_WAIT_CMD, NULL);
 		return ide_started;
@@ -1509,7 +1518,7 @@ static void idetape_create_read_cmd(idetape_tape_=
t *tape, idetape_pc_t *pc,
 	pc->buffer_size =3D length * tape->blk_size;
 	pc->request_transfer =3D pc->buffer_size;
 	if (pc->request_transfer =3D=3D tape->stage_size)
-		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
+		pc->flags |=3D PC_FLAG_DMA_RECOMMENDED;
 }
=20
 static void idetape_create_write_cmd(idetape_tape_t *tape, idetape_pc_=
t *pc,
@@ -1520,7 +1529,7 @@ static void idetape_create_write_cmd(idetape_tape=
_t *tape, idetape_pc_t *pc,
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] =3D 1;
 	pc->callback =3D &idetape_rw_callback;
-	set_bit(PC_WRITING, &pc->flags);
+	pc->flags |=3D PC_FLAG_WRITING;
 	pc->bh =3D bh;
 	pc->b_data =3D bh->b_data;
 	pc->b_count =3D atomic_read(&bh->b_count);
@@ -1528,7 +1537,7 @@ static void idetape_create_write_cmd(idetape_tape=
_t *tape, idetape_pc_t *pc,
 	pc->buffer_size =3D length * tape->blk_size;
 	pc->request_transfer =3D pc->buffer_size;
 	if (pc->request_transfer =3D=3D tape->stage_size)
-		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
+		pc->flags |=3D PC_FLAG_DMA_RECOMMENDED;
 }
=20
 static ide_startstop_t idetape_do_request(ide_drive_t *drive,
@@ -1572,10 +1581,10 @@ static ide_startstop_t idetape_do_request(ide_d=
rive_t *drive,
 	stat =3D ide_read_status(drive);
=20
 	if (!drive->dsc_overlap && !(rq->cmd[0] & REQ_IDETAPE_PC2))
-		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
+		set_bit(IDETAPE_FLAG_IGNORE_DSC, &tape->flags);
=20
 	if (drive->post_reset =3D=3D 1) {
-		set_bit(IDETAPE_IGNORE_DSC, &tape->flags);
+		set_bit(IDETAPE_FLAG_IGNORE_DSC, &tape->flags);
 		drive->post_reset =3D 0;
 	}
=20
@@ -1583,7 +1592,7 @@ static ide_startstop_t idetape_do_request(ide_dri=
ve_t *drive,
 		tape->insert_speed =3D tape->insert_size / 1024 * HZ /
 					(jiffies - tape->insert_time);
 	idetape_calculate_speeds(drive);
-	if (!test_and_clear_bit(IDETAPE_IGNORE_DSC, &tape->flags) &&
+	if (!test_and_clear_bit(IDETAPE_FLAG_IGNORE_DSC, &tape->flags) &&
 	    (stat & SEEK_STAT) =3D=3D 0) {
 		if (postponed_rq =3D=3D NULL) {
 			tape->dsc_polling_start =3D jiffies;
@@ -1641,7 +1650,7 @@ static inline int idetape_pipeline_active(idetape=
_tape_t *tape)
 {
 	int rc1, rc2;
=20
-	rc1 =3D test_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
+	rc1 =3D test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
 	rc2 =3D (tape->active_data_rq !=3D NULL);
 	return rc1;
 }
@@ -1887,7 +1896,7 @@ static ide_startstop_t idetape_read_position_call=
back(ide_drive_t *drive)
 		if (readpos[0] & 0x4) {
 			printk(KERN_INFO "ide-tape: Block location is unknown"
 					 "to the tape\n");
-			clear_bit(IDETAPE_ADDRESS_VALID, &tape->flags);
+			clear_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
 			idetape_end_request(drive, 0, 0);
 		} else {
 			debug_log(DBG_SENSE, "Block Location - %u\n",
@@ -1896,7 +1905,7 @@ static ide_startstop_t idetape_read_position_call=
back(ide_drive_t *drive)
 			tape->partition =3D readpos[1];
 			tape->first_frame =3D
 				be32_to_cpu(*(u32 *)&readpos[4]);
-			set_bit(IDETAPE_ADDRESS_VALID, &tape->flags);
+			set_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
 			idetape_end_request(drive, 1, 0);
 		}
 	} else {
@@ -1915,7 +1924,7 @@ static void idetape_create_write_filemark_cmd(ide=
_drive_t *drive,
 	idetape_init_pc(pc);
 	pc->c[0] =3D WRITE_FILEMARKS;
 	pc->c[4] =3D write_filemark;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -1956,7 +1965,7 @@ static void idetape_create_load_unload_cmd(ide_dr=
ive_t *drive, idetape_pc_t *pc,
 	idetape_init_pc(pc);
 	pc->c[0] =3D START_STOP;
 	pc->c[4] =3D cmd;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -1967,7 +1976,7 @@ static int idetape_wait_ready(ide_drive_t *drive,=
 unsigned long timeout)
 	int load_attempted =3D 0;
=20
 	/* Wait for the tape to become ready */
-	set_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags);
+	set_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags);
 	timeout +=3D jiffies;
 	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
@@ -2040,7 +2049,7 @@ static void idetape_create_locate_cmd(ide_drive_t=
 *drive, idetape_pc_t *pc,
 	pc->c[1] =3D 2;
 	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[3]);
 	pc->c[8] =3D partition;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -2071,7 +2080,7 @@ static int __idetape_discard_read_pipeline(ide_dr=
ive_t *drive)
=20
 	/* Remove merge stage. */
 	cnt =3D tape->merge_stage_size / tape->blk_size;
-	if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))
+	if (test_and_clear_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
 		++cnt;		/* Filemarks count as 1 sector */
 	tape->merge_stage_size =3D 0;
 	if (tape->merge_stage !=3D NULL) {
@@ -2080,7 +2089,7 @@ static int __idetape_discard_read_pipeline(ide_dr=
ive_t *drive)
 	}
=20
 	/* Clear pipeline flags. */
-	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
+	clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
 	tape->chrdev_dir =3D IDETAPE_DIR_NONE;
=20
 	/* Remove pipeline stages. */
@@ -2194,7 +2203,7 @@ static void idetape_plug_pipeline(ide_drive_t *dr=
ive)
 	if (tape->next_stage =3D=3D NULL)
 		return;
 	if (!idetape_pipeline_active(tape)) {
-		set_bit(IDETAPE_PIPELINE_ACTIVE, &tape->flags);
+		set_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags);
 		idetape_activate_next_stage(drive);
 		(void) ide_do_drive_cmd(drive, tape->active_data_rq, ide_end);
 	}
@@ -2213,7 +2222,7 @@ static void idetape_create_rewind_cmd(ide_drive_t=
 *drive, idetape_pc_t *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] =3D REZERO_UNIT;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -2222,7 +2231,7 @@ static void idetape_create_erase_cmd(idetape_pc_t=
 *pc)
 	idetape_init_pc(pc);
 	pc->c[0] =3D ERASE;
 	pc->c[1] =3D 1;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -2232,7 +2241,7 @@ static void idetape_create_space_cmd(idetape_pc_t=
 *pc, int count, u8 cmd)
 	pc->c[0] =3D SPACE;
 	put_unaligned(cpu_to_be32(count), (unsigned int *) &pc->c[1]);
 	pc->c[1] =3D cmd;
-	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
+	pc->flags |=3D PC_FLAG_WAIT_FOR_DSC;
 	pc->callback =3D &idetape_pc_callback;
 }
=20
@@ -2319,7 +2328,7 @@ static int idetape_add_chrdev_write_request(ide_d=
rive_t *drive, int blocks)
 			idetape_plug_pipeline(drive);
 		}
 	}
-	if (test_and_clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
+	if (test_and_clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
 		/* Return a deferred error */
 		return -EIO;
 	return blocks;
@@ -2395,7 +2404,7 @@ static void idetape_empty_write_pipeline(ide_driv=
e_t *drive)
 		__idetape_kfree_stage(tape->merge_stage);
 		tape->merge_stage =3D NULL;
 	}
-	clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
+	clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
 	tape->chrdev_dir =3D IDETAPE_DIR_NONE;
=20
 	/*
@@ -2483,7 +2492,7 @@ static int idetape_init_read(ide_drive_t *drive, =
int max_stages)
 	rq.sector =3D tape->first_frame;
 	rq.nr_sectors =3D blocks;
 	rq.current_nr_sectors =3D blocks;
-	if (!test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags) &&
+	if (!test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags) &&
 	    tape->nr_stages < max_stages) {
 		new_stage =3D idetape_kmalloc_stage(tape);
 		while (new_stage !=3D NULL) {
@@ -2520,13 +2529,13 @@ static int idetape_add_chrdev_read_request(ide_=
drive_t *drive, int blocks)
 	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
=20
 	/* If we are at a filemark, return a read length of 0 */
-	if (test_bit(IDETAPE_FILEMARK, &tape->flags))
+	if (test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
 		return 0;
=20
 	/* Wait for the next block to reach the head of the pipeline. */
 	idetape_init_read(drive, tape->max_stages);
 	if (tape->first_stage =3D=3D NULL) {
-		if (test_bit(IDETAPE_PIPELINE_ERROR, &tape->flags))
+		if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
 			return 0;
 		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
 					tape->merge_stage->bh);
@@ -2543,7 +2552,7 @@ static int idetape_add_chrdev_read_request(ide_dr=
ive_t *drive, int blocks)
 	else {
 		idetape_switch_buffers(tape, tape->first_stage);
 		if (rq_ptr->errors =3D=3D IDETAPE_ERROR_FILEMARK)
-			set_bit(IDETAPE_FILEMARK, &tape->flags);
+			set_bit(IDETAPE_FLAG_FILEMARK, &tape->flags);
 		spin_lock_irqsave(&tape->lock, flags);
 		idetape_remove_stage_head(drive);
 		spin_unlock_irqrestore(&tape->lock, flags);
@@ -2690,12 +2699,13 @@ static int idetape_space_over_filemarks(ide_dri=
ve_t *drive, short mt_op,
 	if (tape->chrdev_dir =3D=3D IDETAPE_DIR_READ) {
 		/* its a read-ahead buffer, scan it for crossed filemarks. */
 		tape->merge_stage_size =3D 0;
-		if (test_and_clear_bit(IDETAPE_FILEMARK, &tape->flags))
+		if (test_and_clear_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
 			++count;
 		while (tape->first_stage !=3D NULL) {
 			if (count =3D=3D mt_count) {
 				if (mt_op =3D=3D MTFSFM)
-					set_bit(IDETAPE_FILEMARK, &tape->flags);
+					set_bit(IDETAPE_FLAG_FILEMARK,
+						&tape->flags);
 				return 0;
 			}
 			spin_lock_irqsave(&tape->lock, flags);
@@ -2779,7 +2789,7 @@ static ssize_t idetape_chrdev_read(struct file *f=
ile, char __user *buf,
 	debug_log(DBG_CHRDEV, "Enter %s, count %Zd\n", __func__, count);
=20
 	if (tape->chrdev_dir !=3D IDETAPE_DIR_READ) {
-		if (test_bit(IDETAPE_DETECT_BS, &tape->flags))
+		if (test_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags))
 			if (count > tape->blk_size &&
 			    (count % tape->blk_size) =3D=3D 0)
 				tape->user_bs_factor =3D count / tape->blk_size;
@@ -2822,7 +2832,7 @@ static ssize_t idetape_chrdev_read(struct file *f=
ile, char __user *buf,
 		tape->merge_stage_size =3D bytes_read-temp;
 	}
 finish:
-	if (!actually_read && test_bit(IDETAPE_FILEMARK, &tape->flags)) {
+	if (!actually_read && test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags)) =
{
 		debug_log(DBG_SENSE, "%s: spacing over filemark\n", tape->name);
=20
 		idetape_space_over_filemarks(drive, MTFSF, 1);
@@ -3015,7 +3025,7 @@ static int idetape_mtioctop(ide_drive_t *drive, s=
hort mt_op, int mt_count)
 					      !IDETAPE_LU_LOAD_MASK);
 		retval =3D idetape_queue_pc_tail(drive, &pc);
 		if (!retval)
-			clear_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags);
+			clear_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags);
 		return retval;
 	case MTNOP:
 		idetape_discard_read_pipeline(drive, 0);
@@ -3038,9 +3048,9 @@ static int idetape_mtioctop(ide_drive_t *drive, s=
hort mt_op, int mt_count)
 			    mt_count % tape->blk_size)
 				return -EIO;
 			tape->user_bs_factor =3D mt_count / tape->blk_size;
-			clear_bit(IDETAPE_DETECT_BS, &tape->flags);
+			clear_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags);
 		} else
-			set_bit(IDETAPE_DETECT_BS, &tape->flags);
+			set_bit(IDETAPE_FLAG_DETECT_BS, &tape->flags);
 		return 0;
 	case MTSEEK:
 		idetape_discard_read_pipeline(drive, 0);
@@ -3188,24 +3198,24 @@ static int idetape_chrdev_open(struct inode *in=
ode, struct file *filp)
=20
 	filp->private_data =3D tape;
=20
-	if (test_and_set_bit(IDETAPE_BUSY, &tape->flags)) {
+	if (test_and_set_bit(IDETAPE_FLAG_BUSY, &tape->flags)) {
 		retval =3D -EBUSY;
 		goto out_put_tape;
 	}
=20
 	retval =3D idetape_wait_ready(drive, 60 * HZ);
 	if (retval) {
-		clear_bit(IDETAPE_BUSY, &tape->flags);
+		clear_bit(IDETAPE_FLAG_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
 		goto out_put_tape;
 	}
=20
 	idetape_read_position(drive);
-	if (!test_bit(IDETAPE_ADDRESS_VALID, &tape->flags))
+	if (!test_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags))
 		(void)idetape_rewind_tape(drive);
=20
 	if (tape->chrdev_dir !=3D IDETAPE_DIR_READ)
-		clear_bit(IDETAPE_PIPELINE_ERROR, &tape->flags);
+		clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags);
=20
 	/* Read block size and write protect status from drive. */
 	ide_tape_get_bsize_from_bdesc(drive);
@@ -3220,7 +3230,7 @@ static int idetape_chrdev_open(struct inode *inod=
e, struct file *filp)
 	if (tape->write_prot) {
 		if ((filp->f_flags & O_ACCMODE) =3D=3D O_WRONLY ||
 		    (filp->f_flags & O_ACCMODE) =3D=3D O_RDWR) {
-			clear_bit(IDETAPE_BUSY, &tape->flags);
+			clear_bit(IDETAPE_FLAG_BUSY, &tape->flags);
 			retval =3D -EROFS;
 			goto out_put_tape;
 		}
@@ -3285,7 +3295,7 @@ static int idetape_chrdev_release(struct inode *i=
node, struct file *filp)
 		__idetape_kfree_stage(tape->cache_stage);
 		tape->cache_stage =3D NULL;
 	}
-	if (minor < 128 && test_bit(IDETAPE_MEDIUM_PRESENT, &tape->flags))
+	if (minor < 128 && test_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->flags=
))
 		(void) idetape_rewind_tape(drive);
 	if (tape->chrdev_dir =3D=3D IDETAPE_DIR_NONE) {
 		if (tape->door_locked =3D=3D DOOR_LOCKED) {
@@ -3295,7 +3305,7 @@ static int idetape_chrdev_release(struct inode *i=
node, struct file *filp)
 			}
 		}
 	}
-	clear_bit(IDETAPE_BUSY, &tape->flags);
+	clear_bit(IDETAPE_FLAG_BUSY, &tape->flags);
 	ide_tape_put(tape);
 	unlock_kernel();
 	return 0;
@@ -3499,7 +3509,7 @@ static void idetape_setup(ide_drive_t *drive, ide=
tape_tape_t *tape, int minor)
=20
 	/* Command packet DRQ type */
 	if (((gcw[0] & 0x60) >> 5) =3D=3D 1)
-		set_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags);
+		set_bit(IDETAPE_FLAG_DRQ_INTERRUPT, &tape->flags);
=20
 	tape->min_pipeline =3D 10;
 	tape->max_pipeline =3D 10;
--=20
1.5.3.7

--=20
Regards/Gru=DF,
    Boris.
