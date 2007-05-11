From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 16:37:41 +0200
Message-ID: <46447FB5.3040306@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com> <46441CA9.4030109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:10556 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbXEKOh4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 10:37:56 -0400
Received: by py-out-1112.google.com with SMTP id a29so804628pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 07:37:55 -0700 (PDT)
In-Reply-To: <46441CA9.4030109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Albert Lee wrote:
> -static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
> +static void ata_pio_sector(struct ata_queued_cmd *qc, int last, int lock)

I think the naming of @lock is a bit confusing here.  @clr_hsm_wq or
@last_sector, maybe?

> +		if (lock) {
> +			tail = 8;
> +			head = ATA_SECT_SIZE - tail; /* multiple of 8 bytes */
> +			ap->ops->data_xfer(qc->dev, buf + offset, head, do_write);
> +			spin_lock_irqsave(ap->lock, irq_flags);
> +		}
> +
> +		ap->ops->data_xfer(qc->dev, buf + offset + head, tail, do_write);

Aieee, we have to transfer the whole last sector while holding the spin
lock and IRQ disabled.  That's sad but pushing locking into ->data_xfer
doesn't sound attractive either.  Any better ideas?

> @@ -5119,6 +5187,10 @@ inline unsigned int ata_host_intr (struc
>  	VPRINTK("ata%u: protocol %d task_state %d\n",
>  		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
>  
> +	/* HSM accessing the port from the workqueue */
> +	if (ap->pflags & ATA_PFLAG_HSM_WQ)
> +		goto idle_irq;
> +

Please update LLDs with private IRQ handlers too.  Maybe we need
ata_idle_irq(ap) test?

Thanks.

-- 
tejun
