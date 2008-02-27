From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 4/5] ide-cd: shorten lines longer than 80 columns
Date: Wed, 27 Feb 2008 23:15:32 +0100
Message-ID: <20080227221532.GB9545@gollum.tnic>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <1204136449-9490-5-git-send-email-petkovbb@gmail.com> <200802272218.50537.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:38161 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187AbYB0WPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:15:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1641908nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:15:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802272218.50537.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 27, 2008 at 10:18:50PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Wednesday 27 February 2008, Borislav Petkov wrote:
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>=20
> interdiff for the merged version
>=20
> diff -u b/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> --- b/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -433,13 +433,13 @@
>  			 * sector. If we got here the error is not correctable.
>  			 */
>  			ide_dump_status_no_sense(drive,
> -						"media error (bad sector)",
> -						stat);
> +						 "media error (bad sector)",
> +						 stat);
>  			do_end_request =3D 1;
>  		} else if (sense_key =3D=3D BLANK_CHECK) {
>  			/* disk appears blank ?? */
>  			ide_dump_status_no_sense(drive, "media error (blank)",
> -						stat);
> +						 stat);
>  			do_end_request =3D 1;
>  		} else if ((err & ~ABRT_ERR) !=3D 0) {
>  			/* go to the default handler for other errors */
> @@ -510,7 +510,7 @@
>  	default:
>  		if (!(rq->cmd_flags & REQ_QUIET))
>  			printk(KERN_INFO "ide-cd: cmd 0x%x timed out\n",
> -				rq->cmd[0]);
> +					 rq->cmd[0]);

why do you push the rq->cmd[0] thingy back here. Shouldn't it be aligne=
d
with the opening brace as the zillion others so far?

>  		wait =3D 0;
>  		break;
>  	}
> @@ -552,7 +552,7 @@
> =20
>  		/* packet command */
>  		ide_execute_command(drive, WIN_PACKETCMD, handler,
> -					ATAPI_WAIT_PC, cdrom_timer_expiry);
> +				    ATAPI_WAIT_PC, cdrom_timer_expiry);
>  		return ide_started;
>  	} else {
>  		unsigned long flags;
> @@ -809,7 +809,7 @@
>  	info->dma =3D 0;
>  	info->start_seek =3D jiffies;
>  	return cdrom_start_packet_command(drive, 0,
> -					cdrom_start_seek_continuation);
> +					  cdrom_start_seek_continuation);
>  }
> =20
>  /*
> @@ -819,8 +819,8 @@
>  static void restore_request(struct request *rq)
>  {
>  	if (rq->buffer !=3D bio_data(rq->bio)) {
> -		sector_t n =3D (rq->buffer - (char *) bio_data(rq->bio)) /
> -				SECTOR_SIZE;
> +		sector_t n =3D
> +			(rq->buffer - (char *)bio_data(rq->bio)) / SECTOR_SIZE;

i must say, lines like this one always look ugly, no matter the formatt=
ing
tricks.

>  		rq->buffer =3D bio_data(rq->bio);
>  		rq->nr_sectors +=3D n;
> @@ -1192,8 +1192,8 @@
>  	/* sg request */
>  	if (rq->bio) {
>  		int mask =3D drive->queue->dma_alignment;
> -		unsigned long addr =3D (unsigned long)
> -					page_address(bio_page(rq->bio));
> +		unsigned long addr =3D
> +			(unsigned long)page_address(bio_page(rq->bio));
> =20
>  		info->dma =3D drive->using_dma;
> =20
> @@ -1233,16 +1233,14 @@
>  					return ide_stopped;
>  				}
>  				printk(KERN_ERR "%s: DSC timeout\n",
> -					drive->name);
> +						drive->name);
>  			}
>  			info->cd_flags &=3D ~IDE_CD_FLAG_SEEKING;
>  		}
> -		if ((rq_data_dir(rq) =3D=3D READ) &&
> -			IDE_LARGE_SEEK(info->last_block,
> -					block,
> -					IDECD_SEEK_THRESHOLD) &&
> -			drive->dsc_overlap)
> -
> +		if (rq_data_dir(rq) =3D=3D READ &&
> +		    IDE_LARGE_SEEK(info->last_block, block,
> +				   IDECD_SEEK_THRESHOLD) &&
> +		    drive->dsc_overlap)
>  			action =3D cdrom_start_seek(drive, block);
>  		else
>  			action =3D cdrom_start_rw(drive, rq);
> @@ -1375,7 +1373,7 @@
>  		toc =3D kmalloc(sizeof(struct atapi_toc), GFP_KERNEL);
>  		if (toc =3D=3D NULL) {
>  			printk(KERN_ERR "%s: No cdrom TOC buffer!\n",
> -				drive->name);
> +					drive->name);
>  			return -ENOMEM;
>  		}
>  		info->toc =3D toc;
> @@ -1619,7 +1617,7 @@
>  	if (drive->media =3D=3D ide_optical) {
>  		cdi->mask &=3D ~(CDC_MO_DRIVE | CDC_RAM);
>  		printk(KERN_ERR "%s: ATAPI magneto-optical drive\n",
> -			drive->name);
> +				drive->name);
>  		return nslots;
>  	}
> =20
> @@ -2118,7 +2116,7 @@
>  	if (ignore !=3D NULL) {
>  		if (strstr(ignore, drive->name)) {
>  			printk(KERN_INFO "ide-cd: ignoring drive %s\n",
> -				drive->name);
> +					 drive->name);
>  			goto failed;
>  		}
>  	}
> @@ -2130,7 +2128,7 @@
>  	info =3D kzalloc(sizeof(struct cdrom_info), GFP_KERNEL);
>  	if (info =3D=3D NULL) {
>  		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n",
> -			drive->name);
> +				drive->name);
>  		goto failed;
>  	}
> =20

--=20
Regards/Gru=DF,
    Boris.
