From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 12/15] ide-cd: convert to using generic sense request
Date: Sun, 19 Apr 2009 11:22:54 +0200
Message-ID: <20090419092254.GB2906@liondog.tnic>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-13-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43667 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZDSJW7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Apr 2009 05:22:59 -0400
Received: by fxm2 with SMTP id 2so1486949fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 19 Apr 2009 02:22:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1239960802-31978-13-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Hi,

On Fri, Apr 17, 2009 at 06:33:19PM +0900, Tejun Heo wrote:
> From: Borislav Petkov <petkovbb@googlemail.com>
>=20
> Preallocate a sense request in the ->do_request method and reinitiali=
ze
> it only on demand, in case it's been consumed in the IRQ handler path=
=2E
> The reason for this is that we don't want to be mapping rq to bio in
> the IRQ path and introduce all kinds of unnecessary hacks to the bloc=
k
> layer.
>=20
> tj: * Both user and kernel PC requests expect sense data to be stored
>       in separate storage other than drive->sense_data.  Copy sense
>       data to rq->sense on completion if rq->sense is not NULL.  This
>       fixes bogus sense data on PC requests.
>=20
> As a result, remove cdrom_queue_request_sense.
>=20
> CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ide/ide-cd.c |   54 +++++++++++-----------------------------=
---------
>  drivers/ide/ide-cd.h |    4 ---
>  2 files changed, 12 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index eb3c299..7b21c7e 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -206,44 +206,6 @@ static void cdrom_analyze_sense_data(ide_drive_t=
 *drive,
>  	ide_cd_log_error(drive->name, failed_command, sense);
>  }
> =20
> -static void cdrom_queue_request_sense(ide_drive_t *drive, void *sens=
e,
> -				      struct request *failed_command)
> -{
> -	struct cdrom_info *info		=3D drive->driver_data;
> -	struct request *rq		=3D &drive->request_sense_rq;
> -
> -	ide_debug_log(IDE_DBG_SENSE, "enter");
> -
> -	if (sense =3D=3D NULL)
> -		sense =3D &info->sense_data;
> -
> -	memset(sense, 0, 18);
> -
> -	/* stuff the sense request in front of our current request */
> -	blk_rq_init(NULL, rq);
> -	rq->cmd_type =3D REQ_TYPE_ATA_PC;
> -	rq->rq_disk =3D info->disk;
> -
> -	rq->data =3D sense;
> -	rq->cmd[0] =3D GPCMD_REQUEST_SENSE;
> -	rq->cmd[4] =3D 18;
> -	rq->data_len =3D 18;
> -
> -	rq->cmd_type =3D REQ_TYPE_SENSE;
> -	rq->cmd_flags |=3D REQ_PREEMPT;
> -
> -	/* NOTE! Save the failed command in "rq->special" */
> -	rq->special =3D (void *)failed_command;
> -
> -	if (failed_command)
> -		ide_debug_log(IDE_DBG_SENSE, "failed_cmd: 0x%x",
> -					     failed_command->cmd[0]);
> -
> -	drive->hwif->rq =3D NULL;
> -
> -	elv_add_request(drive->queue, rq, ELEVATOR_INSERT_FRONT, 0);
> -}
> -
>  static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct req=
uest *rq)
>  {
>  	/*
> @@ -251,11 +213,16 @@ static void ide_cd_complete_failed_rq(ide_drive=
_t *drive, struct request *rq)
>  	 * failed request
>  	 */
>  	struct request *failed =3D (struct request *)rq->special;
> -	struct cdrom_info *info =3D drive->driver_data;
> -	void *sense =3D &info->sense_data;
> +	struct request_sense *sense =3D &drive->sense_data;
> =20
>  	if (failed) {
>  		if (failed->sense) {
> +			/*
> +			 * Sense is always read into drive->sense_data.
> +			 * Copy back if the failed request has its
> +			 * sense pointer set.
> +			 */
> +			memcpy(failed->sense, sense, 18);

shouldn't this line be:

			memcpy(failed->sense, sense, rq->sense);

?

According to SFF8020i, Section 10.8.20 REQUEST SENSE Command, the sense
length can be > 18:

"ATAPI CD-ROM Drives shall be capable of returning at least 18 bytes of
data in response to a REQUEST SENSE command. (...)

Host Computers can determine how much sense data has been returned by
examining the allocation length parameter in the Command Packet and the
additional sense length in the sense data. ATAPI CD-ROM Drives shall
not adjust the additional sense length to re=EF=AC=82ect truncation if =
the
allocation length is less than the sense data available."

So, a possible scenario might be:

We issue a REQUEST_SENSE to a device and it returns more than 18 bytes
of sense data which should normally fit in the request_sense buffer but
we only copyback the first 18 bytes. Now, the error handling doesn't
touch any members behind the 18th byte (sense->asb) but we still subtly
carry stale data with us resulting in future bugs if one decides to
touch the additional sense bytes (->asb).

However, is there any reason for copying back the sense bytes at all?
In other words, does the block layer code need sense data when ending a
request or is it used only by LLDDs for error handling? Because if I'm
not missing something, we could just as well use the drive->sense_data
in the failed->sense case and thus alleviate the need for the copy.
ide_cd_complete_failed_rq is called on the IRQ path so drive->sense_dat=
a
has to be still valid for the current request is a sense request, no?

As a result and if I'm reading the code correctly, we could simply do
(pasting the whole function instead of a diff for more clarity) :

static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct reques=
t *rq)
{
        /*
         * For REQ_TYPE_SENSE, "rq->special" points to the original
         * failed request
         */
        struct request *failed =3D (struct request *)rq->special;
        struct request_sense *sense =3D &drive->sense_data;

        if (failed) {
                if (failed->sense)
                        /* Sense is always read into drive->sense_data.=
 */
                        failed->sense_len =3D rq->sense_len;

                cdrom_analyze_sense_data(drive, failed, sense);

                if (ide_end_rq(drive, failed, -EIO, blk_rq_bytes(failed=
)))
                        BUG();
        } else
                cdrom_analyze_sense_data(drive, NULL, sense);
}



>  			sense =3D failed->sense;
>  			failed->sense_len =3D rq->sense_len;
>  		}
> @@ -431,7 +398,7 @@ static int cdrom_decode_status(ide_drive_t *drive=
, u8 stat)
> =20
>  	/* if we got a CHECK_CONDITION status, queue a request sense comman=
d */
>  	if (stat & ATA_ERR)
> -		cdrom_queue_request_sense(drive, NULL, NULL);
> +		ide_queue_sense_rq(drive, NULL);
>  	return 1;
> =20
>  end_request:
> @@ -445,7 +412,7 @@ end_request:
> =20
>  		hwif->rq =3D NULL;
> =20
> -		cdrom_queue_request_sense(drive, rq->sense, rq);
> +		ide_queue_sense_rq(drive, rq);
>  		return 1;
>  	} else
>  		return 2;
> @@ -893,6 +860,9 @@ static ide_startstop_t ide_cd_do_request(ide_driv=
e_t *drive, struct request *rq,
>  		goto out_end;
>  	}
> =20
> +	/* prepare sense request for this command */
> +	ide_prep_sense(drive, rq);
> +
>  	memset(&cmd, 0, sizeof(cmd));
> =20
>  	if (rq_data_dir(rq))
> diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
> index 1d97101..93a3cf1 100644
> --- a/drivers/ide/ide-cd.h
> +++ b/drivers/ide/ide-cd.h
> @@ -87,10 +87,6 @@ struct cdrom_info {
> =20
>  	struct atapi_toc *toc;
> =20
> -	/* The result of the last successful request sense command
> -	   on this device. */
> -	struct request_sense sense_data;
> -
>  	u8 max_speed;		/* Max speed of the drive. */
>  	u8 current_speed;	/* Current speed of the drive. */
> =20
> --=20
> 1.6.0.2

--=20
Regards/Gruss,
    Boris.
