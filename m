From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 04/10] ide-tape: use standard data transfer mechanism
Date: Wed, 25 Mar 2009 16:12:11 +0100
Message-ID: <9ea470500903250812r19970910h12d197716d262c82@mail.gmail.com>
References: <1237990673-8358-1-git-send-email-tj@kernel.org>
	 <1237990673-8358-5-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761840AbZCYPM0@vger.kernel.org>
In-Reply-To: <1237990673-8358-5-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 25, 2009 at 3:17 PM, Tejun Heo <tj@kernel.org> wrote:
> Impact: use standard way to transfer data
>
> Now that data area is represented with bio, there is no need to use
> custom data transfer methods. =A0Drop idetape_io_buffers() and
> idetape_update_buffers(). =A0pc->bh is set to null to tell ide-atapi =
to
> use standard data transfer mechanism and idetape_bh byte counts are
> updated by the issuer on completion using the residual count.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> =A0drivers/ide/ide-tape.c | =A0 84 +++-------------------------------=
-------------
> =A01 files changed, 6 insertions(+), 78 deletions(-)
>
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index bd0e839..dd37fd7 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -292,65 +292,6 @@ static struct ide_tape_obj *ide_tape_chrdev_get(=
unsigned int i)
> =A0 =A0 =A0 =A0return tape;
> =A0}
>
> -static int idetape_input_buffers(ide_drive_t *drive, struct ide_atap=
i_pc *pc,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned int bcount)
> -{
> - =A0 =A0 =A0 struct idetape_bh *bh =3D pc->bh;
> - =A0 =A0 =A0 int count;
> -
> - =A0 =A0 =A0 if (bcount && bh) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D min(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int)(bh->b_si=
ze - atomic_read(&bh->b_count)),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcount);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 drive->hwif->tp_ops->input_data(drive, =
NULL, bh->b_data +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 atomic_read(&bh->b_count), count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcount -=3D count;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_add(count, &bh->b_count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_read(&bh->b_count) =3D=3D bh=
->b_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->bh =3D NULL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return bcount;
> -}
> -
> -static int idetape_output_buffers(ide_drive_t *drive, struct ide_ata=
pi_pc *pc,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned int bcount)
> -{
> - =A0 =A0 =A0 struct idetape_bh *bh =3D pc->bh;
> - =A0 =A0 =A0 int count;
> -
> - =A0 =A0 =A0 if (bcount && bh) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D min((unsigned int)pc->b_count=
, (unsigned int)bcount);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 drive->hwif->tp_ops->output_data(drive,=
 NULL, pc->b_data, count);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcount -=3D count;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->b_data +=3D count;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->b_count -=3D count;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pc->b_count)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->bh =3D NULL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return bcount;
> -}
> -
> -static void idetape_update_buffers(ide_drive_t *drive, struct ide_at=
api_pc *pc)
> -{
> - =A0 =A0 =A0 struct idetape_bh *bh =3D pc->bh;
> - =A0 =A0 =A0 unsigned int bcount =3D pc->xferred;
> -
> - =A0 =A0 =A0 if (pc->flags & PC_FLAG_WRITING)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 if (bcount) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bh =3D=3D NULL || bcount > bh->b_si=
ze) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ide-ta=
pe: bh =3D=3D NULL in %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&bh->b_count, bcount);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_read(&bh->b_count) =3D=3D bh=
->b_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->bh =3D NULL;
> - =A0 =A0 =A0 }
> -}
> -
> =A0/*
> =A0* called on each failed packet command retry to analyze the reques=
t sense. We
> =A0* currently do not utilize this information.
> @@ -368,12 +309,10 @@ static void idetape_analyze_error(ide_drive_t *=
drive, u8 *sense)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pc->c[0], tape->sense_key, tape->asc,=
 tape->ascq);
>
> =A0 =A0 =A0 =A0/* Correct pc->xferred by asking the tape. =A0 =A0 =A0=
 */
> - =A0 =A0 =A0 if (pc->flags & PC_FLAG_DMA_ERROR) {
> + =A0 =A0 =A0 if (pc->flags & PC_FLAG_DMA_ERROR)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pc->xferred =3D pc->req_xfer -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tape->blk_size *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_be32(&se=
nse[3]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 idetape_update_buffers(drive, pc);
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If error was the result of a zero-length read or wr=
ite command,
> @@ -520,19 +459,6 @@ static void ide_tape_handle_dsc(ide_drive_t *dri=
ve)
> =A0 =A0 =A0 =A0idetape_postpone_request(drive);
> =A0}
>
> -static int ide_tape_io_buffers(ide_drive_t *drive, struct ide_atapi_=
pc *pc,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int bcount, int write)
> -{
> - =A0 =A0 =A0 unsigned int bleft;
> -
> - =A0 =A0 =A0 if (write)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bleft =3D idetape_output_buffers(drive,=
 pc, bcount);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bleft =3D idetape_input_buffers(drive, =
pc, bcount);
> -
> - =A0 =A0 =A0 return bcount - bleft;
> -}
> -
> =A0/*
> =A0* Packet Command Interface
> =A0*
> @@ -685,7 +611,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t=
 *tape,
> =A0 =A0 =A0 =A0ide_init_pc(pc);
> =A0 =A0 =A0 =A0put_unaligned(cpu_to_be32(length), (unsigned int *) &p=
c->c[1]);
> =A0 =A0 =A0 =A0pc->c[1] =3D 1;
> - =A0 =A0 =A0 pc->bh =3D bh;
> + =A0 =A0 =A0 pc->bh =3D NULL;
> =A0 =A0 =A0 =A0pc->buf =3D NULL;
> =A0 =A0 =A0 =A0pc->buf_size =3D length * tape->blk_size;
> =A0 =A0 =A0 =A0pc->req_xfer =3D pc->buf_size;
> @@ -1083,7 +1009,11 @@ static int idetape_queue_rw_tail(ide_drive_t *=
drive, int cmd, int blocks,
>
> =A0 =A0 =A0 =A0blk_execute_rq(drive->queue, tape->disk, rq, 0);
>
> + =A0 =A0 =A0 /* calculate the number of transferred bytes and update=
 bh */
> =A0 =A0 =A0 =A0size -=3D rq->data_len;
> + =A0 =A0 =A0 if (cmd =3D=3D REQ_IDETAPE_READ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_add(size, &bh->b_count);
> +
> =A0 =A0 =A0 =A0ret =3D size;
> =A0 =A0 =A0 =A0if (rq->errors =3D=3D IDE_DRV_ERROR_GENERAL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EIO;
> @@ -2037,8 +1967,6 @@ static void idetape_setup(ide_drive_t *drive, i=
detape_tape_t *tape, int minor)
> =A0 =A0 =A0 =A0u16 *ctl =3D (u16 *)&tape->caps[12];
>
> =A0 =A0 =A0 =A0drive->pc_callback =A0 =A0 =A0 =3D ide_tape_callback;
> - =A0 =A0 =A0 drive->pc_update_buffers =3D idetape_update_buffers;
> - =A0 =A0 =A0 drive->pc_io_buffers =A0 =A0 =3D ide_tape_io_buffers;

You might just as well remove those two ide_drive_t members since
they're used only by ide-tape.

--=20
Regards/Gruss,
Boris
