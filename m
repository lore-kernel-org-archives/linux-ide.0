From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Subject: Re: regression: 295f000 breaks suspend to disk
Date: Wed, 14 Jan 2009 18:44:25 +0100
Message-ID: <1231955065.3246.0.camel@odie.local>
References: <1231797615.2797.5.camel@odie.local>
	 <200901141816.47422.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761522AbZANRpD@vger.kernel.org>
In-Reply-To: <200901141816.47422.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

ons, 14 01 2009 kl. 18:16 +0100, skrev Bartlomiej Zolnierkiewicz:
> On Monday 12 January 2009, Simon Holm Th=C3=B8gersen wrote:
> > commit 295f000 ("ide: don't execute the next queued command from th=
e
> > hard-IRQ context (v2)") breaks suspend to disk for me. On
> > 'echo disk > /sys/power/state' the systems hangs, letting me switch
> > virtual consoles, but not responding to Alt+SysRq
>=20
> Thanks, please try the patch below (it fixes the problem for me):

And for me as well. Thanks!


Simon

>=20
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: fix suspend regression
>=20
> On Monday 12 January 2009, Simon Holm Th=C3=B8gersen wrote:
> > commit 295f000 ("ide: don't execute the next queued command from th=
e
> > hard-IRQ context (v2)") breaks suspend to disk for me. On
> > 'echo disk > /sys/power/state' the systems hangs, letting me switch
> > virtual consoles, but not responding to Alt+SysRq
>=20
> Restart the request queue early for REQ_TYPE_PM_RESUME requests
> (though there is only one resume request for the whole resume
> sequence it stays in the queue until is fully completed and now
> depends on kblockd for processing consequential resume states).
>=20
> Reported-and-bisected-by: Simon Holm Th=C3=B8gersen <odie@cs.aau.dk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-pm.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> Index: b/drivers/ide/ide-pm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-pm.c
> +++ b/drivers/ide/ide-pm.c
> @@ -186,12 +186,10 @@ void ide_complete_pm_request(ide_drive_t
>  	       blk_pm_suspend_request(rq) ? "suspend" : "resume");
>  #endif
>  	spin_lock_irqsave(q->queue_lock, flags);
> -	if (blk_pm_suspend_request(rq)) {
> +	if (blk_pm_suspend_request(rq))
>  		blk_stop_queue(q);
> -	} else {
> +	else
>  		drive->dev_flags &=3D ~IDE_DFLAG_BLOCKED;
> -		blk_start_queue(q);
> -	}
>  	spin_unlock_irqrestore(q->queue_lock, flags);
> =20
>  	drive->hwif->rq =3D NULL;
> @@ -219,6 +217,8 @@ void ide_check_pm_state(ide_drive_t *dri
>  		 * point.
>  		 */
>  		ide_hwif_t *hwif =3D drive->hwif;
> +		struct request_queue *q =3D drive->queue;
> +		unsigned long flags;
>  		int rc;
>  #ifdef DEBUG_PM
>  		printk("%s: Wakeup request inited, waiting for !BSY...\n", drive->=
name);
> @@ -231,5 +231,9 @@ void ide_check_pm_state(ide_drive_t *dri
>  		rc =3D ide_wait_not_busy(hwif, 100000);
>  		if (rc)
>  			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->nam=
e);
> +
> +		spin_lock_irqsave(q->queue_lock, flags);
> +		blk_start_queue(q);
> +		spin_unlock_irqrestore(q->queue_lock, flags);
>  	}
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
