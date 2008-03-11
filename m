From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/4] ide-tape: remove tape->cache_stage
Date: Tue, 11 Mar 2008 07:40:10 +0100
Message-ID: <20080311064010.GA4266@gollum.tnic>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-2-git-send-email-petkovbb@gmail.com> <200803110024.51339.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:10681 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYCKGkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 02:40:18 -0400
Received: by ug-out-1314.google.com with SMTP id z38so5041448ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 23:40:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803110024.51339.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Mar 11, 2008 at 12:24:51AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 09 March 2008, Borislav Petkov wrote:
> > Prior to allocating a new pipeline stage, the code checked for the =
existence of
> > a cached pipeline stage to use. Do away with and stick to normal pi=
peline
> > stages only.
> >=20
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>=20
> I modified it slightly while merging since AFAICS we still need to ch=
eck
> 'tape->nr_stages >=3D tape_max_stages' for idetape_add_chrdev_write_r=
equest().

Yep, thanks for spotting that landmine. By the way this driver is full =
of it :).

> From: Borislav Petkov <petkovbb@googlemail.com>
> Subject: [PATCH 1/4] ide-tape: remove tape->cache_stage
>=20
> Prior to allocating a new pipeline stage, the code checked for the ex=
istence of
> a cached pipeline stage to use. Do away with and stick to normal pipe=
line
> stages only.
>=20
> [bart: keep idetape_kmalloc_stage() for now]
>=20
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> Index: b/drivers/ide/ide-tape.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -365,8 +365,6 @@ typedef struct ide_tape_obj {
>  	idetape_stage_t *next_stage;
>  	/* New requests will be added to the pipeline here */
>  	idetape_stage_t *last_stage;
> -	/* Optional free stage which we can use */
> -	idetape_stage_t *cache_stage;
>  	int pages_per_stage;
>  	/* Wasted space in each stage */
>  	int excess_bh_size;
> @@ -1686,16 +1684,10 @@ abort:
> =20
>  static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
>  {
> -	idetape_stage_t *cache_stage =3D tape->cache_stage;
> -
>  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> =20
>  	if (tape->nr_stages >=3D tape->max_stages)
>  		return NULL;
> -	if (cache_stage !=3D NULL) {
> -		tape->cache_stage =3D NULL;
> -		return cache_stage;
> -	}
>  	return __idetape_kmalloc_stage(tape, 0, 0);
>  }
> =20
> @@ -3245,10 +3237,7 @@ static int idetape_chrdev_release(struct
>  		else
>  			idetape_wait_for_pipeline(drive);
>  	}
> -	if (tape->cache_stage !=3D NULL) {
> -		__idetape_kfree_stage(tape->cache_stage);
> -		tape->cache_stage =3D NULL;
> -	}
> +
>  	if (minor < 128 && test_bit(IDETAPE_FLAG_MEDIUM_PRESENT, &tape->fla=
gs))
>  		(void) idetape_rewind_tape(drive);
>  	if (tape->chrdev_dir =3D=3D IDETAPE_DIR_NONE) {

--=20
Regards/Gru=DF,
    Boris.
