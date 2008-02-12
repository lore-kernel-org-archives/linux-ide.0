From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-floppy: rename end_request handler properly
Date: Tue, 12 Feb 2008 15:36:35 +0100
Message-ID: <20080212143635.GA4530@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:46211 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761739AbYBLOhK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 09:37:10 -0500
Received: by ti-out-0910.google.com with SMTP id 28so427438tif.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 06:37:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

commit 48f9b88d491aa478ffcf21e2f523e3665db0770b
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Tue Feb 12 09:42:19 2008 +0100

    ide-floppy: rename end_request handler properly
   =20
    mv idefloppy_do_end_request -> idefloppy_end_request as is the case=
 with ide-cd
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 7e62dfc..bf1ef60 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -213,7 +213,7 @@ static void ide_floppy_put(struct ide_floppy_obj *f=
loppy)
  * Used to finish servicing a request. For read/write requests, we wil=
l call
  * ide_end_request to pass to the next buffer.
  */
-static int idefloppy_do_end_request(ide_drive_t *drive, int uptodate, =
int nsecs)
+static int idefloppy_end_request(ide_drive_t *drive, int uptodate, int=
 nsecs)
 {
 	idefloppy_floppy_t *floppy =3D drive->driver_data;
 	struct request *rq =3D HWGROUP(drive)->rq;
@@ -270,7 +270,7 @@ static void ide_floppy_io_buffers(ide_drive_t *driv=
e, struct ide_atapi_pc *pc,
 		done +=3D count;
 	}
=20
-	idefloppy_do_end_request(drive, 1, done >> 9);
+	idefloppy_end_request(drive, 1, done >> 9);
=20
 	if (bcount) {
 		printk(KERN_ERR "%s: leftover data in %s, bcount =3D=3D %d\n",
@@ -289,7 +289,7 @@ static void idefloppy_update_buffers(ide_drive_t *d=
rive,
 	struct bio *bio =3D rq->bio;
=20
 	while ((bio =3D rq->bio) !=3D NULL)
-		idefloppy_do_end_request(drive, 1, 0);
+		idefloppy_end_request(drive, 1, 0);
 }
=20
 /*
@@ -355,11 +355,11 @@ static void idefloppy_request_sense_callback(ide_=
drive_t *drive)
 					floppy->ascq);
=20
=20
-		idefloppy_do_end_request(drive, 1, 0);
+		idefloppy_end_request(drive, 1, 0);
 	} else {
 		printk(KERN_ERR "Error in REQUEST SENSE itself - Aborting"
 				" request!\n");
-		idefloppy_do_end_request(drive, 0, 0);
+		idefloppy_end_request(drive, 0, 0);
 	}
 }
=20
@@ -370,7 +370,7 @@ static void idefloppy_pc_callback(ide_drive_t *driv=
e)
=20
 	debug_log("Reached %s\n", __func__);
=20
-	idefloppy_do_end_request(drive, floppy->pc->error ? 0 : 1, 0);
+	idefloppy_end_request(drive, floppy->pc->error ? 0 : 1, 0);
 }
=20
 static void idefloppy_init_pc(struct ide_atapi_pc *pc)
@@ -715,7 +715,7 @@ static void idefloppy_rw_callback(ide_drive_t *driv=
e)
 {
 	debug_log("Reached %s\n", __func__);
=20
-	idefloppy_do_end_request(drive, 1, 0);
+	idefloppy_end_request(drive, 1, 0);
 	return;
 }
=20
@@ -863,7 +863,7 @@ static ide_startstop_t idefloppy_do_request(ide_dri=
ve_t *drive,
 		else
 			printk(KERN_ERR "ide-floppy: %s: I/O error\n",
 				drive->name);
-		idefloppy_do_end_request(drive, 0, 0);
+		idefloppy_end_request(drive, 0, 0);
 		return ide_stopped;
 	}
 	if (blk_fs_request(rq)) {
@@ -871,7 +871,7 @@ static ide_startstop_t idefloppy_do_request(ide_dri=
ve_t *drive,
 		    (rq->nr_sectors % floppy->bs_factor)) {
 			printk(KERN_ERR "%s: unsupported r/w request size\n",
 					drive->name);
-			idefloppy_do_end_request(drive, 0, 0);
+			idefloppy_end_request(drive, 0, 0);
 			return ide_stopped;
 		}
 		pc =3D idefloppy_next_pc_storage(drive);
@@ -884,7 +884,7 @@ static ide_startstop_t idefloppy_do_request(ide_dri=
ve_t *drive,
 	} else {
 		blk_dump_rq_flags(rq,
 			"ide-floppy: unsupported command in queue");
-		idefloppy_do_end_request(drive, 0, 0);
+		idefloppy_end_request(drive, 0, 0);
 		return ide_stopped;
 	}
=20
@@ -1359,7 +1359,7 @@ static ide_driver_t idefloppy_driver =3D {
 	.media			=3D ide_floppy,
 	.supports_dsc_overlap	=3D 0,
 	.do_request		=3D idefloppy_do_request,
-	.end_request		=3D idefloppy_do_end_request,
+	.end_request		=3D idefloppy_end_request,
 	.error			=3D __ide_error,
 	.abort			=3D __ide_abort,
 #ifdef CONFIG_IDE_PROC_FS
--=20
Regards/Gru=DF,
    Boris.
