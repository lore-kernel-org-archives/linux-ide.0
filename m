From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/7] libata: move polling idle irq check to ata_host_intr()
Date: Fri, 11 May 2007 16:27:35 +0200
Message-ID: <46447D57.7040603@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com> <46441BED.9040108@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:11667 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbXEKO1s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 10:27:48 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1010965nzf
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 07:27:48 -0700 (PDT)
In-Reply-To: <46441BED.9040108@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Albert Lee wrote:
> patch 4/7:
> move the polling idle irq check from ata_interrupt() to ata_host_intr(),
> where it makes more sense.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> diff -Nrup 03_smart_flush/drivers/ata/libata-core.c 04_polling_check/drivers/ata/libata-core.c
> --- 03_smart_flush/drivers/ata/libata-core.c	2007-05-11 10:24:19.000000000 +0800
> +++ 04_polling_check/drivers/ata/libata-core.c	2007-05-11 10:25:09.000000000 +0800
> @@ -5119,6 +5119,10 @@ inline unsigned int ata_host_intr (struc
>  	VPRINTK("ata%u: protocol %d task_state %d\n",
>  		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
>  
> +	/* polling */
> +	if (qc->tf.flags & ATA_TFLAG_POLLING)
> +		goto idle_irq;
> +
>  	/* Check whether we are expecting interrupt in this state */
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> @@ -5229,8 +5233,7 @@ irqreturn_t ata_interrupt (int irq, void
>  			struct ata_queued_cmd *qc;
>  
>  			qc = ata_qc_from_tag(ap, ap->active_tag);
> -			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
> -			    (qc->flags & ATA_QCFLAG_ACTIVE))
> +			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE))

There are several LLD specific IRQ handlers which have similar part.
Care to update them together?

-- 
tejun
