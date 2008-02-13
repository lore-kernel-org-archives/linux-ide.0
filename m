From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-floppy: merge callbacks
Date: Wed, 13 Feb 2008 21:57:34 +0100
Message-ID: <20080213205733.GC13446@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:47459 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYBMU6Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 15:58:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so856752ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 12:58:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

commit d1f1f84f413ab00cb2fec48170d022fcd900e214
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Wed Feb 13 20:26:56 2008 +0100

    ide-floppy: merge callbacks
   =20
    The appropriate functionality of the callback is established throug=
h querying
    the ATAPI packet command in pc->c[0].
   =20
    While at it, simplify if (floppy->failed_pc)-branch to be found in =
the original
    idefloppy_request_sense_callback().
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5f133df..1365310 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -313,50 +313,39 @@ static struct request *idefloppy_next_rq_storage(=
ide_drive_t *drive)
 	return (&floppy->rq_stack[floppy->rq_stack_index++]);
 }
=20
-static void idefloppy_request_sense_callback(ide_drive_t *drive)
+static void ide_floppy_callback(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
-	u8 *buf =3D floppy->pc->buf;
=20
 	debug_log("Reached %s\n", __func__);
=20
-	if (!floppy->pc->error) {
-		floppy->sense_key =3D buf[2] & 0x0F;
-		floppy->asc =3D buf[12];
-		floppy->ascq =3D buf[13];
-		floppy->progress_indication =3D buf[15] & 0x80 ?
-			(u16)get_unaligned((u16 *)&buf[16]) : 0x10000;
+	if (floppy->pc->c[0] =3D=3D GPCMD_REQUEST_SENSE) {
+		u8 *buf =3D floppy->pc->buf;
=20
-		if (floppy->failed_pc)
-			debug_log("pc =3D %x, sense key =3D %x, asc =3D %x,"
-					" ascq =3D %x\n",
-					floppy->failed_pc->c[0],
-					floppy->sense_key,
-					floppy->asc,
-					floppy->ascq);
-		else
-			debug_log("sense key =3D %x, asc =3D %x, ascq =3D %x\n",
-					floppy->sense_key,
-					floppy->asc,
-					floppy->ascq);
-
-
-		idefloppy_end_request(drive, 1, 0);
-	} else {
-		printk(KERN_ERR "Error in REQUEST SENSE itself - Aborting"
-				" request!\n");
-		idefloppy_end_request(drive, 0, 0);
-	}
-}
+		if (!floppy->pc->error) {
+			floppy->sense_key =3D buf[2] & 0x0F;
+			floppy->asc =3D buf[12];
+			floppy->ascq =3D buf[13];
+			floppy->progress_indication =3D buf[15] & 0x80 ?
+				(u16)get_unaligned((u16 *)&buf[16]) : 0x10000;
=20
-/* General packet command callback function. */
-static void idefloppy_pc_callback(ide_drive_t *drive)
-{
-	idefloppy_floppy_t *floppy =3D drive->driver_data;
+			if (floppy->failed_pc)
+				debug_log("pc =3D %x, ", floppy->failed_pc->c[0]);
=20
-	debug_log("Reached %s\n", __func__);
+			debug_log("sense key =3D %x, asc =3D %x, ascq =3D %x\n",
+				floppy->sense_key, floppy->asc,	floppy->ascq);
=20
-	idefloppy_end_request(drive, floppy->pc->error ? 0 : 1, 0);
+			idefloppy_end_request(drive, 1, 0);
+		} else {
+			printk(KERN_ERR "Error in REQUEST SENSE itself - "
+					"Aborting request!\n");
+			idefloppy_end_request(drive, 0, 0);
+		}
+	} else if (floppy->pc->c[0] =3D=3D GPCMD_READ_10 ||
+		floppy->pc->c[0] =3D=3D GPCMD_WRITE_10)
+		idefloppy_end_request(drive, 1, 0);
+	else
+		idefloppy_end_request(drive, floppy->pc->error ? 0 : 1, 0);
 }
=20
 static void idefloppy_init_pc(struct ide_atapi_pc *pc)
@@ -367,7 +356,7 @@ static void idefloppy_init_pc(struct ide_atapi_pc *=
pc)
 	pc->req_xfer =3D 0;
 	pc->buf =3D pc->pc_buf;
 	pc->buf_size =3D IDEFLOPPY_PC_BUFFER_SIZE;
-	pc->idefloppy_callback =3D &idefloppy_pc_callback;
+	pc->idefloppy_callback =3D &ide_floppy_callback;
 }
=20
 static void idefloppy_create_request_sense_cmd(struct ide_atapi_pc *pc=
)
@@ -376,7 +365,6 @@ static void idefloppy_create_request_sense_cmd(stru=
ct ide_atapi_pc *pc)
 	pc->c[0] =3D GPCMD_REQUEST_SENSE;
 	pc->c[4] =3D 255;
 	pc->req_xfer =3D 18;
-	pc->idefloppy_callback =3D &idefloppy_request_sense_callback;
 }
=20
 /*
@@ -697,14 +685,6 @@ static ide_startstop_t idefloppy_issue_pc(ide_driv=
e_t *drive,
 	}
 }
=20
-static void idefloppy_rw_callback(ide_drive_t *drive)
-{
-	debug_log("Reached %s\n", __func__);
-
-	idefloppy_end_request(drive, 1, 0);
-	return;
-}
-
 static void idefloppy_create_prevent_cmd(struct ide_atapi_pc *pc, int =
prevent)
 {
 	debug_log("creating prevent removal command, prevent =3D %d\n", preve=
nt);
@@ -799,7 +779,6 @@ static void idefloppy_create_rw_cmd(idefloppy_flopp=
y_t *floppy,
 	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&pc->c[7]);
 	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[2]);
=20
-	pc->idefloppy_callback =3D &idefloppy_rw_callback;
 	pc->rq =3D rq;
 	pc->b_count =3D cmd =3D=3D READ ? 0 : rq->bio->bi_size;
 	if (rq->cmd_flags & REQ_RW)
@@ -813,7 +792,6 @@ static void idefloppy_blockpc_cmd(idefloppy_floppy_=
t *floppy,
 		struct ide_atapi_pc *pc, struct request *rq)
 {
 	idefloppy_init_pc(pc);
-	pc->idefloppy_callback =3D &idefloppy_rw_callback;
 	memcpy(pc->c, rq->cmd, sizeof(pc->c));
 	pc->rq =3D rq;
 	pc->b_count =3D rq->data_len;


--=20
Regards/Gru=DF,
    Boris.
