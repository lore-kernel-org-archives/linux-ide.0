From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 14/40] ide-floppy: merge idefloppy_transfer_pc() and
	idefloppy_transfer_pc1()
Date: Wed, 21 May 2008 07:24:29 +0200
Message-ID: <20080521052429.GA2414@gollum.tnic>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <20080518185633.5636.61364.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:19825 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbYEUFYg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 01:24:36 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2596799fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 20 May 2008 22:24:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080518185633.5636.61364.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 18, 2008 at 08:56:33PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> * Check IDEFLOPPY_FLAG_ZIP_DRIVE flag in idefloppy_transfer_pc1()
>   and skip idefloppy_transfer_pc2()-phase if the flag is not set.
>=20
> * Always use idefloppy_transfer_pc1() in idefloppy_issue_pc()
>   and remove no longer needed idefloppy_transfer_pc().

=2E.. and also probably mv idefloppy_transfer_pc1() to something like
idefloppy_start_transfer_pc() and rename idefloppy_transfer_pc2() to so=
mething
more appropriate like e.g. idefloppy_do_transfer_pc() or similar and do=
 away
with those misleading names and probably even the comments are superflu=
ous then.

>=20
> There should be no functional changes caused by this patch.
>=20
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-floppy.c |   65 ++++++++++++------------------------=
-----------
>  1 file changed, 17 insertions(+), 48 deletions(-)
>=20
> Index: b/drivers/ide/ide-floppy.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -522,40 +522,6 @@ static ide_startstop_t idefloppy_pc_intr
>  }
> =20
>  /*
> - * This is the original routine that did the packet transfer.
> - * It fails at high speeds on the Iomega ZIP drive, so there's a slo=
wer version
> - * for that drive below. The algorithm is chosen based on drive type
> - */
> -static ide_startstop_t idefloppy_transfer_pc(ide_drive_t *drive)
> -{
> -	ide_hwif_t *hwif =3D drive->hwif;
> -	ide_startstop_t startstop;
> -	idefloppy_floppy_t *floppy =3D drive->driver_data;
> -	u8 ireason;
> -
> -	if (ide_wait_stat(&startstop, drive, DRQ_STAT, BUSY_STAT, WAIT_READ=
Y)) {
> -		printk(KERN_ERR "ide-floppy: Strange, packet command "
> -				"initiated yet DRQ isn't asserted\n");
> -		return startstop;
> -	}
> -	ireason =3D hwif->INB(hwif->io_ports.nsect_addr);
> -	if ((ireason & CD) =3D=3D 0 || (ireason & IO)) {
> -		printk(KERN_ERR "ide-floppy: (IO,CoD) !=3D (0,1) while "
> -				"issuing a packet command\n");
> -		return ide_do_reset(drive);
> -	}
> -
> -	/* Set the interrupt routine */
> -	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL=
);
> -
> -	/* Send the actual packet */
> -	hwif->output_data(drive, NULL, floppy->pc->c, 12);
> -
> -	return ide_started;
> -}
> -
> -
> -/*
>   * What we have here is a classic case of a top half / bottom half i=
nterrupt
>   * service routine. In interrupt mode, the device sends an interrupt=
 to signal
>   * that it is ready to receive a packet. However, we need to delay a=
bout 2-3
> @@ -580,6 +546,8 @@ static ide_startstop_t idefloppy_transfe
>  {
>  	ide_hwif_t *hwif =3D drive->hwif;
>  	idefloppy_floppy_t *floppy =3D drive->driver_data;
> +	ide_expiry_t *expiry;
> +	unsigned int timeout;
>  	ide_startstop_t startstop;
>  	u8 ireason;
> =20
> @@ -602,9 +570,20 @@ static ide_startstop_t idefloppy_transfe
>  	 * 40 and 50msec work well. idefloppy_pc_intr will not be actually
>  	 * used until after the packet is moved in about 50 msec.
>  	 */
> +	if (floppy->flags & IDEFLOPPY_FLAG_ZIP_DRIVE) {
> +		timeout =3D floppy->ticks;
> +		expiry =3D &idefloppy_transfer_pc2;
> +	} else {
> +		timeout =3D IDEFLOPPY_WAIT_CMD;
> +		expiry =3D NULL;
> +	}
> +
> +	ide_set_handler(drive, &idefloppy_pc_intr, timeout, expiry);
> +
> +	if ((floppy->flags & IDEFLOPPY_FLAG_ZIP_DRIVE) =3D=3D 0)
> +		/* Send the actual packet */
> +		hwif->output_data(drive, NULL, floppy->pc->c, 12);
> =20
> -	ide_set_handler(drive, &idefloppy_pc_intr, floppy->ticks,
> -			&idefloppy_transfer_pc2);
>  	return ide_started;
>  }
> =20
> @@ -629,7 +608,6 @@ static ide_startstop_t idefloppy_issue_p
>  {
>  	idefloppy_floppy_t *floppy =3D drive->driver_data;
>  	ide_hwif_t *hwif =3D drive->hwif;
> -	ide_handler_t *pkt_xfer_routine;
>  	u16 bcount;
>  	u8 dma;
> =20
> @@ -675,26 +653,17 @@ static ide_startstop_t idefloppy_issue_p
>  		hwif->dma_ops->dma_start(drive);
>  	}
> =20
> -	/* Can we transfer the packet when we get the interrupt or wait? */
> -	if (floppy->flags & IDEFLOPPY_FLAG_ZIP_DRIVE) {
> -		/* wait */
> -		pkt_xfer_routine =3D &idefloppy_transfer_pc1;
> -	} else {
> -		/* immediate */
> -		pkt_xfer_routine =3D &idefloppy_transfer_pc;
> -	}
> -
>  	if (floppy->flags & IDEFLOPPY_FLAG_DRQ_INTERRUPT) {
>  		/* Issue the packet command */
>  		ide_execute_command(drive, WIN_PACKETCMD,
> -				pkt_xfer_routine,
> +				&idefloppy_transfer_pc1,
>  				IDEFLOPPY_WAIT_CMD,
>  				NULL);
>  		return ide_started;
>  	} else {
>  		/* Issue the packet command */
>  		ide_execute_pkt_cmd(drive);
> -		return (*pkt_xfer_routine) (drive);
> +		return idefloppy_transfer_pc1(drive);
>  	}
>  }
> =20

--=20
Regards/Gru=DF,
    Boris.
