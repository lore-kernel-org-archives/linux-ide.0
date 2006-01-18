From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] libata-dev: update timeout for PIO polling
Date: Tue, 17 Jan 2006 19:52:00 -0500
Message-ID: <43CD9130.4000600@pobox.com>
References: <43BA8AEE.8010608@bj-ig.de> <43BB3CBA.5010908@tw.ibm.com> <43BB9568.6010000@bj-ig.de> <43BDE6EB.9090106@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9649 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964923AbWARAwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 19:52:12 -0500
In-Reply-To: <43BDE6EB.9090106@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
>=20
> In the bug reported by Ralf M=FCller:
>   (http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D113629906809278&w=3D=
2)
>=20
>   When the command times out, the qc is completed by the time
> out handler. This might cause null pointer dereference if
> the command is running in the PIO polling thread.
>=20
> Changes:
> - Update the timeout for PIO polling to 5 minutes.
>   This should be long enough to prevent the timeout handler from
>   interfering with the PIO polling thread. =20
>=20
> Patch against the libata-dev irq-pio branch=20
> (61420e147a706ee7c7a902008045547fb2a2a330).
>=20
> For your review, thanks.
>=20
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> --- irq-pio/include/linux/libata.h	2006-01-05 15:16:32.000000000 +080=
0
> +++ update_tmout/include/linux/libata.h	2006-01-06 10:17:34.000000000=
 +0800
> @@ -141,6 +141,7 @@ enum {
>  	ATA_TMOUT_CDB_QUICK	=3D 5 * HZ,
>  	ATA_TMOUT_INTERNAL	=3D 30 * HZ,
>  	ATA_TMOUT_INTERNAL_QUICK =3D 5 * HZ,
> +	ATA_TMOUT_LONG		=3D 300 * HZ,	/* looks long enough */
> =20
>  	/* ATA bus states */
>  	BUS_UNKNOWN		=3D 0,
> --- irq-pio/drivers/scsi/libata-core.c	2006-01-05 15:16:29.000000000 =
+0800
> +++ update_tmout/drivers/scsi/libata-core.c	2006-01-06 10:41:23.00000=
0000 +0800
> @@ -3866,6 +3866,21 @@ int ata_qc_issue_prot(struct ata_queued_
>  		}
>  	}
> =20
> +	/* The PIO polling thread has its own timeout handling.
> +	 * It won't loop forever. Even if it takes a long time,
> +	 * we can wait the PIO polling thread to finish its work.
> +	 * No need to stop the polling thread from the timeout handler.
> +	 * So the timeout is updated to a long time here. This can prevent
> +	 * the timeout handler from interfering with the PIO polling thread=
=2E
> +	 */
> +	if (qc->tf.flags & ATA_TFLAG_POLLING &&
> +	    qc->scsicmd &&
> +	    qc->scsicmd->eh_timeout.function) {
> +		DPRINTK("ata%u: timer updated for PIO polling\n", ap->id);
> +		mod_timer(&qc->scsicmd->eh_timeout,
> +			  jiffies + ATA_TMOUT_LONG);
> +	}

While this may solve the problem, unfortunately we really don't want to=
=20
be directly touching the scsi EH timer.

A better method would be to implement ->eh_timed_out() SCSI host=20
template hook, which is the preferred way to accomplish what you are=20
attempting here.

	Jeff



