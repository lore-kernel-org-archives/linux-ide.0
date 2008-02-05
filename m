From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 07/22] ide-tape: struct idetape_tape_t: shorten member
	names v2
Date: Tue, 5 Feb 2008 05:47:07 +0100
Message-ID: <20080205044707.GA29807@gollum.tnic>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <1202132440-26648-8-git-send-email-petkovbb@gmail.com> <200802050223.21176.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:57330 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYBEErS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 23:47:18 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2257242mue.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 20:47:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802050223.21176.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Feb 05, 2008 at 02:23:21AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Monday 04 February 2008, Borislav Petkov wrote:
> > Shorten some member names not too aggressively since this driver mi=
ght be gone
> > anyway soon.
> >=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-tape.c |  210 ++++++++++++++++++++++++++----------=
------------
> >  1 files changed, 113 insertions(+), 97 deletions(-)
> >=20
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > index 126e8a9..0b5ccce 100644
> > --- a/drivers/ide/ide-tape.c
> > +++ b/drivers/ide/ide-tape.c
>=20
> [...]
>=20
> > @@ -1583,7 +1579,8 @@ static void idetape_create_read_cmd(idetape_t=
ape_t *tape, idetape_pc_t *pc, unsi
> >  	pc->bh =3D bh;
> >  	atomic_set(&bh->b_count, 0);
> >  	pc->buffer =3D NULL;
> > -	pc->request_transfer =3D pc->buffer_size =3D length * tape->tape_=
block_size;
> > +	pc->buffer_size		=3D length * tape->blk_size;
> > +	pc->request_transfer	=3D length * tape->blk_size;
> >  	if (pc->request_transfer =3D=3D tape->stage_size)
> >  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
> >  }
> > @@ -1621,7 +1618,8 @@ static void idetape_create_write_cmd(idetape_=
tape_t *tape, idetape_pc_t *pc, uns
> >  	pc->b_data =3D bh->b_data;
> >  	pc->b_count =3D atomic_read(&bh->b_count);
> >  	pc->buffer =3D NULL;
> > -	pc->request_transfer =3D pc->buffer_size =3D length * tape->tape_=
block_size;
> > +	pc->request_transfer	=3D length * tape->blk_size;
> > +	pc->buffer_size		=3D length * tape->blk_size;
> >  	if (pc->request_transfer =3D=3D tape->stage_size)
> >  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
> >  }
>=20
> for some reason gcc doesn't seem to optimize the new code as well as
> the old one (=3D> driver size goes up instead of staying unchanged)
>=20
> interdiff between original patch and merged version:
>=20
> diff -u b/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> --- b/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -324,7 +324,7 @@
>  	/* Current character device data transfer direction */
>  	u8 chrdev_dir;
> =20
> -	/* tape block size, usu. 512 or 1024 bytes */
> +	/* tape block size, usually 512 or 1024 bytes */
>  	unsigned short blk_size;
>  	int user_bs_factor;
> =20
> @@ -1580,8 +1580,8 @@
>  	pc->bh =3D bh;
>  	atomic_set(&bh->b_count, 0);
>  	pc->buffer =3D NULL;
> -	pc->buffer_size		=3D length * tape->blk_size;
> -	pc->request_transfer	=3D length * tape->blk_size;
> +	pc->buffer_size =3D length * tape->blk_size;
> +	pc->request_transfer =3D pc->buffer_size;
>  	if (pc->request_transfer =3D=3D tape->stage_size)
>  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
>  }
> @@ -1619,8 +1619,8 @@
>  	pc->b_data =3D bh->b_data;
>  	pc->b_count =3D atomic_read(&bh->b_count);
>  	pc->buffer =3D NULL;
> -	pc->request_transfer	=3D length * tape->blk_size;
> -	pc->buffer_size		=3D length * tape->blk_size;
> +	pc->buffer_size =3D length * tape->blk_size;
> +	pc->request_transfer =3D pc->buffer_size;
>  	if (pc->request_transfer =3D=3D tape->stage_size)
>  		set_bit(PC_DMA_RECOMMENDED, &pc->flags);
>  }

Yeah, i did that only because checkpatch.pl complained that multiple as=
signments
should be avoided. Now it looks kinda dumb that way besides improving r=
eadability
so converting it to the best form w.r.t generating smaller binary would=
 be a reason
good enough to ignore checkpatch.pl in that case.

--=20
Regards/Gru=DF,
    Boris.
