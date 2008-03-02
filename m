From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/24] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_write_request
Date: Sun, 2 Mar 2008 22:19:53 +0100
Message-ID: <20080302211953.GD4836@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-3-git-send-email-petkovbb@gmail.com> <200803021933.06012.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:53394 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbYCBVUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 16:20:09 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2503559gve.37
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 13:20:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803021933.06012.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 02, 2008 at 07:33:05PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Saturday 01 March 2008, Borislav Petkov wrote:
> > Instead of plugging the request into the pipeline, queue it straigh=
t on the
> > device's request queue through idetape_queue_rw_tail().
> >=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-tape.c |   81 ++----------------------------------=
-----------
> >  1 files changed, 4 insertions(+), 77 deletions(-)
> >=20
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index 792c76e..abf3efa 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -2123,12 +2123,6 @@ static int idetape_queue_rw_tail(ide_drive_t=
 *drive, int cmd, int blocks,
> > =20
> >  	debug_log(DBG_SENSE, "%s: cmd=3D%d\n", __func__, cmd);
> > =20
> > -	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> > -		printk(KERN_ERR "ide-tape: bug: the pipeline is active in %s\n",
> > -				__func__);
> > -		return (0);
> > -	}
> > -
> >  	idetape_init_rq(&rq, cmd);
> >  	rq.rq_disk =3D tape->disk;
> >  	rq.special =3D (void *)bh;
> > @@ -2140,10 +2134,9 @@ static int idetape_queue_rw_tail(ide_drive_t=
 *drive, int cmd, int blocks,
> >  	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) =3D=3D 0)
> >  		return 0;
> > =20
> > -	if (tape->merge_stage)
> > -		idetape_init_merge_stage(tape);
> >  	if (rq.errors =3D=3D IDETAPE_ERROR_GENERAL)
> >  		return -EIO;
> > +
> >  	return (tape->blk_size * (blocks-rq.current_nr_sectors));
> >  }
>=20
> These two changes to idetape_queue_rw_tail() don't look correct
> as the pipeline mode is still used by read requests.

Wrt first hunk read rq pipeline functionality is removed in the followi=
ng
patch. Would it then be better to merge the two patches? Actually, do w=
e need
to keep the driver functional in between the patches of those series fo=
r
the purposes of git bisection or only compile-testing it is enough? Cau=
se
after applying the whole series you get pipelined mode ripped out anywa=
y and
intermittent states with partially functional pipeline are of no import=
ance, no?

Wrt the second one you're right, this one should stay in for now until
tape->merge_stage has been removed.

> > @@ -2210,81 +2203,15 @@ static void idetape_wait_first_stage(ide_dr=
ive_t *drive)
> >  	spin_unlock_irqrestore(&tape->lock, flags);
> >  }
> > =20
> > -/*
> > - * Try to add a character device originated write request to our p=
ipeline. In
> > - * case we don't succeed, we revert to non-pipelined operation mod=
e for this
> > - * request. In order to accomplish that, we
> > - *
> > - * 1. Try to allocate a new pipeline stage.
> > - * 2. If we can't, wait for more and more requests to be serviced =
and try again
> > - * each time.
> > - * 3. If we still can't allocate a stage, fallback to non-pipeline=
d operation
> > - * mode for this request.
> > - */
> > +/* Queue up a character device originated write request. */
> >  static int idetape_add_chrdev_write_request(ide_drive_t *drive, in=
t blocks)
> >  {
> >  	idetape_tape_t *tape =3D drive->driver_data;
> > -	idetape_stage_t *new_stage;
> > -	unsigned long flags;
> > -	struct request *rq;
> > =20
> >  	debug_log(DBG_CHRDEV, "Enter %s\n", __func__);
> > =20
> > -	/* Attempt to allocate a new stage. Beware possible race conditio=
ns. */
> > -	while ((new_stage =3D idetape_kmalloc_stage(tape)) =3D=3D NULL) {
> > -		spin_lock_irqsave(&tape->lock, flags);
> > -		if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> > -			idetape_wait_for_request(drive, tape->active_data_rq);
> > -			spin_unlock_irqrestore(&tape->lock, flags);
> > -		} else {
> > -			spin_unlock_irqrestore(&tape->lock, flags);
> > -			idetape_plug_pipeline(drive);
> > -			if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE,
> > -					&tape->flags))
> > -				continue;
>=20
> Can all the above code be safely removed (are you sure that there are=
 no
> hidden interactions)?  Even if so I would prefer that it is left inta=
ct by
> this patch to ease the review.

This code does exactly what the comment above explains: it tries to fre=
e
the pipeline for yet another request by plugging it with the already qu=
eued
ones and if it can't do so it simply queues the request in non-pipeline=
d
mode. What the patch does is remove the plugging and waiting. If we
leave this intact we'll be missing the point of the whole exercise.

--=20
Regards/Gru=DF,
    Boris.
