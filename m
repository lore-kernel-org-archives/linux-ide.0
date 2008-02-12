From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [RFC PATCH] ide-floppy: use rq->cmd for preparing and sending
	packet cmds to the drive
Date: Tue, 12 Feb 2008 15:37:15 +0100
Message-ID: <20080212143715.GB4530@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:61510 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762962AbYBLOht (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 09:37:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2801633wah.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 06:37:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

here's a first go at converting ide-floppy to using rq->cmd for packet =
commands.
The code below is pretty rough and from what i can tell needs to be ham=
mered a
lot more, for it raises a lot of issues:

1. The command control (pc->callback, request type, etc) is still done =
using the pc
pointer passed to all the functions prior to issuing the command. This,=
 imho, can be
done a lot cleaner and easier. What is the rationale here, do we want i=
de_atapi_pc
removed in the long run and get by only with rq's as is the case with i=
de-cd?

2. I end up allocating all the requests on the stack just like the resp=
ective
ide_atapi_pc structs and don't use the heap allocation facilities. I gu=
ess this will
get resolved after we've decided on allocation scheme for the rq struct=
s... In the
meantime, the stack is probably gonna blow with additional sizeof(struc=
t request).

3. idefloppy_queue_pc_{head,tail} turn into simple wrappers which begs =
for
merging them but this is trivial.

4.Made rq->cmd_type =3D REQ_TYPE_ATA_PC from REQ_TYPE_SPECIAL but i gue=
ss the
final goal is REQ_TYPE_BLOCK_PC. Will have to see how is this handled i=
n the
block layer and whether we're ready to do that.

5. This change is less intrusive but begs for a lot of simplification a=
fterwards
similar to ide-cd, which will probably get rid of all those create_.*_c=
md()
helpers.

6. Only compile-tested. Proper testing follows...

--
commit 8359f6f7122e87c30467ff73895399b82610b835
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Tue Feb 12 10:06:55 2008 +0100

    ide-floppy: use rq->cmd for preparing and sending packet cmds to th=
e drive

    ... similar to the way it is done in ide-cd.

    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index bf1ef60..ab125ad 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -297,16 +297,9 @@ static void idefloppy_update_buffers(ide_drive_t *=
drive,
  * the current request so that it will be processed immediately, on th=
e next
  * pass through the driver.
  */
-static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_ata=
pi_pc *pc,
-		struct request *rq)
+static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_ata=
pi_pc *pc)
 {
-	struct ide_floppy_obj *floppy =3D drive->driver_data;
-
-	ide_init_drive_cmd(rq);
-	rq->buffer =3D (char *) pc;
-	rq->cmd_type =3D REQ_TYPE_SPECIAL;
-	rq->rq_disk =3D floppy->disk;
-	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
+	(void)ide_do_drive_cmd(drive, pc->rq, ide_preempt);
 }
=20
 static struct ide_atapi_pc *idefloppy_next_pc_storage(ide_drive_t *dri=
ve)
@@ -344,7 +337,7 @@ static void idefloppy_request_sense_callback(ide_dr=
ive_t *drive)
 		if (floppy->failed_pc)
 			debug_log("pc =3D %x, sense key =3D %x, asc =3D %x,"
 					" ascq =3D %x\n",
-					floppy->failed_pc->c[0],
+					floppy->failed_pc->rq->cmd[0],
 					floppy->sense_key,
 					floppy->asc,
 					floppy->ascq);
@@ -375,7 +368,6 @@ static void idefloppy_pc_callback(ide_drive_t *driv=
e)
=20
 static void idefloppy_init_pc(struct ide_atapi_pc *pc)
 {
-	memset(pc->c, 0, 12);
 	pc->retries =3D 0;
 	pc->flags =3D 0;
 	pc->req_xfer =3D 0;
@@ -384,11 +376,25 @@ static void idefloppy_init_pc(struct ide_atapi_pc=
 *pc)
 	pc->idefloppy_callback =3D &idefloppy_pc_callback;
 }
