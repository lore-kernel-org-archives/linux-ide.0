From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 04/24] ide-tape: remove pipeline-specific code from
	idetape_chrdev_write
Date: Sun, 2 Mar 2008 22:31:26 +0100
Message-ID: <20080302213126.GF4836@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-5-git-send-email-petkovbb@gmail.com> <200803021941.28401.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:64231 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087AbYCBVbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 16:31:39 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3135344nfb.21
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 13:31:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803021941.28401.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 02, 2008 at 07:41:28PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Saturday 01 March 2008, Borislav Petkov wrote:
> > Also, remove unused stage-parameter from idetape_copy_stage_from_us=
er()
>=20
> Changes like this one are the best to put into separate patches
> at the very beginning of the patch series.
>=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-tape.c |   15 ++++-----------
> >  1 files changed, 4 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index e919d41..4a064c1 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
> > @@ -1700,7 +1700,7 @@ static idetape_stage_t *idetape_kmalloc_stage=
(idetape_tape_t *tape)
> >  }
> > =20
> >  static int idetape_copy_stage_from_user(idetape_tape_t *tape,
> > -		idetape_stage_t *stage, const char __user *buf, int n)
> > +					const char __user *buf, int n)
> >  {
> >  	struct idetape_bh *bh =3D tape->bh;
> >  	int count;
> > @@ -2696,8 +2696,6 @@ static ssize_t idetape_chrdev_write(struct fi=
le *file, const char __user *buf,
> > =20
> >  	/* Initialize write operation */
> >  	if (tape->chrdev_dir !=3D IDETAPE_DIR_WRITE) {
> > -		if (tape->chrdev_dir =3D=3D IDETAPE_DIR_READ)
> > -			idetape_discard_read_pipeline(drive, 1);
>=20
> Why this is OK thing to do?
>=20
> Are you sure that there are no hidden side-effects?
>=20
> >  		if (tape->merge_stage || tape->merge_stage_size) {
> >  			printk(KERN_ERR "ide-tape: merge_stage_size "
> >  				"should be 0 now\n");
> > @@ -2729,8 +2727,6 @@ static ssize_t idetape_chrdev_write(struct fi=
le *file, const char __user *buf,
> >  	}
> >  	if (count =3D=3D 0)
> >  		return (0);
> > -	if (tape->restart_speed_control_req)
> > -		idetape_restart_speed_control(drive);
>=20
> ditto
>=20
> tape->restart_speed_control_req can still be non-zero.

Same as above: my main focus was ease of review and not keeping pipelin=
ing
functional at all times.

--=20
Regards/Gru=DF,
    Boris.
