From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: (was: Re:...) [PATCH 12/12] ide-floppy: fix most of the remaining
	checkpatch.pl issues-v2
Date: Tue, 15 Jan 2008 21:12:51 +0100
Message-ID: <20080115201251.GC5699@gollum.tnic>
References: <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-7-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-9-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-10-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-12-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-13-git-send-email-bbpetkov@yahoo.de>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp115.plus.mail.re1.yahoo.com ([69.147.102.78]:23463 "HELO
	smtp115.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751315AbYAOUQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 15:16:42 -0500
Content-Disposition: inline
In-Reply-To: <1200255505-31418-13-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

=2E.. and finally the last one. Whew! I think we're done here for now. =
:)

--
=46rom: Borislav Petkov <bbpetkov@yahoo.de>
Date: Tue, 15 Jan 2008 21:01:04 +0100
Subject: ide-floppy: fix most of the remaining checkpatch.pl issues-v2

such as
ERROR: switch and case should be at the same indent
ERROR: need spaces around that '=3D' (ctx:VxV)
ERROR: trailing statements should be on next line
WARNING: no space between function name and open parenthesis '('
WARNING: printk() should include KERN_ facility level
ERROR: That open brace { should be on the previous line
ERROR: use tabs not spaces
ERROR: do not use assignment in if condition
WARNING: braces {} are not necessary for single statement blocks
ERROR: need space after that ',' (ctx:VxV)
WARNING: line over 80 characters
ERROR: do not use assignment in if condition
=2E..
and so on.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

:100644 100644 4b9a7e9... 0bf6596... M	drivers/ide/ide-floppy.c

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 4b9a7e9..0bf6596 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -4,9 +4,7 @@
  * Copyright (C) 1996-1999  Gadi Oxman <gadio@netvision.net.il>
  * Copyright (C) 2000-2002  Paul Bristow <paul@paulbristow.net>
  * Copyright (C) 2005       Bartlomiej Zolnierkiewicz
- */
-
-/*
+ *
  * The driver currently doesn't have any fancy features, just the bare
  * minimum read/write support.
  *
@@ -51,57 +49,56 @@
 #define IDEFLOPPY_DEBUG_LOG		0
=20
 /* #define IDEFLOPPY_DEBUG(fmt, args...) printk(KERN_INFO fmt, ## args=
) */
-#define IDEFLOPPY_DEBUG( fmt, args... )
+#define IDEFLOPPY_DEBUG(fmt, args...)
=20
 #if IDEFLOPPY_DEBUG_LOG
 #define debug_log(fmt, args...) \
 	printk(KERN_INFO "ide-floppy: " fmt, ## args)
 #else
-#define debug_log(fmt, args... ) do {} while(0)
+#define debug_log(fmt, args...) do {} while (0)
 #endif
=20
=20
-/*
- *	Some drives require a longer irq timeout.
- */
+/* Some drives require a longer irq timeout. */
 #define IDEFLOPPY_WAIT_CMD		(5 * WAIT_CMD)
=20
 /*
- *	After each failed packet command we issue a request sense command
- *	and retry the packet command IDEFLOPPY_MAX_PC_RETRIES times.
+ * After each failed packet command we issue a request sense command a=
nd retry
+ * the packet command IDEFLOPPY_MAX_PC_RETRIES times.
  */
 #define IDEFLOPPY_MAX_PC_RETRIES	3
=20
 /*
- *	With each packet command, we allocate a buffer of
- *	IDEFLOPPY_PC_BUFFER_SIZE bytes.
+ * With each packet command, we allocate a buffer of IDEFLOPPY_PC_BUFF=
ER_SIZE
+ * bytes.
  */
 #define IDEFLOPPY_PC_BUFFER_SIZE	256
=20
 /*
- *	In various places in the driver, we need to allocate storage
- *	for packet commands and requests, which will remain valid while
- *	we leave the driver to wait for an interrupt or a timeout event.
+ * In various places in the driver, we need to allocate storage for pa=
cket
+ * commands and requests, which will remain valid while	we leave the d=
river to
+ * wait for an interrupt or a timeout event.
  */
 #define IDEFLOPPY_PC_STACK		(10 + IDEFLOPPY_MAX_PC_RETRIES)
=20
-/*
- *	Our view of a packet command.
- */
 typedef struct idefloppy_packet_command_s {
 	u8 c[12];				/* Actual packet bytes */
-	int retries;				/* On each retry, we increment retries */
+	int retries;				/* On each retry, we increment
+						   retries */
 	int error;				/* Error code */
 	int request_transfer;			/* Bytes to transfer */
 	int actually_transferred;		/* Bytes actually transferred */
 	int buffer_size;			/* Size of our data buffer */
-	int b_count;				/* Missing/Available data on the current buffer */
+	int b_count;				/* Missing/Available data on
+						   the current buffer */
 	struct request *rq;			/* The corresponding request */
 	u8 *buffer;				/* Data buffer */
-	u8 *current_position;			/* Pointer into the above buffer */
-	void (*callback) (ide_drive_t *);	/* Called when this packet command =
is completed */
+	u8 *current_position;			/* Pointer into above buffer */
+	void (*callback) (ide_drive_t *);	/* Called when this packet
+						   command is completed */
 	u8 pc_buffer[IDEFLOPPY_PC_BUFFER_SIZE];	/* Temporary buffer */
-	unsigned long flags;			/* Status/Action bit flags: long for set_bit *=
/
+	unsigned long flags;			/* Status/Action bit flags: long
+						   for set_bit */
 } idefloppy_pc_t;
=20
 /* Packet command flag bits. */
@@ -125,9 +122,9 @@ enum {
 #define CAPACITY_NO_CARTRIDGE	0x03
=20
 /*
- *	Most of our global data which we need to save even as we leave the
- *	driver due to an interrupt or a timer event is stored in a variable
- *	of type idefloppy_floppy_t, defined below.
+ * Most of our global data which we need to save even as we leave the =
driver
+ * due to an interrupt or a timer event is stored in a variable of typ=
e
+ * idefloppy_floppy_t, defined below.
  */
 typedef struct ide_floppy_obj {
 	ide_drive_t	*drive;
@@ -148,17 +145,13 @@ typedef struct ide_floppy_obj {
 	/* We implement a circular array */
 	int rq_stack_index;
=20
-	/*
-	 *	Last error information
-	 */
+	/* Last error information */
 	u8 sense_key, asc, ascq;
 	/* delay this long before sending packet command */
 	u8 ticks;
 	int progress_indication;
=20
-	/*
-	 *	Device information
-	 */
+	/* Device information */
 	/* Current format */
 	int blocks, block_size, bs_factor;
 	/* Last format capacity descriptor */
@@ -189,34 +182,26 @@ enum {
 	IDEFLOPPY_FLAG_ZIP_DRIVE		=3D (1 << 4),
 };
=20
-/*
- *	Defines for the mode sense command
- */
+/* Defines for the MODE SENSE command */
 #define MODE_SENSE_CURRENT		0x00
 #define MODE_SENSE_CHANGEABLE		0x01
-#define MODE_SENSE_DEFAULT		0x02=20
+#define MODE_SENSE_DEFAULT		0x02
 #define MODE_SENSE_SAVED		0x03
=20
-/*
- *	IOCTLs used in low-level formatting.
- */
-
+/* IOCTLs used in low-level formatting. */
 #define	IDEFLOPPY_IOCTL_FORMAT_SUPPORTED	0x4600
 #define	IDEFLOPPY_IOCTL_FORMAT_GET_CAPACITY	0x4601
 #define	IDEFLOPPY_IOCTL_FORMAT_START		0x4602
 #define IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS	0x4603
=20
-/*
- *	Error codes which are returned in rq->errors to the higher part
- *	of the driver.
- */
+/* Error code returned in rq->errors to the higher part of the driver.=
 */
 #define	IDEFLOPPY_ERROR_GENERAL		101
=20
 /*
- *	The following is used to format the general configuration word of
- *	the ATAPI IDENTIFY DEVICE command.
+ * The following is used to format the general configuration word of t=
he
+ * ATAPI IDENTIFY DEVICE command.
  */
-struct idefloppy_id_gcw {=09
+struct idefloppy_id_gcw {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned packet_size		:2;	/* Packet Size */
 	unsigned reserved234		:3;	/* Reserved */
@@ -274,10 +259,10 @@ static void ide_floppy_put(struct ide_floppy_obj =
*floppy)
 }
=20
 /*
- *	Too bad. The drive wants to send us data which we are not ready to =
accept.
- *	Just throw it away.
+ * Too bad. The drive wants to send us data which we are not ready to =
accept.
+ * Just throw it away.
  */
-static void idefloppy_discard_data (ide_drive_t *drive, unsigned int b=
count)
+static void idefloppy_discard_data(ide_drive_t *drive, unsigned int bc=
ount)
 {
 	while (bcount--)
 		(void) HWIF(drive)->INB(IDE_DATA_REG);
@@ -291,10 +276,8 @@ static void idefloppy_write_zeros(ide_drive_t *dri=
ve, unsigned int bcount)
=20
=20
 /*
- *	idefloppy_do_end_request is used to finish servicing a request.
- *
- *	For read/write requests, we will call ide_end_request to pass to th=
e
- *	next buffer.
+ * Used to finish servicing a request. For read/write requests, we wil=
l call
+ * ide_end_request to pass to the next buffer.
  */
 static int idefloppy_do_end_request(ide_drive_t *drive, int uptodate, =
int nsecs)
 {
@@ -305,9 +288,9 @@ static int idefloppy_do_end_request(ide_drive_t *dr=
ive, int uptodate, int nsecs)
 	debug_log("Reached %s\n", __FUNCTION__);
=20
 	switch (uptodate) {
-		case 0: error =3D IDEFLOPPY_ERROR_GENERAL; break;
-		case 1: error =3D 0; break;
-		default: error =3D uptodate;
+	case 0: error =3D IDEFLOPPY_ERROR_GENERAL; break;
+	case 1: error =3D 0; break;
+	default: error =3D uptodate;
 	}
 	if (error)
 		floppy->failed_pc =3D NULL;
@@ -366,7 +349,7 @@ static void ide_floppy_io_buffers(ide_drive_t *driv=
e, idefloppy_pc_t *pc,
 	}
 }
=20
-static void idefloppy_update_buffers (ide_drive_t *drive, idefloppy_pc=
_t *pc)
+static void idefloppy_update_buffers(ide_drive_t *drive, idefloppy_pc_=
t *pc)
 {
 	struct request *rq =3D pc->rq;
 	struct bio *bio =3D rq->bio;
@@ -376,11 +359,12 @@ static void idefloppy_update_buffers (ide_drive_t=
 *drive, idefloppy_pc_t *pc)
 }
=20
 /*
- *	idefloppy_queue_pc_head generates a new packet command request in f=
ront
- *	of the request queue, before the current request, so that it will b=
e
- *	processed immediately, on the next pass through the driver.
+ * Generate a new packet command request in front of the request queue=
, before
+ * the current request so that it will be processed immediately, on th=
e next
+ * pass through the driver.
  */
-static void idefloppy_queue_pc_head (ide_drive_t *drive,idefloppy_pc_t=
 *pc,struct request *rq)
+static void idefloppy_queue_pc_head(ide_drive_t *drive, idefloppy_pc_t=
 *pc,
+		struct request *rq)
 {
 	struct ide_floppy_obj *floppy =3D drive->driver_data;
=20
@@ -391,16 +375,16 @@ static void idefloppy_queue_pc_head (ide_drive_t =
*drive,idefloppy_pc_t *pc,struc
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
=20
-static idefloppy_pc_t *idefloppy_next_pc_storage (ide_drive_t *drive)
+static idefloppy_pc_t *idefloppy_next_pc_storage(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
 	if (floppy->pc_stack_index =3D=3D IDEFLOPPY_PC_STACK)
-		floppy->pc_stack_index=3D0;
+		floppy->pc_stack_index =3D 0;
 	return (&floppy->pc_stack[floppy->pc_stack_index++]);
 }
=20
-static struct request *idefloppy_next_rq_storage (ide_drive_t *drive)
+static struct request *idefloppy_next_rq_storage(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
@@ -445,10 +429,8 @@ static void idefloppy_request_sense_callback(ide_d=
rive_t *drive)
 	}
 }
=20
-/*
- *	General packet command callback function.
- */
-static void idefloppy_pc_callback (ide_drive_t *drive)
+/* General packet command callback function. */
+static void idefloppy_pc_callback(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
@@ -457,10 +439,7 @@ static void idefloppy_pc_callback (ide_drive_t *dr=
ive)
 	idefloppy_do_end_request(drive, floppy->pc->error ? 0 : 1, 0);
 }
=20
-/*
- *	idefloppy_init_pc initializes a packet command.
- */
-static void idefloppy_init_pc (idefloppy_pc_t *pc)
+static void idefloppy_init_pc(idefloppy_pc_t *pc)
 {
 	memset(pc->c, 0, 12);
 	pc->retries =3D 0;
@@ -471,7 +450,7 @@ static void idefloppy_init_pc (idefloppy_pc_t *pc)
 	pc->callback =3D &idefloppy_pc_callback;
 }
=20
-static void idefloppy_create_request_sense_cmd (idefloppy_pc_t *pc)
+static void idefloppy_create_request_sense_cmd(idefloppy_pc_t *pc)
 {
 	idefloppy_init_pc(pc);
 	pc->c[0] =3D GPCMD_REQUEST_SENSE;
@@ -481,11 +460,10 @@ static void idefloppy_create_request_sense_cmd (i=
defloppy_pc_t *pc)
 }
=20
 /*
- *	idefloppy_retry_pc is called when an error was detected during the
- *	last packet command. We queue a request sense packet command in
- *	the head of the request list.
+ * Called when an error was detected during the last packet command. W=
e queue a
+ * request sense packet command in the head of the request list.
  */
-static void idefloppy_retry_pc (ide_drive_t *drive)
+static void idefloppy_retry_pc(ide_drive_t *drive)
 {
 	idefloppy_pc_t *pc;
 	struct request *rq;
@@ -529,7 +507,8 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_=
t *drive)
 	/* Clear the interrupt */
 	stat =3D drive->hwif->INB(IDE_STATUS_REG);
=20
-	if ((stat & DRQ_STAT) =3D=3D 0) {		/* No more interrupts */
+	/* No more interrupts */
+	if ((stat & DRQ_STAT) =3D=3D 0) {
 		debug_log("Packet command completed, %d bytes transferred\n",
 				pc->actually_transferred);
 		pc->flags &=3D ~PC_FLAG_DMA_IN_PROGRESS;
@@ -629,7 +608,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_=
t *drive)
  * It fails at high speeds on the Iomega ZIP drive, so there's a slowe=
r version
  * for that drive below. The algorithm is chosen based on drive type
  */
-static ide_startstop_t idefloppy_transfer_pc (ide_drive_t *drive)
+static ide_startstop_t idefloppy_transfer_pc(ide_drive_t *drive)
 {
 	ide_startstop_t startstop;
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
@@ -656,18 +635,16 @@ static ide_startstop_t idefloppy_transfer_pc (ide=
_drive_t *drive)
=20
=20
 /*
- * What we have here is a classic case of a top half / bottom half
- * interrupt service routine. In interrupt mode, the device sends
- * an interrupt to signal it's ready to receive a packet. However,
- * we need to delay about 2-3 ticks before issuing the packet or we
- * gets in trouble.
+ * What we have here is a classic case of a top half / bottom half int=
errupt
+ * service routine. In interrupt mode, the device sends an interrupt t=
o signal
+ * that it is ready to receive a packet. However, we need to delay abo=
ut 2-3
+ * ticks before issuing the packet or we gets in trouble.
  *
- * So, follow carefully. transfer_pc1 is called as an interrupt (or
- * directly). In either case, when the device says it's ready for a=20
- * packet, we schedule the packet transfer to occur about 2-3 ticks
- * later in transfer_pc2.
+ * So, follow carefully. transfer_pc1 is called as an interrupt (or di=
rectly).
+ * In either case, when the device says it's ready for a packet, we sc=
hedule
+ * the packet transfer to occur about 2-3 ticks later in transfer_pc2.
  */
-static int idefloppy_transfer_pc2 (ide_drive_t *drive)
+static int idefloppy_transfer_pc2(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
@@ -677,7 +654,7 @@ static int idefloppy_transfer_pc2 (ide_drive_t *dri=
ve)
 	return IDEFLOPPY_WAIT_CMD;
 }
=20
-static ide_startstop_t idefloppy_transfer_pc1 (ide_drive_t *drive)
+static ide_startstop_t idefloppy_transfer_pc1(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	ide_startstop_t startstop;
@@ -694,7 +671,7 @@ static ide_startstop_t idefloppy_transfer_pc1 (ide_=
drive_t *drive)
 				"while issuing a packet command\n");
 		return ide_do_reset(drive);
 	}
-	/*=20
+	/*
 	 * The following delay solves a problem with ATAPI Zip 100 drives
 	 * where the Busy flag was apparently being deasserted before the
 	 * unit was ready to receive data. This was happening on a
@@ -703,10 +680,8 @@ static ide_startstop_t idefloppy_transfer_pc1 (ide=
_drive_t *drive)
 	 * used until after the packet is moved in about 50 msec.
 	 */
=20
-	ide_set_handler(drive,=20
-	  &idefloppy_pc_intr, 		/* service routine for packet command */
-	  floppy->ticks,		/* wait this long before "failing" */
-	  &idefloppy_transfer_pc2);	/* fail =3D=3D transfer_pc2 */
+	ide_set_handler(drive, &idefloppy_pc_intr, floppy->ticks,
+			&idefloppy_transfer_pc2);
 	return ide_started;
 }
=20
@@ -726,10 +701,8 @@ static void ide_floppy_report_error(idefloppy_flop=
py_t *floppy,
=20
 }
=20
-/*
- *	Issue a packet command
- */
-static ide_startstop_t idefloppy_issue_pc (ide_drive_t *drive, ideflop=
py_pc_t *pc)
+static ide_startstop_t idefloppy_issue_pc(ide_drive_t *drive,
+		idefloppy_pc_t *pc)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	ide_hwif_t *hwif =3D drive->hwif;
@@ -774,7 +747,8 @@ static ide_startstop_t idefloppy_issue_pc (ide_driv=
e_t *drive, idefloppy_pc_t *p
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK |
 			   IDE_TFLAG_OUT_DEVICE, bcount, dma);
=20
-	if (dma) {	/* Begin DMA, if necessary */
+	if (dma) {
+		/* Begin DMA, if necessary */
 		pc->flags |=3D PC_FLAG_DMA_IN_PROGRESS;
 		hwif->dma_start(drive);
 	}
@@ -802,7 +776,7 @@ static ide_startstop_t idefloppy_issue_pc (ide_driv=
e_t *drive, idefloppy_pc_t *p
 	}
 }
=20
-static void idefloppy_rw_callback (ide_drive_t *drive)
+static void idefloppy_rw_callback(ide_drive_t *drive)
 {
 	debug_log("Reached %s\n", __FUNCTION__);
=20
@@ -810,7 +784,7 @@ static void idefloppy_rw_callback (ide_drive_t *dri=
ve)
 	return;
 }
=20
-static void idefloppy_create_prevent_cmd (idefloppy_pc_t *pc, int prev=
ent)
+static void idefloppy_create_prevent_cmd(idefloppy_pc_t *pc, int preve=
nt)
 {
 	debug_log("creating prevent removal command, prevent =3D %d\n", preve=
nt);
=20
@@ -819,7 +793,7 @@ static void idefloppy_create_prevent_cmd (idefloppy=
_pc_t *pc, int prevent)
 	pc->c[4] =3D prevent;
 }
=20
-static void idefloppy_create_read_capacity_cmd (idefloppy_pc_t *pc)
+static void idefloppy_create_read_capacity_cmd(idefloppy_pc_t *pc)
 {
 	idefloppy_init_pc(pc);
 	pc->c[0] =3D GPCMD_READ_FORMAT_CAPACITIES;
@@ -828,7 +802,7 @@ static void idefloppy_create_read_capacity_cmd (ide=
floppy_pc_t *pc)
 	pc->request_transfer =3D 255;
 }
=20
-static void idefloppy_create_format_unit_cmd (idefloppy_pc_t *pc, int =
b, int l,
+static void idefloppy_create_format_unit_cmd(idefloppy_pc_t *pc, int b=
, int l,
 					      int flags)
 {
 	idefloppy_init_pc(pc);
@@ -845,38 +819,37 @@ static void idefloppy_create_format_unit_cmd (ide=
floppy_pc_t *pc, int b, int l,
=20
 	put_unaligned(cpu_to_be32(b), (unsigned int *)(&pc->buffer[4]));
 	put_unaligned(cpu_to_be32(l), (unsigned int *)(&pc->buffer[8]));
-	pc->buffer_size=3D12;
+	pc->buffer_size =3D 12;
 	pc->flags |=3D PC_FLAG_WRITING;
 }
=20
-/*
- *	A mode sense command is used to "sense" floppy parameters.
- */
-static void idefloppy_create_mode_sense_cmd (idefloppy_pc_t *pc, u8 pa=
ge_code, u8 type)
+/* A mode sense command is used to "sense" floppy parameters. */
+static void idefloppy_create_mode_sense_cmd(idefloppy_pc_t *pc, u8 pag=
e_code,
+		u8 type)
 {
 	u16 length =3D 8; /* sizeof(Mode Parameter Header) =3D 8 Bytes */
-=09
+
 	idefloppy_init_pc(pc);
 	pc->c[0] =3D GPCMD_MODE_SENSE_10;
 	pc->c[1] =3D 0;
 	pc->c[2] =3D page_code + (type << 6);
=20
 	switch (page_code) {
-		case IDEFLOPPY_CAPABILITIES_PAGE:
-			length +=3D 12;
-			break;
-		case IDEFLOPPY_FLEXIBLE_DISK_PAGE:
-			length +=3D 32;
-			break;
-		default:
-			printk(KERN_ERR "ide-floppy: unsupported page code "
+	case IDEFLOPPY_CAPABILITIES_PAGE:
+		length +=3D 12;
+		break;
+	case IDEFLOPPY_FLEXIBLE_DISK_PAGE:
+		length +=3D 32;
+		break;
+	default:
+		printk(KERN_ERR "ide-floppy: unsupported page code "
 				"in create_mode_sense_cmd\n");
 	}
 	put_unaligned(cpu_to_be16(length), (u16 *) &pc->c[7]);
 	pc->request_transfer =3D length;
 }
=20
-static void idefloppy_create_start_stop_cmd (idefloppy_pc_t *pc, int s=
tart)
+static void idefloppy_create_start_stop_cmd(idefloppy_pc_t *pc, int st=
art)
 {
 	idefloppy_init_pc(pc);
 	pc->c[0] =3D GPCMD_START_STOP_UNIT;
@@ -914,8 +887,8 @@ static void idefloppy_create_rw_cmd(idefloppy_flopp=
y_t *floppy,
 	pc->flags |=3D PC_FLAG_DMA_RECOMMENDED;
 }
=20
-static void
-idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy, idefloppy_pc_t *pc, =
struct request *rq)
+static void idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy,
+		idefloppy_pc_t *pc, struct request *rq)
 {
 	idefloppy_init_pc(pc);
 	pc->callback =3D &idefloppy_rw_callback;
@@ -934,10 +907,8 @@ idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy, =
idefloppy_pc_t *pc, struct req
 	pc->request_transfer =3D pc->buffer_size =3D rq->data_len;
 }
=20
-/*
- *	idefloppy_do_request is our request handling function.=09
- */
-static ide_startstop_t idefloppy_do_request (ide_drive_t *drive, struc=
t request *rq, sector_t block_s)
+static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
+		struct request *rq, sector_t block_s)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	idefloppy_pc_t *pc;
@@ -962,8 +933,8 @@ static ide_startstop_t idefloppy_do_request (ide_dr=
ive_t *drive, struct request
 	if (blk_fs_request(rq)) {
 		if (((long)rq->sector % floppy->bs_factor) ||
 		    (rq->nr_sectors % floppy->bs_factor)) {
-			printk("%s: unsupported r/w request size\n",
-				drive->name);
+			printk(KERN_ERR "%s: unsupported r/w request size\n",
+					drive->name);
 			idefloppy_do_end_request(drive, 0, 0);
 			return ide_stopped;
 		}
@@ -986,15 +957,15 @@ static ide_startstop_t idefloppy_do_request (ide_=
drive_t *drive, struct request
 }
=20
 /*
- *	idefloppy_queue_pc_tail adds a special packet command request to th=
e
- *	tail of the request queue, and waits for it to be serviced.
+ * Add a special packet command request to the tail of the request que=
ue,
+ * and wait for it to be serviced.
  */
-static int idefloppy_queue_pc_tail (ide_drive_t *drive,idefloppy_pc_t =
*pc)
+static int idefloppy_queue_pc_tail(ide_drive_t *drive, idefloppy_pc_t =
*pc)
 {
 	struct ide_floppy_obj *floppy =3D drive->driver_data;
 	struct request rq;
=20
-	ide_init_drive_cmd (&rq);
+	ide_init_drive_cmd(&rq);
 	rq.buffer =3D (char *) pc;
 	rq.cmd_type =3D REQ_TYPE_SPECIAL;
 	rq.rq_disk =3D floppy->disk;
@@ -1121,7 +1092,7 @@ static int ide_floppy_get_capacity(ide_drive_t *d=
rive)
 		/* Clik! drive returns this instead of CAPACITY_CURRENT */
 		case CAPACITY_UNFORMATTED:
 			if (!(floppy->flags & IDEFLOPPY_FLAG_CLIK_DRIVE))
-                                /*
+				/*
 				 * If it is not a clik drive, break out
 				 * (maintains previous driver behaviour)
 				 */
@@ -1247,14 +1218,14 @@ static int ide_floppy_get_format_capacities(ide=
_drive_t *drive, int __user *arg)
 }
=20
 /*
-** Get ATAPI_FORMAT_UNIT progress indication.
-**
-** Userland gives a pointer to an int.  The int is set to a progress
-** indicator 0-65536, with 65536=3D100%.
-**
-** If the drive does not support format progress indication, we just c=
heck
-** the dsc bit, and return either 0 or 65536.
-*/
+ * Get ATAPI_FORMAT_UNIT progress indication.
+ *
+ * Userland gives a pointer to an int.  The int is set to a progress
+ * indicator 0-65536, with 65536=3D100%.
+ *
+ * If the drive does not support format progress indication, we just c=
heck
+ * the dsc bit, and return either 0 or 65536.
+ */
=20
 static int idefloppy_get_format_progress(ide_drive_t *drive, int __use=
r *arg)
 {
@@ -1264,17 +1235,15 @@ static int idefloppy_get_format_progress(ide_dr=
ive_t *drive, int __user *arg)
=20
 	if (floppy->srfp) {
 		idefloppy_create_request_sense_cmd(&pc);
-		if (idefloppy_queue_pc_tail(drive, &pc)) {
+		if (idefloppy_queue_pc_tail(drive, &pc))
 			return (-EIO);
-		}
=20
 		if (floppy->sense_key =3D=3D 2 &&
 		    floppy->asc =3D=3D 4 &&
-		    floppy->ascq =3D=3D 4) {
+		    floppy->ascq =3D=3D 4)
 			progress_indication =3D floppy->progress_indication;
-		}
-		/* Else assume format_unit has finished, and we're
-		** at 0x10000 */
+
+		/* Else assume format_unit has finished, and we're at 0x10000 */
 	} else {
 		unsigned long flags;
 		u8 stat;
@@ -1291,10 +1260,7 @@ static int idefloppy_get_format_progress(ide_dri=
ve_t *drive, int __user *arg)
 	return (0);
 }
=20
-/*
- *	Return the current floppy capacity.
- */
-static sector_t idefloppy_capacity (ide_drive_t *drive)
+static sector_t idefloppy_capacity(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	unsigned long capacity =3D floppy->blocks * floppy->bs_factor;
@@ -1344,22 +1310,20 @@ static void idefloppy_add_settings(ide_drive_t =
*drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
=20
-/*
- *			drive	setting name	read/write	data type	min	max	mul_factor	div_fa=
ctor	data pointer		set function
- */
-	ide_add_setting(drive,	"bios_cyl",	SETTING_RW,	TYPE_INT,	0,	1023,		1,=
		1,	&drive->bios_cyl,	NULL);
-	ide_add_setting(drive,	"bios_head",	SETTING_RW,	TYPE_BYTE,	0,	255,		1=
,		1,	&drive->bios_head,	NULL);
-	ide_add_setting(drive,	"bios_sect",	SETTING_RW,	TYPE_BYTE,	0,	63,		1,=
		1,	&drive->bios_sect,	NULL);
-	ide_add_setting(drive,	"ticks",	SETTING_RW,	TYPE_BYTE,	0,	255,		1,		1=
,	&floppy->ticks,		NULL);
+	ide_add_setting(drive, "bios_cyl", SETTING_RW, TYPE_INT, 0, 1023, 1, =
1,
+			&drive->bios_cyl, NULL);
+	ide_add_setting(drive, "bios_head", SETTING_RW, TYPE_BYTE, 0, 255, 1,=
 1,
+			&drive->bios_head, NULL);
+	ide_add_setting(drive, "bios_sect", SETTING_RW,	TYPE_BYTE, 0,  63, 1,=
 1,
+			&drive->bios_sect, NULL);
+	ide_add_setting(drive, "ticks",	   SETTING_RW, TYPE_BYTE, 0, 255, 1, =
1,
+			&floppy->ticks,	 NULL);
 }
 #else
 static inline void idefloppy_add_settings(ide_drive_t *drive) { ; }
 #endif
=20
-/*
- *	Driver initialization.
- */
-static void idefloppy_setup (ide_drive_t *drive, idefloppy_floppy_t *f=
loppy)
+static void idefloppy_setup(ide_drive_t *drive, idefloppy_floppy_t *fl=
oppy)
 {
 	struct idefloppy_id_gcw gcw;
=20
@@ -1368,16 +1332,14 @@ static void idefloppy_setup (ide_drive_t *drive=
, idefloppy_floppy_t *floppy)
 	if (gcw.drq_type =3D=3D 1)
 		floppy->flags |=3D IDEFLOPPY_FLAG_DRQ_INTERRUPT;
 	/*
-	 *	We used to check revisions here. At this point however
-	 *	I'm giving up. Just assume they are all broken, its easier.
+	 * We used to check revisions here. At this point however I'm giving =
up.
+	 * Just assume they are all broken, its easier.
 	 *
-	 *	The actual reason for the workarounds was likely
-	 *	a driver bug after all rather than a firmware bug,
-	 *	and the workaround below used to hide it. It should
-	 *	be fixed as of version 1.9, but to be on the safe side
-	 *	we'll leave the limitation below for the 2.2.x tree.
+	 * The actual reason for the workarounds was likely a driver bug afte=
r
+	 * all rather than a firmware bug, and the workaround below used to h=
ide
+	 * it. It should be fixed as of version 1.9, but to be on the safe si=
de
+	 * we'll leave the limitation below for the 2.2.x tree.
 	 */
-
 	if (!strncmp(drive->id->model, "IOMEGA ZIP 100 ATAPI", 20)) {
 		floppy->flags |=3D IDEFLOPPY_FLAG_ZIP_DRIVE;
 		/* This value will be visible in the /proc/ide/hdx/settings */
@@ -1386,16 +1348,14 @@ static void idefloppy_setup (ide_drive_t *drive=
, idefloppy_floppy_t *floppy)
 	}
=20
 	/*
-	*      Guess what?  The IOMEGA Clik! drive also needs the
-	*      above fix.  It makes nasty clicking noises without
-	*      it, so please don't remove this.
-	*/
+	 * Guess what? The IOMEGA Clik! drive also needs the above fix. It ma=
kes
+	 * nasty clicking noises without it, so please don't remove this.
+	 */
 	if (strncmp(drive->id->model, "IOMEGA Clik!", 11) =3D=3D 0) {
 		blk_queue_max_sectors(drive->queue, 64);
 		floppy->flags |=3D IDEFLOPPY_FLAG_CLIK_DRIVE;
 	}
=20
-
 	(void) ide_floppy_get_capacity(drive);
 	idefloppy_add_settings(drive);
 }
@@ -1425,19 +1385,19 @@ static void idefloppy_cleanup_obj(struct kref *=
kref)
 }
=20
 #ifdef CONFIG_IDE_PROC_FS
-static int proc_idefloppy_read_capacity
-	(char *page, char **start, off_t off, int count, int *eof, void *data=
)
+static int proc_idefloppy_read_capacity(char *page, char **start, off_=
t off,
+		int count, int *eof, void *data)
 {
 	ide_drive_t*drive =3D (ide_drive_t *)data;
 	int len;
=20
-	len =3D sprintf(page,"%llu\n", (long long)idefloppy_capacity(drive));
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+	len =3D sprintf(page, "%llu\n", (long long)idefloppy_capacity(drive))=
;
+	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
 }
=20
 static ide_proc_entry_t idefloppy_proc[] =3D {
-	{ "capacity",	S_IFREG|S_IRUGO,	proc_idefloppy_read_capacity, NULL },
-	{ "geometry",	S_IFREG|S_IRUGO,	proc_ide_read_geometry,	NULL },
+	{ "capacity",	S_IFREG|S_IRUGO, proc_idefloppy_read_capacity,	NULL },
+	{ "geometry",	S_IFREG|S_IRUGO, proc_ide_read_geometry,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
 #endif	/* CONFIG_IDE_PROC_FS */
@@ -1474,7 +1434,8 @@ static int idefloppy_open(struct inode *inode, st=
ruct file *filp)
=20
 	debug_log("Reached %s\n", __FUNCTION__);
=20
-	if (!(floppy =3D ide_floppy_get(disk)))
+	floppy =3D ide_floppy_get(disk);
+	if (!floppy)
 		return -ENXIO;
=20
 	drive =3D floppy->drive;
@@ -1494,10 +1455,10 @@ static int idefloppy_open(struct inode *inode, =
struct file *filp)
 		if (ide_floppy_get_capacity(drive)
 		   && (filp->f_flags & O_NDELAY) =3D=3D 0
 		    /*
-		    ** Allow O_NDELAY to open a drive without a disk, or with
-		    ** an unreadable disk, so that we can get the format
-		    ** capacity of the drive or begin the format - Sam
-		    */
+		     * Allow O_NDELAY to open a drive without a disk, or with an
+		     * unreadable disk, so that we can get the format capacity
+		     * of the drive or begin the format - Sam
+		     */
 		    ) {
 			ret =3D -EIO;
 			goto out_put_floppy;
@@ -1726,16 +1687,20 @@ static int ide_floppy_probe(ide_drive_t *drive)
 		goto failed;
 	if (drive->media !=3D ide_floppy)
 		goto failed;
-	if (!idefloppy_identify_device (drive, drive->id)) {
-		printk (KERN_ERR "ide-floppy: %s: not supported by this version of i=
de-floppy\n", drive->name);
+	if (!idefloppy_identify_device(drive, drive->id)) {
+		printk(KERN_ERR "ide-floppy: %s: not supported by this version"
+				" of ide-floppy\n", drive->name);
 		goto failed;
 	}
 	if (drive->scsi) {
-		printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", driv=
e->name);
+		printk(KERN_INFO "ide-floppy: passing drive %s to ide-scsi"
+				" emulation.\n", drive->name);
 		goto failed;
 	}
-	if ((floppy =3D kzalloc(sizeof (idefloppy_floppy_t), GFP_KERNEL)) =3D=
=3D NULL) {
-		printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\=
n", drive->name);
+	floppy =3D kzalloc(sizeof(idefloppy_floppy_t), GFP_KERNEL);
+	if (!floppy) {
+		printk(KERN_ERR "ide-floppy: %s: Can't allocate a floppy"
+				" structure\n", drive->name);
 		goto failed;
 	}
=20
@@ -1757,7 +1722,7 @@ static int ide_floppy_probe(ide_drive_t *drive)
=20
 	drive->driver_data =3D floppy;
=20
-	idefloppy_setup (drive, floppy);
+	idefloppy_setup(drive, floppy);
=20
 	g->minors =3D 1 << PARTN_BITS;
 	g->driverfs_dev =3D &drive->gendev;
@@ -1773,9 +1738,7 @@ failed:
 	return -ENODEV;
 }
=20
-MODULE_DESCRIPTION("ATAPI FLOPPY Driver");
-
-static void __exit idefloppy_exit (void)
+static void __exit idefloppy_exit(void)
 {
 	driver_unregister(&idefloppy_driver.gen_driver);
 }
@@ -1790,3 +1753,5 @@ MODULE_ALIAS("ide:*m-floppy*");
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ATAPI FLOPPY Driver");
+
--=20
1.5.3.7

--=20
Regards/Gru=DF,
    Boris.
