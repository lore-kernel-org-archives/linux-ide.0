From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 2/4] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_write_request
Date: Wed, 12 Mar 2008 06:41:56 +0100
Message-ID: <20080312054156.GC4266@gollum.tnic>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-3-git-send-email-petkovbb@gmail.com> <200803110025.19650.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:12974 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbYCLFmD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 01:42:03 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2732116fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 22:42:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803110025.19650.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Mar 11, 2008 at 12:25:19AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 09 March 2008, Borislav Petkov wrote:
> > Refrain from adding more write requests to the pipeline and queue t=
hem
> > directly on the device's request queue instead. Prior to that flush=
 all
> > penging stages in the pipeline through idetape_wait_for_pipeline().
>=20
> I would prefer to keep the original code for now
> (it has some subtle differences).

Well, if you mean by this the while-loop below, the original code offlo=
ads
the pipeline gradually, stage-wise, until allocation succeeds, in contr=
ast to
idetape_wait_for_pipeline() which iterates over all pending stages and =
flushes
them all in one go.

At a certain in point in time, however, the driver might land at the un=
likely
state of still having some stages left in the pipeline while queueing a=
ll
incoming requests on the rq queue. Therefore, i'd prefer to make sure t=
he
pipeline is empty before queueing. What is more, it is flushed only onc=
e, if
ever, so idetape_wait_for_pipeline() simply returns in subsequent calls=
 and no
considerable performance penalties are imposed here.

> > The remaining pipeline stage allocation code is used for the next c=
urrent
> > pipeline stage (tape->merge_stage) and data buffer for an upcoming
> > request. The so allocated pipeline stage is rewired into the tape s=
truct
> > thru idetape_switch_buffers() and used during the next request for
> > copying user data into it (see e.g. idetape_chrdev_write()). In cas=
e the
> > allocation fails, the current request is still attempted prior to f=
ailing.
>=20
> Is this really needed now that we've removed pipeline operation for w=
rite
> requests?

I did this simply to keep behavior changes at minimum - after removing =
the
pipeline code completely this'll be simplified too.

> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>=20
> How's about this version?
>=20
> From: Borislav Petkov <petkovbb@googlemail.com>
> Subject: [PATCH 2/4] ide-tape: remove pipeline-specific code from ide=
tape_add_chrdev_write_request
>=20
> Refrain from adding more write requests to the pipeline and queue the=
m
> directly on the device's request queue instead.
>=20
> [bart: re-do for minimal behavior changes]
>=20
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   55 +-------------------------------------=
-----------
>  1 file changed, 2 insertions(+), 53 deletions(-)
>=20
> Index: b/drivers/ide/ide-tape.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -2202,28 +2202,16 @@ static void idetape_wait_first_stage(ide
>  	spin_unlock_irqrestore(&tape->lock, flags);
>  }
> =20
> -/*
> - * Try to add a character device originated write request to our pip=
eline. In
> - * case we don't succeed, we revert to non-pipelined operation mode =
for this
> - * request. In order to accomplish that, we
> - *
> - * 1. Try to allocate a new pipeline stage.
> - * 2. If we can't, wait for more and more requests to be serviced an=
d try again
> - * each time.
> - * 3. If we still can't allocate a stage, fallback to non-pipelined =
operation
> - * mode for this request.
> - */
> +/* Queue up a character device originated write request. */
>  static int idetape_add_chrdev_write_request(ide_drive_t *drive, int =
blocks)
>  {
>  	idetape_tape_t *tape =3D drive->driver_data;
> -	idetape_stage_t *new_stage;
>  	unsigned long flags;
> -	struct request *rq;
> =20
>  	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
> =20
>  	/* Attempt to allocate a new stage. Beware possible race conditions=
=2E */
> -	while ((new_stage =3D idetape_kmalloc_stage(tape)) =3D=3D NULL) {
> +	while (1) {
>  		spin_lock_irqsave(&tape->lock, flags);
>  		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
>  			idetape_wait_for_request(drive, tape->active_data_rq);
> @@ -2234,49 +2222,10 @@ static int idetape_add_chrdev_write_requ
>  			if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
>  					&tape->flags))
>  				continue;
> -			/*
> -			 * The machine is short on memory. Fallback to non-
> -			 * pipelined operation mode for this request.
> -			 */
>  			return idetape_queue_rw_tail(drive, REQ_IDETAPE_WRITE,
>  						blocks, tape->merge_stage->bh);
>  		}
>  	}
> -	rq =3D &new_stage->rq;
> -	idetape_init_rq(rq, REQ_IDETAPE_WRITE);
> -	/* Doesn't actually matter - We always assume sequential access */
> -	rq->sector =3D tape->first_frame;
> -	rq->current_nr_sectors =3D blocks;
> -	rq->nr_sectors =3D blocks;
> -
> -	idetape_switch_buffers(tape, new_stage);
> -	idetape_add_stage_tail(drive, new_stage);
> -	tape->pipeline_head++;
> -	idetape_calculate_speeds(drive);
> -
> -	/*
> -	 * Estimate whether the tape has stopped writing by checking if our
> -	 * write pipeline is currently empty. If we are not writing anymore=
,
> -	 * wait for the pipeline to be almost completely full (90%) before
> -	 * starting to service requests, so that we will be able to keep up=
 with
> -	 * the higher speeds of the tape.
> -	 */
> -	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> -		if (tape->nr_stages >=3D tape->max_stages * 9 / 10 ||
> -			tape->nr_stages >=3D tape->max_stages -
> -			tape->uncontrolled_pipeline_head_speed * 3 * 1024 /
> -			tape->blk_size) {
> -			tape->measure_insert_time =3D 1;
> -			tape->insert_time =3D jiffies;
> -			tape->insert_size =3D 0;
> -			tape->insert_speed =3D 0;
> -			idetape_plug_pipeline(drive);
> -		}
> -	}
> -	if (test_and_clear_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
> -		/* Return a deferred error */
> -		return -EIO;
> -	return blocks;
>  }
> =20
>  /*

--=20
Regards/Gru=DF,
    Boris.
