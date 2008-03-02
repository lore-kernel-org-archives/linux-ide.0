From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 03/24] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_read_request
Date: Sun, 2 Mar 2008 22:28:35 +0100
Message-ID: <20080302212835.GE4836@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-4-git-send-email-petkovbb@gmail.com> <200803021936.12741.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:45890 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbYCBV2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 16:28:50 -0500
Received: by ik-out-1112.google.com with SMTP id c28so3509218ika.5
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 13:28:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803021936.12741.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 02, 2008 at 07:36:12PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Saturday 01 March 2008, Borislav Petkov wrote:
> > We fall back to non-pipelined operation through idetape_queue_rw_ta=
il with cmd
> > set to REQ_IDETAPE_READ. Also, remove idetape_switch_buffers() sinc=
e it becomes
> > unused.
> >=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-tape.c |   46 +-----------------------------------=
----------
> >  1 files changed, 1 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index abf3efa..e919d41 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -1776,16 +1776,6 @@ static void idetape_init_merge_stage(idetape=
_tape_t *tape)
> >  	}
> >  }
> > =20
> > -static void idetape_switch_buffers(idetape_tape_t *tape, idetape_s=
tage_t *stage)
> > -{
> > -	struct idetape_bh *tmp;
> > -
> > -	tmp =3D stage->bh;
> > -	stage->bh =3D tape->merge_stage->bh;
> > -	tape->merge_stage->bh =3D tmp;
> > -	idetape_init_merge_stage(tape);
> > -}
> > -
> >  /* Add a new stage at the end of the pipeline. */
> >  static void idetape_add_stage_tail(ide_drive_t *drive, idetape_sta=
ge_t *stage)
> >  {
> > @@ -2403,9 +2393,6 @@ static int idetape_init_read(ide_drive_t *dri=
ve, int max_stages)
> >  static int idetape_add_chrdev_read_request(ide_drive_t *drive, int=
 blocks)
> >  {
> >  	idetape_tape_t *tape =3D drive->driver_data;
> > -	unsigned long flags;
> > -	struct request *rq_ptr;
> > -	int bytes_read;
> > =20
> >  	debug_log(DBG_PROCS, "Enter %s, %d blocks\n", __func__, blocks);
> > =20
> > @@ -2413,39 +2400,8 @@ static int idetape_add_chrdev_read_request(i=
de_drive_t *drive, int blocks)
> >  	if (test_bit(IDETAPE_FLAG_FILEMARK, &tape->flags))
> >  		return 0;
> > =20
> > -	/* Wait for the next block to reach the head of the pipeline. */
> > -	idetape_init_read(drive, tape->max_stages);
>=20
> Can it be simply removed?  Why?

Bugger, actually this one _has_ to stay since it inits the tape->merge_=
stage
buffer.

> > -	if (tape->first_stage =3D=3D NULL) {
> > -		if (test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags))
> > -			return 0;
> > -		return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
> > +	return idetape_queue_rw_tail(drive, REQ_IDETAPE_READ, blocks,
> >  					tape->merge_stage->bh);
>=20
> Looking at the driver code tape->first_stage is not always NULL,
> seems like ide_tape_add_stage_tail() should vanish first?

At this moment there are no more stages in the pipeline besides only
tape->merge_stage. But this boils down to whether we want to keep the d=
river
functional in intermittent stages of the removal, as i pointed out befo=
re...

--=20
Regards/Gru=DF,
    Boris.
