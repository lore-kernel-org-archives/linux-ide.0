From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] libata-dev:  update timer for PIO polling - revised
Date: Sat, 21 Jan 2006 10:05:07 +0900
Message-ID: <43D188C3.1080600@gmail.com>
References: <43BA8AEE.8010608@bj-ig.de> <43BB3CBA.5010908@tw.ibm.com> <43BB9568.6010000@bj-ig.de> <43BDE6EB.9090106@tw.ibm.com> <43CD9130.4000600@pobox.com> <43D0F175.7010206@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.207]:20808 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932266AbWAUBFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2006 20:05:14 -0500
Received: by xproxy.gmail.com with SMTP id s14so389021wxc
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2006 17:05:13 -0800 (PST)
In-Reply-To: <43D0F175.7010206@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
>=20
> Revised per your advice to use the eh_timed_out() handler.
>=20
> Description:
>   In the bug reported by Ralf M=FCller:
> (http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D113629906809278&w=3D=
2)
>=20
> When the scsi command times out, the qc is completed by the time
> out handler. This might cause null pointer dereference if
> the qc is running in the PIO polling thread.
>=20
> Changes:
>   Add ata_scsi_timed_out() to libata-scsi.
>   If the qc times out when running in PIO mode, EH_RESET_TIMER is ret=
urned.
>   Otherwise, EH_NOT_HANDLED is returned and the eh_strategy_handler()
>   is triggered as before.
>=20
> (Will add ata_scsi_timed_out() to LLDs later if this is ok.)
>=20
> Patch against the libata-dev irq-pio branch=20
> (000080c3499cd5037e60c08a8053efb9e48aa9c0).
>=20
> For your review, thanks.
>=20
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>=20
> =3D=3D=3D=3D=3D
>=20
> --- irq-pio/include/linux/libata.h	2006-01-20 10:35:11.000000000 +080=
0
> +++ eh_timed_out/include/linux/libata.h	2006-01-20 10:48:29.000000000=
 +0800
> @@ -449,6 +449,7 @@ extern void ata_host_set_remove(struct a
>  extern int ata_scsi_detect(struct scsi_host_template *sht);
>  extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __u=
ser *arg);
>  extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(str=
uct scsi_cmnd *));
> +extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd=
 *);
>  extern int ata_scsi_error(struct Scsi_Host *host);
>  extern int ata_scsi_release(struct Scsi_Host *host);
>  extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_qu=
eued_cmd *qc);
> --- irq-pio/drivers/scsi/libata-scsi.c	2006-01-20 10:35:05.000000000 =
+0800
> +++ eh_timed_out/drivers/scsi/libata-scsi.c	2006-01-20 22:13:14.00000=
0000 +0800
> @@ -717,6 +717,59 @@ int ata_scsi_slave_config(struct scsi_de
>  }
> =20
>  /**
> + *	ata_scsi_timed_out - SCSI layer time out handler callback
> + *	@cmd: SCSI cmd on which time out occurred
> + *
> + *	Handles SCSI-layer-thrown time out events.
> + *
> + *	RETURNS:
> + *	EH_HANDLED if qc was completed
> + *	EH_RESET_TIMER for polling case
> + *	EH_NOT_HANDLED otherwise.
> + */
> +enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
> +{
> +	struct scsi_device *scsidev =3D cmd->device;
> +	struct ata_port *ap =3D (struct ata_port *) &scsidev->host->hostdat=
a[0];
> +	struct ata_host_set *host_set =3D ap->host_set;
> +	struct ata_queued_cmd *qc;
> +	unsigned long flags;
> +	int rc =3D EH_NOT_HANDLED;
> +
> +	DPRINTK("ENTER\n");
> +	spin_lock_irqsave(&host_set->lock, flags);
> +
> +	qc =3D ata_qc_from_tag(ap, ap->active_tag);
> +	if (!qc) {
> +		/* ata_poll_qc_complete() or ata_interrupt() win the race.
> +		 */
> +		printk(KERN_ERR "ata%u: timeout without qc\n", ap->id);
> +		rc =3D EH_HANDLED;
> +		goto out;
> +	}
> +
> +	/* check if we are handling the right qc */
> +	assert(qc->scsicmd =3D=3D cmd);
> +	assert(qc->flags & ATA_QCFLAG_ACTIVE);
> +
> +	if (qc->tf.flags & ATA_TFLAG_POLLING) {
> +		/* The PIO polling thread has its own timeout handling.
> +		 * It won't loop forever, even if it takes a long time.
> +		 * We can wait the PIO polling thread to finish its work.
> +		 * No need to stop the polling thread from the timeout handler.
> +		 * Just reset the timer here.
> +		 */
> +		printk(KERN_WARNING "ata%u: reset scsi timer for PIO polling\n", a=
p->id);
> +		cmd->retries =3D 0;
> +		rc =3D EH_RESET_TIMER;
> +	}
> +out:
> +	spin_unlock_irqrestore(&host_set->lock, flags);
> +	DPRINTK("EXIT rc %d\n", rc);
> +	return rc;
> +}
> +
> +/**
>   *	ata_scsi_error - SCSI layer error handler callback
>   *	@host: SCSI host on which error occurred
>   *
> --- irq-pio/drivers/scsi/libata-core.c	2006-01-20 10:35:05.000000000 =
+0800
> +++ eh_timed_out/drivers/scsi/libata-core.c	2006-01-20 10:48:44.00000=
0000 +0800
> @@ -5434,6 +5434,7 @@ EXPORT_SYMBOL_GPL(ata_port_disable);
>  EXPORT_SYMBOL_GPL(ata_ratelimit);
>  EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>  EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
> +EXPORT_SYMBOL_GPL(ata_scsi_timed_out);
>  EXPORT_SYMBOL_GPL(ata_scsi_error);
>  EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
>  EXPORT_SYMBOL_GPL(ata_scsi_release);
>=20

Albert, Jeff, can you please hold off this for a while?  I currently=20
have a lot of pending EH changes (reset, revalidation, reconfiguration,=
=20
etc...).  I'm in the process of splitting the changes and throwing out=20
unnecessary ones.

One of the changes is ata_flush_pio_task() which waits for the pio task=
s=20
to finish.  This function is called by error handler.  This achieves=20
about the same thing, but in sligthly different manner.

* Doesn't use eh_timed_out.  I think this callback interface is somewha=
t=20
weird and it's also slightly broken in that commands can be completed=20
before timer is re-added.  It's not fatal but the command will have to=20
wait until the next timeout.

* ata_flush_pio_task() uses a flag to tell pio tasks to exit early.  Al=
l=20
pio tasks have to do is check whether a flag is set before rescheduling=
=20
itself.

Sorry about asking to hold off after a lot is done.  I've been lazy wit=
h=20
mailing list for a week or so and am catching up now.

--=20
tejun
