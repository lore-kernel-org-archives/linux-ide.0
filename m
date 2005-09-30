From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH/RFC 3/4] libata: interrupt driven pio for libata-core
Date: Fri, 30 Sep 2005 11:28:27 +0200
Message-ID: <58cb370e0509300228h7ab212ebg3916e89c637bed53@mail.gmail.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>
	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>
	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com>
	 <58cb370e05092903083e0d001c@mail.gmail.com> <433CF12D.900@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.197]:5599 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932556AbVI3J2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2005 05:28:31 -0400
Received: by nproxy.gmail.com with SMTP id x37so31255nfc
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2005 02:28:27 -0700 (PDT)
In-Reply-To: <433CF12D.900@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Hi,

On 9/30/05, Albert Lee <albertcc@tw.ibm.com> wrote:

> >>+/**
> >>  *     ata_host_intr - Handle host interrupt for given (port, task)
> >>  *     @ap: Port on which interrupt arrived (possibly...)
> >>  *     @qc: Taskfile currently active in engine
> >>@@ -3641,47 +3742,142 @@ void ata_bmdma_stop(struct ata_queued_cm
> >> inline unsigned int ata_host_intr (struct ata_port *ap,
> >>                                   struct ata_queued_cmd *qc)
> >> {
> >>
> >>
> >
> >We should check first if we are polling and if so we shouldn't touch hardware
> >et all as we can interface with ata_pio_task or atapi_packet_task.  Just think
> >about HSM_ST case when hardware is ready for the next transfer and IRQ
> >happens (from some other device).
> >
> >Please note that this bug is present in original libata code.
> >
> >
> >
> The (qc->tf.flags & ATA_TFLAG_POLLING) flag is checked in ata_interrupt().
> So, the race between the irq handler and ata_pio_task() is avoided.

You are right, I completely forgot about ata_interrupt(). :-)

> When the state is HSM_ST_FIRST,  ata_host_intr() checks the
> (qc->dev->flags & ATA_DFLAG_CDB_INTR) flag.
> Also in atapi_packet_task(), the host lock is aquired during the state
> transition from HSM_ST_FIRST to next state.
> So, the race between the irq handler and atapi_packet_task() is avoided.

What about ATAPI device with !dev->flags & ATA_DFLAG_CDB_INTR)?

Shouldn't we do spin_lock_irqsave() in atapi_packet_task() before
actually touching hardware?

> >>+fsm_start:
> >>+       switch (ap->hsm_task_state) {
> >>+       case HSM_ST_FIRST:
> >>+               /* Some pre-ATAPI-4 devices assert INTRQ
> >>+                * at this state when ready to receive CDB.
> >>+                */
> >>+
> >>+               /* check device status */
> >>+               if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
> >>+                       /* Wrong status. Let EH handle this */
> >>+                       ap->hsm_task_state = HSM_ST_ERR;
> >>+                       goto fsm_start;
> >>+               }
> >>+
> >>+               atapi_send_cdb(ap, qc);
> >>
> >>
> >
> >This case can happen also for ATA PIO out:
> >ata_qc_issue_prot() -> IRQ happens -> ata_host_intr().
> >
> >Sending CDB unconditionally is wrong.
> >
> >
> >
> >
> The (qc->dev->flags & ATA_DFLAG_CDB_INTR) flag is only turned on for
> atapi devices.
> So, when we are in the HSM_ST_FIRST state, ATA devices are filtered out
> and won't enter the irq handler.

Yep, you are right, so we can keep one state (HSM_ST_FIRST)
for ATA and ATAPI.

> Thanks for the review and advice, will revise and send follow up patch
> later.
> (Will also have look at the READ/WRITE MULTIPLE mentioned by Jeff.)

Thanks for working on this.
Bartlomiej