=20
-static void idefloppy_create_request_sense_cmd(struct ide_atapi_pc *pc=
)
+void ide_floppy_init_rq(ide_drive_t *drive, struct request *rq)
+{
+	struct ide_floppy_obj *floppy =3D drive->driver_data;
+
+	ide_init_drive_cmd(rq);
+	rq->cmd_type =3D REQ_TYPE_ATA_PC;
+	rq->rq_disk =3D floppy->disk;
+}
+
+static void idefloppy_create_request_sense_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc)
 {
+	struct request *rq =3D pc->rq;
+
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_REQUEST_SENSE;
-	pc->c[4] =3D 255;
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_REQUEST_SENSE;
+	rq->cmd[4] =3D 255;
 	pc->req_xfer =3D 18;
 	pc->idefloppy_callback =3D &idefloppy_request_sense_callback;
 }
@@ -405,8 +411,8 @@ static void idefloppy_retry_pc(ide_drive_t *drive)
 	(void)ide_read_error(drive);
 	pc =3D idefloppy_next_pc_storage(drive);
 	rq =3D idefloppy_next_rq_storage(drive);
-	idefloppy_create_request_sense_cmd(pc);
-	idefloppy_queue_pc_head(drive, pc, rq);
+	idefloppy_create_request_sense_cmd(drive, pc);
+	idefloppy_queue_pc_head(drive, pc);
 }
=20
 /* The usual interrupt handler called during a packet command. */
@@ -452,7 +458,7 @@ static ide_startstop_t idefloppy_pc_intr (ide_drive=
_t *drive)
 			/* Error detected */
 			debug_log("%s: I/O error\n", drive->name);
 			rq->errors++;
-			if (pc->c[0] =3D=3D GPCMD_REQUEST_SENSE) {
+			if (rq->cmd[0] =3D=3D GPCMD_REQUEST_SENSE) {
 				printk(KERN_ERR "ide-floppy: I/O error in "
 					"request sense command\n");
 				return ide_do_reset(drive);
@@ -544,8 +550,9 @@ static ide_startstop_t idefloppy_pc_intr (ide_drive=
_t *drive)
 static ide_startstop_t idefloppy_transfer_pc(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
-	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
+	struct request *rq =3D floppy->pc->rq;
+	ide_startstop_t startstop;
 	u8 ireason;
=20
 	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READY)=
) {
@@ -563,7 +570,7 @@ static ide_startstop_t idefloppy_transfer_pc(ide_dr=
ive_t *drive)
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	/* Send the actual packet */
-	HWIF(drive)->atapi_output_bytes(drive, floppy->pc->c, 12);
+	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, 12);
 	return ide_started;
 }
=20
@@ -583,7 +590,7 @@ static int idefloppy_transfer_pc2(ide_drive_t *driv=
e)
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
 	/* Send the actual packet */
-	HWIF(drive)->atapi_output_bytes(drive, floppy->pc->c, 12);
+	HWIF(drive)->atapi_output_bytes(drive, floppy->pc->rq->cmd, 12);
 	/* Timeout for the packet command */
 	return IDEFLOPPY_WAIT_CMD;
 }
@@ -631,7 +638,7 @@ static void ide_floppy_report_error(idefloppy_flopp=
y_t *floppy,
=20
 	printk(KERN_ERR "ide-floppy: %s: I/O error, pc =3D %2x, key =3D %2x, =
"
 			"asc =3D %2x, ascq =3D %2x\n",
-			floppy->drive->name, pc->c[0], floppy->sense_key,
+			floppy->drive->name, pc->rq->cmd[0], floppy->sense_key,
 			floppy->asc, floppy->ascq);
=20
 }
