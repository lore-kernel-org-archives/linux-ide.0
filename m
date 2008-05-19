From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 04/40] ide-scsi: fix Interrupt Reason checking in
	idescsi_pc_intr()
Date: Mon, 19 May 2008 07:10:32 +0200
Message-ID: <20080519051032.GB31130@gollum.tnic>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <20080518185503.5636.98141.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:1532 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYESFKg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 01:10:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1656309fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 22:10:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080518185503.5636.98141.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 18, 2008 at 08:55:03PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> Set PC_FLAG_WRITING pc flag in idescsi_queue() (if needed)
> and then fix Interrupt Reason checking in idescsi_pc_intr().
>=20
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/scsi/ide-scsi.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> Index: b/drivers/scsi/ide-scsi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/scsi/ide-scsi.c
> +++ b/drivers/scsi/ide-scsi.c
> @@ -427,7 +427,15 @@ static ide_startstop_t idescsi_pc_intr (
>  		printk(KERN_ERR "ide-scsi: CoD !=3D 0 in idescsi_pc_intr\n");
>  		return ide_do_reset (drive);
>  	}
> -	if (ireason & IO) {
> +	if (((ireason & IO) =3D=3D IO) =3D=3D !!(pc->flags & PC_FLAG_WRITIN=
G)) {
> +		/* Hopefully, we will never get here */
> +		printk(KERN_ERR "%s: We wanted to %s, but the device wants us "
> +				"to %s!\n", drive->name,
> +				(ireason & IO) ? "Write" : "Read",
> +				(ireason & IO) ? "Read" : "Write");
> +		return ide_do_reset(drive);
> +	}
> +	if (!(pc->flags & PC_FLAG_WRITING)) {
>  		temp =3D pc->xferred + bcount;
>  		if (temp > pc->req_xfer) {
>  			if (temp > pc->buf_size) {
> @@ -436,7 +444,6 @@ static ide_startstop_t idescsi_pc_intr (
>  					"- discarding data\n");
>  				temp =3D pc->buf_size - pc->xferred;
>  				if (temp) {
> -					pc->flags &=3D ~PC_FLAG_WRITING;
>  					if (pc->sg)
>  						idescsi_input_buffers(drive, pc,
>  									temp);
> @@ -457,15 +464,11 @@ static ide_startstop_t idescsi_pc_intr (
>  			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more dat=
a than expected - allowing transfer\n");
>  #endif /* IDESCSI_DEBUG_LOG */
>  		}
> -	}
> -	if (ireason & IO) {
> -		pc->flags &=3D ~PC_FLAG_WRITING;
>  		if (pc->sg)
>  			idescsi_input_buffers(drive, pc, bcount);
>  		else
>  			hwif->input_data(drive, NULL, pc->cur_pos, bcount);
>  	} else {
> -		pc->flags |=3D PC_FLAG_WRITING;

Yeah, what was the driver doing turning on/off that flag in the irq han=
dler? Are
those pc's getting reused in ide-scsi... I guess this is one of the bug=
s you
were talking about :).

>  		if (pc->sg)
>  			idescsi_output_buffers(drive, pc, bcount);
>  		else
> @@ -777,6 +780,8 @@ static int idescsi_queue (struct scsi_cm
> =20
>  	memset (pc->c, 0, 12);
>  	pc->flags =3D 0;
> +	if (cmd->sc_data_direction =3D=3D DMA_TO_DEVICE)
> +		pc->flags |=3D PC_FLAG_WRITING;
>  	pc->rq =3D rq;
>  	memcpy (pc->c, cmd->cmnd, cmd->cmd_len);
>  	pc->buf =3D NULL;

--=20
Regards/Gru=DF,
    Boris.
