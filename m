From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/24] ide-tape: remove pipeline-specific code from
	idetape_add_chrdev_write_request
Date: Mon, 3 Mar 2008 07:43:39 +0100
Message-ID: <20080303064339.GG4836@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <200803021933.06012.bzolnier@gmail.com> <20080302211953.GD4836@gollum.tnic> <200803030016.30122.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:29346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbYCCGnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 01:43:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1825117ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 22:43:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803030016.30122.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 03, 2008 at 12:16:29AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> On Sunday 02 March 2008, Borislav Petkov wrote:
> > On Sun, Mar 02, 2008 at 07:33:05PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Saturday 01 March 2008, Borislav Petkov wrote:
> > > > Instead of plugging the request into the pipeline, queue it str=
aight on the
> > > > device's request queue through idetape_queue_rw_tail().
> > > >=20
> > > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > > ---
> > > >  drivers/ide/ide-tape.c |   81 ++------------------------------=
---------------
> > > >  1 files changed, 4 insertions(+), 77 deletions(-)
> > > >=20
> > > > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > > > index 792c76e..abf3efa 100644
> > > > --- a/drivers/ide/ide-tape.c
> > > > +++ b/drivers/ide/ide-tape.c
> > > > @@ -2123,12 +2123,6 @@ static int idetape_queue_rw_tail(ide_dri=
ve_t *drive, int cmd, int blocks,
> > > > =20
> > > >  	debug_log(DBG_SENSE, "%s: cmd=3D%d\n", __func__, cmd);
> > > > =20
> > > > -	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> > > > -		printk(KERN_ERR "ide-tape: bug: the pipeline is active in %s=
\n",
> > > > -				__func__);
> > > > -		return (0);
> > > > -	}
> > > > -
> > > >  	idetape_init_rq(&rq, cmd);
> > > >  	rq.rq_disk =3D tape->disk;
> > > >  	rq.special =3D (void *)bh;
> > > > @@ -2140,10 +2134,9 @@ static int idetape_queue_rw_tail(ide_dri=
ve_t *drive, int cmd, int blocks,
> > > >  	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) =3D=3D 0)
> > > >  		return 0;
> > > > =20
> > > > -	if (tape->merge_stage)
> > > > -		idetape_init_merge_stage(tape);
> > > >  	if (rq.errors =3D=3D IDETAPE_ERROR_GENERAL)
> > > >  		return -EIO;
> > > > +
> > > >  	return (tape->blk_size * (blocks-rq.current_nr_sectors));
> > > >  }
> > >=20
> > > These two changes to idetape_queue_rw_tail() don't look correct
> > > as the pipeline mode is still used by read requests.
> >=20
> > Wrt first hunk read rq pipeline functionality is removed in the fol=
lowing
> > patch. Would it then be better to merge the two patches? Actually, =
do we need
>=20
> Merging patches together would cause increased complexity.
>=20
> The best solution would be to move this hunk to the patch which remov=
es
> IDETAPE_FLAG_PIPELINE_ACTIVE flag.
>=20
> > to keep the driver functional in between the patches of those serie=
s for
> > the purposes of git bisection or only compile-testing it is enough?=
 Cause
>=20
> We want to keep the driver functional in between the patches, especia=
lly
> given that it shouldn't be much more difficult to do so.
>=20
> > after applying the whole series you get pipelined mode ripped out a=
nyway and
> > intermittent states with partially functional pipeline are of no im=
portance, no?
>=20
> We always want fully bisectable patches:
>=20
> - if the patch series accidentaly completely breaks the code we want =
to be
>   able narrow it down to the guilty change
>=20
> - if the patch series causes some regressions (ie. worse performance)=
 we
>   also want to see which exact change caused it
>=20
> [ Nothing changes here and removal of pipeline functionality can't be=
 an
>   excuse for not sticking to the standard procedure. ]

Ok this changes the approach vector :). Will redo the patches from this=
 angle
and send them in small b(i|y)tes :) in order to review them easier/fast=
er.

Thanks.
--=20
Regards/Gru=DF,
    Boris.