@@ -642,11 +649,11 @@ static ide_startstop_t idefloppy_issue_pc(ide_dri=
ve_t *drive,
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	ide_hwif_t *hwif =3D drive->hwif;
 	ide_handler_t *pkt_xfer_routine;
+	struct request *rq =3D pc->rq;
 	u16 bcount;
 	u8 dma;
=20
-	if (floppy->failed_pc =3D=3D NULL &&
-	    pc->c[0] !=3D GPCMD_REQUEST_SENSE)
+	if (floppy->failed_pc =3D=3D NULL && rq->cmd[0] !=3D GPCMD_REQUEST_SE=
NSE)
 		floppy->failed_pc =3D pc;
 	/* Set the current packet command */
 	floppy->pc =3D pc;
@@ -719,30 +726,44 @@ static void idefloppy_rw_callback(ide_drive_t *dr=
ive)
 	return;
 }
=20
-static void idefloppy_create_prevent_cmd(struct ide_atapi_pc *pc, int =
prevent)
+static void idefloppy_create_prevent_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc, int prevent)
 {
+	struct request *rq =3D pc->rq;
+
 	debug_log("creating prevent removal command, prevent =3D %d\n", preve=
nt);
=20
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-	pc->c[4] =3D prevent;
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+	rq->cmd[4] =3D prevent;
 }
=20
-static void idefloppy_create_read_capacity_cmd(struct ide_atapi_pc *pc=
)
+static void idefloppy_create_read_capacity_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc)
 {
+	struct request *rq =3D pc->rq;
+
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_READ_FORMAT_CAPACITIES;
-	pc->c[7] =3D 255;
-	pc->c[8] =3D 255;
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_READ_FORMAT_CAPACITIES;
+	rq->cmd[7] =3D 255;
+	rq->cmd[8] =3D 255;
 	pc->req_xfer =3D 255;
 }
=20
-static void idefloppy_create_format_unit_cmd(struct ide_atapi_pc *pc, =
int b,
-		int l, int flags)
+static void idefloppy_create_format_unit_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc, int b,	int l, int flags)
 {
+	struct request *rq =3D pc->rq;
+
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_FORMAT_UNIT;
-	pc->c[1] =3D 0x17;
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_FORMAT_UNIT;
+	rq->cmd[1] =3D 0x17;
=20
 	memset(pc->buf, 0, 12);
 	pc->buf[1] =3D 0xA2;
@@ -759,15 +780,18 @@ static void idefloppy_create_format_unit_cmd(stru=
ct ide_atapi_pc *pc, int b,
 }
=20
 /* A mode sense command is used to "sense" floppy parameters. */
-static void idefloppy_create_mode_sense_cmd(struct ide_atapi_pc *pc,
-		u8 page_code, u8 type)
+static void idefloppy_create_mode_sense_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc, u8 page_code, u8 type)
 {
 	u16 length =3D 8; /* sizeof(Mode Parameter Header) =3D 8 Bytes */
+	struct request *rq =3D pc->rq;
=20
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_MODE_SENSE_10;
-	pc->c[1] =3D 0;
-	pc->c[2] =3D page_code + (type << 6);
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_MODE_SENSE_10;
+	rq->cmd[1] =3D 0;
+	rq->cmd[2] =3D page_code + (type << 6);
=20
 	switch (page_code) {
 	case IDEFLOPPY_CAPABILITIES_PAGE:
@@ -777,24 +801,32 @@ static void idefloppy_create_mode_sense_cmd(struc=
t ide_atapi_pc *pc,
 		length +=3D 32;
 		break;
 	default:
-		printk(KERN_ERR "ide-floppy: unsupported page code "
-				"in create_mode_sense_cmd\n");
+		printk(KERN_ERR "ide-floppy: unsupported page code %s\n",
+				__func__);
 	}
-	put_unaligned(cpu_to_be16(length), (u16 *) &pc->c[7]);
+	put_unaligned(cpu_to_be16(length), (u16 *) &rq->cmd[7]);
 	pc->req_xfer =3D length;
 }
=20
-static void idefloppy_create_start_stop_cmd(struct ide_atapi_pc *pc, i=
nt start)
+static void idefloppy_create_start_stop_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc, int start)
 {
+	struct request *rq =3D pc->rq;
+
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_START_STOP_UNIT;
-	pc->c[4] =3D start;
+	ide_floppy_init_rq(drive, rq);
+
+	rq->cmd[0] =3D GPCMD_START_STOP_UNIT;
+	rq->cmd[4] =3D start;
 }
