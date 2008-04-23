From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 06/11] ide: make ide_do_drive_cmd return rq->errors
Date: Wed, 23 Apr 2008 09:32:22 +0200
Message-ID: <20080423073222.GB7482@gollum.tnic>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:55862 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYDWHcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 03:32:05 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2510400fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 00:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi,

On Tue, Apr 22, 2008 at 09:26:37AM +0900, FUJITA Tomonori wrote:
> ide_do_drive_cmd forges an error value (-EIO) instead of
> rq->errors. idetape_queue_rw_tail wants rq->errors so this patch make=
s
> ide_do_drive_cmd return rq->errors.
>=20
> For compatibility, this patch makes the users of ide_do_drive_cmd
> return -EIO instead of a return value of ide_do_drive_cmd
> (rq->errors).

i don't see the reason for it. In the end, the only error type that is =
being
handed to and fro is -EIO and nobody is interested in rq->errors. So, w=
hether
ide_do_drive_cmd or its callers return -EIO is kinda unimportant. In th=
e second
case, however, you have simply added more code (as per the diffstat bel=
ow) with
no apparent functionality. It would only make sense, IMHO, if you would
differentiate behaviour based on rq->errors...

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-cd_ioctl.c |    3 ++-
>  drivers/ide/ide-floppy.c   |    4 +++-
>  drivers/ide/ide-io.c       |    2 +-
>  drivers/ide/ide-tape.c     |    5 ++++-
>  drivers/ide/ide-taskfile.c |    7 +++++--
>  drivers/ide/ide.c          |    2 ++
>  6 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
> index 9c044da..57dda1f 100644
> --- a/drivers/ide/ide-cd_ioctl.c
> +++ b/drivers/ide/ide-cd_ioctl.c
> @@ -302,7 +302,8 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi=
)
>  	req.cmd_type =3D REQ_TYPE_SPECIAL;
>  	req.cmd_flags =3D REQ_QUIET;
>  	ret =3D ide_do_drive_cmd(drive, &req, ide_wait);
> -
> +	if (ret)
> +		ret =3D -EIO;
>  	/*
>  	 * A reset will unlock the door. If it was previously locked,
>  	 * lock it again.
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index d75b2aa..af6625a 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -886,13 +886,15 @@ static int idefloppy_queue_pc_tail(ide_drive_t =
*drive, struct ide_atapi_pc *pc)
>  {
>  	struct ide_floppy_obj *floppy =3D drive->driver_data;
>  	struct request *rq;
> +	int ret;
> =20
>  	rq =3D blk_get_request(drive->queue, READ, __GFP_WAIT);
>  	rq->buffer =3D (char *) pc;
>  	rq->cmd_type =3D REQ_TYPE_SPECIAL;
>  	rq->rq_disk =3D floppy->disk;
> =20
> -	return ide_do_drive_cmd(drive, rq, ide_wait);
> +	ret =3D ide_do_drive_cmd(drive, rq, ide_wait);
> +	return ret ? -EIO : 0;
>  }
> =20
>  /*
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index 31e5afa..ce09f70 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -1667,7 +1667,7 @@ int ide_do_drive_cmd (ide_drive_t *drive, struc=
t request *rq, ide_action_t actio
>  	if (must_wait) {
>  		wait_for_completion(&wait);
>  		if (rq->errors)
> -			err =3D -EIO;
> +			err =3D rq->errors;
> =20
>  		blk_put_request(rq);
>  	}
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index f43fd07..02851b3 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -1911,11 +1911,14 @@ static int __idetape_queue_pc_tail(ide_drive_=
t *drive, struct ide_atapi_pc *pc)
>  {
>  	struct ide_tape_obj *tape =3D drive->driver_data;
>  	struct request rq;
> +	int ret;
> =20
>  	idetape_init_rq(&rq, REQ_IDETAPE_PC1);
>  	rq.buffer =3D (char *) pc;
>  	rq.rq_disk =3D tape->disk;
> -	return ide_do_drive_cmd(drive, &rq, ide_wait);
> +	ret =3D ide_do_drive_cmd(drive, &rq, ide_wait);
> +	return ret ? -EIO : 0;
> +
>  }
> =20
>  static void idetape_create_load_unload_cmd(ide_drive_t *drive,
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> index fac7fad..6d433c4 100644
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -531,6 +531,7 @@ static ide_startstop_t pre_task_out_intr(ide_driv=
e_t *drive, struct request *rq)
>  int ide_raw_taskfile(ide_drive_t *drive, ide_task_t *task, u8 *buf, =
u16 nsect)
>  {
>  	struct request *rq;
> +	int ret;
> =20
>  	rq =3D blk_get_request(drive->queue, READ, __GFP_WAIT);
>  	rq->cmd_type =3D REQ_TYPE_ATA_TASKFILE;
> @@ -551,7 +552,8 @@ int ide_raw_taskfile(ide_drive_t *drive, ide_task=
_t *task, u8 *buf, u16 nsect)
>  	rq->special =3D task;
>  	task->rq =3D rq;
> =20
> -	return ide_do_drive_cmd(drive, rq, ide_wait);
> +	ret =3D ide_do_drive_cmd(drive, rq, ide_wait);
> +	return ret ? -EIO : 0;
>  }
> =20
>  EXPORT_SYMBOL(ide_raw_taskfile);
> @@ -782,7 +784,8 @@ int ide_cmd_ioctl (ide_drive_t *drive, unsigned i=
nt cmd, unsigned long arg)
>  		rq =3D blk_get_request(drive->queue, READ, __GFP_WAIT);
>  		rq->cmd_type =3D REQ_TYPE_ATA_TASKFILE;
> =20
> -		return ide_do_drive_cmd(drive, rq, ide_wait);
> +		err =3D ide_do_drive_cmd(drive, rq, ide_wait);
> +		return err ? -EIO : 0;
>  	}
> =20
>  	if (copy_from_user(args, (void __user *)arg, 4))
> diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
> index c5b33f5..8970054 100644
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -738,6 +738,8 @@ static int generic_ide_resume(struct device *dev)
>  	rqpm.pm_state =3D PM_EVENT_ON;
> =20
>  	err =3D ide_do_drive_cmd(drive, rq, ide_head_wait);
> +	if (err)
> +		err =3D -EIO;
> =20
>  	if (err =3D=3D 0 && dev->driver) {
>  		ide_driver_t *drv =3D to_ide_driver(dev->driver);
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
