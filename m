From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/40] ide: generic ATAPI support
Date: Thu, 22 May 2008 09:43:54 +0200
Message-ID: <20080522074354.GB2414@gollum.tnic>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:6744 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758500AbYEVHn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2008 03:43:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2565859fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 22 May 2008 00:43:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 18, 2008 at 08:54:28PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
>=20
> This patch series unifies ATAPI support present in ide-{floppy,tape,s=
csi}
> device drivers and moves it out to the core IDE code (new ide-atapi.c=
 file).
>=20
> In the process many bugs were shaken out and ~300 LOC were removed.
>=20
> diffstat:
>=20
>  drivers/ide/Kconfig      |    6=20
>  drivers/ide/Makefile     |    1=20
>  drivers/ide/ide-atapi.c  |  296 ++++++++++++++++++++++
>  drivers/ide/ide-cd.c     |    5=20
>  drivers/ide/ide-floppy.c |  431 +++++++-------------------------
>  drivers/ide/ide-tape.c   |  630 ++++++++++++++----------------------=
-----------
>  drivers/scsi/ide-scsi.c  |  455 +++++++++++----------------------
>  include/linux/ide.h      |   28 +-
>  8 files changed, 777 insertions(+), 1075 deletions(-)
>=20
> Now, while this is a big step in the right direction there are still =
some
> things left on TODO for generic ATAPI support to be complete:
>=20
> - convert ide-cd to use generic ATAPI code
>=20
> - kill pc and rq stacks in ide-{floppy,tape}
>=20
> - generic handling of REQUEST SENSE command
>=20
> - generic handling of MODE SENSE command for ide-{floppy,tape}
>=20
> - convert ide-{cd,floppy,tape} to use scatterlists for PIO transers
>   (ala ide-scsi)
>=20
> I know that Borislav is working on the first two items but other ones
> are free at the moment so if you feel brave you may give it a try :-)=
=2E
>=20
> PS I'll be travelling during this weekend and be rather busy with day=
 job
>    so replies from me may be delayed a bit.

Hi Bart,

yep, these all look real good, makes all drivers really lightweight. Lo=
oks like
ide-cd will follow not too far behind. By the way, here's another one y=
ou count apply ontop:

=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Thu, 22 May 2008 09:36:53 +0200
Subject: [PATCH] ide-tape: unify idetape_create_read/write_cmd

A straightforward one. There should be no functional change resulting f=
rom this
change.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   47 ++++++++++++++++++++--------------------=
-------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0afa109..da08a6a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -952,40 +952,31 @@ static ide_startstop_t idetape_media_access_finis=
hed(ide_drive_t *drive)
 	return ide_stopped;
 }
=20
-static void idetape_create_read_cmd(idetape_tape_t *tape,
-		struct ide_atapi_pc *pc,
-		unsigned int length, struct idetape_bh *bh)
+static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
+		struct ide_atapi_pc *pc, unsigned int length,
+		struct idetape_bh *bh, int opcode)
 {
 	idetape_init_pc(pc);
-	pc->c[0] =3D READ_6;
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] =3D 1;
 	pc->bh =3D bh;
-	atomic_set(&bh->b_count, 0);
 	pc->buf =3D NULL;
 	pc->buf_size =3D length * tape->blk_size;
 	pc->req_xfer =3D pc->buf_size;
 	if (pc->req_xfer =3D=3D tape->buffer_size)
 		pc->flags |=3D PC_FLAG_DMA_OK;
-}
=20
-static void idetape_create_write_cmd(idetape_tape_t *tape,
-		struct ide_atapi_pc *pc,
-		unsigned int length, struct idetape_bh *bh)
-{
-	idetape_init_pc(pc);
-	pc->c[0] =3D WRITE_6;
-	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
-	pc->c[1] =3D 1;
-	pc->flags |=3D PC_FLAG_WRITING;
-	pc->bh =3D bh;
-	pc->b_data =3D bh->b_data;
-	pc->b_count =3D atomic_read(&bh->b_count);
-	pc->buf =3D NULL;
-	pc->buf_size =3D length * tape->blk_size;
-	pc->req_xfer =3D pc->buf_size;
-	if (pc->req_xfer =3D=3D tape->buffer_size)
-		pc->flags |=3D PC_FLAG_DMA_OK;
+	if (opcode =3D=3D READ_6) {
+		pc->c[0] =3D READ_6;
+		atomic_set(&bh->b_count, 0);
+	}
+	else if (opcode =3D=3D WRITE_6) {
+		pc->c[0] =3D WRITE_6;
+		pc->flags |=3D PC_FLAG_WRITING;
+		pc->b_data =3D bh->b_data;
+		pc->b_count =3D atomic_read(&bh->b_count);
+	} else
+		printk(KERN_ERR "%s: Invalid opcode: 0x%x\n", __func__, opcode);
 }
=20
 static ide_startstop_t idetape_do_request(ide_drive_t *drive,
@@ -1062,14 +1053,16 @@ static ide_startstop_t idetape_do_request(ide_d=
rive_t *drive,
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_READ) {
 		pc =3D idetape_next_pc_storage(drive);
-		idetape_create_read_cmd(tape, pc, rq->current_nr_sectors,
-					(struct idetape_bh *)rq->special);
+		ide_tape_create_rw_cmd(tape, pc, rq->current_nr_sectors,
+					(struct idetape_bh *)rq->special,
+					READ_6);
 		goto out;
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_WRITE) {
 		pc =3D idetape_next_pc_storage(drive);
-		idetape_create_write_cmd(tape, pc, rq->current_nr_sectors,
-					 (struct idetape_bh *)rq->special);
+		ide_tape_create_rw_cmd(tape, pc, rq->current_nr_sectors,
+					 (struct idetape_bh *)rq->special,
+					 WRITE_6);
 		goto out;
 	}
 	if (rq->cmd[0] & REQ_IDETAPE_PC1) {
--=20
1.5.5.1

--=20
Regards/Gru=DF,
    Boris.