=20
-static void idefloppy_create_test_unit_ready_cmd(struct ide_atapi_pc *=
pc)
+static void idefloppy_create_test_unit_ready_cmd(ide_drive_t *drive,
+		struct ide_atapi_pc *pc)
 {
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D GPCMD_TEST_UNIT_READY;
+	ide_floppy_init_rq(drive, pc->rq);
+
+	pc->rq->cmd[0] =3D GPCMD_TEST_UNIT_READY;
 }
=20
 static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
@@ -809,9 +841,11 @@ static void idefloppy_create_rw_cmd(idefloppy_flop=
py_t *floppy,
 		block, blocks);
=20
 	idefloppy_init_pc(pc);
-	pc->c[0] =3D cmd =3D=3D READ ? GPCMD_READ_10 : GPCMD_WRITE_10;
-	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&pc->c[7]);
-	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[2]);
+	ide_floppy_init_rq(floppy->drive, rq);
+
+	rq->cmd[0] =3D cmd =3D=3D READ ? GPCMD_READ_10 : GPCMD_WRITE_10;
+	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&rq->cmd[7]);
+	put_unaligned(cpu_to_be32(block), (unsigned int *) &rq->cmd[2]);
=20
 	pc->idefloppy_callback =3D &idefloppy_rw_callback;
 	pc->rq =3D rq;
