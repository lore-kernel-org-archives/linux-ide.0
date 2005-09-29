From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH/RFC 3/4] libata: interrupt driven pio for libata-core
Date: Thu, 29 Sep 2005 12:08:40 +0200
Message-ID: <58cb370e05092903083e0d001c@mail.gmail.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>
	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>
	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:667 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbVI2KIm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Sep 2005 06:08:42 -0400
Received: by nproxy.gmail.com with SMTP id x37so604157nfc
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2005 03:08:40 -0700 (PDT)
In-Reply-To: <433912FB.9000606@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Hi,

On 9/27/05, Albert Lee <albertcc@tw.ibm.com> wrote:
> Patch 3/4: interrupt driven pio for libata-core
>
> Changes:
> - add PIO_ST_FIRST for the state before sending ATAPI CDB or sending

HSM_ST_FIRST

Could you add some brief comments about HSM_* states
(one line per state should be OK)?

> @@ -3344,43 +3356,96 @@ int ata_qc_issue_prot(struct ata_queued_
>  {
>         struct ata_port *ap = qc->ap;
>
> +       /* select the device */
>         ata_dev_select(ap, qc->dev->devno, 1, 0);
>
> +       /* start the command */
>         switch (qc->tf.protocol) {
>         case ATA_PROT_NODATA:
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       ata_qc_set_polling(qc);
> +
>                 ata_tf_to_host_nolock(ap, &qc->tf);
> +               ap->hsm_task_state = HSM_ST_LAST;
> +
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       queue_work(ata_wq, &ap->pio_task);
> +
>                 break;
>
>         case ATA_PROT_DMA:
> +               assert(!(qc->tf.flags & ATA_TFLAG_POLLING));
> +
>                 ap->ops->tf_load(ap, &qc->tf);   /* load tf registers */
>                 ap->ops->bmdma_setup(qc);           /* set up bmdma */
>                 ap->ops->bmdma_start(qc);           /* initiate bmdma */
> +               ap->hsm_task_state = HSM_ST_LAST;
>                 break;
>
> -       case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
> -               ata_qc_set_polling(qc);
> +       case ATA_PROT_PIO:
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       ata_qc_set_polling(qc);
> +
>                 ata_tf_to_host_nolock(ap, &qc->tf);
> -               ap->hsm_task_state = HSM_ST;
> -               queue_work(ata_wq, &ap->pio_task);
> +
> +               if (qc->tf.flags & ATA_TFLAG_POLLING) {
> +                       /* polling PIO */
> +                       ap->hsm_task_state = HSM_ST;
> +                       queue_work(ata_wq, &ap->pio_task);
> +               } else {
> +                       /* interrupt driven PIO */
> +                       if (qc->tf.flags & ATA_TFLAG_WRITE) {
> +                               /* PIO data out protocol */
> +                               ap->hsm_task_state = HSM_ST_FIRST;
> +                               queue_work(ata_wq, &ap->packet_task);

atapi_packet_task() is now abused to do ATA PIO out which is
very confusing given that name of the function (and all the comments)
remains unchanged.  Please correct it (I think it would be good idea to
separate HSM_ST_CDB from HSM_ST_FIRST).

>         case ATA_PROT_ATAPI:
> -               ata_qc_set_polling(qc);
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       ata_qc_set_polling(qc);
> +
>                 ata_tf_to_host_nolock(ap, &qc->tf);
> -               queue_work(ata_wq, &ap->packet_task);
> +               ap->hsm_task_state = HSM_ST_FIRST;
> +
> +               /* send cdb by polling if no cdb interrupt */
> +               if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
> +                   (qc->tf.flags & ATA_TFLAG_POLLING))
> +                       queue_work(ata_wq, &ap->packet_task);
>                 break;
>
>         case ATA_PROT_ATAPI_NODATA:
> -               ap->flags |= ATA_FLAG_NOINTR;
> +               if (qc->tf.flags & ATA_TFLAG_POLLING)
> +                       ata_qc_set_polling(qc);
> +
>                 ata_tf_to_host_nolock(ap, &qc->tf);
> -               queue_work(ata_wq, &ap->packet_task);
> +               ap->hsm_task_state = HSM_ST_FIRST;
> +
> +               /* send cdb by polling if no cdb interrupt */
> +               if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
> +                   (qc->tf.flags & ATA_TFLAG_POLLING))
> +                       queue_work(ata_wq, &ap->packet_task);
>                 break;

ATA_PROT_ATAPI_NODATA case is now identical
to ATA_PROT_ATAPI one - no need to duplicate code.

It may be also worth to split ata_qc_issue_prot() on IRQ
and polling versions because it is really hard to read now.

> +/**
>   *     ata_host_intr - Handle host interrupt for given (port, task)
>   *     @ap: Port on which interrupt arrived (possibly...)
>   *     @qc: Taskfile currently active in engine
> @@ -3641,47 +3742,142 @@ void ata_bmdma_stop(struct ata_queued_cm
>  inline unsigned int ata_host_intr (struct ata_port *ap,
>                                    struct ata_queued_cmd *qc)
>  {

We should check first if we are polling and if so we shouldn't touch hardware
et all as we can interface with ata_pio_task or atapi_packet_task.  Just think
about HSM_ST case when hardware is ready for the next transfer and IRQ
happens (from some other device).

Please note that this bug is present in original libata code.

> -       u8 status, host_stat;
> -
> -       switch (qc->tf.protocol) {
> +       u8 status, host_stat = 0;
>
> -       case ATA_PROT_DMA:
> -       case ATA_PROT_ATAPI_DMA:
> -       case ATA_PROT_ATAPI:

Your patch changes behavior for ATA_PROT_ATAPI case - now DMA
engine won't be checked.  We had discussion about fixing it before
but I don't remember what was the conclusion - in any case it is worth
to at least mention this change in the patch description.

> -               /* check status of DMA engine */
> -               host_stat = ap->ops->bmdma_status(ap);
> -               VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
> +       VPRINTK("ata%u: protocol %d task_state %d\n",
> +               ap->id, qc->tf.protocol, ap->hsm_task_state);
>
> -               /* if it's not our irq... */
> -               if (!(host_stat & ATA_DMA_INTR))
> +       /* Check whether we are expecting interrupt in this state */
> +       switch (ap->hsm_task_state) {
> +       case HSM_ST_FIRST:
> +               /* Check the ATA_DFLAG_CDB_INTR flag is enough here.
> +                * The flag was turned on only for atapi devices.
> +                * No need to check is_atapi_taskfile(&qc->tf) again.
> +                */
> +               if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
>                         goto idle_irq;
> +               break;
> +       case HSM_ST_LAST:
> +               if (qc->tf.protocol == ATA_PROT_DMA ||
> +                   qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
> +                       /* check status of DMA engine */
> +                       host_stat = ap->ops->bmdma_status(ap);
> +                       VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
> +
> +                       /* if it's not our irq... */
> +                       if (!(host_stat & ATA_DMA_INTR))
> +                               goto idle_irq;
>
> -               /* before we do anything else, clear DMA-Start bit */
> -               ap->ops->bmdma_stop(qc);
> +                       /* before we do anything else, clear DMA-Start bit */
> +                       ap->ops->bmdma_stop(qc);
> +               }
> +               break;
> +       case HSM_ST:
> +               break;
> +       default:
> +               goto idle_irq;
> +       }
>
> -               /* fall through */
> +       /* check altstatus */
> +       status = ata_altstatus(ap);
> +       if (status & ATA_BUSY)
> +               goto idle_irq;
>
> -       case ATA_PROT_ATAPI_NODATA:
> -       case ATA_PROT_NODATA:
> -               /* check altstatus */
> -               status = ata_altstatus(ap);
> -               if (status & ATA_BUSY)
> -                       goto idle_irq;
> +       /* check main status, clearing INTRQ */
> +       status = ata_chk_status(ap);
> +       if (unlikely(status & ATA_BUSY))
> +               goto idle_irq;
>
> -               /* check main status, clearing INTRQ */
> -               status = ata_chk_status(ap);
> -               if (unlikely(status & ATA_BUSY))
> -                       goto idle_irq;
> -               DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
> -                       ap->id, qc->tf.protocol, status);
> +       DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
> +               ap->id, qc->tf.protocol, ap->hsm_task_state, status);
>
> -               /* ack bmdma irq events */
> -               ap->ops->irq_clear(ap);
> +       /* ack bmdma irq events */
> +       ap->ops->irq_clear(ap);
> +
> +       /* check error */
> +       if (unlikely((status & ATA_ERR) || (host_stat & ATA_DMA_ERR)))
> +               ap->hsm_task_state = HSM_ST_ERR;
> +
> +fsm_start:
> +       switch (ap->hsm_task_state) {
> +       case HSM_ST_FIRST:
> +               /* Some pre-ATAPI-4 devices assert INTRQ
> +                * at this state when ready to receive CDB.
> +                */
> +
> +               /* check device status */
> +               if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
> +                       /* Wrong status. Let EH handle this */
> +                       ap->hsm_task_state = HSM_ST_ERR;
> +                       goto fsm_start;
> +               }
> +
> +               atapi_send_cdb(ap, qc);

This case can happen also for ATA PIO out:
ata_qc_issue_prot() -> IRQ happens -> ata_host_intr().

Sending CDB unconditionally is wrong.


The rest of the patch looks fine but it is was quite difficult to review
because you've combined two major logical changes into one patch:
* switching libata to use host state information
* adding support for IRQ driven PIO

Thanks,
Bartlomiej
