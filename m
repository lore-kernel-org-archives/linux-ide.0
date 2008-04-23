From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 07/11] ide-tape: use blk_get_request in the
	ide_do_drive_cmd path
Date: Wed, 23 Apr 2008 09:31:36 +0200
Message-ID: <20080423073136.GA7482@gollum.tnic>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:22251 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYDWHbY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 03:31:24 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3625295fkr.5
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 00:31:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Tue, Apr 22, 2008 at 09:26:38AM +0900, FUJITA Tomonori wrote:
> This replaces struct request on the stack with blk_get_request in the
> ide_do_drive_cmd path that uses ide_wait.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   35 ++++++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 02851b3..04c611e 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -1910,13 +1910,15 @@ static void idetape_create_test_unit_ready_cm=
d(struct ide_atapi_pc *pc)
>  static int __idetape_queue_pc_tail(ide_drive_t *drive, struct ide_at=
api_pc *pc)
>  {
>  	struct ide_tape_obj *tape =3D drive->driver_data;
> -	struct request rq;
> +	struct request *rq;
>  	int ret;
> =20
> -	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
> -	rq.buffer =3D (char *) pc;
> -	rq.rq_disk =3D tape->disk;
> -	ret =3D ide_do_drive_cmd(drive, &rq, ide_wait);
> +	rq =3D blk_get_request(drive->queue, READ, __GFP_WAIT);
> +	rq->cmd_type =3D REQ_TYPE_SPECIAL;
> +	rq->cmd[0] =3D REQ_IDETAPE_PC1;
> +	rq->buffer =3D (char *)pc;
> +	rq->rq_disk =3D tape->disk;
> +	ret =3D ide_do_drive_cmd(drive, rq, ide_wait);
>  	return ret ? -EIO : 0;
> =20
>  }
> @@ -2130,7 +2132,8 @@ static int idetape_queue_rw_tail(ide_drive_t *d=
rive, int cmd, int blocks,
>  				 struct idetape_bh *bh)
>  {
>  	idetape_tape_t *tape =3D drive->driver_data;
> -	struct request rq;
> +	struct request *rq;
> +	int ret;
> =20
>  	debug_log(DBG_SENSE, "%s: cmd=3D%d\n", __func__, cmd);
> =20
> @@ -2140,22 +2143,24 @@ static int idetape_queue_rw_tail(ide_drive_t =
*drive, int cmd, int blocks,
>  		return (0);
>  	}
> =20
> -	idetape_init_rq(&rq, cmd);
> -	rq.rq_disk =3D tape->disk;
> -	rq.special =3D (void *)bh;
> -	rq.sector =3D tape->first_frame;
> -	rq.nr_sectors		=3D blocks;
> -	rq.current_nr_sectors	=3D blocks;
> -	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
> +	rq =3D blk_get_request(drive->queue, READ, __GFP_WAIT);
> +	rq->cmd_type =3D REQ_TYPE_SPECIAL;
> +	rq->cmd[0] =3D cmd;
> +	rq->rq_disk =3D tape->disk;
> +	rq->special =3D (void *)bh;
> +	rq->sector =3D tape->first_frame;
> +	rq->nr_sectors =3D blocks;
> +	rq->current_nr_sectors =3D blocks;
> +	ret =3D ide_do_drive_cmd(drive, rq, ide_wait);
> =20
>  	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) =3D=3D 0)
>  		return 0;
> =20
>  	if (tape->merge_stage)
>  		idetape_init_merge_stage(tape);
> -	if (rq.errors =3D=3D IDETAPE_ERROR_GENERAL)
> +	if (ret =3D=3D IDETAPE_ERROR_GENERAL)
>  		return -EIO;
> -	return (tape->blk_size * (blocks-rq.current_nr_sectors));
> +	return (tape->blk_size * (blocks-rq->current_nr_sectors));
>  }
> =20
>  /* start servicing the pipeline stages, starting from tape->next_sta=
ge. */

are you sure you're patching against the right ide tree? See, we remove=
d
pipelining (patches went in around the beginning of April) and the abov=
e comment
kinda says the opposite. Just to make sure, the latest quilt tree is at
http://www.kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/.

> --=20
> 1.5.4.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Regards/Gru=DF,
    Boris.