@@ -827,8 +861,8 @@ static void idefloppy_blockpc_cmd(idefloppy_floppy_=
t *floppy,
 		struct ide_atapi_pc *pc, struct request *rq)
 {
 	idefloppy_init_pc(pc);
+
 	pc->idefloppy_callback =3D &idefloppy_rw_callback;
-	memcpy(pc->c, rq->cmd, sizeof(pc->c));
 	pc->rq =3D rq;
 	pc->b_count =3D rq->data_len;
 	if (rq->data_len && rq_data_dir(rq) =3D=3D WRITE)
@@ -898,15 +932,7 @@ static ide_startstop_t idefloppy_do_request(ide_dr=
ive_t *drive,
  */
 static int idefloppy_queue_pc_tail(ide_drive_t *drive, struct ide_atap=
i_pc *pc)
 {
-	struct ide_floppy_obj *floppy =3D drive->driver_data;
-	struct request rq;
-
-	ide_init_drive_cmd(&rq);
-	rq.buffer =3D (char *) pc;
-	rq.cmd_type =3D REQ_TYPE_SPECIAL;
-	rq.rq_disk =3D floppy->disk;
-
-	return ide_do_drive_cmd(drive, &rq, ide_wait);
+	return ide_do_drive_cmd(drive, pc->rq, ide_wait);
 }
=20
 /*
@@ -917,13 +943,17 @@ static int ide_floppy_get_flexible_disk_page(ide_=
drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct ide_atapi_pc pc;
+	struct request rq;
+
 	u8 *page;
 	int capacity, lba_capacity;
 	u16 transfer_rate, sector_size, cyls, rpm;
 	u8 heads, sectors;
=20
-	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_FLEXIBLE_DISK_PAGE,
-					MODE_SENSE_CURRENT);
+	pc.rq =3D &rq;
+
+	idefloppy_create_mode_sense_cmd(drive, &pc,
+			IDEFLOPPY_FLEXIBLE_DISK_PAGE, MODE_SENSE_CURRENT);
=20
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-floppy: Can't get flexible disk page"
@@ -969,9 +999,12 @@ static int idefloppy_get_sfrp_bit(ide_drive_t *dri=
ve)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct ide_atapi_pc pc;
+	struct request rq;
+
+	pc.rq =3D &rq;
=20
 	floppy->srfp =3D 0;
-	idefloppy_create_mode_sense_cmd(&pc, IDEFLOPPY_CAPABILITIES_PAGE,
+	idefloppy_create_mode_sense_cmd(drive, &pc, IDEFLOPPY_CAPABILITIES_PA=
GE,
 						 MODE_SENSE_CURRENT);
=20
 	pc.flags |=3D PC_FLAG_SUPPRESS_ERROR;
@@ -990,17 +1023,20 @@ static int ide_floppy_get_capacity(ide_drive_t *=
drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct ide_atapi_pc pc;
+	struct request rq;
 	u8 *cap_desc;
 	u8 header_len, desc_cnt;
 	int i, rc =3D 1, blocks, length;
=20
+	pc.rq =3D &rq;
+
 	drive->bios_cyl =3D 0;
 	drive->bios_head =3D drive->bios_sect =3D 0;
 	floppy->blocks =3D 0;
 	floppy->bs_factor =3D 1;
 	set_capacity(floppy->disk, 0);
=20
-	idefloppy_create_read_capacity_cmd(&pc);
+	idefloppy_create_read_capacity_cmd(drive, &pc);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-floppy: Can't get floppy parameters\n");
 		return 1;
@@ -1102,6 +1138,7 @@ static int ide_floppy_get_capacity(ide_drive_t *d=
rive)
 static int ide_floppy_get_format_capacities(ide_drive_t *drive, int __=
user *arg)
 {
 	struct ide_atapi_pc pc;
+	struct request rq;
 	u8 header_len, desc_cnt;
 	int i, blocks, length, u_array_size, u_index;
 	int __user *argp;
@@ -1112,7 +1149,9 @@ static int ide_floppy_get_format_capacities(ide_d=
rive_t *drive, int __user *arg)
 	if (u_array_size <=3D 0)
 		return (-EINVAL);
=20
-	idefloppy_create_read_capacity_cmd(&pc);
+	pc.rq =3D &rq;
+
+	idefloppy_create_read_capacity_cmd(drive, &pc);
 	if (idefloppy_queue_pc_tail(drive, &pc)) {
 		printk(KERN_ERR "ide-floppy: Can't get floppy parameters\n");
 		return (-EIO);
@@ -1167,10 +1206,13 @@ static int idefloppy_get_format_progress(ide_dr=
ive_t *drive, int __user *arg)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct ide_atapi_pc pc;
+	struct request rq;
 	int progress_indication =3D 0x10000;
=20
+	pc.rq =3D &rq;
+
 	if (floppy->srfp) {
-		idefloppy_create_request_sense_cmd(&pc);
+		idefloppy_create_request_sense_cmd(drive, &pc);
 		if (idefloppy_queue_pc_tail(drive, &pc))
 			return (-EIO);
=20
@@ -1373,8 +1415,11 @@ static int idefloppy_open(struct inode *inode, s=
truct file *filp)
 	struct ide_floppy_obj *floppy;
 	ide_drive_t *drive;
 	struct ide_atapi_pc pc;
+	struct request rq;
 	int ret =3D 0;
=20
+	pc.rq =3D &rq;
+
 	debug_log("Reached %s\n", __func__);
=20
 	floppy =3D ide_floppy_get(disk);
@@ -1389,9 +1434,9 @@ static int idefloppy_open(struct inode *inode, st=
ruct file *filp)
 		floppy->flags &=3D ~IDEFLOPPY_FLAG_FORMAT_IN_PROGRESS;
 		/* Just in case */
=20
-		idefloppy_create_test_unit_ready_cmd(&pc);
+		idefloppy_create_test_unit_ready_cmd(drive, &pc);
 		if (idefloppy_queue_pc_tail(drive, &pc)) {
-			idefloppy_create_start_stop_cmd(&pc, 1);
+			idefloppy_create_start_stop_cmd(drive, &pc, 1);
 			(void) idefloppy_queue_pc_tail(drive, &pc);
 		}
=20
@@ -1414,7 +1459,7 @@ static int idefloppy_open(struct inode *inode, st=
ruct file *filp)
 		floppy->flags |=3D IDEFLOPPY_FLAG_MEDIA_CHANGED;
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
 		if (!(floppy->flags & IDEFLOPPY_FLAG_CLIK_DRIVE)) {
-			idefloppy_create_prevent_cmd(&pc, 1);
+			idefloppy_create_prevent_cmd(drive, &pc, 1);
 			(void) idefloppy_queue_pc_tail(drive, &pc);
 		}
 		check_disk_change(inode->i_bdev);
@@ -1436,13 +1481,16 @@ static int idefloppy_release(struct inode *inod=
e, struct file *filp)
 	struct ide_floppy_obj *floppy =3D ide_floppy_g(disk);
 	ide_drive_t *drive =3D floppy->drive;
 	struct ide_atapi_pc pc;
+	struct request rq;
+
+	pc.rq =3D &rq;
=20
 	debug_log("Reached %s\n", __func__);
=20
 	if (floppy->openers =3D=3D 1) {
 		/* IOMEGA Clik! drives do not support lock/unlock commands */
 		if (!(floppy->flags & IDEFLOPPY_FLAG_CLIK_DRIVE)) {
-			idefloppy_create_prevent_cmd(&pc, 0);
+			idefloppy_create_prevent_cmd(drive, &pc, 0);
 			(void) idefloppy_queue_pc_tail(drive, &pc);
 		}
=20
@@ -1481,12 +1529,12 @@ static int ide_floppy_lockdoor(idefloppy_floppy=
_t *floppy,
 		if (cmd =3D=3D CDROMEJECT)
 			prevent =3D 0;
=20
-		idefloppy_create_prevent_cmd(pc, prevent);
+		idefloppy_create_prevent_cmd(floppy->drive, pc, prevent);
 		(void) idefloppy_queue_pc_tail(floppy->drive, pc);
 	}
=20
 	if (cmd =3D=3D CDROMEJECT) {
-		idefloppy_create_start_stop_cmd(pc, 2);
+		idefloppy_create_start_stop_cmd(floppy->drive, pc, 2);
 		(void) idefloppy_queue_pc_tail(floppy->drive, pc);
 	}
=20
@@ -1498,6 +1546,10 @@ static int ide_floppy_format_unit(idefloppy_flop=
py_t *floppy,
 {
 	int blocks, length, flags, err =3D 0;
 	struct ide_atapi_pc pc;
+	struct request rq;
+	ide_drive_t *drive =3D floppy->drive;
+
+	pc.rq =3D &rq;
=20
 	if (floppy->openers > 1) {
 		/* Don't format if someone is using the disk */
@@ -1529,10 +1581,10 @@ static int ide_floppy_format_unit(idefloppy_flo=
ppy_t *floppy,
 		goto out;
 	}
=20
-	(void) idefloppy_get_sfrp_bit(floppy->drive);
-	idefloppy_create_format_unit_cmd(&pc, blocks, length, flags);
+	(void) idefloppy_get_sfrp_bit(drive);
+	idefloppy_create_format_unit_cmd(drive, &pc, blocks, length, flags);
=20
-	if (idefloppy_queue_pc_tail(floppy->drive, &pc))
+	if (idefloppy_queue_pc_tail(drive, &pc))
 		err =3D -EIO;
=20
 out:
@@ -1549,9 +1601,12 @@ static int idefloppy_ioctl(struct inode *inode, =
struct file *file,
 	struct ide_floppy_obj *floppy =3D ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive =3D floppy->drive;
 	struct ide_atapi_pc pc;
+	struct request rq;
 	void __user *argp =3D (void __user *)arg;
 	int err;
=20
+	pc.rq =3D &rq;
+
 	switch (cmd) {
 	case CDROMEJECT:
 		/* fall through */

--=20
Regards/Gru=DF,
    Boris.
