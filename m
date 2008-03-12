From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 4/4] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_read_request()
Date: Wed, 12 Mar 2008 06:58:03 +0100
Message-ID: <20080312055803.GD4266@gollum.tnic>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-5-git-send-email-petkovbb@gmail.com> <200803110025.51072.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:49281 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYCLF6J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 01:58:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2738138fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 22:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803110025.51072.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Mar 11, 2008 at 12:25:50AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 09 March 2008, Borislav Petkov wrote:
> > In order to do away with queueing read requests on the pipeline, se=
veral things
> > have to be done:
> >=20
> > 1. Do not allocate additional pipeline stages in idetape_init_read(=
) until
> > (tape->nr_stages < max_stages) and do only read operation preparati=
ons. As a
> > collateral result, idetape_add_stage_tail() becomes unused so remov=
e it.
> >=20
> > 2. Wait for all queued pipeline requests to complete before queuein=
g
>=20
> Hmm, but we've just removed all pipeline requests with this patch?

yep, this is me being overly cautious :).

> [ ->first_stage and ->next_stage are always NULL after this patch whi=
ch makes
>   it possible to remove the rest of (now never executed) code for pip=
eline
>   support, same for idetape_plug_pipeline() and IDETAPE_FLAG_PIPELINE=
* flags ]

this'll happen next.

> > the read request's buffer directly thru idetape_queue_rw_tail()
> >=20
> > 3. Do next request buffer allocation (tape->merge_stage)
>=20
> Isn't idetape_init_read() taking care of 3.?

i wanted to have the whole handling at one place and let _init_read() o=
nly
prepare the read. Now we don't allocate any new tape->merge_stage anymo=
re,
which is wrong. Originally, this happened in _init_read(), however, if =
we do
idetape_queue_rw_tail(), we should alloc the new stage _after_ queueing=
 the
request, which means it cannot happen _init_read() now and should take =
place
afterwards, i.e. as it was in the original patch, or?

> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>=20
> Seems like we can get away with:
>=20
> From: Borislav Petkov <petkovbb@googlemail.com>
> Subject: [PATCH 4/4] ide-tape: remove pipeline-specific code from ide=
tape_add_chrdev_read_request()
>=20
> In order to do away with queueing read requests on the pipeline, seve=
ral things
> have to be done:
>=20
> 1. Do not allocate additional pipeline stages in idetape_init_read() =
until
> (tape->nr_stages < max_stages) and do only read operation preparation=
s. As a
> collateral result, idetape_add_stage_tail() becomes unused so remove =
it.
>=20
> 2. Queue the read request's buffer directly thru idetape_queue_rw_tai=
l().
>=20
> 3. Remove now unused idetape_kmalloc_stage() and idetape_switch_buffe=
rs().
>=20
> [bart: simplify the original patch]
>=20
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   96 ++------------------------------------=
-----------
>  1 file changed, 5 insertions(+), 91 deletions(-)
>=20
> Index: b/drivers/ide/ide-tape.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -1586,15 +1586,6 @@ abort:
>  	return NULL;
>  }
> =20
> -static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
> -{
> -	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> -
> -	if (tape->nr_stages >=3D tape->max_stages)
> -		return NULL;
> -	return __idetape_kmalloc_stage(tape, 0, 0);
> -}
> -
>  static int idetape_copy_stage_from_user(idetape_tape_t *tape,
>  		idetape_stage_t *stage, const char __user *buf, int n)
>  {
> @@ -1672,39 +1663,6 @@ static void idetape_init_merge_stage(ide
>  	}
>  }
> =20
> -static void idetape_switch_buffers(idetape_tape_t *tape, idetape_sta=
ge_t *stage)
> -{
> -	struct idetape_bh *tmp;
> -
> -	tmp =3D stage->bh;
> -	stage->bh =3D tape->merge_stage->bh;
> -	tape->merge_stage->bh =3D tmp;
> -	idetape_init_merge_stage(tape);
> -}
> -
> -/* Add a new stage at the end of the pipeline. */
> -static void idetape_add_stage_tail(ide_drive_t *drive, idetape_stage=
_t *stage)
> -{
> -	idetape_tape_t *tape =3D drive->driver_data;
> -	unsigned long flags;
> -
> -	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> -
> -	spin_lock_irqsave(&tape->lock, flags);
> -	stage->next =3D NULL;
> -	if (tape->last_stage !=3D NULL)
> -		tape->last_stage->next =3D stage;
> -	else
> -		tape->first_stage =3D stage;
> -		tape->next_stage  =3D stage;
> -	tape->last_stage =3D stage;
> -	if (tape->next_stage =3D=3D NULL)
> -		tape->next_stage =3D tape->last_stage;
> -	tape->nr_stages++;
> -	tape->nr_pending_stages++;
> -	spin_unlock_irqrestore(&tape->lock, flags);
> -}
> -
>  /* Install a completion in a pending request and sleep until it is s=
erviced. The
>   * caller should ensure that the request will not be serviced before=
 we install
>   * the completion (usually by disabling interrupts).
> @@ -2228,10 +2186,7 @@ static void idetape_empty_write_pipeline
>  static int idetape_init_read(ide_drive_t *drive, int max_stages)
>  {
>  	idetape_tape_t *tape =3D drive->driver_data;
> -	idetape_stage_t *new_stage;
> -	struct request rq;
>  	int bytes_read;
> -	u16 blocks =3D *(u16 *)&tape->caps[12];
> =20
>  	/* Initialize read operation */
>  	if (tape->chrdev_dir !=3D IDETAPE_DIR_READ) {
> @@ -2267,21 +2222,7 @@ static int idetape_init_read(ide_drive_t
>  			}
>  		}
>  	}
> -	idetape_init_rq(&rq, REQ_IDETAPE_READ);
> -	rq.sector =3D tape->first_frame;
> -	rq.nr_sectors =3D blocks;
> -	rq.current_nr_sectors =3D blocks;
> -	if (!test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags) &&
> -	    tape->nr_stages < max_stages) {
> -		new_stage =3D idetape_kmalloc_stage(tape);
> -		while (new_stage !=3D NULL) {
> -			new_stage->rq =3D rq;
> -			idetape_add_stage_tail(drive, new_stage);
> -			if (tape->nr_stages >=3D max_stages)
> -				break;
> -			new_stage =3D idetape_kmalloc_stage(tape);
> -		}
> -	}
> +
>  	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
>  		if (tape->nr_pending_stages >=3D 3 * max_stages / 4) {
>  			tape->measure_insert_time =3D 1;
> @@ -2301,9 +2242,6 @@ static int idetape_init_read(ide_drive_t
>  static int idetape_add_chrdev_read_request(ide_drive_t *drive, int b=
locks)
>  {
>  	idetape_tape_t *tape =3D drive->driver_data;
> -	unsigned long flags;
> -	struct request *rq_ptr;
> -	int bytes_read;
> =20
>  	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
> =20
> @@ -2311,37 +2249,13 @@ static int idetape_add_chrdev_read_reque
>  	if (test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
>  		return 0;
> =20
> -	/* Wait for the next block to reach the head of the pipeline. */
>  	idetape_init_read(drive, tape->max_stages);
> -	if (tape->first_stage =3D=3D NULL) {
> -		if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
> -			return 0;
> -		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
> -					tape->merge_stage->bh);
> -	}
> -	idetape_wait_first_stage(drive);
> -	rq_ptr =3D &tape->first_stage->rq;
> -	bytes_read =3D tape->blk_size * (rq_ptr->nr_sectors -
> -					rq_ptr->current_nr_sectors);
> -	rq_ptr->nr_sectors =3D 0;
> -	rq_ptr->current_nr_sectors =3D 0;
> =20
> -	if (rq_ptr->errors =3D=3D IDETAPE_ERROR_EOD)
> +	if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
>  		return 0;
> -	else {
> -		idetape_switch_buffers(tape, tape->first_stage);
> -		if (rq_ptr->errors =3D=3D IDETAPE_ERROR_FILEMARK)
> -			set_bit(IDETAPE_FLAG_FILEMARK, &tape->flags);
> -		spin_lock_irqsave(&tape->lock, flags);
> -		idetape_remove_stage_head(drive);
> -		spin_unlock_irqrestore(&tape->lock, flags);
> -	}
> -	if (bytes_read > blocks * tape->blk_size) {
> -		printk(KERN_ERR "ide-tape: bug: trying to return more bytes"
> -				" than requested\n");
> -		bytes_read =3D blocks * tape->blk_size;
> -	}
> -	return (bytes_read);
> +
> +	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
> +				     tape->merge_stage->bh);
>  }
> =20
>  static void idetape_pad_zeros(ide_drive_t *drive, int bcount)

--=20
Regards/Gru=DF,
    Boris.
